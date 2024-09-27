using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using SalesForceAutomation.Admin;

namespace SalesForceAutomation.Admin
{
    public partial class DashboardReport : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                string fromDate, ToDate;
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();
                LoadOrder(fromDate, ToDate);
                LoadInvoice(fromDate, ToDate);
                LoadSales(fromDate, ToDate);
                LoadAdvance(fromDate, ToDate);
                LoadAR(fromDate, ToDate);
            }
        }
        public void LoadOrder(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtOrder = new DataTable();
            dtOrder = ObjclsFrms.loadList("SelDashboardReportOrderData", "sp_Dashboard", fromDate, args);
            lblTotalOrder.Text = dtOrder.Rows[0]["orderCount"].ToString();
            lblTotalOrderSum.Text = dtOrder.Rows[0]["orderSum"].ToString();
        }
        public void LoadInvoice(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtInvoice = new DataTable();
            dtInvoice = ObjclsFrms.loadList("SelDashboardReportInvoiceData", "sp_Dashboard", fromDate, args);
            lblTotalInvoice.Text = dtInvoice.Rows[0]["invoiceCount"].ToString();
            lblTotalInvoiceSum.Text = dtInvoice.Rows[0]["invoiceSum"].ToString();
        }
        public void LoadSales(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtSales = new DataTable();
            dtSales = ObjclsFrms.loadList("SelDashboardReportSalesData", "sp_Dashboard", fromDate, args);
            lblTotalInvoices.Text = dtSales.Rows[0]["salesCount"].ToString();
            lblTotalInvoicesSum.Text = dtSales.Rows[0]["salesSum"].ToString();
            lblTotalGReturns.Text = dtSales.Rows[0]["grCount"].ToString();
            lblTotalGReturnsSum.Text = dtSales.Rows[0]["grSum"].ToString();
            lblTotalBReturns.Text = dtSales.Rows[0]["brCount"].ToString();
            lblTotalBReturnsSum.Text = dtSales.Rows[0]["brSum"].ToString();
            lblTotalFreeGoods.Text = dtSales.Rows[0]["fgCount"].ToString();
        }
        public void LoadAdvance(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtAdvance = new DataTable();
            dtAdvance = ObjclsFrms.loadList("SelDashboardReportAdvanceData", "sp_Dashboard", fromDate, args);
            lblTotalAdvance.Text = dtAdvance.Rows[0]["advanceCount"].ToString();
            lblTotalAdvanceSum.Text = dtAdvance.Rows[0]["advanceSum"].ToString();
        }
        public void LoadAR(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtAR = new DataTable();
            dtAR = ObjclsFrms.loadList("SelDashboardReportARData", "sp_Dashboard", fromDate, args);
            lblTotalAR.Text = dtAR.Rows[0]["arCount"].ToString();
            lblTotalARSum.Text = dtAR.Rows[0]["arSum"].ToString();
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            LoadOrder(fromDate, ToDate);
            LoadInvoice(fromDate, ToDate);
            LoadSales(fromDate, ToDate);
            LoadAdvance(fromDate, ToDate);
            LoadAR(fromDate, ToDate);
        }

        protected void lnkToday_Click(object sender, EventArgs e)
        {
            lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            rdfromDate.SelectedDate = DateTime.Now;
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            LoadOrder(fromDate, ToDate);
            LoadInvoice(fromDate, ToDate);
            LoadSales(fromDate, ToDate);
            LoadAdvance(fromDate, ToDate);
            LoadAR(fromDate, ToDate);
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkYear.Attributes.Remove("Style");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            LoadOrder(fromDate, ToDate);
            LoadInvoice(fromDate, ToDate);
            LoadSales(fromDate, ToDate);
            LoadAdvance(fromDate, ToDate);
            LoadAR(fromDate, ToDate);
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, 1, 1);
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            LoadOrder(fromDate, ToDate);
            LoadInvoice(fromDate, ToDate);
            LoadSales(fromDate, ToDate);
            LoadAdvance(fromDate, ToDate);
            LoadAR(fromDate, ToDate);
        }

        protected void lnkInvoice_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=IN");
        }

        protected void lnkTotalOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListOrders.aspx?mode=1");
        }

        protected void lnkTotalAR_Click(object sender, EventArgs e)
        {
            Response.Redirect("ARHeader.aspx?mode=1");
        }

        protected void lnkTotalAdvance_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAdvancePayment.aspx?mode=1");
        }

        protected void lnkSales_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=SL");
        }

        protected void lnkGRReturns_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=GR");
        }

        protected void lnkBRReturns_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=BR");
        }

        protected void lnkFreeGood_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=FG");
        }
    }
}