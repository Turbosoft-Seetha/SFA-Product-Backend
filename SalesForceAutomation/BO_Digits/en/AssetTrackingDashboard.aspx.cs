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
    public partial class AssetTrackingDashboard : System.Web.UI.Page
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
                   
                    fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                    Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                    Session["ToDate"] = rdfromDate.SelectedDate.ToString();
                   
                    Session["Route"] = "rcs_rot_ID";
                    TimeLineStripe(fromDate);
                    AssetTrackingCount(fromDate);
                    AssetAddingRequest();
                  
                    
                    AssetRemovalRequest();
                   
                    
                 
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
               
                Session["Route"] = "rcs_rot_ID";
                TimeLineStripe(fromDate);
                AssetTrackingCount(fromDate);
                AssetAddingRequest();
             
               
                AssetRemovalRequest();
               
              
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

            }
            catch (Exception ex)
            {

            }
        }

        public void TimeLineStripe(string fromDate)
        {
            //pnlTimeline.Visible = true;
            DataTable lstActive = ObjclsFrms.loadList("SelectServiceRouteCount", "sp_ServiceDashboard", fromDate);
            int active = Int32.Parse(lstActive.Rows[0]["allRoute"].ToString());
            //lblActiveRoute.Text = active.ToString();
            DataTable lstProductive = ObjclsFrms.loadList("SelectActiveServiceRouteCount", "sp_ServiceDashboard", fromDate);
            int productive = Int32.Parse(lstProductive.Rows[0]["activeRoute"].ToString());
            //lblProductiveRoute.Text = productive.ToString();
            int nonprod = active - productive;
            //lblNonProductiveRoute.Text = nonprod.ToString();
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

        protected void lnkOpenServiceJob_Click(object sender, EventArgs e)
        {
            Response.Redirect("FieldServiceHeader.aspx?mode=8");
        }

        protected void lnkServiceRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceRequestHeader.aspx");
        }

        protected void lnkAssetRemovalRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetRemoveReqApproval.aspx");
        }

        protected void lnkTodayServiceJob_Click(object sender, EventArgs e)
        {
            Response.Redirect("TodaysServiceJobs.aspx");
        }

        public void AssetTrackingCount(string fromDate)
        {
            try
            {
                DataTable lstAssetTracking = ObjclsFrms.loadList("SelectTotalAssetCount", "sp_ServiceDashboard", fromDate);
                string AllAsset = lstAssetTracking.Rows[0]["AllAssetCount"].ToString();
                string NotAssignedAsset = lstAssetTracking.Rows[0]["AllUnAssignedAssetCount"].ToString();
                string TotalAssets = lstAssetTracking.Rows[0]["TotalAssetsCount"].ToString();
                string TotalAssetCustomer = lstAssetTracking.Rows[0]["TotalCustomerCount"].ToString();
                string Visited = lstAssetTracking.Rows[0]["TotalVisited"].ToString();
                string VisitedCustomer = lstAssetTracking.Rows[0]["TotalVisitedCustomer"].ToString();
                string Tracked = lstAssetTracking.Rows[0]["Tracked"].ToString();
                string TrackedRemovalReq = lstAssetTracking.Rows[0]["TrackedRemovalReq"].ToString();
                string NotTracked = lstAssetTracking.Rows[0]["NotTracked"].ToString();
                string NotTrackedRemovalReq = lstAssetTracking.Rows[0]["NotTrackedRemovalReq"].ToString();

                lblAllAssetCount.Text = AllAsset.ToString();
                lblNotAssigned.Text = NotAssignedAsset.ToString();
                lblTotalAsset.Text = TotalAssets.ToString();
                lblTotalAssetCustomer.Text = TotalAssetCustomer.ToString();
                lblVisited.Text = Visited.ToString();
                lblVisitedCustomer.Text = VisitedCustomer.ToString();
                lblTracked.Text = Tracked.ToString();
                lblTrackedRemovalReq.Text = TrackedRemovalReq.ToString();
                lblNotTracked.Text = NotTracked.ToString();
                lblNotTrackedRemovalReq.Text = NotTrackedRemovalReq.ToString();
            }
            catch (Exception ex)
            {

            }
        }

        public void AssetAddingRequest()
        {
            try
            {
                DataTable lstAssetAdding = ObjclsFrms.loadList("SelectAssetAddingRequestCount", "sp_ServiceDashboard");
                string AssetsAddingReq = lstAssetAdding.Rows[0]["number"].ToString();
                lblAssetAddingRequest.Text = AssetsAddingReq.ToString();
            }
            catch (Exception ex)
            {

            }
        }

      

      

        public void AssetRemovalRequest()
        {
            try
            {
                DataTable lstAssetRemoval = ObjclsFrms.loadList("SelectAssetRemovingRequestCount", "sp_ServiceDashboard");
                string AssetsRemovalReq = lstAssetRemoval.Rows[0]["number"].ToString();
                lblAssetRemovalRequest.Text = AssetsRemovalReq.ToString();
            }
            catch (Exception ex)
            {

            }
        }

      

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
           
          
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
    }
}