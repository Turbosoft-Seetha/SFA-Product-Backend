using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class GeoCodeMisMatches : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rddate.SelectedDate = DateTime.Now;
                Route();
            }
        }
        public void Route()
        {

            ddlrot.DataSource = ObjclsFrms.loadList("SelectRotforGeoCodeMismatches", "sp_VisitReports");
            ddlrot.DataTextField = "rot_Name";
            ddlrot.DataValueField = "rot_ID";
            ddlrot.DataBind();
        }
       

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            LoadData();
            grvRpt.Rebind();
          

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            
            string rot = ddlrot.SelectedValue.ToString();
            if(rot.ToString().Equals(""))
            {
                rot = "udp_rot_ID";
            }
            
            string fromDate = DateTime.Parse(rddate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rotcondition = " udp_rot_ID in (" + rot + ")";
            string dateCondition = " and IsOutsideFence = 'N' and cast('" + fromDate + "' as date) between cast(cse_StartTime as date) and cast(cse_EndTime as date) ";
            string maincondition = rotcondition + dateCondition;

            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectGeoCodeMismatches", "sp_VisitReports", maincondition);
            grvRpt.DataSource = lstDatas;
        }

        protected void ddlrot_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {

        }
    }
}