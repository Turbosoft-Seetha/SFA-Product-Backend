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
    public partial class ListTargetHeader : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void List()
        {
            DataTable lstdata = obj.loadList("selTargetPackageHeader", "sp_Merchandising");
            if (lstdata.Rows.Count > 0)
            {
                grvRpt.DataSource = lstdata;
            }
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditTargetHeader.aspx?Id=" + ID);
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            List();

        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("tph_ID").ToString();
                Response.Redirect("AddEditTargetHeader.aspx?Id=" + ID);
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;                        
                string ID = dataItem.GetDataKeyValue("tph_ID").ToString();         
                Response.Redirect("AddTargetDetail.aspx?Id=" + ID);
            
            }
        }

        protected void ButtonDetail_Click(object sender, EventArgs e)
        {
           
        }
    }
}