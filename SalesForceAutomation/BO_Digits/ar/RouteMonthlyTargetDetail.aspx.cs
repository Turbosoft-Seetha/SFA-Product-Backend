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
    public partial class RouteMonthlyTargetDetail : System.Web.UI.Page
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
            lstDatas = ObjclsFrms.loadList("ListRotMonthlyTargetBYID", "sp_Masters_UOM", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");

                Label lblstartDate = (Label)rp.FindControl("lblstartDate");
                Label lblendDate = (Label)rp.FindControl("lblendDate");
                Label lblstatus = (Label)rp.FindControl("lblstatus");



                rp.Text = "طريق هدف مونلي: " + lstDatas.Rows[0]["tph_Name"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();

                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();

                //lblstartDate.Text = lstDatas.Rows[0]["rtp_StartDate"].ToString();
                //lblendDate.Text = lstDatas.Rows[0]["rtp_EndDate"].ToString();
                //lblstatus.Text = lstDatas.Rows[0]["Status"].ToString();



            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListRotMonthlyTagetDetail", "sp_Masters_UOM", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
    }
}