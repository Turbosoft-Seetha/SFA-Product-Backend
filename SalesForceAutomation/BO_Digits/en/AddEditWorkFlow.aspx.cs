using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditWorkFlow : System.Web.UI.Page
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
                FillForm();
                company();
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectWorkflowByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string wf_name, wf_code,company;
                wf_code = lstDatas.Rows[0]["wfm_Code"].ToString();
                wf_name = lstDatas.Rows[0]["wfm_Name"].ToString();
                company = lstDatas.Rows[0]["wfm_CompanyCode"].ToString();




                txtcode.Text = wf_code.ToString();
                txtname.Text = wf_name.ToString();
                ddlwfmcompany.SelectedValue = company.ToString();

            }
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlwfmcompany.DataSource = dt;
            ddlwfmcompany.DataTextField = "com_Name";
            ddlwfmcompany.DataValueField = "com_Code";
            ddlwfmcompany.DataBind();
        }
        protected void Save()
        {
            string wf_name, wf_code, user,company;

            wf_name = txtname.Text.ToString();
            wf_code = txtcode.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            company = ddlwfmcompany.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { wf_name.ToString(), user.ToString(), company.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertWorkflow", wf_code.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Workflow Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { wf_code.ToString(), id.ToString(), user, company.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateWorkflow", wf_name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Workflow Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListWorkFlow.aspx");
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListWorkFlow.aspx");
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckWorkflowCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Workflow Code Already Exist";
                lblCodeDupli.Visible = true;
            }
            else
            {
                lblCodeDupli.Visible = false;
            }
        }
    }
}