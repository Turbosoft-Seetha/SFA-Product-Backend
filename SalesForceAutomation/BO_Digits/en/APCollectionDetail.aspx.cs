using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class APCollectionDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["rdfromDate"] = DateTime.Parse(Session["FromDate"].ToString());
            ViewState["rdRoute"] = Session["rdRoute"].ToString();
            Session["UdpDate"] = ViewState["rdfromDate"].ToString();
            Session["UdpRoute"] = ViewState["rdRoute"].ToString();

            LoadDate();
            APHeader();

        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        public DataTable LoadData(string mode)
        {
            Session["FromDate"] = ViewState["rdfromDate"].ToString();
            string route = ViewState["rdRoute"].ToString();
            string[] arr = new string[] { DateTime.Parse(ViewState["rdfromDate"].ToString()).ToString("yyyy-MM-dd"), ResponseID.ToString()};
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", route.ToString(), arr);
            return dt;
        }

        public void APHeader()
        {
            string Number, Cus, Date, Totalcollection, mode ,remarks;
            DataTable lstAp = LoadData("SelAPHeaderDetail");
            if (lstAp.Rows.Count > 0)
            {
                Number = lstAp.Rows[0]["adp_Number"].ToString();
                Cus = lstAp.Rows[0]["customer"].ToString();
                Date = lstAp.Rows[0]["CreatedDate"].ToString();

                Totalcollection = lstAp.Rows[0]["adp_Amount"].ToString();
                mode = lstAp.Rows[0]["Mode"].ToString();
                remarks = lstAp.Rows[0]["adp_Remarks"].ToString();

                lblNumber.Text = Number.ToString();
                lblCus.Text = Cus.ToString();
                lblDate.Text = Date.ToString();
                lblTotalcollection.Text = Totalcollection.ToString();
                lblmode.Text = mode.ToString();
                lblremarks.Text = remarks.ToString();

                string Paymode = lstAp.Rows[0]["adp_PayMode"].ToString();
                if (Paymode == "HC")
                {
                    Img.Visible = false;
                }
                else
                {
                    Img.Visible = true;
                    rptAPCollection.DataSource = lstAp;
                    rptAPCollection.DataBind();
                }
                

            }
            else
            {

            }
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
    }
}