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
    public partial class ShowUOMsForProduct : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        public void LoadData()
        {
            string pid = ResponseID.ToString();
            DataTable lstDatas = default(DataTable);
            lstDatas = ob.loadList("ListUomProducts", "sp_Masters_UOM", pid);
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