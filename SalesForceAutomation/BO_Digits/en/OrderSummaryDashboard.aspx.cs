using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Telerik.Web.UI;
using System.IO;
using System.Xml;
using Telerik.Web.UI.Chat;
using Stimulsoft.Data.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class OrderSummaryDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {

                    if (Session["FromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                        Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                    }
                    if (Session["ToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());

                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;
                        Session["ToDate"] = rdendDate.SelectedDate.ToString();
                    }

                    if ((rdfromDate.SelectedDate.HasValue && rdfromDate.SelectedDate.Value.Date == DateTime.Today)
                        && (rdendDate.SelectedDate.HasValue && rdendDate.SelectedDate.Value.Date == DateTime.Today))
                    {
                        lnkToday.Attributes.Add("style", "background-color:#dae9f8; color:#60acf9");
                    }

                    rdfromDate.MaxDate = DateTime.Now;
                    ViewState["Chart"] = null;
                    string fromDate, ToDate;
                    fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    TimeLineStripe(fromDate, ToDate);
                    PlannedVisitCount(fromDate, ToDate);
                    ActualVisitCount(fromDate, ToDate);
                    ProdVisitCount(fromDate, ToDate);
                    NonProdVisitCount(fromDate, ToDate);
                    QuotationTile(fromDate, ToDate);
                    SalesOrderTile(fromDate, ToDate);
                    ConfirmedSalesOrderTile(fromDate, ToDate);
                    DeliveredTile(fromDate, ToDate);
                    OutstandingTile(fromDate, ToDate);
                    ArTile(fromDate, ToDate);
                    MonthlySales(fromDate, ToDate);
                    TopSellingItem(fromDate, ToDate);
                    TopSellingSubCat(fromDate, ToDate);
                    TopSellingCategory(fromDate, ToDate);
                    MostPerformingRoute(fromDate, ToDate);
                    MostPerformingCustomer(fromDate, ToDate);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }

        public void TimeLineStripe(string fromDate, string ToDate)
        {
            if (fromDate.Equals(ToDate))
            {
                pnlTimeline.Visible = true;
                string[] arr = { ToDate };
                DataTable lstActive = ObjclsFrms.loadList("SelectRouteCounts", "sp_Dashboard", fromDate, arr);
                string active = lstActive.Rows[0]["active"].ToString();
                string DaysStarted = lstActive.Rows[0]["DaysStarted"].ToString();
                string notStarted = lstActive.Rows[0]["notStarted"].ToString();
                lblActiveRoute.Text = active.ToString();
                lblProductiveRoute.Text = DaysStarted.ToString();
                lblNonProductiveRoute.Text = notStarted.ToString();
            }
            else
            {
                pnlTimeline.Visible = false;
            }
        }
        public void PlannedVisitCount(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetPlannedVisitCounts", "sp_Dashboard", fromDate, arr);
            string total = lstActive.Rows[0]["total"].ToString();
            string visited = lstActive.Rows[0]["visited"].ToString();
            string pending = lstActive.Rows[0]["pending"].ToString();
           
            lblTotalPlannedVisit.Text = total.ToString();
            lblVisitedPlanned.Text = visited.ToString();
            lblPendingPlanned.Text = pending.ToString();          

        }
        public void ActualVisitCount(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetActualVisitCounts", "sp_Dashboard", fromDate, arr);
            string Total = lstActive.Rows[0]["Total"].ToString();
            string Planned = lstActive.Rows[0]["Planned"].ToString();
            string Unplanned = lstActive.Rows[0]["Unplanned"].ToString();

            lblTotalActualVisit.Text = Total.ToString();
            lblPlannedActual.Text = Planned.ToString();
            lblUnplannedActual.Text = Unplanned.ToString();

        }
        public void ProdVisitCount(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetProdVisitCounts", "sp_Dashboard", fromDate, arr);
            string TotalProdVisits = lstActive.Rows[0]["TotalProdVisits"].ToString();
            string ScheduledProdVisits = lstActive.Rows[0]["ScheduledProdVisits"].ToString();
            string UnscheduledProdVisits = lstActive.Rows[0]["UnscheduledProdVisits"].ToString();

            lblTotalProductiveVisit.Text = TotalProdVisits.ToString();
            lblPlannedProductive.Text = ScheduledProdVisits.ToString();
            lblUnplannedProductive.Text = UnscheduledProdVisits.ToString();

        }
        public void NonProdVisitCount(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetNonProdVisitCounts", "sp_Dashboard", fromDate, arr);
            string TotalNonProdVisits = lstActive.Rows[0]["TotalNonProdVisits"].ToString();
            string ScheduledNonProdVisits = lstActive.Rows[0]["ScheduledNonProdVisits"].ToString();
            string UnscheduledNonProdVisits = lstActive.Rows[0]["UnscheduledNonProdVisits"].ToString();

            lblTotalNonProductiveVisit.Text = TotalNonProdVisits.ToString();
            lblPlannedNonProd.Text = ScheduledNonProdVisits.ToString();
            lblUnplannedNonProd.Text = UnscheduledNonProdVisits.ToString();

        }
        public void QuotationTile(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetQuotations", "sp_Dashboard", fromDate, arr);
            string orderCount = lstActive.Rows[0]["orderCount"].ToString();
            string orderSum = lstActive.Rows[0]["orderSum"].ToString();
            lblQot.Text = orderCount.ToString();
            lblQotAmt.Text = orderSum.ToString();           

        }
        public void SalesOrderTile(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetSalesOrders", "sp_Dashboard", fromDate, arr);
            string orderCount = lstActive.Rows[0]["orderCount"].ToString();
            string orderSum = lstActive.Rows[0]["orderSum"].ToString();
            lblSales.Text = orderCount.ToString();
            lblSalesAmt.Text = orderSum.ToString();

        }
        public void ConfirmedSalesOrderTile(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetConfirmedSalesOrders", "sp_Dashboard", fromDate, arr);
            string orderCount = lstActive.Rows[0]["orderCount"].ToString();
            string orderSum = lstActive.Rows[0]["orderSum"].ToString();
            lblConSal.Text = orderCount.ToString();
            lblConSalAmt.Text = orderSum.ToString();

        }
        public void DeliveredTile(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetDelivered", "sp_Dashboard", fromDate, arr);
            string orderCount = lstActive.Rows[0]["orderCount"].ToString();
            string orderSum = lstActive.Rows[0]["orderSum"].ToString();
            lblDel.Text = orderCount.ToString();
            lblDelAmt.Text = orderSum.ToString();

        }
        public void OutstandingTile(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetTotalOutstanding", "sp_Dashboard", fromDate, arr);
            string totcount = lstActive.Rows[0]["totcount"].ToString();
            string totamount = lstActive.Rows[0]["totamount"].ToString();
            lblTotOutstandingCount.Text = totcount;
            lblTotOutstandingAmount.Text = " AED " + totamount;
        }
        public void ArTile(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable lstActive = ObjclsFrms.loadList("GetTotalAR", "sp_Dashboard", fromDate, arr);
            string totcount = lstActive.Rows[0]["arCount"].ToString();
            string totamount = lstActive.Rows[0]["arSum"].ToString();
            lblTotalArCount.Text = totcount ;
            lblTotalArAmount.Text = " AED " + totamount;
        }
        public void MonthlySales(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtMonthlySales = new DataTable();
            dtMonthlySales = ObjclsFrms.loadList("SelectMonthlySalesforOrdSumDB", "sp_Dashboard", fromDate, args);
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
        public void TopSellingItem(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingItem = new DataTable();
            dtTopSellingItem = ObjclsFrms.loadList("SelectTopSellingItemsforOrdSumDB", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtTopSellingItem.Rows.Count; i++)
            {
                if (i < dtTopSellingItem.Rows.Count - 1)
                {
                    XAxis += dtTopSellingItem.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtTopSellingItem.Rows[i]["value_occurrence"].ToString() + "-";
                    name += dtTopSellingItem.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtTopSellingItem.Rows.Count - 1)
                {
                    XAxis += dtTopSellingItem.Rows[i]["Code"].ToString();
                    YAxis += dtTopSellingItem.Rows[i]["value_occurrence"].ToString();
                    name += dtTopSellingItem.Rows[i]["Name"].ToString();
                }
            }
            string ItemBarChart = "ApplyVertBarChartSellingItem('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + name.ToString() + "');";
            ViewState["Chart"] += ItemBarChart;
        }
        public void TopSellingSubCat(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingSubCat = new DataTable();
            dtTopSellingSubCat = ObjclsFrms.loadList("SelectTopSellingSubCatforOrdSumDB", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtTopSellingSubCat.Rows.Count; i++)
            {
                if (i < dtTopSellingSubCat.Rows.Count - 1)
                {
                    XAxis += dtTopSellingSubCat.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtTopSellingSubCat.Rows[i]["value_occurrence"].ToString() + "-";
                    name += dtTopSellingSubCat.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtTopSellingSubCat.Rows.Count - 1)
                {
                    XAxis += dtTopSellingSubCat.Rows[i]["Code"].ToString();
                    YAxis += dtTopSellingSubCat.Rows[i]["value_occurrence"].ToString();
                    name += dtTopSellingSubCat.Rows[i]["Name"].ToString();
                }
            }
            string SubCatBarChart = "ApplyVertBarChartSellingSubCat('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "', '" + name.ToString() + "');";
            ViewState["Chart"] += SubCatBarChart;
        }
        public void TopSellingCategory(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingCategory = new DataTable();
            dtTopSellingCategory = ObjclsFrms.loadList("SelectTopSellingCatforOrdSumDB", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtTopSellingCategory.Rows.Count; i++)
            {
                if (i < dtTopSellingCategory.Rows.Count - 1)
                {
                    XAxis += dtTopSellingCategory.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtTopSellingCategory.Rows[i]["value_occurrence"].ToString() + "-";
                    name += dtTopSellingCategory.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtTopSellingCategory.Rows.Count - 1)
                {
                    XAxis += dtTopSellingCategory.Rows[i]["Code"].ToString();
                    YAxis += dtTopSellingCategory.Rows[i]["value_occurrence"].ToString();
                    name += dtTopSellingCategory.Rows[i]["Name"].ToString();
                }
            }
            string CategoryBarChart = "ApplyVertBarChartSellingCategory('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "', '" + name.ToString() + "');";
            ViewState["Chart"] += CategoryBarChart;
        }

        public void MostPerformingRoute(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtMostPerformingRoute = new DataTable();
            dtMostPerformingRoute = ObjclsFrms.loadList("SelMostPerformingRoute", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtMostPerformingRoute.Rows.Count; i++)
            {
                if (i < dtMostPerformingRoute.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingRoute.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtMostPerformingRoute.Rows[i]["value_occurrence"].ToString() + "-";
                    name += dtMostPerformingRoute.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtMostPerformingRoute.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingRoute.Rows[i]["Code"].ToString();
                    YAxis += dtMostPerformingRoute.Rows[i]["value_occurrence"].ToString();
                    name += dtMostPerformingRoute.Rows[i]["Name"].ToString();
                }
            }
            string RouteBarChart = "ApplyVertBarChartPopularRoute('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "', '" + name.ToString() + "');";
            ViewState["Chart"] += RouteBarChart;
        }

        public void MostPerformingCustomer(string fromDate, string ToDate)
        {
            string[] args = {  ToDate };
            DataTable dtMostPerformingCustomer = new DataTable();
            dtMostPerformingCustomer = ObjclsFrms.loadList("SelMostPerformingCustomer", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtMostPerformingCustomer.Rows.Count; i++)
            {
                if (i < dtMostPerformingCustomer.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingCustomer.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtMostPerformingCustomer.Rows[i]["value_occurrence"].ToString() + "-";
                    name += dtMostPerformingCustomer.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtMostPerformingCustomer.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingCustomer.Rows[i]["Code"].ToString();
                    YAxis += dtMostPerformingCustomer.Rows[i]["value_occurrence"].ToString();
                    name += dtMostPerformingCustomer.Rows[i]["Name"].ToString();
                }
            }
            string CustomerBarChart = "ApplyVertBarChartPopularCustomer('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "', '" + name.ToString() + "');";
            ViewState["Chart"] += CustomerBarChart;
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
            TimeLineStripe(fromDate, ToDate);
            PlannedVisitCount(fromDate, ToDate);
            ActualVisitCount(fromDate, ToDate);
            ProdVisitCount(fromDate, ToDate);
            NonProdVisitCount(fromDate, ToDate);
            QuotationTile(fromDate, ToDate);
            SalesOrderTile(fromDate, ToDate);
            ConfirmedSalesOrderTile(fromDate, ToDate);
            DeliveredTile(fromDate, ToDate);
            OutstandingTile(fromDate, ToDate);
            ArTile(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

        }
        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            lnkMonth.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkToday.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            TimeLineStripe(fromDate, ToDate);
            PlannedVisitCount(fromDate, ToDate);
            ActualVisitCount(fromDate, ToDate);
            ProdVisitCount(fromDate, ToDate);
            NonProdVisitCount(fromDate, ToDate);
            QuotationTile(fromDate, ToDate);
            SalesOrderTile(fromDate, ToDate);
            ConfirmedSalesOrderTile(fromDate, ToDate);
            DeliveredTile(fromDate, ToDate);
            OutstandingTile(fromDate, ToDate);
            ArTile(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }
        protected void lnkYear_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            lnkYear.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkMonth.Attributes.Remove("Style");
            lnkToday.Attributes.Remove("Style");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, 1, 1);
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            TimeLineStripe(fromDate, ToDate);
            PlannedVisitCount(fromDate, ToDate);
            ActualVisitCount(fromDate, ToDate);
            ProdVisitCount(fromDate, ToDate);
            NonProdVisitCount(fromDate, ToDate);
            QuotationTile(fromDate, ToDate);
            SalesOrderTile(fromDate, ToDate);
            ConfirmedSalesOrderTile(fromDate, ToDate);
            DeliveredTile(fromDate, ToDate);
            OutstandingTile(fromDate, ToDate);
            ArTile(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
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
            TimeLineStripe(fromDate, ToDate);
            PlannedVisitCount(fromDate, ToDate);
            ActualVisitCount(fromDate, ToDate);
            ProdVisitCount(fromDate, ToDate);
            NonProdVisitCount(fromDate, ToDate);
            QuotationTile(fromDate, ToDate);
            SalesOrderTile(fromDate, ToDate);
            ConfirmedSalesOrderTile(fromDate, ToDate);
            DeliveredTile(fromDate, ToDate);
            OutstandingTile(fromDate, ToDate);
            ArTile(fromDate, ToDate);
            MonthlySales(fromDate, ToDate);
            TopSellingItem(fromDate, ToDate);
            TopSellingSubCat(fromDate, ToDate);
            TopSellingCategory(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }
        protected void lnkProductive_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("RouteTypes.aspx?Type=tml");
        }
        protected void lnkNotStarted_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
            Response.Redirect("NotStartedRoutes.aspx?Mode=1");
        }
        protected void lnkMap_Click(object sender, EventArgs e)
        {
            try
            {
                string fromDate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
                string url = ConfigurationManager.AppSettings.Get("TrackingUrl");
                string user = UICommon.GetCurrentUserID().ToString();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "openlink", "window.open('" + url + "&&date=" + fromDate + "&UserID=" + user + "');", true);
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }
        protected void lnkPlannedVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;           
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "Planned");
        }
        protected void lnkActualVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "Actual");
        }
        protected void lnkProdVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "Prod");
        }
        protected void lnkNonProdVisit_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] =  null;
            Response.Redirect("CustomerVisitDetailFromDashboard.aspx?Mode=" + "NonProd");
        }       
        protected void lnkOutstanding_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
            Response.Redirect("OutstandingDashboard.aspx?OutStandingMode=1");
        }
        protected void lnkAr_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
            Response.Redirect("ARHeader.aspx?mode=1");
        }
       
    }
}