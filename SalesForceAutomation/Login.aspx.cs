using System.Collections.Generic;
using System.Diagnostics;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System;
using System.Linq;
using System.Web.Security;
using Ecosoft.DAL;
using System.Text;
using System.Net.Mail;
using SalesForceAutomation.Admin;

namespace SalesForceAutomation
{
    public partial class Login : Page
    {
        General ObjGeneral = new General();
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["count"] = null;
            Session["UserID"] = null;
            Session["page"] = null;
            Page.Form.DefaultButton = LoginUser.FindControl("LoginButton").UniqueID;

            if (!IsPostBack)

            {
                string year = DateTime.Now.Year.ToString();
                //lblYear.Text = year;

                CheckBox cb = (CheckBox)LoginUser.FindControl("chkRemember");
                TextBox username = (TextBox)LoginUser.FindControl("UserName");
                TextBox password = (TextBox)LoginUser.FindControl("Password");
                if (Request.Cookies["userid"] != null)
                {
                    username.Text = Request.Cookies["userid"].Value;
                }
                else
                {
                    username.Text = "";
                }

                    

                if (Request.Cookies["pwd"] != null)
                {
                    password.Attributes.Add("value", Request.Cookies["pwd"].Value);
                }
                else
                {
                    password.Attributes.Add("value", "");
                }

                   
                if (Request.Cookies["userid"] != null && Request.Cookies["pwd"] != null)
                {
                    cb.Checked = true;
                }
                else
                {
                    cb.Checked = false;
                }
                
            }
        }

        protected void LoginUser_LoginError(object sender, EventArgs e)
        {
            LoginUser.FailureText = "<div class='alert alert-error' style='color: rgb(255, 0, 0); background-color: rgb(255, 255, 255);'>Invalid user name or password <i class='la la-close' data-dismiss='alert'></i> </div>";
        }

        protected void LoginUser_LoggingIn(object sender, LoginCancelEventArgs e)
        {

        }

        public void LoginAudit(String LoginID, String UserName, String Status)
        {
            string Mode;
            string[] Paras;
            Paras = new string[2];
            Paras[0] = UserName;
            Paras[1] = Status;



            string Res = "0";
            Mode = "AuditLog";

            try
            {

                Res = ObjclsFrms.SaveData("sp_Report", Mode, LoginID, Paras);


            }
            catch (Exception ex)
            {

                //UICommon.LogException(ex, "Camera Physical");

            }
        }

