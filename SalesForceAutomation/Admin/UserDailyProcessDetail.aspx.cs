using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class UserDailyProcessDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
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
                ViewState["id"] = 0;
                Session["CusStartExitId"] = null;
                Session["CusId"] = null;
                Customer();
                HeaderData();
                Counts();
                CustomerFilter();
                string cusID = Cus();
                string cusCondition = "cse_cus_ID in (" + cusID + ")";
            }
            
            //try
            //{
            //    dt = ObjclsFrms.loadList("DashboardClaimCountMTD", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            //    if (dt.Rows.Count > 0)
            //    {
            //        lblMTDAll.Text = dt.Rows[0]["TotalCount"].ToString();
            //        lblOpenMTD.Text = dt.Rows[0]["OpenClaim"].ToString();
            //        lblApprovedMTD.Text = dt.Rows[0]["ApprovedClaim"].ToString();
            //        lblRejectedMTD.Text = dt.Rows[0]["RejectedClaim"].ToString();
            //    }
            //}
            //catch (Exception ex)
            //{

            //}

            //try
            //{
            //    dt = ObjclsFrms.loadList("DashboardClaimCountYTD", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            //    if (dt.Rows.Count > 0)
            //    {
            //        lblYtdAll.Text = dt.Rows[0]["TotalCount"].ToString();
            //        lblYTDOpen.Text = dt.Rows[0]["OpenClaim"].ToString();
            //        lblApprovedYTD.Text = dt.Rows[0]["ApprovedClaim"].ToString();
            //        lblRejectedYTD.Text = dt.Rows[0]["RejectedClaim"].ToString();
            //    }
            //}
            //catch (Exception Ex)
            //{

            //}
        }
        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in ddlCustomer.Items)
            {
                itme.Checked = true;
                k++;
            }
        }
        public string Cus()
        {
            var ColelctionMarkets = ddlCustomer.CheckedItems;
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


        public string mainConditions(string cusID)
        {
            string CusID = Cus();
            string mainCondition = " cse_udp_ID=" + ResponseID;
            string cusCondition = " and  cse_cus_ID in (" + CusID + ")";

            mainCondition += cusCondition;
            return mainCondition;
        }
        public void Counts()
        {
            try
            {
                //string Cusid = Session["CusId"].ToString();

                string CusId = "";
                if (Session["CusId"] == null)
                {
                    CusId = "";
                }
                else
                {
                    CusId = Session["CusId"].ToString();
                }

                string startExitId = "";
                if(Session["CusStartExitId"] == null)
                {
                    startExitId = "";
                }
                else
                {
                    startExitId = Session["CusStartExitId"].ToString();
                }
                
                DataTable dt = new DataTable();
                string[] arr = { CusId, startExitId };
                dt = ObjclsFrms.loadList("SelUserDailyprocessCounts", "sp_Merchandising", ResponseID.ToString(),arr);
                if (dt.Rows.Count > 0)
                {
                    lblTotalInvoice.Text = dt.Rows[0]["salecount"].ToString();
                    lblTotalOrders.Text = dt.Rows[0]["ordercount"].ToString();
                    lblTotalAR.Text = dt.Rows[0]["ARcount"].ToString();
                    lblTotalAP.Text = dt.Rows[0]["Adpaymentcount"].ToString();
                }

               
                   

                    if (startExitId == "")
                {
                    code.Visible = true;
                    cus.Visible = false;
                }
                else
                {
                    cus.Visible = true;
                    code.Visible = false;
                    DataTable ds = new DataTable();
                    ds = ObjclsFrms.loadList("SelectCusDetail", "sp_Merchandising", startExitId);
                    if (ds.Rows.Count > 0)
                    {
                        lblcode.Text = ds.Rows[0]["cus_Code"].ToString();
                        lblcusName.Text = ds.Rows[0]["customer"].ToString();
                        lblsTime.Text = ds.Rows[0]["cse_STime"].ToString();
                        lbleTime.Text = ds.Rows[0]["cse_ETime"].ToString();
                        lbldurations.Text = ds.Rows[0]["Duration"].ToString();
                    }

                }
                
            }
            catch (Exception ex)
            {

            }
        }

        public void Customer()
        {
            ddlCustomer.DataSource = ObjclsFrms.loadList("SelCustomer", "sp_Merchandising",ResponseID.ToString());
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            string alternateText = (sender as ImageButton).AlternateText;
            if (grvRpt.MasterTableView.Items.Count > 0)
            {
                //grvRpt.MasterTableView.GetColumn("Detail").Visible = false;
                foreach (GridColumn gridColumn in grvRpt.Columns)
                {
                    //gridColumn.HeaderText = gridColumn.HeaderText.Replace("<br/>", " ");
                    gridColumn.HeaderStyle.Font.Bold = true;
                    gridColumn.HeaderStyle.Font.Size = 12;

                }
                grvRpt.ExportSettings.Excel.Format = (GridExcelExportFormat)Enum.Parse(typeof(GridExcelExportFormat), alternateText);
                grvRpt.ExportSettings.IgnorePaging = true;
                grvRpt.ExportSettings.FileName = "UserDailyProcessDetail";
                grvRpt.ExportSettings.ExportOnlyData = true;
                grvRpt.ExportSettings.OpenInNewWindow = true;
                grvRpt.MasterTableView.ExportToExcel();
            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserDailyProcess.aspx");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        public void LoadData()
        {
            string cusID =Cus();
            if (!cusID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(cusID);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("SelectUserDailyProcessDetail", "sp_Merchandising", mainCondition);
                grvRpt.DataSource = lstDatas;
                lblTotalVisits.Text = lstDatas.Rows.Count.ToString();
            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblDuration.Text = lstDatas.Rows[0]["Duration"].ToString();
                //lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
                lblrotname.Text= lstDatas.Rows[0]["routeName"].ToString();
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            LoadData();
            Counts();
            grvRpt.Rebind();
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cse_ID").ToString();
                Response.Redirect("DetailedDailyTransactions.aspx?Id=" + ID + "&DId=" + ResponseID.ToString());
            }
            if (e.CommandName.Equals("MyClick1"))
            {
                
                foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                {
                    di.BackColor = Color.Transparent;
                }

                GridDataItem item = grvRpt.MasterTableView.Items[Convert.ToInt32(e.CommandArgument)];
                string ID = item.GetDataKeyValue("cse_ID").ToString();
               
                if (ViewState["id"].ToString() == ID)
                {
                    Session["CusStartExitId"] = null;
                    Session["CusId"] = null;
                    ViewState["id"] = 0;
                }
                else
                {
                    ViewState["id"] = ID;
                    Session["CusStartExitId"] = ID.ToString();
                    DataTable lstDatas = new DataTable();
                    lstDatas = ObjclsFrms.loadList("SelectUserDailyProcessDetailCusId", "sp_Merchandising", ID);
                    string cusid = lstDatas.Rows[0]["cse_cus_ID"].ToString();
                    Session["CusId"] = cusid.ToString();
                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb"); 
                   
                }
                Counts();

            }
        }

        protected void map_Click(object sender, ImageClickEventArgs e)
        {

            string id = "232";
            OpenNewBrowserWindow("https://track.dev-ts.online/Home/ViewMap?Id="+id+"&&mode=DIGITS-SFA", this);
        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }


        protected void Settelment_Click1(object sender, ImageClickEventArgs e)
        {
         
            DataTable lstSettlement = ObjclsFrms.loadList("SelectSettlementStatus", "sp_Settlement", ResponseID.ToString());
            if (lstSettlement.Rows.Count > 0)
            {
                string status = lstSettlement.Rows[0]["udp_SettlementStatus"].ToString();
                if (status.Equals("SC"))
                {
                    Response.Redirect("SettlementReportCompleted.aspx?Id=" + ResponseID.ToString());
                }
                else
                {
                    Response.Redirect("SettlementReports.aspx?Id=" + ResponseID.ToString());
                }
            }

        }

        protected void lnkinvoices_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=Invoice" + "&Cid=" + ViewState["id"]);
        }

        protected void lnkOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=Orders" + "&Cid=" + ViewState["id"]);
        }

        protected void lnkAr_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=AR" + "&Cid=" + ViewState["id"]);
        }

        protected void lnkAp_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=AP" + "&Cid=" + ViewState["id"]);
        }

        protected void report_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dx = ObjclsFrms.loadList("SelDateandRot", "sp_Settlement", ResponseID.ToString());
            if (dx.Rows.Count > 0)
            {
                Session["udpDate"] = dx.Rows[0]["dt"].ToString();
                Session["udpRoute"] = dx.Rows[0]["rotID"].ToString();
                Response.Redirect("RouteDashboard.aspx");
            }
          

        }
    }
}