//using DocumentFormat.OpenXml.Drawing.Charts;
using Ecosoft.DAL;
using OfficeOpenXml.Packaging.Ionic.Zlib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;
using Telerik.Pdf;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddRole : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                defaultPages();
                FillForm();              
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Roles.aspx");
        }

        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            try
            {
                if (ResponseID!= "")
                {
                    //Roles.CreateRole(this.txtEnglishTitle.Text);
                    string roles = this.txtEnglishTitle.Text;
                    string defPage = ddldefaultpage.SelectedValue.ToString();
                    string[] arr = { defPage.ToString(), ResponseID.ToString() };
                    string Value = ObjclsFrms.SaveData("sp_Masters", "UpdRoles", roles.ToString(), arr);
                    try
                    {
                        int res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failesModal();</script>", false);

                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failesModal();</script>", false);
                    }
                }
                else
                {
                    //Roles.CreateRole(this.txtEnglishTitle.Text);
                    string roles = this.txtEnglishTitle.Text;
                    string defPage = ddldefaultpage.SelectedValue.ToString();
                    string[] arr = { defPage.ToString() };
                    ObjclsFrms.loadList("InsRoles", "sp_Masters", roles.ToString(), arr);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                
            }
            catch (Exception ex)
            {
                this.ltrlMessage.Text = "<div class='alert alert-error'><button class='close' data-dismiss='alert'></button>Role already exists</div>";
                UICommon.LogException(ex, "Add Edit Role");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddRole.aspx btnSave_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("Roles.aspx");
        }

        public void defaultPages()
        {
            string roles = this.txtEnglishTitle.Text;
            System.Data.DataTable lst = ObjclsFrms.loadList("SelDefaultPages", "sp_Masters", roles.ToString());
            if (lst.Rows.Count > 0)
            {
                ddldefaultpage.DataSource = lst;
                ddldefaultpage.DataValueField = "PageUrl";
                ddldefaultpage.DataTextField = "PageName";
                ddldefaultpage.DataBind();
            }
        }

        public string ResponseID
        {
            get
            {
                return Request.Params["ID"] ?? string.Empty; 
            }
        }
        public void FillForm()
        {
            DataTable lstRole = default(DataTable);
            if (ResponseID == "")
            {
                lstRole= new DataTable(); 
            }
            else
            {
                lstRole = ObjclsFrms.loadList("SelectRoleByID", "sp_Masters", ResponseID.ToString());
                if (lstRole.Rows.Count > 0)
                {
                    string RoleID, PageName;

                    RoleID = lstRole.Rows[0]["RoleName"].ToString();
                    PageName = lstRole.Rows[0]["PageName"].ToString();

                    txtEnglishTitle.Text = RoleID.ToString();
                    txtEnglishTitle.Enabled = false;
                    ddldefaultpage.SelectedValue = PageName.ToString();
                }
            }
            
        }

       

    }
}