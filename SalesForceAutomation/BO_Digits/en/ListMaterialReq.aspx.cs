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
    public partial class ListMaterialReq : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        public string mode
        {
            get
            {
                string mode;
                mode=Request.Params["Mode"];

                return mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                try
                {
                    if (Session["MRHStatus"] == null)
                    {
                        Session["MRHStatus"] = "";
                    }
                    else
                    {
                        rdStatus.SelectedValue = Session["MRHStatus"].ToString();
                    }

                    if (Session["MRHFDate"] != null)
                    {

                        rdfromDate.SelectedDate = DateTime.Parse(Session["MRHFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;

                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["MRHTDate"] != null)
                    {

                        rdendDate.SelectedDate = DateTime.Parse(Session["MRHTDate"].ToString());
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
                    GetGridSession(grvRpt, "MaterialRequestHeader");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }


            }
        }

        public string mainConditions()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string mainCondition = "";
            string status = Session["MRHStatus"].ToString();
            string statusCondition = "";

            string dateCondition = "";
            try
            {
                if (status.Equals(""))
                {
                    statusCondition = " isnull(mrh_Status,'P') in (mrh_Status)";
                }
                else
                {
                    statusCondition = "  isnull(mrh_Status,'P') in ('" + status + "')";
                }

                dateCondition = " (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) and";
            }
            catch (Exception ex)
            {

            }
            if(mode!=null)
            {
                if (mode.Equals("DB"))

                {
                    status = "P";
                    statusCondition = "  isnull(mrh_Status,'P') in ('" + status + "')";
                    mainCondition += statusCondition;
                    pnlFilter.Visible = false;
                }
                else
                {
                    mainCondition += dateCondition;
                    mainCondition += statusCondition;
                    pnlFilter.Visible = true;
                }
            }
            else
            {
                mainCondition += dateCondition;
                mainCondition += statusCondition;
                pnlFilter.Visible = true;
            }
            
            return mainCondition;
        }

        public void LoadList()
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            DataTable lstUser = default(DataTable);
            lstUser = obj.loadList("ListMRHeader", "sp_MaterialRequest", mainCondition);
            grvRpt.DataSource = lstUser;
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                Session["MRHStatus"] = rdStatus.SelectedValue.ToString();

                if (Session["MRHFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["MRHFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["MRHFDate"].ToString());
                    }
                    else
                    {
                        Session["MRHFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["MRHFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["MRHTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["MRHTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["MRHTDate"].ToString());
                    }
                    else
                    {
                        Session["MRHTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["MRHTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);



            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;
                SetGridSession(grd, "MaterialRequestHeader");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("mrh_ID").ToString();
                Response.Redirect("MaterialReqHederDetail.aspx?HID=" + ID);
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

        protected void lnkAddMR_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateMR.aspx");
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