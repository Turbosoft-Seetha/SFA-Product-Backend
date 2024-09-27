using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class DailyActivityReview : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
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
                ViewState["mtdsales"] ="0.00";
                HeaderData();
                mtddata();
                TargetData();
                salesData();
                
                ReviewStart();
            }
        }

        public void ReviewStart()
        {
            string[] arr = { };
            string Value = Obj.SaveData("sp_DailyActivityReview", "ReporReviewStartTime", ResponseID.ToString(),arr);
            try
            {
                int res = Int32.Parse(Value.ToString());
            }
            catch(Exception ex) { }
            
            

        }
        public void ReviewComplete()
        {
            string user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { user };
            string Value = Obj.SaveData("sp_DailyActivityReview", "ReporReviewComplete", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Review Completed Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("CashInvClick"))
            {
                try
                {
                    foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string CseNo = dataItem["cse_ID"].Text.ToString();
                    string UdpNo = dataItem["udp_ID"].Text.ToString();
                    string url = "DailyActivityDetails.aspx?mode=1&&cse_ID=" + CseNo + "&&udp_ID=" + UdpNo;
                    Response.Redirect(url);
                    


                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    Obj.LogMessageToFile(UICommon.GetLogFileName(), "DailyActivityReview.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
           else if (e.CommandName.Equals("CreditInvClick"))
            {
                try
                {
                    foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string CseNo = dataItem["cse_ID"].Text.ToString();
                    string UdpNo = dataItem["udp_ID"].Text.ToString();
                    string url = "DailyActivityDetails.aspx?mode=2&&cse_ID=" + CseNo + "&&udp_ID=" + UdpNo;
                    Response.Redirect(url);



                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    Obj.LogMessageToFile(UICommon.GetLogFileName(), "DailyActivityReview.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
           else if (e.CommandName.Equals("CashRtnClick"))
            {
                try
                {
                    foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string CseNo = dataItem["cse_ID"].Text.ToString();
                    string UdpNo = dataItem["udp_ID"].Text.ToString();
                    string url = "DailyActivityDetails.aspx?mode=3&&cse_ID=" + CseNo + "&&udp_ID=" + UdpNo;
                    Response.Redirect(url);



                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    Obj.LogMessageToFile(UICommon.GetLogFileName(), "DailyActivityReview.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }

            else if (e.CommandName.Equals("CreditRtnClick"))
            {
                try
                {
                    foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string CseNo = dataItem["cse_ID"].Text.ToString();
                    string UdpNo = dataItem["udp_ID"].Text.ToString();
                    string url = "DailyActivityDetails.aspx?mode=4&&cse_ID=" + CseNo + "&&udp_ID=" + UdpNo;
                    Response.Redirect(url);



                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    Obj.LogMessageToFile(UICommon.GetLogFileName(), "DailyActivityReview.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
            else if (e.CommandName.Equals("CashARClick"))
            {
                try
                {
                    foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string CseNo = dataItem["cse_ID"].Text.ToString();
                    string UdpNo = dataItem["udp_ID"].Text.ToString();
                    string url = "DailyActivityDetails.aspx?mode=5&&cse_ID=" + CseNo + "&&udp_ID=" + UdpNo;
                    Response.Redirect(url);



                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    Obj.LogMessageToFile(UICommon.GetLogFileName(), "DailyActivityReview.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
            else if (e.CommandName.Equals("ChequeARClick"))
            {
                try
                {
                    foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string CseNo = dataItem["cse_ID"].Text.ToString();
                    string UdpNo = dataItem["udp_ID"].Text.ToString();
                    string url = "DailyActivityDetails.aspx?mode=6&&cse_ID=" + CseNo + "&&udp_ID=" + UdpNo;
                    Response.Redirect(url);



                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    Obj.LogMessageToFile(UICommon.GetLogFileName(), "DailyActivityReview.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }

        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            // lstUser = Obj.loadList("ListProjects", "sp_Masters");
            lstUser = new DataTable();
            grvRpt.DataSource = lstUser;

        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = Obj.loadList("SelUsrDlyPrcsHeaderByID", "sp_DailyActivityReview", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");

                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");



                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblDuration.Text = lstDatas.Rows[0]["Duration"].ToString();

                lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();

                lblrotname.Text = lstDatas.Rows[0]["routeName"].ToString();




            }
        }

        public void mtddata()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = Obj.loadList("ListRouteWorkingDays", "sp_DailyActivityReview", ResponseID.ToString());
            try
            {
                if (lstDatas.Rows.Count > 0)
                {
                    lblMTDWrkDays.Text = lstDatas.Rows[0]["WorkedDays"].ToString();

                    lbltotWrkDays.Text = lstDatas.Rows[0]["rmd_WorkingDays"].ToString();

                    lblMTDsales.Text = lstDatas.Rows[0]["AchievedAmount"].ToString();
                    ViewState["mtdsales"] = lstDatas.Rows[0]["AchievedAmount"].ToString();
                }
                else
                {
                    lblMTDWrkDays.Text = "0.00";


                    lbltotWrkDays.Text = "0.00";
                   
                    lblMTDsales.Text = "0.00";
                }
            }
            catch (Exception ex)
            {

                lblMTDWrkDays.Text = "0.00";

                lbltotWrkDays.Text = "0.00";
               
                lblMTDsales.Text = "0.00";

               
            }
        }
        public void TargetData()
        {
            decimal mtdamount = Decimal.Parse(ViewState["mtdsales"].ToString());
            decimal proAmnt ;
            decimal excessorshort;
            DataTable lstDatas = new DataTable();
            lstDatas = Obj.loadList("DailyTargetPackageHeadercounts", "sp_DailyActivityReview", ResponseID.ToString());
            try
            {
                if (lstDatas.Rows.Count > 0)
                {
                   
                    lblMTDWrkDays.Text = lstDatas.Rows[0]["WorkedDays"].ToString();

                    lbltotaltarget.Text = lstDatas.Rows[0]["TotalTargetAmount"].ToString();

                    lbltotWrkDays.Text = lstDatas.Rows[0]["rmd_WorkingDays"].ToString();
                    lblproratedTarget.Text = lstDatas.Rows[0]["MTD_AMT"].ToString();
                     //lblMTDsales.Text = lstDatas.Rows[0]["TotalMonthAchAmount"].ToString();
                   
                    lblMTDsaltoAchv.Text = lstDatas.Rows[0]["Target_PerDayAmt"].ToString();

                    //lblexcsorshort.Text = lstDatas.Rows[0]["excessorshort"].ToString();
                    proAmnt = decimal.Parse(lstDatas.Rows[0]["MTD_AMT"].ToString());
                    excessorshort= mtdamount - proAmnt;
                   
                    lblexcsorshort.Text = excessorshort.ToString();
                }
                else
                {
                    lblMTDWrkDays.Text = "0.00";

                    lbltotaltarget.Text = "0.00";

                    lbltotWrkDays.Text = "0.00";
                    lblproratedTarget.Text = "0.00";
                    //lblMTDsales.Text = "0.00";

                    lblMTDsaltoAchv.Text = "0.00";
                    proAmnt = 0;
                    excessorshort =  mtdamount - proAmnt;
                    lblexcsorshort.Text = excessorshort.ToString();
                }
            }
            catch (Exception ex) {

                lblMTDWrkDays.Text = "0.00";

                lbltotaltarget.Text = "0.00";

                lbltotWrkDays.Text = "0.00";
                lblproratedTarget.Text = "0.00";
               // lblMTDsales.Text = "0.00";

                lblMTDsaltoAchv.Text = "0.00";

                lblexcsorshort.Text = "0.00";

            }
        }
        public void salesData()
        {

            DataTable lstprovisit = new DataTable();
            DataTable lstsales = new DataTable();
            lstprovisit = Obj.loadList("SelProductiveVisitSplit", "sp_DailyActivityReview", ResponseID.ToString());
            lstsales = Obj.loadList("SelDashboardReportInvoiceData", "sp_DailyActivityReview", ResponseID.ToString());
            try
            {
                if (lstprovisit.Rows.Count > 0)
                {
                    lblprovisit.Text = lstprovisit.Rows[0]["ProdVisits"].ToString();
                    lbltotvisit.Text = lstprovisit.Rows[0]["totVisits"].ToString();
                }
                if (lstsales.Rows.Count > 0)
                {
                    lbltodaysales.Text = lstsales.Rows[0]["invoiceSum"].ToString();

                }
            }
            catch (Exception ex) {
            }
        }
        public void LoadData()
        {
           
           
            DataTable lstDatas = new DataTable();
            lstDatas = Obj.loadList("SelDailyActivityReport", "sp_DailyActivityReview", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;
            try
            {
                if(lstDatas.Rows.Count > 0)
                {
                    DataTable lstfinal = new DataTable();
                    lstfinal = Obj.loadList("SelDailyActivityfinal", "sp_DailyActivityReview", ResponseID.ToString());
                    ViewState["final"] = lstfinal;
                }
            }
            catch(Exception ex) { }
            
        }

       

        protected void lnkback_Click(object sender, EventArgs e)
        {
            Response.Redirect("DailyActivityReviewHeader.aspx?");
        }

        protected void lnkcomplete_Click(object sender, EventArgs e)
        {
            ReviewComplete();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("DailyActivityReviewHeader.aspx?");
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            DataTable lstfinals = new DataTable();
            if (ViewState["final"] != null)
            {
                lstfinals = (DataTable)ViewState["final"];
            }
            if (e.Item is GridFooterItem)
            {
                GridFooterItem footerItem = e.Item as GridFooterItem;

                // Fetch the label control in the footer
                Label lblFinalTotalSal_CS = footerItem.FindControl("finalTotalSal_CS") as Label;
                Label lblfinalTotalSal_CR = footerItem.FindControl("finalTotalSal_CR") as Label;
                Label lblfinalTotalrtn_CS = footerItem.FindControl("finalTotalrtn_CS") as Label;
                Label lblfinalTotalrtn_CR = footerItem.FindControl("finalTotalrtn_CR") as Label;
                Label lblfinalTotalAR_CH = footerItem.FindControl("finalTotalAR_CH") as Label;
                Label lblfinalTotalAR_CS = footerItem.FindControl("finalTotalAR_CS") as Label;

                lblFinalTotalSal_CS.Text = lstfinals.Rows[0]["finalTotalSal_CS"].ToString();
                lblfinalTotalSal_CR.Text = lstfinals.Rows[0]["finalTotalSal_CR"].ToString();

                lblfinalTotalrtn_CS.Text = lstfinals.Rows[0]["finalTotalrtn_CS"].ToString();

                lblfinalTotalrtn_CR.Text = lstfinals.Rows[0]["finalTotalrtn_CR"].ToString();

                lblfinalTotalAR_CH.Text = lstfinals.Rows[0]["finalTotalAR_CH"].ToString();
                lblfinalTotalAR_CS.Text = lstfinals.Rows[0]["finalTotalAR_CS"].ToString();



            }
        }
    }
}