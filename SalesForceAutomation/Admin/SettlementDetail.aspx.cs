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
    public partial class SettlementDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            HeaderData();
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelSalesHeader", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblCreatedBy = (Label)rp.FindControl("lblCreatedBy");
                //Label lblCustomer = (Label)rp.FindControl("lblCustomer");


                rp.Text = "Sales Number: " + lstDatas.Rows[0]["sal_number"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblCreatedBy.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                //lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();

            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListSalesDetail", "sp_Merchandising", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }
        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
    }
}