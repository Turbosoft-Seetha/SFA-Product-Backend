using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class VanToVanBatchDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int ResID
        {
            get
            {
                int ResID;
                int.TryParse(Request.Params["ID"], out ResID);

                return ResID;
            }
        }
        //public int ResponseID
        //{
        //    get
        //    {
        //        int ResponseID;
        //        int.TryParse(Request.Params["VVH"], out ResponseID);

        //        return ResponseID;
        //    }
        //}
        public int VVH
        {
            get
            {
                int VVH;
                int.TryParse(Request.Params["VVH"], out VVH);

                return VVH;
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
            lstDatas = ObjclsFrms.loadList("VanToVanBatchHeader", "sp_InventoryTransaction", ResID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblprdcode = (Label)rp.FindControl("lblprdcode");
                Label lblprdname = (Label)rp.FindControl("lblprdname");
                lblprdcode.Text = lstDatas.Rows[0]["prd_Code"].ToString();
                lblprdname.Text = lstDatas.Rows[0]["prd_Name"].ToString();



            }
        }
        public void LoadData()
        {


            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("VanToVanBatchDetails", "sp_InventoryTransaction", ResID.ToString());
            grvRpt.DataSource = lstDatas;


        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand1(object sender, GridCommandEventArgs e)
        {

        }
    }
}