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
    public partial class CouponReturnBook : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["IDB"], out ResponseID);

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
        public void LoadData()
        {

            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectCouponReturnBookDetail", "sp_CouponCollection", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;

        }


        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectCouponBookReturnHeaderData", "sp_CouponCollection", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblNumber = (Label)rp.FindControl("lblNumber");
                Label lblCop = (Label)rp.FindControl("lblCop");
                Label lblHqty = (Label)rp.FindControl("lblHqty");
                Label lblADJQty = (Label)rp.FindControl("lblADJQty");
                Label lblFinal = (Label)rp.FindControl("lblFinal");


                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblNumber.Text = lstDatas.Rows[0]["crh_Number"].ToString();
                lblCop.Text = lstDatas.Rows[0]["cpm_Name"].ToString();
                lblHqty.Text = lstDatas.Rows[0]["crd_HigherQty"].ToString();
                lblADJQty.Text = lstDatas.Rows[0]["crd_AdjHigherQty"].ToString();
                lblFinal.Text = lstDatas.Rows[0]["crd_FinalHigherQty"].ToString();



            }
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            
        }
    }
}