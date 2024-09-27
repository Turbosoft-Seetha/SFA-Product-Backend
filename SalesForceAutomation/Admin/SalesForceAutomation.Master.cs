using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class SalesForceAutomation : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                string userID = Session["UserID"].ToString();
                string UserName = Session["UserName"].ToString();
                string name = Session["Name"].ToString();
                this.lblUser1.Text = this.lblUser.Text = name;
                this.lblIcon1.Text = this.lblIcon.Text = name[0].ToString();
                var userRoles = Roles.GetRolesForUser(Session["UserName"].ToString());
                if (userRoles.Contains("FE"))
                {
                    plcNewClaim.Visible = true;
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }

        }
    }
}