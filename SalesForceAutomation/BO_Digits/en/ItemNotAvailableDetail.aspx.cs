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
    public partial class ItemNotAvailableDetail : System.Web.UI.Page
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectItemNotAvailableHeader", "sp_Merch_Dashboard", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblProduct = (Label)rp.FindControl("lblProduct");
                Label lblCategory = (Label)rp.FindControl("lblCategory");
                Label lblSubcategory = (Label)rp.FindControl("lblSubcategory");
                Label lblDate = (Label)rp.FindControl("lblDate");

                lblProduct.Text = lstDatas.Rows[0]["prd_Name"].ToString();
                lblCategory.Text = lstDatas.Rows[0]["cat_Name"].ToString();
                lblSubcategory.Text = lstDatas.Rows[0]["sct_Name"].ToString();
                lblDate.Text = lstDatas.Rows[0]["dph_Date"].ToString();
            }
        }
        public void ListData()
        {
            string[] arr = { DateTime.Parse(Session["FromDate"].ToString()).ToString("ddMMMyyyy"), DateTime.Parse(Session["ToDate"].ToString()).ToString("ddMMMyyyy") };
            string frm = DateTime.Parse(Session["FromDate"].ToString()).ToString("ddMMMyyyy");
            string end = DateTime.Parse(Session["ToDate"].ToString()).ToString("ddMMMyyyy");
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectItemNotAvailableDetail", "sp_Merch_Dashboard", ResponseID.ToString(), arr);
            grvRpt.DataSource = lstUser;
        }
        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
    }
}