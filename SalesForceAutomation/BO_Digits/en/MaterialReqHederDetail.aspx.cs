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
    public partial class MaterialReqHederDetail : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["HID"], out ResponseID);
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
            lstDatas = obj.loadList("ListMRApprovalHeaderbyID", "sp_MaterialRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblExpDate = (Label)rp.FindControl("lblExpDate");
                Label lblPicLoc = (Label)rp.FindControl("lblPicLoc");
                Label lblrcvloc = (Label)rp.FindControl("lblrcvloc");


                rp.Text = "Request ID: " + lstDatas.Rows[0]["mrh_Number"].ToString();
                lblDate.Text = lstDatas.Rows[0]["TransTime"].ToString();
                lblExpDate.Text = lstDatas.Rows[0]["mrh_ExpDate"].ToString();
                lblPicLoc.Text = lstDatas.Rows[0]["warehouse"].ToString();
                lblrcvloc.Text = lstDatas.Rows[0]["store"].ToString();

            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = obj.loadList("ListMRApprovalDetail", "sp_MaterialRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstDatas;
                ViewState["dd"] = lstDatas;
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
    }
}