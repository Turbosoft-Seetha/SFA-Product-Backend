using DocumentFormat.OpenXml.Wordprocessing;
using SalesForceAutomation.Admin;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListDisplayAgreements : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["mode"], out Mode);

                return Mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                plhFilter.Visible = false;
                Region();
                Route();
                string type = "";
               

                if (Mode == 1) // While loading page from dashboard 
                {
                    rdRoute.Enabled = false;
                    rdCustomer.Enabled = false;
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;

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
                    

                    RegionFromDashboard();
                    string region = REG();
                    string regionCondition = " dep_reg_ID in (" + region + ")";

                    Depot(regionCondition);
                    DepoFromDashboard();
                    string depo = DPO();
                    string dpocondition = " dpa_dep_ID in (" + depo + ")";

                    DpoArea(dpocondition);
                    DepoAreaFromDashboard();
                    string depoarea = DPOarea();
                    string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";

                    DpoSubArea(dpoareacondition);
                    DepoSubAreaFromDashboard();
                    string deposubarea = DPOsubarea();
                    string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";

                    Route(dposubareacondition);
                    RouteFromDashboard();
                    try
                    {
                        if ((Session["ButtonMode"] != null))
                        {
                            LoadList("");
                            grvRpt.Rebind();
                            if (Session["ButtonMode"].ToString() == "P")
                            {
                                lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "A")
                            {
                                lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "R")
                            {
                                lnkrejejected.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "E")
                            {
                                lnkExpired.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else
                            {
                                lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                        }
                        else
                        {
                            if (type.Equals("NA"))
                            {
                                lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                Session["ButtonMode"] = "P";
                            }
                            else
                            {
                                lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                Session["ButtonMode"] = "A";
                            }
                        }
                        if (Session["chkDate"] != null)
                        {
                            if (Session["chkDate"].ToString()=="true")
                            {
                                chkDate.Checked = true;
                            }
                            else
                            {
                                chkDate.Checked = false;
                            }
                        }
                        else
                        {
                            chkDate.Checked = true;
                        }

                    }
                    catch (Exception ex)
                    {

                    }
                    
                    
                    StatusCount("2");

                }
                else if (Mode == 2)
                {
                    rdRoute.Enabled = false;
                    rdCustomer.Enabled = false;
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;
                    type = Request.Params["type"].ToString();

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
                        try
                        {
                            if ((Session["ButtonMode"] != null))
                            {
                                LoadList("");
                                grvRpt.Rebind();
                                if (Session["ButtonMode"].ToString() == "P")
                                {
                                    lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                }
                                else if (Session["ButtonMode"].ToString() == "A")
                                {
                                    lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                }
                                else if (Session["ButtonMode"].ToString() == "R")
                                {
                                    lnkrejejected.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                }
                                else if (Session["ButtonMode"].ToString() == "E")
                                {
                                    lnkExpired.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                }
                                else
                                {
                                    lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                }
                            }
                            else
                            {
                                if (type.Equals("NA"))
                                {
                                    lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                    Session["ButtonMode"] = "P";
                                }
                                else
                                {
                                    lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                    Session["ButtonMode"] = "A";
                                }
                            }
                            if (Session["chkDate"] != null)
                            {
                                if (Session["chkDate"].ToString() == "true")
                                {
                                    chkDate.Checked = true;
                                }
                                else
                                {
                                    chkDate.Checked = false;
                                }
                            }
                            else
                            {
                                chkDate.Checked = true;
                            }

                        }
                        catch (Exception ex)
                        {

                        }
                        string route = Session["Route"] != null ? Session["Route"].ToString() : string.Empty;
                        RouteFromInvMontDashboard();
                        string routeCondition = " rcs_rot_ID in (" + route + ")";
                        Customer(routeCondition);

                    }
                    catch (Exception ex)
                    {

                    }

                    try
                    {
                        if ((Session["ButtonMode"] != null))
                        {
                            LoadList("");
                            grvRpt.Rebind();
                            if (Session["ButtonMode"].ToString() == "P")
                            {
                                lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "A")
                            {
                                lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "R")
                            {
                                lnkrejejected.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "E")
                            {
                                lnkExpired.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else
                            {
                                lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                        }
                        else
                        {
                            if (type.Equals("NA"))
                            {
                                lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                Session["ButtonMode"] = "P";
                            }
                            else
                            {
                                lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                                Session["ButtonMode"] = "A";
                            }
                        }
                        if (Session["chkDate"] != null)
                        {
                            if (Session["chkDate"].ToString() == "true")
                            {
                                chkDate.Checked = true;
                            }
                            else
                            {
                                chkDate.Checked = false;
                            }
                        }
                        else
                        {
                            chkDate.Checked = true;
                        }

                    }
                    catch (Exception ex)
                    {

                    }
                    StatusCount("");

                }
                else
                {


                    try
                    {


                        if (Session["LDisFromDate"] != null)
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(Session["DisAFromDate"].ToString());
                        }
                        else
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                        }
                        if (Session["LDisToDate"] != null)
                        {
                            rdendDate.SelectedDate = DateTime.Parse(Session["DisAToDate"].ToString());
                        }
                        else
                        {
                            rdendDate.SelectedDate = DateTime.Now; 
                        }
                    }
                    catch
                    {
                        

                    }
                    

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
                    int S = 1;
                    foreach (RadComboBoxItem itmss in rdRoute.Items)
                    {
                        itmss.Checked = true;
                        S++;
                    }
                    string rotID = Rot();
                    string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                    Customer(routeCondition);
                    try
                    {
                        if ((Session["ButtonMode"] != null))
                        {
                            LoadList("");
                            grvRpt.Rebind();
                            if (Session["ButtonMode"].ToString() == "P")
                            {
                                lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "A")
                            {
                                lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "R")
                            {
                                lnkrejejected.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else if (Session["ButtonMode"].ToString() == "E")
                            {
                                lnkExpired.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                            else
                            {
                                lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            }
                        }
                        else
                        {
                            lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                            Session["ButtonMode"] = "N";
                        }
                        if (Session["chkDate"] != null)
                        {
                            if (Session["chkDate"].ToString() == "true")
                            {
                                chkDate.Checked = true;
                            }
                            else
                            {
                                chkDate.Checked = false;
                            }
                        }
                        else
                        {
                            chkDate.Checked = false;
                        }

                    }
                    catch (Exception ex)
                    {

                    }
                    StatusCount("");
                    
                    
                }
                int B = 1;
                foreach (RadComboBoxItem itmss in rdCustomer.Items)
                {
                    itmss.Checked = true;
                    B++;
                }
            }
        }
        public void StatusCount(string mode)
            
        {
            string endDate = "";
            string condition = "";
            string expiry = "";
            string mainCondition = "";
            string allCondition = "";


            DataTable lstUser = default(DataTable);
            endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            if (chkDate.Checked == true)
            {
               
                    expiry = " and ((A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE))) ";
                    condition = " and NOT(CAST('" + endDate + "' as date) > CAST(dag_EndDate AS DATE))";
                    allCondition = " OR ((A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE))) ";
                    string rotID = Rot();
                    string cusID = Cus();
                    string customerCondition = "";
                    string dateCondition = "";
                    mainCondition = " and udp_rot_ID in (" + rotID + ")";
                    try
                    {
                      
                        dateCondition = " and (cast('" + fromDate + "' as date) Between Cast(dag_StartDate as date) and Cast(dag_EndDate as date) Or cast('" + endDate + "' as date) Between Cast(dag_StartDate as date) and Cast(dag_EndDate as date))";
                        if (cusID.Equals("0"))
                        {
                            customerCondition = "";
                        }
                        else
                        {
                            customerCondition = " and dag_cus_ID in (" + cusID + ")";
                        }


                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");

                    }
                    mainCondition += dateCondition;
                    mainCondition += customerCondition;
            }
            else
            {
                expiry = " and (A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";
                condition = " and NOT(CAST(getdate() as date) > CAST(dag_EndDate AS DATE))";
                allCondition = " And ( (A.Status in('A','P','R') and  NOT(CAST('" + endDate + "' as date) > CAST(dag_EndDate AS DATE)))    OR ((A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE)))) ";
            }

            string[] arr = { condition, mainCondition, allCondition };
            lstUser = ObjclsFrms.loadList("DispAgCount", "sp_wb_merch_others", expiry, arr);

            if (lstUser != null && lstUser.Rows.Count > 0)
            {
                lnkALl.Text = "All(" + lstUser.Rows[0]["AllCount"].ToString() + ")";
                lnkapproved.Text = "Approved(" + lstUser.Rows[0]["Approved"].ToString() + ")";
                lnkrejejected.Text = "Rejected(" + lstUser.Rows[0]["Rejected"].ToString() + ")";
                lnkPending.Text = "Pending(" + lstUser.Rows[0]["Pending"].ToString() + ")";
                lnkExpired.Text = "Expired(" + lstUser.Rows[0]["Expired"].ToString() + ")";
            }
        }
        public void RouteFromInvMontDashboard()
        {
            if (Session["Route"] != null)
            {
                string ids = Session["Route"].ToString();
                string[] words = ids.Split(',');

                foreach (var word in words)
                {
                    foreach (RadComboBoxItem rd in rdRoute.Items)
                    {
                        if (rd.Value.Equals(word))
                        {
                            rd.Checked = true;
                        }
                    }
                }
            }
        }
        public void RouteFromDashboard()
        {
            try
            {


                if (Session["Route"] != null)
                {
                    string ids = Session["Route"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in rdRoute.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }

        }
        public void RegionFromDashboard()
        {
            try
            {


                if (Session["Region"] != null)
                {
                    string ids = Session["Region"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddlregion.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
        }
        public void DepoFromDashboard()
        {
            try
            {


                if (Session["Depo"] != null)
                {
                    string ids = Session["Depo"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddldepot.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
        }

        public void DepoAreaFromDashboard()
        {
            try
            {


                if (Session["DepoArea"] != null)
                {
                    string ids = Session["DepoArea"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddldpoArea.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
        }
        public void DepoSubAreaFromDashboard()
        {
            try
            {


                if (Session["Depo"] != null)
                {
                    string ids = Session["DepoSubArea"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddldpoSubArea.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

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
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelectRoutes", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Customer(string routeCondition)
        {
            DataTable dtc = ObjclsFrms.loadList("SelectCustomerByRoute", "sp_wb_merch_others", routeCondition);
            rdCustomer.DataSource = dtc;
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
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
                return "udp_rot_ID";
            }
        }

        public string Cus()
        {
            var ColelctionMarkets = rdCustomer.CheckedItems;
            string cusID = "";
            int k = 0;
            int MarCounts = ColelctionMarkets.Count;
            if (ColelctionMarkets.Count > 0)
            {
                foreach (var item in ColelctionMarkets)
                {
                    //where 1 = 1 
                    if (k == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (k > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (k == (MarCounts - 1))
                    {
                        cusID += item.Value;
                    }
                    k++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }



        public string mainConditions(string rotID)
        {
            string cusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                if ((chkDate.Checked == true) || (Session["ButtonMode"] == null))
                {

                if (Session["ButtonMode"].ToString() != "E") { 
                    dateCondition = " and (cast('" + fromDate + "' as date) Between Cast(dag_StartDate as date) and Cast(dag_EndDate as date) Or cast('" + endDate + "' as date) Between Cast(dag_StartDate as date) and Cast(dag_EndDate as date))";
                }
                }
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and dag_cus_ID in (" + cusID + ")";
                }


            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            return mainCondition;
        }

        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in rdCustomer.Items)
            {
                itme.Checked = true;
                k++;
            }
        }






        public void LoadList(string buttonmode)
        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string expiry = "";
                string notExpired = "";

                
                if (Mode == 1)
                {
                    try
                    {
                        mainCondition = mainConditions(Session["Route"].ToString());
                        string type = Request.Params["type"].ToString();
                        if (Session["ButtonMode"] != null)
                        {
                            if (chkDate.Checked == true)
                            {
                                if (Session["ButtonMode"].ToString() == "N")
                                {
                                    expiry = " OR (A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                }
                                else
                                {
                                    expiry = " and (A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                }
                                notExpired= " And Not(CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE))";

                            }
                            else
                            {
                                if (Session["ButtonMode"].ToString() == "N")
                                {
                                    expiry = " OR (A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                }
                                else
                                {
                                    expiry = " and (A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";
                                }
                                notExpired = " And Not(CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";
                            }

                            if (Session["ButtonMode"].ToString() == "P")
                            {
                                mainCondition += " and (A.Status='P'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "A")
                            {
                                mainCondition += " and (A.Status='A'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "R")
                            {
                                mainCondition += " and (A.Status='R'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "E")
                            {
                                mainCondition += " and ( CAST('" + endDate + "' as date) > CAST(dag_EndDate AS DATE) and A.status not in('A','R'))";
                            }
                            else if (Session["ButtonMode"].ToString() == "N")
                            {
                                mainCondition+= " OR (A.Status = 'P' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";
                            }
                        }
                        else
                        {
                            if (type.Equals("NA"))
                            {
                                mainCondition += " and A.Status='P'";
                            }
                            else if (type.Equals("AA"))
                            {
                                mainCondition += " and A.Status='A'";
                            }
                            else if (type.Equals("AC"))
                            {
                                mainCondition += " and A.Status='A'";
                            }
                        }
                        
                    }
                    catch { }                     
                 }
                else if (Mode == 2)
                {
                    try
                    {
                        mainCondition = mainConditions(Session["Route"].ToString());
                        string type = Request.Params["type"].ToString();
                        if (Session["ButtonMode"] != null)
                        {
                            if (chkDate.Checked == true)
                            {
                                if (Session["ButtonMode"].ToString() == "N")
                                {
                                    expiry = " OR (A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE)) ";

                                }
                                else
                                {
                                    expiry = " and (A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                }

                                notExpired = " And Not(CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE))";
                            }
                            else
                            {
                                if (Session["ButtonMode"].ToString() == "N")
                                {
                                    expiry = " and (A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                }
                                else
                                {
                                    expiry = " and (A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";
                                }
                                notExpired = " And Not(CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";

                            }

                            if (Session["ButtonMode"].ToString() == "P")
                            {
                                mainCondition += " and (A.Status='P'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "A")
                            {
                                mainCondition += " and (A.Status='A'"+notExpired+" )";
                            }
                            else if (Session["ButtonMode"].ToString() == "R")
                            {
                                mainCondition += " and (A.Status='R'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "E")
                            {
                                mainCondition += expiry;
                            }
                            else if (Session["ButtonMode"].ToString() == "N")
                            {
                                mainCondition += expiry;
                            }
                        }
                        else
                        {
                            if (type.Equals("NA"))
                            {
                                mainCondition += " and A.Status='P'";
                            }
                            else if (type.Equals("AA"))
                            {
                                mainCondition += " and A.Status='A'";
                            }
                            else if (type.Equals("AC"))
                            {
                                mainCondition += " and A.Status='A'";
                            }
                        }
                    }
                    catch { }
                }
                   
                
                else
                {
                    string rot_ID = Rot();

                    mainCondition = mainConditions(rot_ID);
                    try
                    {

                        if (Session["ButtonMode"] != null)
                        {
                            if (chkDate.Checked == true)
                            {
                                if (Session["ButtonMode"].ToString() == "N")
                                {
                                    expiry = " OR (A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                }
                                else
                                {
                                    expiry = " and (A.Status = 'A' and CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                }

                                notExpired = " And Not(CAST('" + endDate + "' AS DATE) > CAST(dag_EndDate AS DATE))";
                            }
                            else
                            {
                                if (Session["ButtonMode"].ToString() == "N")
                                {
                                    expiry = " and  (A.Status in('A','P','R') and CAST(getdate() AS DATE) < CAST(dag_EndDate AS DATE) ) OR (A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE)) ";
                                    expiry = " And ( (A.Status in('A','P','R') and  NOT(CAST(getdate() as date) > CAST(dag_EndDate AS DATE)))    OR ((A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))))";
                                }
                                else
                                {
                                    expiry = " and (A.Status = 'A' and CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";
                                }
                                notExpired = " And Not(CAST(getdate() AS DATE) > CAST(dag_EndDate AS DATE))";
                            }



                            if (Session["ButtonMode"].ToString() == "P")
                            {
                                mainCondition += " and (A.Status='P'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "A")
                            {
                                mainCondition += " and (A.Status='A'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "R")
                            {
                                mainCondition += " and (A.Status='R'" + notExpired + " )";
                            }
                            else if (Session["ButtonMode"].ToString() == "E")
                            {
                                mainCondition += expiry;
                            }
                            else if (Session["ButtonMode"].ToString() == "N")
                            {
                                mainCondition += expiry;
                            }
                        }
                    }
                    catch(Exception ex) 
                    { 


                    }
                    //mainCondition = mainConditions(rotID);
                }
               
                DataTable lstUser = default(DataTable);
                string[] ar = { endDate };
                lstUser = ObjclsFrms.loadList("SelDisplayAgreement", "sp_wb_merch_others", mainCondition.ToString(),ar);
                grvRpt.DataSource = lstUser;
            }
        }

        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("udp_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = "rcs_rot_ID in (" + rotID + ")";
            Customer(routeCondition);
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList("");
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                HyperLink pdf = (HyperLink)item.FindControl("pp");
                string att = item["dag_Attachment"].Text.Replace("&nbsp;", "");


                if (att.Equals(""))
                {
                    pdf.Visible = false;
                }
                else
                {
                    pdf.Visible = true;
                }
            }
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (Telerik.Web.UI.GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Image")  && !column.HeaderText.Equals("Attachment")
                    )
                {

                    if (column.Display == true)
                    {
                        columncount++;
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }

                }
            }

            DataRow dr;
            grvRpt.MasterTableView.AllowPaging = false;

            RadGrid dd = grvRpt;
            dd.AllowPaging = false;
            dd.Rebind();
            int x = grvRpt.MasterTableView.Items.Count;
            foreach (GridDataItem item in dd.MasterTableView.Items)
            {
                dr = dt.NewRow();
                int j = 0;
                for (int i = 0; i < grvRpt.MasterTableView.Columns.Count; i++)
                {
                    if (grvRpt.MasterTableView.Columns[i].Display == true)
                    {
                        //if (i == 0)
                        //{
                        //    i++;


                        //}
                        //else
                        //{

                        //    dr[i] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                        //}


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                        {
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image") && !grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Attachment"))
                            {
                                dr[j] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                                j++;
                            }

                        }
                    }
                }
                dt.Rows.Add(dr);
            }
            SpreadStreamProcessingForXLSXAndCSV(dt);
        }
        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Display Agreements")
        {
            using (MemoryStream stream = new MemoryStream())
            {
                using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
                {
                    using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
                    {
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                //make sure the width of the columns is not excessively large
                                //I reduced it to 100 in this iteration
                                columnExporter.SetWidthInPixels(100);
                            }
                        }

                        ExportHeaderRows(worksheetExporter, dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat();
                                    normalFormat.FontSize = 10;

                                    normalFormat.VerticalAlignment = SpreadVerticalAlignment.Center;
                                    normalFormat.HorizontalAlignment = SpreadHorizontalAlignment.Center;
                                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                                    {

                                        cellExporter.SetValue(item.ToString());
                                        cellExporter.SetFormat(normalFormat);
                                    }
                                }

                            }
                        }

                    }
                }

                byte[] output = stream.ToArray();


                Response.ContentType = ContentType;
                Response.Headers.Remove("Content-Disposition");
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Display Agreements", "Xlsx"));
                Response.BinaryWrite(output);
                Response.End();
            }
        }
        private void ExportHeaderRows(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat();
                format.IsBold = true;
                format.Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128));
                format.ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255));
                format.HorizontalAlignment = SpreadHorizontalAlignment.Center;
                format.VerticalAlignment = SpreadVerticalAlignment.Center;

                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                    {
                        cellExporter.SetFormat(format);
                        cellExporter.SetValue(dt.Columns[i].ColumnName);
                    }
                }
            }
        }


        protected void btnPDF_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {


                if (Session["LDisFromDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["LDisFromDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["LDisFromDate"].ToString());
                    }
                    else
                    {
                        Session["LDisFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["LDisFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                // rdfromDate.MaxDate = DateTime.Now;

                if (Session["LDisToDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["LDisToDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["LDisToDate"].ToString());
                    }
                    else
                    {
                        Session["LDisToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["LDisToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
            }
            catch(Exception ex)
            {

            }

            LoadList("");
            grvRpt.Rebind();
            StatusCount("");
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

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
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

        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void lnkPending_Click(object sender, EventArgs e)
        {
            lnkPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkapproved.Attributes.Remove("Style");
            lnkrejejected.Attributes.Remove("Style");
            lnkExpired.Attributes.Remove("Style");
            lnkALl.Attributes.Remove("Style");

            Session["ButtonMode"] = "P";
            LoadList("P");
            grvRpt.Rebind();
        }

        protected void lnkapproved_Click(object sender, EventArgs e)
        {
            lnkPending.Attributes.Remove("Style");
            lnkapproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkrejejected.Attributes.Remove("Style");
            lnkExpired.Attributes.Remove("Style");
            lnkALl.Attributes.Remove("Style");
            Session["ButtonMode"] = "A";
            LoadList("A");
            grvRpt.Rebind();
        }

        protected void lnkrejejected_Click(object sender, EventArgs e)
        {
            lnkPending.Attributes.Remove("Style");
            lnkapproved.Attributes.Remove("Style");
            lnkrejejected.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkExpired.Attributes.Remove("Style");
            lnkALl.Attributes.Remove("Style");
            Session["ButtonMode"] = "R";
            LoadList("R");
            grvRpt.Rebind();
        }

        protected void lnkExpired_Click(object sender, EventArgs e)
        {
            lnkPending.Attributes.Remove("Style");
            lnkapproved.Attributes.Remove("Style");
            lnkrejejected.Attributes.Remove("Style");
            lnkExpired.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkALl.Attributes.Remove("Style");
            Session["ButtonMode"] = "E";
            LoadList("E");
            grvRpt.Rebind();
        }

        protected void lnkALl_Click(object sender, EventArgs e)
        {
            lnkPending.Attributes.Remove("Style");
            lnkapproved.Attributes.Remove("Style");
            lnkrejejected.Attributes.Remove("Style");
            lnkExpired.Attributes.Remove("Style");
            lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["ButtonMode"] = "N";
            LoadList("N");
            grvRpt.Rebind();
        }

        protected void chkDate_CheckedChanged(object sender, EventArgs e)
        {
            if(chkDate.Checked)
            {
                Session["chkDate"] = "true";
            }
            else
            {
                Session["chkDate"] = "false";
            }
            StatusCount("");
            LoadList("");
            grvRpt.Rebind();
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
    }
}