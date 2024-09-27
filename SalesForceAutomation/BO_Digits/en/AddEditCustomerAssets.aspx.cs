using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCustomerAssets : System.Web.UI.Page
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
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["claimID"] = null;
                Type();
                Customer();
                AssetMaster();

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
        public void AssetMaster()
        {
            string[] ar = { AssetID.ToString() };
            DataTable lstType = ObjclsFrms.loadList("DropDownAssetMaster", "sp_Merchandising",ddlType.SelectedValue.ToString(),ar);
            if (lstType.Rows.Count > 0)
            {
                ddlasset.DataSource = lstType;
                ddlasset.DataValueField = "atm_ID";
                ddlasset.DataTextField = "atm_Name";
                ddlasset.DataBind();
            }
        }

        public void Customer()
        {
            DataTable lstType = ObjclsFrms.loadList("SelCustomerDropDown", "sp_Merchandising");
            if (lstType.Rows.Count > 0)
            {
                ddlcustomer.DataSource = lstType;
                ddlcustomer.DataValueField = "cus_ID";
                ddlcustomer.DataTextField = "cus_Name";
                ddlcustomer.DataBind();
            }
        }
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
                    string asset, status, type, customer;

                    asset = lstData.Rows[0]["asc_atm_ID"].ToString();
                    type = lstData.Rows[0]["atm_ast_ID"].ToString();
                    status = lstData.Rows[0]["Status"].ToString();
                    customer = lstData.Rows[0]["asc_cus_ID"].ToString();

                   
                    ddlType.SelectedValue = type.ToString();
                    ddlcustomer.SelectedValue = customer.ToString();
                    ddlcustomer.Enabled = false;
                    ddlStatus.SelectedValue = status.ToString();
                    ddlasset.SelectedValue = asset.ToString();
                }
            }
        }
        protected void Linksave_Click(object sender, EventArgs e)
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
            string user, asset, status, type, customer;
            asset = ddlasset.SelectedValue.ToString();
            type = ddlType.SelectedValue.ToString();
            customer=ddlcustomer.SelectedValue.ToString();
            status = ddlStatus.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();


            if (mode.Equals("I"))
            {
                string[] arr = {   customer.ToString(), user.ToString(), status.ToString() };
                DataTable lstClaim = ObjclsFrms.loadList("InsertCusAsset", "sp_Merchandising", asset.ToString(), arr);
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
                string[] arr = { asset.ToString(),  customer.ToString(), user.ToString(), status.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Merchandising", "UpdateCusAsset", id.ToString(), arr);
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
            Response.Redirect("ListCustomerAssets.aspx");
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerAssets.aspx");
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
           
        }

        protected void ddlType_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            AssetMaster();
        }
    }
}