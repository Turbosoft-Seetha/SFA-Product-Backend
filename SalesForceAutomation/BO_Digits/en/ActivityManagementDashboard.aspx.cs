using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ActivityManagementDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Session["FromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                    }
                    if (Session["ToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                    }
                }
                catch(Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                Route("1=1");
                string rotID;
                RouteFromTransaction();
                rotID = Rot();
                Session["rot"] = rotID;

                lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                DatePick();
                pnlTimeline.Visible = true;
                RouteSummary(rotID);
                Survey(rotID);
                DispAgreements(rotID);
                Task(rotID);
                General(rotID);
                CustomerActivities(rotID);
                LoadVisits(rotID);
                Session["rot"] = rotID;
            }
        }

        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForDropDowns", "sp_Merch_Dashboard", UICommon.GetCurrentUserID().ToString(), arr);
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in ddlRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public string Rot()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var CollectionMarket = ddlRoute.CheckedItems;
                    int MarCount = CollectionMarket.Count;
                    if (CollectionMarket.Count > 0)
                    {
                        foreach (var item in CollectionMarket)
                        {
                            string rotId = item.Value;
                            createNode(rotId, writer);
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
        public string Rotids()
        {
            var ColelctionMarket = ddlRoute.CheckedItems;
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

        public void RouteSummary(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            if (fromDate.Equals(toDate))
            {
                pnlTimeline.Visible = true;
                string[] arr = { fromDate, toDate };
                DataTable lstActive = ObjclsFrms.loadList("SelectAllRouteStatusofMER", "sp_Merch_Dashboard", route, arr); //SelectAllRouteStatusofMER
                int active = Int32.Parse(lstActive.Rows[0]["active"].ToString());
                lblActiveRoute.Text = active.ToString();
                DataTable lstProductive = ObjclsFrms.loadList("SelectActiveRouteStatusofMER", "sp_Merch_Dashboard", route, arr);
                int productive = Int32.Parse(lstProductive.Rows[0]["active"].ToString());
                lblProductiveRoute.Text = productive.ToString();
                int nonprod = active - productive;
                lblNonProductiveRoute.Text = nonprod.ToString();
                DataTable totalvisit = ObjclsFrms.loadList("CustomerVisitCount", "sp_Merch_Dashboard", route, arr);//CustomerVisitCount
                lblVisitedCustomers.Text = totalvisit.Rows[0]["number"].ToString();
            }
            else
            {
                pnlTimeline.Visible = false;
            }
        }

        public void DatePick()
        {
            string fromDate, ToDate;
            try
            {
                if (Session["FromDate"] != null)
                {
                    rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Now;
                }
                if (Session["ToDate"] != null)
                {
                    rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Now;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            
            rdfromDate.MaxDate = DateTime.Now;
            rdendDate.MaxDate = DateTime.Now;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
        }

        private void createNode(string rotId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        protected void lnkToday_Click(object sender, EventArgs e)
        {
            string rotID;
            rotID = Rot();
            Route(rotID);
            lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            rdfromDate.SelectedDate = DateTime.Now;
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            pnlTimeline.Visible = true;
            RouteSummary(rotID);
            Survey(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            CustomerActivities(rotID);
            LoadVisits(rotID);
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            string rotID;
            rotID = Rot();
            Route(rotID);
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkYear.Attributes.Remove("Style");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            pnlTimeline.Visible = false;
            RouteSummary(rotID);
            Survey(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            CustomerActivities(rotID);
            LoadVisits(rotID);
        }
        protected void lnkYear_Click(object sender, EventArgs e)
        {
            string rotID;
            rotID = Rot();
            Route(rotID);
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, 1, 1);
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            pnlTimeline.Visible = false;
            RouteSummary(rotID);
            Survey(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            CustomerActivities(rotID);
            LoadVisits(rotID);

        }

       

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            string rotID;
            rotID = Rot();
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            if (fromDate.Equals(ToDate))
            {
                pnlTimeline.Visible = true;
            }
            else
            {
                pnlTimeline.Visible = false;
            }
            RouteSummary(rotID);
            Survey(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            CustomerActivities(rotID);
            LoadVisits(rotID);

        }
        protected void lnkProductive_Click(object sender, EventArgs e)
        {

            Session["fDate"] = rdfromDate.SelectedDate.ToString();
            Session["TDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("RouteTypes.aspx");
        }
        protected void lnkMap_Click(object sender, EventArgs e)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string url = ConfigurationManager.AppSettings.Get("TrackingUrl");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "openlink", "window.open('" + url + "&&date=" + fromDate + "');", true);
        }
        public string mainConditions(string rotID)
        {
            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(D.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";

            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            return mainCondition;
        }
        public void General(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstCompetitorActivities = ObjclsFrms.loadList("CompetitorActivitiesCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstImageCapture = ObjclsFrms.loadList("ImageCaptureCount", "sp_Merch_Dashboard", route, arr);
            lblCompetitorActivities.Text = lstCompetitorActivities.Rows[0]["number"].ToString();
            lblImageCapture.Text = lstImageCapture.Rows[0]["number"].ToString();
        }
        public void Survey(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstAssignedSurvey = ObjclsFrms.loadList("AssignedSurveysCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedSurvey = ObjclsFrms.loadList("CompletedSurveysCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstSurveyPerformed = ObjclsFrms.loadList("SurveyPerformed", "sp_Merch_Dashboard", route, arr);
            lblAssignedSurveys.Text = lstAssignedSurvey.Rows[0]["number"].ToString();
            lblCompletedSurveys.Text = lstCompletedSurvey.Rows[0]["number"].ToString();
        }
        public void DispAgreements(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstNewAgreements = ObjclsFrms.loadList("NewDisplayAgreementsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstActiveAgreements = ObjclsFrms.loadList("ActiveDisplayAgreementsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstAgreementsPerformed = ObjclsFrms.loadList("DisplayAgreementsPerformed", "sp_Merch_Dashboard", route, arr);
            lblNewAgreements.Text = lstNewAgreements.Rows[0]["number"].ToString();
            lblActiveAgreements.Text = lstActiveAgreements.Rows[0]["number"].ToString();
            lblApproved.Text= lstActiveAgreements.Rows[0]["number"].ToString();
        }

        public void Task(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstAssignedTask = ObjclsFrms.loadList("AssignedTaskCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedTask = ObjclsFrms.loadList("CompletedTaskCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstTaskPerformed = ObjclsFrms.loadList("CustomerTaskPerformed", "sp_Merch_Dashboard", route, arr);
            lblAssignedTask.Text = lstAssignedTask.Rows[0]["number"].ToString();
            lblCompletedTasks.Text = lstCompletedTask.Rows[0]["number"].ToString();
        }
        public void CustomerActivities(string route)
        {

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstOpenCusAct = ObjclsFrms.loadList("OpenCustomerActivityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedCusAct = ObjclsFrms.loadList("CompletedCustomerActivityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCusActPerformed = ObjclsFrms.loadList("CustomerActivityPerformed", "sp_Merch_Dashboard", route, arr);
            lblOpenCusAct.Text = lstOpenCusAct.Rows[0]["number"].ToString();
            lblCompletedCusAct.Text = lstCompletedCusAct.Rows[0]["number"].ToString();
        }
        protected void lnkCompetitorActivities_Click(object sender, EventArgs e)
        {

            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCompetitorActivities.aspx?mode=2");
        }
        protected void lnkAssignedSurveys_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListAssignedSurvey.aspx?mode=1");
        }

        protected void lnkCompletedSurveys_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListSurveyHeaders.aspx?mode=1&type=CS");
        }

        protected void lnkNewAgreements_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=2&type=NA");
        }

        protected void lnkActiveAgreements_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=2&type=AA");
        }

        protected void lnkAssignedTask_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("CustomerTasks.aspx?mode=2&type=AT");
        }

        protected void lnkCompletedTasks_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("CustomerTasks.aspx?mode=2&type=CT");
        }
        protected void lnkOpenCusAct_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivity.aspx?Mode=2&type=OP");
        }
        protected void lnkCompletedCusAct_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivity.aspx?Mode=2&type=CC");
        }
        
        protected void lnkImageCapture_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ImageCapture.aspx?mode=2");
        }

        public void LoadVisits(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            if (fromDate.Equals(toDate))
            {
                pnlTimeline.Visible = true;
                DataTable dtPlannedVisit = new DataTable();
                DataTable dtActualVisit = new DataTable();
                DataTable dtProductiveVisit = new DataTable();
                DataTable dtNonProductiveVisit = new DataTable();
                string[] arr = { fromDate };
                dtPlannedVisit = ObjclsFrms.loadList("SelPlannedVisits", "sp_Merch_Dashboard", route, arr);
                dtActualVisit = ObjclsFrms.loadList("SelActualVisitSplit", "sp_Merch_Dashboard", route, arr);
                dtProductiveVisit = ObjclsFrms.loadList("SelProductiveVisitSplit", "sp_Merch_Dashboard", route, arr);
                dtNonProductiveVisit = ObjclsFrms.loadList("SelNonProdVisSplit", "sp_Merch_Dashboard", route, arr);
                int proPlanned, proUnplanned, proTotal, nonProPlanned, nonProUnplanned, nonProTotal, pendingPlanned, visitedPlanned, totalPlanned,
                    plannedActual, unplannedActual, totalActual;

                visitedPlanned = Int32.Parse(dtPlannedVisit.Rows[0]["visited"].ToString());
                pendingPlanned = Int32.Parse(dtPlannedVisit.Rows[0]["pending"].ToString());
                totalPlanned = visitedPlanned + pendingPlanned;

                plannedActual = Int32.Parse(dtActualVisit.Rows[0]["Planned"].ToString());
                unplannedActual = Int32.Parse(dtActualVisit.Rows[0]["Unplanned"].ToString());
                totalActual = plannedActual + unplannedActual;

                proPlanned = Int32.Parse(dtProductiveVisit.Rows[0]["ScheduledProdVisits"].ToString());
                proUnplanned = Int32.Parse(dtProductiveVisit.Rows[0]["UnscheduledProdVisits"].ToString());
                proTotal = proPlanned + proUnplanned;

                nonProPlanned = Int32.Parse(dtNonProductiveVisit.Rows[0]["ScheduledNonProdVisits"].ToString());
                nonProUnplanned = Int32.Parse(dtNonProductiveVisit.Rows[0]["UnscheduledNonProdVisits"].ToString());
                nonProTotal = nonProPlanned + nonProUnplanned;


                lblTotalPlannedVisit.Text = totalPlanned.ToString();
                lblVisitedPlanned.Text = visitedPlanned.ToString();
                lblPendingPlanned.Text = pendingPlanned.ToString();
                lblTotalActualVisit.Text = totalActual.ToString();
                lblPlannedActual.Text = plannedActual.ToString();
                lblUnplannedActual.Text = unplannedActual.ToString();
                lblTotalProductiveVisit.Text = proTotal.ToString();
                lblPlannedProductive.Text = proPlanned.ToString();
                lblUnplannedProductive.Text = proUnplanned.ToString();
                lblTotalNonProductiveVisit.Text = nonProTotal.ToString();
                lblPlannedNonProd.Text = nonProPlanned.ToString();
                lblUnplannedNonProd.Text = nonProUnplanned.ToString();
            }
            else
            {
                pnlTimeline.Visible = false;
            }
        }

        protected void lbTasks_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("CustomerTaskAnalysis.aspx?mode=2");
        }

        protected void lbSurvey_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListSurveyAnalysis.aspx?mode=2");
        }

        protected void lbDispAggr_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreementAnalysis.aspx?mode=2");
        }

        protected void lbCustAct_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivityAnalysis.aspx?mode=1");
        }

        protected void lnkPlannedVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["RouteForVisits"] = Rotids();
            string rots = Session["RouteForVisits"].ToString();
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "Planned");
        }

        protected void lnkActualVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["RouteForVisits"] = Rotids();
            string rots = Session["RouteForVisits"].ToString();
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "Actual");
        }

        protected void lnkProdVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["RouteForVisits"] = Rotids();
            string rots = Session["RouteForVisits"].ToString();
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "Prod");
        }

        protected void lnkNonProdVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["RouteForVisits"] = Rotids();
            string rots = Session["RouteForVisits"].ToString();
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "NonProd");
        }

        protected void lnkNotStarted_Click(object sender, EventArgs e)
        {
            Session["fDate"] = rdfromDate.SelectedDate.ToString();
            Session["TDate"] = rdendDate.SelectedDate.ToString();
            string rotID = Rot();
            Session["RotIDfromDashboard"] = rotID;
            Response.Redirect("NotStartedRoutes.aspx");
        }

        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {

                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime startdate = rdendDate.SelectedDate.Value.AddDays(-31);

                if (difference.Days > 31)
                {

                    rdfromDate.SelectedDate = startdate;

                }
                else
                {
                    rdfromDate.MaxDate = DateTime.Today;
                }
            }
        }
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {

                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime endDate = rdfromDate.SelectedDate.Value.AddDays(31);

                if (difference.Days > 31)
                {
                    rdendDate.MaxDate = DateTime.Today;
                    rdendDate.SelectedDate = endDate;

                }
                else
                {
                    rdendDate.MaxDate = DateTime.Today;
                }
            }
        }

        protected void lnkApproved_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=2&type=AP");
        }

        protected void lnkvistedCustomer_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["RouteForMerVisits"] = Rotids();
            string rots = Session["RouteForMerVisits"].ToString();
            Response.Redirect("MerchCustomerVisitDetail.aspx");
        }
    }
}