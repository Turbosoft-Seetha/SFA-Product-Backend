using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class OpenFSJobs : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelOpenServiceJobs", "sp_ServiceRequest");

            if (lstUser.Rows.Count >= 0)
            {
                RadGridServiceJob.DataSource = lstUser;
            }

        }

        protected void RadGridServiceJob_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

      

        protected void RadGridServiceJob_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem["sjh_snr_ID"].Text.ToString();
                Response.Redirect("OpenFSJobDetails.aspx?ID=" + ID);
            }
        }
    }
}