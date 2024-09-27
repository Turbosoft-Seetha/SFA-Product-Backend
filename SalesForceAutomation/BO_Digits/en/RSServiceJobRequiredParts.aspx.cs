using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RSServiceJobRequiredParts : System.Web.UI.Page
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
            if (!Page.IsPostBack)
            {
                HeaderData();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("selServiceJobByIDForRequiredParts", "sp_ServiceRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblJobID = (Label)rp.FindControl("lblJobID");
                Label lblReqID = (Label)rp.FindControl("lblReqID");
                Label lblRemarks = (Label)rp.FindControl("lblRemarks");





                //rp.Text = "Transaction No: " + lstDatas.Rows[0]["sjh_Number"].ToString();
                lblJobID.Text = lstDatas.Rows[0]["sjh_Number"].ToString();
                lblReqID.Text = lstDatas.Rows[0]["snr_Code"].ToString();
                lblRemarks.Text = lstDatas.Rows[0]["sjh_ReqPartsRemarks"].ToString();





            }
        }
        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelRequiredParts", "sp_ServiceRequest", ResponseID.ToString());

            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }

        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
    }
}