using GoogleApi.Entities.Maps.Directions.Response;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class MerchDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();

                RouteFromTransaction();

                string rotID;

                if (Session["Route"] != null)
                {
                    rotID = Session["Route"].ToString();
                }
                else
                {
                    rotID = Rot();
                }

                DatePick();
                OutOfStock(rotID);
                ItemAvailability(rotID);
                Survey(rotID);
                DispAgreements(rotID);
                Task(rotID);
                General(rotID);
                CustomerActivities(rotID);
                Requests(rotID);
            }
        }

        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
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
                return "udp_rot_ID";
            }
        }

        public void DatePick()
        {
            string fromDate, ToDate;
            rdfromDate.SelectedDate = DateTime.Now;
            rdfromDate.MaxDate = DateTime.Now;
            rdendDate.SelectedDate = DateTime.Now;
            rdendDate.MaxDate = DateTime.Now;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();

        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            rdendDate.MinDate = (DateTime)rdfromDate.SelectedDate;
            rdendDate.MaxDate = DateTime.Now;
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            string rotID;
            Route();

            if (Session["Route"] != null)
            {
                rotID = Session["Route"].ToString();
            }
            else
            {
                rotID = Rot();
            }

            RouteFromTransaction();
            rotID = Rot();
            ViewState["Chart"] = null;
            
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();


            OutOfStock(rotID);
            ItemAvailability(rotID);
            Survey(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            CustomerActivities(rotID);
            Requests(rotID);
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

        protected void lnkProductive_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("RouteTypes.aspx");
        }

        protected void lnkMap_Click(object sender, EventArgs e)
        {
            string url = ConfigurationManager.AppSettings.Get("TrackingUrl");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "openlink", "window.open('" + url + "');", true);
        }

        protected void lnkOosItems_Click(object sender, EventArgs e)
        {
            Response.Redirect("OutOfStocks.aspx?mode=1");
        }

        protected void lnkOosCustomers_Click(object sender, EventArgs e)
        {
            Response.Redirect("OutOfStocks.aspx?mode=1");
        }

        protected void lnkNotAvailableItem_Click(object sender, EventArgs e)
        {
            Response.Redirect("ItemAvailabilitys.aspx?mode=1");
        }

        protected void lnkNotAvailableCustomers_Click(object sender, EventArgs e)
        {
            Response.Redirect("ItemAvailabilitys.aspx?mode=1");
        }

        protected void lnkItemPricing_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerRetailPrices.aspx?mode=1");
        }

        protected void lnkCompetitorActivities_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCompetitorActivitiess.aspx?mode=1");
        }

        protected void lnkCustomerInventory_Click(object sender, EventArgs e)
        {
            Response.Redirect("InventoryHeaders.aspx?mode=1");
        }

        protected void lnkComplaints_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListProductComplaintss.aspx?mode=1");
        }

        protected void lnkImageCapture_Click(object sender, EventArgs e)
        {
            Response.Redirect("ImageCaptures.aspx?mode=1");
        }

        protected void lnkAssignedSurveys_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListSurveyMaster.aspx");
        }

        protected void lnkCompletedSurveys_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListSurveyHeaders.aspx?mode=1&type=CS");
        }

        protected void lnkNewAgreements_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDisplayAgreementss.aspx?mode=1&type=NA");
        }

        protected void lnkActiveAgreements_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDisplayAgreementss.aspx?mode=1&type=AA");
        }

        protected void lnkAssignedTask_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerTasks.aspx?mode=1&type=AT");
        }

        protected void lnkCompletedTasks_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerTasks.aspx?mode=1&type=CT");
        }

        public void OutOfStock(string route)
        {
            string mainCondition = mainConditions(route);
            DataTable lstOutOfStockItem = ObjclsFrms.loadList("SelectOutOfSockItemCount", "sp_MerchandisingDashboards", mainCondition);
            DataTable lstOutOfStockCustomer = ObjclsFrms.loadList("SelectOutOfSockCustomerCount", "sp_MerchandisingDashboards", mainCondition);
            //DataTable lstOutOfStockPerformed = ObjclsFrms.loadList("SelectOutOfSockCount", "sp_MerchandisingDashboards", mainCondition);
            lblTotalOosItems.Text = lstOutOfStockItem.Rows[0]["number"].ToString();
            lblOosCustomers.Text = lstOutOfStockCustomer.Rows[0]["number"].ToString();
           // lblTotalOutOfStock.Text = lstOutOfStockPerformed.Rows[0]["number"].ToString();
        }

        public void ItemAvailability(string route)
        {
            string mainCondition = mainConditions(route);
            DataTable lstNotAvailableItem = ObjclsFrms.loadList("SelectItemAvailabilityItemCount", "sp_MerchandisingDashboards", mainCondition);
            DataTable lstNotAvailableCustomer = ObjclsFrms.loadList("SelectItemAvailabilityCustomerCount", "sp_MerchandisingDashboards", mainCondition);
            //DataTable lstNotAvailablePerformed = ObjclsFrms.loadList("SelectItemAvailabilityCount", "sp_MerchandisingDashboards", mainCondition);
            lblNotAvailableItems.Text = lstNotAvailableItem.Rows[0]["number"].ToString();
            lblNotAvailableCustomers.Text = lstNotAvailableCustomer.Rows[0]["number"].ToString();
           // lblTotalItemAvailability.Text = lstNotAvailablePerformed.Rows[0]["number"].ToString();
        }

        public void Survey(string route)
        {
            string mainCondition = mainConditions(route);
            DataTable lstAssignedSurvey = ObjclsFrms.loadList("SelectAssignedSurvey", "sp_MerchandisingDashboards");
            DataTable lstCompletedSurvey = ObjclsFrms.loadList("SelectSurveyCount", "sp_MerchandisingDashboards", mainCondition + " and srh_cse_ID IS NOT NULL");
            //DataTable lstSurveyPerformed = ObjclsFrms.loadList("SelectSurveyCount", "sp_MerchandisingDashboards", mainCondition);
            lblAssignedSurveys.Text = lstAssignedSurvey.Rows[0]["number"].ToString();
            lblCompletedSurveys.Text = lstCompletedSurvey.Rows[0]["number"].ToString();
            //lblTotalSurvey.Text = lstSurveyPerformed.Rows[0]["number"].ToString();
        }

        public void DispAgreements(string route)
        {
            string mainCondition = mainConditions(route);
            DataTable lstNewAgreements = ObjclsFrms.loadList("SelDisplayAgreementCount", "sp_MerchandisingDashboards", mainCondition + " and A.Status='P'");
            DataTable lstActiveAgreements = ObjclsFrms.loadList("SelDisplayAgreementCount", "sp_MerchandisingDashboards", mainCondition + " and A.Status='A'");
            //DataTable lstAgreementsPerformed = ObjclsFrms.loadList("SelDisplayAgreementCount", "sp_MerchandisingDashboards", mainCondition);
            lblNewAgreements.Text = lstNewAgreements.Rows[0]["number"].ToString();
            lblActiveAgreements.Text = lstActiveAgreements.Rows[0]["number"].ToString();
            //lblTotalDispAgreement.Text = lstAgreementsPerformed.Rows[0]["number"].ToString();
        }

        public void Task(string route)
        {
            string mainCondition = mainConditions(route);
            DataTable lstAssignedTask = ObjclsFrms.loadList("ListCustomerTaskCount", "sp_MerchandisingDashboards", mainCondition + " and T.cst_Status='P'");
            DataTable lstCompletedTask = ObjclsFrms.loadList("ListCustomerTaskCount", "sp_MerchandisingDashboards", mainCondition + " and T.cst_Status='C'");
            //DataTable lstTaskPerformed = ObjclsFrms.loadList("ListCustomerTaskCount", "sp_MerchandisingDashboards", mainCondition);
            lblAssignedTask.Text = lstAssignedTask.Rows[0]["number"].ToString();
            lblCompletedTasks.Text = lstCompletedTask.Rows[0]["number"].ToString();
            //lblTotalTasks.Text = lstTaskPerformed.Rows[0]["number"].ToString();
        }

        public void General(string route)
        {
            string mainCondition = mainConditions(route);
            DataTable lstItemPricing = ObjclsFrms.loadList("SelCustomerRetailPriceCount", "sp_MerchandisingDashboards", mainCondition);
            DataTable lstCompetitorActivities = ObjclsFrms.loadList("CompetitorActivitiesCount", "sp_MerchandisingDashboards", mainCondition);
            DataTable lstCustomerInventory = ObjclsFrms.loadList("ListInvHeaderCount", "sp_MerchandisingDashboards", mainCondition);
            DataTable lstGeneralComplaints = ObjclsFrms.loadList("SelectGeneralComplaintsCount", "sp_MerchandisingDashboards", mainCondition);
            DataTable lstProductComplaints = ObjclsFrms.loadList("SelectProductComplaintsCounts", "sp_MerchandisingDashboards", mainCondition);
            DataTable lstImageCapture = ObjclsFrms.loadList("SelectImageCaptureCount", "sp_MerchandisingDashboards", mainCondition);
            lblItemPricing.Text = lstItemPricing.Rows[0]["number"].ToString();
            lblCompetitorActivities.Text = lstCompetitorActivities.Rows[0]["number"].ToString();
            lblCustomerInventory.Text = lstCustomerInventory.Rows[0]["number"].ToString();
            lblProductComplaints.Text = lstProductComplaints.Rows[0]["number"].ToString();
            lblGeneralComplaints.Text = lstGeneralComplaints.Rows[0]["number"].ToString();
            lblImageCapture.Text = lstImageCapture.Rows[0]["number"].ToString();
        }

        protected void lnkRepondedRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListNewRequests.aspx?mode=1&type=RR");
        }

        protected void lnkNewRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListNewRequests.aspx?mode=1&type=NR");
        }

        protected void lnkCompletedCusAct_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivitys.aspx?mode=1&type=CC");
        }

        protected void lnkOpenCusAct_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivitys.aspx?mode=1&type=OP");
        }

        public void CustomerActivities(string route)
        {

            string mainCondition = mainConditions(route);
            DataTable lstOpenCusAct = ObjclsFrms.loadList("SelectCustomerActivityCount", "sp_MerchandisingDashboards", mainCondition + " and E.Status='N'");
            DataTable lstCompletedCusAct = ObjclsFrms.loadList("SelectCustomerActivityCount", "sp_MerchandisingDashboards", mainCondition + " and E.Status='Y'");
            //DataTable lstCusActPerformed = ObjclsFrms.loadList("SelectCustomerActivityCount", "sp_MerchandisingDashboards", mainCondition);
            lblOpenCusAct.Text = lstOpenCusAct.Rows[0]["number"].ToString();
            lblCompletedCusAct.Text = lstCompletedCusAct.Rows[0]["number"].ToString();
            //lblCusActPerformed.Text = lstCusActPerformed.Rows[0]["number"].ToString();
        }
        public void Requests(string route)
        {
            string mainCondition = mainConditions(route);
            DataTable lstNewRequest = ObjclsFrms.loadList("SelectNewRequestCount", "sp_MerchandisingDashboards", mainCondition + " and A.Status = 'Open'");
            DataTable lstRepondedRequest = ObjclsFrms.loadList("SelectNewRequestCount", "sp_MerchandisingDashboards", mainCondition + " and A.Status = 'Responded'");
            //DataTable lstReqPerformed = ObjclsFrms.loadList("SelectNewRequestCount", "sp_MerchandisingDashboards", mainCondition);
            lblNewRequest.Text = lstNewRequest.Rows[0]["number"].ToString();
            lblRepondedRequest.Text = lstRepondedRequest.Rows[0]["number"].ToString();
            //lblReqPerformed.Text = lstReqPerformed.Rows[0]["number"].ToString();
        }

        protected void lnkGeneralComplaints_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListGeneralComplaintss.aspx?mode=1");
        }
    }
}