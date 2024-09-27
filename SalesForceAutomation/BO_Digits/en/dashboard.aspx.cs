using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class dashboard : System.Web.UI.Page
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

                ViewState["Chart"] = null;

                TopSellingItem(fromDate, ToDate);
                TopSellingSubCat(fromDate, ToDate);
                TopSellingCategory(fromDate, ToDate);
                MostPerformingRoute(fromDate, ToDate);
                MostPerformingCustomer(fromDate, ToDate);
                FrequentlyReturned(fromDate, ToDate);
                MonthlySales(fromDate, ToDate);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
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
        public void TopSellingItem(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingItem = new DataTable();
            dtTopSellingItem = ObjclsFrms.loadList("SelectTopSellingItems", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            for (int i = 0; i < dtTopSellingItem.Rows.Count; i++)
            {
                if (i < dtTopSellingItem.Rows.Count - 1)
                {
                    XAxis += dtTopSellingItem.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtTopSellingItem.Rows[i]["value_occurrence"].ToString() + "-";
                }
                else if (i == dtTopSellingItem.Rows.Count - 1)
                {
                    XAxis += dtTopSellingItem.Rows[i]["Code"].ToString();
                    YAxis += dtTopSellingItem.Rows[i]["value_occurrence"].ToString();
                }
            }
            string ItemBarChart = "ApplyVertBarChartSellingItem('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += ItemBarChart;
        }
        public void TopSellingSubCat(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingSubCat = new DataTable();
            dtTopSellingSubCat = ObjclsFrms.loadList("SelectTopSellingSubCat", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";

            for (int i = 0; i < dtTopSellingSubCat.Rows.Count; i++)
            {
                if (i < dtTopSellingSubCat.Rows.Count - 1)
                {
                    XAxis += dtTopSellingSubCat.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtTopSellingSubCat.Rows[i]["value_occurrence"].ToString() + "-";
                }
                else if (i == dtTopSellingSubCat.Rows.Count - 1)
                {
                    XAxis += dtTopSellingSubCat.Rows[i]["Code"].ToString();
                    YAxis += dtTopSellingSubCat.Rows[i]["value_occurrence"].ToString();
                }
            }
            string SubCatBarChart = "ApplyVertBarChartSellingSubCat('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += SubCatBarChart;
        }
        public void TopSellingCategory(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingCategory = new DataTable();
            dtTopSellingCategory = ObjclsFrms.loadList("SelectTopSellingCat", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";

            for (int i = 0; i < dtTopSellingCategory.Rows.Count; i++)
            {
                if (i < dtTopSellingCategory.Rows.Count - 1)
                {
                    XAxis += dtTopSellingCategory.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtTopSellingCategory.Rows[i]["value_occurrence"].ToString() + "-";
                }
                else if (i == dtTopSellingCategory.Rows.Count - 1)
                {
                    XAxis += dtTopSellingCategory.Rows[i]["Code"].ToString();
                    YAxis += dtTopSellingCategory.Rows[i]["value_occurrence"].ToString();
                }
            }
            string CategoryBarChart = "ApplyVertBarChartSellingCategory('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += CategoryBarChart;
        }
        public void MostPerformingRoute(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtMostPerformingRoute = new DataTable();
            dtMostPerformingRoute = ObjclsFrms.loadList("SelectMostPerformRoute", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";

            for (int i = 0; i < dtMostPerformingRoute.Rows.Count; i++)
            {
                if (i < dtMostPerformingRoute.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingRoute.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtMostPerformingRoute.Rows[i]["value_occurrence"].ToString() + "-";
                }
                else if (i == dtMostPerformingRoute.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingRoute.Rows[i]["Code"].ToString();
                    YAxis += dtMostPerformingRoute.Rows[i]["value_occurrence"].ToString();
                }
            }
            string RouteBarChart = "ApplyVertBarChartPopularRoute('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += RouteBarChart;
        }
        public void MostPerformingCustomer(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtMostPerformingCustomer = new DataTable();
            dtMostPerformingCustomer = ObjclsFrms.loadList("SelectMostPerformCust", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";

            for (int i = 0; i < dtMostPerformingCustomer.Rows.Count; i++)
            {
                if (i < dtMostPerformingCustomer.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingCustomer.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtMostPerformingCustomer.Rows[i]["value_occurrence"].ToString() + "-";
                }
                else if (i == dtMostPerformingCustomer.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingCustomer.Rows[i]["Code"].ToString();
                    YAxis += dtMostPerformingCustomer.Rows[i]["value_occurrence"].ToString();
                }
            }
            string CustomerBarChart = "ApplyVertBarChartPopularCustomer('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += CustomerBarChart;
        }
        public void FrequentlyReturned(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtSelectFrequentlyGoodReturned = new DataTable();
            dtSelectFrequentlyGoodReturned = ObjclsFrms.loadList("SelectFrequentlyGoodReturned", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string RAxis = "";

            for (int i = 0; i < dtSelectFrequentlyGoodReturned.Rows.Count; i++)
            {
                if (i < dtSelectFrequentlyGoodReturned.Rows.Count - 1)
                {
                    XAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Quantity"].ToString() + "-";
                    RAxis += dtSelectFrequentlyGoodReturned.Rows[i]["value_occurrence"].ToString() + "-";
                }
                else if (i == dtSelectFrequentlyGoodReturned.Rows.Count - 1)
                {
                    XAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Code"].ToString();
                    YAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Quantity"].ToString();
                    RAxis += dtSelectFrequentlyGoodReturned.Rows[i]["value_occurrence"].ToString();
                }
            }
            DataTable dtSelectFrequentlyBadReturned = new DataTable();
            dtSelectFrequentlyBadReturned = ObjclsFrms.loadList("SelectFrequentlyBadReturned", "sp_Dashboard", fromDate, args);
            string UAxis = "";
            string VAxis = "";
            string WAxis = "";

            for (int i = 0; i < dtSelectFrequentlyBadReturned.Rows.Count; i++)
            {
                if (i < dtSelectFrequentlyBadReturned.Rows.Count - 1)
                {
                    UAxis += dtSelectFrequentlyBadReturned.Rows[i]["Code"].ToString() + "-";
                    VAxis += dtSelectFrequentlyBadReturned.Rows[i]["Quantity"].ToString() + "-";
                    WAxis += dtSelectFrequentlyBadReturned.Rows[i]["value_occurrence"].ToString() + "-";
                }
                else if (i == dtSelectFrequentlyBadReturned.Rows.Count - 1)
                {
                    UAxis += dtSelectFrequentlyBadReturned.Rows[i]["Code"].ToString();
                    VAxis += dtSelectFrequentlyBadReturned.Rows[i]["Quantity"].ToString();
                    WAxis += dtSelectFrequentlyBadReturned.Rows[i]["value_occurrence"].ToString();
                }
            }
            string FreqReturnedBubbleChart = "ApplyBubbleChartReturned('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "','" + RAxis.ToString() + "' , '" + UAxis.ToString() + "' , '" + VAxis.ToString() + "','" + WAxis.ToString() + "');";
            ViewState["Chart"] += FreqReturnedBubbleChart;
        }
        public void MonthlySales(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtMonthlySales = new DataTable();
            dtMonthlySales = ObjclsFrms.loadList("SelectMonthlySales", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string RAxis = "";
            string UAxis = "";

            for (int i = 0; i < dtMonthlySales.Rows.Count; i++)
            {
                if (i < dtMonthlySales.Rows.Count - 1)
                {
                    XAxis += dtMonthlySales.Rows[i]["Months"].ToString() + "-";
                    YAxis += dtMonthlySales.Rows[i]["Sales"].ToString() + "-";
                    RAxis += dtMonthlySales.Rows[i]["Good"].ToString() + "-";
                    UAxis += dtMonthlySales.Rows[i]["Bad"].ToString() + "-";

                }
                else if (i == dtMonthlySales.Rows.Count - 1)
                {
                    XAxis += dtMonthlySales.Rows[i]["Months"].ToString();
                    YAxis += dtMonthlySales.Rows[i]["Sales"].ToString();
                    RAxis += dtMonthlySales.Rows[i]["Good"].ToString();
                    UAxis += dtMonthlySales.Rows[i]["Bad"].ToString();
                }
            }
            string MonthlySalesBarChart = "ApplyTrippleBarChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + RAxis.ToString() + "' , '" + UAxis.ToString() + "');";
            ViewState["Chart"] += MonthlySalesBarChart;
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
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
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyReturned(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void lnkToday_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
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
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyReturned(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
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
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyReturned(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
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
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyReturned(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
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
    }
}