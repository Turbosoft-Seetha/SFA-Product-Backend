using SalesForceAutomation.Admin;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class FieldServiceHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["mode"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    string fromDate;
                    fromDate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");

                    if (ResponseID == 1)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = true;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListAllAssets();
                    }
                    else if (ResponseID == 2)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = true;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListAssigned();
                    }
                    else if (ResponseID == 3)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = true;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListVisited(fromDate);
                    }
                    else if (ResponseID == 4)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = true;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListTracked(fromDate);
                    }
                    else if (ResponseID == 5)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = true;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListNotTracked(fromDate);
                    }
                    else if (ResponseID == 6)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = true;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListAssetAdding();
                    }
                    else if (ResponseID == 7)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = true;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListServiceRequest();
                    }
                    else if (ResponseID == 8)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = true;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListOpenServiceJobs();
                    }
                    else if (ResponseID == 9)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = true;
                        pnlTodaysJob.Visible = false;
                        ListAssetRemoval();
                    }
                    else if (ResponseID == 10)
                    {
                        pnlActiveServiceRoute.Visible = false;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = true;
                        ListTodaysJob();
                    }
                    else if (ResponseID == 11)
                    {
                        pnlActiveServiceRoute.Visible = true;
                        pnlAllAsset.Visible = false;
                        pnlAssigned.Visible = false;
                        pnlVisited.Visible = false;
                        pnlTracked.Visible = false;
                        pnlNotTracked.Visible = false;
                        pnlAssetAdding.Visible = false;
                        pnlServiceRequest.Visible = false;
                        pnlOpenServiceJobs.Visible = false;
                        pnlAssetRemoval.Visible = false;
                        pnlTodaysJob.Visible = false;
                        ListActiveServiceRoute(fromDate);
                    }
                }
                catch (Exception ex)
                {

                }
            }
        }

        protected void grvActiveRoute_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListActiveServiceRoute(string fromDate)
        {
            try
            {
                DataTable lstActiveRoute = ObjclsFrms.loadList("SelectActiveServiceRoutes", "sp_ServiceDashboard", fromDate);
                grvActiveRoute.DataSource = lstActiveRoute;
                grvActiveRoute.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvAllAsset_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListAllAssets()
        {
            try
            {
                DataTable lstAllAssets = ObjclsFrms.loadList("SelectAllAsset", "sp_ServiceDashboard");
                grvAllAsset.DataSource = lstAllAssets;
                grvAllAsset.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvAssigned_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListAssigned()
        {
            try
            {
                DataTable lstAssigned = ObjclsFrms.loadList("SelectTotalCustomerAsset", "sp_ServiceDashboard");
                grvAssigned.DataSource = lstAssigned;
                grvAssigned.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvVisited_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListVisited(string fromDate)
        {
            try
            {
                DataTable lstVisited = ObjclsFrms.loadList("SelectVisitedAsset", "sp_ServiceDashboard", fromDate);
                grvVisited.DataSource = lstVisited;
                grvVisited.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvTracked_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListTracked(string fromDate)
        {
            try
            {
                DataTable lstTracked = ObjclsFrms.loadList("SelectTrackedAsset", "sp_ServiceDashboard", fromDate);
                grvTracked.DataSource = lstTracked;
                grvTracked.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvNotTracked_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListNotTracked(string fromDate)
        {
            try
            {
                DataTable lstNotTracked = ObjclsFrms.loadList("SelectNotTrackedAsset", "sp_ServiceDashboard", fromDate);
                grvNotTracked.DataSource = lstNotTracked;
                grvNotTracked.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvAssetAdding_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListAssetAdding()
        {
            try
            {
                DataTable lstAssetsAdding = ObjclsFrms.loadList("SelectAssetAddingReq", "sp_ServiceDashboard");
                grvAssetAdding.DataSource = lstAssetsAdding;
                grvAssetAdding.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvServiceRequest_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListServiceRequest()
        {
            try
            {
                DataTable lstServiceRequest = ObjclsFrms.loadList("SelectTotalServiceRequest", "sp_ServiceDashboard");
                grvServiceRequest.DataSource = lstServiceRequest;
                grvServiceRequest.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvOpenServiceJobs_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListOpenServiceJobs()
        {
            try
            {
                DataTable lstOpenServiceJobs = ObjclsFrms.loadList("SelectOpenServiceJobs", "sp_ServiceDashboard");
                grvOpenServiceJobs.DataSource = lstOpenServiceJobs;
                grvOpenServiceJobs.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvAssetRemoval_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListAssetRemoval()
        {
            try
            {
                DataTable lstAssetRemoval = ObjclsFrms.loadList("SelectAssetRemovalReq", "sp_ServiceDashboard");
                grvAssetRemoval.DataSource = lstAssetRemoval;
                grvAssetRemoval.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvTodaysJob_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        public void ListTodaysJob()
        {
            try
            {
                DataTable lstTodaysJob = ObjclsFrms.loadList("SelectTodayTotalServiceJob", "sp_ServiceDashboard");
                grvTodaysJob.DataSource = lstTodaysJob;
                grvTodaysJob.DataBind();

                DataTable lstPlannedAttended = ObjclsFrms.loadList("SelectTodayPlannedAttdServiceJob", "sp_ServiceDashboard");
                grvPlannedAttended.DataSource = lstPlannedAttended;
                grvPlannedAttended.DataBind();

                DataTable lstUnplannedAttended = ObjclsFrms.loadList("SelectTodayUnPlannedAttdServiceJob", "sp_ServiceDashboard");
                grvUnPlannedAttended.DataSource = lstUnplannedAttended;
                grvUnPlannedAttended.DataBind();

                DataTable lstSerReqActionTaken = ObjclsFrms.loadList("SelectTodayActionTakenServiceJob", "sp_ServiceDashboard");
                grvTodayActionTaken.DataSource = lstSerReqActionTaken;
                grvTodayActionTaken.DataBind();

                DataTable lstResolved = ObjclsFrms.loadList("SelectTodayResolvedServiceJob", "sp_ServiceDashboard");
                grvResolved.DataSource = lstResolved;
                grvResolved.DataBind();

                DataTable lstPlannedPending = ObjclsFrms.loadList("SelectTodayPlannedPendServiceJob", "sp_ServiceDashboard");
                grvPlannedPending.DataSource = lstPlannedPending;
                grvPlannedPending.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void grvCreated_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvSerReqActionTaken_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvPlannedAttended_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvUnPlannedAttended_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvTodayActionTaken_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvResolved_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvPlannedPending_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvTodaysJob_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("FieldServiceDetail.aspx?id=" + id);
            }
        }

        protected void grvPlannedAttended_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("FieldServiceDetail.aspx?id=" + id);
            }
        }

        protected void grvUnPlannedAttended_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("FieldServiceDetail.aspx?id=" + id);
            }
        }

        protected void grvTodayActionTaken_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("FieldServiceDetail.aspx?id=" + id);
            }
        }

        protected void grvResolved_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("FieldServiceDetail.aspx?id=" + id);
            }
        }

        protected void grvPlannedPending_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("FieldServiceDetail.aspx?id=" + id);
            }
        }

        protected void grvServiceRequest_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("snr_ID").ToString();
                Response.Redirect("FieldServiceDetail.aspx?id=" + id);
            }
        }

    }
}