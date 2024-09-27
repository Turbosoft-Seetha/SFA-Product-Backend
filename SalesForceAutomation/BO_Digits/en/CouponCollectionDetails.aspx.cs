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
    public partial class CouponCollectionDetails : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);

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
            lstDatas = ObjclsFrms.loadList("SelectCouponDetails", "sp_CouponCollection", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;

        }


        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectCouponHederData", "sp_CouponCollection", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblNumber = (Label)rp.FindControl("lblNumber");
              

                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();

                lblNumber.Text = lstDatas.Rows[0]["cph_Number"].ToString();


            }
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cpd_ID").ToString();
                Response.Redirect("CouponCollectionBook.aspx?IDB=" + ID);
            }
        }
    }
}