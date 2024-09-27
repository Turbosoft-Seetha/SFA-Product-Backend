using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class RouteTypes : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string date = DateTime.Parse(Session["FrmDat"].ToString()).ToString("yyyyMMdd");
                rdfromDate.SelectedDate = DateTime.Parse(Session["FrmDat"].ToString());
                rdfromDate.MaxDate = DateTime.Now;
                ViewState["date"] = date;
                VanSales();
                Delivery();
                Order();
                AR();
                Merchandising();
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

        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                DataTable lstVanStock = ObjclsFrms.loadList("SelectVanStock", "sp_RouteType", ID.ToString());
                Session["LOStatus"] = lstVanStock.Rows[0]["udp_LoadOutStatus"].ToString();
                Response.Redirect("UserDailyProcessDetail.aspx?Id=" + ID);
            }
        }

        protected void lnkVanSales_Click(object sender, EventArgs e)
        {
            string mode = "SL";
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkDelivery_Click(object sender, EventArgs e)
        {
            string mode = "DR";
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkOrder_Click(object sender, EventArgs e)
        {
            string mode = "OR";
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkAr_Click(object sender, EventArgs e)
        {
            string mode = "AR";
            LoadData(mode);
            grvRpt.DataBind();
        }

        protected void lnkMerchandising_Click(object sender, EventArgs e)
        {
            string mode = "MER";
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

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            ViewState["date"] = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            VanSales();
            Delivery();
            Order();
            AR();
            Merchandising();
            grvRpt.DataSource = "";
            grvRpt.DataBind();
        }
    }
}