        protected void LoginUser_Authenticate(object sender, AuthenticateEventArgs e)
        {
            if (Membership.ValidateUser(LoginUser.UserName, LoginUser.Password))
            {
                
                string userId = Membership.GetUser(LoginUser.UserName).UserName;
                UserProfile userProfile = DALHelper.GetUsers(userCriteria => userCriteria.UserName.ToLower() == userId.ToLower()).FirstOrDefault();
                if (userId != null)
                {
                    Session["UserID"] = userProfile.ID;
                    Session["UserName"] = userProfile.UserName;
                    Session["Name"] = userProfile.FirstName + " " + userProfile.LastName;

                    DataTable dtUserStatus = ObjclsFrms.loadList("SelNewUserStatus", "sp_Masters", Session["UserID"].ToString());
                    if (dtUserStatus.Rows.Count == 0)
                    {
                        Response.Redirect("ActivateAccount.aspx");
                    }
                    else
                    {
                        CheckBox cb = (CheckBox)LoginUser.FindControl("chkRemember");
                        if (cb.Checked)
                        {
                            Response.Cookies["userid"].Value = LoginUser.UserName;
                            Response.Cookies["pwd"].Value = LoginUser.Password;
                            Response.Cookies["userid"].Expires = DateTime.Now.AddDays(15);
                            Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(15);
                        }
                        else
                        {
                            Response.Cookies["userid"].Value = "";
                            Response.Cookies["pwd"].Value = "";
                            Response.Cookies["userid"].Expires = DateTime.Now.AddDays(-1);
                            Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(-1);
                        }

                        LoginAudit(userProfile.ID.ToString(), LoginUser.UserName, "Success");
                        e.Authenticated = true;
                        var userRoles = Roles.GetRolesForUser(Session["UserName"].ToString());

                        //DataTable dtMarket = ObjclsFrms.loadList("SelectUserMarket", "sp_Masters", Session["UserID"].ToString());
                        //if (dtMarket.Rows.Count > 0)
                        //{
                        //    Session["Mar_ID"] = dtMarket.Rows[0]["dst_mar_ID"].ToString(); //"2";
                        //}
                        //else
                        //{
                        //    Session["Mar_ID"] = "0";
                        //}
                        //string v = "";
                        //if (Request.Params.Count > 0)
                        //{
                        //    try
                        //    {

                        //        if (Request.Params["mode"] != null && Request.Params["mode"].ToString().Equals("0"))
                        //        {
                        //            v = "1";
                        //        }
                        //        else if (Request.Params["mode"].ToString().Equals("2"))
                        //        {
                        //            v = "2";
                        //        }
                        //    }
                        //    catch (Exception ex)
                        //    {
                        //        v = "0";
                        //    }

                        //}
                        //else
                        //{
                        //    v = "0";
                        //}
                        //if (v == "0")
                        //{
                            Response.Redirect("Admin/ChartDashboard.aspx");
                        //    //Response.Redirect("Admin/ViewClaim.aspx?Id=560");
                        //}
                        //else if (v == "2") { Response.Redirect("Admin/ListNewClaim.aspx"); }
                        //else if (v == "1") { Response.Redirect("Admin/DisplayClaim.aspx?id=" + Request.Params["id"].ToString()); }

                        //return;
                    }
                }
                   
                  

            }
            else
            {
                e.Authenticated = false;
                LoginAudit("", LoginUser.UserName, "Failure");
            }
        }

        protected void lnkReq_Click(object sender, EventArgs e)
        {
            Reset();
        }

        public void Reset()
        {
            string mail = this.txtMail.Text.ToString();


            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var stringChars = new char[6];
            var random = new Random();
            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }

            string password = new String(stringChars);
            UserProfile userProfile = new UserProfile();
            MembershipUser user;
            user = Membership.GetUser(this.txtMail.Text);
            if (user != null)
            {

                DataTable dtLogin = ObjclsFrms.loadList("SelLoginCredentailsForReset", "sp_Masters", txtMail.Text.ToString());
                if (dtLogin.Rows.Count > 0)
                {
                    user.UnlockUser();
                    string NewPass = user.ResetPassword();


                    MailService(dtLogin, NewPass);
                }
                else
                {
                    this.ltrlMessage.Text = UICommon.GetErrorMessage("We are facing some technical issues, please try again later");
                }
            }
            else
            {
                this.ltrlMessage.Text = UICommon.GetErrorMessage("User along with this account not Found");
            }
        }

        public void MailService(DataTable dx, string newPass)
        {

            StringBuilder sb = new StringBuilder();
            string body = dx.Rows[0]["emb_Body"].ToString();
            body = body.Replace("{0}", dx.Rows[0]["ToMail"].ToString());
            body = body.Replace("{1}", newPass);

            MailMessage message = new MailMessage();
            message.Body = body.ToString();
            message.IsBodyHtml = true;
            message.From = new MailAddress(dx.Rows[0]["tcl_User"].ToString());
            message.To.Add(txtMail.Text.ToString());
            message.Subject = "Password Reset Successfull";
            SmtpClient smtp = new SmtpClient(dx.Rows[0]["tcl_Client"].ToString());
            smtp.Credentials = new System.Net.NetworkCredential(dx.Rows[0]["tcl_User"].ToString(), dx.Rows[0]["tcl_Pass"].ToString());
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(message);

            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SuccessModal('Your Password Reset Success, Please check your mail for new password');</script>", false);

        }
        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void lnkbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

    }
}