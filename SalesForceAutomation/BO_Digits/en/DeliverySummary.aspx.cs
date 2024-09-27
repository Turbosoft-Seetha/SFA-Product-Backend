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

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class DeliverySummary : System.Web.UI.Page
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
                        btnToday.Attributes.Add("style", "background-color:#dae9f8; color:#60acf9");
                    }

                    rdfromDate.MaxDate = DateTime.Now;
                    ViewState["Chart"] = null;
                    string fromDate, ToDate;
                    fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    TimeLineStripe(fromDate, ToDate);
                    DeliveryCount(fromDate, ToDate);
                    LoadInvoiceAndSales(fromDate, ToDate);
                    MostPerformingRoute(fromDate, ToDate);
                    MostPerformingCustomer(fromDate, ToDate);
                    FrequentlyGoodReturned(fromDate, ToDate);
                    FrequentlyBadReturned(fromDate, ToDate);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            btnToday.Attributes.Remove("Style");
            btnMonth.Attributes.Remove("Style");
            btnYear.Attributes.Remove("Style");
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            TimeLineStripe(fromDate, ToDate);
            DeliveryCount(fromDate, ToDate);
            LoadInvoiceAndSales(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyGoodReturned(fromDate, ToDate);
            FrequentlyBadReturned(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

       

        protected void btnToday_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            btnToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            btnMonth.Attributes.Remove("Style");
            btnYear.Attributes.Remove("Style");
            rdfromDate.SelectedDate = DateTime.Now;
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            TimeLineStripe(fromDate, ToDate);
            DeliveryCount(fromDate, ToDate);
            LoadInvoiceAndSales(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyGoodReturned(fromDate, ToDate);
            FrequentlyBadReturned(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void btnMonth_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            btnMonth.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            btnToday.Attributes.Remove("Style");
            btnYear.Attributes.Remove("Style");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);            
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            TimeLineStripe(fromDate, ToDate);
            DeliveryCount(fromDate, ToDate);
            LoadInvoiceAndSales(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyGoodReturned(fromDate, ToDate);
            FrequentlyBadReturned(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void btnYear_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            btnYear.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            btnMonth.Attributes.Remove("Style");
            btnToday.Attributes.Remove("Style");
            rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, 1, 1);
            rdendDate.SelectedDate = DateTime.Now;
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            TimeLineStripe(fromDate, ToDate);
            DeliveryCount(fromDate, ToDate);
            LoadInvoiceAndSales(fromDate, ToDate);
            MostPerformingRoute(fromDate, ToDate);
            MostPerformingCustomer(fromDate, ToDate);
            FrequentlyGoodReturned(fromDate, ToDate);
            FrequentlyBadReturned(fromDate, ToDate);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        public void TimeLineStripe(string fromDate, string ToDate)
        {
            if (fromDate.Equals(ToDate))
            {
                pnlTimeline.Visible = true;
                string[] arr = {  ToDate };
                DataTable lstActive = ObjclsFrms.loadList("SelectRouteCounts", "sp_Dashboard", fromDate, arr);
                int active = Int32.Parse(lstActive.Rows[0]["active"].ToString());
                int DaysStarted = Int32.Parse(lstActive.Rows[0]["DaysStarted"].ToString());
                int notStarted = Int32.Parse(lstActive.Rows[0]["notStarted"].ToString());
                lblActiveRoute.Text = active.ToString();
                lblProductiveRoute.Text = DaysStarted.ToString();
                lblNonProductiveRoute.Text = notStarted.ToString();
            }
            else
            {
                pnlTimeline.Visible = false;
            }
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

        public void DeliveryCount(string fromDate, string ToDate)
        {
                string[] arr = { ToDate };
                DataTable lstActive = ObjclsFrms.loadList("SelectDeliveryCounts", "sp_Dashboard", fromDate, arr);
                int TotalOrders = Int32.Parse(lstActive.Rows[0]["TotalOrders"].ToString());
                int FullyDeliveredOrders = Int32.Parse(lstActive.Rows[0]["FullyDeliveredOrders"].ToString());
                int PartiallyDeliveredOrders = Int32.Parse(lstActive.Rows[0]["PartiallyDeliveredOrders"].ToString());
                int NotDeliveredOrders = Int32.Parse(lstActive.Rows[0]["NotDeliveredOrders"].ToString());
                lblAllCount.Text = TotalOrders.ToString();
                lblFDCount.Text = FullyDeliveredOrders.ToString();
                lblPDCount.Text = PartiallyDeliveredOrders.ToString();
                lblNDCount.Text = NotDeliveredOrders.ToString();
           
        }

        public void LoadInvoiceAndSales( string fromDate, string ToDate)
        {

            string[] args = { ToDate };
            DataTable dtInvSales = new DataTable();
            dtInvSales = ObjclsFrms.loadList("SelectInvSalesCountandSum", "sp_Dashboard", fromDate, args);

            lblTotalInvoice.Text = dtInvSales.Rows[0]["invoiceCount"].ToString();
            lblTotalInvoiceSum.Text = dtInvSales.Rows[0]["invoiceSum"].ToString();

            lblTotalInvoices.Text = dtInvSales.Rows[0]["salesCount"].ToString();
            lblTotalInvoicesSum.Text = dtInvSales.Rows[0]["salesSum"].ToString();

            lblTotalGReturns.Text = dtInvSales.Rows[0]["grCount"].ToString();
            lblTotalGReturnsSum.Text = dtInvSales.Rows[0]["grSum"].ToString();

            lblTotalBReturns.Text = dtInvSales.Rows[0]["brCount"].ToString();
            lblTotalBReturnsSum.Text = dtInvSales.Rows[0]["brSum"].ToString();

        }

        public void MostPerformingRoute(string fromDate, string ToDate)
        {
            string[] args = {  ToDate };
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
        public void MostPerformingCustomer( string fromDate, string ToDate)
        {
            string[] args = { ToDate };
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
        public void FrequentlyGoodReturned( string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtSelectFrequentlyGoodReturned = new DataTable();
            dtSelectFrequentlyGoodReturned = ObjclsFrms.loadList("SelFreqReturnedGR", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtSelectFrequentlyGoodReturned.Rows.Count; i++)
            {
                if (i < dtSelectFrequentlyGoodReturned.Rows.Count - 1)
                {
                    XAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Quantity"].ToString() + "-";
                    name += dtSelectFrequentlyGoodReturned.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtSelectFrequentlyGoodReturned.Rows.Count - 1)
                {
                    XAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Code"].ToString();
                    YAxis += dtSelectFrequentlyGoodReturned.Rows[i]["Quantity"].ToString();
                    name += dtSelectFrequentlyGoodReturned.Rows[i]["Name"].ToString();
                }
            }

            string FreqReturnedGoodChart = "ApplyHorrBarChartGoodReturned('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "', '" + name.ToString() + "');";
            ViewState["Chart"] += FreqReturnedGoodChart;
        }
        public void FrequentlyBadReturned(string fromDate, string ToDate)
        {
            string[] args = {  ToDate };
            DataTable dtSelectFrequentlyBadReturned = new DataTable();
            dtSelectFrequentlyBadReturned = ObjclsFrms.loadList("SelFreqReturnedBR", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtSelectFrequentlyBadReturned.Rows.Count; i++)
            {
                if (i < dtSelectFrequentlyBadReturned.Rows.Count - 1)
                {
                    XAxis += dtSelectFrequentlyBadReturned.Rows[i]["Code"].ToString() + "-";
                    YAxis += dtSelectFrequentlyBadReturned.Rows[i]["Quantity"].ToString() + "-";
                    name += dtSelectFrequentlyBadReturned.Rows[i]["Name"].ToString() + "{0}";
                }
                else if (i == dtSelectFrequentlyBadReturned.Rows.Count - 1)
                {
                    XAxis += dtSelectFrequentlyBadReturned.Rows[i]["Code"].ToString();
                    YAxis += dtSelectFrequentlyBadReturned.Rows[i]["Quantity"].ToString();
                    name += dtSelectFrequentlyBadReturned.Rows[i]["Name"].ToString();
                }
            }
            string FreqReturnedBadChart = "ApplyHorrBarChartBadReturned('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "', '" + name.ToString() + "');";
            ViewState["Chart"] += FreqReturnedBadChart;
        }

        protected void totalInvoices_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=INV");
        }

        protected void lnkSales_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
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
    }
}