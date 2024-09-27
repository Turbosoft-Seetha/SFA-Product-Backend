using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Metadata.Edm;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
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
                Assets();

                fillForm();
                Customer();
            }
        }
        public void Customer()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerName", "sp_Merchandising", CustomerID.ToString());
            if (lstUser.Rows.Count > 0)
            {
                string name = lstUser.Rows[0]["cus_Name"].ToString();
                ltrlCustomer.Text = "Customer :" + name.ToString();
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
		public void Assets()
		{
            string type = ddlType.SelectedValue.ToString();
            DataTable lstType = ObjclsFrms.loadList("DropDownAssets", "sp_Merchandising", type.ToString());
			if (lstType.Rows.Count > 0)
			{
				ddlassets.DataSource = lstType;
				ddlassets.DataValueField = "id";
				ddlassets.DataTextField = "name";
				ddlassets.DataBind();
			}
		}
		protected void ddlType_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
		{
			string selectedAssetType = e.Value;

            if (selectedAssetType != "")
            {
				assets.Visible = false;
				ddlassets.Enabled = false;
                
                DataTable lstAssets = ObjclsFrms.loadList("DropDownAssets", "sp_Merchandising", selectedAssetType);
                if (lstAssets.Rows.Count > 0)
                {
					assets.Visible = true;
					ddlassets.Enabled = true;
					ddlassets.DataSource = lstAssets;
                    ddlassets.DataValueField = "id";
                    ddlassets.DataTextField = "name";
                    ddlassets.DataBind();

                }
				else
				{
					assets.Visible = false;
					ddlassets.Enabled = false;
				}
			}
			else
			{
				assets.Visible = false;
				ddlassets.Enabled = false;
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
                   // string name, code, status, type, customer;

					//name = lstData.Rows[0]["asc_Name"].ToString();
					//code = lstData.Rows[0]["asc_Code"].ToString();

					string  status, type, assets, customer;
					type = lstData.Rows[0]["asc_ast_ID"].ToString();
                    assets = lstData.Rows[0]["asc_atm_ID"].ToString();
					status = lstData.Rows[0]["Status"].ToString();
                    customer = lstData.Rows[0]["asc_cus_ID"].ToString();

                    //txtCode.Text = code.ToString();
                    //txtName.Text = name.ToString();
                    ddlType.SelectedValue = type.ToString();
					ddlassets.SelectedValue = assets.ToString();
					ddlStatus.SelectedValue = status.ToString();
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
            //string user, name, code, status, type, customer;
            //code = txtCode.Text.ToString();
            //name = txtName.Text.ToString();
            string user, status, type, assets;//, customer;
			type = ddlType.SelectedValue.ToString();
            assets = ddlassets.SelectedValue.ToString();
			status = ddlStatus.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();


            if (mode.Equals("I"))
            {
               // string[] arr = { code.ToString(), type.ToString(), CustomerID.ToString(), user.ToString(), status.ToString() };
				string[] arr = { CustomerID.ToString(), user.ToString(), status.ToString() ,type.ToString()};
				string lstClaim = ObjclsFrms.SaveData("sp_Merchandising", "InsertAssetMaster", assets.ToString(), arr);
                int sliderID = Int32.Parse(lstClaim.ToString());

                if (sliderID > 0)
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
				//string[] arr = { name.ToString(), code.ToString(), type.ToString(), CustomerID.ToString(), user.ToString(), status.ToString() };
				string[] arr = {assets.ToString(), CustomerID.ToString(), user.ToString(), status.ToString() };
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
            Response.Redirect("ListAssetMaster.aspx?CId=" + CustomerID.ToString());
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAssetMaster.aspx?CId=" + CustomerID.ToString());
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }
    }
}