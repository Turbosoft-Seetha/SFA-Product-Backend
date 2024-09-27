using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewAddEditPromotionHeader : System.Web.UI.Page
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
                PromotionType();
                Qualification();
                Assignment();
                FillForm();
            }
        }
        public void FillForm()
        {

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                Num.Visible = false;
            }

            DataTable lstDatas = ObjclsFrms.loadList("SelectPromotionHeaderByID", "sp_Web_Promotion", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {

                string name, qualification, assignment, type, range, status, code;
                name = lstDatas.Rows[0]["prm_Name"].ToString();
                qualification = lstDatas.Rows[0]["prm_qlh_ID"].ToString();
                assignment = lstDatas.Rows[0]["prm_ash_ID"].ToString();
                type = lstDatas.Rows[0]["prm_prt_ID"].ToString();
                range = lstDatas.Rows[0]["prm_RepeatRange"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                code = lstDatas.Rows[0]["prm_Number"].ToString();
                txtNumber.Text = code.ToString();
                txtName.Text = name.ToString();
                ddlQualificaiton.SelectedValue = qualification.ToString();
                ddlAssignment.SelectedValue = assignment.ToString();
                ddlType.SelectedValue = type.ToString();
                ddlStatus.SelectedValue = status.ToString();
                ddlrange.SelectedValue = range.ToString();

                if (type == "1")
                {
                    asg.Visible = true;
                }
                else
                {
                    asg.Visible = false;
                }
            }
        }
        public void Qualification()
        {
            DataTable dt = ObjclsFrms.loadList("SelectQualificationHeaderDropdown", "sp_Web_Promotion");
            ddlQualificaiton.DataSource = dt;
            ddlQualificaiton.DataTextField = "name";
            ddlQualificaiton.DataValueField = "id";
            ddlQualificaiton.DataBind();
        }

        public void Assignment()
        {
            DataTable dts = ObjclsFrms.loadList("SelectAssignmentHeaderDropdown", "sp_Web_Promotion");
            ddlAssignment.DataSource = dts;
            ddlAssignment.DataTextField = "name";
            ddlAssignment.DataValueField = "id";
            ddlAssignment.DataBind();
        }

        public void PromotionType()
        {
            DataTable dtp = ObjclsFrms.loadList("SelectPromotionTypeDropdown", "sp_Web_Promotion");
            ddlType.DataSource = dtp;
            ddlType.DataTextField = "name";
            ddlType.DataValueField = "id";
            ddlType.DataBind();
        }

    }
}