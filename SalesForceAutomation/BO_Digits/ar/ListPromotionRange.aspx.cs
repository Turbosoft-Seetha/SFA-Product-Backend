using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ListPromotionRange : System.Web.UI.Page
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
        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditPromotionRange.aspx?HId=0&Id=" + ResponseID.ToString());
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
            lstDatas = ObjclsFrms.loadList("SelPromotionHeader", "sp_Web_Promotion", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblNum = (Label)rp.FindControl("lblNum");
                Label lblName = (Label)rp.FindControl("lblName");
                Label lblType = (Label)rp.FindControl("lblType");
                Label lblStatus = (Label)rp.FindControl("lblStatus");


                //rp.Text = "Promotion No: " + lstDatas.Rows[0]["lih_TransID"].ToString();
                lblNum.Text = lstDatas.Rows[0]["prm_Number"].ToString();
                lblName.Text = lstDatas.Rows[0]["prm_ArabicName"].ToString();
                lblType.Text = lstDatas.Rows[0]["prt_Name"].ToString();
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();

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

        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeleteProRange", "sp_Backend", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}