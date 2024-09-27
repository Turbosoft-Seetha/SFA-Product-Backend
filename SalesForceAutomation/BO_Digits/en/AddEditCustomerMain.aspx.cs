using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCustomerMain : System.Web.UI.Page
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
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlmaincompany.DataSource = dt;
            ddlmaincompany.DataTextField = "com_Name";
            ddlmaincompany.DataValueField = "com_Code";
            ddlmaincompany.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("selCustomerMainById", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string Name, ArabicName, Status,Code,company;
                Code = lstDatas.Rows[0]["cum_Code"].ToString();
                Name = lstDatas.Rows[0]["cum_Name"].ToString();
                ArabicName = lstDatas.Rows[0]["cum_NameArabic"].ToString();
                Status = lstDatas.Rows[0]["Status"].ToString();
                company = lstDatas.Rows[0]["cum_CompanyCode"].ToString();





                txtcode.Text = Code.ToString();
                txtname.Text = Name.ToString();
                txtArabicName.Text = ArabicName.ToString();
                ddlStatus.SelectedValue = Status.ToString();
                txtcode.Enabled = false;
                ddlmaincompany.SelectedValue = company.ToString();

            }
        }
        protected void Save()
        {
            string Name, ArabicName, Status, user,Code,company;
            Code = txtcode.Text.ToString();
            Name = txtname.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            ArabicName = txtArabicName.Text.ToString();
            Status = ddlStatus.SelectedValue.ToString();
            company = ddlmaincompany.SelectedValue.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { ArabicName, user, Status,Code,company };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsCusMain", Name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Main  Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { ArabicName, user, Status, Code,id,company };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCusMain", Name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Main Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCustomerMain.aspx");

        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCustomerMain.aspx");

        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckCustomerMain", "sp_CodeChecker", code);
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