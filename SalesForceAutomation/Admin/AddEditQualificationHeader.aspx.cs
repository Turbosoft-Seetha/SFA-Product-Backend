using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditQualificationHeader : System.Web.UI.Page
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
            }
        }


       
        public void FillForm()
        {
            if (ResponseID.Equals("") || ResponseID == 0)
            {
                Num.Visible = false;
            }

            DataTable lstDatas = ObjclsFrms.loadList("SelectQalificationHeaderByID", "sp_Web_Promotion", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, status,code;
                name = lstDatas.Rows[0]["qlh_Name"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                code = lstDatas.Rows[0]["qlh_Number"].ToString();
                txtNumber.Text = code.ToString();
                txtName.Text = name.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }

        protected void Save()
        {
            string name, user, status;

            name = txtName.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = {  user, status};
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsertQualificationHeader", name,arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Qualification Header Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = {user, status, id};
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "UpdateQualificationHeader", name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Qualification Header Updated Successfully');</script>", false);
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
            Response.Redirect("/Admin/ListQualificationHeader.aspx");
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListQualificationHeader.aspx");
        }
    }
}