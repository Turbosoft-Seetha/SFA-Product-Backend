using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using System.Configuration;
using DocumentFormat.OpenXml.Presentation;
using System.IO;
using System.Xml;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteMerchDashboard : System.Web.UI.Page
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

                lnkAdvFilter.Visible = false;
                pnlstartmessage.Visible = false;
                rdfromDate.MaxDate = DateTime.Now;
                Session["IVHMode"] = null;
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



                if (ResponseType == null)
                {
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
                }
                else if (ResponseType.Equals("udp"))
                {
                    try
                    {


                        rdfromDate.SelectedDate = DateTime.Parse(Session["UdpDate"].ToString());
                        rdRoute.SelectedValue = Session["UdpRoute"].ToString();
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                }

                Session["KPIRoute"] = null;
                Session["KPIDate"] = null;
                Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
                Session["KPIDate"] = rdfromDate.SelectedDate.ToString();
                ViewState["Chart"] = null;

                try
                {
                    if ((Session["KPIRoute"] != null) && (Session["KPIRoute"].ToString() != ""))
                    {
                        string Route = rdRoute.SelectedValue.ToString();
                        DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", Route.ToString());
                        string Type = dt.Rows[0]["RouteType"].ToString();

                        if (Type == "SL")
                        {


                        }

                        else
                        {
                            //Normal Route


                        }

                    }
                    else
                    {


                    }
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "RouteDAshboard.aspx", " Error : " + ex.Message.ToString() + " - " + innerMessage);

                }

                SelCusVisits();
                SelCusSchVisits();
                OutOfStock();
                ItemAvailability();
                General();
                Survey();
                DispAgreements();
                Task();
                CustomerActivities();
                Requests();
                Settlement();
                TimeSetReport();
                SelCollectionReport();


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            }

        }

        public void SelCollectionReport()
        {
            lblTotalCheque.Text = String.Empty;
            DataTable dtCheque = LoadData("SelCollChequeReport");
            DataTable dtChequeCount = LoadData("SelCollChequeCount");
            DataTable dtChequeDetail = LoadData("SelChequeDetail");
            rptCheque.DataSource = dtChequeDetail;
            rptCheque.DataBind();
            string totalCheque = dtCheque.Rows[0]["total"].ToString();
            string chequeCount = dtChequeCount.Rows[0]["total"].ToString();
            lblTotalCheque.Text = chequeCount + " / " + totalCheque;
        }

        protected void ddlRotType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rdRoute.ClearSelection();
            Route("");
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
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), ddlRotType.SelectedValue.ToString() };
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

            DataTable dt1 = LoadData("TotalCusVisits");
            DataTable dtCustomerVisit = ObjclsFrms.loadList("SelCusVisits", "sp_KPI_Dashboard", route.ToString(), arr);

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

            DataTable dt1 = LoadData("SelCusSchVisitsTotal");
            DataTable dtActualVisit = ObjclsFrms.loadList("SelCusSchVisSplit", "sp_KPI_Dashboard", route.ToString(), arr);

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
        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        { 

        }
        protected void PlannedVisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerVisitsDetail.aspx");
        }

        protected void ActualVisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerVisitsDetail.aspx");
        }

        protected void Productivevisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerVisitsDetail.aspx");
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
        protected void btnVanStock_Click(object sender, EventArgs e)
        {
            UserDailyID();
            string ID = ViewState["ID"].ToString();
            Session["rdRoute"] = rdRoute.SelectedValue.ToString();
            Session["fDate"] = rdfromDate.SelectedDate.ToString();
            Session["TDate"] = rdfromDate.SelectedDate.ToString();
            Response.Redirect("CurrentVanStock.aspx?Id=" + ID);

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
                lblCashTotal.Text = sum.ToString("#,##0.00");
            }
            else
            {
                lblCashTotal.Text = "0";
                lblHardCash.Text = "0";
                lblOnlinePayment.Text = "0";
                lblPOS.Text = "0";
            }
        }
        public void TimeSetReport()
        {
            lblHours.Text = String.Empty;
            lblStartTime.Text = String.Empty;
            lblSpendWithCus.Text = "00 Hrs  00 Mins";

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
                lblCollectedTotal.Text = sumCollected.ToString("#,##0.00");
                lblTotalVariance.Text = sumVariance.ToString("#,##0.00");
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
            ddlRotType.ClearSelection();
        }
        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            Session["KPIRoute"] = null;
            Session["KPIDate"] = null;
            Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
            Session["KPIDate"] = rdfromDate.SelectedDate.ToString();
            Session["KPIType"] = ddlRotType.SelectedValue.ToString();
            ViewState["Chart"] = null;


            string Route = rdRoute.SelectedValue.ToString();
            DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", Route.ToString());
            string Type = dt.Rows[0]["RouteType"].ToString();
            if (Type == "MER")
            {

                pnlstartmessage.Visible = false;
                pnlVisit.Visible = true;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = true;
            }
            else if (Type == "SL")
            {
                Response.Redirect("RouteSalesDashboard.aspx");

            }
            else if (Type == "FS")
            {
                Response.Redirect("RouteFieldServiceDashboard.aspx");
            }
            else if (Type == "DL")
            {
                Response.Redirect("DeliveryRouteDashboard.aspx");
            }
            else
            {

                Response.Redirect("RouteDashboard.aspx");
            }

            SelCusVisits();
            SelCusSchVisits();
            OutOfStock();
            ItemAvailability();
            General();
            Survey();
            DispAgreements();
            Task();
            CustomerActivities();
            Requests();
            Settlement();
            TimeSetReport();
            SelCollectionReport();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);


        }
        
       
        public void Survey()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstAssignedSurvey = ObjclsFrms.loadList("AssignedSurveysCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedSurvey = ObjclsFrms.loadList("CompletedSurveysCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstSurveyPerformed = ObjclsFrms.loadList("SurveyPerformed", "sp_Merch_Dashboard", route, arr);
            lblAssignedSurveys.Text = lstAssignedSurvey.Rows[0]["number"].ToString();
            lblCompletedSurveys.Text = lstCompletedSurvey.Rows[0]["number"].ToString();
        }
        public void DispAgreements()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstNewAgreements = ObjclsFrms.loadList("NewDisplayAgreementsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstActiveAgreements = ObjclsFrms.loadList("ActiveDisplayAgreementsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstAgreementsPerformed = ObjclsFrms.loadList("DisplayAgreementsPerformed", "sp_Merch_Dashboard", route, arr);
            lblNewAgreements.Text = lstNewAgreements.Rows[0]["number"].ToString();
            lblActiveAgreements.Text = lstActiveAgreements.Rows[0]["number"].ToString();
            lblApproved.Text = lstActiveAgreements.Rows[0]["number"].ToString();
        }

        public void Task()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstAssignedTask = ObjclsFrms.loadList("AssignedTaskCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedTask = ObjclsFrms.loadList("CompletedTaskCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstTaskPerformed = ObjclsFrms.loadList("CustomerTaskPerformed", "sp_Merch_Dashboard", route, arr);
            lblAssignedTask.Text = lstAssignedTask.Rows[0]["number"].ToString();
            lblCompletedTasks.Text = lstCompletedTask.Rows[0]["number"].ToString();
        }
        public void CustomerActivities()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstOpenCusAct = ObjclsFrms.loadList("OpenCustomerActivityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedCusAct = ObjclsFrms.loadList("CompletedCustomerActivityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCusActPerformed = ObjclsFrms.loadList("CustomerActivityPerformed", "sp_Merch_Dashboard", route, arr);
            lblOpenCusAct.Text = lstOpenCusAct.Rows[0]["number"].ToString();
            lblCompletedCusAct.Text = lstCompletedCusAct.Rows[0]["number"].ToString();
        }
       
        public string mainConditions(string rotID)
        {
            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
                string endDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
                dateCondition = " and (cast(D.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";

            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            return mainCondition;
        }
        public void OutOfStock()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string[] arr = { fromDate, toDate };
            DataTable lstOutOfStockItem = ObjclsFrms.loadList("OOSItemCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstOutOfStockCustomer = ObjclsFrms.loadList("OOSCustomerCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstOutOfStockPerformed = ObjclsFrms.loadList("OOSPerformed", "sp_Merch_Dashboard", route, arr);
            lblTotalOosItems.Text = lstOutOfStockItem.Rows[0]["number"].ToString();
            lblOosCustomers.Text = lstOutOfStockCustomer.Rows[0]["number"].ToString();
        }

        public void ItemAvailability()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string[] arr = { fromDate, toDate };
            DataTable lstNotAvailableItem = ObjclsFrms.loadList("ItemAvailabilityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstNotAvailableCustomer = ObjclsFrms.loadList("CustomerAvailabilityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstNotAvailablePerformed = ObjclsFrms.loadList("ItemAvailbilityPerformed", "sp_Merch_Dashboard", route, arr);
            lblNotAvailableItems.Text = lstNotAvailableItem.Rows[0]["number"].ToString();
            lblNotAvailableCustomers.Text = lstNotAvailableCustomer.Rows[0]["number"].ToString();
        }
        public void General()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { fromDate, toDate , user };
            //DataTable lstDeliveryCheck = ObjclsFrms.loadList("DeliveryCheckCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstItemPricing = ObjclsFrms.loadList("ItemPricingCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCustomerInventory = ObjclsFrms.loadList("InventoryCount", "sp_Merch_Dashboard", route, arr);
            lblItemPricing.Text = lstItemPricing.Rows[0]["number"].ToString();
            lblCustomerInventory.Text = lstCustomerInventory.Rows[0]["number"].ToString();

            DataTable lstCompetitorActivities = ObjclsFrms.loadList("CompetitorActivitiesCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstImageCapture = ObjclsFrms.loadList("ImageCaptureCount", "sp_Merch_Dashboard", route, arr);
            lblCompetitorActivities.Text = lstCompetitorActivities.Rows[0]["number"].ToString();
            lblImageCapture.Text = lstImageCapture.Rows[0]["number"].ToString();

            DataTable CreditNote = ObjclsFrms.loadList("CreditNoteReqCount", "sp_Merch_Dashboard", route, arr);
            DataTable DisputeReq = ObjclsFrms.loadList("DisputeReqCount", "sp_Merch_Dashboard", route, arr);
            DataTable ReturnReq = ObjclsFrms.loadList("ReturnReqCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstGeneralComplaints = ObjclsFrms.loadList("SelectGeneralComplaintsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstProductComplaints = ObjclsFrms.loadList("SelectProductComplaintsCounts", "sp_Merch_Dashboard", route, arr);
            lblprdComp.Text = lstProductComplaints.Rows[0]["number"].ToString();
            lblgeneralComplaints.Text = lstGeneralComplaints.Rows[0]["number"].ToString();
            lblCreditNote.Text = CreditNote.Rows[0]["number"].ToString();
            lblDisputeReqNote.Text = DisputeReq.Rows[0]["number"].ToString();
            lblReturnRequest.Text = ReturnReq.Rows[0]["number"].ToString();
        }
        public string Rot()
        {
            string rotId;
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    if (rdRoute.SelectedValue.ToString().Equals(""))
                    {
                        rotId = "0";
                    }
                    else
                    {
                        rotId =rdRoute.SelectedValue.ToString();
                    }
                     
                    createNode(rotId, writer);
                    c++;

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
        private void createNode(string rotId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void Requests()
        {
            string route;
            route = Rot();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstNewRequest = ObjclsFrms.loadList("NewRequestCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstRepondedRequest = ObjclsFrms.loadList("RepondedRequestCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstReqPerformed = ObjclsFrms.loadList("ReqPerformed", "sp_Merch_Dashboard", route, arr);
            lblNewRequest.Text = lstNewRequest.Rows[0]["number"].ToString();
            lblRepondedRequest.Text = lstRepondedRequest.Rows[0]["number"].ToString();
        }

        protected void btnOutOfStk_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            Session["ToDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("OutOfStockAnalysis.aspx?mode=2");
        }

        protected void btnItmAvlbty_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            Session["ToDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ItemAvailabilityAnalysis.aspx?mode=2");
        }
        protected void lnkOosItems_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerOutStockHeader.aspx?mode=1");
        }

        protected void lnkOosCustomers_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerOutStockHeader.aspx");

        }

        protected void lnkNotAvailableItem_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ItemNotAvailable.aspx");

        }
        protected void lnkNotAvailableCustomers_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ItemAvailability.aspx?mode=2");
        }
        protected void lnkCustomerInventory_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("InventoryHeader.aspx?mode=2");
        }
        protected void lnkItemPricing_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerRetailPrice.aspx?mode=2");
        }
        protected void lbTasks_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("CustomerTaskAnalysis.aspx?mode=2");
        }

        protected void lbSurvey_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListSurveyAnalysis.aspx?mode=2");
        }

        protected void lbDispAggr_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreementAnalysis.aspx?mode=2");
        }

        protected void lbCustAct_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivityAnalysis.aspx?mode=1");
        }
        protected void lnkCompetitorActivities_Click(object sender, EventArgs e)
        {

            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListCompetitorActivities.aspx?mode=2");
        }
        protected void lnkAssignedSurveys_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            string route = Rot();
            Session["rot"] = route;
            Response.Redirect("ListAssignedSurvey.aspx?mode=1");
        }

        protected void lnkCompletedSurveys_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListSurveyHeaders.aspx?mode=1&type=CS");
        }

        protected void lnkNewAgreements_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=2&type=NA");
        }

        protected void lnkActiveAgreements_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=2&type=AA");
        }

        protected void lnkAssignedTask_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("CustomerTasks.aspx?mode=2&type=AT");
        }

        protected void lnkCompletedTasks_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("CustomerTasks.aspx?mode=2&type=CT");
        }
        protected void lnkOpenCusAct_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdfromDate.SelectedDate.ToString();
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivity.aspx?Mode=2&type=OP");
        }
        protected void lnkCompletedCusAct_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdfromDate.SelectedDate.ToString();
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivity.aspx?Mode=2&type=CC");
        }

        protected void lnkImageCapture_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ImageCapture.aspx?mode=2");
        }
        protected void lnkCreditNote_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Session["FromDate"] = rdfromDate.SelectedDate.ToString(); ;
            Session["ToDate"] = rdfromDate.SelectedDate.ToString(); ;
            Response.Redirect("CreditNoteReqApprovalHeader.aspx?mode=1");
        }

        protected void lnkDisputeReqNote_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdfromDate.SelectedDate.ToString();
            Response.Redirect("DisputeNotReqApprovalHeader.aspx?mode=1");
        }

        protected void lnkReturnRequest_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdfromDate.SelectedDate.ToString();
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ScheduledReturn.aspx?Mode=2");
            //
        }
        protected void lnkNewRequest_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdfromDate.SelectedDate.ToString();
            Response.Redirect("ListNewRequests.aspx?mode=1&type=NR");
        }
        protected void lnkRepondedRequest_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListNewRequests.aspx?mode=1&type=RR");
        }

        protected void lnkgnrlComp_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdfromDate.SelectedDate.ToString();
            Response.Redirect("ListGeneralComplaintss.aspx?mode=1");
        }

        protected void lnkPrdComp_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdfromDate.SelectedDate.ToString();
            Response.Redirect("ListProductComplaintss.aspx?mode=1");
        }
        protected void lnkApproved_Click(object sender, EventArgs e)
        {
            string rot = rdRoute.SelectedValue.ToString();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=2&type=AP");
        }
    }
}