using DocumentFormat.OpenXml.Presentation;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteFieldServiceDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public string ResponseType
        {
            get
            {
                string ResponseType = Request.Params["Type"];

                return ResponseType;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lnkAdvFilter.Visible= false;
                pnlstartmessage.Visible= false;

                rdfromDate.MaxDate = DateTime.Now;
                Region();
                int o = 1;
                foreach (RadComboBoxItem itmss in ddlregion.Items)
                {
                    itmss.Checked = true;
                    o++;
                }
                string Reg = REG();
                string regcondition = " dep_reg_ID in (" + Reg + ")";
                Depot(regcondition);

                int p = 1;
                foreach (RadComboBoxItem itmss in ddldepots.Items)
                {
                    itmss.Checked = true;
                    p++;
                }
                string depo = DPO();
                string dpocondition = " dpa_dep_ID in (" + depo + ")";
                DpoArea(dpocondition);
                int q = 1;
                foreach (RadComboBoxItem itmss in ddldpoArea.Items)
                {
                    itmss.Checked = true;
                    q++;
                }
                string depoarea = DPOarea();
                string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";
                DpoSubArea(dpoareacondition);
                int R = 1;
                foreach (RadComboBoxItem itmss in ddldpoSubArea.Items)
                {
                    itmss.Checked = true;
                    R++;
                }
                string deposubarea = DPOsubarea();
                string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";
                
                string rotID;

                try
                {


                    if (Session["KPIDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["KPIDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                    }
                    Route("");
                    if (Session["KPIRoute"] != null)
                    {
                        rdRoute.SelectedValue = Session["KPIRoute"].ToString();
                    }
                    else
                    {

                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    if ((Session["KPIRoute"] != null) && (Session["KPIRoute"].ToString() != ""))
                    {
                        string Route = rdRoute.SelectedValue.ToString();


                    }
                }
                catch(Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "RouteDAshboard.aspx", " Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

                
                DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
                string Type = dt.Rows[0]["RouteType"].ToString();

                DataTable dtIsAsset = ObjclsFrms.loadList("SelIsAsset", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
                string IsAsset = dtIsAsset.Rows[0]["rot_EnableKPIAstTracking"].ToString();

                DataTable dtService = ObjclsFrms.loadList("SelIsService", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
                string IsService = dtService.Rows[0]["rot_EnableKPIServReq"].ToString();

                if (Type == "FS")
                {
                    if (IsAsset == "Y")
                    {
                        pnlAssetTrackingandServiceReq.Visible = true;
                    }
                    else
                    {
                        pnlAssetTrackingandServiceReq.Visible = false;
                    }
                    if (IsService == "Y")
                    {
                        pnlServiceRequest.Visible = true;
                    }
                    else
                    {
                        pnlServiceRequest.Visible = false;
                    }
                    SelCusVisits();
                    SelCusSchVisits();
                    SelLoads();
                    LoadTransfer();
                    LoadOut();
                    Settlement();
                    TimeSetReport();
                    TotalInvoiceAmount();
                    InventoryReconfirmation();
                    ServiceRequestCount();
                    AssetTrackingCount();
                    AssetAddingRequest();
                    AssetRemovalRequest();
                }
                else
                {
                    Response.Redirect("RouteDashboard.aspx");
                }
                

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            }

        }

        protected void lnkTimeline_Click(object sender, EventArgs e)
        {
            UserDailyID();
            string Id = "232";
            string url = ConfigurationManager.AppSettings.Get("TrackingUrlID");
            OpenNewBrowserWindow(url + ViewState["ID"] + "&&mode=DIGITS-SFA", this);

        }
        public static void OpenNewBrowserWindow(string Url, System.Web.UI.Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
        public void Settlement()
        {
            TotalCash();
            TotalCollected();
        }

        public void TotalCash()
        {
            UserDailyID();
            string udpId = ViewState["ID"].ToString();
            DataTable lstCashReceived = ObjclsFrms.loadList("SelTotalWithMode", "sp_KPI_Dashboard", udpId.ToString());
            if (lstCashReceived.Rows.Count > 0)
            {
                string mode, amount;
                double sum = 0;
                string hardCash, pos, onlinePay;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    amount = lstCashReceived.Rows[i]["Amount"].ToString();
                    sum += double.Parse(amount);
                    if (mode.Equals("HC"))
                    {
                        hardCash = amount.ToString();
                        ViewState["HardCash"] = hardCash.ToString();
                        lblHardCash.Text = hardCash;
                    }
                    else if (mode.Equals("POS"))
                    {
                        pos = amount.ToString();
                        ViewState["POS"] = pos.ToString();
                        lblPOS.Text = pos;
                    }
                    else if (mode.Equals("OP"))
                    {
                        onlinePay = amount.ToString();
                        ViewState["Online"] = onlinePay.ToString();
                        lblOnlinePayment.Text = onlinePay;
                    }
                }
                lblCashTotal.Text = sum.ToString();
            }
            else
            {
                lblCashTotal.Text = "0";
                lblHardCash.Text = "0";
                lblOnlinePayment.Text = "0";
                lblPOS.Text = "0";
            }
        }
        public void SelCusVisits()
        {

            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string route;
            if (rdRoute.SelectedValue.ToString().Equals(""))
            {
                route = "0";
            }
            else
            {
                route = rdRoute.SelectedValue.ToString();
            }
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };

            DataTable dt1 = LoadDatas("TotalCusVisits");
            DataTable dtCustomerVisit = ObjclsFrms.loadList("SelCusVisits", "sp_RouteFieldServiceDashboard", route.ToString(), arr);

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dcCustomerVisit in dtCustomerVisit.Columns)
            {
                if (i < dtCustomerVisit.Columns.Count - 1)
                {
                    XAxis += dcCustomerVisit.ColumnName.ToString() + "-";
                    YAxis += dtCustomerVisit.Rows[0][dcCustomerVisit.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dcCustomerVisit.ColumnName.ToString();
                    YAxis += dtCustomerVisit.Rows[0][dcCustomerVisit.ColumnName].ToString();
                }
                i++;
            }
            lblPlannedVisit.Text = para1.ToString();
            string CuVisits = "ApplyPlannedDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += CuVisits;

        }

        public void SelCusSchVisits()
        {

            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string route = rdRoute.SelectedValue.ToString();
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };

            DataTable dt1 = LoadDatas("SelCusSchVisitsTotal");
            DataTable dtActualVisit = ObjclsFrms.loadList("SelCusSchVisSplit", "sp_RouteFieldServiceDashboard", route.ToString(), arr);

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";


            foreach (DataColumn dcActualVisit in dtActualVisit.Columns)
            {
                if (i < dtActualVisit.Columns.Count - 1)
                {
                    XAxis += dcActualVisit.ColumnName.ToString() + "-";
                    YAxis += dtActualVisit.Rows[0][dcActualVisit.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dcActualVisit.ColumnName.ToString();
                    YAxis += dtActualVisit.Rows[0][dcActualVisit.ColumnName].ToString();
                }
                i++;
            }
            //lblActualVisit.Text = para1.ToString();
            int tot = Int32.Parse(dtActualVisit.Rows[0]["Planned"].ToString()) + Int32.Parse(dtActualVisit.Rows[0]["Unplanned"].ToString());
            lblActualVisit.Text = tot.ToString();
            string CuVisits = "ApplyActualDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += CuVisits;

        }

       

        public void SelLoads()
        {
            DataTable dt = LoadData("SelLICountSplit");
            DataTable dt1 = LoadData("SelLiCount");
            DataTable dts = LoadData("SelLICountSplits");

            string para1 = dt1.Rows[0][0].ToString();
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
            lblLoadIn.Text = para1.ToString();
            lblLICompleted.Text = dts.Rows[0]["LICompleted"].ToString();
            lblLIPending.Text = dts.Rows[0]["LIPending"].ToString();
            lblLINotProcss.Text = dts.Rows[0]["LINotProcessed"].ToString();
            lblLIRejected.Text = dts.Rows[0]["LIRejected"].ToString();
            string CuVisits = "ApplyLoadsDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "'); ";
            ViewState["Chart"] += CuVisits;
        }
        public void Region()
        {
            ddlregion.DataSource = ObjclsFrms.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlregion.DataTextField = "reg_Name";
            ddlregion.DataValueField = "reg_ID";
            ddlregion.DataBind();
        }
        public void Route(string DposubAreaCondition)
        {
            //string[] arr = { DposubAreaCondition };
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList("SelectRouteforRotDashboards", "sp_KPI_Dashboard", UICommon.GetCurrentUserID().ToString(), arr);
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        public DataTable LoadData(string mode)
        {

            string route;
            if (rdRoute.SelectedValue.ToString().Equals(""))
            {
                route = "0";
            }
            else
            {
                route = rdRoute.SelectedValue.ToString();
            }
            Session["rdRoute"] = rdRoute.SelectedValue.ToString();
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", route.ToString(), arr);
            return dt;

        }
        public DataTable LoadDatas(string mode)
        {

            string route;
            if (rdRoute.SelectedValue.ToString().Equals(""))
            {
                route = "0";
            }
            else
            {
                route = rdRoute.SelectedValue.ToString();
            }
            Session["rdRoute"] = rdRoute.SelectedValue.ToString();
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_RouteFieldServiceDashboard", route.ToString(), arr);
            return dt;

        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {

            Session["KPIRoute"] = null;
            Session["KPIDate"] = null;
            Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
            Session["KPIDate"] = rdfromDate.SelectedDate.ToString();

            ViewState["Chart"] = null;
            string Route = rdRoute.SelectedValue.ToString();
            DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", Route.ToString());
            string Type = dt.Rows[0]["RouteType"].ToString();

            if (Type == "FS")
            {
                SelCusVisits();
                SelCusSchVisits();
                SelLoads();
                LoadTransfer();
                LoadOut();
                Settlement();
                TimeSetReport();
                TotalInvoiceAmount();
                InventoryReconfirmation();
                ServiceRequestCount();
                AssetTrackingCount();
                AssetAddingRequest();
                AssetRemovalRequest();
            }
            else
            {
                Response.Redirect("RouteDashboard.aspx");
            }


        }
            protected void lnkAdvFilter_Click(object sender, EventArgs e)
        {
            if (plhFilter.Visible == true)
            {
                plhFilter.Visible = false;
            }
            else
            {
                plhFilter.Visible = true;
            }

        }
        public void Depot(string Regcondition)
        {
            string[] arr = { Regcondition };
            ddldepots.DataSource = ObjclsFrms.loadList("SelectDepotTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldepots.DataTextField = "dep_Name";
            ddldepots.DataValueField = "dep_ID";
            ddldepots.DataBind();
        }
        public void DpoArea(string DpoCondition)
        {
            string[] arr = { DpoCondition };
            ddldpoArea.DataSource = ObjclsFrms.loadList("SelectDepotAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoArea.DataTextField = "dpa_Name";
            ddldpoArea.DataValueField = "dpa_ID";
            ddldpoArea.DataBind();
        }
        public void DpoSubArea(string DpoAreaCondition)
        {
            string[] arr = { DpoAreaCondition };
            ddldpoSubArea.DataSource = ObjclsFrms.loadList("SelectDepotSubAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoSubArea.DataTextField = "dsa_Name";
            ddldpoSubArea.DataValueField = "dsa_ID";
            ddldpoSubArea.DataBind();
        }
        public string REG()
        {
            var CollectionMarket1 = ddlregion.CheckedItems;
            string regID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        regID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        regID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        regID += item.Value;
                    }
                    j++;
                }
                return regID;
            }
            else
            {
                return "0";
            }
        }
        public string DPO()
        {
            var CollectionMarket1 = ddldepots.CheckedItems;
            string dpoID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        dpoID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dpoID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dpoID += item.Value;
                    }
                    j++;
                }
                return dpoID;
            }
            else
            {
                return "0";
            }
        }


        public string DPOarea()
        {
            var CollectionMarket2 = ddldpoArea.CheckedItems;
            string dpoareID = "";
            int j = 0;
            int MarCount = CollectionMarket2.Count;
            if (CollectionMarket2.Count > 0)
            {
                foreach (var item in CollectionMarket2)
                {
                    if (j == 0)
                    {
                        dpoareID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dpoareID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dpoareID += item.Value;
                    }
                    j++;
                }
                return dpoareID;
            }
            else
            {
                return "0";
            }
        }

        public string DPOsubarea()
        {
            var CollectionMarket3 = ddldpoSubArea.CheckedItems;
            string dposubareID = "";
            int j = 0;
            int MarCount = CollectionMarket3.Count;
            if (CollectionMarket3.Count > 0)
            {
                foreach (var item in CollectionMarket3)
                {
                    if (j == 0)
                    {
                        dposubareID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dposubareID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dposubareID += item.Value;
                    }
                    j++;
                }
                return dposubareID;
            }
            else
            {
                return "0";
            }
        }

        protected void ddldepot_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
        }

        protected void ddldpoArea_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
        }

        protected void ddldpoSubArea_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route("");
        }

        protected void ddldepots_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";


            DpoArea(DpoCondition);

        }
        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }
        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            Session["KPIRoute"] = null;
            Session["KPIDate"] = null;
            Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
            Session["KPIDate"] = rdfromDate.SelectedDate.ToString();

            ViewState["Chart"] = null;
            string Route = rdRoute.SelectedValue.ToString();
            DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", Route.ToString());
            string Type = dt.Rows[0]["RouteType"].ToString();

            
            if (Type == "FS")
            {
                pnlstartmessage.Visible = false;
                pnlVisit.Visible = true;
                pnlload.Visible = true;
                pnlTimeline.Visible = true;
                pnlAssetTrackingandServiceReq.Visible = true;
                pnlSale.Visible = true;
                pnlServiceRequest.Visible = true;
                pnlSettlement.Visible = true;
                
            }
            else if (Type == "DL")
            {
                Response.Redirect("DeliveryRouteDashboard.aspx");
            }
            else if (Type == "SL")
            {
                Response.Redirect("RouteSalesDashboard.aspx");
            }
            else if (Type == "MER")
            {
                Response.Redirect("RouteMerchDashboard.aspx");
            }
            else
            {
                Response.Redirect("RouteDashboard.aspx");
            }
            SelCusVisits();
            SelCusSchVisits();
            SelLoads();
            LoadTransfer();
            LoadOut();
            Settlement();
            TimeSetReport();
            TotalInvoiceAmount();
            InventoryReconfirmation();
            ServiceRequestCount();
            AssetTrackingCount();
            AssetAddingRequest();
            AssetRemovalRequest();
        }
        protected void PlannedVisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("RouteWiseServiceJobsHeader.aspx?Type=P");
        }

        protected void ActualVisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("RouteWiseServiceJobsHeader.aspx?Type=V");
        }
        protected void salessummary_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoadInAndSalesDetail.aspx");
        }
        protected void LoadIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoadInAndSalesDetail.aspx");
        }
        protected void lnkLT_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoadOutDashboardDetail.aspx");
        }
        public void TotalCollected()
        {
            UserDailyID();
            string udpId = ViewState["ID"].ToString();
            DataTable lstCashReceived = ObjclsFrms.loadList("SelectUserSettlementPayModes", "sp_KPI_Dashboard", udpId.ToString());
            if (lstCashReceived.Rows.Count > 0)
            {
                string mode, hcCollected, hcVariance, posCollected, posVariance, opVariance, opCollected;
                double sumCollected = 0, sumVariance = 0;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    sumCollected += double.Parse(lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString());
                    sumVariance += double.Parse(lstCashReceived.Rows[i]["usp_Variance"].ToString());
                    if (mode.Equals("HC"))
                    {
                        hcCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        hcVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVarianceHard.Text = hcVariance.ToString();
                        lblCollectedHard.Text = hcCollected.ToString();
                    }
                    else if (mode.Equals("POS"))
                    {
                        posCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        posVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVariancePos.Text = posVariance.ToString();
                        lblCollectedPos.Text = posCollected.ToString();
                    }
                    else if (mode.Equals("OP"))
                    {
                        opCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        opVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVarainceOnline.Text = opVariance.ToString();
                        lblCollectedOnline.Text = opCollected.ToString();
                    }
                }
                lblCollectedTotal.Text = sumCollected.ToString();
                lblTotalVariance.Text = sumVariance.ToString();
            }
            else
            {
                lblCollectedTotal.Text = "0.00";
                lblCollectedHard.Text = "0.00";
                lblCollectedOnline.Text = "0.00";
                lblCollectedPos.Text = "0.00";
                lblTotalVariance.Text = "0.00";
                lblVarianceHard.Text = "0.00";
                lblVarainceOnline.Text = "0.00";
                lblVariancePos.Text = "0.00";
            }
        }


        public void UserDailyID()
        {
            string date = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MM-yyyy");
            string route = rdRoute.SelectedValue.ToString();
            string[] arr = { date.ToString() };
            DataTable lstID = ObjclsFrms.loadList("SelectUserDailyProcessID", "sp_KPI_Dashboard", route, arr);
            if (lstID.Rows.Count > 0)
            {
                string Id = lstID.Rows[0]["udp_ID"].ToString();
                ViewState["ID"] = Id.ToString();
            }
            else
            {
                ViewState["ID"] = "0";
            }
        }

        public void TimeSetReport()
        {
            lblHours.Text = String.Empty;
            lblStartTime.Text = String.Empty;
            lblSpendWithCus.Text = "00Hrs.00Mins";

            DataTable dt = LoadData("SelTimeReport");
            if (dt.Rows.Count > 0)
            {
                lblHours.Text = dt.Rows[0]["Duration"].ToString();
                lblStartTime.Text = dt.Rows[0]["StartTime"].ToString();
                lblSpendWithCus.Text = dt.Rows[0]["CusTime"].ToString();
                lblEndDay.Text = dt.Rows[0]["EndDayStatus"].ToString();
                lblSettlement.Text = dt.Rows[0]["udp_SettlementStatus"].ToString();
                lblAppProcess.Text = dt.Rows[0]["udp_IsAppProcessComplete"].ToString();
                lblLoadout.Text = dt.Rows[0]["udp_LoadOutStatus"].ToString();
                if (lblHours.Text.Equals(""))
                {
                    lblHours.Text = "00:00:00";
                }
            }
        }
        public void TotalInvoiceAmount()
        {
            string totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, creditCount, creditAmount;
            DataTable lstInvoice = LoadData("SelectTotalInvoiceCollection");
            if (lstInvoice.Rows.Count > 0)
            {
                totalAmount = lstInvoice.Rows[0]["TotalInvAmount"].ToString();
                hcCount = lstInvoice.Rows[0]["HC_Count"].ToString();
                hcAmount = lstInvoice.Rows[0]["HC_Amount"].ToString();
                posCount = lstInvoice.Rows[0]["POS_Count"].ToString();
                posAmount = lstInvoice.Rows[0]["POS_Amount"].ToString();
                opCount = lstInvoice.Rows[0]["OP_Count"].ToString();
                opAmount = lstInvoice.Rows[0]["OP_Amount"].ToString();
                creditCount = lstInvoice.Rows[0]["CR_Count"].ToString();
                creditAmount = lstInvoice.Rows[0]["CR_Amount"].ToString();

                lblTotalInvAmt.Text = totalAmount.ToString();
                lblInvHcAmt.Text = hcAmount.ToString();
                lblInvHcCount.Text = hcCount.ToString();
                lblInvPosAmt.Text = posAmount.ToString();
                lblInvPosCount.Text = posCount.ToString();
                lblInvOpAmt.Text = opAmount.ToString();
                lblInvOpCount.Text = opCount.ToString();
                lblInvCreditAmt.Text = creditAmount.ToString();
                lblInvCreditCount.Text = creditCount.ToString();
            }
            else
            {
                lblTotalInvAmt.Text = "0 / 0.00";
                lblInvHcAmt.Text = "0.00";
                lblInvHcCount.Text = "0";
                lblInvPosAmt.Text = "0.00";
                lblInvPosCount.Text = "0";
                lblInvOpAmt.Text = "0.00";
                lblInvOpCount.Text = "0";
                lblInvCreditAmt.Text = "0.00";
                lblInvCreditCount.Text = "0";
            }
        }

       

        public void LoadTransfer()
        {
            DataTable lstLTCount = LoadData("SelLTGDCount");
            string good, bad;
            good = lstLTCount.Rows[0]["GDLoadTransfer"].ToString();
            bad = lstLTCount.Rows[0]["BDLoadTransfer"].ToString();
            lblLTGoodStock.Text = good.ToString();
            lblLTBadStock.Text = bad.ToString();
        }

        public void LoadOut()
        {
            DataTable lstGoodLoadOut = LoadData("SelLOGDCount");
            DataTable lstBadLoadOut = LoadData("SelLOBDCount");
            int good, gEnd, gOffLoad, gAdj, bad, bOffLoad, bAdj;
            good = Int32.Parse(lstGoodLoadOut.Rows[0]["LoadOutCount"].ToString());
            if (good == 0)
            {
                pnlGDgreen.Visible = false;
                pnlGDred.Visible = true;
            }
            else
            {
                pnlGDgreen.Visible = true;
                pnlGDred.Visible = false;
            }
            gEnd = Int32.Parse(lstGoodLoadOut.Rows[0]["EndStockCount"].ToString());
            if (gEnd == 0)
            {
                pnlGDEndGreen.Visible = false;
                pnlGDEndRed.Visible = true;
            }
            else
            {
                pnlGDEndGreen.Visible = true;
                pnlGDEndRed.Visible = false;
            }
            gOffLoad = Int32.Parse(lstGoodLoadOut.Rows[0]["OffloadCount"].ToString());
            if (gOffLoad == 0)
            {
                pnlGDOffGreen.Visible = false;
                pnlGDOffRed.Visible = true;
            }
            else
            {
                pnlGDOffGreen.Visible = true;
                pnlGDOffRed.Visible = false;
            }
            gAdj = Int32.Parse(lstGoodLoadOut.Rows[0]["AdjCount"].ToString());
            if (gAdj == 0)
            {
                pnlGDAdjGreen.Visible = false;
                pnlGDAdjRed.Visible = true;
            }
            else
            {
                pnlGDAdjGreen.Visible = true;
                pnlGDAdjRed.Visible = false;
            }
            bad = Int32.Parse(lstBadLoadOut.Rows[0]["LoadOutCount"].ToString());
            if (bad == 0)
            {
                pnlBDgreen.Visible = false;
                pnlBDred.Visible = true;
            }
            else
            {
                pnlBDgreen.Visible = true;
                pnlBDred.Visible = false;
            }
            bOffLoad = Int32.Parse(lstBadLoadOut.Rows[0]["OffloadCount"].ToString());
            if (bOffLoad == 0)
            {
                pnlBDOffGreen.Visible = false;
                pnlBDOffRed.Visible = true;
            }
            else
            {
                pnlBDOffGreen.Visible = true;
                pnlBDOffRed.Visible = false;
            }
            bAdj = Int32.Parse(lstBadLoadOut.Rows[0]["AdjCount"].ToString());
            if (bAdj == 0)
            {
                pnlBDAdjGreen.Visible = false;
                pnlBDAdjRed.Visible = true;
            }
            else
            {
                pnlBDAdjGreen.Visible = true;
                pnlBDAdjRed.Visible = false;
            }
        }

        public void MonthlyTarget()
        {
            DataTable dtMonthlyTarget = new DataTable();
            dtMonthlyTarget = ObjclsFrms.loadList("SelectMonthlyTarget", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
            string XAxis = "";
            string YAxis = "";
            string ZAxis = "";
            for (int i = 0; i < dtMonthlyTarget.Rows.Count; i++)
            {
                if (i < dtMonthlyTarget.Rows.Count - 1)
                {
                    XAxis += dtMonthlyTarget.Rows[i]["rtp_Month"].ToString() + "-";
                    YAxis += dtMonthlyTarget.Rows[i]["TargetAmount"].ToString() + "-";
                    ZAxis += dtMonthlyTarget.Rows[i]["AchievedAmount"].ToString() + "-";
                }
                else if (i == dtMonthlyTarget.Rows.Count - 1)
                {
                    XAxis += dtMonthlyTarget.Rows[i]["rtp_Month"].ToString();
                    YAxis += dtMonthlyTarget.Rows[i]["TargetAmount"].ToString();
                    ZAxis += dtMonthlyTarget.Rows[i]["AchievedAmount"].ToString();
                }
            }
            string MonthlyTargetChart = "ApplyMonthlyTargetChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + ZAxis.ToString() + "');";
            ViewState["Chart"] += MonthlyTargetChart;
        }

        public void DailyTarget()
        {
            DataTable dtDailyTarget = new DataTable();
            dtDailyTarget = ObjclsFrms.loadList("SelectDailyTarget", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
            string XAxis = "";
            string YAxis = "";
            string ZAxis = "";
            for (int i = 0; i < dtDailyTarget.Rows.Count; i++)
            {
                if (i < dtDailyTarget.Rows.Count - 1)
                {
                    XAxis += dtDailyTarget.Rows[i]["rtp_Month"].ToString() + "-";
                    YAxis += dtDailyTarget.Rows[i]["TargetAmount"].ToString() + "-";
                    ZAxis += dtDailyTarget.Rows[i]["AchievedAmount"].ToString() + "-";
                }
                else if (i == dtDailyTarget.Rows.Count - 1)
                {
                    XAxis += dtDailyTarget.Rows[i]["rtp_Month"].ToString();
                    YAxis += dtDailyTarget.Rows[i]["TargetAmount"].ToString();
                    ZAxis += dtDailyTarget.Rows[i]["AchievedAmount"].ToString();
                }
            }
            string DailyTargetChart = "ApplyDailyTargetChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + ZAxis.ToString() + "');";
            ViewState["Chart"] += DailyTargetChart;
        }
        public void InventoryReconfirmation()
        {
            DataTable dt = new DataTable();
            dt = LoadData("SelInventoryandVantoVan");
            lblreconfirmation.Text = dt.Rows[0]["InvRecCount"].ToString();
            lbltrnIn.Text = dt.Rows[0]["TransIn"].ToString();
            lbltrnIn.Text = dt.Rows[0]["TransOut"].ToString();
        }
        public void AssetRemovalRequest()
        {
            try
            {
                //DataTable lstAssetRemoval = ObjclsFrms.loadList("SelectAssetRemovingRequestCount", "sp_ServiceDashboard");
                DataTable lstAssetRemoval = new DataTable();
                lstAssetRemoval = LoadData("SelectAssetRemovingRequestCount");
                string AssetsRemovalReq = lstAssetRemoval.Rows[0]["number"].ToString();
                lblAssetRemovalRequest.Text = AssetsRemovalReq.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void AssetAddingRequest()
        {
            try
            {
                //DataTable lstAssetAdding = ObjclsFrms.loadList("SelectAssetAddingRequestCount", "sp_ServiceDashboard");
                DataTable lstAssetAdding = new DataTable();
                lstAssetAdding = LoadData("SelectAssetAddingRequestCount");
                string AssetsAddingReq = lstAssetAdding.Rows[0]["number"].ToString();
                lblAssetAddingRequest.Text = AssetsAddingReq.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void AssetTrackingCount()
        {
            try
            {
                //DataTable lstAssetTracking = ObjclsFrms.loadList("SelectTotalAssetCount", "sp_ServiceDashboard", fromDate);
                DataTable lstAssetTracking = new DataTable();
                lstAssetTracking = LoadData("SelectTotalAssetCountForFs");
                string Visited = lstAssetTracking.Rows[0]["TotalVisited"].ToString();
                string Tracked = lstAssetTracking.Rows[0]["Tracked"].ToString();
                string NotTracked = lstAssetTracking.Rows[0]["NotTracked"].ToString();


                lblAssetVisited.Text = Visited.ToString();
                lblAssetTracked.Text = Tracked.ToString();
                lblAssetNotTracked.Text = NotTracked.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void ServiceRequestCount()
        {
            try
            {
                //DataTable lstServiceRequest = ObjclsFrms.loadList("SelectServiceRequestCount", "sp_ServiceDashboard");
                DataTable lstServiceRequest = new DataTable();
                lstServiceRequest = LoadData("SelectServiceRequestCount");
                string TotalServiceReq = lstServiceRequest.Rows[0]["CreatedServiceRequest"].ToString();
                string Created = lstServiceRequest.Rows[0]["ActionTakenServiceRequest"].ToString();

                lblOpenServiceReqCount.Text = TotalServiceReq.ToString();
                lblCompReqCount.Text = Created.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        protected void lnkAssetAddingRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetAddReqApproval.aspx");
        }

       

        protected void lnkServiceRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceRequestHeader.aspx");
        }

        protected void lnkAssetRemovalRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetRemoveReqApproval.aspx");
        }

        protected void Lnlvantovan_Click(object sender, EventArgs e)
        {
            Response.Redirect("VanToVanHeader.aspx");
        }

        protected void LnkInventoryRec_Click(object sender, EventArgs e)
        {
            Response.Redirect("InvVerificationHeader.aspx"); //InvVerificationHeader.aspx
        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Session["KPIRoute"] = null;
            Session["KPIDate"] = null;
            Session["KPIDate"] = rdfromDate.SelectedDate.ToString();
            ViewState["Chart"] = null;
            rdRoute.Text = "";
            rdRoute.SelectedValue = "";
            Route("");
            pnlstartmessage.Visible = true;
            pnlVisit.Visible = false;
            pnlload.Visible = false;
            pnlTimeline.Visible = false;
            pnlAssetTrackingandServiceReq.Visible = false;
            pnlSale.Visible = false;
            pnlServiceRequest.Visible = false;
            pnlSettlement.Visible = false;
        }

        protected void AssetTrack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetTrackingDashboard.aspx");
        }
    }
}