using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class TodaysServiceJobs : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {


                    if ((Session["KPIDate"] != null) && (Session["KPIRoute"] != null))
                    {
                        string rotId= Session["KPIRoute"].ToString();
                        string date = Session["KPIDate"].ToString();
                        SelAllJobs(rotId,date);
                        SelOpenJobs(rotId, date);
                        SelATJobs(rotId, date);
                        SelRSJobs(rotId, date);
                        SelTodaysJobcount(rotId, date);
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
       
        
        public DataTable LoadData(string mode,string rotID,string date)
        {



            string[] arr = { date };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_RouteFieldServiceDashboard",rotID,arr);
            return dt;



        }
        

        public void SelAllJobs(string rotID,string date)
        {

            DataTable dt = LoadData("SelectAllTodayJob","","");
            if (dt.Rows.Count >= 0)
            {
                grvTodaysJob.DataSource = dt;
            }



        }

        public void SelOpenJobs(string rotID, string date)
        {
            DataTable dt = LoadData("SelectOPTodayJob", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvTodayOpen.DataSource = dt;
            }


        }
        public void SelATJobs(string rotID, string date)
        {

            DataTable dt = LoadData("SelectATTodayJob", rotID,date);
            if (dt.Rows.Count >= 0)
            {
                grvTodayActionTaken.DataSource = dt;
            }


        }
        public void SelRSJobs(string rotID, string date)
        {
            DataTable dt = LoadData("SelectRSTodayJob", rotID, date);
            if (dt.Rows.Count >= 0)
            {
                grvTodayResolved.DataSource = dt;
            }


        }
        public void SelTodaysJobcount(string rotID, string date)
        {
            DataTable dt = LoadData("SelTodaysServiceJobCounts", rotID, date);
            if (dt.Rows.Count > 0)
            {
                string TotalServiceJob = dt.Rows[0]["TotalJobs"].ToString();
                string Opencount = dt.Rows[0]["OpenJobs"].ToString();
                string ActionTaken = dt.Rows[0]["ActionTaken"].ToString();
                string Resolved = dt.Rows[0]["Resolved"].ToString();
                
                lblAllCount.Text = TotalServiceJob;
                lblOpenCount.Text = Opencount;
                lblATCount.Text = ActionTaken;
                lblRSCount.Text = Resolved;
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
                        string rotId= Session["KPIRoute"].ToString();
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
                    SelRSJobs(rotId, date);
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
    }
}