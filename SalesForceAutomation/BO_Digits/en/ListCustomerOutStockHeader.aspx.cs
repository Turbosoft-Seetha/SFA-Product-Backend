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
    public partial class ListCustomerOutStockHeader : System.Web.UI.Page
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


            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
        public string mainConditions(string rotID)
        {


            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(Session["ToDate"].ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(D.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";

            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;

            return mainCondition;
        }

        public void ListData()
        {
            string mainCondition = mainConditions(Session["Route"].ToString());
            DataTable lstdata = new DataTable();
            if (Mode == 0)
            {
                lstdata = ObjclsFrms.loadList("SelectCustomerOutOfStock", "sp_Merch_Dashboard", mainCondition);
            }
            else
            {
                lstdata = ObjclsFrms.loadList("SelectItemOutOfStock", "sp_Merch_Dashboard", mainCondition);
            }
            grvRpt.DataSource = lstdata;
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("Id").ToString();
                Response.Redirect("ListCustomerOutStockDetail.aspx?Id=" + ID + "&mode=" + Mode.ToString());
            }
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            grvRpt.MasterTableView.GetColumn("Id").Visible = false;
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {

        }
    }
}