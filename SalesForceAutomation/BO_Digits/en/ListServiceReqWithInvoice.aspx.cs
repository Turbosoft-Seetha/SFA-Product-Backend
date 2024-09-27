using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListServiceReqWithInvoice : System.Web.UI.Page
    {
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["mode"], out Mode);

                return Mode;
            }
        }
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                plhFilter.Visible = false;
                Region();
                if (Mode == 1) // While loading page from dashboard 
                {
                    try
                    {
                        rdRoute.Enabled = false;
                        rdCustomer.Enabled = false;
                        rdfromDate.Enabled = false;
                        rdendDate.Enabled = false;

                        if (Session["StartDate"] != null)
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(Session["StartDate"].ToString());
                        }
                        if (Session["EndDate"] != null)
                        {
                            rdendDate.SelectedDate = DateTime.Parse(Session["EndDate"].ToString());
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("SignIn.aspx");
                    }

                    try
                    {
                        GetGridSession(grvRpt, "ASJ");

                        grvRpt.Rebind();
                    }

                    catch (Exception ex)
                    {
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AllServiceJobs.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                    }


                }
                else
                {
                    try
                    {
                        if (Session["SRHIFromDate"] != null)
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(Session["SRHIFromDate"].ToString());
                        }
                        else
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                        }
                        if (Session["SRHITromDate"] != null)
                        {
                            rdendDate.SelectedDate = DateTime.Parse(Session["SRHITromDate"].ToString());
                        }
                        else
                        {
                            rdendDate.SelectedDate = DateTime.Now; ;
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

                        if (Session["SRHIrotID"] != null)
                        {
                            int a = rdRoute.Items.Count;
                            string rotID = Session["SRHIrotID"].ToString();
                            string[] ar = rotID.Split(',');
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
                            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                            Customer(routeCondition);

                        }
                        else
                        {
                            string rotID = Rot();
                            string routeCondition = " sjh_rot_ID in (" + rotID + ")";
                            Customer(routeCondition);


                        }

                        if (Session["SRHIcusID"] != null)
                        {
                            int a = rdCustomer.Items.Count;
                            string cusID = Session["SRHIcusID"].ToString();
                            string[] ar = cusID.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdCustomer.Items)
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
                            string cusID = Cus();
                            string customerCondition = " snr_cus_ID in (" + cusID + ")";
                        }

                        try
                        {
                            GetGridSession(grvRpt, "SRHI");
                            grvRpt.Rebind();
                        }

                        catch (Exception ex)
                        {
                            String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                            ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ServiceRequestHeader.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }

                }
            }
        }

        public void LoadJobs()
        {
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainConditions(rotID);
            DataTable lstdata = ObjclsFrms.loadList("ServiceReqJobHeaderWithInvoice", "sp_Transaction", mainCondition);
            if (lstdata.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstdata;
            }
        }


        public string mainConditions(string rotID)
        {
            string cusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " sjh_rot_ID in (" + rotID + ")";

            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.ModifiedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and sjh_cus_ID in (" + cusID + ")";
                }
                if (rdfromDate.SelectedDate.ToString() == "" || rdendDate.SelectedDate.ToString() == "")
                {
                    dateCondition = "";

                }
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            return mainCondition;
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadJobs();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Invoice"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sjh_ID").ToString();

                Response.Redirect("serviceReqInvoiceDetail.aspx?JobID=" + ID.ToString());
            }
        }

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void ddldepot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
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
        protected void ddldpoArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
        }

        protected void ddldpoSubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
        }

        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("udp_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = "rcs_rot_ID in (" + rotID + ")";
            Customer(routeCondition);
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

            }

        }
        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {


                if (Session["SRHIFromDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["SRHIFromDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["SRHIFromDate"].ToString());
                    }
                    else
                    {
                        Session["SRHIFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["SRHIFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                // rdfromDate.MaxDate = DateTime.Now;

                if (Session["SRHIToDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["SRHIToDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["SRHIToDate"].ToString());
                    }
                    else
                    {
                        Session["SRHIToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["SRHIToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                // rdendDate.MaxDate = DateTime.Now.AddDays(1);

                if (Session["SRHIrotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["SRHIrotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["SRHIrotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["SRHIrotID"] = rotID;
                }

                if (Session["SRHIcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["SRHIcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["SRHIcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["SRHIcusID"] = cusID;
                }


            }
            catch (Exception ex)
            {

            }

            LoadJobs();
            grvRpt.Rebind();
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
                Response.Redirect("SignIn.aspx");
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
                Response.Redirect("SignIn.aspx");
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
            catch (Exception ex) { Response.Redirect("SignIn.aspx"); }
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
            catch (Exception ex) { Response.Redirect("SignIn.aspx"); }
        }

        public void Customer(string routeCondition)
        {
            rdCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerByRoute", "sp_Transaction", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
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
                Response.Redirect("SignIn.aspx");
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

        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in rdCustomer.Items)
            {
                itme.Checked = true;
                k++;
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
                return "sjh_rot_ID";
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