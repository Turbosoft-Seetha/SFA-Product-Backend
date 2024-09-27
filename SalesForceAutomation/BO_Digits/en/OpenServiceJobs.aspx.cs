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
    public partial class OpenServiceJobs : System.Web.UI.Page
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
            lstUser = ObjclsFrms.loadList("SelPendingServiceJobs", "sp_ServiceRequest");

            if (lstUser.Rows.Count >= 0)
            {
                RadGridServiceJob.DataSource = lstUser;
            }

        }

        protected void RadGridServiceJob_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void btnBulkAssign_Click(object sender, EventArgs e)
        {
            string User = UICommon.GetCurrentUserID().ToString();
            string url = ConfigurationManager.AppSettings.Get("ServiceJobAssign");
            OpenNewBrowserWindow(url + User, this);
        }

        protected void RadGridServiceJob_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem["sjh_snr_ID"].Text.ToString();
                Response.Redirect("UnassignedJobDetail.aspx?ID=" + ID);
            }
        }
    }
}