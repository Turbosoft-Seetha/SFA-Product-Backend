using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditAgreementSubCat : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Category();
                FillForm();
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
            DataTable lstDatas = ObjclsFrms.loadList("SelectAgrSubCatByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, ArabName, status, code, Cat;
                name = lstDatas.Rows[0]["asc_Name"].ToString();
                ArabName = lstDatas.Rows[0]["asc_ArabicName"].ToString();
                code = lstDatas.Rows[0]["asc_Code"].ToString();
                Cat = lstDatas.Rows[0]["asc_act_ID"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();

                txtArabName.Text = ArabName.ToString();
                txtcode.Text = code.ToString();
                txtname.Text = name.ToString();
                ddlcat.SelectedValue = Cat.ToString();
                ddlStatus.SelectedValue = status.ToString();
                txtcode.Enabled = false;
            }
        }

        protected void Save()
        {
            string name, code, Cat, user, status, ArabName;

            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            Cat = ddlcat.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();
            ArabName = txtArabName.Text.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { ArabName.ToString(), code.ToString(), Cat.ToString(), user.ToString(), status.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "InsertAgrSubCat", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('SubCategory Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { ArabName.ToString(), code.ToString(), Cat.ToString(), user.ToString(), status.ToString(), id.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "UpdateAgrSubCat", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('SubCategory Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }

        public void Category()
        {
            DataTable dt = ObjclsFrms.loadList("SelectAgrCatFromDrop", "sp_Merchandising");
            ddlcat.DataSource = dt;
            ddlcat.DataTextField = "act_Name";
            ddlcat.DataValueField = "act_ID";
            ddlcat.DataBind();
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListAgreementSubCat.aspx");

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
            Response.Redirect("/BO_Digits/en/ListAgreementSubCat.aspx");

        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckAgreementSubCat", "sp_CodeChecker", code);
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