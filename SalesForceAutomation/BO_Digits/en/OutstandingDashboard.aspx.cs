using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Media;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Common.FormatProviders;
using Telerik.Windows.Documents.Flow.Model;
using Telerik.Windows.Documents.Flow.Model.Editing;
using Telerik.Windows.Documents.Flow.Model.Styles;
using Telerik.Windows.Documents.Spreadsheet.Model;
using Table = Telerik.Windows.Documents.Flow.Model.Table;
using TableCell = Telerik.Windows.Documents.Flow.Model.TableCell;
using TableRow = Telerik.Windows.Documents.Flow.Model.TableRow;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class OutstandingDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int OutStandingMode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["OutStandingMode"], out Mode);

                return Mode;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                string rotID;
                if (OutStandingMode == 1) // While loading page from ChartDashboard 
                {
                    if (Session["Route"] != null)
                    {
                        rotID = Session["Route"].ToString();
                        string[] ar = rotID.Split(',');
                        int k = 0;
                        foreach (RadComboBoxItem items in rdRoute.Items)
                        {
                            if (items.Value == ar[k])
                            {
                                items.Checked = true;
                                k++;
                            }

                        }

                    }
                    else
                    {
                        int i = 1;
                        foreach (RadComboBoxItem itmss in rdRoute.Items)
                        {
                            itmss.Checked = true;
                            i++;
                        }
                        rotID = Rot();
                    }
                }
                else                        // While loading page from RouteDashboard 
                {
                    if (Session["KPIRoute"] != null)
                    {
                        rotID = Session["KPIRoute"].ToString();
                        string[] ar = rotID.Split(',');
                        int k = 0;
                        foreach (RadComboBoxItem items in rdRoute.Items)
                        {
                            if (k < ar.Length && items.Value == ar[k])
                            {
                                items.Checked = true;
                                k++;
                            }

                        }

                    }
                    else
                    {
                        int i = 1;
                        foreach (RadComboBoxItem itmss in rdRoute.Items)
                        {
                            itmss.Checked = true;
                            i++;
                        }
                        rotID = Rot();
                    }
                }
              

                string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                Customers(routeCondition);
                ViewState["Chart"] = null;
                SelOutstanding();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
                // SelDues();


                //  ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            }
        }
        public void SelOutstandingInvCount()
        {
            string mainCondition = "";
            mainCondition = mainConditions();

            DataTable dt = ObjclsFrms.loadList("SelectOutstandingCountAndAmount", "sp_Report", mainCondition);

            string lblOutstandingCount = dt.Rows[0]["count"].ToString();

           // lblOutstanding.Text = lblOutstandingCount;
        }

        public string mainConditions()
        {

            string rotID;

            if (OutStandingMode == 1) // While loading page from ChartDashboard 
            {
                if (Session["Route"] != null)
                {
                    rotID = Session["Route"].ToString();
                }
                else
                {
                    rotID = Rot();
                }
            }
            else                     // While loading page from RouteDashboard 
            {
                if (Session["KPIRoute"] != null)
                {
                    rotID = Session["KPIRoute"].ToString();
                }
                else
                {
                    rotID = Rot();
                }
            }
               

            string rot = "";
            //    string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");

            string MainCondition = "";
            string RouteCondition = "";
            string CustomerCondition = "";
          
            if (rotID.Equals("rcs_rot_ID"))
            {
                rotID = "0";
            }
            else
            {
                RouteCondition = " A.rot_ID in ( " + rotID + " )";
            }
            string cusid = Cus();

            if (cusid.Equals("oid_cus_ID"))
            {
                CustomerCondition = "";
            }
            else
            {
                CustomerCondition = " and oid_cus_ID in ( " + cusid + " )";
            }

            MainCondition += RouteCondition;
            MainCondition += CustomerCondition;
           
            return MainCondition;
        }
        public DataTable LoadData(string mode)
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            if (mode== "SelCusOutstandingHeader")
            {
                if (ddlStatus.SelectedValue.ToString() == "D")
                {
                    mainCondition = mainCondition + " and cast(getdate() as date) <= cast(InvoicedOn + rcs_CreditDays as date)";
                }
                   else if (ddlStatus.SelectedValue.ToString() == "O")
                {
                    mainCondition = mainCondition + " and cast(getdate() as date) > cast(InvoicedOn + rcs_CreditDays as date)";
                                                        //cast(getdate() as date) > cast(InvoicedOn + rcs_CreditDays as date) 
                }


            }


            DataTable dt = ObjclsFrms.loadList(mode, "sp_Report", mainCondition);
            return dt;

        }
        public void SelOutstanding()
        {
            DataTable dt = LoadData("SelOutstandingCountSplit");
            DataTable dt1 = LoadData("SelOutstandingCount");
            DataTable dts = LoadData("SelOutstandingCountSplits");

            string count = dts.Rows[0]["totcount"].ToString();
            string amount = dts.Rows[0]["totamount"].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            lbltotcount.Text = count.ToString();
            lbltotamnt.Text= amount.ToString();
          
            lblDueAmount.Text = dts.Rows[0]["DueAmount"].ToString();
            lblDueCount.Text = dts.Rows[0]["DueCount"].ToString();
            lblOvrDueAmount.Text = dts.Rows[0]["OverDueAmount"].ToString();
            lblOvrDueCount.Text = dts.Rows[0]["OverDueCount"].ToString();
            string CuVisits = "ApplyOutstandingDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "'); ";
            ViewState["Chart"] += CuVisits;
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            SelOutstanding();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            LoadData("SelCusOutstandingHeader");
            grvRpt.Rebind();
        }
        public void Route()
        {
            string[] ar = { };
            rdRoute.DataSource = ObjclsFrms.loadList("selRoutesforOutstanding", "sp_Dashboard",UICommon.GetCurrentUserID().ToString(),ar);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public string Rot()
        {
            var CollectionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        rotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        rotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        rotID += item.Value;
                    }
                    j++;
                }
                return rotID;
            }
            else
            {
                return "rcs_rot_ID";
            }
        }
        public string Cus()
        {
            var CollectionMarket = rdCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "oid_cus_ID";
            }

        }
        public void Customers(string routeCondition)
        {

            rdCustomer.DataSource = ObjclsFrms.loadList("selCustomerforOutstanding", "sp_Dashboard", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }

        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("rcs_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
            Customers(routeCondition);
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt= LoadData("SelCusOutstandingHeader");
            grvRpt.DataSource = dt;
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }
        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {

            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName)
                    && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail")
                   && !column.HeaderText.Equals("Edit") && !column.HeaderText.Equals("Image")
                    )
                {


                    if (column.Display == true)
                    {
                        columncount++;
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }
                }
            }

            DataRow dr;
            grvRpt.MasterTableView.AllowPaging = false;

            RadGrid dd = grvRpt;
            dd.AllowPaging = false;
            dd.Rebind();
            int x = grvRpt.MasterTableView.Items.Count;
            foreach (GridDataItem item in dd.MasterTableView.Items)
            {
                dr = dt.NewRow();
                int j = 0;
                for (int i = 1; i < grvRpt.MasterTableView.Columns.Count; i++)
                {
                    if (grvRpt.MasterTableView.Columns[i].Display == true)
                    {


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail") &&
                            !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Edit"))
                        {
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                            {
                                if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;"))
                                {
                                    dr[j] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                                }
                                else
                                {
                                    dr[j] = " ";
                                }

                                j++;

                            }

                        }
                    }
                }
                dt.Rows.Add(dr);
            }
            SpreadStreamProcessingForXLSXAndCSV(dt);
        }
        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Sheet1")
        {
            using (MemoryStream stream = new MemoryStream())
            {
                using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
                {
                    using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
                    {
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                columnExporter.SetWidthInPixels(100);
                            }
                        }

                        ExportHeaderRows(worksheetExporter, dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat();
                                    normalFormat.FontSize = 10;

                                    normalFormat.VerticalAlignment = SpreadVerticalAlignment.Center;
                                    normalFormat.HorizontalAlignment = SpreadHorizontalAlignment.Center;
                                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                                    {

                                        cellExporter.SetValue(item.ToString());
                                        cellExporter.SetFormat(normalFormat);
                                    }
                                }

                            }
                        }

                    }
                }

                byte[] output = stream.ToArray();


                Response.ContentType = ContentType;
                Response.Headers.Remove("Content-Disposition");
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Outstanding Invoices", "Xlsx"));
                Response.BinaryWrite(output);
                Response.End();
            }
        }
        private void ExportHeaderRows(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;

                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat();
                format.IsBold = true;
                format.Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128));
                format.ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255));
                format.HorizontalAlignment = SpreadHorizontalAlignment.Center;
                format.VerticalAlignment = SpreadVerticalAlignment.Center;

                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                    {
                        cellExporter.SetFormat(format);
                        cellExporter.SetValue(dt.Columns[i].ColumnName);
                    }
                }
            }
        }
    }
}