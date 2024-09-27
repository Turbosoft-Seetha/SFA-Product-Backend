using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class ListRoute : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

      
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectRoutes", "sp_Backend");
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
                string ID = dataItem.GetDataKeyValue("rot_ID").ToString();
                Response.Redirect("AddEditRoute.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("CusAssigned"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rot_ID").ToString();
                Response.Redirect("ListCustomerRoute.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("ProAssigned"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rot_ID").ToString();
                Response.Redirect("ListRouteProduct.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("CusWeek"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rot_ID").ToString();
                Response.Redirect("CustomerWeekRoute.aspx?Id=" + ID);
            }

            if (e.CommandName.Equals("WorkingDays"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rot_ID").ToString();
                Response.Redirect("ListRouteWorkingDays.aspx?RId=" + ID);
            }
        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditRoute.aspx?Id=0");
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {

        }
    }
}