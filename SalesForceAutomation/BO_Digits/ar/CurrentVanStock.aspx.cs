using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class CurrentVanStock : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
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
            if (!Page.IsPostBack)
            {


                Route();
                rdfromDate.SelectedDate = DateTime.Now;
                rdfromDate.Enabled = false;
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["rdRoute"] != null)
                {
                    rdRoute.SelectedValue = Session["rdRoute"].ToString();
                    rdRoute.Enabled = false;

                }



            }
        }
        public void ListData()
        {
            string udpID = ResponseID.ToString();

            string fromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");



            string[] ar = { fromdate, rdRoute.SelectedValue.ToString() };
            DataTable lstdata = ObjclsFrms.loadList("CurrentVanStocks", "sp_Dashboard", udpID, ar);
            grvRpt.DataSource = lstdata;
            //arr = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") ,udpID.ToString()};

        }

        public void Route()
        {
            string userid = UICommon.GetCurrentUserID().ToString();
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters", userid);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }
    }
}