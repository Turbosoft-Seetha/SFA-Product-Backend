using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteDeliveries : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //ViewState["FromDate"] = DateTime.Parse(Session["FromDate"].ToString());
                //ViewState["route"] = Session["rdRoute"].ToString();
                //Session["UdpDate"] = ViewState["FromDate"].ToString();
                //Session["UdpRoute"] = ViewState["route"].ToString();
                try
                {
                    rdDate.SelectedDate = DateTime.Parse(Session["fdate"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());

                    //rdRoute.SelectedValue = Session["Route"].ToString();
                }
                catch(Exception ex)
                {
                   
                }
                
                Route();
                foreach (RadComboBoxItem itmss in rdRoute.Items)
                {
                    itmss.Checked = true;
                   
                }
                string rotID = Rot();
                Customers(rotID);
                SelAllDelivery();
                SelFDDelivery();
                SelNDDelivery();
                SelAllDelcount();
                SelFDDelCount();
                SelNDDelCount();
            }
        }
        public void Route()
        {
            string fdate, todate;
            fdate = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            todate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string[] arr = { todate};
            rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_Report",fdate ,arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Customers(string rotID)
        {

            rdCustomer.DataSource = ObjclsFrms.loadList("SelRouteCustomers", "sp_Report", rotID);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
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
                return "0";
            }

        }
        public DataTable LoadData(string mode)
        {

            //string[] arr = new string[] { DateTime.Parse(ViewState["FromDate"].ToString()).ToString("yyyy-MM-dd") };
            //DataTable dt = ObjclsFrms.loadList(mode, "sp_Report", ViewState["route"].ToString(), arr);
            string rotID = Rot();
           
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                
                DataTable dt = ObjclsFrms.loadList(mode, "sp_Report", mainCondition);
                return dt;

            
           
        }
        public string mainConditions(string rotID)
        {
            string cusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " ord_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
                dateCondition = " and (cast(B.ord_ExpectedDelDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
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

        public void SelAllDelivery()
        {
            DataTable dt = LoadData("SelecttotOrder");
            grvRpt.DataSource = dt;
           

        }
        
        public void SelFDDelivery()
        {
            DataTable dt = LoadData("SelectFDRotDel");
            RadGrid3.DataSource = dt;
            
        }
        public void SelNDDelivery()
        {
            DataTable dt = LoadData("SelectNotDelRotDel");
            RadGrid4.DataSource = dt;
           
        }
        public void SelAllDelcount()
        {
            DataTable dt = LoadData("SelecttotOrderCount");
            if (dt.Rows.Count > 0)
            {
                string count;
                count = dt.Rows[0]["count"].ToString();
                lblAllCount.Text = count;
            }

        }
        
       
        public void SelFDDelCount()
        {
            DataTable dt = LoadData("SelectRotDelCount");
            if (dt.Rows.Count > 0)
            {
                string count;
                count = dt.Rows[0]["count"].ToString();
                lblFDCount.Text = count + '/' + lblAllCount.Text;
            }
        }
        public void SelNDDelCount()
        {
            DataTable dt = LoadData("SelectNotDelRotDelCount");
            if (dt.Rows.Count > 0)
            {
                string count;
                count = dt.Rows[0]["count"].ToString();
                lblNDCount.Text = count + '/' + lblAllCount.Text;
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
          
            SelAllDelivery();
           
            SelFDDelivery();
            SelNDDelivery();

            SelAllDelcount();
            
            SelFDDelCount();
            SelNDDelCount();

            grvRpt.Rebind();
            
            RadGrid3.Rebind();
            RadGrid4.Rebind();
        }

        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            Customers(rotID);
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            SelAllDelivery();
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();
               
                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }

       
        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();
                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }

       

        protected void RadGrid2_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();
                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            SelFDDelivery();
        }

        protected void RadGrid3_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sal_ID").ToString();
                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }

        protected void RadGrid4_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            SelNDDelivery();
        }

        protected void RadGrid4_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();
                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }

        protected void rdDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Route();
        }

        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Route();
        }
    }
}