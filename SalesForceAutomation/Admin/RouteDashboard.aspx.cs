using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class RouteDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdfromDate.SelectedDate = DateTime.Now;
                Route();
                SelOrders();
                SelCollectionReport();
                TimeSetReport();
                SelProdVisits();
                LoadTransfer();
                LoadOut();
                TotalInvoices();
                TotalInvoiceAmount();
                ARCollection();
                AdvanceCollection();

                if (Session["udpDate"] != null && Session["udpRoute"] != null)
                {
                    rdfromDate.SelectedDate = DateTime.Parse( Session["udpDate"].ToString());
                    rdRoute.SelectedValue = Session["udpRoute"].ToString();
                   
                }
            }
        }

        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelRoutes", "sp_KPI_Dashboard");
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "RouteName";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        public void LoadOnDemand()
        {
            ViewState["Chart"] = null;
            SelCusVisits();
            SelCusSchVisits();
            SelCollectionReport();
            SelLoads();
            SelSalesReport();
            Settlement();
            TimeSetReport();
            SelOrders();
            SelProdVisits();
            LoadTransfer();
            LoadOut();
            TotalInvoices();
            MonthlyTarget();
            DailyTarget();
            TotalInvoiceAmount();
            ARCollection();
            AdvanceCollection();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            ViewState["Chart"] = null;
            SelCusVisits();
            SelCusSchVisits();
            SelCollectionReport();
            SelLoads();
            SelSalesReport();
            Settlement();
            TimeSetReport();
            SelOrders();
            SelProdVisits();
            LoadTransfer();
            LoadOut();
            TotalInvoices();
            MonthlyTarget();
            DailyTarget();
            TotalInvoiceAmount();
            ARCollection();
            AdvanceCollection();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
        }

        public DataTable LoadData(string mode)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string route = rdRoute.SelectedValue.ToString();
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", route.ToString(), arr);
            return dt;
        }

        public void SelCusVisits()
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string route = rdRoute.SelectedValue.ToString();
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };

            DataTable dt1 = LoadData("TotalCusVisits");
            DataTable dtCustomerVisit = ObjclsFrms.loadList("SelCusVisits", "sp_KPI_Dashboard", route.ToString(), arr);

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dcCustomerVisit in dtCustomerVisit.Columns)
            {
                if (i < dtCustomerVisit.Columns.Count - 1)
                {
                    XAxis += dcCustomerVisit.ColumnName.ToString() + "-";
                    YAxis += dtCustomerVisit.Rows[0][dcCustomerVisit.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dcCustomerVisit.ColumnName.ToString();
                    YAxis += dtCustomerVisit.Rows[0][dcCustomerVisit.ColumnName].ToString();
                }
                i++;
            }
            lblPlannedVisit.Text = para1.ToString();
            string CuVisits = "ApplyPlannedDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += CuVisits;
        }

        public void SelCusSchVisits()
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string route = rdRoute.SelectedValue.ToString();
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };

            DataTable dt1 = LoadData("SelCusSchVisitsTotal");
            DataTable dtActualVisit = ObjclsFrms.loadList("SelCusSchVisSplit", "sp_KPI_Dashboard", route.ToString(), arr);

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dcActualVisit in dtActualVisit.Columns)
            {
                if (i < dtActualVisit.Columns.Count - 1)
                {
                    XAxis += dcActualVisit.ColumnName.ToString() + "-";
                    YAxis += dtActualVisit.Rows[0][dcActualVisit.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dcActualVisit.ColumnName.ToString();
                    YAxis += dtActualVisit.Rows[0][dcActualVisit.ColumnName].ToString();
                }
                i++;
            }
            lblActualVisit.Text = para1.ToString();
            string CuVisits = "ApplyActualDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
            ViewState["Chart"] += CuVisits;
        }

        public void SelCollectionReport()
        {
            lblTotalCheque.Text = String.Empty;
            DataTable dtCheque = LoadData("SelCollChequeReport");
            DataTable dtChequeCount = LoadData("SelCollChequeCount");
            DataTable dtChequeDetail = LoadData("SelChequeDetail");
            rptCheque.DataSource = dtChequeDetail;
            rptCheque.DataBind();
            string totalCheque = dtCheque.Rows[0]["total"].ToString();
            string chequeCount = dtChequeCount.Rows[0]["total"].ToString();
            lblTotalCheque.Text = chequeCount + " / " + totalCheque;
        }

        public void SelLoads()
        {
            DataTable dt = LoadData("SelLICountSplit");
            DataTable dt1 = LoadData("SelLiCount");
            DataTable dts = LoadData("SelLICountSplits");

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
            lblLoadIn.Text = para1.ToString();
            lblLICompleted.Text = dts.Rows[0]["LICompleted"].ToString();
            lblLIPending.Text = dts.Rows[0]["LIPending"].ToString();
            lblLINotProcss.Text = dts.Rows[0]["LINotProcessed"].ToString();
            string CuVisits = "ApplyLoadsDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "'); ";
            ViewState["Chart"] += CuVisits;
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

        public void Settlement()
        {
            TotalCash();
            TotalCollected();
        }

        public void TotalCash()
        {
            UserDailyID();
            string udpId = ViewState["ID"].ToString();
            DataTable lstCashReceived = ObjclsFrms.loadList("SelTotalWithMode", "sp_KPI_Dashboard", udpId.ToString());
            if (lstCashReceived.Rows.Count > 0)
            {
                string mode, amount;
                double sum = 0;
                string hardCash, pos, onlinePay;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    amount = lstCashReceived.Rows[i]["Amount"].ToString();
                    sum += double.Parse(amount);
                    if (mode.Equals("HC"))
                    {
                        hardCash = amount.ToString();
                        ViewState["HardCash"] = hardCash.ToString();
                        lblHardCash.Text = hardCash;
                    }
                    else if (mode.Equals("POS"))
                    {
                        pos = amount.ToString();
                        ViewState["POS"] = pos.ToString();
                        lblPOS.Text = pos;
                    }
                    else if (mode.Equals("OP"))
                    {
                        onlinePay = amount.ToString();
                        ViewState["Online"] = onlinePay.ToString();
                        lblOnlinePayment.Text = onlinePay;
                    }
                }
                lblCashTotal.Text = sum.ToString();
            }
        }

        public void TotalCollected()
        {
            UserDailyID();
            string udpId = ViewState["ID"].ToString();
            DataTable lstCashReceived = ObjclsFrms.loadList("SelectUserSettlementPayModes", "sp_KPI_Dashboard", udpId.ToString());
            if (lstCashReceived.Rows.Count > 0)
            {
                string mode, hcCollected, hcVariance, posCollected, posVariance, opVariance, opCollected;
                double sumCollected = 0, sumVariance = 0;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    sumCollected += double.Parse(lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString());
                    sumVariance += double.Parse(lstCashReceived.Rows[i]["usp_Variance"].ToString());
                    if (mode.Equals("HC"))
                    {
                        hcCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        hcVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVarianceHard.Text = hcVariance.ToString();
                        lblCollectedHard.Text = hcCollected.ToString();
                    }
                    else if (mode.Equals("POS"))
                    {
                        posCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        posVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVariancePos.Text = posVariance.ToString();
                        lblCollectedPos.Text = posCollected.ToString();
                    }
                    else if (mode.Equals("OP"))
                    {
                        opCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        opVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVarainceOnline.Text = opVariance.ToString();
                        lblCollectedOnline.Text = opCollected.ToString();
                    }
                }
                lblCollectedTotal.Text = sumCollected.ToString();
                lblTotalVariance.Text = sumVariance.ToString();            
            }
        }

        public void UserDailyID()
        {
            string date = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MM-yyyy");
            string route = rdRoute.SelectedValue.ToString();
            string[] arr = { date.ToString() };
            DataTable lstID = ObjclsFrms.loadList("SelectUserDailyProcessID", "sp_KPI_Dashboard", route, arr);
            string Id = lstID.Rows[0]["udp_ID"].ToString();
            ViewState["ID"] = Id.ToString();
        }

        public void TimeSetReport()
        {
            lblHours.Text = String.Empty;
            lblStartTime.Text = String.Empty;
            lblSpendWithCus.Text = String.Empty;

            DataTable dt = LoadData("SelTimeReport");
            if (dt.Rows.Count > 0)
            {
                lblHours.Text = dt.Rows[0]["Duration"].ToString();
                lblStartTime.Text = dt.Rows[0]["StartTime"].ToString();
                lblSpendWithCus.Text = dt.Rows[0]["CusTime"].ToString();
            }
        }

        public void SelOrders()
        {
            lblTotOrdCount.Text = String.Empty;
            DataTable dtOrders = LoadData("SelOrderCount");
            lblTotOrdCount.Text = dtOrders.Rows[0][0].ToString();
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

        }

        public void ARCollection()
        {
            string totalCount, totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, chequeCount, chequeAmount;
            DataTable lstAr = LoadData("SelectARCount");
            if(lstAr.Rows.Count > 0)
            {
                totalCount = lstAr.Rows[0]["TotalArCount"].ToString();
                totalAmount = lstAr.Rows[0]["TotalARAmount"].ToString();
                hcCount = lstAr.Rows[0]["AR_HC_Count"].ToString();
                hcAmount = lstAr.Rows[0]["AR_HC_Amount"].ToString();
                posCount = lstAr.Rows[0]["AR_POS_Count"].ToString();
                posAmount = lstAr.Rows[0]["AR_POS_Amount"].ToString();
                opCount = lstAr.Rows[0]["AR_OP_Count"].ToString();
                opAmount = lstAr.Rows[0]["AR_OP_Amount"].ToString();
                chequeCount = lstAr.Rows[0]["AR_Chq_Count"].ToString();
                chequeAmount = lstAr.Rows[0]["AR_Chq_Amount"].ToString();

                lblTotalArAmt.Text = totalCount.ToString() + " / " + totalAmount.ToString();
                lblArHcAmt.Text = hcAmount.ToString();
                lblArHcCount.Text = hcCount.ToString();
                lblArPosAmt.Text = posAmount.ToString();
                lblArPosCount.Text = posCount.ToString();
                lblArOpAmt.Text = opAmount.ToString();
                lblArOpCount.Text = opCount.ToString();
                lblArChequeAmt.Text = chequeAmount.ToString();
                lblArChequeCount.Text = chequeCount.ToString();
            }
            else
            {
                lblTotalArAmt.Text = "0 / 0.00";
                lblArHcAmt.Text = "0.00";
                lblArHcCount.Text = "0";
                lblArPosAmt.Text = "0.00";
                lblArPosCount.Text = "0";
                lblArOpAmt.Text = "0.00";
                lblArOpCount.Text = "0";
                lblArChequeAmt.Text = "0.00";
                lblArChequeCount.Text = "0";
            }
        }

        public void AdvanceCollection()
        {
            string totalCount, totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, chequeCount, chequeAmount;
            DataTable lstAdvance = LoadData("SelectAdvanceCount");
            if(lstAdvance.Rows.Count > 0)
            {
                totalCount = lstAdvance.Rows[0]["TotalApCount"].ToString();
                totalAmount = lstAdvance.Rows[0]["TotalAPAmount"].ToString();
                hcCount = lstAdvance.Rows[0]["AP_HC_Count"].ToString();
                hcAmount = lstAdvance.Rows[0]["AP_HC_Amount"].ToString();
                posCount = lstAdvance.Rows[0]["AP_POS_Count"].ToString();
                posAmount = lstAdvance.Rows[0]["AP_POS_Amount"].ToString();
                opCount = lstAdvance.Rows[0]["AP_OP_Count"].ToString();
                opAmount = lstAdvance.Rows[0]["AP_OP_Amount"].ToString();
                chequeCount = lstAdvance.Rows[0]["AP_Chq_Count"].ToString();
                chequeAmount = lstAdvance.Rows[0]["AP_Chq_Amount"].ToString();

                lblTotalAdvAmt.Text = totalCount.ToString() + " / " + totalAmount.ToString();
                lblAdvHcAmt.Text = hcAmount.ToString();
                lblAdvHcCount.Text = hcCount.ToString();
                lblAdvPosAmt.Text = posAmount.ToString();
                lblAdvPosCount.Text = posCount.ToString();
                lblAdvOpAmt.Text = opAmount.ToString();
                lblAdvOpCount.Text = opCount.ToString();
                lblAdvChequeAmt.Text = chequeAmount.ToString();
                lblAdvChequeCount.Text = chequeCount.ToString();
            }
            else
            {
                lblTotalAdvAmt.Text = "0 / 0.00";
                lblAdvHcAmt.Text = "0.00";
                lblAdvHcCount.Text = "0";
                lblAdvPosAmt.Text = "0.00";
                lblAdvPosCount.Text = "0";
                lblAdvOpAmt.Text = "0.00";
                lblAdvOpCount.Text = "0";
                lblAdvChequeAmt.Text = "0.00";
                lblAdvChequeCount.Text = "0";
            }
        }

        public void TotalInvoiceAmount()
        {
            string totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, creditCount, creditAmount;
            DataTable lstInvoice = LoadData("SelectTotalInvoiceCollection");
            if (lstInvoice.Rows.Count > 0)
            {
                totalAmount = lstInvoice.Rows[0]["TotalInvAmount"].ToString();
                hcCount = lstInvoice.Rows[0]["HC_Count"].ToString();
                hcAmount = lstInvoice.Rows[0]["HC_Amount"].ToString();
                posCount = lstInvoice.Rows[0]["POS_Count"].ToString();
                posAmount = lstInvoice.Rows[0]["POS_Amount"].ToString();
                opCount = lstInvoice.Rows[0]["OP_Count"].ToString();
                opAmount = lstInvoice.Rows[0]["OP_Amount"].ToString();
                creditCount = lstInvoice.Rows[0]["CR_Count"].ToString();
                creditAmount = lstInvoice.Rows[0]["CR_Amount"].ToString();

                lblTotalInvAmt.Text = totalAmount.ToString();
                lblInvHcAmt.Text = hcAmount.ToString();
                lblInvHcCount.Text = hcCount.ToString();
                lblInvPosAmt.Text = posAmount.ToString();
                lblInvPosCount.Text = posCount.ToString();
                lblInvOpAmt.Text = opAmount.ToString();
                lblInvOpCount.Text = opCount.ToString();
                lblInvCreditAmt.Text = creditAmount.ToString();
                lblInvCreditCount.Text = creditCount.ToString();
            }
            else
            {
                lblTotalInvAmt.Text = "0 / 0.00";
                lblInvHcAmt.Text = "0.00";
                lblInvHcCount.Text = "0";
                lblInvPosAmt.Text = "0.00";
                lblInvPosCount.Text = "0";
                lblInvOpAmt.Text = "0.00";
                lblInvOpCount.Text = "0";
                lblInvCreditAmt.Text = "0.00";
                lblInvCreditCount.Text = "0";
            }
        }

        public void TotalInvoices()
        {
            DataTable dtInvoices = LoadData("SelectTotalInvoice");
            int sales, gr, br, foc, invoices;
            sales = Int32.Parse(dtInvoices.Rows[0]["Sales"].ToString());
            gr = Int32.Parse(dtInvoices.Rows[0]["GoodReturn"].ToString());
            br = Int32.Parse(dtInvoices.Rows[0]["BadReturn"].ToString());
            foc = Int32.Parse(dtInvoices.Rows[0]["FreeCost"].ToString());
            invoices = Int32.Parse(dtInvoices.Rows[0]["Invoices"].ToString());
            lblSales.Text = sales.ToString();
            lblGoodReturn.Text = gr.ToString();
            lblBadReturn.Text = br.ToString();
            lblFoc.Text = foc.ToString();
            lblTotalInvoices.Text = invoices.ToString();
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
            DataTable lstGoodLoadOut = LoadData("SelLOGDCount");
            DataTable lstBadLoadOut = LoadData("SelLOBDCount");
            int good, gEnd, gOffLoad, gAdj, bad, bOffLoad, bAdj;
            good = Int32.Parse(lstGoodLoadOut.Rows[0]["LoadOutCount"].ToString());
            if(good == 0)
            {
                pnlGDgreen.Visible = false;
                pnlGDred.Visible = true;
            }
            else
            {
                pnlGDgreen.Visible = true;
                pnlGDred.Visible = false;
            }
            gEnd = Int32.Parse(lstGoodLoadOut.Rows[0]["EndStockCount"].ToString());
            if (gEnd == 0)
            {
                pnlGDEndGreen.Visible = false;
                pnlGDEndRed.Visible = true;
            }
            else
            {
                pnlGDEndGreen.Visible = true;
                pnlGDEndRed.Visible = false;
            }
            gOffLoad = Int32.Parse(lstGoodLoadOut.Rows[0]["OffloadCount"].ToString());
            if (gOffLoad == 0)
            {
                pnlGDOffGreen.Visible = false;
                pnlGDOffRed.Visible = true;
            }
            else
            {
                pnlGDOffGreen.Visible = true;
                pnlGDOffRed.Visible = false;
            }
            gAdj = Int32.Parse(lstGoodLoadOut.Rows[0]["AdjCount"].ToString());
            if (gAdj == 0)
            {
                pnlGDAdjGreen.Visible = false;
                pnlGDAdjRed.Visible = true;
            }
            else
            {
                pnlGDAdjGreen.Visible = true;
                pnlGDAdjRed.Visible = false;
            }
            bad = Int32.Parse(lstBadLoadOut.Rows[0]["LoadOutCount"].ToString());
            if (bad == 0)
            {
                pnlBDgreen.Visible = false;
                pnlBDred.Visible = true;
            }
            else
            {
                pnlBDgreen.Visible = true;
                pnlBDred.Visible = false;
            }
            bOffLoad = Int32.Parse(lstBadLoadOut.Rows[0]["OffloadCount"].ToString());
            if (bOffLoad == 0)
            {
                pnlBDOffGreen.Visible = false;
                pnlBDOffRed.Visible = true;
            }
            else
            {
                pnlBDOffGreen.Visible = true;
                pnlBDOffRed.Visible = false;
            }
            bAdj = Int32.Parse(lstBadLoadOut.Rows[0]["AdjCount"].ToString());
            if (bAdj == 0)
            {
                pnlBDAdjGreen.Visible = false;
                pnlBDAdjRed.Visible = true;
            }
            else
            {
                pnlBDAdjGreen.Visible = true;
                pnlBDAdjRed.Visible = false;
            }
        }

        public void MonthlyTarget()
        {
            DataTable dtMonthlyTarget = new DataTable();
            dtMonthlyTarget = ObjclsFrms.loadList("SelectMonthlyTarget", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
            string XAxis = "";
            string YAxis = "";
            string ZAxis = "";
            for (int i = 0; i < dtMonthlyTarget.Rows.Count; i++)
            {
                if (i < dtMonthlyTarget.Rows.Count - 1)
                {
                    XAxis += dtMonthlyTarget.Rows[i]["rtp_Month"].ToString() + "-";
                    YAxis += dtMonthlyTarget.Rows[i]["TargetAmount"].ToString() + "-";
                    ZAxis += dtMonthlyTarget.Rows[i]["AchievedAmount"].ToString() + "-";
                }
                else if (i == dtMonthlyTarget.Rows.Count - 1)
                {
                    XAxis += dtMonthlyTarget.Rows[i]["rtp_Month"].ToString();
                    YAxis += dtMonthlyTarget.Rows[i]["TargetAmount"].ToString();
                    ZAxis += dtMonthlyTarget.Rows[i]["AchievedAmount"].ToString();
                }
            }
            string MonthlyTargetChart = "ApplyMonthlyTargetChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + ZAxis.ToString() + "');";
            ViewState["Chart"] += MonthlyTargetChart;
        }

        public void DailyTarget()
        {
            DataTable dtDailyTarget = new DataTable();
            dtDailyTarget = ObjclsFrms.loadList("SelectDailyTarget", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
            string XAxis = "";
            string YAxis = "";
            string ZAxis = "";
            for (int i = 0; i < dtDailyTarget.Rows.Count; i++)
            {
                if (i < dtDailyTarget.Rows.Count - 1)
                {
                    XAxis += dtDailyTarget.Rows[i]["rtp_Month"].ToString() + "-";
                    YAxis += dtDailyTarget.Rows[i]["TargetAmount"].ToString() + "-";
                    ZAxis += dtDailyTarget.Rows[i]["AchievedAmount"].ToString() + "-";
                }
                else if (i == dtDailyTarget.Rows.Count - 1)
                {
                    XAxis += dtDailyTarget.Rows[i]["rtp_Month"].ToString();
                    YAxis += dtDailyTarget.Rows[i]["TargetAmount"].ToString();
                    ZAxis += dtDailyTarget.Rows[i]["AchievedAmount"].ToString();
                }
            }
            string DailyTargetChart = "ApplyDailyTargetChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + ZAxis.ToString() + "');";
            ViewState["Chart"] += DailyTargetChart;
        }

        protected void lnkTimeline_Click(object sender, EventArgs e)
        {
            UserDailyID();
            string Id = "232";
            OpenNewBrowserWindow("https://track.dev-ts.online/Home/ViewMap?Id=" + Id + "&&mode=DIGITS-SFA", this);
        }

        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
    }
}