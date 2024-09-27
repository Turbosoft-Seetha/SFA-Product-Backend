using Ecosoft.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class UpdatePassword : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        string Mode = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.FillForm();
                }
            }
            catch (Exception ex)
            {
                UICommon.LogException(ex, "Update Password");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UpdatePassword.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }


        private void FillForm()
        {
            if (string.IsNullOrEmpty(UICommon.GetCurrentUserID().ToString()))
            {
                return;
            }


            String UserNo = UICommon.GetCurrentUserID().ToString();
            DataTable dt = default(DataTable);


            Mode = "SelectUser";
            dt = ObjclsFrms.loadList(Mode, "sp_User", UserNo);



            UserProfile userProfile = DALHelper.GetUsers(userCriteria => userCriteria.UserId == new Guid(dt.Rows[0]["UserId"].ToString())).First();

            this.txtEmail.Text = userProfile.UserName;
            this.txtContactInfo.Text = userProfile.ContacInfo;
            this.txtFirstName.Text = userProfile.FirstName;
            this.txtLastName.Text = userProfile.LastName;

            MembershipUser user = Membership.GetUser(this.txtEmail.Text);

            //this.chkActive.Checked = user.IsApproved;

            this.txtEmail.Enabled = false;
            this.txtContactInfo.Enabled = false;
            this.txtFirstName.Enabled = false;
            this.txtLastName.Enabled = false;

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(UICommon.GetCurrentUserID().ToString()))
                {
                    return;
                }
                MembershipUser user;
                user = Membership.GetUser(this.txtEmail.Text);

                Boolean isSucess = user.ChangePassword(txtOldPassword.Text, txtNewPassword.Text);
                if (isSucess == true)
                {
                    String UserNo = UICommon.GetCurrentUserID().ToString();
                    DataTable dt = default(DataTable);
                    Mode = "SelectUser";
                    dt = ObjclsFrms.loadList(Mode, "sp_User", UserNo);
                    UserProfile userProfile = DALHelper.GetUsers(userCriteria => userCriteria.UserId == new Guid(dt.Rows[0]["UserId"].ToString())).First();
                    userProfile.AccessCode = txtNewPassword.Text.ToString();
                    DALHelper.UpdateUserProfile(userProfile);

                    Response.Redirect("~/Admin/AdminDashboard.aspx");
                }
                else
                {
                    ltrlMessage.Text = "Error Occured, Please contact system Administrator";

                }



            }
            catch (Exception ex)
            {
                UICommon.LogException(ex, "Add Edit User");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UpdatePassword.aspx btnSave_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/AdminDashboard.aspx");
        }
    }
}