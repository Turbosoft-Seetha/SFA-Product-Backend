using DocumentFormat.OpenXml.Wordprocessing;
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
    public partial class OrderStatusDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public string Type
        {
            get
            {
                string Type;
                Type = (Request.Params["type"]);

                return Type;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
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

                string rotID;
                Route();
                if (Session["Route"] != null)
                {
                    rotID = Session["Route"].ToString();
                    string[] ar = rotID.Split(',');
                    int k = 0;
                        foreach (RadComboBoxItem items in rdRoute.Items)
                        {
                            if (items.Value == ar[k])
                            {
                                items.Checked = true;
                                k++;
                            }
                        }
                    
                }
                else
                {
                    
                    int R = 1;
                    foreach (RadComboBoxItem itmss in rdRoute.Items)
                    {
                        itmss.Checked = true;
                        R++;
                    }
                    rotID = Rot();
                }
              //  rdfromDate.SelectedDate = DateTime.Now;

                string routeCondition = " ord_rot_ID in (" + rotID + ")";
               

                Customers(routeCondition);
                int i= 1;
                foreach (RadComboBoxItem itmss in rdCustomer.Items)
                {
                    itmss.Checked = true;
                    i++;
                }
                rotID = Rot();
                LoadQuotation();
                LoadSalesOrder();
                LoadConfirmSO();
                //LoadDelivered();
                SetActiveTile(Type);

            }
        }
        private void SetActiveTile(string type)
        {
            if (type == "QOT")
            {
                liQuotation.Attributes["class"] += " active";
            }
            else if (type == "SAL")
            {
                liSalesOrd.Attributes["class"] += " active";
            }
            else if (type == "CSO")
            {
                liConSalesOrd.Attributes["class"] += " active";
            }           
            else
            {
                liQuotation.Attributes["class"] += " active";
            }
        }
        public void Route()
        {
            string[] ar = { };
            rdRoute.DataSource = ObjclsFrms.loadList("selOrderRoutes", "sp_Dashboard",UICommon.GetCurrentUserID().ToString(),ar);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "ord_rot_ID";
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
                return "ord_rot_ID";
            }
        }
        public string Cus()
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
                return "ord_cus_ID";
            }

        }
        public void Customers(string routeCondition)
        {

            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomerforOrderdashboard", "sp_Dashboard", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }

        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("ord_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = " ord_rot_ID in (" + rotID + ")";
            Customers(routeCondition);
        }
        
        protected void grvRptQuatation_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadQuotation();
        }
        public void LoadQuotation()
        {
            string rotID;
            if (Session["Route"] != null)
            {
                rotID = Session["Route"].ToString();
            }
            else
            {
                 rotID = Rot();
            }
            
            string mode = "and O.ord_Type='D'";
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID,mode);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("ListQuotationOrder", "sp_Dashboard", mainCondition);
                grvRptQuatation.DataSource = lstDatas;
               
                if (lstDatas.Rows.Count > 0)
                {
                    lblQtncount.Text = lstDatas.Rows[0]["count"].ToString();
                }
                else
                {
                    lblQtncount.Text = "0";
                }
            }

        }
        public void LoadSalesOrder()
        {
            string rotID;
            if (Session["Route"] != null)
            {
                rotID = Session["Route"].ToString();
            }
            else
            {
                rotID = Rot();
            }
            string mode = "and O.ord_Type='O' and O.Status='P' ";
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID,mode);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("ListQuotationOrder", "sp_Dashboard", mainCondition);
                grvRptSalesOrder.DataSource = lstDatas;
               
                if (lstDatas.Rows.Count > 0)
                {
                    lblSOcount.Text = lstDatas.Rows[0]["count"].ToString();
                }
                else
                {
                    lblSOcount.Text = "0";
                }
            }

        }
        public void LoadConfirmSO()
        {
            string rotID;
            if (Session["Route"] != null)
            {
                rotID = Session["Route"].ToString();
            }
            else
            {
                rotID = Rot();
            }
            string mode = "and O.ord_Type='O' and O.Status='C'";
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID,mode);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("ListQuotationOrder", "sp_Dashboard", mainCondition);
                grvRptConfirmSO.DataSource = lstDatas;
               
                if (lstDatas.Rows.Count > 0)
                {
                    lblCSOcount.Text = lstDatas.Rows[0]["count"].ToString();
                }
                else
                {
                    lblCSOcount.Text = "0";
                }
            }

        }
        //public void LoadDelivered()
        //{
        //    string rotID;
        //    if (Session["Route"] != null)
        //    {
        //        rotID = Session["Route"].ToString();
        //    }
        //    else
        //    {
        //        rotID = Rot();
        //    }
        //    string mode = "and O.ord_Type='O' and O.Status='D'";
        //    if (!rotID.Equals("0"))
        //    {
        //        string mainCondition = "";
        //        mainCondition = mainConditions(rotID, mode);
        //        DataTable lstDatas = new DataTable();
        //        lstDatas = ObjclsFrms.loadList("ListQuotationOrder", "sp_Dashboard", mainCondition);
        //        grvRptDelivered.DataSource = lstDatas;
        //        if(lstDatas.Rows.Count>0)
        //        {
        //            lblNDcount.Text = lstDatas.Rows[0]["count"].ToString();
        //        }
        //        else
        //        {
        //            lblNDcount.Text = "0";
        //        }
                
        //    }

        //}
        public string mainConditions(string rotID, string mode)
        {
            string cusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " ord_rot_ID in (" + rotID + ") ";
             mainCondition += mode;
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string Filterby = ddlDatefilter.SelectedValue.ToString();

                if (Filterby == "ED")
                {
                    dateCondition = " and (cast(O.ord_ExpectedDelDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";
                    // dateCondition = " and cast(O.ord_ExpectedDelDate as date) <= cast('" + Date + "' as date) ";
                }
                else
                {
                    dateCondition = " and (cast(O.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";
                    //dateCondition = " and cast(O.CreatedDate as date) <= cast('" + Date + "' as date) ";
                }
                
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and ord_cus_ID in (" + cusID + ")";
                }
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            return mainCondition;
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            LoadQuotation();
            grvRptQuatation.Rebind();
            LoadSalesOrder();
            grvRptSalesOrder.Rebind();
            LoadConfirmSO();
            grvRptConfirmSO.Rebind();
           // LoadDelivered();
           // grvRptDelivered.Rebind();
        }

        protected void grvRptSalesOrder_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadSalesOrder();
        }

        protected void grvRptDelivered_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
        }

        protected void grvRptConfirmSO_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadConfirmSO();
        }

        protected void grvRptQuatation_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();

                Response.Redirect("OrderStatusDetail.aspx?Id=" + ID);
            }           
            
        }

        protected void grvRptSalesOrder_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("SODetail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();

                Response.Redirect("OrderStatusDetail.aspx?Id=" + ID);
            }
        }

        protected void grvRptConfirmSO_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("ConfirmedSODetail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();

                Response.Redirect("OrderStatusDetail.aspx?Id=" + ID);
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
    }
}