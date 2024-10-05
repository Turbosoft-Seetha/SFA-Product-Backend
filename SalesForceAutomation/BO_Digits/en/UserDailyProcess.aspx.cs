using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Configuration;
using System.Linq.Expressions;
using DocumentFormat.OpenXml.Office.CustomUI;
using System.IO;
using System.Xml;
using DocumentFormat.OpenXml.ExtendedProperties;
using EnvDTE;
using System.Runtime.InteropServices;

namespace SalesForceAutomation.BO_Digits.en
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
                Session["Status"] = "";
                string rotID, routeCondition, routeTypeCondition;
                EndDayNotDone();
               
                try
                {
					if (Mode.Equals("tml"))
					{

						rdfromDate.SelectedDate = DateTime.Parse(Session["FrmDat"].ToString());
						rdendDate.SelectedDate = DateTime.Parse(Session["ToDat"].ToString());


					}
					else if (Mode.Equals("udd"))
					{

						rdfromDate.SelectedDate = DateTime.Parse(Session["frmdate"].ToString());
						rdendDate.SelectedDate = DateTime.Parse(Session["todate"].ToString());



					}
					else if (Mode.Equals("SR"))
					{

						rdfromDate.SelectedDate = DateTime.Parse(Session["SRFdate"].ToString());
						rdendDate.SelectedDate = DateTime.Parse(Session["SRTdate"].ToString());



					}
					else if (Mode.Equals("SRC"))
					{

						rdfromDate.SelectedDate = DateTime.Parse(Session["SRCFdate"].ToString());
						rdendDate.SelectedDate = DateTime.Parse(Session["SRCTdate"].ToString());



					}
					else if (Mode.Equals("VAN"))
					{

						rdfromDate.SelectedDate = DateTime.Parse(Session["VanFDate"].ToString());
						rdendDate.SelectedDate = DateTime.Parse(Session["VanTDate"].ToString());



					}
					else
					{
                        if (Session["UDPFromDate"] != null)
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(Session["UDPFromDate"].ToString());  
                        }
                        else
                        {
                            rdfromDate.SelectedDate = DateTime.Now;
                        }
                       
                        if (Session["UDPToDate"] != null)
                        {
                            rdendDate.SelectedDate = DateTime.Parse(Session["UDPToDate"].ToString()); 
                        }
                        else
                        {
                            rdendDate.SelectedDate = DateTime.Now;
                        }

      //                  rdfromDate.SelectedDate = DateTime.Now;
						//rdendDate.SelectedDate = DateTime.Now;

						plhFilter.Visible = false;

					}
				}
                catch(Exception ex)
                {
					Response.Redirect("~/SignIn.aspx");
				}
               
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
                RouteType();

                try
                {
                    if (Session["UDProtTypeID"] != null)
                    {
                        int a = rdRouteType.Items.Count;
                        string routetype = Session["UDProtTypeID"].ToString();
                        string[] ar = routetype.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {

                            string trimmedType = ar[i].Trim('\'');
                            foreach (RadComboBoxItem items in rdRouteType.Items)
                            {
                                
                                if (items.Value == trimmedType)
                                {
                                    items.Checked = true;
                                }
                               
                            }
                        }
                    }
                    else
                    {
                        int j = 1;
                        foreach (RadComboBoxItem itmss in rdRouteType.Items)
                        {
                            itmss.Checked = true;
                            j++;
                        }
                        string rotType = RotType();
                        routeTypeCondition = " rot_Type in (" + rotType + ")";

                    }
                   

                    Route(dposubareacondition);
                   
                    if (Session["UDProtID"] != null)
                    {
                        int a = rdRoute.Items.Count;
                        string route = Session["UDProtID"].ToString();
                        string[] ar = route.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in rdRoute.Items)
                            {
                                if (items.Value == ar[i])
                                {
                                    items.Checked = true;
                                }
                            }
                        }
                    }
                    else
                    {
                        if (!Mode.Equals("udd"))
                        {
                            RouteFromTransaction();
                        }
                        else
                        {
                            int j = 1;
                            foreach (RadComboBoxItem itmss in rdRoute.Items)
                            {
                                itmss.Checked = true;
                                j++;
                            }
                            rotID = Rot();
                            routeCondition = "udp_rot_ID in (" + rotID + ")";
                        }
                    }
                   
                }
                catch(Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    GetGridSession(grvRpt, "UDP");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                SelUserDailyProcess();
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

       
        public string mainConditions(string rotID,string cmode)
        {


            string dateCondition = "";
            string StatusCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromdate + "' as date) and cast('" + endDate + "' as date))";

                if (cmode.Equals("C"))
                {
                    string Status = Session["Status"].ToString();

                    if (Status == "Completed")
                    {
                        StatusCondition = " and isnull(udp_StartDay, '') = 'SD' and isnull(udp_EndDayStatus, '') = 'ED' ";
                    }
                    else if (Status == "NotCompleted")
                    {
                        StatusCondition = " and isnull(udp_StartDay, '') = 'SD' and isnull(udp_EndDayStatus, '') <> 'ED'";
                    }
                    else
                    {
                        StatusCondition = "";
                    }
                }
                else
                {
                    StatusCondition = "";
                }
                



            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += StatusCondition;


            return mainCondition;
        }

        public void LoadList(string mode)
        {
            string rotID = Rot();

            DataTable lstUser = default(DataTable);
            if(mode.Equals("F"))
            {
                lstUser = ObjclsFrms.loadList("SelectUserDailyProcess", "sp_Merchandising", mainConditions(rotID, "C").ToString());
            }
            else
            {
                lstUser = ObjclsFrms.loadList("SelectUserDailyProcess", "sp_Merchandising", mainConditions(rotID, "").ToString());
            }
            
            grvRpt.DataSource = lstUser;
            
        }



        protected void ddlEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                Session["fDate"] = rdfromDate.SelectedDate.ToString();
                Session["TDate"] = rdendDate.SelectedDate.ToString();

                Session["UDPFromDate"] = rdfromDate.SelectedDate.ToString();
                Session["UDPToDate"] = rdendDate.SelectedDate.ToString();





                if (Session["UDProtID"] != null)
                {
                    string route = Rot();
                    if (route == Session["UDProtID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["UDProtID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["UDProtID"] = rotID;
                }

                if (Session["UDProtTypeID"] != null)
                {
                    string rotType = RotType();
                    if (rotType == Session["UDProtTypeID"].ToString())
                    {
                        string routeType = RotType();

                    }
                    else
                    {
                        string routeType = RotType();

                        Session["UDProtTypeID"] = routeType;
                    }


                }
                else
                {
                    string routeType = RotType();
                    Session["UDProtTypeID"] = routeType;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            Session["Status"] = "";
            SelUserDailyProcess();
            LoadList("");
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList("");
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "UDP");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }           
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                string rotID = e.CommandArgument.ToString();
				try
				{
					Session["rdRoute"] = rotID.ToString();
					Session["LOStatus"] = dataItem["udp_LoadOutStatus"].Text.ToString();
					Session["fDate"] = rdfromDate.SelectedDate.ToString();
					Session["TDate"] = rdendDate.SelectedDate.ToString();
				}
				catch (Exception ex)
				{
					Response.Redirect("~/SignIn.aspx");
				}
				
                Response.Redirect("UserDailyProcessDetail.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("VanStock"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                string rotID = e.CommandArgument.ToString();
				try
				{
					Session["rdRoute"] = rotID.ToString();
					Session["fDate"] = rdfromDate.SelectedDate.ToString();
					Session["TDate"] = rdendDate.SelectedDate.ToString();
				}
				catch (Exception ex)
				{
					Response.Redirect("~/SignIn.aspx");
				}

				
                Response.Redirect("CurrentVanStock.aspx?Id=" + ID );

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
                string URL=System.Configuration.ConfigurationManager.AppSettings.Get("TrackingUrlID");
                OpenNewBrowserWindow(URL + id + "&&mode=DIGITS-SFA", this);
            }
            if (e.CommandName.Equals("Settlement"))
            {
                try
                {
                    Session["fDate"] = "";
                    Session["TDate"] = "";
                    Session["fDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["TDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
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
                        if (status.Equals("AP"))
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
                ImageButton SettleBtn = (ImageButton)item.FindControl("RadImageButton2");
                if ((item["udp_LoadOutStatus"].Text == "Y") || (item["udp_EndDayStatus"].Text == "ED"))
                {
                    VanBtn.Visible = false;
                }
                else
                {
                    VanBtn.Visible = true;
                }

                if ((item["rot_Type"].Text == "SL") || (item["rot_Type"].Text == "DL") || (item["rot_Type"].Text == "FS"))
                {
                    VanBtn.Visible = true;
                }
                else
                {
                    VanBtn.Visible = false;
                }

                if ((item["rot_Type"].Text == "MER") || (item["rot_Type"].Text == "OR"))
                {
                    SettleBtn.Visible = false;
                }
                else
                {
                    SettleBtn.Visible = true;
                }
            }
        }

        protected void btnVanStock_Click(object sender, EventArgs e)
        {
            Response.Redirect("CurrentVanStock.aspx");
        }

        public void RouteType()
        {
            rdRouteType.DataSource = ObjclsFrms.loadList("SelectRouteTypeforDropdown", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRouteType.DataTextField = "Type";
            rdRouteType.DataValueField = "rot_Type";
            rdRouteType.DataBind();
        }
        public void Route(string DposubAreaCondition)
        {
            string TypeCondition;
            string rotType = RotType();


            //if ((rdRouteType.SelectedValue.ToString() == "AL")|| (rdRouteType.SelectedValue.ToString() == ""))
            //{
            //    TypeCondition = "";
            //}
            //else
            //{
              //  TypeCondition = (DposubAreaCondition == "" ? " rot_Type='" + ddlRotType.SelectedValue.ToString() + "'" : " and rot_Type=' " + ddlRotType.SelectedValue.ToString() + "'");
                TypeCondition = (DposubAreaCondition == "" ? " rot_Type in (" + rotType + ")" : " and rot_Type in (" + rotType + ")");


            //}

            string[] arr = { DposubAreaCondition, TypeCondition };
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
       
        public string RotType()
        {
            var CollectionMarket = rdRouteType.CheckedItems;
            string rotType = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;

            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        rotType += "'" + item.Value + "'";
                    }
                    else
                    {
                        rotType += ",'" + item.Value + "'";
                    }
                    j++;
                }
                return rotType;
            }
            else
            {
                return "'0'";
            }
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
            //Route(DposubAreaCondition);
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
        public void SetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                foreach (GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        string filterValue = column.CurrentFilterValue;

                        Session[SessionPrefix + columnName] = filterValue;

                    }

                }

            }

            catch (Exception ex)

            {

                Response.Redirect("~/SignIn.aspx");


            }



        }
        public void GetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                string filterExpression = string.Empty;

                foreach (GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        if (Session[SessionPrefix + columnName] != null)

                        {

                            string filterValue = Session[SessionPrefix + columnName].ToString();



                            if (filterValue != "")
                            {

                                column.CurrentFilterValue = filterValue;



                                if (!string.IsNullOrEmpty(filterExpression))

                                {

                                    filterExpression += " AND ";

                                }

                                filterExpression += string.Format("{0} LIKE '%{1}%'", column.UniqueName, column.CurrentFilterValue);

                            }

                        }

                    }

                }

                if (filterExpression != string.Empty)

                {

                    grvRpt.MasterTableView.FilterExpression = filterExpression;

                }



            }

            catch (Exception ex)

            {
                Response.Redirect("~/SignIn.aspx");

            }

        }

        protected void lnkNotCompleted_Click(object sender, EventArgs e)
        {
            try
            {
                Session["Status"] = "NotCompleted";
                LoadList("F");
                grvRpt.Rebind();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UserDailyProcess.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }

        }

        protected void lnkCompleted_Click(object sender, EventArgs e)
        {
            try
            {
                Session["Status"] = "Completed";
                LoadList("F");
                grvRpt.Rebind();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UserDailyProcess.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        protected void lnkTotCount_Click(object sender, EventArgs e)
        {
            try
            {
                Session["Status"] = "";
                LoadList("F");
                grvRpt.Rebind();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UserDailyProcess.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        public DataTable LoadData(string QueryMode)
        {
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainConditions(rotID,"");

            DataTable dt = ObjclsFrms.loadList(QueryMode, "sp_Merchandising", mainCondition);
            return dt;
        }

            public void SelUserDailyProcess()
        {
            
            DataTable dts = LoadData("SelUserDailyProcessCountSplits");
            if(dts.Rows.Count > 0)
            {
                string para1 = dts.Rows[0]["TotalCount"].ToString();

                lblTotalCount.Text = para1.ToString();

                lblCompleted.Text = dts.Rows[0]["Completed"].ToString();
                lblNotCompleted.Text = dts.Rows[0]["NotCompleted"].ToString();
            }
          
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            EndDayNotDone();
        }
        public void EndDayNotDone()
        {
            try
            {
                
                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("SelEndDayNotDone", "sp_Report");
                RadGrid1.DataSource = lstUser;
                RadGrid1.Rebind();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UserDailyProcess.aspx EndDayNotDone()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }

        }
        protected void EndDay_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }
        protected void lnkEndday_Click(object sender, EventArgs e)
        {
            try
            {
                string udp_ID = GetItemFromGrid();
                if (string.IsNullOrEmpty(udp_ID))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Please choose atlest one and try again.');</script>", false);
                }
                else
                {
                    string User, ID;

                    User = UICommon.GetCurrentUserID().ToString();
                    ID = GetItemFromGrid();

                    string[] arr = { User };
                    DataTable lstUser = default(DataTable);
                    lstUser = ObjclsFrms.loadList("UpadateEndDay", "sp_Report", ID, arr);
                    string res = lstUser.Rows[0]["Res"].ToString();
                    if (lstUser.Rows.Count > 0)
                    {
                        if (res == "1")
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('EndDay done successfully');</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong, please try again later.');</script>", false);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong, please try again later.');</script>", false);
                    }
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UserDailyProcess.aspx lnkEndday_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("q");

                    DataTable dsc = new DataTable();
                    foreach (GridDataItem dr in RadGrid1.SelectedItems)
                    {

                        string udp_ID = dr.GetDataKeyValue("udp_ID").ToString();

                        createNode2(udp_ID, writer);
                        c++;
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();

                }
                if (c == 0)
                {

                    return null;
                }
                else
                {
                    string ss = sw.ToString();
                    return sw.ToString();
                }
            }
        }
        private void createNode2(string udp_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("udp_ID");
            writer.WriteString(udp_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/UserDailyProcess.aspx");
        }

      
        protected void lnkTodayDate_Click(object sender, EventArgs e)
        {
            rdfromDate.SelectedDate = DateTime.Now;
            rdendDate.SelectedDate = DateTime.Now;
            Session["Status"] = "";
            SelUserDailyProcess();
            LoadList("");
            grvRpt.Rebind();
        }

        protected void lnkPrevious_Click(object sender, EventArgs e)
        {
            rdfromDate.SelectedDate = rdfromDate.SelectedDate.Value.AddDays(-1);
            rdendDate.SelectedDate = rdfromDate.SelectedDate.Value;
            Session["Status"] = "";
            SelUserDailyProcess();
            LoadList("");
            grvRpt.Rebind();

        }

        protected void lnkNextDay_Click(object sender, EventArgs e)
        {
            rdfromDate.SelectedDate = rdfromDate.SelectedDate.Value.AddDays(1);
            rdendDate.SelectedDate = rdfromDate.SelectedDate.Value;
            Session["Status"] = "";
            SelUserDailyProcess();
            LoadList("");
            grvRpt.Rebind();
        }
        //protected void ddlRotType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    rdRoute.ClearSelection();
        //    Route("");
        //}

        protected void rdRouteType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rdRoute.ClearSelection();
            Route("");
        }
        private void ClearGridFilterConditions(Telerik.Web.UI.RadGrid grd, string SessionPrefix)
        {
            try
            {
                foreach (GridColumn column in grd.MasterTableView.Columns)
                {
                    if (column is GridBoundColumn boundColumn)
                    {
                        string columnName = boundColumn.UniqueName;
                        column.CurrentFilterValue = string.Empty;
                        Session[SessionPrefix + columnName] = null;
                    }
                }
                grd.MasterTableView.FilterExpression = string.Empty;
            }
            catch (Exception ex)
            {

            }
        }

        public void reset()
        {
            ClearGridFilterConditions(grvRpt, "UDP");
            //string mainCondition = "";

            Session["fDate"] = "";
            Session["TDate"] = "";
            Session["UDPFromDate"] = "";
            Session["UDPToDate"] = "";


            Session["UDProtID"] = "";
            Session["UDProtTypeID"] = "";
            Session["Status"] = "";
            string rotID, routeCondition, routeTypeCondition;
            EndDayNotDone();
            Console.WriteLine("sessiondate",Session["UDPFromDate"]);
            try
            {
                if (Mode.Equals("tml"))
                {

                    rdfromDate.SelectedDate = DateTime.Parse(Session["FrmDat"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["ToDat"].ToString());


                }
                else if (Mode.Equals("udd"))
                {

                    rdfromDate.SelectedDate = DateTime.Parse(Session["frmdate"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["todate"].ToString());



                }
                else if (Mode.Equals("SR"))
                {

                    rdfromDate.SelectedDate = DateTime.Parse(Session["SRFdate"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["SRTdate"].ToString());



                }
                else if (Mode.Equals("SRC"))
                {

                    rdfromDate.SelectedDate = DateTime.Parse(Session["SRCFdate"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["SRCTdate"].ToString());



                }
                else if (Mode.Equals("VAN"))
                {

                    rdfromDate.SelectedDate = DateTime.Parse(Session["VanFDate"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["VanTDate"].ToString());



                }
                else
                {
                    if (!string.IsNullOrEmpty(Session["UDPFromDate"] as string))
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["UDPFromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                    }

                    if (!string.IsNullOrEmpty(Session["UDPToDate"] as string))
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["UDPToDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;
                    }

                    //                  rdfromDate.SelectedDate = DateTime.Now;
                    //rdendDate.SelectedDate = DateTime.Now;

                    plhFilter.Visible = false;

                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

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
            RouteType();

           
            try
            {
                if (!string.IsNullOrEmpty(Session["UDProtTypeID"] as string))
                {
                    int a = rdRouteType.Items.Count;
                    string routetype = Session["UDProtTypeID"].ToString();
                    string[] ar = routetype.Split(',');
                    for (int i = 0; i < ar.Length; i++)
                    {
                        string trimmedType = ar[i].Trim('\'');
                        foreach (RadComboBoxItem items in rdRouteType.Items)
                        {
                            
                            if (items.Value == trimmedType)
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else
                {
                    int j = 1;
                    foreach (RadComboBoxItem itmss in rdRouteType.Items)
                    {
                        itmss.Checked = true;
                        j++;
                    }
                    string rotType = RotType();
                    routeTypeCondition = " rot_Type in (" + rotType + ")";

                }
                Route(dposubareacondition);

                //if (!Mode.Equals("udd"))
                //{
                //    RouteFromTransaction();
                //}
                if (!string.IsNullOrEmpty(Session["UDProtID"] as string))
                {
                    int a = rdRoute.Items.Count;
                    string route = Session["UDProtID"].ToString();
                    string[] ar = route.Split(',');
                    for (int i = 0; i < ar.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdRoute.Items)
                        {
                            if (items.Value == ar[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else
                {
                    if (!Mode.Equals("udd"))
                    {
                        RouteFromTransaction();
                    }
                    else
                    {
                        int j = 1;
                        foreach (RadComboBoxItem itmss in rdRoute.Items)
                        {
                            itmss.Checked = true;
                            j++;
                        }
                        rotID = Rot();
                        routeCondition = "udp_rot_ID in (" + rotID + ")";
                    }
                }

            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            SelUserDailyProcess();
        }
        protected void Reset_Click(object sender, ImageClickEventArgs e)
        {
            try 
            { 
           
                reset();
               

                LoadList("");
                grvRpt.Rebind();

            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UserDailyProcess.aspx", "ItemsData() Error : " + ex.Message.ToString() + " - " + innerMessage);
            }

        }
    }
}