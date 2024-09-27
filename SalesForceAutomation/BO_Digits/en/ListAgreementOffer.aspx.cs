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
    public partial class ListAgreementOffer : System.Web.UI.Page
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
            lstUser = obj.loadList("selAgreementOffer", "sp_Merchandising");
            grvRpt.DataSource = lstUser;
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/AddEditAgreementOffer.aspx");
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
                string ID = dataItem.GetDataKeyValue("ago_ID").ToString();
                Response.Redirect("AddEditAgreementOffer.aspx?Id=" + ID);
            }
        }
    }
}