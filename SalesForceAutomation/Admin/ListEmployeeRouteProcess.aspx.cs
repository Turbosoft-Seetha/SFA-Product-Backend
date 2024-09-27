using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class ListEmployeeRouteProcess : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListEmpRouteProcess", "sp_Masters");
            grvRpt.DataSource = lstUser;
        }
        protected void lnkSubCat_Click(object sender, EventArgs e)
        {

        }

        protected void lnkSubCat_Click1(object sender, EventArgs e)
        {

        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource1(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand1(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
    }
}