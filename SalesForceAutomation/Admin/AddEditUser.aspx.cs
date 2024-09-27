using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Ecosoft.DAL;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Configuration;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditUser : System.Web.UI.Page
    {


        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(!Page.IsPostBack)
                {
                    if (string.IsNullOrEmpty(Request.Params["Id"]))
                    {
                        this.chkActive.Checked = true;
                    }
                    Division();
                    this.FillForm();
                }
            }
            catch (Exception ex)
            {
                UICommon.LogException(ex, "Add Edit User");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditUser.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);



            } 
        }



        private void FillForm()
        {
            if(string.IsNullOrEmpty(Request.Params["Id"]))
            {
                return;
            }


            UserProfile userProfile = DALHelper.GetUsers(userCriteria => userCriteria.UserId == new Guid(Request.Params["Id"])).First();

            this.txtEmail.Text = userProfile.UserName;
            this.txtContactInfo.Text = userProfile.ContacInfo;
            this.txtFirstName.Text = userProfile.FirstName;
            this.txtLastName.Text = userProfile.LastName;
            
            MembershipUser user = Membership.GetUser(this.txtEmail.Text);

            this.chkActive.Checked = user.IsApproved;
            this.txtEmail.Enabled = false;

            string ID = userProfile.ID.ToString();
            DataTable lstData = ObjclsFrms.loadList("SelectUserDivisionByUserID", "sp_Masters", ID.ToString());
            if (lstData.Rows.Count > 0)
            {
                string[] words = new string[500];
                for (int i = 0; i<lstData.Rows.Count; i++)
                {
                    string id = lstData.Rows[i]["usd_sdv_ID"].ToString();
                    words[i] = id;
                }
                foreach (var word in words)
                {
                    foreach (RadComboBoxItem rd in ddlDivision.Items)
                    {
                        if (rd.Value.Equals(word))
                        {
                            rd.Checked = true;
                        }
                    }
                }
            }
            DataTable lstCode = ObjclsFrms.loadList("SelectEmployeeCodeForUser", "sp_Masters", ID.ToString());
            if (lstCode.Rows.Count > 0)
            {
                string code = lstCode.Rows[0]["EmployeeCode"].ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                UserProfile userProfile = new UserProfile();
                MembershipUser user;
                //string password = Membership.GeneratePassword(8, 1);
                string password ="User@123";
                if (!string.IsNullOrEmpty(Request.Params["Id"]))
                {
                    userProfile = DALHelper.GetUsers(userCriteria => userCriteria.UserId == new Guid(Request.Params["id"])).First();
                    user = Membership.GetUser(this.txtEmail.Text);
                }
                else
                {
                    if (Membership.GetUser(this.txtEmail.Text) != null)
                    {
                        this.ltrlMessage.Text = UICommon.GetErrorMessage("User already exists");
                        //System.Windows.Forms.MessageBox.Show("User already exists", "Add Edit User");
                        return;
                    }

                    //string password = "user@123";
                    user = Membership.CreateUser(this.txtEmail.Text, password);

                    userProfile.CreatedDate = DateTime.Now;
                    userProfile.CreatedBy = UICommon.GetCurrentUserID();
                }
              
               user.IsApproved = this.chkActive.Checked;
               Membership.UpdateUser(user);
               userProfile.ModifiedDate = DateTime.Now;
               userProfile.ModifiedBy = UICommon.GetCurrentUserID();
               userProfile.UserId = new Guid(user.ProviderUserKey.ToString());
               userProfile.FirstName = this.txtFirstName.Text;
               userProfile.LastName = this.txtLastName.Text;
               userProfile.Email = this.txtEmail.Text;
               userProfile.ContacInfo = this.txtContactInfo.Text;
               userProfile.CreatedDate = DateTime.Now;
               userProfile.Active = this.chkActive.Checked;
               userProfile.UserName = user.UserName;
                int Id = DALHelper.UpdateUserProfile(userProfile);
                
                
                ObjclsFrms.loadList("DeleteUserDivisionByUserID", "sp_Masters", Id.ToString());
                var SelectedDivision = ddlDivision.CheckedItems;
                string divi = "";
                string[] arr = { Id.ToString() };
                foreach (var item in SelectedDivision)
                {
                    divi = item.Value;
                    ObjclsFrms.SaveData("sp_Masters", "InsertUserDivision", divi.ToString(), arr);
                }

                string empCode;
                empCode = txtEmpCode.Text.ToString();
                string[] arrs = { empCode.ToString() };
                ObjclsFrms.SaveData("sp_Masters", "UpdateEmployeeCodeForUserProfile", Id.ToString(), arrs);

                //DataTable dtLogin = ObjclsFrms.loadList("SelLoginCredentailsForNAC", "sp_Masters");
                //if (dtLogin.Rows.Count > 0)
                //{
                //    MailService(dtLogin, "BSMEA - Eclaim Account Activation for BSMEA Users", password);
                //}
            }
            catch (Exception ex)
            {
                UICommon.LogException(ex, "Add Edit User");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditUser.aspx btnSave_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);


            }
            Response.Redirect("Users.aspx");
        }

        public void MailService(DataTable dx, string Subject, string password)
        {
            StringBuilder sb = new StringBuilder();
            string body = dx.Rows[0]["emb_Body"].ToString();

            body = body.Replace("{0}", this.txtFirstName.Text);
            body = body.Replace("{1}", txtEmail.Text.ToString());
            body = body.Replace("{2}", password);

            MailMessage message = new MailMessage();
            message.Body = body.ToString();
            message.IsBodyHtml = true;
            string email = ConfigurationManager.AppSettings.Get("NACEmail").ToString();
            message.From = new MailAddress(dx.Rows[0]["tcl_User"].ToString());

            message.To.Add(this.txtEmail.Text.ToString());
            message.To.Add(email);

            message.Subject = Subject;
            SmtpClient smtp = new SmtpClient(dx.Rows[0]["tcl_Client"].ToString());
            smtp.Credentials = new System.Net.NetworkCredential(dx.Rows[0]["tcl_User"].ToString(), dx.Rows[0]["tcl_Pass"].ToString());
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(message);

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/Users.aspx"); 
        }


        public void Division()
        {
            ddlDivision.DataSource = ObjclsFrms.loadList("SelectDivision", "sp_Masters");
            ddlDivision.DataTextField = "name";
            ddlDivision.DataValueField = "id";
            ddlDivision.DataBind();
        }

        
    }
}