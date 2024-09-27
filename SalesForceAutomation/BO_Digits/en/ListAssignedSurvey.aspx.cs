using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListAssignedSurvey : System.Web.UI.Page
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
            string fromdate="", todate="";
            try
            {
                fromdate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
                todate = DateTime.Parse(Session["ToDate"].ToString()).ToString("yyyyMMdd");
            }
            catch(Exception ex) { 
            }
            
            string[] arr = { fromdate,todate, };

            lstUser = ObjclsFrms.loadList("SelectAssignedSurvey", "sp_Merch_Dashboard", Session["rot"].ToString(), arr);
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
    }
}