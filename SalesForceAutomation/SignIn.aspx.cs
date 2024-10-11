using SalesForceAutomation.BO_Digits;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation
{
    public partial class SignIn : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
     
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    if (Request.Params["mode"] == "exit" || Session["UserID"] == null)
                    {
                        Session["UserID"] = null;
                    }
                    else
                    {
                        if (Session["UserID"] != null)
                        {
                            string role = Session["Role"].ToString();
                            string URLRoot;
                            if (role.Equals("Inventory"))
                            {
                                URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/InventoryDashboard.aspx";
                                Response.Redirect(URLRoot);
                            }
                            else if (role.Equals("Admin"))
                            {
                                URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/ChartDashboard.aspx";
                                Response.Redirect(URLRoot);
                            }
                            else if (role.Equals("Warehouse"))
                            {
                                URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/WarehouseTransferDashboard.aspx";
                                Response.Redirect(URLRoot);
                            }
                            else if (role.Equals("Field Service"))
                            {
                                URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/ChartDashboard.aspx";
                                Response.Redirect(URLRoot);
                            }
                          
                        }
                    }

                }
                catch (Exception ex)
                {

                }
               

              
                if (Request.Cookies["userid"] != null)
                {
                    txtUsername.Text = Request.Cookies["userid"].Value;
                }
                else
                {
                    txtUsername.Text = "";
                }

                if (Request.Cookies["pwd"] != null)
                {
                    txtPassword.Attributes.Add("value", Request.Cookies["pwd"].Value);
                }
                else
                {
                    txtPassword.Attributes.Add("value", "");
                }


                if (Request.Cookies["userid"] != null && Request.Cookies["pwd"] != null)
                {
                    chkRemember.Checked = true;
                }
                else
                {
                    chkRemember.Checked = false;
                }
            }
        }

        protected void lnkSignIn_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(txtUsername.Text.ToString(), txtPassword.Text.ToString()))
            {

                string userId = Membership.GetUser(txtUsername.Text.ToString()).UserName;

                DataTable dt = ObjclsFrms.loadList("SelectUserByUserName", "sp_User", userId);
                DataTable cop = ObjclsFrms.loadList("SelectCustomerOperations", "sp_User", userId);

                if (dt.Rows.Count > 0)
                {
                    DataTable rol = ObjclsFrms.loadList("SelUserRole", "sp_User", userId);
                    string role = rol.Rows[0]["RoleName"].ToString();
                    string PageName = rol.Rows[0]["PageName"].ToString();
                    string URLRoot;

                    foreach (DataRow row in cop.Rows)
                    {
                        Session["CO_"+row["cop_Key"].ToString()] = row["cop_Enable"].ToString();
                        Session["CO_"+row["cop_Key"].ToString()+"_NAME"]= row["cop_Name"].ToString();

                    }
                    Session["UserID"] = dt.Rows[0]["ID"].ToString();
                    Session["UserName"] = dt.Rows[0]["UserName"].ToString() ;
                    Session["Name"] = dt.Rows[0]["Name"].ToString();
                    Session["Role"] = rol.Rows[0]["RoleName"].ToString();                    

                    if (Session["lang"] == null)
                    {
                        Session["lang"] = "en";
                    }
                    Session["dtLeftNav"] = null;
                    Session["dtLanguages"] = null;
                    DataTable dtUserStatus = ObjclsFrms.loadList("SelNewUserStatus", "sp_Masters", Session["UserID"].ToString());
                    if (dtUserStatus.Rows.Count == 0)
                    {
                        Response.Redirect("ActivateAccount.aspx");
                    }
                    else
                    {
                        
                        if (chkRemember.Checked)
                        {
                            Response.Cookies["userid"].Value = txtUsername.Text.ToString();
                            Response.Cookies["pwd"].Value = txtPassword.Text.ToString();
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

                        LoginAudit(dt.Rows[0]["ID"].ToString(), dt.Rows[0]["UserName"].ToString(), "Success");
                        if(role.Equals("Inventory"))
                        {
                            URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/"+ PageName;
                            Response.Redirect(URLRoot);
                        }
                        else if(role.Equals("Admin"))
                        {
                            URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/" + PageName;
                            Response.Redirect(URLRoot);
                        }
                        else if (role.Equals("Warehouse"))
                        {
                            URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/" + PageName;
                            Response.Redirect(URLRoot);
                        }
                        else if (role.Equals("Field Service"))
                        {
                            URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/" + PageName;
                            Response.Redirect(URLRoot);
                        }
                        else
                        {
                            URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"] + "/ChartDashboard.aspx";
                            Response.Redirect(URLRoot);
                        }
                       
                    }
                }
            }
            else
            {
                LoginAudit("", txtUsername.Text.ToString(), "Failure");
                ltrlError.Text = "<span style=\"color:red;\">Invalid Username or Password</span>";
            }
        }

        public void LoginAudit(String LoginID, String UserName, String Status)
        {
            string Mode;
            string clientIp;

            try
            {
                clientIp = HttpContext.Current.Request.UserHostAddress;
                ObjclsFrms.TraceService("Client IP " + clientIp);
            }
            catch (Exception ex)
            {
                clientIp = "";
                ObjclsFrms.TraceService("Client IP Not available ");
            }

            string[] Paras;
            Paras = new string[3];
            Paras[0] = UserName;
            Paras[1] = Status;
            Paras[2] = clientIp;


            string Res = "0";
            Mode = "AuditLog";

            try
            {

                Res = ObjclsFrms.SaveData("sp_User", Mode, LoginID, Paras);


            }
            catch (Exception ex)
            {

                //UICommon.LogException(ex, "Camera Physical");

            }
        }
    }
}