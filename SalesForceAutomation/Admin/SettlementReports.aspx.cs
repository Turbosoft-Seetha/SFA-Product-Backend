using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class SettlementReports : System.Web.UI.Page
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
                ViewState["HardCash"] = null;
                ViewState["POS"] = null;
                ViewState["Online"] = null;
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

        protected void ddlRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadOrdersReport();
            LoadCreditInvoice();
            LoadCashInvoice();
            LoadARCollection();
            LoadAdvanceCollection();
            LoadPayment();
            TotalCountAndAmount();
        }

        protected void grvOrders_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadOrdersReport();
        }

        protected void grvCredit_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadCreditInvoice();
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

        protected void grvCash_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadCashInvoice();
        }

        protected void grvAR_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadARCollection();
        }

        protected void grvAdvance_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadAdvanceCollection();
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
            DataTable lstCashReceived = ObjclsFrms.loadList("SelTotalWithMode", "sp_Settlement", ResponseID.ToString());
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
                string mode, amount;
                string hardCash, pos, onlinePay;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    DataTable lstVariance = ObjclsFrms.loadList("SelectAllowSettlementDiscrepancy", "sp_Settlement", ResponseID.ToString());
                    string variance = lstVariance.Rows[0]["rot_AllowSetlmntDiscrepancy"].ToString();
                    if (variance.Equals("Y"))
                    {
                        mode = lstCashReceived.Rows[i]["Mode"].ToString();
                        amount = lstCashReceived.Rows[i]["Amount"].ToString();
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
                    else
                    {
                        mode = lstCashReceived.Rows[i]["Mode"].ToString();
                        amount = lstCashReceived.Rows[i]["Amount"].ToString();
                        txtHardCash.Enabled = false;
                        txtPos.Enabled = false;
                        txtOnlinePayment.Enabled = false;
                        if (mode.Equals("HC"))
                        {
                            hardCash = amount.ToString();
                            ViewState["HardCash"] = hardCash.ToString();
                            lblHardCash.Text = hardCash;
                            txtHardCash.Text = hardCash;
                            lblHardCashVariance.Text = "0.00";
                        }
                        else if (mode.Equals("POS"))
                        {
                            pos = amount.ToString();
                            ViewState["POS"] = pos.ToString();
                            lblPOS.Text = pos;
                            txtPos.Text = pos;
                            lblPOSVariance.Text = "0.00";
                        }
                        else if (mode.Equals("OP"))
                        {
                            onlinePay = amount.ToString();
                            ViewState["Online"] = onlinePay.ToString();
                            lblOnlinePayment.Text = onlinePay;
                            txtOnlinePayment.Text = onlinePay;
                            lblOnlinePaymentVariance.Text = "0.00";
                        }
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

        protected void grvPayment_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadPayment();
        }

        public void LoadPayment()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstPayment = ObjclsFrms.loadList("SelectPayment", "sp_Settlement", ResponseID.ToString());
            grvPayment.DataSource = lstPayment;
        }

        protected void RadWizard1_FinishButtonClick(object sender, WizardEventArgs e)
        {
            if(txtHardCash.Text.ToString() == "")
            {
                txtHardCash.Text = "0.00";
            }
            if (txtPos.Text.ToString() == "")
            {
                txtPos.Text = "0.00";
            }
            if (txtOnlinePayment.Text.ToString() == "")
            {
                txtOnlinePayment.Text = "0.00";
            }

            DataTable lstVarianceAllowed = ObjclsFrms.loadList("SelectLoadOutStatus", "sp_Settlement", ResponseID.ToString());
            if(lstVarianceAllowed.Rows.Count > 0)
            {
                string allowed = lstVarianceAllowed.Rows[0]["udp_LoadOutStatus"].ToString();
                if (allowed.Equals("Y"))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>loadOutModal();</script>", false);
                }
            }
        }

        public void Save()
        {
            string invCash, arCash, advCash, udpID, rotID, usrID;
            invCash = lblPCashInvoices.Text.ToString();
            arCash = lblPArCollectionCash.Text.ToString();
            advCash = lblPAdvanceCash.Text.ToString();
            udpID = ResponseID.ToString();
            rotID = "";
            usrID = "";
            string cheque = GetDetailFromGrid();
            string cash = GetDetailFromLabel();
            string[] arr = { arCash, advCash, udpID, rotID, usrID, cash, cheque };
            DataTable lstSave = ObjclsFrms.loadList("UpdSettlement", "sp_Settlement", invCash, arr);
            int res = Int32.Parse(lstSave.Rows[0]["Res"].ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Settlement completed successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
        }

        protected void txtHardCash_TextChanged(object sender, EventArgs e)
        {
            double hardCash = double.Parse(ViewState["HardCash"].ToString());
            double hardReceived = double.Parse(txtHardCash.Text.ToString());
            double hardVariance = hardCash - hardReceived;
            lblHardCashVariance.Text = hardVariance.ToString();
        }

        protected void txtPos_TextChanged(object sender, EventArgs e)
        {
            double posCash = double.Parse(ViewState["POS"].ToString());
            double posReceived = double.Parse(txtPos.Text.ToString());
            double posVariance = posCash - posReceived;
            lblPOSVariance.Text = posVariance.ToString();
        }

        protected void txtOnlinePayment_TextChanged(object sender, EventArgs e)
        {
            double onlineCash = double.Parse(ViewState["Online"].ToString());
            double onlineReceived = double.Parse(txtOnlinePayment.Text.ToString());
            double onlineVariance = onlineCash - onlineReceived;
            lblOnlinePaymentVariance.Text = onlineVariance.ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserDailyProcess.aspx");
        }

        public string GetDetailFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = grvPayment.SelectedItems;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string mode = dr["type"].Text.ToString();
                            string id = dr["colID"].Text.ToString();
                            string cheqNo = dr["chequeNo"].Text.ToString();
                            string amount = dr["amount"].Text.ToString();
                            createNode(mode, id, cheqNo, amount, writer);
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

        private void createNode(string mode, string id, string cheqNo, string amount, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("CollectionType");
            writer.WriteString(mode);
            writer.WriteEndElement();

            writer.WriteStartElement("CollectionId");
            writer.WriteString(id);
            writer.WriteEndElement();

            writer.WriteStartElement("ChequeNumber");
            writer.WriteString(cheqNo);
            writer.WriteEndElement();

            writer.WriteStartElement("ChequeAmount");
            writer.WriteString(amount);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public string GetDetailFromLabel()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    DataTable dbCash = new DataTable();
                    dbCash.Columns.Add("Mode");
                    dbCash.Columns.Add("Expected");
                    dbCash.Columns.Add("Received");
                    dbCash.Columns.Add("Variance");

                    string[] modes = { "HC", "POS", "Online" };

                    for (int i = 0; i < modes.Length; i++)
                    {
                        string mode, expected, received, variance, type;
                        mode = modes[i].ToString();
                        if (mode.Equals("HC"))
                        {
                            if (ViewState["HardCash"] == null)
                            {
                                ViewState["HardCash"] = "0.00";
                            }
                            double hardCash = double.Parse(ViewState["HardCash"].ToString());
                            double hardReceived = double.Parse(txtHardCash.Text.ToString());
                            double hardVariance = hardCash - hardReceived;
                            type = "HC";
                            expected = ViewState["HardCash"].ToString();
                            received = txtHardCash.Text.ToString();
                            variance = hardVariance.ToString();
                            dbCash.Rows.Add(type, expected, received, variance);
                        }
                        else if (mode.Equals("POS"))
                        {
                            if (ViewState["POS"] == null)
                            {
                                ViewState["POS"] = "0.00";
                            }
                            double posCash = double.Parse(ViewState["POS"].ToString());
                            double posReceived = double.Parse(txtPos.Text.ToString());
                            double posVariance = posCash - posReceived;
                            type = "POS";
                            expected = ViewState["POS"].ToString();
                            received = txtPos.Text.ToString();
                            variance = posVariance.ToString();
                            dbCash.Rows.Add(type, expected, received, variance);
                        }
                        else if (mode.Equals("Online"))
                        {
                            if (ViewState["Online"] == null)
                            {
                                ViewState["Online"] = "0.00";
                            }
                            double onlineCash = double.Parse(ViewState["Online"].ToString());
                            double onlineReceived = double.Parse(txtOnlinePayment.Text.ToString());
                            double onlineVariance = onlineCash - onlineReceived;
                            type = "OP";
                            expected = ViewState["Online"].ToString();
                            received = txtOnlinePayment.Text.ToString();
                            variance = onlineVariance.ToString();
                            dbCash.Rows.Add(type, expected, received, variance);
                        }
                    }


                    if (dbCash.Rows.Count > 0)
                    {
                        for (int j = 0; j < dbCash.Rows.Count; j++)
                        {
                            string types = dbCash.Rows[j]["Mode"].ToString();
                            string expecteds = dbCash.Rows[j]["Expected"].ToString();
                            string receiveds = dbCash.Rows[j]["Received"].ToString();
                            string variances = dbCash.Rows[j]["Variance"].ToString();
                            createNodes(types, expecteds, receiveds, variances, writer);
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

        private void createNodes(string type, string expected, string received, string variance, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("Mode");
            writer.WriteString(type);
            writer.WriteEndElement();

            writer.WriteStartElement("ExpectedAmount");
            writer.WriteString(expected);
            writer.WriteEndElement();

            writer.WriteStartElement("CollectedAmount");
            writer.WriteString(received);
            writer.WriteEndElement();

            writer.WriteStartElement("Variance");
            writer.WriteString(variance);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void LoadOutStatus()
        {
            DataTable lstVarianceAllowed = ObjclsFrms.loadList("SelectLoadOutStatusToDisplay", "sp_Settlement", ResponseID.ToString());
            lblLoadOutStatus.Text = lstVarianceAllowed.Rows[0]["udp_LoadOutStatus"].ToString();
        }
    }
}