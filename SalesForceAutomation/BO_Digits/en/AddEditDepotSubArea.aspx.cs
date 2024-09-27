using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
   
    public partial class AddEditDepotSubArea : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillForm();
                Area();
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
        public void Area()
        {
            DataTable dt = ObjclsFrms.loadList("selectDepotAreaForDropDown", "sp_Masters");
            cmbArea.DataSource = dt;
            cmbArea.DataTextField = "dpa_Name";
            cmbArea.DataValueField = "dpa_ID";
            cmbArea.DataBind();
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddldsacompany.DataSource = dt;
            ddldsacompany.DataTextField = "com_Name";
            ddldsacompany.DataValueField = "com_Code";
            ddldsacompany.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelDepotSubAreaByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string code, name, area,company;
                name = lstDatas.Rows[0]["dsa_Name"].ToString();
                code = lstDatas.Rows[0]["dsa_Code"].ToString();
                area = lstDatas.Rows[0]["dsa_dpa_ID"].ToString();
                company = lstDatas.Rows[0]["dsa_CompanyCode"].ToString();

                txtname.Text = name.ToString();
                txtcode.Text = code.ToString();
                txtcode.Enabled = false;
                cmbArea.SelectedValue = area.ToString();
                ddldsacompany.SelectedValue = company.ToString();


            }
        }
        protected void Save()
        {
            string code, name, area,user,company;
            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            area = cmbArea.SelectedValue.ToString();
            company = ddldsacompany.SelectedValue.ToString();

            user = UICommon.GetCurrentUserID().ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { name, area,company};
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertDepotSubArea", code, arr);
                int res = Int32.Parse(Value.ToString());
                if (res >= 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Depot Sub Area Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { name, area, id,user,company};
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateDepotSubArea", code, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Depot Sub Area Updated Successfully');</script>", false);
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
            Response.Redirect("ListDepoSubArea.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDepoSubArea.aspx");
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckDepotSubAreaCode", "sp_CodeChecker", code);
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