using System;
using System.Data;
using System.IO;
using System.Web.UI;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListTasks : System.Web.UI.Page
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
                lstUser = ObjclsFrms.loadList("ListTask", "sp_Merchandising");
                grvRpt.DataSource = lstUser;
            
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditTasks.aspx");
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
                string ID = dataItem.GetDataKeyValue("tsk_ID").ToString();
                Response.Redirect("AddEditTasks.aspx?Id=" + ID);
            }
            else if (e.CommandName.Equals("Customer"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("tsk_ID").ToString();
                Response.Redirect("AddTaskCustomerRoute.aspx?Id=" + ID);
            }
        }

      
    }
}