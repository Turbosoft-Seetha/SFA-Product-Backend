using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ServiceDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ViewState["Chart"] = null;
                    string fromDate;
                    rdfromDate.SelectedDate = DateTime.Now;
                    rdfromDate.MaxDate = DateTime.Now;
                    ddlFromdate.SelectedDate = DateTime.Now;
                    ddlFromdate.MaxDate = DateTime.Now;
                    ddlTodate.SelectedDate = DateTime.Now;
                    ddlTodate.MaxDate = DateTime.Now;
                    fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    
                    Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                    Session["ToDate"] = rdfromDate.SelectedDate.ToString();
                    Session["StartDate"] = ddlFromdate.SelectedDate.ToString();
                    Session["EndDate"] = ddlTodate.SelectedDate.ToString();
                    Session["Route"] = "rcs_rot_ID";
                    TimeLineStripe(fromDate);
                    
                    ServiceRequestCount();
                    OpenServiceJobs();
                 
                    TodaysServiceJob();
                    CompletedAndInvoicedJobCount();
                    ServiceRequestAgainstAssetType();
                    ServiceDoneAgainstComplaintType();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

                }
                catch (Exception ex)
                {

                }
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                ViewState["Chart"] = null;
                string fromDate, toDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                toDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdfromDate.SelectedDate.ToString();
                Session["StartDate"] = ddlFromdate.SelectedDate.ToString();
                Session["EndDate"] = ddlTodate.SelectedDate.ToString();
                Session["Route"] = "rcs_rot_ID";
                TimeLineStripe(fromDate);
               
                ServiceRequestCount();
                OpenServiceJobs();
               
                TodaysServiceJob();
                ServiceRequestAgainstAssetType();
                ServiceDoneAgainstComplaintType();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            }
            catch (Exception ex)
            {

            }
        }

        public void TimeLineStripe(string fromDate)
        {
            pnlTimeline.Visible = true;
            DataTable lstActive = ObjclsFrms.loadList("SelectServiceRouteCount", "sp_ServiceDashboard", fromDate);
            int active = Int32.Parse(lstActive.Rows[0]["allRoute"].ToString());
            lblActiveRoute.Text = active.ToString();
            DataTable lstProductive = ObjclsFrms.loadList("SelectActiveServiceRouteCount", "sp_ServiceDashboard", fromDate);
            int productive = Int32.Parse(lstProductive.Rows[0]["activeRoute"].ToString());
            lblProductiveRoute.Text = productive.ToString();
            int nonprod = active - productive;
            lblNonProductiveRoute.Text = nonprod.ToString();
        }

        protected void lnkProductive_Click(object sender, EventArgs e)
        {
            Response.Redirect("FieldServiceHeader.aspx?mode=11");
        }

        protected void lnkMap_Click(object sender, EventArgs e)
        {
            string fromDate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
            string url = ConfigurationManager.AppSettings.Get("TrackingUrl");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "openlink", "window.open('" + url + "&&date=" + fromDate + "');", true);
        }

        protected void lnkTotalAsset_Click(object sender, EventArgs e)
        {
            Response.Redirect("FieldServiceHeader.aspx?mode=2");
        }

        protected void lnkVisited_Click(object sender, EventArgs e)
        {
            Response.Redirect("FieldServiceHeader.aspx?mode=3");
        }

        protected void lnkTracked_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerAssetTracking.aspx?mode=1");
        }

        protected void lnkAssetTypes_Click(object sender, EventArgs e)
        {
            Response.Redirect("FieldServiceHeader.aspx?mode=1");
        }

        protected void lnkAssetAddingRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetAddReqApproval.aspx");
        }

        public static void OpenNewBrowserWindow(string Url, System.Web.UI.Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void lnkOpenServiceJob_Click(object sender, EventArgs e)
        {
            string User = UICommon.GetCurrentUserID().ToString();
            string url = ConfigurationManager.AppSettings.Get("ServiceJobAssign");
            OpenNewBrowserWindow(url + User, this);
           // Response.Redirect("FieldServiceHeader.aspx?mode=8");
        }

        protected void lnkServiceRequest_Click(object sender, EventArgs e)
        {

            Response.Redirect("ServiceRequestHeader.aspx?mode=1");
        }

        protected void lnkAssetRemovalRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetRemoveReqApproval.aspx");
        }

        protected void lnkTodayServiceJob_Click(object sender, EventArgs e)
        {
            Response.Redirect("TodaysServiceJobs.aspx");
        }

       

      

        public void ServiceRequestCount()
        {
            try
            {
                DataTable lstServiceRequest = ObjclsFrms.loadList("SelectServiceRequestCount", "sp_ServiceDashboard");
                string TotalServiceReq = lstServiceRequest.Rows[0]["TotalServiceRequest"].ToString();
                string Created = lstServiceRequest.Rows[0]["CreatedServiceRequest"].ToString();
                string ActionTaken = lstServiceRequest.Rows[0]["ActionTakenServiceRequest"].ToString();

                lblServiceRequest.Text = TotalServiceReq.ToString();
                lblCreated.Text = Created.ToString();
                lblActionTaken.Text = ActionTaken.ToString();
            }
            catch (Exception ex)
            {

            }
        }

        public void OpenServiceJobs()
        {
            try
            {
                DataTable lstOpenServiceJob = ObjclsFrms.loadList("SelectOpenServiceJobsCount", "sp_ServiceDashboard");
                string openServiceJob = lstOpenServiceJob.Rows[0]["number"].ToString();
                lblOpenServiceJobs.Text = openServiceJob.ToString();
            }
            catch (Exception ex)
            {

            }
        }

     

        public void TodaysServiceJob()
        {
            try
            {
                DataTable lstTodayServiceJob = ObjclsFrms.loadList("SelectTodaysServiceJobCount", "sp_ServiceDashboard");
                string TotalServiceJob = lstTodayServiceJob.Rows[0]["TotalJobs"].ToString();
                string PlannedAttended = lstTodayServiceJob.Rows[0]["PlannedAttended"].ToString();
                string UnplannedAttended = lstTodayServiceJob.Rows[0]["UnplannedAttended"].ToString();
                string ActionTaken = lstTodayServiceJob.Rows[0]["ActionTaken"].ToString();
                string Resolved = lstTodayServiceJob.Rows[0]["Resolved"].ToString();
                string PlannedPending = lstTodayServiceJob.Rows[0]["PlannedPending"].ToString();
                string InvoicedNo = lstTodayServiceJob.Rows[0]["InvoicedNumber"].ToString();
                string InvoicedAmount = lstTodayServiceJob.Rows[0]["InvoicedAmount"].ToString();

                lblTodaysServiceJobs.Text = TotalServiceJob.ToString();
                lblPlannedAttended.Text = PlannedAttended.ToString();
                lblUnplannedAttended.Text = UnplannedAttended.ToString();
                lblActionTakenServiceJob.Text = ActionTaken.ToString();
                lblResolved.Text = Resolved.ToString();
                lblPlannedPending.Text = PlannedPending.ToString();
                lblInvoiced.Text = InvoicedNo.ToString();
                lblAmount.Text = ConfigurationManager.AppSettings.Get("Currency") + " " + InvoicedAmount.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void CompletedAndInvoicedJobCount()
        {
            try
            {
               string  fromDate = DateTime.Parse(ddlFromdate.SelectedDate.ToString()).ToString("yyyyMMdd");
               string  toDate = DateTime.Parse(ddlTodate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string[] ar = { toDate.ToString() };
                DataTable lstServiceRequest = ObjclsFrms.loadList("SelectCompletedAndInvoicedJobCount", "sp_ServiceDashboard",fromDate,ar);
                string TotalCompletedJob= lstServiceRequest.Rows[0]["TotalCompletedJobs"].ToString();
                string InvoicedJob = lstServiceRequest.Rows[0]["TotalInvoicedJobs"].ToString();
               

                lblCompletedJobCount.Text = TotalCompletedJob.ToString();
                lblInvoicedJobCount.Text = InvoicedJob.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void ServiceRequestAgainstAssetType()
        {
            string fromDate = DateTime.Parse(ddlFromdate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(ddlTodate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] args = { ToDate };
            DataTable dtServiceRequestAgainstAssetType = new DataTable();
            dtServiceRequestAgainstAssetType = ObjclsFrms.loadList("SelServiceRequestAgainstAssetType", "sp_ServiceDashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtServiceRequestAgainstAssetType.Rows.Count; i++)
            {
                if (i < dtServiceRequestAgainstAssetType.Rows.Count - 1)
                {
                    XAxis += dtServiceRequestAgainstAssetType.Rows[i]["Code"].ToString() + ";";
                    YAxis += dtServiceRequestAgainstAssetType.Rows[i]["Quantity"].ToString() + "-";
                    name += dtServiceRequestAgainstAssetType.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtServiceRequestAgainstAssetType.Rows.Count - 1)
                {
                    XAxis += dtServiceRequestAgainstAssetType.Rows[i]["Code"].ToString();
                    YAxis += dtServiceRequestAgainstAssetType.Rows[i]["Quantity"].ToString();
                    name += dtServiceRequestAgainstAssetType.Rows[i]["Name"].ToString();
                }
            }

            string ServiceAgainstAssetTypeChart = "ApplyHorrBarChartServiceAssetType('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "', '" + name.ToString() + "');";
            ViewState["Chart"] += ServiceAgainstAssetTypeChart;
        }

        public void ServiceDoneAgainstComplaintType()
        {
            string fromDate = DateTime.Parse(ddlFromdate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(ddlTodate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] args = {  ToDate };
            DataTable dtTopSellingItem = new DataTable();
            dtTopSellingItem = ObjclsFrms.loadList("SelServiceRequestCountbyComplaintType", "sp_ServiceDashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtTopSellingItem.Rows.Count; i++)
            {
                if (i < dtTopSellingItem.Rows.Count - 1)
                {
                    XAxis += dtTopSellingItem.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtTopSellingItem.Rows[i]["value_occurrence"].ToString() + "-";
                    name += dtTopSellingItem.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtTopSellingItem.Rows.Count - 1)
                {
                    XAxis += dtTopSellingItem.Rows[i]["Code"].ToString();
                    YAxis += dtTopSellingItem.Rows[i]["value_occurrence"].ToString();
                    name += dtTopSellingItem.Rows[i]["Name"].ToString();
                }
            }
            string ItemBarChart = "ApplyVertBarChartComplaintTypes('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + name.ToString() + "');";
            ViewState["Chart"] += ItemBarChart;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            Session["StartDate"] = ddlFromdate.SelectedDate.ToString();
            Session["EndDate"] = ddlTodate.SelectedDate.ToString();
            CompletedAndInvoicedJobCount();
            ServiceRequestAgainstAssetType();
            ServiceDoneAgainstComplaintType();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

        }

        protected void lnkServiceReq_Click(object sender, EventArgs e)
        {
            Response.Redirect("AllServiceJobs.aspx?mode=1");
        }

        protected void InvServiceJob_Click(object sender, EventArgs e)
        {

            Response.Redirect("ListServiceReqWithInvoice.aspx?mode=1");
        }

       

        protected void ddlTodate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (ddlFromdate.SelectedDate != null && ddlTodate.SelectedDate != null)
            {

                TimeSpan difference = ddlTodate.SelectedDate.Value - ddlFromdate.SelectedDate.Value;
                DateTime startdate = ddlTodate.SelectedDate.Value.AddDays(-31);

                if (difference.Days > 31)
                {

                    ddlFromdate.SelectedDate = startdate;

                }
                else
                {
                    ddlFromdate.MaxDate = DateTime.Today;
                }
            }
        }
        protected void ddlFromdate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (ddlFromdate.SelectedDate != null && ddlTodate.SelectedDate != null)
            {

                TimeSpan difference = ddlTodate.SelectedDate.Value - ddlFromdate.SelectedDate.Value;
                DateTime endDate = ddlFromdate.SelectedDate.Value.AddDays(31);

                if (difference.Days > 31)
                {
                    ddlTodate.MaxDate = DateTime.Today;
                    ddlTodate.SelectedDate = endDate;

                }
                else
                {
                    ddlTodate.MaxDate = DateTime.Today;
                }
            }
        }
    }
}