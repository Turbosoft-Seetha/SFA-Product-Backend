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
    public partial class ListUsers : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void List()
        {
            DataTable lstdata = obj.loadList("SelectUsers", "sp_Masters");
            if (lstdata.Rows.Count > 0)
            {
                grvRpt.DataSource = lstdata;
            }



        }
        protected void lnkAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditUsers.aspx");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))                                           //To check whether the triggered command name matched or not, in case of multiple command name in aspx side
            {                                                                           //If it matched the following code will be executed
                GridDataItem dataItem = e.Item as GridDataItem;                         //We are creating an object for grid data item 
                string ID = dataItem.GetDataKeyValue("usr_ID").ToString();              //Using the object and a propery "GetDataKeyValue" we can access the value of DataKey in ASPX. which is the ID. 
                Response.Redirect("AddEditUsers.aspx?Id=" + ID);                         //With the ID we can redirect to the add page to edit and update the value.
            }
        }
    }
}