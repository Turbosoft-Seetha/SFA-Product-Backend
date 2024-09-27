using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListSettingsProfiles : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

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
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectSettingsHeaderByID", "sp_ProfileSettings", ResponseID.ToString());
            lblProfileName.Text = lstUser.Rows[0]["pfh_ProfileName"].ToString();
            lblMaster.Text=lstUser.Rows[0]["pfh_Table"].ToString();

        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            string hid;
            hid = ResponseID.ToString();
            lstUser = ObjclsFrms.loadList("SelectSettingsByID", "sp_ProfileSettings", hid);
            grvRpt.DataSource = lstUser;

            
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        { 

        }
    }
}