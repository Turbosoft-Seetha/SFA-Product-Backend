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
    public partial class ListCustomerOutStockDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
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
                if (Mode == 0)
                {
                    RadPanelBar0.Visible = true;
                    RadPanelBar1.Visible = false;
                    CustomerHeader();
                }
                else
                {
                    RadPanelBar0.Visible = false;
                    RadPanelBar1.Visible = true;
                    ItemHeader();
                }
            }
        }
        public void ListData()
        {
            string fromdate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
            string todate = DateTime.Parse(Session["ToDate"].ToString()).ToString("yyyyMMdd");
            string[] arr = { fromdate, todate };

            DataTable lstUser = default(DataTable);
            if (Mode == 0)
            {
                lstUser = ObjclsFrms.loadList("SelectCustomerOutOfStockDetail", "sp_Merch_Dashboard", ResponseID.ToString(), arr);
            }
            else
            {
                lstUser = ObjclsFrms.loadList("SelectItemOutOfStockDetail", "sp_Merch_Dashboard", ResponseID.ToString(), arr);
            }
            grvRpt.DataSource = lstUser;
        }
        public void CustomerHeader()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectCustomerOutOfStockHeader", "sp_Merch_Dashboard", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblDate = (Label)rp.FindControl("lblDate");

                lblRoute.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblDate.Text = lstDatas.Rows[0]["dph_Date"].ToString();
            }
        }

        public void ItemHeader()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectItemOutOfStockHeader", "sp_Merch_Dashboard", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar1.Items[0];
                Label lblProduct = (Label)rp.FindControl("lblProduct");
                Label lblCategory = (Label)rp.FindControl("lblCategory");
                Label lblSubcategory = (Label)rp.FindControl("lblSubcategory");
                Label lblDescription = (Label)rp.FindControl("lblDescription");
                Label lblDates = (Label)rp.FindControl("lblDates");

                lblProduct.Text = lstDatas.Rows[0]["prd_Name"].ToString();
                lblCategory.Text = lstDatas.Rows[0]["cat_Name"].ToString();
                lblSubcategory.Text = lstDatas.Rows[0]["sct_Name"].ToString();
                lblDescription.Text = lstDatas.Rows[0]["prd_ItemLongDesc"].ToString();
                lblDates.Text = lstDatas.Rows[0]["dph_Date"].ToString();
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            grvRpt.MasterTableView.GetColumn("Id").Visible = false;
        }
    }
}