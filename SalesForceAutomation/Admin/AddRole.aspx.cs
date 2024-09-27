﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SalesForceAutomation.Admin
{
    public partial class AddRole : System.Web.UI.Page
    {

        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                Roles.CreateRole(this.txtEnglishTitle.Text);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            catch (Exception ex)
            {
                this.ltrlMessage.Text = "<div class='alert alert-error'><button class='close' data-dismiss='alert'></button>Role already exists</div>";
                UICommon.LogException(ex, "Add Edit Role");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddRole.aspx btnSave_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);



            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/Roles.aspx");
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/Roles.aspx");
        }
    }
}