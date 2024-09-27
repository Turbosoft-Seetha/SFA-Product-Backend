using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCompanies : System.Web.UI.Page
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
            FillForm();
            country();
            currency();
        }
       
        public void country()
        {
            DataTable dt = ObjclsFrms.loadList("selectCountryForDropDown", "sp_Masters");
            ddlcountry.DataSource = dt;
            ddlcountry.DataTextField = "cou_Name";
            ddlcountry.DataValueField = "cou_Code";
            ddlcountry.DataBind();
        }
        public void currency()
        {
            DataTable dt = ObjclsFrms.loadList("selectCurrencyForDropDown", "sp_Masters");
            ddlcurrency.DataSource = dt;
            ddlcurrency.DataTextField = "cur_Name";
            ddlcurrency.DataValueField = "cur_Code";
            ddlcurrency.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("selCompanyById", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string Name, Currency, Status, Code,country;
                Code = lstDatas.Rows[0]["com_Code"].ToString();
                Name = lstDatas.Rows[0]["com_Name"].ToString();
                Currency = lstDatas.Rows[0]["com_BaseCurrency"].ToString();
                Status = lstDatas.Rows[0]["Status"].ToString();
                country = lstDatas.Rows[0]["com_CountryCode"].ToString();






                txtcode1.Text = Code.ToString();
                txtname2.Text = Name.ToString();
                ddlcurrency.SelectedValue = Currency.ToString();
                ddlStatus.SelectedValue = Status.ToString();
                txtcode1.Enabled = false;
                ddlcountry.SelectedValue = country.ToString();


            }
        }

        protected void Save()
        {
            string Name, Currency, Status, user, Code,country;
            Code = txtcode1.Text.ToString();
            Name = txtname2.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            Currency = ddlcurrency.SelectedValue.ToString();
            Status = ddlStatus.SelectedValue.ToString();
            country = ddlcountry.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { Code, Currency, Status, user, country };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsCompany", Name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Company  Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { Code,Currency, Status, user,id, country };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCompany", Name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Company Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }

        protected void lnkCancel_Click1(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCompanies.aspx");

        }

        protected void txtcode1_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode1.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckCompanyCode", "sp_CodeChecker", code);
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

        
        protected void lnkSave_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

       

        protected void save_Click1(object sender, EventArgs e)
        {
            Save();
        }



        protected void btnOK_Click1(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCompanies.aspx");

        }
    }
}