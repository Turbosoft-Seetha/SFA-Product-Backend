using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.VariantTypes;
using DocumentFormat.OpenXml.Wordprocessing;
using ExcelLibrary.BinaryFileFormat;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;
using Telerik.Web.UI.Skins;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using static ClosedXML.Excel.XLPredefinedFormat;
using static Stimulsoft.Report.Func;
using static System.Runtime.CompilerServices.RuntimeHelpers;
using Color = System.Drawing.Color;
using Convert = System.Convert;
using DateTime = System.DateTime;
using Image = System.Web.UI.WebControls.Image;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class SettlementReports : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        DocumentFormat.OpenXml.InkML.Table tbodyPreviousVariances = new DocumentFormat.OpenXml.InkML.Table();
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
            try
            {
                if (!Page.IsPostBack)
                {
                    Route();
                    TotalVariance();
                    try
                    {
                        if (from.Equals("AP"))
                        {
                            pnlaprv.Visible = true;
                            pnlrjct.Visible = true;
                            RadWizard1.Localization.Finish = "";
                            RadWizard1.Localization.Previous = "";

                        }
                        else
                        {
                            pnlaprv.Visible = false;
                            pnlrjct.Visible = false;
                        }
                    }
                    catch(Exception ex)
                    {

                    }
                    
                    try
                    {
                        if (Session["fDate"] != null)
                        {
                            Session["SRFdate"] = DateTime.Parse(Session["fDate"].ToString());
                        }
                        if (Session["TDate"] != null)
                        {
                            Session["SRTdate"] = DateTime.Parse(Session["TDate"].ToString());
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }

                    ViewState["HardCash"] = null;
                    ViewState["POS"] = null;
                    ViewState["Online"] = null;


                    try
                    {
                        Label1.Text = Session["DefaultCurrency"].ToString();
                        Label2.Text = Session["DefaultCurrency"].ToString();
                        Label3.Text = Session["DefaultCurrency"].ToString();
                        Label4.Text = Session["DefaultCurrency"].ToString();
                        Label5.Text = Session["DefaultCurrency"].ToString();
                        Label6.Text = Session["DefaultCurrency"].ToString();
                        Label7.Text = Session["DefaultCurrency"].ToString();
                        Label8.Text = Session["DefaultCurrency"].ToString();

                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }


                    RadWizard1.NavigationBarPosition = (RadWizardNavigationBarPosition)Enum.Parse(typeof(RadWizardNavigationBarPosition), "Left");
                    RadWizard1.ProgressBarPosition = (RadWizardProgressBarPosition)Enum.Parse(typeof(RadWizardProgressBarPosition), "Left");
                    RadWizard1.ActiveStepIndex = 6;
                   
                    if (ViewState["settlmntFrom"].ToString() == "A")
                    {
                        RadWizard1.Localization.Finish = "Override Settlement from App";
                       
                    }

                    ViewState["CouponCollectedCount"] = null;
                    CouponData();
                    
                    TotalVariance();
                    if(ViewState["Approve"].ToString()=="Y")
                    {
                        RadWizard1.Localization.Finish = "Sent for Approval";
                    }

                        //RadWizard1.Localization.Finish = "";
                        //RadWizard1.Localization.Previous = "";
                        HeaderData();
                    //LoadOutStatus();
                    RoutePettycash();
                    AppComplitionStatus();
                    TotalCountAndAmount();
                    rdfromDate.SelectedDate = DateTime.Parse(Session["fDate"].ToString());
                    rdendDate.SelectedDate = DateTime.Parse(Session["TDate"].ToString());
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SettlementReports.aspx ", "Error : " + ex.Message.ToString() + " - " + innerMessage);
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
                    btnpettycash.Enabled = true;
                }
                else
                {
                    lblProcess.ForeColor = System.Drawing.Color.Green;
                    btnpettycash.Enabled = true;
                }

            }
        }
        public void Route()
        {
            DataTable dtRoute = ObjclsFrms.loadList("SelectRoute", "sp_Settlement", ResponseID.ToString());
            string route = dtRoute.Rows[0]["rot_Name"].ToString();
            string settlementFrom= dtRoute.Rows[0]["rot_SettlementFrom"].ToString();
            string varlimit= dtRoute.Rows[0]["rot_SetlmntVarLimit"].ToString();
            lblvarlimit.Text = varlimit;
            lblRoute.Text = route.ToString();
            ViewState["settlmntFrom"] = settlementFrom.ToString(); 
            ViewState["VarLimit"]=varlimit.ToString();
            if (settlementFrom.ToString()=="A")
            {
                lblsettlementInfo.Text = "(Settlement From App)";

            }
            else if (settlementFrom.ToString()=="W")
            {
                lblsettlementInfo.Text = "(Settlement Initiation From App)";
            }
        }
        //public void LoadOutStatus()
        //{
        //    DataTable dtRouteType = ObjclsFrms.loadList("SelectRouteType", "sp_Settlement", ResponseID.ToString());
        //    string routeType = dtRouteType.Rows[0]["rot_Type"].ToString();
        //    ViewState["RouteType"] = routeType.ToString();
        //    if (routeType.Equals("OR") || routeType.Equals("AR"))
        //    {
        //        lblLoadOutStatus.Text = "Not Required";
        //    }
        //    else if(routeType.Equals("SL") || routeType.Equals("DR"))
        //    {
        //        DataTable lstVarianceAllowed = ObjclsFrms.loadList("SelectLoadOutStatusToDisplay", "sp_Settlement", ResponseID.ToString());
        //        string Lostatus = lstVarianceAllowed.Rows[0]["udp_LoadOutStatus"].ToString();
        //        lblLoadOutStatus.Text = Lostatus.ToString();
        //    }
            
        //}

        public void AppComplitionStatus()
        {
            DataTable lstCompletionStatus = ObjclsFrms.loadList("SelectAppComplEndosStatus", "sp_Settlement", ResponseID.ToString());
            string AppStatus = lstCompletionStatus.Rows[0]["udp_IsAppProcessComplete"].ToString();
            string processID = lstCompletionStatus.Rows[0]["ProcessID"].ToString();
            string date = lstCompletionStatus.Rows[0]["Dat"].ToString();
            string rot_Endorsement = lstCompletionStatus.Rows[0]["rot_IsEndorsementEnabled"].ToString();
            string endorsement = lstCompletionStatus.Rows[0]["udp_EndorsementStatus"].ToString();
            string initiateCount = lstCompletionStatus.Rows[0]["initiateCount"].ToString();
            string Settlement = lstCompletionStatus.Rows[0]["udp_SettlementStatus"].ToString();

            if (Settlement == "Completed")
            {
                lblSettlemetStatus.ForeColor = System.Drawing.Color.Green;
                txtHardCash.Enabled = false;
                txtPos.Enabled = false;
                txtOnlinePayment.Enabled = false;

            }
            else if (Settlement == "Pending")
            {
                lblSettlemetStatus.ForeColor = System.Drawing.Color.Red;
            }
            else if (Settlement == "Approval Pending")
            {
                lblSettlemetStatus.ForeColor = System.Drawing.Color.Red;
                txtHardCash.Enabled = false;
                txtPos.Enabled = false;
                txtOnlinePayment.Enabled = false;
            }
            if (rot_Endorsement == "N")
            {
                endorsement = "Y";
            }
            ViewState["AppStatus"] = AppStatus.ToString();
            ViewState["Endorsement"] = endorsement.ToString();
            ViewState["initiateCount"] = initiateCount.ToString();
            // lblLoadOutStatus.Text = AppStatus.ToString();
            lblProcessID.Text = processID.ToString();
            lblDate.Text = date.ToString();
            lblSettlemetStatus.Text = Settlement.ToString();
            ViewState["SettlementSts"]= Settlement.ToString();

        }

        protected void RadWizard1_FinishButtonClick(object sender, Telerik.Web.UI.WizardEventArgs e)
        {
            
                if (ViewState["settlmntFrom"].ToString() == "A")
                {
                    RadWizard1.Localization.Finish = "Override Settlement from App";
                }
                if (txtHardCash.Text.ToString() == "")
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

                //string rotTyp = ViewState["RouteType"].ToString();
                //if(rotTyp.Equals("SL") || rotTyp.Equals("DR"))
                //{
                //    DataTable lstVarianceAllowed = ObjclsFrms.loadList("SelectLoadOutStatus", "sp_Settlement", ResponseID.ToString());
                //    if (lstVarianceAllowed.Rows.Count > 0)
                //    {
                //        string allowed = lstVarianceAllowed.Rows[0]["udp_LoadOutStatus"].ToString();
                //        if (allowed.Equals("Y"))
                //        {
                //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                //        }
                //        else
                //        {
                //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>loadOutModal();</script>", false);
                //        }
                //    }
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                //}

                AppComplitionStatus();
                string status = ViewState["AppStatus"].ToString();
                string endorsement = ViewState["Endorsement"].ToString();
                string initiateCount = ViewState["initiateCount"].ToString();
                if (status.Equals("Completed"))
                {


                    if (endorsement.Equals("Y"))
                    {
                        if (ViewState["settlmntFrom"].ToString() == "A")
                        {
                            initiateCount = "1";
                        }

                        if (initiateCount == "0")
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>loadOutModal('There is no initiation from app..Please make initiation from app and continue');</script>", false);

                        }
                        else
                        {
                            if (ViewState["variance"].ToString() == "N")
                            {
                                string mode = ViewState["mode"].ToString();
                                double cashtyped = 0;
                                double cashreceive = 0;
                                if (mode == "HC")
                                {
                                    cashtyped = double.Parse(txtHardCash.Text.ToString());
                                    cashreceive = double.Parse(ViewState["HardCash"].ToString());


                                }
                                else if (mode == "POS")
                                {
                                    cashtyped = double.Parse(txtPos.Text.ToString());
                                    cashreceive = double.Parse(ViewState["POS"].ToString());


                                }
                                else if (mode == "OP")
                                {
                                    cashtyped = double.Parse(txtOnlinePayment.Text.ToString());
                                    cashreceive = double.Parse(ViewState["Online"].ToString());



                                }

                                if ((cashreceive != cashtyped))
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>loadOutModal('Received Amount mismatch');</script>", false);

                                }

                            }

                            int selected = grvPayment.SelectedItems.Count;
                            int total = Int32.Parse(ViewState["paymentGrid"].ToString());
                            if (total == selected)
                            {
                                if (ViewState["settlmntFrom"].ToString() == "A")
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confirm();</script>", false);

                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

                                }
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Payment();</script>", false);
                            }
                        }

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>loadOutModal('Please complete endorsement and try again.');</script>", false);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>loadOutModal('Please complete app process and try again.');</script>", false);
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
            DataTable Initiation = ObjclsFrms.loadList("SelectAdvanceCollection", "sp_Settlement", ResponseID.ToString());
            grvAdvance.DataSource = Initiation;
        }

        public void Initiation()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstAdvance = ObjclsFrms.loadList("SelectIniation", "sp_Settlement", ResponseID.ToString());
            RadGrid1.DataSource = lstAdvance;
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
            lblHardCash.Text = "0.00";
            lblHardCashVariance.Text = "0.00";
            lblPOS.Text = "0.00";
            lblPOSVariance.Text = "0.00";
            lblOnlinePayment.Text = "0.00";
            lblOnlinePaymentVariance.Text = "0.00";
            lblARCollCheque.Text = "";
            lblAdvCollCheque.Text = "";
            //lblRemark.Text = "";
            //lblTotalDebitNoteCount.Text = "";
            //lblTotalDebitNoteAmount.Text = "";


            DataTable lstOrderCount = ObjclsFrms.loadList("SelectOrdersCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstCreditCount = ObjclsFrms.loadList("SelectCreditCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstCashCount = ObjclsFrms.loadList("SelectCashCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstARCount = ObjclsFrms.loadList("SelectARCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstAdvanceCount = ObjclsFrms.loadList("SelectAdvanceCount", "sp_Settlement", ResponseID.ToString());
            DataTable lstPaymentCount = ObjclsFrms.loadList("SelTotalCash", "sp_Settlement", ResponseID.ToString());
            string stlmntsts = ViewState["SettlementSts"].ToString();
            DataTable lstCashReceived = new DataTable();
            if (stlmntsts.Equals("AP"))
            {
                lstCashReceived = ObjclsFrms.loadList("SelTotalWithMode", "sp_Settlement", ResponseID.ToString());

            }
            else
            {
                lstCashReceived = ObjclsFrms.loadList("SelTotalWithMode", "sp_Settlement", ResponseID.ToString());

            }
            DataTable lstChequeAmount = ObjclsFrms.loadList("SelectArAdvCheqAmount", "sp_Settlement", ResponseID.ToString());
			//DataTable lstDebitNote = ObjclsFrms.loadList("SelectSalesManDebitNoteCount", "sp_Settlement", ResponseID.ToString());
			DataTable lstPendingBalance = ObjclsFrms.loadList("SelectDiscrepencyAmount", "sp_Settlement", ResponseID.ToString());
			DataTable lstLastVariance = ObjclsFrms.loadList("SelectLastVariance", "sp_Settlement", ResponseID.ToString());
            DataTable Initiation = ObjclsFrms.loadList("SelectIniation", "sp_Settlement", ResponseID.ToString());
            DataTable pettycash = ObjclsFrms.loadList("Selecttotalpettycash", "sp_Settlement", ResponseID.ToString());


            if (pettycash != null && pettycash.Rows.Count > 0)
            {
                // Assuming the column name is "TotalAmount"
                string totalAmount = pettycash.Rows[0]["TotalAmount"].ToString();

                //lblpettycash.Text = totalAmount;
                lblpettycash1.Text = "-" + totalAmount;

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
            if (Initiation.Rows.Count > 0)
            {
                string Remark, image;
                Remark = Initiation.Rows[0]["Remarks"].ToString();
                image = Initiation.Rows[0]["Image"].ToString();
              //  lblRemark.Text = !string.IsNullOrEmpty(Remark) ? Remark : "No remark";
              //  ImageControl.ImageUrl = image;
                //lblOrderAmount.Text = orderAmount;
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
			//if (lstLastVariance.Rows.Count > 0)
			//{
			//	string LastVariance;
			//	LastVariance = lstLastVariance.Rows[0]["LastVariance"].ToString();
			//	lblLastVariance.Text = LastVariance;
			//}
			if (lstCashReceived.Rows.Count > 0)
            {
                string mode, amount;
                string hardCash, pos, onlinePay;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    DataTable lstVariance = ObjclsFrms.loadList("SelectAllowSettlementDiscrepancy", "sp_Settlement", ResponseID.ToString());
                    string variance = lstVariance.Rows[0]["rot_AllowSetlmntDiscrepancy"].ToString();
                    ViewState["variance"] = variance.ToString();
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    ViewState["mode"] = mode.ToString();
                    if (variance.Equals("Y"))
                    {
                        mode = lstCashReceived.Rows[i]["Mode"].ToString();
                        amount = lstCashReceived.Rows[i]["Amount"].ToString();

                       



                        if (mode.Equals("HC"))
                        {


                            hardCash = amount.ToString();
                            ViewState["HardCash"] = hardCash.ToString();

                            string Totalamt = ViewState["totalAmount"].ToString();

                            // Convert Totalamt to decimal
                            decimal totalAmountDecimal;
                            if (!decimal.TryParse(Totalamt, out totalAmountDecimal))
                            {
                                // Handle conversion failure, maybe log an error or throw an exception
                            }

                            // Assuming hardCash is already a decimal or convertible to decimal
                            decimal hardCashDecimal;
                            if (!decimal.TryParse(hardCash, out hardCashDecimal))
                            {
                                // Handle conversion failure, maybe log an error or throw an exception
                            }

                            ViewState["HardCash"] = hardCashDecimal.ToString();

                            // Perform subtraction and set lblHardCash.Text
                            lblHardCash.Text = (hardCashDecimal - totalAmountDecimal).ToString();

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
                    else
                    {
                        mode = lstCashReceived.Rows[i]["Mode"].ToString();
                        amount = lstCashReceived.Rows[i]["Amount"].ToString();
                        txtHardCash.Enabled = true;
                        txtPos.Enabled = true;
                        txtOnlinePayment.Enabled = true;
                        if (mode.Equals("HC"))
                        {
                            hardCash = amount.ToString();
                            ViewState["HardCash"] = hardCash.ToString();
                            lblHardCash.Text = hardCash;
                            // txtHardCash.Text = hardCash;
                            txtHardCash.Text = "0.00";
                            lblHardCashVariance.Text = "0.000";
                        }
                        else if (mode.Equals("POS"))
                        {
                            pos = amount.ToString();
                            ViewState["POS"] = pos.ToString();
                            lblPOS.Text = pos;
                            //txtPos.Text = pos;
                            txtPos.Text = "0.00";
                            lblPOSVariance.Text = "0.000";
                        }
                        else if (mode.Equals("OP"))
                        {
                            onlinePay = amount.ToString();
                            ViewState["Online"] = onlinePay.ToString();
                            lblOnlinePayment.Text = onlinePay;
                            // txtOnlinePayment.Text = onlinePay;
                            txtOnlinePayment.Text = "0.00";
                            lblOnlinePaymentVariance.Text = "0.000";
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
            //if (lstDebitNote.Rows.Count > 0)
            //{
            //    string debitNoteCount, debitNoteAmount;
            //    debitNoteCount = lstDebitNote.Rows[0]["totalCount"].ToString();
            //    debitNoteAmount = lstDebitNote.Rows[0]["totalAmount"].ToString();
            //    lblTotalDebitNoteCount.Text = debitNoteCount;
            //    lblTotalDebitNoteAmount.Text = debitNoteAmount;
            //}
        }

        protected void txtHardCash_TextChanged(object sender, EventArgs e)
        {
            if (ViewState["HardCash"] == null)
            {
                ViewState["HardCash"] = 0.00;
            }
            if(txtHardCash.Text.ToString().Equals(""))
            {
                txtHardCash.Text = "0.00";
            }
            double hardCash = double.Parse(ViewState["HardCash"].ToString());
            double hardReceived = double.Parse(txtHardCash.Text.ToString());
            double hardVariance = hardCash - hardReceived;
            lblHardCashVariance.Text = Math.Round(hardVariance, 3).ToString();
			TotalVariance();

		}

        protected void txtPos_TextChanged(object sender, EventArgs e)
        {
            if(ViewState["POS"] == null)
            {
                ViewState["POS"] = 0.00;
            }
            if (txtPos.Text.ToString().Equals(""))
            {
                txtPos.Text = "0.00";
            }
            double posCash = double.Parse(ViewState["POS"].ToString());
            double posReceived = double.Parse(txtPos.Text.ToString());
            double posVariance = posCash - posReceived;
            lblPOSVariance.Text = Math.Round(posVariance, 3).ToString();
			TotalVariance();

		}

        protected void txtOnlinePayment_TextChanged(object sender, EventArgs e)
        {
            if (ViewState["Online"] == null)
            {
                ViewState["Online"] = 0.00;
            }
            if (txtOnlinePayment.Text.ToString().Equals(""))
            {
                txtOnlinePayment.Text = "0.00";
            }
            double onlineCash = double.Parse(ViewState["Online"].ToString());
            double onlineReceived = double.Parse(txtOnlinePayment.Text.ToString());
            double onlineVariance = onlineCash - onlineReceived;
            lblOnlinePaymentVariance.Text = Math.Round(onlineVariance, 3).ToString();
			TotalVariance();

		}

        protected void grvPayment_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadPayment();
        }
        public void LoadPayment()
        {
            //string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstPayment = ObjclsFrms.loadList("SelectPayment", "sp_Settlement", ResponseID.ToString());
            ViewState["paymentGrid"] = lstPayment.Rows.Count;
            grvPayment.DataSource = lstPayment;
        }
        public void Save()
        {
            string invCash, arCash, advCash, udpID, rotID, usrID;
            invCash = lblPCashInvoices.Text.ToString();
            arCash = lblPArCollectionCash.Text.ToString();
            advCash = lblPAdvanceCash.Text.ToString();

            if (invCash=="")
            {
                invCash= "0";
            }
            if(arCash=="")
            {
                arCash= "0";
            }
            if (advCash=="")
            {
                advCash= "0";
            }
          


            udpID = ResponseID.ToString();
            rotID = "";
            usrID = "";
            string cheque = GetDetailFromGrid();
            string cash = GetDetailFromLabel();
            string status;
            if (ViewState["Approve"].ToString() == "Y")
            {
                status = "AP";
            }
            else
            {
                status = "SC";
            }
            string Coupon = GetCouponDataFronGrid();
            if (Coupon==null)
            {
                Coupon = "";
            }
            
            string hardcash, pos, onlinepayment;
            hardcash=txtHardCash.Text.ToString();
            pos=txtPos.Text.ToString();
            onlinepayment= txtOnlinePayment.Text.ToString();
                string[] arr = { arCash, advCash, udpID, rotID, usrID, cash, cheque, status , Coupon };
            DataTable lstSave = ObjclsFrms.loadList("UpdSettlement", "sp_Settlement", invCash, arr);
          
            int res = Int32.Parse(lstSave.Rows[0]["Res"].ToString());
            if (res > 0)
            {
                if (ViewState["Approve"].ToString() == "Y")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Settlement sent for Approoval');</script>", false);

                }
                else
                {
                    UpdateVarianceSum();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Settlement completed successfully');</script>", false);

                }


            }
            else
            {
                string descr = lstSave.Rows[0]["Descr"].ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('"+descr+"');</script>", false);
            }
        }
        public string GetCouponDataFronGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("p");

                    DataTable dsc = new DataTable();
                    foreach (GridDataItem dr in RadGrid3.SelectedItems)
                    {
                      
                        string cpb_ID, cpl_ID;


                        cpb_ID = dr["csi_cpb_ID"].Text.ToString();
                        cpl_ID = dr["csi_cpl_ID"].Text.ToString();

                        createNode2(cpb_ID, cpl_ID, writer);
                        c++;
                        
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    ViewState["CouponCollectedCount"] = c;
                }
                if (c == 0)
                {

                    return null;
                }
                else
                {
                    ViewState["CouponCollectedCount"] = c;
                    string ss = sw.ToString();
                    return sw.ToString();
                }
            }
        }
        private void createNode2(string cpb_ID, string cpl_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("cpb_ID");
            writer.WriteString(cpb_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("cpl_ID");
            writer.WriteString(cpl_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
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
                            if (amount=="")
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
                                if (expected=="")
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserDailyProcess.aspx");
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

		protected void TotalVariance()
		{
			double hardVariance, posVariance, onlineVariance;
			
			if (double.TryParse(lblHardCashVariance.Text, out hardVariance) &&
				double.TryParse(lblPOSVariance.Text, out posVariance) &&
				double.TryParse(lblOnlinePaymentVariance.Text, out onlineVariance))
			{
				double totalVariance = hardVariance + posVariance + onlineVariance;
				string sum = Math.Round(totalVariance, 3).ToString();
				lblTotalVariance.Text = sum;
               
			}
            else
            {
				lblTotalVariance.Text = "0.00";

			}
            try
            {
                double varlimit;
                double.TryParse(ViewState["VarLimit"].ToString(), out varlimit);

                double totvar = double.Parse(lblTotalVariance.Text.ToString());
                    if (totvar > varlimit)
                    {
                        RadWizard1.Localization.Finish = "Send for Approval";
                        ViewState["Approve"] = 'Y';
                    }
                    else
                    {
                        ViewState["Approve"] = 'N';
                        RadWizard1.Localization.Finish = "Settle";
                }
             }
                

                
            

            catch (Exception ex) { }

        }

		protected void btnPreviousVariances_Click(object sender, EventArgs e)
		{
			ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showPreviousVariances();</script>", false);

            PopulateTable();

		}
		public void PopulateTable()
		{
            try
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
            catch(Exception ex) { }
           
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
            AppComplitionStatus();
            string status = ViewState["AppStatus"].ToString();            
            if (status.Equals("Completed"))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showpettycash();</script>", false);
                Populatepettycash();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>loadOutModal('Please complete app process and try again.');</script>", false);
            }
           
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Populatepettycash();
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            string amount, dec, img, id, user;
            amount = txtamount.Text.ToString();
            dec = txtDEC.InnerText.ToString();
            id = ResponseID.ToString();
            user = UICommon.GetCurrentUserID().ToString();

            img = "";

            if (upd1.UploadedFiles.Count > 0) // Check if any file is uploaded
            {
                int ImageID = 0;
                foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                {
                    ImageID += 1;
                    string csvPath = Server.MapPath(("..") + @"/../UploadFiles/Pettycash/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                    uploadedFile.SaveAs(csvPath);
                    img = @"../../UploadFiles/Pettycash/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                    ViewState["Image"] = img.ToString();
                }
            }
            else // No image uploaded
            {
                img = "";// Use default or previously set image
            }

            string[] arr = { dec, img, id, user };
            string value = ObjclsFrms.SaveData("sp_Settlement", "InsertPettycash", amount, arr);
            int res = Int32.Parse(value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showSuccessToast('Petty Cash Details saved Successfully');</script>", false);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "refreshModal", "refreshModal();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
            }
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("SettlementReports.aspx?Id=" + ResponseID);
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

        protected void RadGrid2_ItemCommand(object sender, GridCommandEventArgs e)
        {
           
           


            if (e.CommandName.Equals("Delete"))
            {

                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pcs_ID").ToString();
                string[] arr = { };
                string Value = ObjclsFrms.SaveData("sp_Transaction", "ClosePettycash", ID, arr);
                RadGrid2.Rebind();

            }
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect("SettlementReports.aspx?Id=" + ResponseID);
        }

        public void BankName()
        {
            try
            {
               
                RDbank.DataSource = ObjclsFrms.loadList("SelectBank", "sp_Settlement");
                RDbank.DataTextField = "bnk_Name";
                RDbank.DataValueField = "bnk_ID";
                RDbank.DataBind();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SettlementReports.aspx Bank()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        protected void grvPayment_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("MyClick1"))
            {
                try
                {
                    foreach (GridDataItem di in grvPayment.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    GridDataItem item = grvPayment.MasterTableView.Items[Convert.ToInt32(e.CommandArgument)];
                    string ID = item.GetDataKeyValue("id").ToString();
                    string ChqNumber = item["chequeNo"].Text.ToString();
                    string Chqdate = item["chequeDate"].Text.ToString();
                    string Bank = item["bnk_Name"].Text.ToString();
                    string BankID = item["bnk_ID"].Text.ToString();
                    string Type = item["type"].Text.ToString();

                    Session["ID"] = ID.ToString();
                    Session["chequeNo"] = ChqNumber.ToString();
                    Session["chequeDate"] = Chqdate.ToString();
                    Session["bnk_Name"] = Bank.ToString();
                    Session["bnk_ID"] = BankID.ToString();
                    Session["type"] = Type.ToString();



                    BankName();
                    ddltext.Text = ChqNumber;
                    RDbank.SelectedValue = BankID;
                    //ddlbank.Text = Bank;
                    // ddlamt.Text = amt;
                    RadDatePicker1.SelectedDate = System.DateTime.Parse(Chqdate.ToString());

                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>UpdateStatus();</script>", false);

               



                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), ".aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
            }



        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string Bank,date,chnumber,user,Id,Type;

            Type = Session["type"].ToString();
            Id = ResponseID.ToString();
            Bank = RDbank.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            date = DateTime.Parse(RadDatePicker1.SelectedDate.ToString()).ToString("yyyyMMdd");
            chnumber = ddltext.Text.ToString();
            string[] arr = { date.ToString(), chnumber.ToString(), Id,Type };
            string Value = ObjclsFrms.SaveData("sp_Settlement", "UpdateBank", Bank.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                lblsuc.Text = "Bank Updated Sucessfully";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideLabel", "setTimeout(function() { document.getElementById('" + lblsuc.ClientID + "').style.display = 'none'; }, 5000);", true);
                LoadPayment();
                grvPayment.Rebind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
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
            string Id = ResponseID.ToString();
            string[] arr = { };
            string Value = ObjclsFrms.SaveData("sp_Settlement", "InsSettlementApproval", Id, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Settlement completed successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
        }

        protected void lnkrjectaprv_Click(object sender, EventArgs e)
        {
            string Id = ResponseID.ToString();
            string[] arr = { };
            string Value = ObjclsFrms.SaveData("sp_Settlement", "RejectSettlementApproval", Id, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RejectConfim('Settlement Not done..!');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
        }

        protected void lnkCollectCoupon_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showCoupon();</script>", false);
            string ID = ResponseID.ToString();
            DataTable dt = ObjclsFrms.loadList("SelCouponLeaf", "sp_Settlement", ID.ToString());
            RadGrid3.DataSource = dt;
            ViewState["Coupondt"] = dt;
            RadGrid3.Rebind();
            
        }
        public void CouponData()
        {
            
            string ID = ResponseID.ToString();
            DataTable dt = ObjclsFrms.loadList("SelCouponCounts", "sp_Settlement", ID.ToString());
            lblRedeemedCoupon.Text = dt.Rows[0]["TotalRedeem"].ToString();
           
        }

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            
        }

        protected void CouponOK_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>hideCoupon();</script>", false);
            
            string CouponData = GetCouponDataFronGrid();
            string CouponCollectedCount = ViewState["CouponCollectedCount"].ToString();
            lblCollectedCoupon.Text = CouponCollectedCount;
        }
    }
    
}