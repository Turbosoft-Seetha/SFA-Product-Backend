using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListCustomerActivitys : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["mode"], out Mode);

                return Mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                if (Mode == 3 || Mode == 2 || Mode == 1)
                {
                    try
                    {

                        ViewState["fromdate"] = Session["FromDate"];
                        ViewState["todate"] = Session["ToDate"];
                        ViewState["route"] = Session["Route"];
                        string r = Session["Route"].ToString();
                        //string ed = Session["tDate"].ToString();

                        if (Session["FromDate"] != null)
                        {
                            rdFromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                        }
                        if (Session["ToDate"] != null)
                        {
                            rdEndDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                        }
                        Route();
                        RouteFromDashboard();

                    }
                    catch (Exception ex)
                    {
                        UICommon.LogException(ex, "List Customer Activitys");
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ListCustomerActivitys.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                    }
                }
                else // While loading page from transaction menu
                {
                    rdFromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    rdEndDate.SelectedDate = DateTime.Now;

                    Route();
                    int j = 1;
                    foreach (RadComboBoxItem itmss in rdRoute.Items)
                    {
                        itmss.Checked = true;
                        j++;
                    }
                }


                string rotID = Rot();
                string routeCondition = " rcs_rot_ID in (" + rotID + ")";

                Customers(routeCondition);
                CustomerFilter();
            }
        }

        public string mainConditions(string rotID)
        {
            string CusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " cah_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                //dateCondition = " and (isnull(cast(A.ModifiedDate as date),cast(A.CreatedDate as date)) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                dateCondition= " and (cast('" + fromDate + "' as date) Between Cast(cah_StartDate as date) and Cast(cah_EndDate as date) Or cast('" + endDate + "' as date) Between Cast(cah_StartDate as date) and Cast(cah_EndDate as date)) ";
              
                if (CusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and cah_cus_ID in (" + CusID + ")";
                }


            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            return mainCondition;
        }
        public void ListData()
        {

            DataTable lstUser = default(DataTable);
            if (Mode == 1)
            {
                string rotID = Rot();
                if (!rotID.Equals("0"))
                {
                    string mainCondition = "";
                    try
                    {
                        mainCondition = mainConditions(Session["Route"].ToString());
                        string type = Request.Params["type"].ToString();
                        if (type.Equals("CC"))
                        {
                            mainCondition += " and E.Status='Y'";
                        }
                        else if (type.Equals("OP"))
                        {
                            mainCondition += " and E.Status='N'";
                        }
                       
                    }
                    catch { }
                    lstUser = ObjclsFrms.loadList("SelectCustomerActivityfromDashboard", "sp_Merch_Dashboard", mainCondition);
                    grvRpt.DataSource = lstUser;
                }
            }
            else
            {
                string rotID = Rot();
                if (!rotID.Equals("0"))
                {
                    string mainCondition = "";                  
                    mainCondition = mainConditions(rotID);                                     
                    lstUser = ObjclsFrms.loadList("SelectCustomerActivity", "sp_Masters", mainCondition);
                    grvRpt.DataSource = lstUser;
                }
            }
        }
      
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cah_ID").ToString();
                Response.Redirect("ListCustomerActivityDetails.aspx?HID=" + ID);
            }
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
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
                        //if (i == 0)
                        //{
                        //    i++;


                        //}
                        //else
                        //{

                        //    dr[i] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                        //}


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
                                //make sure the width of the columns is not excessively large
                                //I reduced it to 100 in this iteration
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customer Activity", "Xlsx"));
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
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCustomerActivity.aspx?Id=0");
        }

        protected void lnkfilter_Click(object sender, EventArgs e)
        {
            ListData();
            grvRpt.Rebind();
        }
        public string Rot()
        {
            var ColelctionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
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
                return "0";
            }
        }
        public void Customers(string routeCondition)
        {
            DataTable dt = ObjclsFrms.loadList("SelectCustomerGeoLocDropdown", "sp_Masters", routeCondition);
            rdCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerGeoLocDropdown", "sp_Masters", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in rdCustomer.Items)
            {
                itme.Checked = true;
                k++;
            }
        }
        public string Cus()
        {
            var ColelctionMarkets = rdCustomer.CheckedItems;
            string cusID = "";
            int k = 0;
            int MarCounts = ColelctionMarkets.Count;
            if (ColelctionMarkets.Count > 0)
            {
                foreach (var item in ColelctionMarkets)
                {
                    //where 1 = 1 
                    if (k == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (k > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (k == (MarCounts - 1))
                    {
                        cusID += item.Value;
                    }
                    k++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }

        public void RouteFromDashboard()
        {
            try
            {


                if (Session["Route"] != null)
                {
                    string ids = Session["Route"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in rdRoute.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch { }
        }
        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
            Customers(routeCondition);
        }
    }
}