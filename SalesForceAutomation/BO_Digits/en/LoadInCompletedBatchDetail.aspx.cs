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
    public partial class LoadInCompletedBatchDetail : System.Web.UI.Page
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
        public int LIH
        {
            get
            {
                int LIH;
                int.TryParse(Request.Params["ID"], out LIH);

                return LIH;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            HeaderData();
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("LoadInCompletedBatchHeader", "sp_InventoryTransaction", LIH.ToString());
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
            lstDatas = ObjclsFrms.loadList("LoadInCompletedBatchDetails", "sp_InventoryTransaction", ResID.ToString());
            grvRpt.DataSource = lstDatas;


        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
           
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        
    }
}