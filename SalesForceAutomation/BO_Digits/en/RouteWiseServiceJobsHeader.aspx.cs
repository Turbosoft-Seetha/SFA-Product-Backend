using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteWiseServiceJobsHeader : System.Web.UI.Page
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
                try
                {

                    if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                    {
                        string rotId = Session["KPIRoute"].ToString();
                        string date = Session["KPIDate"].ToString();
                        string[] dateParts = date.Split(' ');
                        DataTable dt = ObjclsFrms.loadList("RouteName", "sp_RouteFieldServiceDashboard", rotId);
                        lbldate.Text =  dateParts[0];
                        lblroute.Text = dt.Rows[0]["Route"].ToString();

                        if (ResponseType.Equals("P"))
                        {

                            pnlPlanned.Visible = true;
                            pnlplannedGrids.Visible = true;
                            pnlActualGrids.Visible = false;
                            pnlActual.Visible = false;
                            SelAllJobs(rotId, date);
                            SelOpenJobs(rotId, date);
                            SelATJobs(rotId, date);
                            SelTodaysJobcount(rotId, date);
                        }
                        else
                        {

                            
                            pnlPlanned.Visible = false;
                            pnlplannedGrids.Visible = false;
                            pnlActualGrids.Visible = true;
                            pnlActual.Visible = true;
                            SelAllVisited(rotId, date);
                            SelAllVisitedCount(rotId, date);
                            SelPlanned(rotId, date);
                            Selunplanned(rotId,date);
                        }
                        

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
        }


        public DataTable LoadData(string mode, string rotID, string date)
        {



            string[] arr = { date };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_RouteFieldServiceDashboard", rotID, arr);
            return dt;



        }


        public void SelAllJobs(string rotID, string date) //AllPlanned
        {

            DataTable dt = LoadData("SelectAllTodayJob", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvTodaysJob.DataSource = dt;
                //grvTodaysJob.Rebind();
            }



        }

        public void SelOpenJobs(string rotID, string date) //Pending
        {
            DataTable dt = LoadData("SelectOPTodayJob", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvTodayOpen.DataSource = dt;
               //// grvTodayOpen.Rebind();
            }


        }
        public void SelATJobs(string rotID, string date) //Visited
        {

            DataTable dt = LoadData("SelectATTodayJob", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvTodayActionTaken.DataSource = dt;
                //grvTodayActionTaken.Rebind();
            }


        }
        
        public void SelTodaysJobcount(string rotID, string date) //PlannedCount
        {
            DataTable dt = LoadData("SelTotPlanned", rotID, date);
            if (dt.Rows.Count > 0)
            {
                string TotalServiceJob = dt.Rows[0]["totPlanned"].ToString();
                string Opencount = dt.Rows[0]["Pending"].ToString();
                string ActionTaken = dt.Rows[0]["Visited"].ToString();

                lblAllCount.Text = TotalServiceJob;
                lblOpenCount.Text = Opencount;
                lblATCount.Text = ActionTaken;
                
            }

        }
        public void SelAllVisitedCount(string rotID, string date) //AllVisitedCount
        {
            DataTable dt = LoadData("SelAllVisited", rotID, date);
            if (dt.Rows.Count > 0)
            {
                string TotalServiceJob = dt.Rows[0]["totvisited"].ToString();
                string Opencount = dt.Rows[0]["Planned"].ToString();
                string ActionTaken = dt.Rows[0]["unplanned"].ToString();

                lblAllVisited.Text = TotalServiceJob;
                lblPlannedCount.Text = Opencount;
                lblUnplanned.Text = ActionTaken;

            }

        }
        public void SelAllVisited(string rotID, string date) //AllVisited
        {

            DataTable dt = LoadData("SelectAllVisitedData", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvTotalPlanned.DataSource = dt;
                //grvTotalPlanned.Rebind();
            }


        }
        public void SelPlanned(string rotID, string date) //Planned
        {

            DataTable dt = LoadData("SelectPlanned", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvPlanned.DataSource = dt;
                //grvPlanned.Rebind();
            }


        }
        public void Selunplanned(string rotID, string date) //unplanned
        {
            DataTable dt = LoadData("SelectUnplanned", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvUnplanned.DataSource = dt;
                //grvUnplanned.Rebind();
            }

        }


        protected void grvTodaysJob_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {


                if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                {
                    string rotId = Session["KPIRoute"].ToString();
                    string date = Session["KPIDate"].ToString();
                    SelAllJobs(rotId, date);
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

        protected void grvTodaysJob_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("TodaysServiceJobDetail.aspx?id=" + id);
            }
        }

        protected void grvTodayOpen_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {


                if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                {
                    string rotId = Session["KPIRoute"].ToString();
                    string date = Session["KPIDate"].ToString();
                    SelOpenJobs(rotId, date);
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

        protected void grvTodayOpen_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("TodaysServiceJobDetail.aspx?id=" + id);
            }
        }

        protected void grvTodayActionTaken_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {


                if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                {
                    string rotId = Session["KPIRoute"].ToString();
                    string date = Session["KPIDate"].ToString();
                    SelATJobs(rotId, date);
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

        protected void grvTodayActionTaken_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("TodaysServiceJobDetail.aspx?id=" + id);
            }
        }

        protected void grvTodayResolved_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {


                if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                {
                    string rotId = Session["KPIRoute"].ToString();
                    string date = Session["KPIDate"].ToString();
                    SelAllVisited(rotId, date);
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

        protected void grvTodayResolved_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("TodaysServiceJobDetail.aspx?id=" + id);
            }
        }

        protected void grvTodaysJob_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                ImageButton DelBtn = (ImageButton)item.FindControl("RadDetail");

                string status = item["Status"].Text.ToString();
                //if (status == "Open")
                //{
                //    DelBtn.Visible = false;

                //}
                //else
                //{
                //    DelBtn.Visible = true;

                //}
            }

        }

        protected void grvTodayOpen_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                ImageButton DelBtn = (ImageButton)item.FindControl("RadDetail1");

                string status = item["Status"].Text.ToString();
              
            }
        }

        protected void grvTotalPlanned_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {


                if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                {
                    string rotId = Session["KPIRoute"].ToString();
                    string date = Session["KPIDate"].ToString();
                    SelAllVisited(rotId, date);
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

        protected void grvTotalPlanned_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("TodaysServiceJobDetail.aspx?id=" + id);
            }
        }

        protected void grvPlanned_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {


                if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                {
                    string rotId = Session["KPIRoute"].ToString();
                    string date = Session["KPIDate"].ToString();
                    SelPlanned(rotId, date);
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

        protected void grvPlanned_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("TodaysServiceJobDetail.aspx?id=" + id);
            }
        }

        protected void grvUnplanned_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {


                if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                {
                    string rotId = Session["KPIRoute"].ToString();
                    string date = Session["KPIDate"].ToString();
                    Selunplanned(rotId, date);
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

        protected void grvUnplanned_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();
                Response.Redirect("TodaysServiceJobDetail.aspx?id=" + id);
            }
        }
    }
}