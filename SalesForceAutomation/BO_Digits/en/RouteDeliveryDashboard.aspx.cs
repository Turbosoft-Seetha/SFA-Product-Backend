using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteDeliveryDashboard : System.Web.UI.Page
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
                if (Mode == 1) // While loading page from dashboard 
                {
                    try
                    {
                        if (Session["FromDate"] != null)
                        {
                            rdFromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                        }
                        else 
                        {
                            rdFromDate.SelectedDate = DateTime.Now;
                            Session["FromDate"] = rdFromDate.SelectedDate.ToString();
                        }
                        if (Session["ToDate"] != null)
                        {
                            rdEndDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());

                        }
                        else
                        {
                            rdEndDate.SelectedDate = DateTime.Now;
                            Session["ToDate"] = rdEndDate.SelectedDate.ToString();
                        }

                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }

                  
                }
                else
                {
                    //ViewState["FromDate"] = DateTime.Parse(Session["FromDate"].ToString());
                    //ViewState["route"] = Session["rdRoute"].ToString();
                    //Session["UdpDate"] = ViewState["FromDate"].ToString();
                    //Session["UdpRoute"] = ViewState["route"].ToString();

                    try
                    {
                        if (Session["FromDate"] != null)
                        {
                            rdFromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                        }
                        else
                        {
                            rdFromDate.SelectedDate = DateTime.Now;
                            Session["FromDate"] = rdFromDate.SelectedDate.ToString();
                        }
                        if (Session["ToDate"] != null)
                        {
                            rdEndDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());

                        }
                        else
                        {
                            rdEndDate.SelectedDate = DateTime.Now;
                            Session["ToDate"] = rdEndDate.SelectedDate.ToString();
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
               

                Route();
                foreach (RadComboBoxItem itmss in rdRoute.Items)
                {
                    itmss.Checked = true;

                }
                string rotID = Rot();
                Customers();
                SelAllDelivery();
                SelFDDelivery();
                SelNDDelivery();
                SelPDDelivery();
                SelAllDelcount();
                SelFDDelCount();
                SelPDDelCount();
                SelNDDelCount();

                SetActiveTile(Type);
            }
        }

        private void SetActiveTile(string type)
        {
            if (type == "AL")
            {
                liAllDeliveries.Attributes["class"] += " active"; 
            }
            else if (type == "FD")
            {
                liFullyDelivered.Attributes["class"] += " active"; 
            }
            else if (type == "PD")
            {
                liPartiallyDelivered.Attributes["class"] += " active"; 
            }
            else if (type == "ND")
            {
                liNotDelivered.Attributes["class"] += " active";
            }
            else
            {
                liAllDeliveries.Attributes["class"] += " active";
            }
        }
        public void Route()
        {
            string fdate, todate;
            fdate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            todate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string[] arr = { todate };
            rdRoute.DataSource = ObjclsFrms.loadList("SelDeliveryRoute", "sp_Report", fdate, arr);
            
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Customer(DataTable dt)
        {
            DataTable distinctDataTable = dt;             

            rdCustomer.DataSource = dt;
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Customers()
        {
            string fdate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string todate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string[] arr = { todate };
            rdCustomer.DataSource = ObjclsFrms.loadList("SelRouteCustomers", "sp_Report",fdate,arr);
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
                return "ord_AssignedRot";
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
            string mainCondition = " ord_AssignedRot in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
                //dateCondition = " and (cast(B.ord_ExpectedDelDate as date) = cast('" + fromDate + "' as date)) ";
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
            if (dt.Rows.Count>=0)
            {
                grvRptAll.DataSource = dt;
            }
           


        }

        public void SelFDDelivery()
        {
            DataTable dt = LoadData("SelectFDRotDel");
            if (dt.Rows.Count >= 0)
            {
                grvRptFD.DataSource = dt;
            }
           

        }
        public void SelNDDelivery()
        {
            DataTable dt = LoadData("SelectNotDelRotDel");
            if (dt.Rows.Count >= 0)
            {
                grvRptND.DataSource = dt;
            }
           

        }
        public void SelPDDelivery()
        {
            DataTable dt = LoadData("SelectPDRotDel");
            if (dt.Rows.Count >= 0)
            {
                grvRptPD.DataSource = dt;
            }
           

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
                lblFDCount.Text = count ;
            }
        }
        public void SelPDDelCount()
        {
            DataTable dt = LoadData("SelectPDRotDelCount");
            if (dt.Rows.Count > 0)
            {
                string count;
                count = dt.Rows[0]["count"].ToString();
                lblPDCount.Text = count ;
            }
        }
        public void SelNDDelCount()
        {
            DataTable dt = LoadData("SelectNotDelRotDelCount");
            if (dt.Rows.Count > 0)
            {
                string count;
                count = dt.Rows[0]["count"].ToString();
                lblNDCount.Text = count ;
            }
        }



        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            //    string rotID = Rot();
            //    Customers(rotID);
            }

            protected void Filter_Click(object sender, EventArgs e)
        {
            SelAllDelivery();

            SelFDDelivery();
            SelNDDelivery();

            SelAllDelcount();

            SelFDDelCount();
            SelNDDelCount();
            SelPDDelCount();
            grvRptAll.Rebind();

            grvRptFD.Rebind();
            grvRptPD.Rebind();
            grvRptND.Rebind();
        }

        protected void grvRptAll_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            SelAllDelivery();
        }

        protected void grvRptAll_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();

                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }


        protected void grvRptFD_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            SelFDDelivery();
        }

        protected void grvRptFD_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();

                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }

        protected void grvRptPD_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            SelPDDelivery();
        }

        protected void grvRptPD_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();

                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }

        protected void grvRptND_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            SelNDDelivery();
        }

        protected void grvRptND_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ord_ID").ToString();

                Response.Redirect("RouteDeliveryDetail.aspx?Id=" + ID);
            }
        }
    }
}
