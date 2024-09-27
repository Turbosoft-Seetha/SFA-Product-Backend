using SalesForceAutomation;
using SalesForceAutomation.BO_Digits;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddGeneralCredit : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Customers();
            }
        }
        public void Customers()
        {
            DataTable dt = ObjclsFrms.loadList("SelectCus", "sp_CreditNote");
            ddlCustomer.DataSource = dt;
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
        }

        protected void lnkConfirm_Click(object sender, EventArgs e)
        {

            if ((upd1.UploadedFiles.Count == 0) && (ViewState["image"] == null))
            {


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SaveAlert();</script>", false);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();

        }

       

        public void Save()
        {
            string image = "";
            int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                ImageID += 1;

                string csvPath = Server.MapPath(("..") + @"/UploadFiles/GeneralCredit/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                image = @"/UploadFiles/GeneralCredit/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                ViewState["image"] = image.ToString();
            }
            image = ViewState["image"].ToString();
            string[] arr = { txtAmount.Text.ToString(), UICommon.GetCurrentUserID().ToString(), DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd"), image.ToString() }; //para8
            DataTable dtRes = ObjclsFrms.loadList("InsertGeneralCredit", "sp_CreditNote", ddlCustomer.SelectedValue.ToString(), arr);

            try
            {
                if (dtRes.Rows.Count > 0)
                {
                    string lst = dtRes.Rows[0]["res"].ToString();
                    int resp = Int32.Parse(lst);
                    if (resp > 0)
                    {
                        string clrID = dtRes.Rows[0]["seqNum"].ToString();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SaveSuccess('" + clrID + "');</script>", false);
                    }
                    else
                    {
                        string remarks = dtRes.Rows[0]["remarks"].ToString();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Error in submitting the data, please try again /n" + remarks + "' );</script>", false);
                        btnSave.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('We are facing some technical issues, please try again later');</script>", false);
                btnSave.Enabled = true;
            }
        }

        protected void btnReqSuccess_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListGeneralCredit.aspx");

        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListGeneralCredit.aspx");
        }
    }
}