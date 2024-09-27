using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using System.Text;
using ClosedXML.Excel;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class TargetDashboardRouteDetails : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public string Mode
        {
            get
            {
                string Mode;
                Mode = (Request.Params["Mode"]);


                return Mode;
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
                if (Mode=="ROT")
                {
                    lnkViewProducts.Visible = false;
                    lblHeading.Text = "Packages Wise Target";
                    Heading();
                   

                }
                else
                {
                    lblHeading.Text = "Assigned Routes";
                    
                    lnkViewProducts.Visible= true;
                    Heading();
                }

                try
                {
                    rdMonth.SelectedDate = DateTime.Parse(Session["Date"].ToString());
                    Session["month"] = DateTime.Parse(Session["Date"].ToString());
                }
                catch
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                HeaderData();
                ViewState["Chart"] = null;
                Selqty();
                SelAmnt();
                Seltargetdays();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            }
        }
        public void LoadQuestion()
        {
            string tphID;
            if(Mode=="ROT")
            {
                tphID = ViewState["tph_ID"].ToString();
               
            }
            else
            {
                tphID = ResponseID.ToString();
            }

            //DataTable lstUsers = ObjclsFrms.loadList("SelectTargetPackageHeaderById", "sp_Target", tphID.ToString());
            //if (lstUsers.Rows.Count > 0)
            //{
            //    string target = lstUsers.Rows[0]["tph_Name"].ToString();
            //    prdHeading.Text = "Target Package : " + target;
            //}
            DataTable lstDatas = default(DataTable);
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { mnth.ToString(),ResponseID.ToString() };
            lstDatas = ObjclsFrms.loadList("SelPackageDetails", "sp_Dashboard", tphID.ToString(), arr);
            if (lstDatas.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                //Table start.
                sb.Append("<table cellpadding='8' cellspacing='0' style='border: 1px solid #ccc;font-size: 9pt;font-family:Arial;width:100%;overflow:scroll;'>");

                //Adding HeaderRow.
                sb.Append("<tr>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Route Code</th>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Product Code</th>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Product</th>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Category</th>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>SubCategory</th>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Brand</th>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Acheived Qty</th>");
                sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Acheived Amount</th>");
                sb.Append("</tr>");


                //Adding DataRow.
                for (int i = 0; i < lstDatas.Rows.Count; i++)
                {
                    string code,name,cat,subcat,brd,aqty,aamt,rot;
                    code = lstDatas.Rows[i]["prd_Code"].ToString();
                    name = lstDatas.Rows[i]["prd_Name"].ToString();
                    cat = lstDatas.Rows[i]["cat_Name"].ToString();
                    subcat = lstDatas.Rows[i]["sct_Name"].ToString();
                    brd = lstDatas.Rows[i]["brd_Name"].ToString();
                    aqty= lstDatas.Rows[i]["AchievedQty"].ToString();
                    aamt= lstDatas.Rows[i]["AchievedAmount"].ToString();
                    rot = lstDatas.Rows[i]["rot_Code"].ToString();
                    sb.Append("<tr>");
                    sb.AppendFormat("<td style='width:50px;border: 1px solid #ccc'>{0}</td>", rot.ToString());
                    sb.AppendFormat("<td style='width:50px;border: 1px solid #ccc'>{0}</td>", code.ToString());
                    sb.AppendFormat("<td style='width:300px;border: 1px solid #ccc'>{0}</td>", name.ToString());
                    sb.AppendFormat("<td style='width:100px;border: 1px solid #ccc'>{0}</td>", cat.ToString());
                    sb.AppendFormat("<td style='width:50px;border: 1px solid #ccc'>{0}</td>", subcat.ToString());
                    sb.AppendFormat("<td style='width:50px;border: 1px solid #ccc'>{0}</td>", brd.ToString());
                    sb.AppendFormat("<td style='width:50px;border: 1px solid #ccc'>{0}</td>", aqty.ToString());
                    sb.AppendFormat("<td style='width:100px;border: 1px solid #ccc'>{0}</td>", aamt.ToString());
                    sb.Append("</tr>");
                }

                //Table end.
                sb.Append("</table>");
                ltTable.Text = sb.ToString();
            }
        }
        public void Heading()
        {
            DataTable lstUsers = default(DataTable);
            if (Mode == "ROT")
            {


                lstUsers = ObjclsFrms.loadList("SelectRouteByID", "sp_Masters", ResponseID.ToString());
                if (lstUsers.Rows.Count > 0)
                {
                    string Rot = lstUsers.Rows[0]["rot_Name"].ToString();
                    lblPageHeading.Text = "Route : " + Rot;
                }
            }
            else
            {

                lstUsers = ObjclsFrms.loadList("SelectTargetPackageHeaderById", "sp_Target", ResponseID.ToString());
                if (lstUsers.Rows.Count > 0)
                {
                    string target = lstUsers.Rows[0]["tph_Name"].ToString();
                    lblPageHeading.Text = "Target Package : " + target;
                }
            }

        }
        public void HeaderData()
        {
            DataTable lstUser = default(DataTable);
           
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { ResponseID.ToString() };
            if(Mode=="PKG")
            {
                lstUser = ObjclsFrms.loadList("PackageWiseTargetPackageBYID", "sp_Dashboard", mnth, ar);

            }
            else
            {
                lstUser = ObjclsFrms.loadList("RouteWiseTargetPackageBYID", "sp_Dashboard", mnth, ar);

            }
            if (lstUser.Rows.Count > 0)
            {
                lblTotalQtyPerc.Text = lstUser.Rows[0]["QtyPerc"].ToString() + "%";
                lblTotalTargetQty.Text = lstUser.Rows[0]["TargetQty"].ToString();
                lblTotalAchievedQty.Text = lstUser.Rows[0]["AchievedQty"].ToString();
                lblTotalAchievedQtyPerc.Text = lstUser.Rows[0]["QtyPerc"].ToString() + "%";
                lblTotalGapQty.Text = lstUser.Rows[0]["RemQty"].ToString();
                lblTotalGapQtyPerc.Text = lstUser.Rows[0]["RemQtyPerc"].ToString() + "%";

                lblTotalAmountPerc.Text = lstUser.Rows[0]["AmountPerc"].ToString() + "%";
                lblTotalTargetAmt.Text = lstUser.Rows[0]["TargetAmount"].ToString();
                lblTotalAchievedAmt.Text = lstUser.Rows[0]["AchievedAmount"].ToString();
                lblTotalAchievedAmtPerc.Text = lstUser.Rows[0]["AmountPerc"].ToString() + "%";
                lblTotalGapAmt.Text = lstUser.Rows[0]["RemAmount"].ToString();
                lblTotalGapAmtPerc.Text = lstUser.Rows[0]["RemAmountPerc"].ToString() + "%";

                StringBuilder ltrlQtyPerc = new StringBuilder();
                string QtyPerc = lstUser.Rows[0]["QtyPerc"].ToString();


                ltrlQtyPerc.AppendFormat("<div class=\"rounded\" role=\"progressbar\" style=\"width:{0}%;background-color:#BD82CB;height:15px;\" aria-valuenow=\"50\" aria-valuemin=\"0\" aria-valuemax=\"100\">", QtyPerc);
                ltrlQtyPerc.Append("</div>");
                ltrQtyPerc.Text = ltrlQtyPerc.ToString();

                StringBuilder ltrlAmtPerc = new StringBuilder();
                string AmtPerc = lstUser.Rows[0]["AmountPerc"].ToString();


                ltrlAmtPerc.AppendFormat("<div class=\"rounded\" role=\"progressbar\" style=\"width:{0}%;background-color:#DC678F;height:15px;\" aria-valuenow=\"50\" aria-valuemin=\"0\" aria-valuemax=\"100\">", AmtPerc);
                ltrlAmtPerc.Append("</div>");
                ltrAmtPerc.Text = ltrlAmtPerc.ToString();
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            HeaderData();
            Selqty();
            SelAmnt();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            grvRpt.Rebind();
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { ResponseID.ToString() };
            if (Mode == "ROT")
            {               

                lstUser = ObjclsFrms.loadList("RouteWiseTargetPackageBYIDSummary", "sp_TargetDashboard", mnth, ar);
            }
            else if(Mode=="PKG")
            {
                lstUser = ObjclsFrms.loadList("PackageWiseTargetPackageBYIDSummary", "sp_Dashboard", mnth, ar);

            }
            grvRpt.DataSource = lstUser;


        }
        public void Seltargetdays()
        {
            DataTable dt = default(DataTable);
            string rot = "";
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { mnth };
            dt = ObjclsFrms.loadList("selTargetdays", "sp_Dashboard", ResponseID.ToString(), ar);
            lbltotwrkdays.Text= dt.Rows[0]["rmd_WorkingDays"].ToString();
            lblcmpltdwrkdays.Text = dt.Rows[0]["cmpltddays"].ToString();
        }
        public void Selqty()
        {
            DataTable dt = default(DataTable);
            string rot = "";
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { ResponseID.ToString() };
            dt = ObjclsFrms.loadList("TargetQuantitiesforchart", "sp_Dashboard", mnth, ar);
            int i = 0;
            int j = 0;
            string XAxis = "";
            string YAxis = "";
           if(dt.Rows.Count > 0)
            {
                foreach (DataColumn dc in dt.Columns)
                {
                    if (j < dt.Columns.Count - 1)
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
                    j++;



                }
                lblachvdqty.Text = dt.Rows[0]["MonthAchQty"].ToString();
                lblmtdgapqty.Text = dt.Rows[0]["MTDGapQty"].ToString();
                lblmonthgapqty.Text = dt.Rows[0]["MonthlyGapQty"].ToString();
                lbltargetqty.Text = dt.Rows[0]["TargetQty"].ToString();
            }
           
            
            string targetqty = "ApplytargetQtyChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += targetqty;
           // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + targetqty.ToString() + " </script>", false);
        }
        public void SelAmnt()
        {
            DataTable dt = default(DataTable);
            DataTable dt2 = default(DataTable);
            string rot = "";
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { ResponseID.ToString() };
            dt = ObjclsFrms.loadList("selTargetamountsforchart", "sp_Dashboard", mnth, ar);
            dt2 = ObjclsFrms.loadList("selTargetamounts", "sp_Dashboard", mnth, ar);
            int i = 0;
            int j = 0;
            string XAxis = "";
            string YAxis = "";
            if (dt.Rows.Count > 0)
            {
                foreach (DataColumn dc in dt.Columns)
                {
                    if (j < dt.Columns.Count - 1)
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
                    j++;
                }
                lblachvdamnt.Text = dt2.Rows[0]["MonthAchAmount"].ToString();
                lblmtdgapamnt.Text = dt2.Rows[0]["MTDGapAmt"].ToString();
                lblmonthlygapamnt.Text = dt2.Rows[0]["monthlygapamnt"].ToString();
                lbltargetamnt.Text = dt2.Rows[0]["TargetAmount"].ToString();
            }
            string targetamnt = "ApplytargetamntChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += targetamnt;
          //  ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + targetamnt.ToString() + " </script>", false);
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();

        }

        protected void reportdetail_Click(object sender, EventArgs e)
        {

        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            RadGrid radgrid2 = (RadGrid)sender;
            if (Mode == "PKG")
            {
                radgrid2.MasterTableView.GetColumn("tph_Number").Display = false;
                radgrid2.MasterTableView.GetColumn("tph_Name").Display = false;

                radgrid2.MasterTableView.GetColumn("Detail").Display = false;
                radgrid2.MasterTableView.GetColumn("rot_Code").Display = true;
                radgrid2.MasterTableView.GetColumn("rot_Name").Display = true;


            }
            else
            {
                radgrid2.MasterTableView.GetColumn("rot_Code").Display = false;
                radgrid2.MasterTableView.GetColumn("rot_Name").Display = false;
                radgrid2.MasterTableView.GetColumn("tph_Number").Display = true;
                radgrid2.MasterTableView.GetColumn("tph_Name").Display = true;

                radgrid2.MasterTableView.GetColumn("Detail").Display = true;


            }
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string PID = dataItem.GetDataKeyValue("ID").ToString();
                ViewState["tph_ID"] = PID;
               
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Question();</script>", false);
                LoadQuestion();
            }
        }

        protected void lnkViewProducts_Click(object sender, EventArgs e)
        {
           
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Question();</script>", false);
            LoadQuestion();

        }

        protected void Excel_Click(object sender, ImageClickEventArgs e)
        {
            string tphID;
            if (Mode == "ROT")
            {
                tphID = ViewState["tph_ID"].ToString();

            }
            else
            {
                tphID = ResponseID.ToString();
            }
            DataTable dt = new DataTable();

            DataTable lstDatas = default(DataTable);
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { mnth.ToString(),ResponseID.ToString() };
            lstDatas = ObjclsFrms.loadList("SelPackageDetails", "sp_Dashboard", tphID.ToString(), arr);

            // Add columns to DataTable
            dt.Columns.Add("Route Code", typeof(string));
            dt.Columns.Add("Product Code", typeof(string));
            dt.Columns.Add("Product", typeof(string));
            dt.Columns.Add("Category", typeof(string));
            dt.Columns.Add("SubCategory", typeof(string));
            dt.Columns.Add("Brand", typeof(string));
            dt.Columns.Add("Achieved Qty", typeof(string));
            dt.Columns.Add("Achieved Amount", typeof(string));

            // Add rows to DataTable
            foreach (DataRow row in lstDatas.Rows)
            {
                dt.Rows.Add(row["rot_Code"], row["prd_Code"], row["prd_Name"], row["cat_Name"], row["sct_Name"], row["brd_Name"], row["AchievedQty"], row["AchievedAmount"]);
            }

            // Export DataTable to Excel
            SpreadStreamProcessingForXLSXAndCSV(dt);
        }

        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt)
        {
            // Prepare the Response
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=Export.xlsx");

            // Create Excel file from DataTable
            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add(dt, "Sheet1");

                // Save the Excel file to the Response OutputStream
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
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