using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class SettlementReportCompleted : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RadWizard1.NavigationBarPosition = (RadWizardNavigationBarPosition)Enum.Parse(typeof(RadWizardNavigationBarPosition), "Left");
                RadWizard1.ProgressBarPosition = (RadWizardProgressBarPosition)Enum.Parse(typeof(RadWizardProgressBarPosition), "Left");
                Route();
                LoadOutStatus();
                TotalCountAndAmount();
            }
        }

        public void Route()
        {
            DataTable dtRoute = ObjclsFrms.loadList("SelectRoute", "sp_Settlement", ResponseID.ToString());
            string route = dtRoute.Rows[0]["rot_Name"].ToString();
            lblRoute.Text = route.ToString();
        }

        protected void RadWizard1_FinishButtonClick(object sender, Telerik.Web.UI.WizardEventArgs e)
        {
            Response.Redirect("UserDailyProcess.aspx");
        }

        protected void grvOrders_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadOrdersReport();
        }

        protected void grvCredit_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadCreditInvoice();
        }

        protected void grvCash_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadCashInvoice();
        }

        protected void grvAR_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadARCollection();
        }

        protected void grvAdvance_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadAdvanceCollection();
        }

        protected void grvPayment_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadPayment();
        }

        public void TotalCountAndAmount()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            lblOrderCount.Text = "";
            lblOrderAmount.Text = "";
            lblCreditCount.Text = "";
            lblCreditAmount.Text = "";
            lblCashCount.Text = "";
            lblCashAmount.Text = "";
            lblARCount.Text = "";
            lblARAmount.Text = "";
            lblAdvanceCount.Text = "";
            lblAdvanceAmount.Text = "";
            lblPCash.Text = "";
            lblPArCollectionCash.Text = "";
            lblPAdvanceCash.Text = "";
            lblPCashInvoices.Text = "";
            lblHardCash.Text = "";
            lblHardCashVariance.Text = "";
            lblPOS.Text = "";
            lblPOSVariance.Text = "";
            lblOnlinePayment.Text = "";
            lblOnlinePaymentVariance.Text = "";
            lblARCollCheque.Text = "";
            lblAdvCollCheque.Text = "";
            DataTable lstOrderCount = ObjclsFrms.loadList("SelectOrdersCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstCreditCount = ObjclsFrms.loadList("SelectCreditCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstCashCount = ObjclsFrms.loadList("SelectCashCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstARCount = ObjclsFrms.loadList("SelectARCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstAdvanceCount = ObjclsFrms.loadList("SelectAdvanceCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstPaymentCount = ObjclsFrms.loadList("SelTotalCash", "sp_Settlement", ResponseID.ToString());
            DataTable lstCashReceived = ObjclsFrms.loadList("SelectUserSettlementPayModes", "sp_Settlement", ResponseID.ToString());
            DataTable lstChequeAmount = ObjclsFrms.loadList("SelectArAdvCheqAmount", "sp_Settlement", ResponseID.ToString());
            if (lstOrderCount.Rows.Count > 0)
            {
                string orderCount, orderAmount;
                orderCount = lstOrderCount.Rows[0]["totalCount"].ToString();
                orderAmount = lstOrderCount.Rows[0]["totalAmount"].ToString();
                lblOrderCount.Text = orderCount;
                lblOrderAmount.Text = orderAmount;
            }
            if (lstCreditCount.Rows.Count > 0)
            {
                string creditCount, creditAmount;
                creditCount = lstCreditCount.Rows[0]["totalCount"].ToString();
                creditAmount = lstCreditCount.Rows[0]["totalAmount"].ToString();
                lblCreditCount.Text = creditCount;
                lblCreditAmount.Text = creditAmount;
            }
            if (lstCashCount.Rows.Count > 0)
            {
                string cashCount, cashAmount;
                cashCount = lstCashCount.Rows[0]["totalCount"].ToString();
                cashAmount = lstCashCount.Rows[0]["totalAmount"].ToString();
                lblCashCount.Text = cashCount;
                lblCashAmount.Text = cashAmount;
            }
            if (lstARCount.Rows.Count > 0)
            {
                string arCount, arAmount;
                arCount = lstARCount.Rows[0]["totalCount"].ToString();
                arAmount = lstARCount.Rows[0]["totalAmount"].ToString();
                lblARCount.Text = arCount;
                lblARAmount.Text = arAmount;
            }
            if (lstAdvanceCount.Rows.Count > 0)
            {
                string advanceCount, advanceAmount;
                advanceCount = lstAdvanceCount.Rows[0]["totalCount"].ToString();
                advanceAmount = lstAdvanceCount.Rows[0]["totalAmount"].ToString();
                lblAdvanceCount.Text = advanceCount;
                lblAdvanceAmount.Text = advanceAmount;
            }
            if (lstPaymentCount.Rows.Count > 0)
            {
                string pCash, pARColl, pAdv, pCashInv;
                pCash = lstPaymentCount.Rows[0]["csTotal"].ToString();
                pARColl = lstPaymentCount.Rows[0]["csAr"].ToString();
                pAdv = lstPaymentCount.Rows[0]["csAdp"].ToString();
                pCashInv = lstPaymentCount.Rows[0]["csInv"].ToString();
                lblPCash.Text = pCash;
                lblPArCollectionCash.Text = pARColl;
                lblPAdvanceCash.Text = pAdv;
                lblPCashInvoices.Text = pCashInv;

            }
            if (lstCashReceived.Rows.Count > 0)
            {
                string mode, hcExpected, hcCollected, hcVariance, posExpected, posCollected, posVariance, opExpected, opVariance, opCollected;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    if (mode.Equals("HC"))
                    {
                        hcExpected = lstCashReceived.Rows[i]["usp_ExpectedAmount"].ToString();
                        hcCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        hcVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblHardCash.Text = hcExpected.ToString();
                        lblHardCashVariance.Text = hcVariance.ToString();
                        txtHardCash.Text = hcCollected.ToString();
                    }
                    else if (mode.Equals("POS"))
                    {
                        posExpected = lstCashReceived.Rows[i]["usp_ExpectedAmount"].ToString();
                        posCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        posVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblPOS.Text = posExpected.ToString();
                        lblPOSVariance.Text = posVariance.ToString();
                        txtPos.Text = posCollected.ToString();
                    }
                    else if (mode.Equals("OP"))
                    {
                        opExpected = lstCashReceived.Rows[i]["usp_ExpectedAmount"].ToString();
                        opCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        opVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblOnlinePayment.Text = opExpected.ToString();
                        lblOnlinePaymentVariance.Text = opVariance.ToString();
                        txtOnlinePayment.Text = opCollected.ToString();
                    }
                }
            }
            if (lstChequeAmount.Rows.Count > 0)
            {
                string mode, amount;
                for (int i = 0; i < lstChequeAmount.Rows.Count; i++)
                {
                    mode = lstChequeAmount.Rows[i]["mode"].ToString();
                    amount = lstChequeAmount.Rows[i]["amount"].ToString();
                    if (mode.Equals("AR"))
                    {
                        lblARCollCheque.Text = amount.ToString(); ;
                    }
                    else if (mode.Equals("Adv"))
                    {
                        lblAdvCollCheque.Text = amount.ToString();
                    }
                }
            }
        }

        public void LoadOrdersReport()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstOrder = ObjclsFrms.loadList("SelectOrdersReport", "sp_Settlement", ResponseID.ToString());
            grvOrders.DataSource = lstOrder;
        }

        public void LoadCreditInvoice()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstCredit = ObjclsFrms.loadList("SelectCreditInvoice", "sp_Settlement", ResponseID.ToString());
            grvCredit.DataSource = lstCredit;
        }

        public void LoadCashInvoice()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstCash = ObjclsFrms.loadList("SelectCashInvoice", "sp_Settlement", ResponseID.ToString());
            grvCash.DataSource = lstCash;
        }

        public void LoadARCollection()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstARCol = ObjclsFrms.loadList("SelectARCollection", "sp_Settlement", ResponseID.ToString());
            grvAR.DataSource = lstARCol;
        }

        public void LoadAdvanceCollection()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstAdvance = ObjclsFrms.loadList("SelectAdvanceCollection", "sp_Settlement", ResponseID.ToString());
            grvAdvance.DataSource = lstAdvance;
        }

        public void LoadPayment()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstPayment = ObjclsFrms.loadList("SelectPayment", "sp_Settlement", ResponseID.ToString());
            grvPayment.DataSource = lstPayment;
        }

        public void LoadOutStatus()
        {
            DataTable lstVarianceAllowed = ObjclsFrms.loadList("SelectLoadOutStatusToDisplay", "sp_Settlement", ResponseID.ToString());
            lblLoadOutStatus.Text = lstVarianceAllowed.Rows[0]["udp_LoadOutStatus"].ToString();
        }
    }
}