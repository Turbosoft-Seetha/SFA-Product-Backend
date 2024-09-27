using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListAssets : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectAssetMaster", "sp_Merchandising",ddlType.SelectedValue.ToString());

            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;
            }

        }
        protected void lnkAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditAssets.aspx");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("atm_ID").ToString();

                Response.Redirect("AddEditAssets.aspx?ID=" + ID.ToString());
            }
            else if (e.CommandName.Equals("Customer"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("atm_ID").ToString();
                Response.Redirect("ListCustomerAssets.aspx?Id=" + ID);
            }
        }

        protected void ddlType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ListData();
            grvRpt.Rebind();
        }
    }
}