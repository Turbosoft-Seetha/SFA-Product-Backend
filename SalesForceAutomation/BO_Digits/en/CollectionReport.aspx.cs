using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CollectionReport : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    if (Session["CReFDate"] != null)
                    {

                        rdfromDate.SelectedDate = DateTime.Parse(Session["CReFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;


                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["CReTDate"] != null)
                    {

                        rdendDate.SelectedDate = DateTime.Parse(Session["CReTDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;

                    }
                    rdendDate.MaxDate = DateTime.Now;
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                
                Route();
                try
                {
                    if (Session["CRErotID"] != null)
                    {
                        int a = rdRoute.Items.Count;
                        string route = Session["CRErotID"].ToString();
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
                        int j = 1;
                        foreach (RadComboBoxItem itmss in rdRoute.Items)
                        {
                            itmss.Checked = true;
                            j++;
                        }
                    }
                }
                catch(Exception ex)
                {

                }
                try
                {
                    GetGridSession(grvRptInvoice, "CRInv");

                    grvRptInvoice.Rebind();

                    GetGridSessionAR(grvRptAR, "CRAR");

                    grvRptAR.Rebind();

                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

            }

        }

        public void LoadDataAR()
        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("SelARforReport", "sp_Masters", mainCondition);
                if (lstDatas.Rows.Count > 0)
                {
                    grvRptAR.DataSource = lstDatas;

                }
                else
                {
                    grvRptAR.DataSource = lstDatas;
                }
            }

        }
        public void LoadDataInv()
        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("SelInvoiceforReport", "sp_Masters", mainCondition);
                if (lstDatas.Rows.Count > 0)
                {

                    grvRptInvoice.DataSource = lstDatas;

                }
                else
                {
                    grvRptInvoice.DataSource = lstDatas;
                }
            }

        }

        protected void grvRptInvoice_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadDataInv();
        }

        protected void grvRptAR_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadDataAR();
        }

        protected void Filter_Click(object sender, EventArgs e)
        {

            try
            {
                if (Session["CReFDateCR"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["CRFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["CRFDate"].ToString());
                    }
                    else
                    {
                        Session["CRFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["CReFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["CReTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["CReTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["CReTDate"].ToString());
                    }
                    else
                    {
                        Session["CReTDateCRe"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["CReTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);



                if (Session["CRErotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["CRErotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["CRErotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["CRErotID"] = rotID;
                }


            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

            
            LoadDataInv();
            grvRptInvoice.Rebind();
            LoadDataAR();
            grvRptAR.Rebind();

        }

        public string mainConditions(string rotID)
        {

            string dateCondition = "";
            string mainCondition = "  and udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(C.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date)) ";

            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;

            return mainCondition;
        }
        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("RouteforReport", "sp_Masters");
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public string Rot()
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

                    grvRptInvoice.MasterTableView.FilterExpression = filterExpression;

                }



            }

            catch (Exception ex)

            {

                Response.Redirect("~/SignIn.aspx");

            }

        }

        public void GetGridSessionAR(RadGrid grd, string SessionPrefix)

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

                    grvRptAR.MasterTableView.FilterExpression = filterExpression;

                }



            }

            catch (Exception ex)

            {

                Response.Redirect("~/SignIn.aspx");

            }

        }
        protected void grvRptAR_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "CRAR");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }

        protected void grvRptInvoice_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "CRInv");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }
    }
}