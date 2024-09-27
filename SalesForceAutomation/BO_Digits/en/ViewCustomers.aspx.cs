using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewCustomers : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListCustomer", "sp_Masters");
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
                Response.Redirect("ViewAddEditCustomer.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("Location"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
                Response.Redirect("ViewListCustomerInnerLocation.aspx?CId=" + ID);
            }
            if (e.CommandName.Equals("Asset"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
                Response.Redirect("ViewListAssetMaster.aspx?CId=" + ID);
            }

            if (e.CommandName.Equals("Documents"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
                Response.Redirect("ViewListDocuments.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("Map"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string geoCode = dataItem["cus_GeoCode"].Text.ToString();
                string map = "http://maps.google.com?q=" + geoCode.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Open", "window.open('" + map + "');", true);

            }

        }
    }
}