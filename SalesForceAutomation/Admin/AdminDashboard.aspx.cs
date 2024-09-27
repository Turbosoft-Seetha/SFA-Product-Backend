using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Telerik.Web.UI;
using System.Drawing;

namespace SalesForceAutomation.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdFromData.SelectedDate = DateTime.Now;
                ViewState["Chart"] = null;
                Route();
                rdRoute.SelectedIndex = 0;
                //SelCusVisits();
                //SelCusSchVisits();
                //SelTargetDailyAmt();
                //SelTargetDailyQty();
                //SelTargetMonthlyQty();
                //SelTargetMonthlyAmt();
                //SelProdVisits();
                //SelLoads();
                //SelOrders();
                //SelSalesReport();
                //SelAR();
                //SelAP();
                //TimeSetReport();
                //SelCollectionReport();
                //ClientScript.RegisterStartupScript(GetType(), "Open", ViewState["Chart"].ToString(), true);
            }
        }

        public void Route() {
            DataTable dt = ObjclsFrms.loadList("SelRoutes", "sp_Dashboard");
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "RouteName";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            SelCusVisits();
            SelCusSchVisits();
            SelTargetDailyAmt();
            SelTargetDailyQty();
            SelTargetMonthlyQty();
            SelTargetMonthlyAmt();
            SelProdVisits();
            SelLoads();
            SelOrders();
            SelSalesReport();
            SelAR();
            SelAP();
            TimeSetReport();
            SelCollectionReport();
            //ClientScript.RegisterStartupScript(GetType(), "Open", ViewState["Chart"].ToString(), true);
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", ViewState["Chart"].ToString(), false);

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> "+ ViewState["Chart"].ToString() + " </script>", false);
       
        }

        public DataTable LoadData(string mode )
        {
            Session["FromDate"] = rdFromData.SelectedDate.ToString();
            string para1 = rdRoute.SelectedValue.ToString();
            string[] arr = new string[] { DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyy-MM-dd")  };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_Dashboard", para1, arr);
            return dt;
        }

     

        public void SelCusVisits()
        {
            DataTable dt = LoadData("SelCusVisits");
            DataTable dt1 = LoadData("TotalCusVisits");
           
            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            
            string CuVisits = "ApplyDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'CusTotalVisits' , 'Total Visit' , '" + para1 + "' , 'doughnut' , '0');";
            ViewState["Chart"] += CuVisits;
        }

        public void SelCusSchVisits()
        {
            DataTable dt = LoadData("SelCusSchVisSplit");
            DataTable dt1 = LoadData("SelCusSchVisitsTotal");
           
                string para1 = dt1.Rows[0][0].ToString();
                int i = 0;
                string XAxis = "";
                string YAxis = "";

                foreach (DataColumn dc in dt.Columns)
                {
                    if (i < dt.Columns.Count - 1)
                    {
                        XAxis += dc.ColumnName.ToString() + "-";
                        YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                    }
                    else
                    {
                        XAxis += dc.ColumnName.ToString();
                        YAxis += dt.Rows[0][dc.ColumnName].ToString();
                    }
                    i++;
                }
                string CuVisits = "ApplyDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'CusTotalSchedule' , 'Total Scheduled' ,'" + para1 + "' , 'doughnut' , '0');";
                ViewState["Chart"] += CuVisits;
        }

        public void SelTargetDailyQty()
        {
            
            DataTable dt = LoadData("SelDailyQty");
            if(dt.Rows.Count > 0)
            {
                string XAxis = "";
                string YAxis = "";
                string YAxis2 = "";
                int i = 0;
                foreach (DataColumn dc in dt.Columns)
                {
                  
                        if (i < dt.Columns.Count - 1)
                        {
                            YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                            XAxis += dc.ColumnName.ToString() + "-";
                        }
                        else
                        {
                            YAxis += dt.Rows[0][dc.ColumnName].ToString();
                            XAxis += dc.ColumnName.ToString();
                        }
                    i++;
                }
                i = 0;

                string CuVisits = "ApplyBarChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'DailyQty' , 'Quantity' ,'" + "" + "' , 'bar', '0');";
                ViewState["Chart"] += CuVisits;
            }
          

        }

        public void SelTargetDailyAmt()
        {

            DataTable dt = LoadData("SelDailyAmt");
            if (dt.Rows.Count > 0)
            {
                string XAxis = "";
                string YAxis = "";
                string YAxis2 = "";
                int i = 0;
                foreach (DataColumn dc in dt.Columns)
                {

                    if (i < dt.Columns.Count - 1)
                    {
                        YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                        XAxis += dc.ColumnName.ToString() + "-";
                    }
                    else
                    {
                        YAxis += dt.Rows[0][dc.ColumnName].ToString();
                        XAxis += dc.ColumnName.ToString();
                    }
                    i++;
                }
                i = 0;

                string CuVisits = "ApplyBarChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'DailyAmt' , 'Amount' ,'" + "" + "', 'bar' , '0');";
                ViewState["Chart"] += CuVisits;
            }


        }

        public void SelTargetMonthlyQty()
        {

            DataTable dt = LoadData("SelMonthlyQty");
            if (dt.Rows.Count > 0)
            {
                string XAxis = "";
                string YAxis = "";
                string YAxis2 = "";
                int i = 0;
                foreach (DataColumn dc in dt.Columns)
                {

                    if (i < dt.Columns.Count - 1)
                    {
                        YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                        XAxis += dc.ColumnName.ToString() + "-";
                    }
                    else
                    {
                        YAxis += dt.Rows[0][dc.ColumnName].ToString();
                        XAxis += dc.ColumnName.ToString();
                    }
                    i++;
                }
                i = 0;

                string CuVisits = "ApplyBarChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'MonthlyQty' , 'Quantity' ,'" + "" + "', 'bar', '0');";
                ViewState["Chart"] += CuVisits;
            }


        }

        public void SelTargetMonthlyAmt()
        {

            DataTable dt = LoadData("SelMonthlyAmt");
            if (dt.Rows.Count > 0)
            {
                string XAxis = "";
                string YAxis = "";
                string YAxis2 = "";
                int i = 0;
                foreach (DataColumn dc in dt.Columns)
                {

                    if (i < dt.Columns.Count - 1)
                    {
                        YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                        XAxis += dc.ColumnName.ToString() + "-";
                    }
                    else
                    {
                        YAxis += dt.Rows[0][dc.ColumnName].ToString();
                        XAxis += dc.ColumnName.ToString();
                    }
                    i++;
                }
                i = 0;

                string CuVisits = "ApplyBarChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'MonthlyAmt' , 'Amount' ,'" + "" + "', 'bar', '0');";
                ViewState["Chart"] += CuVisits;
            }


        }


        public void SelTargetMonthly()
        {
            DataTable dt = LoadData("SelRoutePackSumQnty");
            if (dt.Rows.Count > 1)
            {


                string XAxis = "";
                string YAxis = "";
                string YAxis2 = "";
                int i = 0;
                foreach (DataColumn dc in dt.Columns)
                {
                    if (dc.ColumnName != "mode")
                    {
                        if (i < dt.Columns.Count - 1)
                        {
                            YAxis += dt.Rows[1][dc.ColumnName].ToString() + "-";
                            XAxis += dc.ColumnName.ToString() + "-";
                        }
                        else
                        {
                            YAxis += dt.Rows[1][dc.ColumnName].ToString();
                            XAxis += dc.ColumnName.ToString();
                        }
                    }

                    i++;
                }
                i = 0;

                
                string CuVisits = "ApplyBarChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'Monthlytarget' , 'Monthly Target' ,'" + "" + "', 'bar', '0');";

                ViewState["Chart"] += CuVisits;
            }
           

        }

        public void SelProdVisits() 
        {
            DataTable dt = LoadData("SelProdVisSplit");
            DataTable dt1 = LoadData("SelProdVisits");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            string CuVisits = "ApplyDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'prdVisits' , 'Productive Visits' ,'" + para1 + "' , 'doughnut' , '0'); ";
            ViewState["Chart"] += CuVisits;
        }

        public void SelLoads()
        {
            DataTable dt = LoadData("SelLICountSplit");
            DataTable dt1 = LoadData("SelLiCount");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            string CuVisits = "ApplyDoughnutCharts('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'LoadRprts' , 'Total Loads' ,'" + para1 + "' , 'doughnut' , '1'); ";
            ViewState["Chart"] += CuVisits;
        }

        public void SelOrders()
        {
            lblTotOrdCount.Text = String.Empty;
            //lblGSCount.Text = String.Empty;
            //lblBSCount.Text = String.Empty;
            DataTable dtOrders = LoadData("SelOrderCount");
            DataTable dtBs = LoadData("SelBSCount");
            DataTable dtGs = LoadData("SelGSCount");
            lblTotOrdCount.Text = dtOrders.Rows[0][0].ToString();
            //lblGSCount.Text = dtGs.Rows[0][0].ToString();
            //lblBSCount.Text = dtBs.Rows[0][0].ToString();
        }

        public void SelSalesReport()
        {
            DataTable dt = LoadData("SelAllSalesSplit");
            DataTable dt1 = LoadData("SelAllSales");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }

            string CuVisits = "ApplyBarCharts('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'salesReport' , 'Total Invoices' ,'" + para1 + "', 'bar', '3');";
            ViewState["Chart"] += CuVisits;
            }

        public void SelAR()
        {
            lblTotalAR.Text = String.Empty;
            lblCashAr.Text = String.Empty;
            lblChequeAR.Text = String.Empty;
            DataTable dt = LoadData("SelARSplit");
            DataTable dt1 = LoadData("SelTotalAR");
            if (dt1.Rows.Count > 0)
            {
                string para1 = dt1.Rows[0][0].ToString();
                int i = 0;
                string XAxis = "";
                string YAxis = "";

                foreach (DataColumn dc in dt.Columns)
                {
                    if (i < dt.Columns.Count - 1)
                    {
                        XAxis += dc.ColumnName.ToString() + "-";
                        YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                    }
                    else
                    {
                        XAxis += dc.ColumnName.ToString();
                        YAxis += dt.Rows[0][dc.ColumnName].ToString();
                    }
                    i++;
                }
                string CuVisits = "ApplyDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'ARcollection' , 'AR' ,'" + para1 + "' , 'doughnut' , '2');";
                ViewState["Chart"] += CuVisits;

                dt = LoadData("SelARSplitWithSum");
                dt1 = LoadData("SelTotalARWithSum");

                string totalAr = dt1.Rows[0][0].ToString(); 
                string CashAr = dt.Rows[0][0].ToString();
                string cheqAr = dt.Rows[0][1].ToString();

                lblTotalAR.Text = totalAr;
                lblCashAr.Text = CashAr;
                lblChequeAR.Text = cheqAr;
            }
          



        }


        public void SelAP()
        {
            lblAPTotal.Text = String.Empty;
            lblAPCheque.Text = String.Empty;
            lblAPCash.Text = String.Empty;
            DataTable dt = LoadData("SelAPSplit");
            DataTable dt1 = LoadData("SelTotalAP");
            if (dt1.Rows.Count > 0)
            {
                string para1 = dt1.Rows[0][0].ToString();
                int i = 0;
                string XAxis = "";
                string YAxis = "";

                foreach (DataColumn dc in dt.Columns)
                {
                    if (i < dt.Columns.Count - 1)
                    {
                        XAxis += dc.ColumnName.ToString() + "-";
                        YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                    }
                    else
                    {
                        XAxis += dc.ColumnName.ToString();
                        YAxis += dt.Rows[0][dc.ColumnName].ToString();
                    }
                    i++;
                }
                string CuVisits = "ApplyDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'APCollection' , 'Advance' ,'" + para1 + "' , 'doughnut' , '2');";
                ViewState["Chart"] += CuVisits;

                dt = LoadData("SelAPSplitWithSum");
                dt1 = LoadData("SelTotalAPWithSum");

                string totalAr = dt1.Rows[0][0].ToString();
                string CashAr = dt.Rows[0][0].ToString();
                string cheqAr = dt.Rows[0][1].ToString();

                lblAPTotal.Text = totalAr;
                lblAPCash.Text = CashAr;
                lblAPCheque.Text = cheqAr;
            }
        }

        public void TimeSetReport()
        {
            lblHours.Text = String.Empty;
            lblStartTime.Text = String.Empty;
            lblSpendWithCus.Text = String.Empty;
            lblEndTime.Text = String.Empty;
            lblTotInvs.Text = String.Empty;
            lblCashInvs.Text = String.Empty;
            lblCrInvs.Text = String.Empty;

            DataTable dt = LoadData("selTimeReport");
            DataTable dt1 = LoadData("SelSetlReport");
            if (dt.Rows.Count > 0)
            {
                lblHours.Text = dt.Rows[0]["Duration"].ToString();
                lblStartTime.Text = dt.Rows[0]["StartTime"].ToString();
                lblSpendWithCus.Text = dt.Rows[0]["CusTime"].ToString();
                lblEndTime.Text = dt.Rows[0]["EndDayStatus"].ToString();

                //EndDayStatus

                lblTotInvs.Text = dt1.Rows[0]["TotalAmount"].ToString();
                lblCashInvs.Text = dt1.Rows[0]["CashAmount"].ToString();
                lblCrInvs.Text = dt1.Rows[0]["CreditAmount"].ToString();
            }
        }


        public void SelCollectionReport()
        {
            lblTotalCash.Text = String.Empty;
            lblARCash.Text = String.Empty;
            lblAdvanceCash.Text = String.Empty;
            lblCashInnvoice.Text = String.Empty;
            lblTotalCheque.Text = String.Empty;
            lblARCheque.Text = String.Empty;
            lblAdvanceCheque.Text = String.Empty;

            DataTable dtCash = LoadData("SelCollCashReport");
            DataTable dtCheque = LoadData("SelCollChequeReport");
            DataTable dtChequeCount = LoadData("SelCollChequeCount");

            DataTable dtChequeDetail = LoadData("SelChequeDetail");
            rptCheque.DataSource = dtChequeDetail;
            rptCheque.DataBind();

            string totalCash = dtCash.Rows[0]["total"].ToString();
            string arCash = dtCash.Rows[0]["ar"].ToString();
            string advanceCash = dtCash.Rows[0]["advance"].ToString();
            string cashInnvoice = dtCash.Rows[0]["cashInvoice"].ToString();
            string totalCheque = dtCheque.Rows[0]["total"].ToString();
            string arCheque = dtCheque.Rows[0]["ar"].ToString();
            string advanceCheque = dtCheque.Rows[0]["advance"].ToString();
            string chequeCount = dtChequeCount.Rows[0]["total"].ToString();

            lblTotalCash.Text = totalCash;
            lblARCash.Text = arCash;
            lblAdvanceCash.Text = advanceCash;
            lblCashInnvoice.Text = cashInnvoice;
            lblTotalCheque.Text = chequeCount + " / " + totalCheque;
            lblARCheque.Text = arCheque;
            lblAdvanceCheque.Text = advanceCheque;
        }

        protected void map_Click(object sender, ImageClickEventArgs e)
        {
            string para1 = rdRoute.SelectedValue.ToString();
            string[] arr = new string[] { DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyy-MM-dd") };
            DataTable dtUdpID = ObjclsFrms.loadList("SelectUserDailyProcessByRouteID", "sp_Dashboard", para1, arr);
            if (dtUdpID.Rows.Count > 0)
            {
                string id = dtUdpID.Rows[0]["udp_ID"].ToString();
                OpenNewBrowserWindow("https://track.dev-ts.online/Home/ViewMap?Id=" + id + "&&mode=DIGITS-SFA", this);
            }
        }

        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
    }
}