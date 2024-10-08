using DocumentFormat.OpenXml.Vml.Spreadsheet;
using GoogleApi.Entities.Common.Enums;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using static Stimulsoft.Report.Func;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using Telerik.Windows.Documents.Fixed.Model.Common;
using DocumentFormat.OpenXml.Presentation;
using System.Reflection;
using System.ComponentModel;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCusRoute : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["CID"], out ResponseID);
                return ResponseID;
            }
        }
        public int RouteID
        {
            get
            {
                int RouteID;
                int.TryParse(Request.Params["RID"], out RouteID);
                return RouteID;
            }
        }
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["Mode"], out Mode);
                return Mode;
            }
        }

        public int CUSID
        {
            get
            {
                int CUSID;
                int.TryParse(Request.Params["CusID"], out CUSID);

                return CUSID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable dt = ob.loadList("SelectRouteType", "sp_Masters", RouteID.ToString());
                String RouteCode = dt.Rows[0]["rot_Code"].ToString();
                String RouteName = dt.Rows[0]["rot_Name"].ToString();
                String RouteType = dt.Rows[0]["RouteType"].ToString();

                lblRouteCode.Text = RouteCode.ToString();
                lblRouteName.Text = RouteName.ToString();
                lblRouteType.Text = RouteType.ToString();

                if (ResponseID.ToString() == "" || ResponseID.ToString() == "0")
                {
                    pnlItemMapping.Visible = false;
                }
                else
                {
                    pnlItemMapping.Visible = true;
                }


                Route();
                Profile();
                // Customer();
                Paymode();

                if (Mode == 1) // While loading page from dashboard 
                {
                    lnkSearch.Visible = false;
                    CustomerS();
                    ddlcus.Enabled = false;
                    ProductMappingGroup();


                }

                else
                {
                    string Id = ResponseID.ToString();
                    if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                    {
                        search.Visible = true;

                        ddlcus.Attributes.Add("onkeydown", "return false;");
                        ddlcus.AutoPostBack = true;
                        //CustomerwithoutRoute();

                    }
                    else                                                                        //If we are editing there will be a value and the following code will be executed.
                    {

                        DataTable lstDatas = ob.loadList("EditCusRoute", "sp_Masters", ResponseID.ToString());
                        if (lstDatas.Rows.Count > 0)
                        {
                            Customer();
                            search.Visible = false;
                            string rot, rotname, cus, IsInvoicing, IsSO, IsMerchandising, IsAR, IsI_Sales, IsI_GR, IsI_BR, IsI_FG, TCL, CDays, VoidEnable, PT, RoundAmount,
                            IsVAT, IsPO, cusType, signatureinvoice, Remark, signatureAR, OrderReqR, custCategoryType,
                            selectiontype, radius, Orderpro, IsHold, oncall, noOfInv, advpay, FG, status, MerchColumns, paymode, mandcolumns, enforcecussel, Cheque, SalSign, OrdSign, InvMode, AltInvReq, FGsep,
                            Insight, FS, FSFeatures, NegativeInvAmt, profile, MinInvoiceValue, MustSellItemCount, IsArManualAllocation, GracePeriod, GraceAmount, PartialDelivery, PriceChange, OrdPriceChange, eInvoive,
                            CusDocExpiryAlert, AlertDays, invhcimgmand, invposimgmand, invopimgmand, arhcimgmand, arposimgmand, arpoimgmand, archimgmand, ActvityManage, CusService,
                            ActManageMand, CusServiceMand, IsActivityManage, IsCustomerService, rcs_EnableForecastSales, rcs_EnableQuotation, EnableSuggestedOrd, IsPriceChange, CusLocation,
                            RecentSales, RecentOrder, MinOrderValue, ARRemark, GRSettings, BRSettings, VoidEnableCusInsight, EnableDelPriceChange, ARPayMode, rcs_EnforceBuyBackfree, MustSell,
                            InstDelivery, AttachmentsAR,IsAttachmentOrder,AttachmentInvoice,FreeSampleOrder,CouponPayMode, CurrentSecurityDeposit, FreeSampleOrderApproval,SuggestedLoadReq, 
                            CouponEnable, InsCusSettings,fulldelivery, EnableLPONumber , LPONumberMand  ;

                            invhcimgmand = lstDatas.Rows[0]["rcs_INV_HCRcpt_Img_Mand"].ToString();
                            invposimgmand = lstDatas.Rows[0]["rcs_INV_POSRcpt_Img_Mand"].ToString();
                            invopimgmand = lstDatas.Rows[0]["rcs_INV_OPRcpt_Img_Mand"].ToString();
                            arhcimgmand = lstDatas.Rows[0]["rcs_AR_HCRcpt_Img_Mand"].ToString();
                            arposimgmand = lstDatas.Rows[0]["rcs_AR_POSRcpt_Img_Mand"].ToString();
                            arpoimgmand = lstDatas.Rows[0]["rcs_AR_OPRcpt_Img_Mand"].ToString();
                            archimgmand = lstDatas.Rows[0]["rcs_AR_CHRcpt_Img_Mand"].ToString();
                            RecentSales = lstDatas.Rows[0]["rcs_EnableRecentSales"].ToString();
                            RecentOrder = lstDatas.Rows[0]["rcs_EnableRecentOrder"].ToString();
                            GRSettings= lstDatas.Rows[0]["rcs_GRSettings"].ToString();
                            BRSettings=lstDatas.Rows[0]["rcs_BRSettings"].ToString();
                            ARPayMode= lstDatas.Rows[0]["rcs_ArPaymodes"].ToString();
                            CouponPayMode= lstDatas.Rows[0]["rcs_CouponPayMode"].ToString();
                            


                            rot = lstDatas.Rows[0]["rcs_rot_ID"].ToString();
                            rotname = lstDatas.Rows[0]["rot_Name"].ToString();

                            cus = lstDatas.Rows[0]["cus_ID"].ToString();
                            cusType = lstDatas.Rows[0]["rcs_cusType"].ToString();
                            custCategoryType = lstDatas.Rows[0]["rcs_CustCategoryType"].ToString();
                            TCL = lstDatas.Rows[0]["rcs_TotalCreditLimit"].ToString();

                            CDays = lstDatas.Rows[0]["rcs_CreditDays"].ToString();
                            PT = lstDatas.Rows[0]["rcs_PaymentTerms"].ToString();
                            noOfInv = lstDatas.Rows[0]["rcs_NoOfInvoice"].ToString();
                            IsVAT = lstDatas.Rows[0]["rcs_IsVAT"].ToString();
                            IsHold = lstDatas.Rows[0]["rcs_IsHold"].ToString();
                            status = lstDatas.Rows[0]["Status"].ToString();

                            selectiontype = lstDatas.Rows[0]["rcs_SelectionType"].ToString();
                            radius = lstDatas.Rows[0]["rcs_FencingRadius"].ToString();
                            oncall = lstDatas.Rows[0]["rcs_OnCallFeatures"].ToString();
                            string[] arr = oncall.Split('-');
                            IsSO = lstDatas.Rows[0]["IsSalesOrder"].ToString();
                            IsInvoicing = lstDatas.Rows[0]["rcs_IsSalesJob"].ToString();
                            IsI_Sales = lstDatas.Rows[0]["IsInvoicing_Sales"].ToString();
                            IsI_GR = lstDatas.Rows[0]["IsInvoicing_GR"].ToString();
                            IsI_BR = lstDatas.Rows[0]["IsInvoicing_BR"].ToString();
                            IsI_FG = lstDatas.Rows[0]["IsInvoicing_FG"].ToString();
                            IsAR = lstDatas.Rows[0]["IsAR"].ToString();
                            advpay = lstDatas.Rows[0]["rcs_IsAdvPayment"].ToString();
                            IsMerchandising = lstDatas.Rows[0]["IsMerchandising"].ToString();
                            IsActivityManage = lstDatas.Rows[0]["IsActivityManagement"].ToString();//IsActivityManagement
                            IsCustomerService = lstDatas.Rows[0]["IsCustomerService"].ToString();
                            eInvoive = lstDatas.Rows[0]["rcs_EInvoiceSend"].ToString();
                            AttachmentInvoice = lstDatas.Rows[0]["rcs_IsAttachmentsInvoice"].ToString();
                            EnableLPONumber = lstDatas.Rows[0]["rcs_EnableLPONumber"].ToString();
                            LPONumberMand = lstDatas.Rows[0]["rcs_LPONumberMand"].ToString();

                            VoidEnable = lstDatas.Rows[0]["rcs_VoidEnable"].ToString();
                            RoundAmount = lstDatas.Rows[0]["rcs_RoundAmount"].ToString();
                            IsPO = lstDatas.Rows[0]["rcs_IsPrintOut"].ToString();
                            signatureinvoice = lstDatas.Rows[0]["rcs_IsSignatureInvoice"].ToString();
                            signatureAR = lstDatas.Rows[0]["rcs_IsSignatureAR"].ToString();
                            Remark = lstDatas.Rows[0]["rcs_IsRemarkInvoice"].ToString();
                            OrderReqR = lstDatas.Rows[0]["rcs_IsRemarkOrderReq"].ToString();
                            Orderpro = lstDatas.Rows[0]["rcs_IsOrderPromo"].ToString();
                            FG = lstDatas.Rows[0]["rcs_IsFGExemption"].ToString();
                            MerchColumns = lstDatas.Rows[0]["rcs_MerchFeatures"].ToString();
                            mandcolumns = lstDatas.Rows[0]["rcs_MandFeatures"].ToString();
                            ActvityManage = lstDatas.Rows[0]["rcs_ActManageFeatures"].ToString();
                            CusService = lstDatas.Rows[0]["rcs_CusServiceFeatures"].ToString();
                            ActManageMand = lstDatas.Rows[0]["rcs_AMMandFeatures"].ToString();
                            CusServiceMand = lstDatas.Rows[0]["rcs_CSMandFeatures"].ToString();
                            paymode = lstDatas.Rows[0]["rcs_PaymentModes"].ToString();
                            enforcecussel = lstDatas.Rows[0]["rcs_EnforceCustSelection"].ToString();
                            SalSign = lstDatas.Rows[0]["rcs_EnableSalesSign"].ToString();
                            OrdSign = lstDatas.Rows[0]["rcs_EnableOrderSign"].ToString();
                            IsAttachmentOrder = lstDatas.Rows[0]["rcs_IsAttachmentsOrder"].ToString();
                            FreeSampleOrder = lstDatas.Rows[0]["rcs_EnableFreeSampleOrder"].ToString();;                           
                            FreeSampleOrderApproval = lstDatas.Rows[0]["rcs_EnableFreeSampleOrderApproval"].ToString();;                           
                            InvMode = lstDatas.Rows[0]["rcs_InvoiceMode"].ToString();
                            Cheque = lstDatas.Rows[0]["Cheque_Amount"].ToString();
                            AltInvReq = lstDatas.Rows[0]["AltInvReq"].ToString();
                            Insight = lstDatas.Rows[0]["rcs_EnableInsight"].ToString();
                            FS = lstDatas.Rows[0]["IsFS"].ToString();
                            NegativeInvAmt = lstDatas.Rows[0]["rcs_IsNegativeInvoiceAmt"].ToString();
                            FSFeatures = lstDatas.Rows[0]["rcs_FSFeatures"].ToString();
                            profile = lstDatas.Rows[0]["rcs_CusProfileSettings"].ToString();
                            GraceAmount = lstDatas.Rows[0]["rcs_GraceAmount"].ToString();
                            GracePeriod = lstDatas.Rows[0]["rcs_GracePeriod"].ToString();
                            InsCusSettings = lstDatas.Rows[0]["rcs_InsightCustomerSettings"].ToString();
                            
                            string[] ary = profile.Split('-');
                            string[] arry = MerchColumns.Split('-');
                            string[] array = mandcolumns.Split('-');
                            string[] ar = paymode.Split('-');
                            string[] arFS = FSFeatures.Split('-');
                            string[] ActMngArray = ActvityManage.Split('-');
                            string[] CusServiceArray = CusService.Split('-');
                            string[] ActMngMandArray = ActManageMand.Split('-');
                            string[] CusServiceMandArray = CusServiceMand.Split('-');
                            string[] GRSettingsArray = GRSettings.Split(',');
                            string[] BRSettingsArray = BRSettings.Split(',');
                            string[] ARPayModeArray = ARPayMode.Split('-');
                            string[] CouponPayModeArray = CouponPayMode.Split('-');
                            string[] InsCusSettingsArray = InsCusSettings.Split('-');

                            FGsep = lstDatas.Rows[0]["rcs_FGSeperate"].ToString();



                            MinInvoiceValue = lstDatas.Rows[0]["rcs_MinInvoiceValue"].ToString();
                            MustSellItemCount = lstDatas.Rows[0]["rcs_MustSellItemCount"].ToString();
                            IsArManualAllocation = lstDatas.Rows[0]["rcs_IsArManualAllocation"].ToString();
                            AttachmentsAR = lstDatas.Rows[0]["rcs_IsAttachmentsAR"].ToString();
                            PartialDelivery = lstDatas.Rows[0]["rcs_EnablePD"].ToString();
                            PriceChange = lstDatas.Rows[0]["rcs_EnablePriceChange"].ToString();
                            OrdPriceChange = lstDatas.Rows[0]["rcs_EnableOrdPriceChange"].ToString();
                            AlertDays = lstDatas.Rows[0]["rcs_AlertDays"].ToString();
                            CusDocExpiryAlert = lstDatas.Rows[0]["rcs_EnableCusDocExpiryAlert"].ToString();
                            rcs_EnableForecastSales = lstDatas.Rows[0]["rcs_EnableForecastSales"].ToString();
                            rcs_EnableQuotation = lstDatas.Rows[0]["rcs_EnableQuotation"].ToString();
                            EnableSuggestedOrd = lstDatas.Rows[0]["EnableSuggestedOrd"].ToString();
                            IsPriceChange = lstDatas.Rows[0]["rcs_IsPriceChange"].ToString();
                            CusLocation = lstDatas.Rows[0]["rcs_ERPCusLocation"].ToString();
                            MinOrderValue =lstDatas.Rows[0]["rcs_OrderMinValue"].ToString();
                            ARRemark = lstDatas.Rows[0]["rcs_IsRemarkAR"].ToString();//[rcs_IsRemarkAR]
                            VoidEnableCusInsight= lstDatas.Rows[0]["rcs_VoidEnableInsightCustomer"].ToString();
                            EnableDelPriceChange = lstDatas.Rows[0]["rcs_EnableDelPriceChange"].ToString();//rcs_EnableDelPriceChange                    
                            rcs_EnforceBuyBackfree = lstDatas.Rows[0]["rcs_EnforceBuyBackFree"].ToString();
                            MustSell = lstDatas.Rows[0]["rcs_IsMustSellApproval"].ToString();
                            InstDelivery = lstDatas.Rows[0]["rcs_EnableInstantDelivery"].ToString();                         
                            CurrentSecurityDeposit = lstDatas.Rows[0]["rcs_CurrentSecurityDeposit"].ToString();
                            SuggestedLoadReq = lstDatas.Rows[0]["EnableSuggestedLODReq"].ToString();
                            CouponEnable = lstDatas.Rows[0]["rcs_IsCoupon"].ToString();
                            fulldelivery = lstDatas.Rows[0]["rcs_OptionForFullDelivery"].ToString();


                            rdFulldelivery.SelectedValue = fulldelivery.ToString();
                            ddARRemarks.SelectedValue = ARRemark.ToString();
                            HCimgMand.SelectedValue = invhcimgmand.ToString();
                            POSimgMand.SelectedValue = invposimgmand.ToString();
                            OPimgMand.SelectedValue = invopimgmand.ToString();
                            ARHCingmand.SelectedValue = arhcimgmand.ToString();
                            ARPOSimgMnad.SelectedValue = arposimgmand.ToString();
                            AROPimgMand.SelectedValue = arpoimgmand.ToString();
                            ARCHimgMnad.SelectedValue = archimgmand.ToString();
                            ddlRecentSale.SelectedValue = RecentSales.ToString();
                            ddlRecentOder.SelectedValue = RecentOrder.ToString();


                            ddlroute.SelectedValue = rot.ToString();
                            ddlcus.SelectedValue = cus.ToString();
                            ddcusType.SelectedValue = cusType.ToString();
                            ddcatType.SelectedValue = custCategoryType.ToString();
                            txtTCL.Text = TCL.ToString();

                            txtCDays.Text = CDays.ToString();
                            ddPT.SelectedValue = PT.ToString();
                            txtnoInvoice.Text = noOfInv.ToString();
                            ddIsVAT.SelectedValue = IsVAT.ToString();
                            ddlIsHold.SelectedValue = IsHold.ToString();
                            ddlstatus.SelectedValue = status.ToString();

                            ddltype.SelectedValue = selectiontype.ToString();
                            txtradius.Text = radius.ToString();
                            ddIsSOrder.SelectedValue = IsSO.ToString();
                            ddlIsInvoicing.SelectedValue = IsInvoicing.ToString();
                            ddIsI_Sales.SelectedValue = IsI_Sales.ToString();
                            ddIsI_GR.SelectedValue = IsI_GR.ToString();
                            ddIsI_BR.SelectedValue = IsI_BR.ToString();
                            ddIsI_FG.SelectedValue = IsI_FG.ToString();
                            ddlIsAR.SelectedValue = IsAR.ToString();
                            ddladvpay.SelectedValue = advpay.ToString();
                            ddIsMerchand.SelectedValue = IsMerchandising.ToString();

                            ddVoidEnable.SelectedValue = VoidEnable.ToString();
                            ddVoidEnableCusInsight.SelectedValue = VoidEnableCusInsight.ToString();
                            ddRoundAmount.SelectedValue = RoundAmount.ToString();

                            ddlSI.SelectedValue = signatureinvoice.ToString();
                            ddSAR.SelectedValue = signatureAR.ToString();
                            ddRe.SelectedValue = Remark.ToString();
                            ddORR.SelectedValue = OrderReqR.ToString();
                            ddlordpro.SelectedValue = Orderpro.ToString();
                            ddlFGExemption.SelectedValue = FG.ToString();
                            ddlenforcecussel.SelectedValue = enforcecussel.ToString();
                            ddlEnablesalsign.SelectedValue = SalSign.ToString();
                            ddlenableOrdrsign.SelectedValue = OrdSign.ToString();
                            ddlIsAttachmentsOrder.SelectedValue = IsAttachmentOrder.ToString();
                            ddlEnableFreeSampleOrder.SelectedValue = FreeSampleOrder.ToString();
                            ddlEnableFreeSampleOrderApproval.SelectedValue = FreeSampleOrderApproval.ToString();
                            ddlInvoiceMode.SelectedValue = InvMode.ToString();
                            rdAltInvReq.SelectedValue = AltInvReq.ToString();

                            ddlEnableInsight.SelectedValue = Insight.ToString();
                            ddlFS.SelectedValue = FS.ToString();
                            ddlnegativeInvAmt.SelectedValue = NegativeInvAmt.ToString();
                            //txtCheqAmnt.Text = Cheque.ToString();
                            ddlcus.Enabled = false;
                            ddlFGsep.SelectedValue = FGsep.ToString();

                            MinInvoiceVal.Text = MinInvoiceValue.ToString();
                            MustSellItmCnt.Text = MustSellItemCount.ToString();
                            IsArManAllocation.SelectedValue = IsArManualAllocation.ToString();
                            IsAttachmentsAR.SelectedValue = AttachmentsAR.ToString();
                            txtGraceamount.Text = GraceAmount.ToString();
                            txtGracePeriod.Text = GracePeriod.ToString();
                            ddlEnablePD.SelectedValue = PartialDelivery.ToString();
                            ddlPriceChange.SelectedValue = PriceChange.ToString();
                            ddlOrdPriceChange.SelectedValue = OrdPriceChange.ToString();
                            ddleInvoice.SelectedValue = eInvoive.ToString();
                            ddlAttachmentInvoice.SelectedValue = AttachmentInvoice.ToString();
                            ddlCusDocExpiryAlert.SelectedValue = CusDocExpiryAlert.ToString();
                            txtAlertDay.Text = AlertDays.ToString();
                            ddlISCusService.SelectedValue = IsCustomerService.ToString();
                            ddlIsActManage.SelectedValue = IsActivityManage.ToString();
                            ddlEnableForecastSales.SelectedValue = rcs_EnableForecastSales.ToString();
                            ddlEnableQuotation.SelectedValue = rcs_EnableQuotation.ToString();
                            ddlEnableSuggestedOrd.SelectedValue = EnableSuggestedOrd.ToString();
                            ddlISPriceChange.SelectedValue = IsPriceChange.ToString();
                            txtCusLocation.Text = CusLocation.ToString();
                            rdMinOrderValue.Text = MinOrderValue.ToString();
                            ddlDelPriceChange.SelectedValue = EnableDelPriceChange.ToString();
                            ddlEnforceBuyBackfree.SelectedValue = rcs_EnforceBuyBackfree.ToString();
                            ddlMustSellApproval.SelectedValue = MustSell.ToString();
                            ddlInstDelivery.SelectedValue = InstDelivery.ToString();                          
                            txtCurrentSecDeposit.Text = CurrentSecurityDeposit.ToString();
                            ddlSuggLoadReq.SelectedValue = SuggestedLoadReq.ToString();
                            ddlISCouponEnable.SelectedValue = CouponEnable.ToString();
                            ddlEnableLPONumber.SelectedValue = EnableLPONumber.ToString();
                            ddlLPONumberMand.SelectedValue = LPONumberMand.ToString();




                            for (int i = 0; i < arFS.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlFSFeatures.Items)
                                {
                                    if (items.Value == arFS[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < arr.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddloncal.Items)
                                {
                                    if (items.Value == arr[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < arry.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlMandColumns.Items)
                                {
                                    if (items.Value == arry[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < ActMngArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlActManage.Items)
                                {
                                    if (items.Value == ActMngArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < CusServiceArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlCusService.Items)
                                {
                                    if (items.Value == CusServiceArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < ActMngMandArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlAMMand.Items)
                                {
                                    if (items.Value == ActMngMandArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < CusServiceMandArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlCSMand.Items)
                                {
                                    if (items.Value == CusServiceMandArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < array.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlmandfeatures.Items)
                                {
                                    if (items.Value == array[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlpaymode.Items)
                                {
                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            for (int i = 0; i < ary.Length; i++)
                            {
                                foreach (RadComboBoxItem items in CusProfile.Items)
                                {
                                    if (items.Value == ary[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }

                            for (int i = 0; i < GRSettingsArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdGRSettings.Items)
                                {
                                    if (items.Value == GRSettingsArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }

                            for (int i = 0; i < BRSettingsArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdBRSettings.Items)
                                {
                                    if (items.Value == BRSettingsArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }

                            for (int i = 0; i < ARPayModeArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdARPayMode.Items)
                                {
                                    if (items.Value == ARPayModeArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            
                            for (int i = 0; i < CouponPayModeArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                                {
                                    if (items.Value == CouponPayModeArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }


                            for (int i = 0; i < InsCusSettingsArray.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                                {
                                    if (items.Value == InsCusSettingsArray[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }

                            if (cusType == "CS")
                            {
                                Custype.Visible = false;
                            }
                            else
                            {
                                Custype.Visible = true;
                            }
                            if (cusType == "TC")
                            {
                                noofinvoice.Visible = true;
                            }
                            else
                            {
                                noofinvoice.Visible = false;
                            }

                            if (IsInvoicing == "N")
                            {
                                inv.Visible = false;
                            }

                            else
                            {
                                inv.Visible = true;
                            }
                            if (ddcatType.SelectedValue == "NC")
                            {
                                ddIsSOrder.Enabled = false;
                                ddIsI_Sales.Enabled = true;
                            }
                            else
                            {
                                plsSalesorder.Visible = true;
                                ddIsSOrder.Enabled = true;
                                ddIsI_Sales.Enabled = false;
                            }

                            if (ddcusType.SelectedValue == "CS")
                            {
                                Paymodes.Visible = true;
                            }
                            else
                            {
                                Paymodes.Visible = false;
                            }
                            if (ddltype.SelectedValue == "B")
                            {
                                pnlFencing.Visible = false;
                            }
                            else
                            {
                                pnlFencing.Visible = true;
                            }

                            txtTCL.Enabled = true;

                            if (ddPT.SelectedValue == "N")
                            {
                                Paymodes.Visible = false;
                            }
                            else
                            {
                                Paymodes.Visible = true;
                            }
                            if (FS == "Y")
                            {
                                pnlFS.Visible = true;

                            }
                            else
                            {
                                pnlFS.Visible = false;
                            }
                            if (IsAR == "Y")
                            {
                                pnlAR.Visible = true;
                            }
                            else
                            {
                                pnlAR.Visible = false;
                            }
                            if (IsMerchandising == "Y")
                            {
                                pnlMandFeat.Visible = true;
                            }
                            else
                            {
                                pnlMandFeat.Visible = false;
                            }
                            if (IsActivityManage == "Y")
                            {
                                pnlActmanage.Visible = true;
                            }
                            else
                            {
                                pnlActmanage.Visible = false;
                            }
                            if (IsCustomerService == "Y")
                            {
                                pnlCusService.Visible = true;
                            }
                            else
                            {
                                pnlCusService.Visible = false;
                            }
                            
                        }
                    }
                    ProductMappingGroup();
                }
               
            }
        }

        public void Route()
        {
            DataTable dt = ob.loadList("Route", "sp_Masters", RouteID.ToString());
            if (dt.Rows.Count > 0)
            {
                string rotname = dt.Rows[0]["rot_Name"].ToString();

                //cusroute.Text = "Route Name : " + rotname;
            }

        }
        public string Mandcolumns()
        {
            string retStr = "";
            var checkedItems = ddlMandColumns.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }
        
       
        public string ActivityManage()
        {
            string retStr = "";
            var checkedItems = ddlActManage.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }
        public string CustomerService()
        {
            string retStr = "";
            var checkedItems = ddlCusService.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }
        public string ActivityManageMand()
        {
            string retStr = "";
            var checkedItems = ddlAMMand.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }
        public string CustomerServiceMand()
        {
            string retStr = "";
            var checkedItems = ddlCSMand.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }
        public string CusProfileSettings()
        {
            string retStr = "";
            var checkedItems = CusProfile.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            if (retStr != "")
            {
                retStr = retStr.Remove(retStr.Length - 1, 1);

            }
            return retStr;
        }
        public string Mandfeature()
        {
            string retStr = "";
            var checkedItems = ddlmandfeatures.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }

        public string paytmodecolumns()
        {
            string retStr = "";
            var checkedItems = ddlpaymode.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }


        public string GRSettingsSL()
        {
            string retStr = "";
            var checkedItems = rdGRSettings.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + ",";
            }
            return retStr;
        }

        public string BRSettingsSL()
        {
            string retStr = "";
            var checkedItems = rdBRSettings.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + ",";
            }
            return retStr;
        }

        public string ARPaymentMode()
        {
            string retStr = "";
            var checkedItems = rdARPayMode.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            if (retStr != "")
            {
                retStr = retStr.Remove(retStr.Length - 1, 1);

            }
            return retStr;
        }
        
        public string CouponPaymentMode()
        {
            string retStr = "";
            var checkedItems = rdCouponPayMode.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            if (retStr != "")
            {
                retStr = retStr.Remove(retStr.Length - 1, 1);

            }
            return retStr;
        }

        public string InsCusSetting()
        {
            string retStr = "";
            var checkedItems = rdInsCusSetting.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            if (retStr != "")
            {
                retStr = retStr.Remove(retStr.Length - 1, 1);

            }
            return retStr;
        }


        public void CustomerwithoutRoute()
        {

            DataTable dts = ob.loadList("selcusbyid", "sp_Masters", RouteID.ToString());
            if (dts.Rows.Count > 0)
            {

                ddlcus.DataSource = dts;
                ddlcus.DataTextField = "cus_Name";
                ddlcus.DataValueField = "cus_ID";
                ddlcus.DataBind();
            }
        }
        public void Customer()
        {
            string[] arr = { ResponseID.ToString() };
            DataTable dt = ob.loadList("selcus", "sp_Masters", RouteID.ToString(), arr);
            ddlcus.DataSource = dt;
            ddlcus.DataTextField = "cus_Name";
            ddlcus.DataValueField = "cus_ID";
            ddlcus.DataBind();

        }

        public void CustomerS()
        {
            string CUSIDS = CUSID.ToString();
            DataTable dt = ob.loadList("SelectRouteCustomerforMappping", "sp_Masters", CUSIDS);

            // Check if the DataTable contains data
            if (dt != null && dt.Rows.Count > 0)
            {
                ddlcus.DataSource = dt;
                ddlcus.DataTextField = "cus_Name"; // Assuming this is the display text field
                ddlcus.DataValueField = "cus_ID"; // Assuming this is the value field
                ddlcus.DataBind();

                // Optionally, set the selected value if needed
                ddlcus.SelectedValue = CUSIDS; // Assuming CUSID represents the selected value
            }
        }


        public void CustomerLike()
        {
            string[] arr = { SearchTextBox.Text.ToString() };
            DataTable ds = ob.loadList("selcusLike", "sp_Masters", RouteID.ToString(), arr);
            ddlcus.DataSource = ds;
            ddlcus.DataTextField = "cus_Name";
            ddlcus.DataValueField = "cus_ID";
            ddlcus.DataBind();

        }
        public void Paymode()
        {
            DataTable dt = ob.loadList("selPaymode", "sp_Masters", RouteID.ToString());
            ddlpaymode.DataSource = dt;
            ddlpaymode.DataTextField = "Data";
            ddlpaymode.DataValueField = "Data";
            ddlpaymode.DataBind();

        }

        public void SaveData()
        {
            string rot, cus, IsInvoicing, IsSO, IsMerchandising, IsAR, IsI_Sales, IsI_GR, IsI_BR, IsI_FG, TCL, CDays, VoidEnable, PT, RoundAmount, UIC, PDCAmount, custCategoryType,
            IsVAT, IsPO, cusType, signatureinvoice, Remark, signatureAR, selectiontype, radius, Orderpro, IsHold, oncall, noOfInv, advpay, FG, OrderReqR, status, MerchColumns, paymode, Mandfeatures, enforcecussel,
            Salsign, Ordsign, InvMode, AltInvReq, FGsep, Insight, FS, FSFeatures, NegativeInvAmt, profile, MinInvoiceValue, MustSellItemCount, IsArManualAllocation, GraceAmount, GracePeriod, PartialDelivery, PriceChange,
            OrdPriceChange, eInvoice, AlertDays,CusDocExpiryAlert,invhcimgmand,invposimgmand,invopimgmand,arhcimgmand,arposimgmand,arpoimgmand,archimgmand,ActManage,CusService,
            ActManageMand, CusServiceMand, IsAvtManage, IsCusService, EnableForecastSales, EnableQuotation, EnableSuggestedOrd, IsPriceChange , CusLocation, RecentSales, RecentOrder, MinOrderValue,
            ARRemarks,GRSettings,BrSettings,VoidEnableCusInsight, EnableDelPriceChange,ARPayMode, rcs_EnforceBuyBackfree, MustSell, InstDelivery, AttachmentsAR, IsAttachmentOrder, AttachmentInvoice,FreeSampleOrder,
            CouponPayMode, CurrentSecurityDeposit,FreeSampleOrderApproval, SuggestedLoadReq, CouponEnable, InsCusSettings, fulldelivery, EnableLPONumber,LPONumberMand;

            GracePeriod = "0";
            GraceAmount= "0";
            profile = CusProfileSettings();
            rot = ddlroute.SelectedValue.ToString();
            cus = ddlcus.SelectedValue.ToString();
            cusType = ddcusType.SelectedValue.ToString();
            custCategoryType = ddcatType.SelectedValue.ToString();
            TCL = txtTCL.Text.ToString();
            RecentSales = ddlRecentSale.SelectedValue.ToString();
            RecentOrder = ddlRecentOder.SelectedValue.ToString();
            MinInvoiceValue = MinInvoiceVal.Text.ToString();
            MustSellItemCount = MustSellItmCnt.Text.ToString();
			IsArManualAllocation = IsArManAllocation.SelectedValue.ToString();
            AttachmentsAR = IsAttachmentsAR.SelectedValue.ToString();
			PartialDelivery = ddlEnablePD.SelectedValue.ToString();
			PriceChange = ddlPriceChange.SelectedValue.ToString();
            OrdPriceChange = ddlOrdPriceChange.SelectedValue.ToString();
            eInvoice = ddleInvoice.SelectedValue.ToString();
            AttachmentInvoice = ddlAttachmentInvoice.SelectedValue.ToString();
            invhcimgmand = HCimgMand.SelectedValue.ToString();
            invposimgmand = POSimgMand.SelectedValue.ToString();
            invopimgmand = OPimgMand.SelectedValue.ToString();
            arhcimgmand = ARHCingmand.SelectedValue.ToString();
            arposimgmand = ARPOSimgMnad.SelectedValue.ToString();
            arpoimgmand = AROPimgMand.SelectedValue.ToString();
            archimgmand = ARCHimgMnad.SelectedValue.ToString();
            UIC = "0";
            PDCAmount = "0";
            CDays = txtCDays.Text.ToString();
            PT = ddPT.SelectedValue.ToString();
            noOfInv = txtnoInvoice.Text.ToString();
            IsVAT = ddIsVAT.SelectedValue.ToString();
            IsHold = ddlIsHold.SelectedValue.ToString();
            status = ddlstatus.SelectedValue.ToString();

            selectiontype = ddltype.SelectedValue.ToString();
            radius = txtradius.Text.ToString();
            oncall = OnCall();
            IsSO = ddIsSOrder.SelectedValue.ToString();
            IsInvoicing = ddlIsInvoicing.SelectedValue.ToString();
            IsI_Sales = ddIsI_Sales.SelectedValue.ToString();
            IsI_GR = ddIsI_GR.SelectedValue.ToString();
            IsI_BR = ddIsI_BR.SelectedValue.ToString();
            IsI_FG = ddIsI_FG.SelectedValue.ToString();
            IsAR = ddlIsAR.SelectedValue.ToString();
            advpay = ddladvpay.SelectedValue.ToString();
            IsMerchandising = ddIsMerchand.SelectedValue.ToString();
            IsAvtManage=ddlIsActManage.SelectedValue.ToString();
            IsCusService=ddlISCusService.SelectedValue.ToString();
            VoidEnable = ddVoidEnable.SelectedValue.ToString();
            RoundAmount = ddRoundAmount.SelectedValue.ToString();

            signatureinvoice = ddlSI.SelectedValue.ToString();
            signatureAR = ddSAR.SelectedValue.ToString();
            Remark = ddRe.SelectedValue.ToString();
            OrderReqR = ddORR.SelectedValue.ToString();
            Orderpro = ddlordpro.SelectedValue.ToString();
            FG = ddlFGExemption.SelectedValue.ToString();
            enforcecussel = ddlenforcecussel.SelectedValue.ToString();
            Salsign = ddlEnablesalsign.SelectedValue.ToString();
            Ordsign = ddlenableOrdrsign.SelectedValue.ToString();
            IsAttachmentOrder = ddlIsAttachmentsOrder.SelectedValue.ToString();
            FreeSampleOrder = ddlEnableFreeSampleOrder.SelectedValue.ToString();
            FreeSampleOrderApproval = ddlEnableFreeSampleOrderApproval.SelectedValue.ToString();
            InvMode = ddlInvoiceMode.SelectedValue.ToString();
            AltInvReq = rdAltInvReq.SelectedValue.ToString();
            FS=ddlFS.SelectedValue.ToString();
            Insight=ddlEnableInsight.SelectedValue.ToString();
            NegativeInvAmt=ddlnegativeInvAmt.SelectedValue.ToString();
            FSFeatures = FSFeature();
            MerchColumns = Mandcolumns();
            InsCusSettings = InsCusSetting();
            ActManage = ActivityManage();
            CusService = CustomerService();
            ActManageMand = ActivityManageMand();
            CusServiceMand = CustomerServiceMand();
            paymode = paytmodecolumns();
            Mandfeatures = Mandfeature();
            FGsep = ddlFGsep.SelectedValue.ToString();
            GraceAmount = txtGraceamount.Text.ToString();
            GracePeriod=txtGracePeriod.Text.ToString();
            string usr = UICommon.GetCurrentUserID().ToString();
            AlertDays=txtAlertDay.Text.ToString();
            CusDocExpiryAlert=ddlCusDocExpiryAlert.SelectedValue.ToString();
            EnableForecastSales = ddlEnableForecastSales.SelectedValue.ToString();
            EnableQuotation = ddlEnableQuotation.SelectedValue.ToString();
            EnableSuggestedOrd = ddlEnableSuggestedOrd.SelectedValue.ToString();
            IsPriceChange = ddlISPriceChange.SelectedValue.ToString();
            CusLocation = txtCusLocation.Text.ToString();
            MinOrderValue = rdMinOrderValue.Text.ToString();
            ARRemarks=ddARRemarks.SelectedValue.ToString();
            GRSettings = GRSettingsSL();
            BrSettings=BRSettingsSL();
            VoidEnableCusInsight =ddVoidEnableCusInsight.SelectedValue.ToString();
            EnableDelPriceChange = ddlDelPriceChange.SelectedValue.ToString();
            string pg = ddlproductgroup.SelectedValue.ToString();
            string[] ar = { cus, RouteID.ToString() };
            ARPayMode = ARPaymentMode();
            CouponPayMode = CouponPaymentMode();
            rcs_EnforceBuyBackfree = ddlEnforceBuyBackfree.SelectedValue.ToString();
            MustSell = ddlMustSellApproval.SelectedValue.ToString();
            InstDelivery = ddlInstDelivery.SelectedValue.ToString();
            SuggestedLoadReq = ddlSuggLoadReq.SelectedValue.ToString();
            CouponEnable = ddlISCouponEnable.SelectedValue.ToString();
            CurrentSecurityDeposit = txtCurrentSecDeposit.Text.ToString();
            fulldelivery=rdFulldelivery.SelectedValue.ToString();
            EnableLPONumber = ddlEnableLPONumber.SelectedValue.ToString();
            LPONumberMand = ddlLPONumberMand.SelectedValue.ToString();



            if ((cusType == "CS" && ResponseID.ToString() == "0")|| (cusType == "CS" && txtGraceamount.Text.ToString()==""))
            {
                TCL = "0";

                UIC = "0";
                PDCAmount = "0";
                CDays = "0";
                GraceAmount="0";
                
            }

            if ((cusType == "CS" && (ResponseID.ToString() != null || ResponseID.ToString() != "")))
            {
                TCL = "0";

                UIC = "0";
                PDCAmount = "0";
                CDays = "0";
                GraceAmount = "0";

            }

            if (IsInvoicing == "N")
            {
                IsI_Sales = "N";
                IsI_GR = "N";
                IsI_BR = "N";
                IsI_FG = "N";
            }

            if (ResponseID.Equals("0") || ResponseID == 0)
            {

                string[] arr = {   cus,cusType,TCL , CDays,PT,
                    noOfInv,IsVAT, IsHold,selectiontype,radius,
                    oncall,IsSO,IsInvoicing,IsI_Sales, IsI_GR,
                    IsI_BR, IsI_FG,IsAR,advpay,  IsMerchandising,
                    VoidEnable,  RoundAmount, signatureinvoice,signatureAR,
                    Remark,OrderReqR,Orderpro,FG ,status,
                    UIC, PDCAmount,custCategoryType,MerchColumns,paymode,
                    Mandfeatures,enforcecussel,Ordsign,Salsign,InvMode,AltInvReq,usr,FGsep,Insight,FS,FSFeatures,NegativeInvAmt,profile,
                    MinInvoiceValue,MustSellItemCount,IsArManualAllocation,GraceAmount,GracePeriod,PartialDelivery,PriceChange,OrdPriceChange,
                    eInvoice,CusDocExpiryAlert,AlertDays,invhcimgmand,invposimgmand,invopimgmand,arhcimgmand,arposimgmand,arpoimgmand,archimgmand,ActManage,CusService,
                    ActManageMand, CusServiceMand, IsAvtManage, IsCusService,EnableForecastSales, EnableQuotation, EnableSuggestedOrd,IsPriceChange , CusLocation,RecentSales,
                    RecentOrder,MinOrderValue,ARRemarks,GRSettings,BrSettings,VoidEnableCusInsight,EnableDelPriceChange,ARPayMode,rcs_EnforceBuyBackfree,MustSell, InstDelivery,
                    AttachmentsAR,IsAttachmentOrder,AttachmentInvoice,FreeSampleOrder,CouponPayMode,CurrentSecurityDeposit,FreeSampleOrderApproval,SuggestedLoadReq,CouponEnable,
                    InsCusSettings,fulldelivery,EnableLPONumber,LPONumberMand};

                string Value = ob.SaveData("sp_Merchandising", "InsertCusRoute", RouteID.ToString(), arr);
                
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    DataTable dt = ob.loadList("InsMappingProducts", "sp_Masters", pg,ar);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Route has been saved sucessfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Some Technical Exception are there kindly try again later');</script>", false);
                }
            }
            else
            {
                string id = ResponseID.ToString();
                string[] arr = { RouteID.ToString(), cus,cusType,TCL , CDays,PT,noOfInv,IsVAT, IsHold,selectiontype,radius,oncall,IsSO,IsInvoicing,IsI_Sales, IsI_GR, IsI_BR, IsI_FG,
                            IsAR,advpay,  IsMerchandising,   VoidEnable,  RoundAmount,signatureinvoice,signatureAR,Remark,OrderReqR,Orderpro,FG ,status,UIC,PDCAmount,custCategoryType,MerchColumns,paymode,Mandfeatures,enforcecussel,
                            Ordsign,Salsign,InvMode,AltInvReq,usr,FGsep,Insight,FS,FSFeatures,NegativeInvAmt,profile,
                    MinInvoiceValue, MustSellItemCount,IsArManualAllocation,GraceAmount,GracePeriod,PartialDelivery,PriceChange,OrdPriceChange,eInvoice,CusDocExpiryAlert,AlertDays,invhcimgmand,invposimgmand,
                    invopimgmand,arhcimgmand,arposimgmand,arpoimgmand,archimgmand,ActManage,CusService,ActManageMand, CusServiceMand, IsAvtManage, IsCusService,EnableForecastSales, 
                    EnableQuotation, EnableSuggestedOrd,IsPriceChange, CusLocation,RecentSales,RecentOrder,MinOrderValue,ARRemarks,GRSettings,BrSettings,VoidEnableCusInsight,
                    EnableDelPriceChange,ARPayMode,rcs_EnforceBuyBackfree,MustSell, InstDelivery,AttachmentsAR,IsAttachmentOrder,AttachmentInvoice,FreeSampleOrder,CouponPayMode,CurrentSecurityDeposit,
                    FreeSampleOrderApproval,SuggestedLoadReq,CouponEnable,InsCusSettings,fulldelivery,EnableLPONumber,LPONumberMand};
                string value = ob.SaveData("sp_Merchandising", "UpdateCusRoute", id, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    DataTable dt = ob.loadList("InsMappingProducts", "sp_Masters", pg, ar);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Route has been updated sucessfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Some Technical Exception are there kindly try again later');</script>", false);
                }
            }


        }
        public string OnCall()
        {
            string retStr = "";
            var checkedItems = ddloncal.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }

        public string FSFeature()
        {
            string retStr = "";
            var checkedItems = ddlFSFeatures.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            return retStr;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //string ID = ResponseID.ToString();

            //DataTable lstDatas = ob.loadList("EditCusRoute", "sp_Masters", ResponseID.ToString());
            //if (lstDatas.Rows.Count > 0)
            //{
            //    string UCL = lstDatas.Rows[0]["rcs_UsedCreditLimit"].ToString();
            //    string custype = ddcusType.SelectedValue.ToString();
            //    if (UCL == "")
            //    {
            //        UCL = "0";
            //    }
            //    decimal usedCL = Decimal.Parse(UCL.ToString());
            //    if (custype == "CS")
            //    {
            //        if (usedCL > 0)
            //        {
            //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Used Credit Limit is Greater than Zero ...Customer Type Canot be Cash');</script>", false);
            //        }
            //        else
            //        {
            //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            //        }

            //    }
            //    else
            //    {
            //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            //    }

            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            //}

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string ID = RouteID.ToString();
            Response.Redirect("ListCustomerRoute.aspx?RID=" + ID);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            string ID = RouteID.ToString();
            Response.Redirect("ListCustomerRoute.aspx?RID=" + ID);


        }

        protected void ddcusType_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string custype = ddcusType.SelectedValue.ToString();

            if (custype == "CS")
            {
                Custype.Visible = false;
                Paymodes.Visible = true;
            }
            else
            {
                Custype.Visible = true;
                Paymodes.Visible = false;
            }
            if (custype == "TC")
            {
                noofinvoice.Visible = true;
            }
            else
            {
                noofinvoice.Visible = false;
            }

            //from addedit customer

            DataTable dt = ob.loadList("SelectRouteType", "sp_Masters", RouteID.ToString());
            if (dt.Rows.Count > 0)
            {
              
                string rotType = dt.Rows[0]["rot_Type"].ToString();
                ViewState["RotType"] = rotType.ToString();

               
            }

            string RotTypes = ViewState["RotType"].ToString();
            if (RotTypes == "SL")
            {
                if (custype == "CS")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                  //  ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "N";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "Y";
                    ddlAttachmentInvoice.SelectedValue = "Y";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";
                   
                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    } 
                    
                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    

                }
                else if (custype == "CR")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                   // ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "N";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "N";
                    ddlPriceChange.SelectedValue = "Y";
                    ddleInvoice.SelectedValue = "Y";
                    ddlAttachmentInvoice.SelectedValue = "Y";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    


                }
                else if (custype == "TC")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                 //   ddPT.SelectedValue = "Y";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "N";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "N";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                }
                else
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                  //  ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "N";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "Y";
                    ddlAttachmentInvoice.SelectedValue = "Y";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }

                string InsCusSettings = "SL-OR-AP-AR";
                string[] InCus = InsCusSettings.Split('-');
                for (int i = 0; i < InCus.Length; i++)
                {
                    foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                    {
                        if (items.Value == InCus[i])
                        {
                            items.Checked = true;
                        }
                    }
                }

            }
            else if (RotTypes == "OR")
            {
                if (custype == "CS")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                   // ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "N";
                    ddSAR.SelectedValue = "N";
                    IsArManAllocation.SelectedValue = "N";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else if (custype == "CR")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                 //   ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "N";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "Y";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "N";
                    ddSAR.SelectedValue = "N";
                    IsArManAllocation.SelectedValue = "N";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else if (custype == "TC")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                 //   ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "N";
                    ddSAR.SelectedValue = "N";
                    IsArManAllocation.SelectedValue = "N";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                   // ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "N";
                    ddSAR.SelectedValue = "N";
                    IsArManAllocation.SelectedValue = "N";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
            }
            else if (RotTypes == "OA")
            {
                if (custype == "CS")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                  //  ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else if (custype == "CR")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                   // ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "N";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "Y";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else if (custype == "TC")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                  //  ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
                else
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                 //   ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "ODC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "Y";
                    ddlordpro.SelectedValue = "Y";
                    ddlenableOrdrsign.SelectedValue = "Y";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "N";
                    ddIsI_Sales.SelectedValue = "N";
                    ddIsI_GR.SelectedValue = "N";
                    ddIsI_BR.SelectedValue = "N";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "N";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "N";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "Y";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string CusService = "SRR";
                    string[] CusServiceArray = CusService.Split('-');
                    for (int i = 0; i < CusServiceArray.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlCusService.Items)
                        {
                            if (items.Value == CusServiceArray[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }
            }
            else
            {
                if (custype == "CS")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                 //   ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "Y";
                    ddlAttachmentInvoice.SelectedValue = "Y";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }



                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                }
                else if (custype == "CR")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                   // ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "N";
                    ddlPriceChange.SelectedValue = "Y";
                    ddleInvoice.SelectedValue = "Y";
                    ddlAttachmentInvoice.SelectedValue = "Y";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                }
                else if (custype == "TC")
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                 //   ddPT.SelectedValue = "Y";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings 
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "N";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "N";
                    ddlAttachmentInvoice.SelectedValue = "N";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                }
                else
                {
                    //Credit Terms
                    ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                 //   ddPT.SelectedValue = "N";
                    ddIsVAT.SelectedValue = "Y";
                    ddlIsHold.SelectedValue = "N";
                    ddlstatus.SelectedValue = "Y";

                    //General Settings
                    ddltype.SelectedValue = "M";
                    txtradius.Text = "100";
                    ddcatType.SelectedValue = "NC";
                    ddlenforcecussel.SelectedValue = "N";
                    ddlEnableInsight.SelectedValue = "Y";
                    ddVoidEnable.SelectedValue = "Y";
                    ddRoundAmount.SelectedValue = "N";
                    MustSellItmCnt.Text = "0";
                    ddlEnablePD.SelectedValue = "N";
                    ddlCusDocExpiryAlert.SelectedValue = "N";
                    txtAlertDay.Text = "0";
                    ddlISPriceChange.SelectedValue = "Y";
                    txtCurrentSecDeposit.Text = "0";

                    //Transactional Settings
                    ddIsSOrder.SelectedValue = "Y";
                    ddORR.SelectedValue = "N";
                    ddlordpro.SelectedValue = "N";
                    ddlenableOrdrsign.SelectedValue = "N";
                    ddlOrdPriceChange.SelectedValue = "N";
                    ddlEnableQuotation.SelectedValue = "N";
                    ddlEnableSuggestedOrd.SelectedValue = "N";

                    //Invoice
                    ddlIsInvoicing.SelectedValue = "Y";
                    ddIsI_Sales.SelectedValue = "Y";
                    ddIsI_GR.SelectedValue = "Y";
                    ddIsI_BR.SelectedValue = "Y";
                    ddIsI_FG.SelectedValue = "N";
                    rdAltInvReq.SelectedValue = "N";
                    ddlInvoiceMode.SelectedValue = "S";
                    ddlSI.SelectedValue = "Y";
                    ddRe.SelectedValue = "Y";
                    ddlEnablesalsign.SelectedValue = "Y";
                    ddlFGExemption.SelectedValue = "Y";
                    MinInvoiceVal.Text = "0";
                    ddlFGsep.SelectedValue = "N";
                    ddlnegativeInvAmt.SelectedValue = "Y";
                    ddlPriceChange.SelectedValue = "N";
                    ddleInvoice.SelectedValue = "Y";
                    ddlAttachmentInvoice.SelectedValue = "Y";
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";
                    ddlEnableLPONumber.SelectedValue = "Y";
                    ddlLPONumberMand.SelectedValue = "Y";

                    //Account Receivables
                    ddlIsAR.SelectedValue = "Y";
                    ddSAR.SelectedValue = "Y";
                    IsArManAllocation.SelectedValue = "Y";
                    ARHCingmand.SelectedValue = "0";
                    ARPOSimgMnad.SelectedValue = "0";
                    AROPimgMand.SelectedValue = "0";
                    ARCHimgMnad.SelectedValue = "0";
                    ddladvpay.SelectedValue = "N";

                    //Inventory Monitoring
                    ddIsMerchand.SelectedValue = "N";

                    //Activity Management
                    ddlIsActManage.SelectedValue = "N";

                    //Customer Service
                    ddlISCusService.SelectedValue = "N";

                    //Field Service
                    ddlFS.SelectedValue = "N";

                    string paymode = "HC";
                    string[] arpaym = paymode.Split('-');
                    for (int i = 0; i < arpaym.Length; i++)
                    {
                        foreach (RadComboBoxItem items in ddlpaymode.Items)
                        {
                            if (items.Value == arpaym[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string profile = "CDS-PRM-SPR-CIM-GCD-PTH-PTD";
                    string[] ary = profile.Split('-');
                    for (int i = 0; i < ary.Length; i++)
                    {
                        foreach (RadComboBoxItem items in CusProfile.Items)
                        {
                            if (items.Value == ary[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }
                    string ARPayMode = "HC-POS-OP";
                    string[] aryARPay = ARPayMode.Split('-');
                    for (int i = 0; i < aryARPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdARPayMode.Items)
                        {
                            if (items.Value == aryARPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                    string CouponPayMode = "HC-POS-OP";
                    string[] aryCPay = CouponPayMode.Split('-');
                    for (int i = 0; i < aryCPay.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdCouponPayMode.Items)
                        {
                            if (items.Value == aryCPay[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }


                    string InsCusSettings = "SL-OR-AP-AR";
                    string[] InCus = InsCusSettings.Split('-');
                    for (int i = 0; i < InCus.Length; i++)
                    {
                        foreach (RadComboBoxItem items in rdInsCusSetting.Items)
                        {
                            if (items.Value == InCus[i])
                            {
                                items.Checked = true;
                            }
                        }
                    }

                }

            }

            string invoice = ddlIsInvoicing.SelectedValue.ToString();
            if (invoice == "N")
            {
                inv.Visible = false;
                pnlSalesJob.Visible = false;
            }
            else
            {
                inv.Visible = true;
                pnlSalesJob.Visible = true;
            }

            string invoicing = ddcatType.SelectedValue.ToString();
            if (invoicing.Equals("ODC"))
            {
                //pnlSalesInv.Visible = false;
                ddIsI_Sales.Enabled = false;
            }
            else
            {
                //pnlSalesInv.Visible = true;
                ddIsI_Sales.Enabled = true;
            }
            if (invoicing.Equals("NC"))
            {
                plsSalesorder.Visible = false;
            }
            else
            {
                plsSalesorder.Visible = true;
                ddIsSOrder.Enabled = true;
            }

            string type = ddltype.SelectedValue.ToString();
            if (type.Equals("B"))
            {
                pnlFencing.Visible = false;
            }
            else
            {
                pnlFencing.Visible = true;
            }

            txtTCL.Enabled = true;

            if (ddPT.SelectedValue.Equals("N"))
            {
                Paymodes.Visible = false;
            }
            else
            {
                Paymodes.Visible = true;
                RequiredFieldValidator27.ValidationGroup = "form";
            }

            string FS = ddlFS.SelectedValue.ToString();
            if (FS.Equals("N"))
            {
                pnlFS.Visible = false;
            }
            else
            {
                pnlFS.Visible = true;
            }

            string ar = ddlIsAR.SelectedValue.ToString();
            if (ar.Equals("N"))
            {
                pnlAR.Visible = false;
            }
            else
            {
                pnlAR.Visible = true;
            }

            string merch = ddIsMerchand.SelectedValue.ToString();
            if (merch.Equals("N"))
            {
                pnlMandFeat.Visible = false;
            }
            else
            {
                pnlMandFeat.Visible = true;
            }

            string ActManage = ddlIsActManage.SelectedValue.ToString();
            if (ActManage.Equals("N"))
            {
                pnlActmanage.Visible = false;
            }
            else
            {
                pnlActmanage.Visible = true;
            }

            string merc = ddlISCusService.SelectedValue.ToString();
            if (merc.Equals("N"))
            {
                pnlCusService.Visible = false;
            }
            else
            {
                pnlCusService.Visible = true;
            }
        }

        protected void ddlIsInvoicing_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string invoice = ddlIsInvoicing.SelectedValue.ToString();
            if (invoice == "N")
            {
                inv.Visible = false;
                pnlSalesJob.Visible = false;
            }
            else
            {
                inv.Visible = true;
                pnlSalesJob.Visible = true;
            }
        }

        protected void ddltype_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string type = ddltype.SelectedValue.ToString();
            if (type.Equals("B"))
            {
                pnlFencing.Visible = false;
            }
            else
            {
                pnlFencing.Visible = true;
            }
        }

        protected void ddcatType_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string invoicing = ddcatType.SelectedValue.ToString();
            if (invoicing.Equals("ODC"))
            {
                //pnlSalesInv.Visible = false;
                ddIsI_Sales.Enabled = false;
            }
            else
            {
                //pnlSalesInv.Visible = true;
                ddIsI_Sales.Enabled = true;
            }
            if (invoicing.Equals("NC"))
            {
                plsSalesorder.Visible = false;
            }
            else
            {
                plsSalesorder.Visible = true;
                ddIsSOrder.Enabled = true;
            }

        }

        protected void ddIsMerchand_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string merch = ddIsMerchand.SelectedValue.ToString();
            if (merch.Equals("N"))
            {
                pnlMandFeat.Visible = false;
            }
            else
            {
                pnlMandFeat.Visible = true;
            }
        }

        protected void ddlIsAR_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string ar = ddlIsAR.SelectedValue.ToString();
            if (ar.Equals("N"))
            {
                pnlAR.Visible = false;
            }
            else
            {
                pnlAR.Visible = true;
            }
        }

        protected void ddPT_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            if (ddPT.SelectedValue.Equals("N"))
            {
                Paymodes.Visible = false;
            }
            else
            {
                Paymodes.Visible = true;
                RequiredFieldValidator27.ValidationGroup = "form";
            }
        }

        protected void ddlcus_TextChanged(object sender, EventArgs e)
        {

        }

        protected void lnkSearch_Click(object sender, EventArgs e)
        {
            CustomerLike();
        }

        protected void ddlFS_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string FS = ddlFS.SelectedValue.ToString();
            if (FS.Equals("N"))
            {
                pnlFS.Visible = false;
            }
            else
            {
                pnlFS.Visible = true;
            }
        }

        protected void ddlIsActManage_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string merch = ddlIsActManage.SelectedValue.ToString();
            if (merch.Equals("N"))
            {
                pnlActmanage.Visible = false;
            }
            else
            {
                pnlActmanage.Visible = true;
            }
        }

        protected void ddlISCusService_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string merch = ddlISCusService.SelectedValue.ToString();
            if (merch.Equals("N"))
            {
                pnlCusService.Visible = false;
            }
            else
            {
                pnlCusService.Visible = true;
            }
        }

        protected void Itemmap_Click(object sender, EventArgs e)
        {
            string RID = RouteID.ToString();
            string CusID = ddlcus.SelectedValue.ToString();
            string CID = ResponseID.ToString();
            
            Response.Redirect("ListCustomerProductsMapping.aspx?CID=" + CID + "&RID=" + RID + "&cusID=" + CusID);
        }

        protected void Proceedmap_Click(object sender, EventArgs e)
        {
            string RID = RouteID.ToString();
            string CusID = ddlcus.SelectedValue.ToString();
            string CID = ResponseID.ToString();

            Response.Redirect("ListCustomerProductsMapping.aspx?CID=" + CID + "&RID=" + RID + "&cusID=" + CusID);
        }

        protected void lnkGotoCus_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");
        }

        protected void btnspclpriceassign_Click(object sender, EventArgs e)
        {
            string CUID = ResponseID.ToString();
            string RTID = RouteID.ToString();
            Response.Redirect("ListCustomerSplPriceData.aspx?CUID=" + CUID + "&RTID=" + RTID);
        }

        public void ProductMappingGroup()
        {
            try
            {
                string rotId = RouteID.ToString();
                string cus = ddlcus.SelectedValue.ToString();

                DataTable dts = ob.loadList("SelectPMGnameforCustomerRoute", "sp_Masters");

                if (cus != "")
                {
                    string[] ar = { rotId };
                    DataTable dt = ob.loadList("SelProductGroup", "sp_Masters", cus, ar);

                    // Create a new DataTable to combine dt and dts without duplicates
                    DataTable combinedDt = dts.Clone(); // Clone structure of dts
                    HashSet<string> uniqueEntries = new HashSet<string>();

                    // Add rows from dt to combinedDt
                    foreach (DataRow row in dt.Rows)
                    {
                        string pmgId = row["pmg_ID"].ToString();
                        if (uniqueEntries.Add(pmgId))
                        {
                            combinedDt.ImportRow(row);
                        }
                    }

                    // Add rows from dts to combinedDt
                    foreach (DataRow row in dts.Rows)
                    {
                        string pmgId = row["pmg_ID"].ToString();
                        if (uniqueEntries.Add(pmgId))
                        {
                            combinedDt.ImportRow(row);
                        }
                    }

                    ddlproductgroup.DataSource = combinedDt;
                }
                else
                {
                    ddlproductgroup.DataSource = dts;
                }

                ddlproductgroup.DataTextField = "pmg_Name";
                ddlproductgroup.DataValueField = "pmg_ID";
                ddlproductgroup.DataBind();

                if (ddlproductgroup.Items.Count > 0)
                {
                    ddlproductgroup.SelectedIndex = 0;
                }
            }
            catch(Exception ex)
            {

            }
           
        }

        protected void ddlcus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ProductMappingGroup();
        }


        protected void ApplyProfile_Click(object sender, EventArgs e)
        {
            try
            {
                string pfh_Id = rdProfile.SelectedValue.ToString();
                if (!string.IsNullOrEmpty(pfh_Id))
                {
                    DataTable dt = ob.loadList("ProdileDetailforMasterForms", "sp_ProfileSettings", pfh_Id);
                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            string controlId = dr["pfd_ControlId"].ToString();
                            string controlValues = dr["pfd_Values"].ToString();
                            string controlType = dr["pfd_Type"].ToString();
                            SetControlValues(controlId, controlValues, controlType);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
        }

        private void SetControlValues(string controlId, string controlValues, string controlType)
        {
            System.Web.UI.Control control = FindControlRecursive(Page, controlId);
            if (control != null)
            {
                if (controlType == "S")
                {
                    if (control is RadDropDownList radDropDownList)
                    {
                        SetRadDropDownListSingleValue(radDropDownList, controlValues);
                    }
                }
                else if (controlType == "M")
                {
                    if (control is RadComboBox radComboBox)
                    {
                        SetRadComboBoxMultipleValues(radComboBox, controlValues);
                    }
                }
                else if (controlType == "T")
                {
                    if (control is RadTextBox radTextBox)
                    {
                        radTextBox.Text = controlValues;
                    }
                }
                else if (controlType == "N")
                {
                    if (control is RadNumericTextBox radTextBox)
                    {
                        radTextBox.Text = controlValues;
                    }
                }
            }
        }

        private void SetRadDropDownListSingleValue(RadDropDownList rd, string controlValue)
        {
            rd.ClearSelection();
            rd.SelectedValue = controlValue.ToString();

            //TriggerSelectedIndexChanged(rd);


        }

        private void SetRadComboBoxMultipleValues(RadComboBox radComboBox, string controlValues)
        {
            radComboBox.ClearSelection();
            string[] values = controlValues.Split('-');

            foreach (RadComboBoxItem items in radComboBox.Items)
            {
                items.Checked = false;
            }

            foreach (string value in values)
            {
                RadComboBoxItem item = radComboBox.Items.FindItemByValue(value);
                if (item != null)
                {
                    item.Checked = true;
                }
            }
        }

        private System.Web.UI.Control FindControlRecursive(System.Web.UI.Control root, string id)
        {
            if (root.ID == id)
            {
                return root;
            }

            foreach (System.Web.UI.Control child in root.Controls)
            {
                System.Web.UI.Control found = FindControlRecursive(child, id);
                if (found != null)
                {
                    return found;
                }
            }

            return null;

        }
        public void Profile()
        {

            DataTable lstVehicle = ob.loadList("SelProfileHeaderforDropDown", "sp_ProfileSettings", "tb_CustomerRoute");
            if (lstVehicle.Rows.Count > 0)
            {
                rdProfile.DataSource = lstVehicle;
                rdProfile.DataValueField = "pfh_ID";
                rdProfile.DataTextField = "pfh_ProfileName";
                rdProfile.DataBind();

            }
        }

        
    }
}