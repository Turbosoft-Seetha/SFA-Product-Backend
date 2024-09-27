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
    public partial class ListSalesWeek : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
       
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void List()
        {
            DataTable lstdata = obj.loadList("selSalesWeek", "sp_Masters");
            
            if (lstdata.Rows.Count > 0)
            {
                grvRpt.DataSource = lstdata;
                
            }
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {

        }
        
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
           
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;

                String s = item["slw_WeekStart"].Text;
                if (item["today"].Text=="1")
                {
                   
                    item.BackColor = System.Drawing.Color.AntiqueWhite;
                }
               
            }
        }
    }
}