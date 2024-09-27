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
    public partial class RouteTypes : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["mode"] = ""; 

                string date = "";
                try
                {
                    date = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
                }
                catch(Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                 
                rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                rdfromDate.MaxDate = DateTime.Now;
                ViewState["date"] = date;
                VanSales();
                Delivery();
                Order();
                AR();
                Merchandising();
                OrderandAR();
                FEILDSERVICE();
                DELIVERY();
            }
        }

        public void LoadData(string mode)
        {
            string date = ViewState["date"].ToString();
            string[] arr = { mode, date };
            DataTable lstRouteType = default(DataTable);
            lstRouteType = ObjclsFrms.loadList("SelectRouteTypeGrid", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            grvRpt.DataSource = lstRouteType;
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            string mode = ViewState["mode"].ToString() ;
            if(mode == "")
            {
                mode = "SL";
            }
            LoadData(mode);
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                DataTable lstVanStock = ObjclsFrms.loadList("SelectVanStock", "sp_RouteType", ID.ToString());
                Session["LOStatus"] = lstVanStock.Rows[0]["udp_LoadOutStatus"].ToString();
                Session["fDate"] = rdfromDate.SelectedDate.ToString();
                Session["TDate"] = rdfromDate.SelectedDate.ToString();
                Response.Redirect("UserDailyProcessDetail.aspx?Id=" + ID);
            }
        }

        protected void lnkVanSales_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "blue";
            lnkOrder.Style["color"] = "black";
            lnkAr.Style["color"] = "black";
            lnkOrderandAR.Style["color"] = "black";
            lnkDel.Style["color"] = "black";
            lnkMerchandising.Style["color"] = "black";
            lnkFS.Style["color"] = "black";
            string mode = "SL";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkDelivery_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "black";
            lnkOrder.Style["color"] = "black";
            lnkAr.Style["color"] = "black";
            lnkOrderandAR.Style["color"] = "black";
            lnkDel.Style["color"] = "blue";
            lnkMerchandising.Style["color"] = "black";
            lnkFS.Style["color"] = "black";
            string mode = "DR";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkOrder_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "black";
            lnkOrder.Style["color"] = "blue";
            lnkAr.Style["color"] = "black";
            lnkOrderandAR.Style["color"] = "black";
            lnkDel.Style["color"] = "black";
            lnkMerchandising.Style["color"] = "black";
            lnkFS.Style["color"] = "black";
            string mode = "OR";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkAr_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "black";
            lnkOrder.Style["color"] = "black";
            lnkAr.Style["color"] = "blue";
            lnkOrderandAR.Style["color"] = "black";
            lnkDel.Style["color"] = "black";
            lnkMerchandising.Style["color"] = "black";
            lnkFS.Style["color"] = "black";

            string mode = "AR";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkMerchandising_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "black";
            lnkOrder.Style["color"] = "black";
            lnkAr.Style["color"] = "black";
            lnkOrderandAR.Style["color"] = "black";
            lnkDel.Style["color"] = "black";
            lnkMerchandising.Style["color"] = "blue";
            lnkFS.Style["color"] = "black";

            string mode = "MER";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }

        public void VanSales()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeSL = default(DataTable);
            lstRouteTypeSL = ObjclsFrms.loadList("SelectVanSalesRoutes", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lblVanTotal.Text = lstRouteTypeSL.Rows[0]["startDay"].ToString();
            lblVanStart.Text = lstRouteTypeSL.Rows[0]["startDay"].ToString();
            lblVanLin.Text = lstRouteTypeSL.Rows[0]["loadIn"].ToString();
            lblVanLout.Text = lstRouteTypeSL.Rows[0]["loadOut"].ToString();
            lblVanSettle.Text = lstRouteTypeSL.Rows[0]["settlement"].ToString();
            lblVanEnd.Text = lstRouteTypeSL.Rows[0]["endDay"].ToString();
        }

        public void Delivery()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeDR = default(DataTable);
            lstRouteTypeDR = ObjclsFrms.loadList("SelectDeliveryRoutes", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lblDeliveryTotal.Text = lstRouteTypeDR.Rows[0]["startDay"].ToString();
            lblDeliveryStart.Text = lstRouteTypeDR.Rows[0]["startDay"].ToString();
            lblDeliveryLin.Text = lstRouteTypeDR.Rows[0]["loadIn"].ToString();
            lblDeliveryLout.Text = lstRouteTypeDR.Rows[0]["loadOut"].ToString();
            lblDeliverySettle.Text = lstRouteTypeDR.Rows[0]["settlement"].ToString();
            lblDeliveryEnd.Text = lstRouteTypeDR.Rows[0]["endDay"].ToString();
        }

        public void Order()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeOR = default(DataTable);
            lstRouteTypeOR = ObjclsFrms.loadList("SelectOrderRoutes", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lblOrderTotal.Text = lstRouteTypeOR.Rows[0]["startDay"].ToString();
            lblOrderStart.Text = lstRouteTypeOR.Rows[0]["startDay"].ToString();
            lblOrderSettle.Text = lstRouteTypeOR.Rows[0]["settlement"].ToString();
            lblOrderEnd.Text = lstRouteTypeOR.Rows[0]["endDay"].ToString();
        }

        public void AR()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeAR = default(DataTable);
            lstRouteTypeAR = ObjclsFrms.loadList("SelectARRoutes", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lblArTotal.Text = lstRouteTypeAR.Rows[0]["startDay"].ToString();
            lblArStart.Text = lstRouteTypeAR.Rows[0]["startDay"].ToString();
            lblArSettle.Text = lstRouteTypeAR.Rows[0]["settlement"].ToString();
            lblArEnd.Text = lstRouteTypeAR.Rows[0]["endDay"].ToString();
        }

        public void Merchandising()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeMER = default(DataTable);
            lstRouteTypeMER = ObjclsFrms.loadList("SelectMerchandisingRoutes", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lblMerchTotal.Text = lstRouteTypeMER.Rows[0]["startDay"].ToString();
            lblMerchStart.Text = lstRouteTypeMER.Rows[0]["startDay"].ToString();
            lblMerchEnd.Text = lstRouteTypeMER.Rows[0]["endDay"].ToString();
        }

        public void OrderandAR()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeORAR = default(DataTable);
            lstRouteTypeORAR = ObjclsFrms.loadList("SelectOrderandARRoutes", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lbtotalORandAR.Text = lstRouteTypeORAR.Rows[0]["startDay"].ToString();
            lblOASday.Text = lstRouteTypeORAR.Rows[0]["startDay"].ToString();
            lblORARset.Text = lstRouteTypeORAR.Rows[0]["settlement"].ToString();

            lblOAeday.Text = lstRouteTypeORAR.Rows[0]["endDay"].ToString();
        }

        public void FEILDSERVICE()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeFS = default(DataTable);
            lstRouteTypeFS = ObjclsFrms.loadList("SelectFeildServiceRoute", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lbltotFS.Text = lstRouteTypeFS.Rows[0]["startDay"].ToString();
            lblFSsday.Text = lstRouteTypeFS.Rows[0]["startDay"].ToString();
            lblFSloadin.Text = lstRouteTypeFS.Rows[0]["loadIn"].ToString();
            lblFSloadout.Text = lstRouteTypeFS.Rows[0]["loadOut"].ToString();
            lblFSsett.Text = lstRouteTypeFS.Rows[0]["settlement"].ToString();
            lblFSeday.Text = lstRouteTypeFS.Rows[0]["endDay"].ToString();
        }

        public void DELIVERY()
        {
            string date = ViewState["date"].ToString();
            string[] arr = { date };
            DataTable lstRouteTypeDL = default(DataTable);
            lstRouteTypeDL = ObjclsFrms.loadList("SelectDeliveryRoute", "sp_RouteType", UICommon.GetCurrentUserID().ToString(), arr);
            lbltotDL.Text = lstRouteTypeDL.Rows[0]["startDay"].ToString();
            lblDELsday.Text = lstRouteTypeDL.Rows[0]["startDay"].ToString();
            lblDLloadin.Text = lstRouteTypeDL.Rows[0]["loadIn"].ToString();
            lblDLloadout.Text = lstRouteTypeDL.Rows[0]["loadOut"].ToString();
            lblDLsett.Text = lstRouteTypeDL.Rows[0]["settlement"].ToString();
            lblDLeday.Text = lstRouteTypeDL.Rows[0]["endDay"].ToString();
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            ViewState["date"] = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            VanSales();
            Delivery();
            Order();
            AR();
            Merchandising();
            OrderandAR();
            FEILDSERVICE();
            DELIVERY();
            grvRpt.DataSource = "";
            grvRpt.DataBind();
        }

        protected void lnkOrderandAR_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "black";
            lnkOrder.Style["color"] = "black";
            lnkAr.Style["color"] = "black";
            lnkOrderandAR.Style["color"] = "blue";
            lnkDel.Style["color"] = "black";
            lnkMerchandising.Style["color"] = "black";
            lnkFS.Style["color"] = "black";

            string mode = "OA";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkFS_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "black";
            lnkOrder.Style["color"] = "black";
            lnkAr.Style["color"] = "black";
            lnkOrderandAR.Style["color"] = "black";
            lnkDel.Style["color"] = "black";
            lnkMerchandising.Style["color"] = "black";
            lnkFS.Style["color"] = "blue";

            string mode = "FS";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkDel_Click(object sender, EventArgs e)
        {
            lnkVanSales.Style["color"] = "black";
            lnkOrder.Style["color"] = "black";
            lnkAr.Style["color"] = "black";
            lnkOrderandAR.Style["color"] = "black";
            lnkDel.Style["color"] = "blue";
            lnkMerchandising.Style["color"] = "black";
            lnkFS.Style["color"] = "black";

            string mode = "DL";
            ViewState["mode"] = mode;
            LoadData(mode);
            grvRpt.DataBind();
        }
    }
}