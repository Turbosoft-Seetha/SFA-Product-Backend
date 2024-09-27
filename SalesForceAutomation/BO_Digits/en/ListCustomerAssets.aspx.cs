using SalesForceAutomation.Admin;
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
    public partial class ListCustomerAssets : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
       
        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerAssets", "sp_Merchandising",ResponseID.ToString());
           
            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;
            }

        }
        protected void lnkAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditCustomerAssets.aspx");
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
                string ID = dataItem.GetDataKeyValue("asc_ID").ToString();

                Response.Redirect("AddEditCustomerAssets.aspx?ID=" + ID.ToString());
            }

            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("asc_ID").ToString();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = ObjclsFrms.SaveData("sp_Merchandising", "DeleteCustomerAssets", ID.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Customer Asset Removed');</script>", false);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
                }
            }

        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAssets.aspx");

        }
    }
}