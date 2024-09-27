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


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ChartDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Region();
                int o = 1;
                foreach (RadComboBoxItem itmss in ddlregion.Items)
                {
                    itmss.Checked = true;
                    o++;
                }
                string Reg = REG();
                string regcondition = " dep_reg_ID in (" + Reg + ")";
                Depot(regcondition);
                int p = 1;
                foreach (RadComboBoxItem itmss in ddldepots.Items)
                {
                    itmss.Checked = true;
                    p++;
                }
                string depo = DPO();
                string dpocondition = " dpa_dep_ID in (" + depo + ")";
                DpoArea(dpocondition);
                int q = 1;
                foreach (RadComboBoxItem itmss in ddldpoAreas.Items)
                {
                    itmss.Checked = true;
                    q++;
                }
                string depoarea = DPOarea();
                string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";
                DpoSubArea(dpoareacondition);
                int R = 1;
                foreach (RadComboBoxItem itmss in ddldpoSubArea.Items)
                {
                    itmss.Checked = true;
                    R++;
                }
                string deposubarea = DPOsubarea();
                string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";
                Route(dposubareacondition);
                string rotID;
                //Route();
                RouteFromTransaction();
                rotID = Rot();
                try
                {
                    DataTable dtcurrency = new DataTable();
                    dtcurrency = ObjclsFrms.loadList("DefaultCurrency", "sp_Masters");
                    Session["DefaultCurrency"] = dtcurrency.Rows[0]["apc_Value"].ToString();
                    lblCurrency.Text = Session["DefaultCurrency"].ToString();
                    Label1.Text = Session["DefaultCurrency"].ToString();
                    Label2.Text = Session["DefaultCurrency"].ToString();
                    Label3.Text = Session["DefaultCurrency"].ToString();
                    Label4.Text = Session["DefaultCurrency"].ToString();
                    Label5.Text = Session["DefaultCurrency"].ToString();
                    Label6.Text = Session["DefaultCurrency"].ToString();
                    lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                    string fromDate, ToDate;
                    rdfromDate.SelectedDate = DateTime.Now;
                    rdfromDate.MaxDate = DateTime.Now;
                    rdendDate.SelectedDate = DateTime.Now;
                    fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                    Session["ToDate"] = rdendDate.SelectedDate.ToString();
                    TimeLineStripe(rotID, fromDate, ToDate);
                    LoadOrder(rotID, fromDate, ToDate);
                    LoadInvoice(rotID, fromDate, ToDate);
                    LoadSales(rotID, fromDate, ToDate);
                    LoadAdvance(rotID, fromDate, ToDate);
                    LoadAR(rotID, fromDate, ToDate);
                    LoadVisits(rotID, fromDate);

                    ViewState["Chart"] = null;

                    TopSellingItem(rotID, fromDate, ToDate);
                    TopSellingSubCat(rotID, fromDate, ToDate);
                    TopSellingCategory(rotID, fromDate, ToDate);
                    MostPerformingRoute(rotID, fromDate, ToDate);
                    MostPerformingCustomer(rotID, fromDate, ToDate);
                    FrequentlyGoodReturned(rotID, fromDate, ToDate);
                    FrequentlyBadReturned(rotID, fromDate, ToDate);
                    MonthlySales(rotID, fromDate, ToDate);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

                }
                catch (Exception ex)
                {

                }
            }
        }
        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in ddlRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public string Rot()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var CollectionMarket = ddlRoute.CheckedItems;
                    int MarCount = CollectionMarket.Count;
                    if (CollectionMarket.Count > 0)
                    {
                        foreach (var item in CollectionMarket)
                        {
                            string rotId = item.Value;
                            createNode(rotId, writer);
                            c++;
                        }
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string rotId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForDropDowns", "sp_Merchandising", UICommon.GetCurrentUserID().ToString(), arr);
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

        public void LoadOrder(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtOrder = new DataTable();
            dtOrder = ObjclsFrms.loadList("SelDashboardReportOrderData", "sp_Dashboard", route, args);
            lblTotalOrder.Text = dtOrder.Rows[0]["orderCount"].ToString();
            lblTotalOrderSum.Text = dtOrder.Rows[0]["orderSum"].ToString();
        }
        public void LoadInvoice(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtInvoice = new DataTable();
            dtInvoice = ObjclsFrms.loadList("SelDashboardReportInvoiceData", "sp_Dashboard", route, args);
            lblTotalInvoice.Text = dtInvoice.Rows[0]["invoiceCount"].ToString();
            lblTotalInvoiceSum.Text = dtInvoice.Rows[0]["invoiceSum"].ToString();
        }
        public void LoadSales(string route, string fromDate, string ToDate)
        {

            string[] args = { fromDate, ToDate };
            DataTable dtSales = new DataTable();
            dtSales = ObjclsFrms.loadList("SelDashboardReportSalesData", "sp_Dashboard", route, args);
            lblTotalInvoices.Text = dtSales.Rows[0]["salesCount"].ToString();
            lblTotalGReturns.Text = dtSales.Rows[0]["grCount"].ToString();
            lblTotalBReturns.Text = dtSales.Rows[0]["brCount"].ToString();
            lblTotalFreeGoods.Text = dtSales.Rows[0]["fgCount"].ToString();

            lblTotalInvoicesSum.Text = dtSales.Rows[0]["salesSum"].ToString();

            lblTotalGReturnsSum.Text = dtSales.Rows[0]["grSum"].ToString();

            lblTotalBReturnsSum.Text = dtSales.Rows[0]["brSum"].ToString();

        }
        public void LoadAdvance(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtAdvance = new DataTable();
            dtAdvance = ObjclsFrms.loadList("SelDashboardReportAdvanceData", "sp_Dashboard", route, args);
            lblTotalAdvance.Text = dtAdvance.Rows[0]["advanceCount"].ToString();
            lblTotalAdvanceSum.Text = dtAdvance.Rows[0]["advanceSum"].ToString();
        }
        public void LoadAR(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtAR = new DataTable();
            dtAR = ObjclsFrms.loadList("SelDashboardReportARData", "sp_Dashboard", route, args);
            lblTotalAR.Text = dtAR.Rows[0]["arCount"].ToString();
            lblTotalARSum.Text = dtAR.Rows[0]["arSum"].ToString();
        }
        public void TopSellingItem(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtTopSellingItem = new DataTable();
            dtTopSellingItem = ObjclsFrms.loadList("SelectTopSellingItems", "sp_Dashboard", route, args);
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
        public void TopSellingSubCat(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtTopSellingSubCat = new DataTable();
            dtTopSellingSubCat = ObjclsFrms.loadList("SelectTopSellingSubCat", "sp_Dashboard", route, args);
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
        public void TopSellingCategory(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtTopSellingCategory = new DataTable();
            dtTopSellingCategory = ObjclsFrms.loadList("SelectTopSellingCat", "sp_Dashboard", route, args);
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
        public void MostPerformingRoute(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtMostPerformingRoute = new DataTable();
            dtMostPerformingRoute = ObjclsFrms.loadList("SelectMostPerformRoute", "sp_Dashboard", route, args);
            string XAxis = "";
            string YAxis = "";
            string name = "";
            for (int i = 0; i < dtMostPerformingRoute.Rows.Count; i++)
            {
                if (i < dtMostPerformingRoute.Rows.Count - 1)
                {
                    XAxis += dtMostPerformingRoute.Rows[i]["Code"].ToString() + "{0}";
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
        public void MostPerformingCustomer(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtMostPerformingCustomer = new DataTable();
            dtMostPerformingCustomer = ObjclsFrms.loadList("SelectMostPerformCust", "sp_Dashboard", route, args);
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
        public void FrequentlyGoodReturned(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtSelectFrequentlyGoodReturned = new DataTable();
            dtSelectFrequentlyGoodReturned = ObjclsFrms.loadList("SelectFrequentlyGoodReturned", "sp_Dashboard", route, args);
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

        public void FrequentlyBadReturned(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtSelectFrequentlyBadReturned = new DataTable();
            dtSelectFrequentlyBadReturned = ObjclsFrms.loadList("SelectFrequentlyBadReturned", "sp_Dashboard", route, args);
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
        public void MonthlySales(string route, string fromDate, string ToDate)
        {
            string[] args = { fromDate, ToDate };
            DataTable dtMonthlySales = new DataTable();
            dtMonthlySales = ObjclsFrms.loadList("SelectMonthlySales", "sp_Dashboard", route, args);
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
            string rotID;
            rotID = Rot();
            Route(rotID);
            // RouteFromTransaction();
            try
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
                TimeLineStripe(rotID, fromDate, ToDate);
                LoadOrder(rotID, fromDate, ToDate);
                LoadInvoice(rotID, fromDate, ToDate);
                LoadSales(rotID, fromDate, ToDate);
                LoadAdvance(rotID, fromDate, ToDate);
                LoadAR(rotID, fromDate, ToDate);
                TopSellingItem(rotID, fromDate, ToDate);
                TopSellingSubCat(rotID, fromDate, ToDate);
                TopSellingCategory(rotID, fromDate, ToDate);
                MostPerformingRoute(rotID, fromDate, ToDate);
                MostPerformingCustomer(rotID, fromDate, ToDate);
                FrequentlyGoodReturned(rotID, fromDate, ToDate);
                FrequentlyBadReturned(rotID, fromDate, ToDate);
                MonthlySales(rotID, fromDate, ToDate);
                LoadVisits(rotID, fromDate);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkToday_Click(object sender, EventArgs e)
        {
            try
            {
                string rotID;
                //Route();
                //RouteFromTransaction();
                rotID = Rot();
                Route(rotID);
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
                TimeLineStripe(rotID, fromDate, ToDate);
                LoadOrder(rotID, fromDate, ToDate);
                LoadInvoice(rotID, fromDate, ToDate);
                LoadSales(rotID, fromDate, ToDate);
                LoadAdvance(rotID, fromDate, ToDate);
                LoadAR(rotID, fromDate, ToDate);
                TopSellingItem(rotID, fromDate, ToDate);
                TopSellingSubCat(rotID, fromDate, ToDate);
                TopSellingCategory(rotID, fromDate, ToDate);
                MostPerformingRoute(rotID, fromDate, ToDate);
                MostPerformingCustomer(rotID, fromDate, ToDate);
                FrequentlyGoodReturned(rotID, fromDate, ToDate);
                FrequentlyBadReturned(rotID, fromDate, ToDate);
                MonthlySales(rotID, fromDate, ToDate);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            string rotID;
            // Route();
            //RouteFromTransaction();
            rotID = Rot();
            Route(rotID);
            try
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
                TimeLineStripe(rotID, fromDate, ToDate);
                LoadOrder(rotID, fromDate, ToDate);
                LoadInvoice(rotID, fromDate, ToDate);
                LoadSales(rotID, fromDate, ToDate);
                LoadAdvance(rotID, fromDate, ToDate);
                LoadAR(rotID, fromDate, ToDate);
                TopSellingItem(rotID, fromDate, ToDate);
                TopSellingSubCat(rotID, fromDate, ToDate);
                TopSellingCategory(rotID, fromDate, ToDate);
                MostPerformingRoute(rotID, fromDate, ToDate);
                MostPerformingCustomer(rotID, fromDate, ToDate);
                FrequentlyGoodReturned(rotID, fromDate, ToDate);
                FrequentlyBadReturned(rotID, fromDate, ToDate);
                MonthlySales(rotID, fromDate, ToDate);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            string rotID;
            // Route();
            //RouteFromTransaction();
            rotID = Rot();
            Route(rotID);
            try
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
                TimeLineStripe(rotID, fromDate, ToDate);
                LoadOrder(rotID, fromDate, ToDate);
                LoadInvoice(rotID, fromDate, ToDate);
                LoadSales(rotID, fromDate, ToDate);
                LoadAdvance(rotID, fromDate, ToDate);
                LoadAR(rotID, fromDate, ToDate);
                TopSellingItem(rotID, fromDate, ToDate);
                TopSellingSubCat(rotID, fromDate, ToDate);
                TopSellingCategory(rotID, fromDate, ToDate);
                MostPerformingRoute(rotID, fromDate, ToDate);
                MostPerformingCustomer(rotID, fromDate, ToDate);
                FrequentlyGoodReturned(rotID, fromDate, ToDate);
                FrequentlyBadReturned(rotID, fromDate, ToDate);
                MonthlySales(rotID, fromDate, ToDate);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkProductive_Click(object sender, EventArgs e)
        {
            Session["FrmDat"] = rdfromDate.SelectedDate.ToString();
            Session["ToDat"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("RouteTypes.aspx?Type=tml");
        }

        protected void lnkMap_Click(object sender, EventArgs e)
        {
            try
            {
                string fromDate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
                string url = ConfigurationManager.AppSettings.Get("TrackingUrl");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "openlink", "window.open('" + url + "&&date=" + fromDate + "');", true);
                //Response.Write(String.Format("window.open('{0}','_blank')", ResolveUrl(url)));
            }
            catch (Exception ex)
            {

            }
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
        public void TimeLineStripe(string route, string fromDate, string ToDate)
        {
            if (fromDate.Equals(ToDate))
            {
                pnlTimeline.Visible = true;
                string[] arr = { fromDate, ToDate };
                DataTable lstActive = ObjclsFrms.loadList("SelectActiveRouteStatus", "sp_Dashboard", route, arr);
                int active = Int32.Parse(lstActive.Rows[0]["active"].ToString());
                lblActiveRoute.Text = active.ToString();
                DataTable lstProductive = ObjclsFrms.loadList("SelectProductiveRouteStatus", "sp_Dashboard", route, arr);
                int productive = Int32.Parse(lstProductive.Rows[0]["productive"].ToString());
                lblProductiveRoute.Text = productive.ToString();
                int nonprod = active - productive;
                lblNonProductiveRoute.Text = nonprod.ToString();
            }
            else
            {
                pnlTimeline.Visible = false;
            }
        }
        public void LoadVisits(string route, string fromDate)
        {
            DataTable dtPlannedVisit = new DataTable();
            DataTable dtActualVisit = new DataTable();
            DataTable dtProductiveVisit = new DataTable();
            DataTable dtNonProductiveVisit = new DataTable();
            string[] arr = { fromDate };
            dtPlannedVisit = ObjclsFrms.loadList("SelPlannedVisits", "sp_Dashboard", route, arr);
            dtActualVisit = ObjclsFrms.loadList("SelActualVisitSplit", "sp_Dashboard", route, arr);
            dtProductiveVisit = ObjclsFrms.loadList("SelProductiveVisitSplit", "sp_Dashboard", route, arr);
            dtNonProductiveVisit = ObjclsFrms.loadList("SelNonProdVisSplit", "sp_Dashboard", route, arr);
            int proPlanned, proUnplanned, proTotal, nonProPlanned, nonProUnplanned, nonProTotal, pendingPlanned, visitedPlanned, totalPlanned,
                plannedActual, unplannedActual, totalActual;

            visitedPlanned = Int32.Parse(dtPlannedVisit.Rows[0]["visited"].ToString());
            pendingPlanned = Int32.Parse(dtPlannedVisit.Rows[0]["pending"].ToString());
            totalPlanned = visitedPlanned + pendingPlanned;

            plannedActual = Int32.Parse(dtActualVisit.Rows[0]["Planned"].ToString());
            unplannedActual = Int32.Parse(dtActualVisit.Rows[0]["Unplanned"].ToString());
            totalActual = plannedActual + unplannedActual;

            proPlanned = Int32.Parse(dtProductiveVisit.Rows[0]["ScheduledProdVisits"].ToString());
            proUnplanned = Int32.Parse(dtProductiveVisit.Rows[0]["UnscheduledProdVisits"].ToString());
            proTotal = proPlanned + proUnplanned;

            nonProPlanned = Int32.Parse(dtNonProductiveVisit.Rows[0]["ScheduledNonProdVisits"].ToString());
            nonProUnplanned = Int32.Parse(dtNonProductiveVisit.Rows[0]["UnscheduledNonProdVisits"].ToString());
            nonProTotal = nonProPlanned + nonProUnplanned;


            lblTotalPlannedVisit.Text = totalPlanned.ToString();
            lblVisitedPlanned.Text = visitedPlanned.ToString();
            lblPendingPlanned.Text = pendingPlanned.ToString();
            lblTotalActualVisit.Text = totalActual.ToString();
            lblPlannedActual.Text = plannedActual.ToString();
            lblUnplannedActual.Text = unplannedActual.ToString();
            lblTotalProductiveVisit.Text = proTotal.ToString();
            lblPlannedProductive.Text = proPlanned.ToString();
            lblUnplannedProductive.Text = proUnplanned.ToString();
            lblTotalNonProductiveVisit.Text = nonProTotal.ToString();
            lblPlannedNonProd.Text = nonProPlanned.ToString();
            lblUnplannedNonProd.Text = nonProUnplanned.ToString();

        }

        public void Region()
        {
            ddlregion.DataSource = ObjclsFrms.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlregion.DataTextField = "reg_Name";
            ddlregion.DataValueField = "reg_ID";
            ddlregion.DataBind();
        }
        public void Depot(string RegCondition)
        {
            string[] arr = { RegCondition };
            ddldepots.DataSource = ObjclsFrms.loadList("SelectDepotTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldepots.DataTextField = "dep_Name";
            ddldepots.DataValueField = "dep_ID";
            ddldepots.DataBind();
        }
        public void DpoArea(string DpoCondition)
        {
            string u = UICommon.GetCurrentUserID().ToString();
            string[] arr = { DpoCondition };
            ddldpoAreas.DataSource = ObjclsFrms.loadList("SelectDepotAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoAreas.DataTextField = "dpa_Name";
            ddldpoAreas.DataValueField = "dpa_ID";
            ddldpoAreas.DataBind();
        }
        public void DpoSubArea(string DpoAreaCondition)
        {
            string[] arr = { DpoAreaCondition };
            ddldpoSubArea.DataSource = ObjclsFrms.loadList("SelectDepotSubAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoSubArea.DataTextField = "dsa_Name";
            ddldpoSubArea.DataValueField = "dsa_ID";
            ddldpoSubArea.DataBind();
        }
        public string DPO()
        {
            var CollectionMarket1 = ddldepots.CheckedItems;
            string dpoID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        dpoID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dpoID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dpoID += item.Value;
                    }
                    j++;
                }
                return dpoID;
            }
            else
            {
                return "0";
            }
        }
        public string REG()
        {
            var CollectionMarket1 = ddlregion.CheckedItems;
            string regID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        regID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        regID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        regID += item.Value;
                    }
                    j++;
                }
                return regID;
            }
            else
            {
                return "0";
            }
        }

        public string DPOarea()
        {
            var CollectionMarket2 = ddldpoAreas.CheckedItems;
            string dpoareID = "";
            int j = 0;
            int MarCount = CollectionMarket2.Count;
            if (CollectionMarket2.Count > 0)
            {
                foreach (var item in CollectionMarket2)
                {
                    if (j == 0)
                    {
                        dpoareID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dpoareID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dpoareID += item.Value;
                    }
                    j++;
                }
                return dpoareID;
            }
            else
            {
                return "0";
            }
        }
        public string DPOsubarea()
        {
            var CollectionMarket3 = ddldpoSubArea.CheckedItems;
            string dposubareID = "";
            int j = 0;
            int MarCount = CollectionMarket3.Count;
            if (CollectionMarket3.Count > 0)
            {
                foreach (var item in CollectionMarket3)
                {
                    if (j == 0)
                    {
                        dposubareID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dposubareID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dposubareID += item.Value;
                    }
                    j++;
                }
                return dposubareID;
            }
            else
            {
                return "0";
            }
        }

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }

        protected void ddldepots_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

            string dpoID = DPO();

            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
        }

        protected void ddldpoAreas_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();

            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
        }

        protected void ddldpoSubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
        }

        protected void lnkAdvFilter_Click(object sender, EventArgs e)
        {
            if (plhFilter.Visible == true)
            {
                plhFilter.Visible = false;
            }
            else
            {
                plhFilter.Visible = true;
            }
        }

        protected void totalInvoices_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=INV");
        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            rdendDate.MinDate = (DateTime)rdfromDate.SelectedDate;
        }
    }
}