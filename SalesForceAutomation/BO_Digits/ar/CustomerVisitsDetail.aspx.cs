using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class CustomerVisitsDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ViewState["FromDate"] = DateTime.Parse(Session["FromDate"].ToString());
                    ViewState["route"] = Session["rdRoute"].ToString();
                    Session["UdpDate"] = ViewState["FromDate"].ToString();
                    Session["UdpRoute"] = ViewState["route"].ToString();
                    LoadDate();

                    SelCusVisits();
                    SelCusSchVisits();
                    SelProdVisits();
                    SelTotalPlannedInPlanned();
                    SelTotalVisitedInPlanned();
                    SelTotalPendingInPlanned();
                    SelTotalActalvisitDetail();
                    SelActalvisitPlannedDetail();
                    SelActalvisitUnPlannedDetail();
                }
                catch (Exception ex)
                {

                }
            }
        }
        public void LoadDate()
        {
            string route = ViewState["route"].ToString();
            string data = DateTime.Parse(ViewState["FromDate"].ToString()).ToString("dd MMM yyyy");
            DataTable datas = ObjclsFrms.loadList("SelKPIrot", "sp_KPI_Dashboard", route);
            string rot;
            rot = datas.Rows[0]["rot_Name"].ToString();
            lbldat.Text = data.ToString();
            lblroute.Text = rot.ToString();
        }
        public DataTable LoadData(string mode)
        {

            string[] arr = new string[] { DateTime.Parse(ViewState["FromDate"].ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", ViewState["route"].ToString(), arr);

            return dt;
        }
        public void SelCusVisits()
        {


            string[] arr = new string[] { DateTime.Parse(ViewState["FromDate"].ToString()).ToString("yyyy-MM-dd") };

            DataTable dt1 = LoadData("TotalPlannedVisitscount");
            DataTable dtCustomerVisit = ObjclsFrms.loadList("TotalPlannedVisitedCount", "sp_KPI_Dashboard", ViewState["route"].ToString(), arr);
            DataTable dtCustomerPending = ObjclsFrms.loadList("TotalPlannedPendingCount", "sp_KPI_Dashboard", ViewState["route"].ToString(), arr);

            lblPlannedVisit.Text = dt1.Rows[0][0].ToString();
            CusTotalVisits.Text = dtCustomerVisit.Rows[0][0].ToString();
            CusPending.Text = dtCustomerPending.Rows[0][0].ToString();
            SelTotalPlannedInPlanned();
            SelTotalVisitedInPlanned();
            SelTotalPendingInPlanned();

        }
        public void SelCusSchVisits()
        {

            string[] arr = new string[] { DateTime.Parse(ViewState["FromDate"].ToString()).ToString("yyyy-MM-dd") };

            DataTable dt2 = LoadData("SelCusSchVisitsTotal");
            DataTable dtActualVisit = ObjclsFrms.loadList("SelCusSchVisSplit", "sp_KPI_Dashboard", ViewState["route"].ToString(), arr);

            lblActualVisit.Text = dt2.Rows[0][0].ToString();
            lblPlanned.Text = dtActualVisit.Rows[0]["Planned"].ToString();
            lblUnplanned.Text = dtActualVisit.Rows[0]["Unplanned"].ToString();
            SelTotalActalvisitDetail();
            SelActalvisitPlannedDetail();
            SelActalvisitUnPlannedDetail();
        }
        public void SelProdVisits()
        {
            DataTable dtProductive = LoadData("SelProdVisSplit");
            int proPlanned, proUnplanned, proTotal;
            proPlanned = Int32.Parse(dtProductive.Rows[0]["ScheduledProdVisits"].ToString());
            proUnplanned = Int32.Parse(dtProductive.Rows[0]["UnscheduledProdVisits"].ToString());
            proTotal = proPlanned + proUnplanned;
            lblProductivePlanned.Text = proPlanned.ToString();
            lblProductiveUnplanned.Text = proUnplanned.ToString();
            lblTotalProductive.Text = proTotal.ToString();

            DataTable dtNonProductive = LoadData("SelNonProdVisSplit");
            int nonProPlanned, nonProUnplanned, nonProTotal;
            nonProPlanned = Int32.Parse(dtNonProductive.Rows[0]["ScheduledNonProdVisits"].ToString());
            nonProUnplanned = Int32.Parse(dtNonProductive.Rows[0]["UnscheduledNonProdVisits"].ToString());
            nonProTotal = nonProPlanned + nonProUnplanned;
            lblNonProductivePlanned.Text = nonProPlanned.ToString();
            lblNonProductiveUnplanned.Text = nonProUnplanned.ToString();
            lblTotalNonProductive.Text = nonProTotal.ToString();
            SelProductivevisitDetail();
            SelProductivePlannedDetail();
            SelProductiveUnPlannedDetail();
            SelNonProductiveUnPlannedDetail();
            SelNonProductivePlannedDetail();
            SelNonProductiveDetail();
        }
        public void SelTotalPlannedInPlanned()
        {
            DataTable dt3 = LoadData("TotalPlannedVisitsdetail");
            rptTotalPlanned.DataSource = dt3;
            rptTotalPlanned.DataBind();

        }
        public void SelTotalVisitedInPlanned()
        {
            DataTable dt4 = LoadData("TotalPlannedVisitedDetail");
            rptTotalVisited.DataSource = dt4;
            rptTotalVisited.DataBind();

        }
        public void SelTotalPendingInPlanned()
        {
            DataTable dt5 = LoadData("TotalPlannedPendingDetail");
            rptTotalPending.DataSource = dt5;
            rptTotalPending.DataBind();

        }
        public void SelTotalActalvisitDetail()
        {
            DataTable dt6 = LoadData("SelCusSchActalVisitsDetail");
            rptActalVisit.DataSource = dt6;
            rptActalVisit.DataBind();

        }
        public void SelActalvisitPlannedDetail()
        {
            DataTable dt7 = LoadData("SelCusSchActualVisPlanned");
            rptActualvisitplanned.DataSource = dt7;
            rptActualvisitplanned.DataBind();

        }
        public void SelActalvisitUnPlannedDetail()
        {
            DataTable dt8 = LoadData("SelCusSchActualVisUnPlanned");
            rptActualVisitUnplanned.DataSource = dt8;
            rptActualVisitUnplanned.DataBind();

        }
        public void SelProductivevisitDetail()
        {
            DataTable dt9 = LoadData("SelCusSchProductivevisits");
            rptproductivedetail.DataSource = dt9;
            rptproductivedetail.DataBind();

        }
        public void SelProductivePlannedDetail()
        {
            DataTable dt10 = LoadData("SelCusSchProductivePlannedvisits");
            rptProductivePlanned.DataSource = dt10;
            rptProductivePlanned.DataBind();

        }
        public void SelProductiveUnPlannedDetail()
        {
            DataTable dt11 = LoadData("SelCusSchProductiveUnPlannedvisits");
            rptProductiveUnPlanned.DataSource = dt11;
            rptProductiveUnPlanned.DataBind();

        }
        public void SelNonProductiveDetail()
        {
            DataTable dt12 = LoadData("SelNonProductivevisitsDetail");
            rptNonproductivedetail.DataSource = dt12;
            rptNonproductivedetail.DataBind();

        }
        public void SelNonProductivePlannedDetail()
        {
            DataTable dt13 = LoadData("SelNonProductivePlannedvisits");
            rptNonproductivePlanned.DataSource = dt13;
            rptNonproductivePlanned.DataBind();

        }
        public void SelNonProductiveUnPlannedDetail()
        {
            DataTable dt14 = LoadData("SelNonProductiveUnPlannedvisits");
            rptNonproductiveUnplanned.DataSource = dt14;
            rptNonproductiveUnplanned.DataBind();

        }


        protected void ButtonTotalPlanned_Click(object sender, EventArgs e)
        {

            LinkButton lnkRowSelection = (LinkButton)sender;
            string[] arguments = lnkRowSelection.CommandArgument.Split(';');
            string rscID = arguments[0];
            string cusID = arguments[1];
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=pl");

        }

        protected void btnTotalVisited_Click(object sender, EventArgs e)
        {

            LinkButton lnkRowSelection = (LinkButton)sender;
            string[] arguments = lnkRowSelection.CommandArgument.Split(';');
            string rscID = arguments[0];
            string cusID = arguments[1];
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=pl");

        }

        protected void btnTotalPending_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string[] arguments = lnkRowSelection.CommandArgument.Split(';');
            string rscID = arguments[0];
            string cusID = arguments[1];
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=pl");

        }

        protected void btnTotalActual_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=act");
        }

        protected void btnActualplanned_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=act");


        }

        protected void btnActualUnplanned_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=act");


        }

        protected void btnTotalProd_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=prd");


        }

        protected void btnPlannedProd_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=prd");


        }

        protected void btnUnplannedprod_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=prd");


        }

        protected void btnNonprodTotal_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=nprd");


        }

        protected void btnNonProdPlanned_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=nprd");


        }

        protected void btnNonprodUnplanned_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/CustomerVisits.aspx?cusID=" + cusID + "&&mode=nprd");


        }

        protected void rptTotalPlanned_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item is RepeaterItem)
            {
                RepeaterItem item = e.Item as RepeaterItem;
                //foreach (RepeaterItem item in rptTotalPlanned.Items)
                //{
                //   // LinkButton btn = new LinkButton();
                //int count = rptTotalPlanned.Items.Count;
                //for (int i = 0; i < count; i++)
                //{
                // string status = rptTotalPlanned.Items[i].FindControl("lblStatus").ToString();
                Label status = (Label)item.FindControl("lblStatus");
                LinkButton btn = (LinkButton)item.FindControl("ButtonTotalPlanned");
                if (status.Text == "Pending")
                {
                    btn.Visible = false;
                }
                //    }
            }
        }
    }
}