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
    public partial class ListTargetDetail : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);
                return ResponseID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void List()
        {
            DataTable lstdata = obj.loadList("selTargetPackageDetail", "sp_Target",ResponseID.ToString());
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
    }
}