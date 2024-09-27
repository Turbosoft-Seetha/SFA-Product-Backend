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
    public partial class CustomerPromotionDetail : System.Web.UI.Page
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
        public int cid
        {
            get
            {
                int cid;
                int.TryParse(Request.Params["cid"], out cid);
                return cid;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Titles();
                HeaderData();
            }
        }
        public void Titles()
        {
            DataTable lstTitle = ObjclsFrms.loadList("SelectPromotionHeaderTitle", "sp_Web_Promotion", ResponseID.ToString());
            string titles = lstTitle.Rows[0]["title"].ToString();
            // lblTitle.Text = "for " + titles.ToString();
        }
        

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectPromotionRange", "sp_Web_Promotion", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            string[] arr = { cid.ToString() };
            lstDatas = ObjclsFrms.loadList("SelCusPromotionHeader", "sp_Web_Promotion", ResponseID.ToString(),arr);
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblNum = (Label)rp.FindControl("lblNum");
                Label lblName = (Label)rp.FindControl("lblName");
                Label lblType = (Label)rp.FindControl("lblType");
                Label lblStatus = (Label)rp.FindControl("lblStatus");
                Label lblRange= (Label)rp.FindControl("lblRange");

                //rp.Text = "Promotion No: " + lstDatas.Rows[0]["lih_TransID"].ToString();
                lblNum.Text = lstDatas.Rows[0]["prm_Number"].ToString();
                lblName.Text = lstDatas.Rows[0]["prm_Name"].ToString();
                lblType.Text = lstDatas.Rows[0]["prt_Name"].ToString();
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();
                lblRange.Text= lstDatas.Rows[0]["DateRange"].ToString();
            }
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prr_ID").ToString();

                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

       
    }
}