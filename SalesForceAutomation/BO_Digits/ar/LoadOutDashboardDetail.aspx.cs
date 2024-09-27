using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class LoadOutDashboardDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["rdfromDate"] = DateTime.Parse(Session["FromDate"].ToString());
            ViewState["rdRoute"] = Session["rdRoute"].ToString();
            Session["UdpDate"] = ViewState["rdfromDate"].ToString();
            Session["UdpRoute"] = ViewState["rdRoute"].ToString();


            LoadDate();
            LoadTransfer();
            LoadOut();
            SelCollectionReport();
        }

        public DataTable LoadData(string mode)
        {
            Session["FromDate"] = ViewState["rdfromDate"].ToString();
            string route = ViewState["rdRoute"].ToString();
            string[] arr = new string[] { DateTime.Parse(ViewState["rdfromDate"].ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", route.ToString(), arr);
            return dt;

        }

        public void LoadDate()
        {
            string route = ViewState["rdRoute"].ToString();
            string data = DateTime.Parse(ViewState["rdfromDate"].ToString()).ToString("dd MMM yyyy");
            DataTable datas = ObjclsFrms.loadList("SelKPIrot", "sp_KPI_Dashboard", route);
            string rot;
            rot = datas.Rows[0]["rot_Name"].ToString();
            lbldat.Text = data.ToString();
            lblroute.Text = rot.ToString();
        }
        public void LoadTransfer()
        {
            DataTable lstLTCount = LoadData("SelLTGDCount");
            string good, bad;
            good = lstLTCount.Rows[0]["GDLoadTransfer"].ToString();
            bad = lstLTCount.Rows[0]["BDLoadTransfer"].ToString();
            lblLTGoodStock.Text = good.ToString();
            lblLTBadStock.Text = bad.ToString();
        }


        public void LoadOut()
        {
            DataTable lstLTCount = LoadData("SelLOCount");
            string good, bad;
            good = lstLTCount.Rows[0]["GDLoadOut"].ToString();
            bad = lstLTCount.Rows[0]["BDLoadOut"].ToString();
            lblLOGoodStock.Text = good.ToString();
            lblLOBadStock.Text = bad.ToString();
        }

        public void SelCollectionReport()
        {
            DataTable dtLtGDDetail = LoadData("SelLTGD_KPIDashboard_Detail");
            rptLoadTransferGD.DataSource = dtLtGDDetail;
            rptLoadTransferGD.DataBind();

            DataTable dtLTBDDetail = LoadData("SelLTBD_KPIDashboard_Detail");
            rptLoadTransferBD.DataSource = dtLTBDDetail;
            rptLoadTransferBD.DataBind();

            DataTable dtLOGDDetail = LoadData("SelLOGD_KPIDashboard_Detail");
            rptLOGD.DataSource = dtLOGDDetail;
            rptLOGD.DataBind();

            DataTable dtLOBDDetail = LoadData("SelLOBD_KPIDashboard_Detail");
            rptLOBD.DataSource = dtLOBDDetail;
            rptLOBD.DataBind();

        }



    }
}