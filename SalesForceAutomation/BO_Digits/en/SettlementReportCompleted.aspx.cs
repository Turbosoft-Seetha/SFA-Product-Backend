using SalesForceAutomation.Admin;
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
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
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
        public string from
        {
            get
            {
                string from;
                from = Request.Params["from"];
                if (from == null)
                {
                    from = "";
                    return from;
                }
                else
                {
                    return from;
                }
                
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                TotalVariance();
                CouponData();
                try
                {
                    if (from.Equals("AP"))
                    {
                        txtHardCash.Enabled = false;
                        txtPos.Enabled = false;
                        txtOnlinePayment.Enabled = false;

                    }
                    else
                    {
                        txtHardCash.Enabled = true;
                        txtPos.Enabled = true;
                        txtOnlinePayment.Enabled = true;
                    }
                }
                catch (Exception ex)
                {

                }
                try
                {
                    if (from.Equals("AP"))
                    {
                        pnlaprv.Visible = true;
                      //  pnlrjct.Visible = true;
                        //RadWizard1.Localization.Finish = null;
                        //RadWizard1.Localization.Previous = "";
                        foreach(Control ctrlmain in RadWizard1.Controls)
                        {
                            if (ctrlmain is RadWizardStep rws && rws.Title == "Payment")
                            {
                                foreach (Control ctrl in rws.Controls)
                                {
                                    if (ctrl is Button btn && btn.Text == RadWizard1.Localization.Finish)
                                    {
                                        btn.Visible = false;
                                    }
                                }
                            }
                        }
                     

                    }
                    else
                    {
                        pnlaprv.Visible = false;
                      //  pnlrjct.Visible = false;
                    }
                }
                catch (Exception ex)
                {

                }
                try
				{
					Session["SRCFdate"] = DateTime.Parse(Session["fDate"].ToString());
					Session["SRCTdate"] = DateTime.Parse(Session["TDate"].ToString());

					Label1.Text = Session["DefaultCurrency"].ToString();
					Label2.Text = Session["DefaultCurrency"].ToString();
					Label3.Text = Session["DefaultCurrency"].ToString();
					Label4.Text = Session["DefaultCurrency"].ToString();
					Label5.Text = Session["DefaultCurrency"].ToString();
					Label6.Text = Session["DefaultCurrency"].ToString();
					Label7.Text = Session["DefaultCurrency"].ToString();
				}
				catch (Exception ex)
				{
					Response.Redirect("~/SignIn.aspx");
				}
				
                RadWizard1.NavigationBarPosition = (RadWizardNavigationBarPosition)Enum.Parse(typeof(RadWizardNavigationBarPosition), "Left");
                RadWizard1.ProgressBarPosition = (RadWizardProgressBarPosition)Enum.Parse(typeof(RadWizardProgressBarPosition), "Left");
                RadWizard1.ActiveStepIndex = 6;
                Route();

                if (ViewState["coupen"].ToString().Equals("Y"))
                {
                    pnlcoupen.Visible = true;
                }
                else
                {
                    pnlcoupen.Visible = false;
                }
                if (ViewState["pettycash"].ToString().Equals("Y"))
                {
                    btnpettycash.Enabled = true;
                }
                else
                {
                    btnpettycash.Enabled = false;
                }

                HeaderData();
                //LoadOutStatus();
                AppComplitionStatus();
                TotalCountAndAmount();
                RoutePettycash();
                rdfromDate.SelectedDate = DateTime.Parse(Session["fDate"].ToString());
                rdendDate.SelectedDate = DateTime.Parse(Session["TDate"].ToString());
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                //Label lblRoute = (Label)rp.FindControl("lblRoute");
                // Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                Label lblProcess = (Label)rp.FindControl("lblProcess");

                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblDuration.Text = lstDatas.Rows[0]["Duration"].ToString();
                //lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
                //lblrotname.Text = lstDatas.Rows[0]["routeName"].ToString();               
                lblProcess.Text = lstDatas.Rows[0]["Process"].ToString();


                if (lblProcess.Text == "Pending")
                {
                    lblProcess.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblProcess.ForeColor = System.Drawing.Color.Green;
                }


            }
        }
        public void Route()
        {
            DataTable dtRoute = ObjclsFrms.loadList("SelectRoute", "sp_Settlement", ResponseID.ToString());
            string route = dtRoute.Rows[0]["rot_Name"].ToString();
            lblRoute.Text = route.ToString();
            lblvarlimit.Text= dtRoute.Rows[0]["rot_SetlmntVarLimit"].ToString();
            string coupen = dtRoute.Rows[0]["rot_EnableCoupon"].ToString();
            string pettycash = dtRoute.Rows[0]["rot_EnablePettyCash"].ToString();
            ViewState["coupen"] = coupen.ToString();
            ViewState["pettycash"] = pettycash.ToString();
        }
        //public void LoadOutStatus()
        //{
        //    DataTable lstVarianceAllowed = ObjclsFrms.loadList("SelectLoadOutStatusToDisplay", "sp_Settlement", ResponseID.ToString());
        //    string Lostatus = lstVarianceAllowed.Rows[0]["udp_LoadOutStatus"].ToString();
        //    lblLoadOutStatus.Text = Lostatus.ToString();
        //}

        protected void RadWizard1_FinishButtonClick(object sender, Telerik.Web.UI.WizardEventArgs e)
        {
            if(from.Equals("AP"))
            {
                Response.Redirect("SettlementApproval.aspx");

            }
            if  (from.Equals(""))
            {
                Response.Redirect("UserDailyProcess.aspx");

            }
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
            lblHardCashVariance.Text = "0.00";
            lblPOS.Text = "";
            lblPOSVariance.Text = "0.00";
            lblOnlinePayment.Text = "";
            lblOnlinePaymentVariance.Text = "0.00";
            lblARCollCheque.Text = "";
            lblAdvCollCheque.Text = "";
            //lblTotalDebitNoteCount.Text = "";
            //lblTotalDebitNoteAmount.Text = "";
            DataTable lstOrderCount = ObjclsFrms.loadList("SelectOrdersCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstCreditCount = ObjclsFrms.loadList("SelectCreditCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstCashCount = ObjclsFrms.loadList("SelectCashCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstARCount = ObjclsFrms.loadList("SelectARCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstAdvanceCount = ObjclsFrms.loadList("SelectAdvanceCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstPaymentCount = ObjclsFrms.loadList("SelTotalCash", "sp_Settlement", ResponseID.ToString());

            DataTable lstCashReceived = new DataTable();
            string stlmntsts = ViewState["SettlementSts"].ToString();
            if (stlmntsts.Equals("Completed"))
            {
                lstCashReceived = ObjclsFrms.loadList("SelectUserSettlementPayModes", "sp_Settlement", ResponseID.ToString());
            }
            else if (stlmntsts.Equals("Approval Pending"))
            {
                lstCashReceived = ObjclsFrms.loadList("SelectSettlementApprovalPayModes", "sp_Settlement", ResponseID.ToString());

            }
            else
            {
                lstCashReceived = ObjclsFrms.loadList("SelectUserSettlementPayModes", "sp_Settlement", ResponseID.ToString());

            }

            DataTable lstChequeAmount = ObjclsFrms.loadList("SelectArAdvCheqAmount", "sp_Settlement", ResponseID.ToString());
            //DataTable lstDebitNote = ObjclsFrms.loadList("SelectSalesManDebitNoteCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstPendingBalance = ObjclsFrms.loadList("SelectDiscrepencyAmount", "sp_Settlement", ResponseID.ToString());

            DataTable pettycash = ObjclsFrms.loadList("Selecttotalpettycash", "sp_Settlement", ResponseID.ToString());


            if (pettycash != null && pettycash.Rows.Count > 0)
            {
                // Assuming the column name is "TotalAmount"
                string totalAmount = pettycash.Rows[0]["TotalAmount"].ToString();

                // lblpettycash.Text = totalAmount;
                lblpettycash1.Text = totalAmount;
                ViewState["totalAmount"] = totalAmount.ToString();
                // Find the control for the Label element
                Label lblPettyCashValue = (Label)FindControl("yourLabelID");

                // Check if the Label control is found
                if (lblPettyCashValue != null)
                {
                    // Assign the total amount value to the Text property of the Label
                    lblPettyCashValue.Text = totalAmount;
                }
                else
                {
                    // Handle the case where the Label control is not found
                    // For example, log an error or display a message
                }
            }
            else
            {
                // Handle the case where no data is retrieved from the database
                // For example, set a default value for the Label or display a message
            }
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
                string pCash, pARColl, pAdv, pCashInv, debitNote;

                pCash = lstPaymentCount.Rows[0]["csTotal"].ToString();
                pARColl = lstPaymentCount.Rows[0]["csAr"].ToString();
                pAdv = lstPaymentCount.Rows[0]["csAdp"].ToString();
                pCashInv = lstPaymentCount.Rows[0]["csInv"].ToString();
                debitNote = lstPaymentCount.Rows[0]["debitNote"].ToString();
                //Int32.Parse



                lblPCash.Text = pCash;
                lblPArCollectionCash.Text = pARColl;
                lblPAdvanceCash.Text = pAdv;
                lblPCashInvoices.Text = pCashInv;
                lblDebitNote.Text = debitNote;
            }
            if (lstPendingBalance.Rows.Count > 0)
            {
                string pendingBal;
                pendingBal = lstPendingBalance.Rows[0]["PendingBalance"].ToString();
                lblPendingBalance.Text = pendingBal;
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

                        ViewState["HardCash"] = hcExpected.ToString();
                        decimal hardCashDecimal;
                        if (!decimal.TryParse(hcExpected, out hardCashDecimal))
                        {
                            // Handle conversion failure, maybe log an error or throw an exception
                        }

                        ViewState["HardCash"] = hardCashDecimal.ToString();

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
            //if (lstDebitNote.Rows.Count > 0)
            //{
            //    string debitNoteCount, debitNoteAmount;
            //    debitNoteCount = lstDebitNote.Rows[0]["totalCount"].ToString();
            //    debitNoteAmount = lstDebitNote.Rows[0]["totalAmount"].ToString();
            //    lblTotalDebitNoteCount.Text = debitNoteCount;
            //    lblTotalDebitNoteAmount.Text = debitNoteAmount;
            //}
            TotalVariance();
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

        //protected void grvDebitNote_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        //{
        //    LoadDebitNote();
        //}

        //public void LoadDebitNote()
        //{
        //    //string[] arr = { ddlRoute.SelectedValue.ToString() };
        //    DataTable lstDebitNote = ObjclsFrms.loadList("SelectSalesManDebitNote", "sp_Settlement", ResponseID.ToString());
        //    grvDebitNote.DataSource = lstDebitNote;
        //}

        public void AppComplitionStatus()
        {
            DataTable lstCompletionStatus = ObjclsFrms.loadList("SelectAppCompleteionStatus", "sp_Settlement", ResponseID.ToString());
            string AppStatus = lstCompletionStatus.Rows[0]["udp_IsAppProcessComplete"].ToString();
            string processID = lstCompletionStatus.Rows[0]["ProcessID"].ToString();
            string date = lstCompletionStatus.Rows[0]["Dat"].ToString();
            string Status = lstCompletionStatus.Rows[0]["udp_SettlementStatus"].ToString();
            ViewState["AppStatus"] = AppStatus.ToString();
            //lblLoadOutStatus.Text = AppStatus.ToString();
            lblProcessID.Text = processID.ToString();
            lblDate.Text = date.ToString();
            lblSettlemetStatus.Text = Status.ToString();
            ViewState["SettlementSts"]= Status.ToString();
            try
            {
                 if (Status.Equals("Completed"))
                {
                    lblSettlemetStatus.ForeColor = System.Drawing.Color.Green;
                    pnlaprv.Visible = false;
                    txtHardCash.Enabled = false;
                    txtPos.Enabled = false;
                    txtOnlinePayment.Enabled = false;
                }
                else if (Status.Equals("Approval Pending") && from.Equals(""))
                {
                    lblSettlemetStatus.ForeColor = System.Drawing.Color.Red;
                    pnlaprv.Visible = false;
                    txtHardCash.Enabled = false;
                    txtPos.Enabled = false;
                    txtOnlinePayment.Enabled = false;
                }
                else if (Status.Equals("Approval Pending") && from.Equals("AP"))
                {
                    lblSettlemetStatus.ForeColor = System.Drawing.Color.Red;
                    pnlaprv.Visible = true;
                    txtHardCash.Enabled = false;
                    txtPos.Enabled = false;
                    txtOnlinePayment.Enabled = false;
                }
              
                else
                {
                    pnlaprv.Visible = false;
                }
            }
            catch (Exception ex) { }
            
        }
        protected void TotalVariance()
        {
            double hardVariance = 0, posVariance = 0, onlineVariance = 0;

            string hardCashText = lblHardCashVariance.Text.Trim();
            string posText = lblPOSVariance.Text.Trim();
            string onlineText = lblOnlinePaymentVariance.Text.Trim();

            if (!double.TryParse(hardCashText, out hardVariance))
            {
                hardVariance = 0;
            }

            if (!double.TryParse(posText, out posVariance))
            {
                posVariance = 0;
            }

            if (!double.TryParse(onlineText, out onlineVariance))
            {
                onlineVariance = 0;
            }

            double totalVariance = hardVariance + posVariance + onlineVariance;
            string sum = totalVariance.ToString("F2"); // Ensures two decimal places
            lblTotalVariance.Text = sum;
        }




        protected void Button1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showPreviousVariances();</script>", false);

            PopulateTable();
        }
        public void PopulateTable()
        {

            string FDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string TDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { FDate, TDate };
            DataTable lstVariance = ObjclsFrms.loadList("SelectVariances", "sp_Settlement", ResponseID.ToString(), arr);

            // Clear existing rows from the table
            //tbodyPreviousVariances.Rows.Clear();

            if (lstVariance.Rows.Count > 0)
            {
                RadGridSuccess.DataSource = lstVariance;

            }
        }

        protected void RadGridSuccess_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            PopulateTable();
        }

        protected void Filtr_Click(object sender, EventArgs e)
        {
            PopulateTable();
            RadGridSuccess.Rebind();
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Initiation();
        }
        public void Initiation()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstAdvance = ObjclsFrms.loadList("SelectIniation", "sp_Settlement", ResponseID.ToString());
            RadGrid1.DataSource = lstAdvance;
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                string imah = dataItem["Image"].Text.Replace(" ", "");
                string[] values = imah.Split(',');
                imah = imah.Replace("&nbsp;", null);
                for (int i = 0; i < values.Length; i++)
                {
                    if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                    {

                        Image img = new Image();
                        img.ID = "Image1" + i.ToString();
                        img.ImageUrl = "../" + values[i].ToString();
                        img.Height = 20;
                        img.Width = 20;
                        img.BorderStyle = System.Web.UI.WebControls.BorderStyle.Groove;
                        img.BorderWidth = 2;
                        img.BorderColor = System.Drawing.Color.Black;
                        HyperLink hl = new HyperLink();
                        if (img.ImageUrl == "../../UploadFiles/NoImage/imagenotavailable.png")
                        {
                            hl.NavigateUrl = "";
                        }
                        else
                        {
                            hl.NavigateUrl = "../" + values[i].ToString();
                        }

                        hl.ID = "hl" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img);

                        dataItem["Images"].Controls.Add(hl);
                    }
                }




            }
        }
        public void RoutePettycash()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectRoutePettycash", "sp_Settlement", ResponseID.ToString());
            if (lstDatas != null && lstDatas.Rows.Count > 0)
            {
                // Find the control for the <tr> element
                foreach (DataRow row in lstDatas.Rows)
                {
                    // Assuming the column name is "rot_EnablePettyCash", change it if it's different
                    string value = row["rot_EnablePettyCash"].ToString();

                    // Check if the value is equal to "Y"
                    if (value == "Y")
                    {
                        // Set the Label's visibility to true
                        ddlPettycash.Visible = true;
                    }
                    else
                    {
                        // Set the Label's visibility to false
                        ddlPettycash.Visible = false;
                    }
                }
            }
        }

        public void Populatepettycash()
        {


            DataTable cash = ObjclsFrms.loadList("SelectPettycash", "sp_Settlement", ResponseID.ToString());

            // Clear existing rows from the table
            //tbodyPreviousVariances.Rows.Clear();


            RadGrid2.DataSource = cash;


        }

        protected void btnpettycash_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showpettycash();</script>", false);

            Populatepettycash();
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

            Populatepettycash();
        }

        protected void grvPayment_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;

                string imagC = dataItem["image"].Text.Replace(" ", "");
                string[] valuesC = imagC.Split(',');
                imagC = imagC.Replace("&nbsp;", null);
                for (int i = 0; i < valuesC.Length; i++)
                {
                    if (!valuesC[i].Equals("&nbsp;") && !valuesC[i].Equals(""))
                    {

                        Image img = new Image();
                        img.ID = "Image2" + i.ToString();
                        img.ImageUrl = "../" + valuesC[i].ToString();
                        img.Height = 20;
                        img.Width = 20;
                        img.BorderStyle = System.Web.UI.WebControls.BorderStyle.Groove;
                        img.BorderWidth = 2;
                        img.BorderColor = System.Drawing.Color.Black;
                        HyperLink hl = new HyperLink();
                        if (img.ImageUrl == "../../UploadFiles/NoImage/imagenotavailable.png")
                        {
                            hl.NavigateUrl = "";
                        }
                        else
                        {
                            hl.NavigateUrl = "../" + valuesC[i].ToString();
                        }

                        hl.ID = "hll" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img);

                        dataItem["ImagesCheque"].Controls.Add(hl);
                    }
                }
            }
        }
        protected void btnapprv_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>AprvConfirm();</script>", false);


        }

        protected void lnkreject_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RejectConfim();</script>", false);


        }

        protected void lnkAprvConfirm_Click(object sender, EventArgs e)
        {
            Save();
            string Id = ResponseID.ToString();
            string[] arr = { };
            string Value = ObjclsFrms.SaveData("sp_Settlement", "InsSettlementApproval", Id, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>AprvConfirmclose();</script>", false);

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Approval completed successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong.. Approval not completed');</script>", false);
            }
        }

        protected void lnkrjectaprv_Click(object sender, EventArgs e)
        {
            Save();
            string Id = ResponseID.ToString();
            string[] arr = { };
            string Value = ObjclsFrms.SaveData("sp_Settlement", "RejectSettlementApproval", Id, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>AprvConfirmclose();</script>", false);

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Settlement Approval Rejected..!');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/SettlementApproval.aspx");

        }
        public void Save()
        {
            string invCash, arCash, advCash, udpID, rotID, usrID;
            invCash = lblPCashInvoices.Text.ToString();
            arCash = lblPArCollectionCash.Text.ToString();
            advCash = lblPAdvanceCash.Text.ToString();

            if (invCash == "")
            {
                invCash = "0";
            }
            if (arCash == "")
            {
                arCash = "0";
            }
            if (advCash == "")
            {
                advCash = "0";
            }



            udpID = ResponseID.ToString();
            rotID = "";
            usrID = "";
            string cheque = GetDetailFromGrid();
            string cash = GetDetailFromLabel();
            string status = "SC";
           
            string hardcash, pos, onlinepayment;
            hardcash = txtHardCash.Text.ToString();
            pos = txtPos.Text.ToString();
            onlinepayment = txtOnlinePayment.Text.ToString();
            string[] arr = { arCash, advCash, udpID, rotID, usrID, cash, cheque, status };
            DataTable lstSave = ObjclsFrms.loadList("UpdSettlement", "sp_Settlement", invCash, arr);
            //UpdateVarianceSum();
            int res = Int32.Parse(lstSave.Rows[0]["Res"].ToString());
            if (res > 0)
            {
                
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Settlement completed successfully');</script>", false);

                


            }
            else
            {
                string descr = lstSave.Rows[0]["Descr"].ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('" + descr + "');</script>", false);
            }
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
                            if (amount == "")
                            {
                                amount = "0";
                            }

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
                                type = "HC";
                                expected = "0.00";
                                received = "0.00";
                                variance = "0.00";

                                dbCash.Rows.Add(type, expected, received, variance);
                            }
                            else
                            {
                                double hardCash = double.Parse(ViewState["HardCash"].ToString());
                                double hardReceived = double.Parse(txtHardCash.Text.ToString());
                                double hardVariance = hardCash - hardReceived;
                                type = "HC";
                                expected = ViewState["HardCash"].ToString();
                                received = txtHardCash.Text.ToString();
                                variance = hardVariance.ToString();
                                if (expected == "")
                                {
                                    expected = "0";
                                }
                                if (received == "")
                                {
                                    received = "0";
                                }
                                if (variance == "")
                                {
                                    variance = "0";
                                }

                                dbCash.Rows.Add(type, expected, received, variance);
                            }
                        }
                        else if (mode.Equals("POS"))
                        {
                            if (ViewState["POS"] == null)
                            {
                                type = "POS";
                                expected = "0.00";
                                received = "0.00";
                                variance = "0.00";

                                dbCash.Rows.Add(type, expected, received, variance);
                            }
                            else
                            {
                                double posCash = double.Parse(ViewState["POS"].ToString());
                                double posReceived = double.Parse(txtPos.Text.ToString());
                                double posVariance = posCash - posReceived;
                                type = "POS";
                                expected = ViewState["POS"].ToString();
                                received = txtPos.Text.ToString();
                                variance = posVariance.ToString();
                                if (expected == "")
                                {
                                    expected = "0";
                                }
                                if (received == "")
                                {
                                    received = "0";
                                }
                                if (variance == "")
                                {
                                    variance = "0";
                                }

                                dbCash.Rows.Add(type, expected, received, variance);
                            }
                        }
                        else if (mode.Equals("Online"))
                        {
                            if (ViewState["Online"] == null)
                            {
                                type = "OP";
                                expected = "0.00";
                                received = "0.00";
                                variance = "0.00";

                                dbCash.Rows.Add(type, expected, received, variance);
                            }
                            else
                            {
                                double onlineCash = double.Parse(ViewState["Online"].ToString());
                                double onlineReceived = double.Parse(txtOnlinePayment.Text.ToString());
                                double onlineVariance = onlineCash - onlineReceived;
                                type = "OP";
                                expected = ViewState["Online"].ToString();
                                received = txtOnlinePayment.Text.ToString();
                                variance = onlineVariance.ToString();
                                if (expected == "")
                                {
                                    expected = "0";
                                }
                                if (received == "")
                                {
                                    received = "0";
                                }
                                if (variance == "")
                                {
                                    variance = "0";
                                }

                                dbCash.Rows.Add(type, expected, received, variance);
                            }
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
                            if (expecteds == "")
                            {
                                expecteds = "0";
                            }
                            if (receiveds == "")
                            {
                                receiveds = "0";
                            }
                            if (variances == "")
                            {
                                variances = "0";
                            }

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
        protected void UpdateVarianceSum()
        {
            double pendingBalance = double.Parse(lblPendingBalance.Text);
            double totalVariance = double.Parse(lblTotalVariance.Text);
            double pendingBal = pendingBalance + totalVariance;


            string[] arr = { pendingBal.ToString(), totalVariance.ToString() };
            DataTable lstVariance = ObjclsFrms.loadList("InsertSettlementDiscrepancyAmount", "sp_Settlement", ResponseID.ToString(), arr);
            string res = lstVariance.Rows[0]["Res"].ToString();
            //int resValue = Int32.Parse(res);

        }

        protected void lnkCoupon_Click(object sender, EventArgs e)
        {
            CouponGridData();
        }

        public void CouponGridData()
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showCoupon();</script>", false);
            string ID = ResponseID.ToString();
            DataTable dt = ObjclsFrms.loadList("SelCouponforSettlementComplete", "sp_Settlement", ID.ToString());
            couponCollected.DataSource = dt;           
        }
        public void CouponData()
        {

            string ID = ResponseID.ToString();
            DataTable dt = ObjclsFrms.loadList("SelCouponCollectedCount", "sp_Settlement", ID.ToString());
            lblCollectedCoupon.Text = dt.Rows[0]["TotalCollected"].ToString();
            lblRedeemedCoupon.Text = dt.Rows[0]["TotalRedeem"].ToString();
        }

        protected void couponCollected_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            CouponGridData();
        }

        protected void CouponOK_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>hideCoupon();</script>", false);

        }
    }
}