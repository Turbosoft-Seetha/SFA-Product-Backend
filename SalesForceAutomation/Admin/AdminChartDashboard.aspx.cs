using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AdminChartDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Label1.Text = Session["DefaultCurrency"].ToString();
                Label2.Text = Session["DefaultCurrency"].ToString();
                Label3.Text = Session["DefaultCurrency"].ToString();
                Label4.Text = Session["DefaultCurrency"].ToString();
                Label5.Text = Session["DefaultCurrency"].ToString();
                Label6.Text = Session["DefaultCurrency"].ToString();
                Label7.Text = Session["DefaultCurrency"].ToString();
                pnlItems.Visible = true;
                pnlSubCat.Visible = false;
                pnlCategory.Visible = false;
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
            string VertBarChart = "ApplyVertBarChartSelling('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'TopSellingItem' , 'bar' , '0');";
            ViewState["Chart"] += VertBarChart;
        }
        public void TopSellingSubCat(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingSubCat = new DataTable();
            dtTopSellingSubCat = ObjclsFrms.loadList("SelectTopSellingSubCat", "sp_Dashboard", fromDate, args);
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dtTopSellingSubCat.Columns)
            {
                if (i < dtTopSellingSubCat.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dtTopSellingSubCat.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dtTopSellingSubCat.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            string VertBarChart = "ApplyVertBarChartSelling('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'TopSellingSubCat' , 'bar' , '0');";
            ViewState["Chart"] += VertBarChart;
        }
        public void TopSellingCategory(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtTopSellingCategory = new DataTable();
            dtTopSellingCategory = ObjclsFrms.loadList("SelectTopSellingCat", "sp_Dashboard", fromDate, args);
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dtTopSellingCategory.Columns)
            {
                if (i < dtTopSellingCategory.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dtTopSellingCategory.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dtTopSellingCategory.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            string VertBarChart = "ApplyVertBarChartSelling('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'TopSellingCategory' , 'bar' , '0');";
            ViewState["Chart"] += VertBarChart;
        }
        public void MostPerformingRoute(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtMostPerformingRoute = new DataTable();
            dtMostPerformingRoute = ObjclsFrms.loadList("SelectMostPerformRoute", "sp_Dashboard", fromDate, args);
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dtMostPerformingRoute.Columns)
            {
                if (i < dtMostPerformingRoute.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dtMostPerformingRoute.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dtMostPerformingRoute.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            string VertBarChart = "ApplyVertBarChartPopularRoute('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'MostPerformingRoute' , 'bar' , '1');";
            ViewState["Chart"] += VertBarChart;
        }
        public void MostPerformingCustomer(string fromDate, string ToDate)
        {
            string[] args = { ToDate };
            DataTable dtMostPerformingCustomer = new DataTable();
            dtMostPerformingCustomer = ObjclsFrms.loadList("SelectMostPerformCust", "sp_Dashboard", fromDate, args);
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dtMostPerformingCustomer.Columns)
            {
                if (i < dtMostPerformingCustomer.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dtMostPerformingCustomer.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dtMostPerformingCustomer.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            string VertBarChart = "ApplyVertBarChartPopularCustomer('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'MostPerformingCustomer' , 'bar' , '1');";
            ViewState["Chart"] += VertBarChart;
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            pnlItems.Visible = true;
            pnlSubCat.Visible = false;
            pnlCategory.Visible = false;
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
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void lnkToday_Click(object sender, EventArgs e)
        {
            pnlItems.Visible = true;
            pnlSubCat.Visible = false;
            pnlCategory.Visible = false;
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
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            pnlItems.Visible = true;
            pnlSubCat.Visible = false;
            pnlCategory.Visible = false;
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
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            pnlItems.Visible = true;
            pnlSubCat.Visible = false;
            pnlCategory.Visible = false;
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

        protected void btnCategory_Click(object sender, EventArgs e)
        {
            pnlItems.Visible = false;
            pnlSubCat.Visible = false;
            pnlCategory.Visible = true;
            string fromDate, toDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] args = { toDate };
            DataTable dtTopSellingCategory = new DataTable();
            dtTopSellingCategory = ObjclsFrms.loadList("SelectTopSellingCat", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            LinkButton[] nks = { btnItem, btnSubCat };
            ColorManage(btnCategory, nks);

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
            string VertBarChart = "ApplyVertBarChartSelling('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'TopSellingCategory' , 'bar' , '0');";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + VertBarChart + " </script>", false);
        }

        protected void btnSubCat_Click(object sender, EventArgs e)
        {
            pnlItems.Visible = false;
            pnlSubCat.Visible = true;
            pnlCategory.Visible = false;
            string fromDate, toDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] args = { toDate };
            DataTable dtTopSellingSubCat = new DataTable();
            dtTopSellingSubCat = ObjclsFrms.loadList("SelectTopSellingSubCat", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            LinkButton[] nks = { btnItem, btnCategory };
            ColorManage(btnSubCat, nks);

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
            string VertBarChart = "ApplyVertBarChartSelling('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'TopSellingSubCat' , 'bar' , '0');";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + VertBarChart + " </script>", false);
        }

        public void ColorManage(LinkButton lnkActive , LinkButton[] linkButtons)
        {
            lnkActive.CssClass = "btn btn-sm btn-color-muted btn-active btn-active-primary active px-4 me-1";

            for(int i = 0; i < linkButtons.Length; i++)
            {
                 linkButtons[i].CssClass  = "btn btn-sm btn-color-muted btn-active btn-active-primary px-4 me-1";
            }
        }

        protected void btnItem_Click(object sender, EventArgs e)
        {
            pnlItems.Visible = true;
            pnlSubCat.Visible = false;
            pnlCategory.Visible = false;
            string fromDate, toDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] args = { toDate };
            DataTable dtTopSellingItem = new DataTable();
            dtTopSellingItem = ObjclsFrms.loadList("SelectTopSellingItems", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            LinkButton[] nks = { btnSubCat, btnCategory };
            ColorManage(btnItem, nks);

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
            string VertBarChart = "ApplyVertBarChartSelling('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'TopSellingItem' , 'bar' , '0');";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + VertBarChart + " </script>", false);
        }

        protected void lnkRoute_Click(object sender, EventArgs e)
        {
            pnlRoute.Visible = true;
            pnlCustomer.Visible = false;
            string fromDate, toDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] args = { toDate };
            DataTable dtTopSellingItem = new DataTable();
            dtTopSellingItem = ObjclsFrms.loadList("SelectMostPerformRoute", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            LinkButton[] nks = { lnkCustomer };
            ColorManage(lnkRoute, nks);

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
            string VertBarChart = "ApplyVertBarChartPopularRoute('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'MostPerformingRoute' , 'bar' , '1');";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + VertBarChart + " </script>", false);
        }

        protected void lnkCustomer_Click(object sender, EventArgs e)
        {
            pnlRoute.Visible = false;
            pnlCustomer.Visible = true;
            string fromDate, toDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] args = { toDate };
            DataTable dtTopSellingItem = new DataTable();
            dtTopSellingItem = ObjclsFrms.loadList("SelectMostPerformCust", "sp_Dashboard", fromDate, args);
            string XAxis = "";
            string YAxis = "";
            LinkButton[] nks = { lnkRoute };
            ColorManage(lnkCustomer, nks);

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
            string VertBarChart = "ApplyVertBarChartPopularCustomer('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'MostPerformingCustomer' , 'bar' , '1');";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + VertBarChart + " </script>", false);
        }
    }
}