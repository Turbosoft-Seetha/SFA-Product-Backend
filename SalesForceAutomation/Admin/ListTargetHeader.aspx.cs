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
                GridDataItem dataItem = e.Item as GridDataItem;                        //We are creating an object for grid data item 
                string ID = dataItem.GetDataKeyValue("tph_ID").ToString();              //Using the object and a propery "GetDataKeyValue" we can access the value of DataKey in ASPX. which is the ID. 
                Response.Redirect("AddTargetDetail.aspx?Id=" + ID);
            }
        }

        protected void ButtonDetail_Click(object sender, EventArgs e)
        {
                                                                               //To check whether the triggered command name matched or not, in case of multiple command name in aspx side
                                                                               //If it matched the following code will be executed
                                    //With the ID we can redirect to the add page to edit and update the value.
          
            

        }
    }
}