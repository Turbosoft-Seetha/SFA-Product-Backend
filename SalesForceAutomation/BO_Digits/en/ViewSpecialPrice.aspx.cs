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
    public partial class ViewSpecialPrice : System.Web.UI.Page
    {

        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListPriceListHeader", "sp_Masters");
            grvRpt.DataSource = lstUser;
        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditPriceListHeader.aspx?Id=0");

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
                string ID = dataItem.GetDataKeyValue("prh_ID").ToString();
                Response.Redirect("ViewAddEditSpecialPrice.aspx?Id=" + ID);
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prh_ID").ToString();
                Response.Redirect("ViewSpecialPriceDetail.aspx?hid=" + ID);
            }
            if (e.CommandName.Equals("CusAssign"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prh_ID").ToString();
                Response.Redirect("ViewListSpecialPriceAssign.aspx?Id=" + ID);
            }

        }
    }
}