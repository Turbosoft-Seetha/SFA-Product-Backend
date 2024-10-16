using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GoogleApi.Entities.Interfaces;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class FreeSampleApprovalHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                try
                {
                    if (Session["faStatus"] == null)
                    {
                        Session["faStatus"] = "";
                    }
                    else
                    {
                        rdStatus.SelectedValue = Session["faStatus"].ToString();
                    }

                    if (Session["faFDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["faFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["faTDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["faTDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now.AddDays(1);
                    }
                    rdendDate.MaxDate = DateTime.Now.AddDays(1);
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    Route();
                    if (Session["farotid"] != null)
                    {
                        string routeID = Session["farotid"].ToString();
                        string[] ar = routeID.Split(',');
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
                        string rotid = curot();
                        string routecondition = " fsh_rot_ID  in (" + rotid + ")";
                    }
                    Customers();
                    if (Session["facusID"] != null)
                    {
                        int a = rdCustomer.Items.Count;
                        string cusID = Session["facusID"].ToString();
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
                        string cusID = Cu_Cus();
                        string cusCondition = "A.cus_ID in (" + cusID + ")";
                    }
                }
                catch
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    GetGridSession(grvRpt, "FreeSampleApprovalHeader");
                    grvRpt.Rebind();
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
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
        public void Customers()
        {

            string rotid = curot();
            string routeCondition = " fsh_rot_ID in (" + rotid + ")";
            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomers", "sp_SFA_App_Sales", routeCondition.ToString());
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Route()
        {

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { toDate.ToString() };
            rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_SFA_App_Sales", fromDate.ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public string Cu_Cus()
        {
            var CollectionMarket = rdCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "fsh_cus_ID";
            }

        }
        public string curot()
        {
            var CollectionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
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
                return "fsh_rot_ID";
            }
        }
        public string mainConditions()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rotid = curot();
            string customer = Cu_Cus();
            string status = Session["faStatus"].ToString();
            string mainCondition = "";
            string customerCondition = "";
            string rotCondition = "";
            string statusCondition = "";
            string dateCondition = "";
            try
            {
                if (status.Equals(""))
                {
                    statusCondition = "and isnull(A.Status,'P') in ('P')";
                }
                else
                {
                    statusCondition = " and isnull(A.Status,'P')  in ('" + status + "')";
                }
                dateCondition = "  and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";
                if (rotid.Equals("0"))
                {
                    rotCondition = "";
                }
                else
                {
                    rotCondition = " and fsh_rot_ID in (" + rotid + ")";
                }
                if (customer.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " fsh_cus_ID in (" + customer + ")";
                }
            }
            catch (Exception ex)
            {

            }
            mainCondition += customerCondition;
            mainCondition += rotCondition;
            mainCondition += dateCondition;
            mainCondition += statusCondition;
            return mainCondition;
        }
        public void LoadList()
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListFreeSampleApprovalHeader", "sp_SFA_App_Sales", mainCondition);
            grvRpt.DataSource = lstUser;
        }


        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {

            try
            {
                Session["faStatus"] = rdStatus.SelectedValue.ToString();

                if (Session["faFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["faFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["faFDate"].ToString());
                    }
                    else
                    {
                        Session["faFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["faFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["faTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["faTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["faTDate"].ToString());
                    }
                    else
                    {
                        Session["faTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["faTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);
                if (Session["farotid"] != null)
                {
                    string routeID = curot();
                    if (routeID == Session["farotid"].ToString())
                    {
                        string rotid = curot();
                    }
                    else
                    {
                        string rotid = curot();
                        Session["farotid"] = rotid;
                    }
                }
                else
                {
                    string rotid = curot();
                    Session["farotid"] = rotid;
                }
                if (Session["facusID"] != null)
                {
                    string customer = Cu_Cus();
                    if (customer == Session["facusID"].ToString())
                    {
                        string cusID = Cu_Cus();

                    }
                    else
                    {
                        string cusID = Cu_Cus();
                        Session["facusID"] = cusID;
                    }
                }
                else
                {
                    string cusID = Cu_Cus();
                    Session["facusID"] = cusID;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.Rebind();
        }
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Route();
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
            Route();
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
        protected void Rdcushead_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customers();
        }

        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "FreeSampleApprovalHeader");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

            if (e.CommandName.Equals("Details"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem != null)
                {
                    string ID = dataItem.GetDataKeyValue("fsh_ID").ToString();
                    Console.WriteLine("ID", ID);
                    //string Mode = dataItem["Mode"].Text.ToString();

                    Response.Redirect("FreeSampleApprovalDetail.aspx?FAID=" + ID);

                }
            }
        }
        protected void save_Click(object sender, EventArgs e)
        {
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
        }

    }
}
