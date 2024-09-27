using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditAgreementType : System.Web.UI.Page
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
            DataTable lstDatas = ObjclsFrms.loadList("SelectAgrTypeByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, status, ArabName;
                name = lstDatas.Rows[0]["agt_Name"].ToString();
                ArabName = lstDatas.Rows[0]["agt_ArabicName"].ToString();

                status = lstDatas.Rows[0]["Status"].ToString();


                txtArabName.Text = ArabName.ToString();
                txtname.Text = name.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }

        protected void Save()
        {
            string name, ArabName, user, status;

            name = txtname.Text.ToString();
            ArabName = txtArabName.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { ArabName.ToString(), user.ToString(), status.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "InsertAgrType", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Areement Type Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { ArabName.ToString(), user.ToString(), status.ToString(), id.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "UpdateAgrType", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Agreement Type Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListAgreementType.aspx");

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
            Response.Redirect("/BO_Digits/en/ListAgreementType.aspx");

        }
    }
}