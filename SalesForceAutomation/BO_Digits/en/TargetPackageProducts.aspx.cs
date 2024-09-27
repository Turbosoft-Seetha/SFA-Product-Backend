using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class TargetPackageProducts : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["PId"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                HeaderData();
            }
        }
        public void HeaderData()
        {
            DataTable lstUsers = default(DataTable);
            lstUsers = ObjclsFrms.loadList("SelectTargetPackageHeaderById", "sp_Target", ResponseID.ToString());
            if (lstUsers.Rows.Count > 0)
            {
                string target = lstUsers.Rows[0]["tph_Name"].ToString();
                lbltarget.Text = "Target Header : " + target;
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);

            lstUser = ObjclsFrms.loadList("SelPackageDetails", "sp_Dashboard",ResponseID.ToString());

            grvRpt.DataSource = lstUser;


        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
    }
    }