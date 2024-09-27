using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class ListCustomerRetailPriceDetail : System.Web.UI.Page
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
            lstDatas = ObjclsFrms.loadList("SelectCustomerRetailPriceHeader", "sp_wb_merch_others", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblAppUser = (Label)rp.FindControl("lblAppUser");
                
                Label lblTransTime = (Label)rp.FindControl("lblTransTime");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblVstart = (Label)rp.FindControl("lblVstart");
                Label lblVend = (Label)rp.FindControl("lblVend");

                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblAppUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
              
                lblTransTime.Text = lstDatas.Rows[0]["dph_Time"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblVstart.Text = lstDatas.Rows[0]["VisitStart"].ToString();
                lblVend.Text = lstDatas.Rows[0]["VisitEnd"].ToString();
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerRetailPriceDetail", "sp_wb_merch_others", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
    }
}