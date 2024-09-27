using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
   
    public partial class AddEditDepotArea : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillForm();
                Depot();
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
        public void Depot()
        {
            DataTable dt = ObjclsFrms.loadList("selectDepotForDropDown", "sp_Masters");
            cmbDepo.DataSource = dt;
            cmbDepo.DataTextField = "dep_Name";
            cmbDepo.DataValueField = "dep_ID";
            cmbDepo.DataBind();
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddldpacompany.DataSource = dt;
            ddldpacompany.DataTextField = "com_Name";
            ddldpacompany.DataValueField = "com_Code";
            ddldpacompany.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelDepotAreaByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string code, name,depot,company;
                name = lstDatas.Rows[0]["dpa_Name"].ToString();
                code = lstDatas.Rows[0]["dpa_Code"].ToString();
                depot= lstDatas.Rows[0]["dpa_dep_ID"].ToString();
                company = lstDatas.Rows[0]["dpa_CompanyCode"].ToString();


                txtname.Text = name.ToString();
                txtcode.Text = code.ToString();
                txtcode.Enabled = false;
                cmbDepo.SelectedValue = depot.ToString();
                ddldpacompany.SelectedValue = company.ToString();


            }
        }
        protected void Save()
        {
            string code, name,depot,user,company;
            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            depot = cmbDepo.SelectedValue.ToString();
            company = ddldpacompany.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { name,depot,company};
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertDepotArea", code, arr);
                int res = Int32.Parse(Value.ToString());
                if (res >= 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Depot Area Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { name,depot, id,user,company };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateDepotArea", code, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Depot Area Updated Successfully');</script>", false);
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
            Response.Redirect("ListDepotArea.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDepotArea.aspx");
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckDepotAreaCode", "sp_CodeChecker", code);
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