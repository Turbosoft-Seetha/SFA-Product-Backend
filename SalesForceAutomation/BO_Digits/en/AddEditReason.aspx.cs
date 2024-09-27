using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditReason : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillForm();
                company();
            }

        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }

        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("EditReason", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, type, status, arabic,company;
                name = lstDatas.Rows[0]["rsn_Name"].ToString();
                arabic = lstDatas.Rows[0]["rsn_NameArabic"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                type = lstDatas.Rows[0]["rsn_Type"].ToString();
                company = lstDatas.Rows[0]["rsn_CompanyCode"].ToString();



                txtname.Text = name.ToString();
                txtArabic.Text = arabic.ToString();
                ddltype.SelectedValue = type.ToString();
                ddlStatus.SelectedValue = status.ToString();
                ddlrsncompany.SelectedValue = company.ToString();

            }
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlrsncompany.DataSource = dt;
            ddlrsncompany.DataTextField = "com_Name";
            ddlrsncompany.DataValueField = "com_Code";
            ddlrsncompany.DataBind();
        }
        protected void Save()
        {
            string name, type, user, status, arabic,company;
            name = txtname.Text.ToString();
            arabic = txtArabic.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            type = ddltype.SelectedValue.ToString();
            status = ddlStatus.SelectedValue.ToString();
            company = ddlrsncompany.SelectedValue.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { type, user, status, arabic,company };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertReason", name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Reason Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            else
            {
                string id = ResponseID.ToString();
                string[] arr = { type, status, arabic, id ,company};
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateReason", name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Reason Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReasonMaster.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReasonMaster.aspx");

        }
    }
}