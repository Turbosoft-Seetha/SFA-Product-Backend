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
    public partial class ViewItemStdPrice : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        public void LoadData()
        {            
            DataTable lstDatas = default(DataTable);
            lstDatas = ob.loadList("ViewItemStdPrice", "sp_Masters_UOM");
            if (lstDatas.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstDatas;
            }
            else
            {
                grvRpt.DataSource = new DataTable();
            }
        }
    }
}