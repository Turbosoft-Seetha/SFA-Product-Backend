using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCategory : System.Web.UI.Page
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
            DataTable lstDatas = ObjclsFrms.loadList("SelCategoryByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, status, code,company;
                name = lstDatas.Rows[0]["cat_Name"].ToString();
                code = lstDatas.Rows[0]["cat_Code"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                company = lstDatas.Rows[0]["cat_CompanyCode"].ToString();


                txtcode.Text = code.ToString();
                txtcode.Enabled = false;
                txtname.Text = name.ToString();
                ddlStatus.SelectedValue = status.ToString();
                ddlccatcompany.SelectedValue = company.ToString();

            }
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlccatcompany.DataSource = dt;
            ddlccatcompany.DataTextField = "com_Name";
            ddlccatcompany.DataValueField = "com_Code";
            ddlccatcompany.DataBind();
        }
        protected void Save()
        {
            string name, code, user, status,company;

            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();
            company = ddlccatcompany.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { code.ToString(), user.ToString(), status.ToString(), company.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertCategory", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Category Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { code.ToString(), status.ToString(), id.ToString(), user, company.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCategory", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Category Updated Successfully');</script>", false);
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
            Response.Redirect("Category.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("Category.aspx");
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("ChechCategoryCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                lnkSave.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                lnkSave.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }
    }
}