using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditSubcategory : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
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
                Customer();
                FillForm();
                company();
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ob.loadList("SelectSubByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, catid, code, status,company;
                name = lstDatas.Rows[0]["sct_Name"].ToString();
                catid = lstDatas.Rows[0]["sct_cat_ID"].ToString();
                code = lstDatas.Rows[0]["sct_Code"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                company = lstDatas.Rows[0]["sct_CompanyCode"].ToString();


                txtname.Text = name.ToString();
                ddlid.SelectedValue = catid.ToString();
                txtcode.Text = code.ToString();
                txtcode.Enabled = false;
                ddlStats.SelectedValue = status.ToString();
                ddlsubcatcompany.SelectedValue = company.ToString();

            }
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ob.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlsubcatcompany.DataSource = dt;
            ddlsubcatcompany.DataTextField = "com_Name";
            ddlsubcatcompany.DataValueField = "com_Code";
            ddlsubcatcompany.DataBind();
        }
        protected void Save()
        {
            string name, code, catid, user, status,company;

            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            catid = ddlid.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStats.SelectedValue.ToString();
            company = ddlsubcatcompany.SelectedValue.ToString();



            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { catid.ToString(), code.ToString(), user.ToString(), status.ToString(), company.ToString() };
                string Value = ob.SaveData("sp_Masters", "InsertSub", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Subcategory Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { catid.ToString(), code.ToString(), status.ToString(), id.ToString(), user , company.ToString() };
                string Value = ob.SaveData("sp_Masters", "UpdateSub", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Subcategory Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        public void Customer()
        {
            DataTable dt = ob.loadList("SelectCatFromDrop", "sp_Masters");
            ddlid.DataSource = dt;
            ddlid.DataTextField = "cat_Name";
            ddlid.DataValueField = "cat_ID";
            ddlid.DataBind();
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListSubCategory.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListSubCategory.aspx");
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ob.loadList("ChechSubcategoryCode", "sp_CodeChecker", code);
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