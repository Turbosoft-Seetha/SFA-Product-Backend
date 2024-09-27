using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    
    public partial class ListPromotionDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["prmID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["qualification"] = "";
                ViewState["Assignment"] = "";
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectPromotionDetails", "sp_Web_Promotion",ResponseID.ToString());
            grvRpt.DataSource = lstUser;
            lblprmname.Text =  lstUser.Rows[0]["prm_Name"].ToString();
            ViewState["qualification"] = lstUser.Rows[0]["qlh_ID"].ToString();
            ViewState["Assignment"] = lstUser.Rows[0]["ash_ID"].ToString();
        }
        public void QualificationDetail()
        {
            string qlh = ViewState["qualification"].ToString();
            DataTable lstQuali = default(DataTable);
            lstQuali = ObjclsFrms.loadList("SelectQalificationDetailforgrid", "sp_Web_Promotion", qlh);
            RadGrid1.DataSource = lstQuali;
        }
        public void AssignmentDetail()
        {
            string ash = ViewState["Assignment"].ToString();
            DataTable lstAssign = default(DataTable);
            lstAssign = ObjclsFrms.loadList("SelectAssignmentDetailforgrid", "sp_Web_Promotion", ash);
            RadGrid2.DataSource = lstAssign;
        }
        protected void Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditRouteCustomerPromotions.aspx?Id=0");
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            QualificationDetail();
        }

        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            AssignmentDetail();
        }
    }
}