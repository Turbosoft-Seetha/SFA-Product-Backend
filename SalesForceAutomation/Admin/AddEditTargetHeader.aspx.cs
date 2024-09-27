using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditTargetHeader : System.Web.UI.Page
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
            DataTable lstDatas = ObjclsFrms.loadList("SelTargetHeaderByID", "sp_Masters_UOM", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name,number, status;
                name = lstDatas.Rows[0]["tph_Name"].ToString();
                number = lstDatas.Rows[0]["tph_Number"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();

                txtname.Text = name.ToString();
                txtNumber.Text = number.ToString();
                ddlStatus.SelectedValue = status.ToString();

            }
        }
        protected void Save()
        {
            string name,number, user, status;
            name = txtname.Text.ToString();
            number = txtNumber.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();
            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { user,number, status };
                string Value = ObjclsFrms.SaveData("sp_Target", "InsertIntoTargetHeader", name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res >= 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Target Header Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { number, status, id };
                string Value = ObjclsFrms.SaveData("sp_Target", "UpdateTargetHeader", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Target Header Updated Successfully');</script>", false);
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
            Response.Redirect("/Admin/ListTargetHeader.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListTargetHeader.aspx");
        }
    }
}