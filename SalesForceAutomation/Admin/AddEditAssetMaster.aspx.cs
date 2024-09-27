using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditAssetMaster : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int AssetID
        {
            get
            {
                int AssetID;
                int.TryParse(Request.Params["Id"], out AssetID);

                return AssetID;
            }
        }
        public int CustomerID
        {
            get
            {
                int CustomerID;
                int.TryParse(Request.Params["CId"], out CustomerID);

                return CustomerID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["claimID"] = null;
                Type();
               
                fillForm();
            }
        }
        public void Type()
        {
            DataTable lstType = ObjclsFrms.loadList("DropDownAssetType", "sp_Merchandising");
            if (lstType.Rows.Count > 0)
            {
                ddlType.DataSource = lstType;
                ddlType.DataValueField = "id";
                ddlType.DataTextField = "name";
                ddlType.DataBind();
            }
        }
        //public void Customer()
        //{
        //    DataTable lstCustomer = ObjclsFrms.loadList("DropDownCustomer", "sp_Merchandising");
        //    if (lstCustomer.Rows.Count > 0)
        //    {
        //        ddlCustomer.DataSource = lstCustomer;
        //        ddlCustomer.DataValueField = "id";
        //        ddlCustomer.DataTextField = "name";
        //        ddlCustomer.DataBind();
        //    }
        //}
        protected void fillForm()
        {
            if (AssetID == 0)
            {
                
            }
            else
            {
                DataTable lstData = default(DataTable);
                lstData = ObjclsFrms.loadList("SelectAssetMasterByID", "sp_Merchandising", AssetID.ToString());
                if (lstData.Rows.Count > 0)
                {
                    string name, code, status, type, customer;

                    name = lstData.Rows[0]["asc_Name"].ToString();
                    code = lstData.Rows[0]["asc_Code"].ToString();
                    type = lstData.Rows[0]["asc_ast_ID"].ToString();
                    status = lstData.Rows[0]["Status"].ToString();
                    customer = lstData.Rows[0]["asc_cus_ID"].ToString();

                    txtCode.Text = code.ToString();
                    txtName.Text = name.ToString();
                    ddlType.SelectedValue = type.ToString();
                    
                    ddlStatus.SelectedValue = status.ToString();
                }
            }
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAssetMaster.aspx?Id=" + CustomerID.ToString());
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                if (AssetID == 0)
                {
                    string mode = "I";
                    Save(mode);
                }
                else
                {
                    string mode = "U";
                    Save(mode);
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditAssetMaster.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void Save(string mode)
        {
            string user, name, code, status, type, customer;
            code = txtCode.Text.ToString();
            name = txtName.Text.ToString();
            type = ddlType.SelectedValue.ToString();
           
            status = ddlStatus.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();


            if (mode.Equals("I"))
            {
                string[] arr = { code.ToString(), type.ToString(), CustomerID.ToString(), user.ToString(), status.ToString() };
                DataTable lstClaim = ObjclsFrms.loadList("InsertAssetMaster", "sp_Merchandising", name.ToString(), arr);
                if (lstClaim.Rows.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            else
            {
                string id = AssetID.ToString();
                string[] arr = { name.ToString(), code.ToString(), type.ToString(), CustomerID.ToString(), user.ToString(), status.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "UpdateAssetMaster", id.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }

        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAssetMaster.aspx?Id=" + CustomerID.ToString());
        }
    }
}