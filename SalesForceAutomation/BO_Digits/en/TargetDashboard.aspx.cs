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
using ProcessExcel;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class TargetDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int mode
        {
            get
            {
                int mode;
                int.TryParse(Request.Params["mode"], out mode);

                return mode;
            }
        }
        public string Mode
        {
            get
            {
                string Mode;
                if (Request.Params["Type"] == null)
                {
                    Mode = "";
                }
                else
                {
                    Mode = Request.Params["Type"].ToString();
                }


                return Mode;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
              

                try
                {
                    if (Mode.Equals("tdr"))
                    {
                        rdMonth.SelectedDate = DateTime.Parse(Session["month"].ToString());

                    }
                    else if (Mode.Equals("tdd"))
                    {

                        rdMonth.SelectedDate = DateTime.Parse(Session["monthDate"].ToString());
                    }
                    else
                    {
                        rdMonth.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                        Session["Date"] = rdMonth.SelectedDate.ToString();
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                Route();
                HeaderData();
                //Selpercentage();
                if (mode==1)
                {
                    try
                    {
                        if (Session["Route"] != null)
                        {
                            string route = Session["Route"].ToString();
                            string[] ar = route.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdRoute.Items)
                                {
                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                        }
                        else
                        {
                            RouteFromTransaction();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                }
                else
                {
                    RouteFromTransaction();
                }
               

            }
        }
        public void Route()
        {
            string[] arr = {};
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTargetDashboard", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in rdRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public void HeaderData()
        {
            DataTable lstUser = default(DataTable);
            string rot = rotFromGrid();
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { rot };
            lstUser = ObjclsFrms.loadList("TargetPackageHeadercounts", "sp_TargetDashboard", mnth, ar);
            if (lstUser.Rows.Count > 0)
            {
                lblTotalQtyPerc.Text = "0";
                lblTotalTargetQty.Text = lstUser.Rows[0]["TotalTargetQty"].ToString();
                lblTotalAchievedQty.Text = lstUser.Rows[0]["TotalMonthAchQty"].ToString();
                if(lblTotalTargetQty.Text.ToString()=="0")
                {
                    lblTotalAchievedQty.Text = "0";
                }
                
                lblTotalAchievedQtyPerc.Text = lstUser.Rows[0]["MonthAchQtyPer"].ToString() + "%";
                lblTotalGapQty.Text = lstUser.Rows[0]["TotalMonthlyGapQty"].ToString();
                lblTotalGapQtyPerc.Text = lstUser.Rows[0]["MonthlyGapQtyPer"].ToString() + "%";

                lblTotalAmountPerc.Text = "0";
                lblTotalTargetAmt.Text = lstUser.Rows[0]["TotalTargetAmount"].ToString();
                lblTotalAchievedAmt.Text = lstUser.Rows[0]["TotalMonthAchAmount"].ToString();
                lblTotalAchievedAmtPerc.Text = lstUser.Rows[0]["MonthAchAmountPer"].ToString() + "%";
                lblTotalGapAmt.Text = lstUser.Rows[0]["TotalMonthlyGapAmount"].ToString();
                lblTotalGapAmtPerc.Text = lstUser.Rows[0]["MonthlyGapAmountPer"].ToString() + "%";

                StringBuilder ltrlQtyPerc = new StringBuilder();
                string QtyPerc = lstUser.Rows[0]["QtyPerc"].ToString();
                
               
                ltrlQtyPerc.AppendFormat("<div class=\"rounded\" role=\"progressbar\" style=\"width:{0}%;background-color:#67D4DC;height:15px;\" aria-valuenow=\"50\" aria-valuemin=\"0\" aria-valuemax=\"100\">",QtyPerc);
                ltrlQtyPerc.Append("</div>");
                ltrQtyPerc.Text = ltrlQtyPerc.ToString();

                StringBuilder ltrlAmtPerc = new StringBuilder();
                string AmtPerc = lstUser.Rows[0]["AmountPerc"].ToString();


                ltrlAmtPerc.AppendFormat("<div class=\"rounded\" role=\"progressbar\" style=\"width:{0}%;background-color:#67A2DC;height:15px;\" aria-valuenow=\"50\" aria-valuemin=\"0\" aria-valuemax=\"100\">", AmtPerc);
                ltrlAmtPerc.Append("</div>");
                ltrAmtPerc.Text = ltrlAmtPerc.ToString();
            }
        }
        public void Selpercentage()
        {
            DataTable dt = default(DataTable);
            string rot = rotFromGrid();
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { rot };
            dt = ObjclsFrms.loadList("TargetQuantitiesforchart", "sp_Dashboard", mnth, ar);
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
            
            string targetqtyper = "ApplytargetQtyChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            //ViewState["Chart"] += targetqtyper;
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + targetqtyper.ToString() + " </script>", false);
        }

        public string rotFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = rdRoute.CheckedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            createNode(item.Value, writer);
                            c++;

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string rotID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            Session["Date"] = rdMonth.SelectedDate.ToString();
            HeaderData();
            grvRptRouteWise.Rebind();
            grvRptPackageWise.Rebind();
           
        }

       

        protected void Imgexcel_Click(object sender, ImageClickEventArgs e)
        {

            DataSet ds = new DataSet();
            DataTable dt1 = new DataTable("TT1");
            DataTable dt2 = new DataTable("TT2");
            dt1 = (DataTable)ViewState["RouteWiseTable"];
            dt2 = (DataTable)ViewState["PackageWiseTable"];
            ds.Tables.Add(dt1);
           // ds.Tables.Add(dt2);
            BuildExcel excel = new BuildExcel();
            string[] arr = { "RouteWise"};

            byte[] output = excel.DataSetProcess(ds, arr);

            Response.ContentType = ContentType;
            Response.Headers.Remove("Content-Disposition");
            Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Target Package", "Xlsx"));
            Response.BinaryWrite(output);
            Response.End();

            DataSet ds1 = new DataSet();
            DataTable dt = new DataTable("TT1");
            
           
            dt = (DataTable)ViewState["PackageWiseTable"];
            ds1.Tables.Add(dt);
            // ds.Tables.Add(dt2);
            BuildExcel excel2 = new BuildExcel();
            string[] arr2 = { "RouteWise" };

            byte[] output2 = excel.DataSetProcess(ds1, arr2);

            Response.ContentType = ContentType;
            Response.Headers.Remove("Content-Disposition");
            Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Target Package", "Xlsx"));
            Response.BinaryWrite(output2);
            Response.End();



        }





        protected void reportdetail_Click(object sender, EventArgs e)
        {

        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            string rot = rotFromGrid();
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { rot };
            lstUser = ObjclsFrms.loadList("RouteWiseTargetPackage", "sp_TargetDashboard", mnth, ar);
            ViewState["RouteWiseTable"] = lstUser;
            grvRptRouteWise.DataSource = lstUser;


        }
        public void ListData()
        {

            DataTable lstUsers = default(DataTable);
            string rot = rotFromGrid();
            string mnth = DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] ar = { rot };

            //lstUsers = ObjclsFrms.loadList("PackageWiseTargetPackage", "sp_Dashboard", mnth, ar);
            //ViewState["PackageWiseTable"] = lstUsers;
            //grvRptPackageWise.DataSource = lstUsers; Temporarily hides package wise details


        }

        protected void grvRptRouteWise_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRptPackageWise_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRptPackageWise_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("tph_ID").ToString();
                Response.Redirect("TargetDashboardRouteDetails.aspx?Id=" + ID+"&&Mode=PKG");
            }
        }

        protected void grvRptRouteWise_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rot_ID").ToString();
                Response.Redirect("TargetDashboardRouteDetails.aspx?Id=" + ID + "&&Mode=ROT");
            }
        }

        protected void targetamountclick_Click(object sender, EventArgs e)
        {

        }

        protected void TargetQuantityClick_Click(object sender, EventArgs e)
        {

        }
    }
}