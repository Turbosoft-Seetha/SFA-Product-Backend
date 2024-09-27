using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Configuration;

namespace SalesForceAutomation.BO_Digits.ar
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
                    rdfromDate.SelectedDate = DateTime.Parse(Session["FrmDat"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["ToDat"].ToString());
                    //fromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("01-MM-yyyy"));
                    //toDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("dd-MM-yyyy"));
                    //toDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1);

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
                    foreach (RadComboBoxItem itmss in ddldepot.Items)
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
                    Route(dposubareacondition);
                    RouteFromTransaction();
                    rotID = Rot();
                    routeCondition = "udp_rot_ID in (" + rotID + ")";
                }
                else
                {
                    //fromDate.MinDate = DateTime.Now;
                    //toDate.MinDate = DateTime.Now;
                    ///fromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    rdfromDate.SelectedDate = DateTime.Now;
                    rdendDate.SelectedDate = DateTime.Now;
                    //fromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("01-MM-yyyy"));
                    //toDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("dd-MM-yyyy"));
                    //toDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1);
                    plhFilter.Visible = false;
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
                    foreach (RadComboBoxItem itmss in ddldepot.Items)
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
                    Route(dposubareacondition);
                    RouteFromTransaction();
                    rotID = Rot();
                    routeCondition = "udp_rot_ID in (" + rotID + ")";
                }

            }
        }

        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in rdRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public string Rot()
        {
            var ColelctionMarket = rdRoute.CheckedItems;
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


        public string mainConditions(string rotID)
        {


            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
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

        protected void ddlEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            LoadList();
            grvRpt.Rebind();
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
                string rotID = e.CommandArgument.ToString();
                Session["rdRoute"] = rotID.ToString();
                Session["LOStatus"] = dataItem["udp_LoadOutStatus"].Text.ToString();
                Response.Redirect("UserDailyProcessDetail.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("VanStock"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                string rotID = e.CommandArgument.ToString();
                Session["rdRoute"] = rotID.ToString();
                Response.Redirect("CurrentVanStock.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("map"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("udp_ID").ToString();

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
                string URL = ConfigurationManager.AppSettings.Get("TrackingUrlID");
                OpenNewBrowserWindow(URL + id + "&&mode=DIGITS-SFA", this);
            }
            if (e.CommandName.Equals("Settlement"))
            {

                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                DataTable lstRouteType = ObjclsFrms.loadList("SelectRouteType", "sp_Settlement", ID.ToString());
                string rotTypes = lstRouteType.Rows[0]["rot_Type"].ToString();
                if (rotTypes.Equals("MER"))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>MerchModal();</script>", false);
                }
                else
                {
                    DataTable lstSettlement = ObjclsFrms.loadList("SelectSettlementStatus", "sp_Settlement", ID.ToString());
                    if (lstSettlement.Rows.Count > 0)
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
        }

        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                ImageButton VanBtn = (ImageButton)item.FindControl("btnVanstock");
                if ((item["udp_LoadOutStatus"].Text == "Y") || (item["udp_EndDayStatus"].Text == "ED"))
                {
                    VanBtn.Visible = false;
                }
                else
                {
                    VanBtn.Visible = true;
                }
            }
        }

        protected void btnVanStock_Click(object sender, EventArgs e)
        {
            Response.Redirect("CurrentVanStock.aspx");
        }
        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Region()
        {
            ddlregion.DataSource = ObjclsFrms.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlregion.DataTextField = "reg_Name";
            ddlregion.DataValueField = "reg_ID";
            ddlregion.DataBind();
        }
        public void Depot(string RegCondition)
        {
            string[] arr = { RegCondition };
            ddldepot.DataSource = ObjclsFrms.loadList("SelectDepotTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldepot.DataTextField = "dep_Name";
            ddldepot.DataValueField = "dep_ID";
            ddldepot.DataBind();
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
        public void DpoArea(string DpoCondition)
        {
            string u = UICommon.GetCurrentUserID().ToString();
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
        public string DPO()
        {
            var CollectionMarket1 = ddldepot.CheckedItems;
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
        protected void ddldepot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
        }

        protected void ddldpoArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
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
        protected void ddldpoSubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
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

        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}