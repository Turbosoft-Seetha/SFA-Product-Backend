using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditAgreementOffer : System.Web.UI.Page
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
            DataTable lstDatas = ObjclsFrms.loadList("selAgreementOfferById", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string  Name, ArabicName, Status; 
               
                Name = lstDatas.Rows[0]["ago_Name"].ToString();
                ArabicName = lstDatas.Rows[0]["ago_ArabicName"].ToString();
                Status = lstDatas.Rows[0]["Status"].ToString();

                txtname.Text = Name.ToString();
                txtArabicName.Text = ArabicName.ToString();
                ddlStatus.SelectedValue = Status.ToString();

            }
        }
        protected void Save()
        {
            string Name, ArabicName, Status, user;
           
            Name = txtname.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            ArabicName = txtArabicName.Text.ToString();
            Status = ddlStatus.SelectedValue.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = {  ArabicName, user, Status };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "insAgreementOffer", Name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Agreement Offer  Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { ArabicName, user, Status, id };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "updateAgreementOffer", Name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Agreement Offer Updated Successfully');</script>", false);
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
            Response.Redirect("/Admin/ListAgreementOffer.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListAgreementOffer.aspx");
        }
    }
}