using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class LastRouteCommunicationReport : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadRoute();
                SelRouteHistory();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);
                return ResponseID;
            }
        }
        public void LoadRoute()
        {
            DataTable datas = ObjclsFrms.loadList("SelLastRoute", "sp_KPI_Dashboard", ResponseID.ToString());
            string rot = datas.Rows[0]["rot_ArabicName"].ToString();
            string rotID = datas.Rows[0]["rot_ID"].ToString();
            ViewState["rdRoute"] = rotID.ToString();
            lblrot.Text = rot.ToString();
        }
        public DataTable LoadData(string mode)
        {
            string route = ViewState["rdRoute"].ToString();
            string[] arr = new string[] { ResponseID.ToString() };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", route.ToString(), arr);
            return dt;
        }

        public void SelRouteHistory()
        {
            DataTable dtLastRoute = LoadData("SelLastRouteCommunication");
            rptRouteHistory.DataSource = dtLastRoute;
            rptRouteHistory.DataBind();
        }


    }
}