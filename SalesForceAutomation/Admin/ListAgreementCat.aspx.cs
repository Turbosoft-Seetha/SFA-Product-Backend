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
    public partial class ListAgreementCat : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        public void List()
        {
            DataTable lstUser = default(DataTable);
            lstUser = obj.loadList("selAgreementCat", "sp_Merchandising");
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("act_ID").ToString();
                Response.Redirect("AddEditAgreementCat.aspx?Id=" + ID);
            }

        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/AddEditAgreementCat.aspx");
        }
    }
}