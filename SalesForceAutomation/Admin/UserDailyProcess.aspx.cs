using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class UserDailyProcess : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public string Mode
        {
            get
            {
                string Mode;
                if (Request.Params["Type"] == null)
                {
                    Mode = "";
                }
                else
                {
                    Mode = Request.Params["Type"].ToString();
                }
                

                return Mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string rotID, routeCondition; 
                if (Mode.Equals("tml"))
                {
                    //fromDate.MinDate = DateTime.Now;
                    //toDate.MinDate = DateTime.Now;
                    fromDate.SelectedDate = DateTime.Parse(Session["FrmDat"].ToString());
                    toDate.SelectedDate = DateTime.Parse(Session["ToDat"].ToString());
                    //fromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("01-MM-yyyy"));
                    //toDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("dd-MM-yyyy"));
                    //toDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1);
                    Employee();
                    RouteFromTransaction();
                    rotID = Rot();
                    routeCondition = "udp_rot_ID in (" + rotID + ")";
                }
                else
                {
                    //fromDate.MinDate = DateTime.Now;
                    //toDate.MinDate = DateTime.Now;
                    fromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    toDate.SelectedDate = DateTime.Now;
                    //fromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("01-MM-yyyy"));
                    //toDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("dd-MM-yyyy"));
                    //toDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1);
                    Employee();
                    RouteFromTransaction();
                    rotID = Rot();
                    routeCondition = "udp_rot_ID in (" + rotID + ")";
                }
                
            }
        }
        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in ddlEmployee.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public string Rot()
        {
            var ColelctionMarket = ddlEmployee.CheckedItems;
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

        public void Employee()
        {
            ddlEmployee.DataSource = ObjclsFrms.loadList("SelectRouteForDropDown", "sp_Merchandising");
            ddlEmployee.DataTextField = "rot_Name";
            ddlEmployee.DataValueField = "rot_ID";
            ddlEmployee.DataBind();
        }

        public string mainConditions(string rotID)
        {
            
           
            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromdate = DateTime.Parse(fromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(toDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromdate + "' as date) and cast('" + endDate + "' as date))";
                


            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
           
            return mainCondition;
        }

        public void LoadList()
        {

            //if (fromDate.SelectedDate == null)
            //{
            //    //fromdate = fromDate.DateTime.Now;
            //    fromdate = DateTime.Parse(fromDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            //}
            //else
            //{
            //    fromdate = DateTime.Parse(fromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            //}
            //if (toDate.SelectedDate == null)
            //{
            //    //todate = toDate.SelectedDate.ToString();
            //    todate = DateTime.Parse(toDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            //}
            //else
            //{
            //    todate = DateTime.Parse(toDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            //}

            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("SelectUserDailyProcess", "sp_Merchandising", mainCondition.ToString());
                grvRpt.DataSource = lstUser;
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                Response.Redirect("UserDailyProcessDetail.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("map"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                //string id = dataItem.GetDataKeyValue("udp_ID").ToString();
                string id = "232";

                //    DataTable lstUser = default(DataTable);
                //    lstUser = ObjclsFrms.loadList("SelUserPath", "sp_Report", id);
                //    string geoCodes = "", cusNames = "", DtFormat = "", type = "";
                //    int i = 0;
                //    foreach (DataRow dr in lstUser.Rows)
                //    {
                //        if (i < lstUser.Rows.Count - 1)
                //        {
                //            geoCodes += dr[3].ToString() + "-";
                //            cusNames += dr[4].ToString() + "{0}";
                //            DtFormat += dr[5].ToString() + "{0}";
                //            type += dr[0].ToString() + "{0}";
                //        }
                //        else
                //        {
                //            geoCodes += dr[3].ToString();
                //            cusNames += dr[4].ToString();
                //            DtFormat += dr[5].ToString();
                //            type += dr[0].ToString();
                //        }

                //        i++;

                //    }
                //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>WayMap('" + geoCodes + "' , '" + cusNames + "' , '" + DtFormat + "'  , '" + type + "');</script>", false);
                OpenNewBrowserWindow("https://track.dev-ts.online/Home/ViewMap?Id="+id+"&&mode=DIGITS-SFA", this);
            }
            if (e.CommandName.Equals("Settlement"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                DataTable lstSettlement = ObjclsFrms.loadList("SelectSettlementStatus", "sp_Settlement", ID.ToString());
                if(lstSettlement.Rows.Count > 0)
                {
                    string status = lstSettlement.Rows[0]["udp_SettlementStatus"].ToString();
                    if (status.Equals("SC"))
                    {
                        Response.Redirect("SettlementReportCompleted.aspx?Id=" + ID);
                    }
                    else
                    {
                        Response.Redirect("SettlementReports.aspx?Id=" + ID);
                    }
                }
            }
        }

        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            LoadList();
            grvRpt.Rebind();
        }

        protected void ddlEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}