using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditBank : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
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
            DataTable lstDatas = ObjclsFrms.loadList("SelectBankByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, status, code;
                name = lstDatas.Rows[0]["bnk_Name"].ToString();
                code = lstDatas.Rows[0]["bnk_Code"].ToString();
                
                status = lstDatas.Rows[0]["Status"].ToString();
                
               
                txtcode.Text = code.ToString();
                txtname.Text = name.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Save();
        }
        protected void Save()
        {
            string name, code, user,status;
            
            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { code.ToString(),   user.ToString(), status.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertBank", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Bank Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { code.ToString(),  status.ToString(), id.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateBank", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Bank Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }

        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
          
        }

        protected void btnOK_Click1(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListBank.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }
    }
}