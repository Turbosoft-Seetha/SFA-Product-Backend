using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewAddEditAssetMaster : System.Web.UI.Page
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
    }
}