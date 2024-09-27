using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCustomerCategory : System.Web.UI.Page
    {
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                CusMain();
                FillForm();
                company();
            }
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlcatcompany.DataSource = dt;
            ddlcatcompany.DataTextField = "com_Name";
            ddlcatcompany.DataValueField = "com_Code";
            ddlcatcompany.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelCusCatByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, ArabName, status, code, Cus,company;
                name = lstDatas.Rows[0]["cct_Name"].ToString();
                ArabName = lstDatas.Rows[0]["cct_NameArabic"].ToString();
                code = lstDatas.Rows[0]["cct_Code"].ToString();
                Cus = lstDatas.Rows[0]["cct_cum_ID"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                company = lstDatas.Rows[0]["cct_CompanyCode"].ToString();

                txtArabName.Text = ArabName.ToString();
                txtcode.Text = code.ToString();
                txtname.Text = name.ToString();
                ddlcusmain.SelectedValue = Cus.ToString();
                ddlStatus.SelectedValue = status.ToString();
                txtcode.Enabled = false;
                ddlcatcompany.SelectedValue = company.ToString();

            }
        }
        protected void Save()
        {
            string name, code, Cus, user, status, ArabName,company;

            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            Cus = ddlcusmain.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();
            ArabName = txtArabName.Text.ToString();
            company = ddlcatcompany.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { ArabName.ToString(), code.ToString(), Cus.ToString(), user.ToString(), status.ToString(), company.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsCusCategory", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Category Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { ArabName.ToString(), code.ToString(), Cus.ToString(), user.ToString(), status.ToString(), id.ToString(), company.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCusCategory", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Category Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        public void CusMain()
        {
            DataTable dt = ObjclsFrms.loadList("SelCusMainFromDrop", "sp_Masters");
            ddlcusmain.DataSource = dt;
            ddlcusmain.DataTextField = "cum_Name";
            ddlcusmain.DataValueField = "cum_ID";
            ddlcusmain.DataBind();
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCustomerCategory.aspx");

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCustomerCategory.aspx");

        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckCustomerCategory", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                LinkButton1.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                LinkButton1.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }
    }
}