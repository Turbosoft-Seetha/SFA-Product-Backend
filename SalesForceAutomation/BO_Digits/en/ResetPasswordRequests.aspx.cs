using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using Telerik.Web.UI;
using System.Configuration;
using System.Web.Security;
using System.Security.Cryptography;
using System.IO;
using Ecosoft.DAL;
using System.Net;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ResetPasswordRequests : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                try
                {
                    if (Session["RPRFromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["RPRFromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                    }
                    if (Session["RPRTODate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["RPRTODate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now; ;
                    }  
                    rdendDate.MaxDate = DateTime.Now;
                }
                catch (Exception ex)
                {
                    Response.Redirect("SignIn.aspx");
                }
            }
        }

        public void ListData()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { ToDate.ToString()};
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelResetRequestList", "sp_User", fromDate.ToString(), arr);
            grvRpt.DataSource = lstUser;
        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            if (Session["RPRFromDate"] != null)
            {
                string fromdate = rdfromDate.SelectedDate.ToString();
                if (fromdate == Session["RPRFromDate"].ToString())
                {
                    rdfromDate.SelectedDate = DateTime.Parse(Session["RPRFromDate"].ToString());
                }
                else
                {
                    Session["RPRFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                }
            }
            else
            {
                rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                Session["RPRFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

            }

            if (Session["RPRTODate"] != null)
            {
                string todate = rdendDate.SelectedDate.ToString();
                if (todate == Session["RPRTODate"].ToString())
                {
                    rdendDate.SelectedDate = DateTime.Parse(Session["RPRTODate"].ToString());
                }
                else
                {
                    Session["RPRTODate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }

            }
            else
            {
                rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                Session["RPRTODate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
            }
            ListData();
            grvRpt.Rebind();
        }
        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            Reset();
        }

        public void Reset()
        {
            string mail = ViewState["Email"].ToString();
            string ID = ViewState["ID"].ToString();
            string userName = ViewState["UserName"].ToString();

            string password = ConfigurationManager.AppSettings.Get("DeffPass");
            UserProfile userProfile = new UserProfile();
            MembershipUser user;
            user = Membership.GetUser(userName);

            if (user != null)
            {
                user.UnlockUser();
                string NewPass = user.ResetPassword();

                string[] arr = { ID.ToString() };
                string svd = ObjclsFrms.SaveData("sp_User", "UpdResetPswdStatus", null, arr);
                Save(NewPass);

            }
            else
            {
                this.ltrlMessage.Text = UICommon.GetErrorMessage("User along with this account not Found");
            }
        }

        public void Save(string Password)
        {
            string userName = ViewState["UserName"].ToString();
            string id, user;
            id = ViewState["ID"].ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { Password.ToString(), user.ToString() };
            DataTable lstClaim = ObjclsFrms.loadList("InsPasswordEncryptionLog", "sp_User", id.ToString(), arr);
            if (lstClaim.Rows.Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SuccessModal('" + userName + " . The password is " + Password + "');</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ResetPasswordRequests.aspx");
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Reset"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prr_UserId").ToString();
                ViewState["User"] = null;
                ViewState["UserName"] = null;
                ViewState["Email"] = null;
                ViewState["ID"] = null;
                DataTable lstUserName = ObjclsFrms.loadList("SelectUserByUserID", "sp_User", ID.ToString());
                if (lstUserName.Rows.Count > 0)
                {
                    string username = lstUserName.Rows[0]["UserName"].ToString();
                    string email = lstUserName.Rows[0]["Email"].ToString();
                    string ids = lstUserName.Rows[0]["ID"].ToString();
                    ViewState["UserName"] = username;
                    ViewState["Email"] = email;
                    ViewState["ID"] = ids;
                }
                ViewState["User"] = ID;
                string uName = ViewState["UserName"].ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('" + uName + "');</script>", false);
            }
        }

        
    }
}