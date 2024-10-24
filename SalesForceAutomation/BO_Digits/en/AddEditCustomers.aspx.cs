using ExcelLibrary.BinaryFileFormat;
using GoogleApi.Entities.Maps.Directions.Response;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{    
    public partial class AddEditCustomers : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["mode"], out Mode);

                return Mode;
            }
        }

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {


          
            if (!Page.IsPostBack)
            {
                // Session.Clear();

                Session["Routemapping"] = "";
                Area();
                Class();
                CustomerHeader();
                Paymode();

                // Route();
                // List();
                Pricelist();
                company();



            //  Routes();
            rdFromData.SelectedDate = DateTime.Now;
                rdEndDate.SelectedDate = DateTime.Now;
                rdEndDate.MinDate = DateTime.Now;
                rdFromData.MinDate = DateTime.Now;

                try
                {
                    if (Session["ActiveStepIndex"] != null)
                    {
                        int stepIndex = (int)Session["ActiveStepIndex"];
                        RadWizard1.ActiveStepIndex = stepIndex;

                        // Clear the session variable if no longer needed
                        Session.Remove("ActiveStepIndex");
                    }
                }
                catch(Exception ex)
                {

                }


                RadWizard1.NavigationBarPosition = (RadWizardNavigationBarPosition)Enum.Parse(typeof(RadWizardNavigationBarPosition), "Top");
                RadWizard1.ProgressBarPosition = (RadWizardProgressBarPosition)Enum.Parse(typeof(RadWizardProgressBarPosition), "Top");





            }
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlCusCom.DataSource = dt;
            ddlCusCom.DataTextField = "com_Name";
            ddlCusCom.DataValueField = "com_Code";
            ddlCusCom.DataBind();
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtCode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckCustomerCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
              //  LinkSave.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
               // LinkSave.Enabled = true;
                lblCodeDupli.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "focusNext", "focusNextTextbox();", true);
            }
        }

        protected void ddlcustype_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            string cusType = ddlcustype.SelectedValue.ToString();
            if (cusType == "NC")
            {

                pnlCusHead.Visible = false;
                lblTRN.Visible = true;
               // PlaceHolder2.Visible = true;
            }
            else
            {
                //  PlaceHolder2.Visible = false;
                lblTRN.Visible = false;
                pnlCusHead.Visible = true;
                CustomerHeader();
            }
        }


        public void Area()
        {
            DataTable dt = ObjclsFrms.loadList("SelectFromAreaByID", "sp_Masters");
            ddlarea.DataSource = dt;
            ddlarea.DataTextField = "are_Name";
            ddlarea.DataValueField = "are_ID";
            ddlarea.DataBind();
        }

        //public void Route()
        //{
        //    DataTable dt = ObjclsFrms.loadList("SelectRoutes", "sp_Masters");
        //    ddlrot.DataSource = dt;
        //    ddlrot.DataTextField = "rot_Name";
        //    ddlrot.DataValueField = "rot_ID";
        //    ddlrot.DataBind();
        //}

        public void Class()
        {
            DataTable dt = ObjclsFrms.loadList("SelectFromClassByID", "sp_Masters");
            ddlcls.DataSource = dt;
            ddlcls.DataTextField = "cls_Name";
            ddlcls.DataValueField = "cls_ID";
            ddlcls.DataBind();
        }

        protected void ddcusType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {

            Paymode();

            DataTable dtt = ObjclsFrms.loadList("SelectRouteType", "sp_Masters", ddlrot.SelectedValue.ToString());

            if (dtt != null && dtt.Rows.Count > 0)
            {
                object routeTypeValue = dtt.Rows[0]["RouteType"];
                if (routeTypeValue != null && routeTypeValue != DBNull.Value)
                {
                    String RouteType = routeTypeValue.ToString();
                    RotType.Text = RouteType;
                }
                else
                {
                    // Handle the case where RouteType is null or DBNull
                    RotType.Text = "No Route Type"; // You can set it to an appropriate default value or message
                }
            }
            else
            {
                // Handle the case where the DataTable is null or has no rows
                RotType.Text = "No Data"; // You can set it to an appropriate default value or message
            }

            // RouteLike();
            ProductMappingGroup();
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

            string RoutID = ddlrot.SelectedValue.ToString();

            DataTable dt = ObjclsFrms.loadList("SelectRouteType", "sp_Masters", RoutID);
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
                   // ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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


                }
                else if (custype == "CR")
                {
                    //Credit Terms
                    //ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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


                }
                else if (custype == "TC")
                {
                    //Credit Terms
                   // ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "Y";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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


                }


            }
            else if (RotTypes == "OR")
            {
                if (custype == "CS")
                {
                    //Credit Terms
                   // ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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
                }
                else if (custype == "CR")
                {
                    //Credit Terms
                  //  ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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
                }
                else if (custype == "TC")
                {
                    //Credit Terms
                  //  ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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
                }
            }
            else if (RotTypes == "OA")
            {
                if (custype == "CS")
                {
                    //Credit Terms
                   // ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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
                }
                else if (custype == "CR")
                {
                    //Credit Terms
                   // ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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
                }
                else if (custype == "TC")
                {
                    //Credit Terms
                    //ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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
                }
            }
            else
            {
                if (custype == "CS")
                {
                    //Credit Terms
                    //ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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

                }
                else if (custype == "CR")
                {
                    //Credit Terms
                    //ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "N";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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

                }
                else if (custype == "TC")
                {
                    //Credit Terms
                   // ddlcus.Enabled = false;
                    txtGraceamount.Text = "0";
                    txtGracePeriod.Text = "0";
                    ddPT.SelectedValue = "Y";
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
                    HCimgMand.SelectedValue = "0";
                    POSimgMand.SelectedValue = "0";
                    OPimgMand.SelectedValue = "0";
                    ddlEnableForecastSales.SelectedValue = "N";

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

        protected void ddPT_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            if (ddPT.SelectedValue.Equals("N"))
            {
                Paymodes.Visible = false;
            }
            else
            {
                Paymodes.Visible = true;
                RequiredFieldValidator27.ValidationGroup = "form";
                Paymodes1();
            }
        }

        protected void ddltype_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void ddcatType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void ddlproductgroup_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void ddlIsInvoicing_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void ddlIsAR_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void ddIsMerchand_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void ddlIsActManage_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void ddlISCusService_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void ddlFS_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
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

        protected void lnkSearch_Click(object sender, EventArgs e)
        {

        }

      

        protected void Save()

        {
            string name, code, shortname, total, used, creditdays, addres, vat, phe, email, geo, area, cls, status, nameArabic, addressArabic, shortnameArabic,
            custype, whatsapp, cntctperson, cntctpersonAR, recaptureGeo, AltHOCOde, EnableInvoiceApproval, TRN, cusHead,company;


            name = txtName.Text.ToString();
            code = txtCode.Text.ToString();
            ViewState["Name"] = name.ToString();
            ViewState["Code"] = code.ToString();

            shortname = txtShortName.Text.ToString();
            total = "0.00";
            used = "0.00";
            creditdays = "";
            whatsapp = txtwhatsNo.Text.ToString();
            cntctperson = txtContactPerson.Text.ToString();
            cntctpersonAR = txtARcontactPerson.Text.ToString();
            recaptureGeo = ddlRecapture.SelectedValue.ToString();
            AltHOCOde = txtAltHOCode.Text.ToString();
            EnableInvoiceApproval = EnableInvAppr.SelectedValue.ToString();


            //if (txtTotCrLimit.Text == "")
            //{
            //    total = "0.00";
            //}
            //else
            //{
            //    total = txtTotCrLimit.Text.ToString();
            //}
            //if (txtUsdCrdLimits.Text == "")
            //{
            //    used = "0.00";
            //}
            //else
            //{
            //    used = txtUsdCrdLimits.Text.ToString();
            //}
            //creditdays = txtCrdDayy.Text.ToString();
            vat = "";
            addres = txtad.Text.ToString();
            email = txtEmail.Text.ToString();
            //vat = ddlvat.SelectedValue.ToString();
            phe = txtPerson.Text.ToString();
            geo = txtGeoLoc.Text.ToString();
            area = ddlarea.SelectedValue.ToString();
            cls = ddlcls.SelectedValue.ToString();
            status = ddlStatuses.SelectedValue.ToString();
            nameArabic = txtArabName.Text.ToString();
            //shortnameArabic = txtArabShortName.Text.ToString();
            shortnameArabic = "";
            addressArabic = txtArabAddress.Text.ToString();
            custype = ddlcustype.SelectedValue.ToString();
            TRN = txtTRN.Text.ToString();
            company = ddlCusCom.SelectedValue.ToString();
            string user = UICommon.GetCurrentUserID().ToString();
            string CloseStatus = rblStatus.SelectedValue;

            if (string.IsNullOrEmpty(CloseStatus))
            {
                CloseStatus = "N";
            }

            if (custype == "NC")
            {

                cusHead = "0";
            }
            else
            {

                cusHead = ddlCusHeader.SelectedValue.ToString();
            }

            string ID = "";//= ResponseID.ToString();

            try
            {
                if (Session["CusID"] != null)
                {
                    ID = Session["CusID"].ToString();
                }

            }
            catch
            {

            }


            if (ID == "0"  || ID == "")
            {
                try
                {
                    ViewState["Value"] = "";
                    string[] arr = {code,shortname,total, used,creditdays, addres, email, vat,phe, geo, area,cls, status, 
                        nameArabic,shortnameArabic, addressArabic,custype,whatsapp, cntctperson, cntctpersonAR, recaptureGeo,AltHOCOde,
                        EnableInvoiceApproval, cusHead, TRN,  user, CloseStatus,  company   };

                    string Value = ObjclsFrms.SaveData("sp_Masters", "InsertCustomer", name, arr);
                    ViewState["Value"] = Value.ToString();

                    int res = Int32.Parse(Value.ToString());
                    Session["CusID"] = res;
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess3('Customer Inserted Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditCustomer.aspx Save()", "Error : " + ex.Message.ToString() + " - " + innerMessage + "Value:" + ViewState["Value"].ToString());

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('" + ViewState["Value"].ToString() + "');</script>", false);
                }
            }
            else
            {
                try
                {
                    string id = ID;
                    string[] arr = { code, shortname, total, used, creditdays, addres, email, vat, phe, geo, area, cls, status, nameArabic, shortnameArabic, addressArabic, id,
                    custype, whatsapp, cntctperson, cntctpersonAR,recaptureGeo,AltHOCOde,EnableInvoiceApproval , cusHead ,TRN, user,CloseStatus,company};
                    string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCustomer", name, arr);
                    int res = Int32.Parse(Value.ToString());
                    Session["CusID"] = id;
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess3('Customer Updated Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditCustomer.aspx Save()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }

            }


        }
           
        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnDone_Click1(object sender, EventArgs e)
        {
            //if (lblTRN.Visible == true)
            //{

            //   // lblTRN.Text = "Please enter TRN Number";
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);

            //}
            //else
            //{
            //    // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            //    Save();
            //}
            //if (ddlcustype.SelectedValue == "NC" && string.IsNullOrWhiteSpace(txtTRN.Text))
            //{
            //    // Show alert
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure1();</script>", false);
            //}
            //else if (Session["CustomerType"] != null && Session["CustomerType"].ToString() == "NC" && string.IsNullOrWhiteSpace(txtTRN.Text))
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure1();</script>", false);

            //}
            //else
            //{
               ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

                // Call the Save method
                  //  Save();

               // Session.Remove("CustomerType");
           // }
        }

        protected void OK_Click(object sender, EventArgs e)
        {
            RadWizardStep step = RadWizard1.FindControl("splprice") as RadWizardStep;
            if (step != null)
            {
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                Session["ActiveStepIndex"] = stepIndex;

                // Register JavaScript to hide the modal and reload the page
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalAndReload", "hideModalAndReload();", true);
            }
        }

      



        public void RouteLike()
        {
          


            if (Session["CusID"] != null)
            {
                int CusId;
                if (int.TryParse(Session["CusID"].ToString(), out CusId))
                {
                    // Convert RouteId to string before passing to loadList method
                    DataTable ds = ObjclsFrms.loadList("SelectRouteIsNotMapped", "sp_Masters", CusId.ToString());
                    ddlrot.DataSource = ds;
                    ddlrot.DataTextField = "rot_Name";
                    ddlrot.DataValueField = "rot_ID";
                    ddlrot.DataBind();


                }
            }

        }


        public void RouteMapped()
        {



         
                    // Convert RouteId to string before passing to loadList method
                    DataTable ds = ObjclsFrms.loadList("SelectRouteForMappingCustomer", "sp_Masters");
                    ddlrot.DataSource = ds;
                    ddlrot.DataTextField = "rot_Name";
                    ddlrot.DataValueField = "rot_ID";
                    ddlrot.DataBind();


                
            

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
        public void SaveData()
        {
            string rot, cus, IsInvoicing, IsSO, IsMerchandising, IsAR, IsI_Sales, IsI_GR, IsI_BR, IsI_FG, TCL, CDays, VoidEnable, PT, RoundAmount, UIC, PDCAmount, custCategoryType,
            IsVAT, IsPO, cusType, signatureinvoice, Remark, signatureAR, selectiontype, radius, Orderpro, IsHold, oncall, noOfInv, advpay, FG, OrderReqR, status, MerchColumns, paymode, Mandfeatures, enforcecussel,
            Salsign, Ordsign, InvMode, AltInvReq, FGsep, Insight, FS, FSFeatures, NegativeInvAmt, profile, MinInvoiceValue, MustSellItemCount, IsArManualAllocation, GraceAmount, GracePeriod, PartialDelivery, PriceChange,
            OrdPriceChange, eInvoice, AlertDays, CusDocExpiryAlert, invhcimgmand, invposimgmand, invopimgmand, arhcimgmand, arposimgmand, arpoimgmand, archimgmand, ActManage, CusService,
            ActManageMand, CusServiceMand, IsAvtManage, IsCusService, EnableForecastSales, EnableQuotation, EnableSuggestedOrd, IsPriceChange, CusLocation, RecentSales, RecentOrder, MinOrderValue,
            ARRemarks, GRSettings, BrSettings, VoidEnableCusInsight, EnableDelPriceChange, ARPayMode, rcs_EnforceBuyBackFree,MustSell, InstDelivery, AttachmentsAR, IsAttachmentOrder, AttachmentInvoice, FreeSampleOrder,
            CouponPayMode, CurrentSecurityDeposit, FreeSampleOrderApproval, SuggestedLoadReq, CouponEnable, InsCusSettings, fulldelivery, EnableLPONumber, LPONumberMand, ResRtnSameItmInvoice, EnableCashDeposit, EnableReturnRequestBatch;


            GracePeriod = "0";
            GraceAmount = "0";
            profile = CusProfileSettings();
            rot = ddlrot.SelectedValue.ToString();
            Session["RotID"] = rot;

            cus = Session["CusID"].ToString();
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
            IsAvtManage = ddlIsActManage.SelectedValue.ToString();
            IsCusService = ddlISCusService.SelectedValue.ToString();
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
            FS = ddlFS.SelectedValue.ToString();
            Insight = ddlEnableInsight.SelectedValue.ToString();
            NegativeInvAmt = ddlnegativeInvAmt.SelectedValue.ToString();
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
            GracePeriod = txtGracePeriod.Text.ToString();
            string usr = UICommon.GetCurrentUserID().ToString();
            AlertDays = txtAlertDay.Text.ToString();
            CusDocExpiryAlert = ddlCusDocExpiryAlert.SelectedValue.ToString();
            EnableForecastSales = ddlEnableForecastSales.SelectedValue.ToString();
            EnableQuotation = ddlEnableQuotation.SelectedValue.ToString();
            EnableSuggestedOrd = ddlEnableSuggestedOrd.SelectedValue.ToString();
            IsPriceChange = ddlISPriceChange.SelectedValue.ToString();
            CusLocation = txtCusLocation.Text.ToString();
            MinOrderValue = rdMinOrderValue.Text.ToString();
            ARRemarks = ddARRemarks.SelectedValue.ToString();
            GRSettings = GRSettingsSL();
            BrSettings = BRSettingsSL();
            VoidEnableCusInsight = ddVoidEnableCusInsight.SelectedValue.ToString();
            EnableDelPriceChange = ddlDelPriceChange.SelectedValue.ToString();

            string productgroup = ddlproductgroup.SelectedValue.ToString();
            ARPayMode = ARPaymentMode();
            CouponPayMode = CouponPaymentMode();
            rcs_EnforceBuyBackFree = ddlEnforceBuyBackfree.SelectedValue.ToString();
            MustSell = ddlMustSellApproval.SelectedValue.ToString();
            InstDelivery = ddlInstDelivery.SelectedValue.ToString();
            SuggestedLoadReq = ddlSuggLoadReq.SelectedValue.ToString();
            CouponEnable = ddlISCouponEnable.SelectedValue.ToString();
            CurrentSecurityDeposit = txtCurrentSecDeposit.Text.ToString();
            fulldelivery = rdFulldelivery.SelectedValue.ToString();
            EnableLPONumber = ddlEnableLPONumber.SelectedValue.ToString();
            LPONumberMand = ddlLPONumberMand.SelectedValue.ToString();
            ResRtnSameItmInvoice = ddlRestrictedRtnSameItmInvoice.SelectedValue.ToString();
            EnableCashDeposit = ddlEnableCD.SelectedValue.ToString();

            EnableReturnRequestBatch = ddlEnableRtnReqBatch.SelectedValue.ToString();
            if ((cusType == "CS" && Session["CusID"].ToString() == "0") || (cusType == "CS" && txtGraceamount.Text.ToString() == ""))
            {
                TCL = "0";

                UIC = "0";
                PDCAmount = "0";
                CDays = "0";
                GraceAmount = "0";

            }

            if ((cusType == "CS" && (Session["CusID"].ToString() != null || Session["CusID"].ToString() != "")))
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

            string CusID = Session["C1"] as string;
            string RotID = Session["R1"] as string;


            if (string.IsNullOrEmpty(CusID) || CusID == "0")
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
                    ActManageMand, CusServiceMand, IsAvtManage, IsCusService,EnableForecastSales, EnableQuotation, EnableSuggestedOrd,IsPriceChange , CusLocation,RecentSales,RecentOrder,MinOrderValue,ARRemarks,GRSettings,BrSettings,VoidEnableCusInsight,EnableDelPriceChange,ARPayMode,rcs_EnforceBuyBackFree,
                    MustSell, InstDelivery, AttachmentsAR, IsAttachmentOrder, AttachmentInvoice, FreeSampleOrder,CouponPayMode, CurrentSecurityDeposit, FreeSampleOrderApproval, SuggestedLoadReq, CouponEnable, InsCusSettings, fulldelivery, EnableLPONumber, LPONumberMand,ResRtnSameItmInvoice,EnableCashDeposit,EnableReturnRequestBatch};
                string[] array = { cus, ddlrot.SelectedValue.ToString() };

                string Value = ObjclsFrms.SaveData("sp_Merchandising", "InsertCusRoute", rot, arr);
                int res = Int32.Parse(Value.ToString());
                Session["rcsID"] = res;

               // ViewState["Routemapping"] = "Yes";

                Session["Routemapping"] = "Yes";

                if (res > 0)
                {
                    DataTable dt = ObjclsFrms.loadList("InsMappingProducts", "sp_Masters", productgroup, array);

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess9('Customer Route has been saved sucessfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Some Technical Exception are there kindly try again later');</script>", false);
                }
            }
            else
            {
                string id = CusID.ToString();
                string[] arr = { RotID.ToString(), cus,cusType,TCL , CDays,PT,noOfInv,IsVAT, IsHold,selectiontype,radius,oncall,IsSO,IsInvoicing,IsI_Sales, IsI_GR, IsI_BR, IsI_FG,
                            IsAR,advpay,  IsMerchandising,   VoidEnable,  RoundAmount,signatureinvoice,signatureAR,Remark,OrderReqR,Orderpro,FG ,status,UIC,PDCAmount,custCategoryType,MerchColumns,paymode,Mandfeatures,enforcecussel,
                            Ordsign,Salsign,InvMode,AltInvReq,usr,FGsep,Insight,FS,FSFeatures,NegativeInvAmt,profile,
                    MinInvoiceValue, MustSellItemCount,IsArManualAllocation,GraceAmount,GracePeriod,PartialDelivery,PriceChange,OrdPriceChange,eInvoice,CusDocExpiryAlert,AlertDays,invhcimgmand,invposimgmand,
                    invopimgmand,arhcimgmand,arposimgmand,arpoimgmand,archimgmand,ActManage,CusService,ActManageMand, CusServiceMand, IsAvtManage, IsCusService,EnableForecastSales,
                    EnableQuotation, EnableSuggestedOrd,IsPriceChange, CusLocation,RecentSales,RecentOrder,MinOrderValue,ARRemarks,GRSettings,BrSettings,VoidEnableCusInsight,EnableDelPriceChange,ARPayMode,rcs_EnforceBuyBackFree,
                     MustSell, InstDelivery, AttachmentsAR, IsAttachmentOrder, AttachmentInvoice, FreeSampleOrder,CouponPayMode, CurrentSecurityDeposit, FreeSampleOrderApproval, SuggestedLoadReq, CouponEnable, InsCusSettings, fulldelivery, EnableLPONumber, LPONumberMand,ResRtnSameItmInvoice,EnableCashDeposit,EnableReturnRequestBatch};
            
                string value = ObjclsFrms.SaveData("sp_Merchandising", "UpdateCusRoute", id, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    DataTable dt = ObjclsFrms.loadList("InsMappingProducts", "sp_Masters", productgroup, arr);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess9('Customer Route has been updated sucessfully');</script>", false);
                    Session.Remove("C1");
                    Session.Remove("R1");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Some Technical Exception are there kindly try again later');</script>", false);
                }
            }
            


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
        protected void RouCuSave_Click(object sender, EventArgs e)
        {
            //SaveData();

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confimroute();</script>", false);

        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            //List();
        }
        public void List()
        {
            if (Session["CusID"] != null)
            {
                int CusId;
                if (int.TryParse(Session["CusID"].ToString(), out CusId))
                {
                    DataTable lstUser = ObjclsFrms.loadList("ListRouteOfCustomer", "sp_Masters", CusId.ToString());
                    if (lstUser.Rows.Count > 0)
                    {
                        grvRpt.DataSource = lstUser;

                        // Check for null or DBNull value before assigning to RCSID
                        string RCSID = lstUser.Rows[0]["rcs_ID"] != DBNull.Value ? lstUser.Rows[0]["rcs_ID"].ToString() : null;

                        if (!string.IsNullOrEmpty(RCSID))
                        {
                            Session["rcsID"] = RCSID;
                        }
                    }

                    DataTable lst = ObjclsFrms.loadList("CustomerBYid", "sp_Masters", CusId.ToString());
                    if (lst != null && lst.Rows.Count > 0)
                    {
                        Label1.Text = lst.Rows[0]["cus_Code"].ToString();
                        lblcustomer.Text = lst.Rows[0]["cus_Name"].ToString();
                    }
                }
            }
        }

        public string Res()
        {
            var CollectionMarket = rdRoute1.CheckedItems;
            string ResID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        ResID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        ResID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        ResID += item.Value;
                    }
                    j++;
                }
                return ResID;
            }
            else
            {
                return "crp_rcs_ID";
            }
        }

        public string mainConditions()
        {

            string Rcs = Res();

            string mainCondition = "";
            string ResCondition = "";

            try
            {

              
                if (Rcs.Equals("0"))
                {
                    ResCondition = "";
                }
                else
                {
                    ResCondition = " crp_rcs_ID  in (" + Rcs + ")";
                }



            }
            catch (Exception ex)
            {

            }

            mainCondition += ResCondition;

            return mainCondition;
        }
        public void ListSpecialPrice()
        {
            string rotcus = Session["CusID"] as string;

            if (string.IsNullOrEmpty(rotcus))
            {
                
                return;
            }

            try
            {
                DataTable lstUser = ObjclsFrms.loadList("ListCusRouteProductes", "sp_Masters_UOM", rotcus);

                if (lstUser == null)
                {
                    lstUser = new DataTable(); 
                }

                RadGrid1.DataSource = lstUser;
                RadGrid1.DataBind(); 
            }
            catch (Exception ex)
            {
                
            }
        }



        protected void Add_Click(object sender, EventArgs e)
        {

            RadWizardStep step = RadWizard1.FindControl("Routemapping") as RadWizardStep;
            if (step != null)
            {

                ClearControls(step);
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                  Session["ActiveStepIndex"] = stepIndex;

               // Session["IsAddClicked"] = true;

                // Reload the page to apply the stored active step index
                Response.Redirect(Request.RawUrl);
            }


        }
        private void ClearControls(Control parent)
        {
            foreach (Control control in parent.Controls)
            {
                if (control is RadComboBox radComboBox)
                {
                    radComboBox.ClearSelection();
                    radComboBox.Text = string.Empty;
                }
                else if (control is RadTextBox radTextBox)
                {
                    radTextBox.Text = string.Empty;
                }
                else if (control is RadNumericTextBox radNumericTextBox)
                {
                    radNumericTextBox.Value = null;
                }
                else if (control is DropDownList dropDownList)
                {
                    dropDownList.ClearSelection();
                }
                else if (control is TextBox textBox)
                {
                    textBox.Text = string.Empty;
                }
                else if (control is CheckBox checkBox)
                {
                    checkBox.Checked = false;
                }
                else if (control is RadioButton radioButton)
                {
                    radioButton.Checked = false;
                }
                else if (control is Label label)
                {
                    label.Text = string.Empty;
                }
                else if (control.HasControls())
                {
                    ClearControls(control);
                }
            }
        }




        //public void Paymode()
        //{
        //    string RotID = Session["R1"] as string;

        //    DataTable dt = ObjclsFrms.loadList("selPaymode", "sp_Masters", RotID.ToString());
        //    ddlpaymode.DataSource = dt;
        //    ddlpaymode.DataTextField = "Data";
        //    ddlpaymode.DataValueField = "Data";
        //    ddlpaymode.DataBind();

        //}

        public void Paymode()
        {
            // Check if the session variable is null
         

         // Load the data
                DataTable dt = ObjclsFrms.loadList("selPaymode", "sp_Masters", ddlrot.SelectedValue.ToString());

               

                // Bind the data to the dropdown list
                ddlpaymode.DataSource = dt;
                ddlpaymode.DataTextField = "Data";
                ddlpaymode.DataValueField = "Data";
                ddlpaymode.DataBind();
      
        }


        public void Paymodeforprofile()
        {
            // Check if the session variable is null


            // Load the data
            DataTable dt = ObjclsFrms.loadList("selPaymodeforCustomers", "sp_Masters");



            // Bind the data to the dropdown list
            ddlpaymode.DataSource = dt;
            ddlpaymode.DataTextField = "Data";
            ddlpaymode.DataValueField = "Data";
            ddlpaymode.DataBind();

        }


        public void Paymodes1()
        {
            // Check if the session variable is null
          
            try
            {
                // Load the data
                DataTable dt = ObjclsFrms.loadList("selPaymode", "sp_Masters", ddlrot.SelectedValue.ToString()) ;

                // Check if the DataTable is null
                if (dt == null)
                {
                    // Handle the case where dt is null
                    // Log the event or show a message to the user
                    // Here, we simply return to avoid further processing
                    return;
                }

                // Bind the data to the dropdown list
                ddlpaymode.DataSource = dt;
                ddlpaymode.DataTextField = "Data";
                ddlpaymode.DataValueField = "Data";
                ddlpaymode.DataBind();
            }
            catch (Exception ex)
            {
                // Handle any exceptions that occur during data loading or binding
                // Log the exception or show an error message to the user
                // For example, using a logging framework or writing to the event log
                // Here, we could log the exception and/or rethrow it
                // LogException(ex); // Assuming you have a method to log exceptions
                throw; // Optionally rethrow the exception if you want to propagate it further
            }
        }

        protected void Unnamed_Load(object sender, EventArgs e)
        {
          
           
                if (!Page.IsPostBack)
                {
                   RouteLike();
                Profiles();
               Paymode();




                if (Session["CusID"] != null)
                {
                    int customerId;
                    if (int.TryParse(Session["CusID"].ToString(), out customerId))
                    {
                        DataTable dttt = ObjclsFrms.loadList("SelectCustomers", "sp_Masters", customerId.ToString());

                        // Check if the DataTable is null or empty
                        if (dttt != null && dttt.Rows.Count > 0)
                        {
                            String CusCode = dttt.Rows[0]["cus_Code"].ToString();
                            String CusName = dttt.Rows[0]["cus_Name"].ToString();

                            lblCusCode.Text = CusCode;
                            lblCusName.Text = CusName;
                            Label2.Text = CusCode;
                            Label3.Text = CusName;
                        }
                        else
                        {
                            // Handle the case when the DataTable is null or empty
                            lblCusCode.Text = " ";
                            lblCusName.Text = " ";
                            Label2.Text = " ";
                            Label3.Text = " ";
                            // Optionally, log an error or display a message to the user
                        }
                    }
                    else
                    {
                        // Handle the case when the customer ID is not a valid integer
                        lblCusCode.Text = " ";
                        lblCusName.Text = " ";
                        Label2.Text = " ";
                        Label3.Text = " ";
                    }
                }
                else
                {
                    // Handle the case when Session["CusID"] is null
                    lblCusCode.Text = " ";
                    lblCusName.Text = " ";
                    Label2.Text = " ";
                    Label3.Text = " ";
                }





                DataTable dt = ObjclsFrms.loadList("SelectRouteType", "sp_Masters", ddlrot.SelectedValue.ToString());

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        object routeTypeValue = dt.Rows[0]["RouteType"];
                        if (routeTypeValue != null && routeTypeValue != DBNull.Value)
                        {
                            String RouteType = routeTypeValue.ToString();
                            RotType.Text = RouteType;
                        }
                        else
                        {
                            // Handle the case where RouteType is null or DBNull
                            RotType.Text = "No Route Type"; // You can set it to an appropriate default value or message
                        }
                    }
                    else
                    {
                        // Handle the case where the DataTable is null or has no rows
                        RotType.Text = "No Data"; // You can set it to an appropriate default value or message
                    }




                    // Retrieve the values from session or view state
                    string RotID = Session["R1"] as string;
                    string CusID = Session["C1"] as string;

                    // Check if RotID is null or empty
                    if (string.IsNullOrEmpty(RotID))
                    {
                        // Handle the null case, e.g., set a default value or show an error message
                        RotType.Text = "No RotID"; // Example of setting a default message
                        return; // Exit the method if RotID is null or empty
                    }

                    // Check if CusID is null or empty
                    if (string.IsNullOrEmpty(CusID))
                    {
                        // Handle the null case, e.g., set a default value or show an error message
                        RotType.Text = "No CusID"; // Example of setting a default message
                        return; // Exit the method if CusID is null or empty
                    }

                    // Proceed with loading the DataTable using the RotID
                    DataTable dtt = ObjclsFrms.loadList("SelectRouteType", "sp_Masters", RotID);

                    if (dtt != null && dtt.Rows.Count > 0)
                    {
                        object routeTypeValue = dtt.Rows[0]["RouteType"];
                        if (routeTypeValue != null && routeTypeValue != DBNull.Value)
                        {
                            String RouteType = routeTypeValue.ToString();
                            RotType.Text = RouteType;
                        }
                        else
                        {
                            // Handle the case where RouteType is null or DBNull
                            RotType.Text = "No Route Type"; // You can set it to an appropriate default value or message
                        }
                    }
                    else
                    {
                        // Handle the case where the DataTable is null or has no rows
                        RotType.Text = "No Data"; // You can set it to an appropriate default value or message
                    }



                    if (string.IsNullOrEmpty(CusID) || CusID == "0")
                    {


                    Paymode();
                    //ARPaymodes ---- to select hard cash and online payment selected
                    foreach (RadComboBoxItem items in rdARPayMode.Items)
                    {
                        if ((items.Value == "HC") || (items.Value == "OP"))
                        {
                            items.Checked = true;
                        }
                    }

                }

                    else                                                                        //If we are editing there will be a value and the following code will be executed.
                    {

                        DataTable lstDatas = ObjclsFrms.loadList("EditCusRoute", "sp_Masters", CusID.ToString());
                        if (lstDatas.Rows.Count > 0)
                        {
                        // Customer();
                        // RouteLike();
                            RouteMapped();
                            Paymode();

                            ddlrot.Enabled = false;
                            string rot, rotname, cus, IsInvoicing, IsSO, IsMerchandising, IsAR, IsI_Sales, IsI_GR, IsI_BR, IsI_FG, TCL, CDays, VoidEnable, PT, RoundAmount,
                            IsVAT, IsPO, cusType, signatureinvoice, Remark, signatureAR, OrderReqR, custCategoryType,
                            selectiontype, radius, Orderpro, IsHold, oncall, noOfInv, advpay, FG, status, MerchColumns, paymode, mandcolumns, enforcecussel, Cheque, SalSign, OrdSign, InvMode, AltInvReq, FGsep,
                            Insight, FS, FSFeatures, NegativeInvAmt, profile, MinInvoiceValue, MustSellItemCount, IsArManualAllocation, GracePeriod, GraceAmount, PartialDelivery, PriceChange, OrdPriceChange, eInvoive,
                            CusDocExpiryAlert, AlertDays, invhcimgmand, invposimgmand, invopimgmand, arhcimgmand, arposimgmand, arpoimgmand, archimgmand, ActvityManage, CusService,
                            ActManageMand, CusServiceMand, IsActivityManage, IsCustomerService, rcs_EnableForecastSales, rcs_EnableQuotation, EnableSuggestedOrd, IsPriceChange, CusLocation,
                            RecentSales, RecentOrder, MinOrderValue, ARRemark, GRSettings, BRSettings, VoidEnableCusInsight, EnableDelPriceChange, ARPayMode, rcs_EnforceBuyBackfree, MustSell,
                            InstDelivery, AttachmentsAR, IsAttachmentOrder, AttachmentInvoice, FreeSampleOrder, CouponPayMode, CurrentSecurityDeposit, FreeSampleOrderApproval, SuggestedLoadReq,
                            CouponEnable, InsCusSettings, fulldelivery, EnableLPONumber, LPONumberMand, ResRtnSameItmInvoice, EnableCashDeposit, EnableReturnRequestBatch;


                            invhcimgmand = lstDatas.Rows[0]["rcs_INV_HCRcpt_Img_Mand"].ToString();
                            invposimgmand = lstDatas.Rows[0]["rcs_INV_POSRcpt_Img_Mand"].ToString();
                            invopimgmand = lstDatas.Rows[0]["rcs_INV_OPRcpt_Img_Mand"].ToString();
                            arhcimgmand = lstDatas.Rows[0]["rcs_AR_HCRcpt_Img_Mand"].ToString();
                            arposimgmand = lstDatas.Rows[0]["rcs_AR_POSRcpt_Img_Mand"].ToString();
                            arpoimgmand = lstDatas.Rows[0]["rcs_AR_OPRcpt_Img_Mand"].ToString();
                            archimgmand = lstDatas.Rows[0]["rcs_AR_CHRcpt_Img_Mand"].ToString();
                            RecentSales = lstDatas.Rows[0]["rcs_EnableRecentSales"].ToString();
                            RecentOrder = lstDatas.Rows[0]["rcs_EnableRecentOrder"].ToString();
                            GRSettings = lstDatas.Rows[0]["rcs_GRSettings"].ToString();
                            BRSettings = lstDatas.Rows[0]["rcs_BRSettings"].ToString();


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
                        ResRtnSameItmInvoice = lstDatas.Rows[0]["rcs_RestrictedRtnSingleItemInvoice"].ToString();
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
                        FreeSampleOrder = lstDatas.Rows[0]["rcs_EnableFreeSampleOrder"].ToString();
                        FreeSampleOrderApproval = lstDatas.Rows[0]["rcs_EnableFreeSampleOrderApproval"].ToString(); 
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
                            MinOrderValue = lstDatas.Rows[0]["rcs_OrderMinValue"].ToString();
                            ARRemark = lstDatas.Rows[0]["rcs_IsRemarkAR"].ToString();//[rcs_IsRemarkAR]
                            VoidEnableCusInsight = lstDatas.Rows[0]["rcs_VoidEnableInsightCustomer"].ToString();
                            EnableDelPriceChange = lstDatas.Rows[0]["rcs_EnableDelPriceChange"].ToString();//rcs_EnableDelPriceChange
                            ARPayMode = lstDatas.Rows[0]["rcs_ArPaymodes"].ToString();

                            string[] ARPayModeArray = ARPayMode.Split('-');
                        CouponPayMode = lstDatas.Rows[0]["rcs_CouponPayMode"].ToString();
                        string[] CouponPayModeArray = CouponPayMode.Split('-');
                        rcs_EnforceBuyBackfree = lstDatas.Rows[0]["rcs_EnforceBuyBackfree"].ToString();
                            MustSell = lstDatas.Rows[0]["rcs_IsMustSellApproval"].ToString();
                            InstDelivery = lstDatas.Rows[0]["rcs_EnableInstantDelivery"].ToString();
                        CurrentSecurityDeposit = lstDatas.Rows[0]["rcs_CurrentSecurityDeposit"].ToString();
                        SuggestedLoadReq = lstDatas.Rows[0]["EnableSuggestedLODReq"].ToString();
                        CouponEnable = lstDatas.Rows[0]["rcs_IsCoupon"].ToString();
                        fulldelivery = lstDatas.Rows[0]["rcs_OptionForFullDelivery"].ToString();
                        EnableCashDeposit = lstDatas.Rows[0]["rcs_EnableCashDeposit"].ToString();

                        EnableReturnRequestBatch = lstDatas.Rows[0]["rcs_EnableReturnRequestBatch"].ToString();
                        ddlEnforceBuyBackfree.SelectedValue = rcs_EnforceBuyBackfree.ToString();
                        ddlMustSellApproval.SelectedValue = MustSell.ToString();
                        ddlInstDelivery.SelectedValue = InstDelivery.ToString();
                        txtCurrentSecDeposit.Text = CurrentSecurityDeposit.ToString();
                        ddlSuggLoadReq.SelectedValue = SuggestedLoadReq.ToString();
                        ddlISCouponEnable.SelectedValue = CouponEnable.ToString();
                        ddlEnableLPONumber.SelectedValue = EnableLPONumber.ToString();
                        ddlLPONumberMand.SelectedValue = LPONumberMand.ToString();
                        ddlRestrictedRtnSameItmInvoice.SelectedValue = ResRtnSameItmInvoice.ToString();
                        ddlEnableCD.SelectedValue = EnableCashDeposit.ToString();
                        ddlEnableRtnReqBatch.SelectedValue = EnableReturnRequestBatch.ToString();

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


                            ddlrot.SelectedValue = rot.ToString();
                     //   RouteLike();
                        
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
                            // ddlcus.Enabled = false;
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

        public void Pricelist()
        {
          
                if (Session["CusID"] != null)
            {
                int Id;
                if (int.TryParse(Session["CusID"].ToString(), out Id))
                {
                    DataTable dt = ObjclsFrms.loadList("PriceListHeaderwithoutRoute", "sp_Masters", Id.ToString());
                    ddlprh.DataSource = dt;
                    ddlprh.DataTextField = "prh_Name";
                    ddlprh.DataValueField = "prh_ID";
                    ddlprh.DataBind();
                }
            }



        }

        public void Routes()
        {


            if (Session["CusID"] != null)
            {
                int cuId;
                if (int.TryParse(Session["CusID"].ToString(), out cuId))
                {
                    DataTable dtt = ObjclsFrms.loadList("SelectPriceListRoute", "sp_Masters", cuId.ToString());
                    rdRoute1.DataSource = dtt;
                    rdRoute1.DataTextField = "rot_Name";
                    rdRoute1.DataValueField = "rot_ID";
                    rdRoute1.DataBind();
                }
            }



            
        }




        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_ItemCommand1(object sender, GridCommandEventArgs e)
        {


            if (e.CommandName.Equals("Edit"))                                           //To check whether the triggered command name matched or not, in case of multiple command name in aspx side
            {                                                                           //If it matched the following code will be executed
                GridDataItem dataItem = e.Item as GridDataItem;                         //We are creating an object for grid data item 
                string ID = dataItem.GetDataKeyValue("crp_ID").ToString();              //Using the object and a propery "GetDataKeyValue" we can access the value of DataKey in ASPX. which is the ID. 
                Response.Redirect("AddEditCusRouteProducts.aspx?Id=" + ID);                         //With the ID we can redirect to the add page to edit and update the value.
            }
            if (e.CommandName.Equals("Detail"))                                           //To check whether the triggered command name matched or not, in case of multiple command name in aspx side
            {
                string Rot = Session["RotID"].ToString();
                string cus = Session["CusID"].ToString();                                 //If it matched the following code will be executed
                GridDataItem dataItem = e.Item as GridDataItem;                         //We are creating an object for grid data item 
                string crpID = dataItem.GetDataKeyValue("crp_ID").ToString();              //Using the object and a propery "GetDataKeyValue" we can access the value of DataKey in ASPX. which is the ID. 
                Response.Redirect("ListCusRouteProductsDetails.aspx?crpId=" + crpID + "&RID=" + Rot.ToString() + "&CID=" + cus.ToString());                         //With the ID we can redirect to the add page to edit and update the value.
            }
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("crp_ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }

        protected void AddPrice_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim1();</script>", false);

        }

        public string GetRouteFromDropforPrice()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("root"); // Root element

                    foreach (RadComboBoxItem item in rdRoute1.CheckedItems)
                    {
                        createNodeForComboBox1(item.Value, writer);
                    }

                    writer.WriteEndElement(); // Close root element
                    writer.WriteEndDocument();
                    writer.Close();

                    return sw.ToString();
                }
            }
        }

        // Example method to create a node for RadComboBox items in XML
        private void createNodeForComboBox1(string value, XmlWriter writer)
        {
            writer.WriteStartElement("row"); // Each route ID under its own element
            writer.WriteElementString("rcs_ID", value);
            writer.WriteEndElement();
        }


      




        public void SaveSpecilaPrice()
        {
            string prh;

            string cus = GetRouteFromDropforPrice();

            string cus1 = mainConditions();

            Session["Customer"] = cus1;
            string dates = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
            string date = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            prh = ddlprh.SelectedValue.ToString();
            string usr = UICommon.GetCurrentUserID().ToString();
            string[] arr = { dates, date, cus.ToString(), usr, RadDropDownList1.SelectedValue.ToString() };
            string Value = ObjclsFrms.SaveData("sp_Masters", "AddCusRouteProductPrice", prh, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Special Price Added successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }

     
        protected void SavePrice_Click(object sender, EventArgs e)
        {
            SaveSpecilaPrice();


        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            ListSpecialPrice();
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeletecusrouteProducts", "sp_Masters", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>pricedelete();</script>", false);
        }

        protected void BtnDelConfrm_Click(object sender, EventArgs e)
        {
            RadWizardStep step = RadWizard1.FindControl("promo") as RadWizardStep;
            if (step != null)
            {
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                Session["ActiveStepIndex"] = stepIndex;

                // Register JavaScript to hide the modal and reload the page
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalAndReloadpromo", "hideModalAndReloadpromo();", true);
            }
        }

        protected void AddPromo_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModalPromo();</script>", false);

        }




        public void Routes1()
        {


            if (Session["CusID"] != null)
            {
                int cuId;
                if (int.TryParse(Session["CusID"].ToString(), out cuId))
                {
                    DataTable dtt = ObjclsFrms.loadList("SelectPromotionRoute", "sp_Masters", cuId.ToString());
                    ddlp.DataSource = dtt;
                    ddlp.DataTextField = "rot_Name";
                    ddlp.DataValueField = "rot_ID";
                    ddlp.DataBind();
                }
            }




        }

        protected void promo_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                rdFromDatas.MinDate = DateTime.Now.AddDays(0);
                rdEndDates.MinDate = DateTime.Now.AddDays(1);
                rdFromDatas.SelectedDate = DateTime.Now;
                rdEndDates.SelectedDate = DateTime.Now.AddDays(10);
                Routes1();
                Promo();


                if (Session["CusID"] != null)
                {
                    int customerId;
                    if (int.TryParse(Session["CusID"].ToString(), out customerId))
                    {
                        DataTable dt = ObjclsFrms.loadList("SelectCustomers", "sp_Masters", customerId.ToString());

                        // Check if the DataTable is null or empty
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            String CusCode = dt.Rows[0]["cus_Code"].ToString();
                            String CusName = dt.Rows[0]["cus_Name"].ToString();

                            promocode.Text = CusCode;
                            promoname.Text = CusName;
                        }
                        else
                        {
                            // Handle the case when the DataTable is null or empty
                            promocode.Text = " ";
                            promoname.Text = " ";
                            // Optionally, log an error or display a message to the user
                        }
                    }
                    else
                    {
                        // Handle the case when the customer ID is not a valid integer
                        promocode.Text = " ";
                        promoname.Text = " ";
                    }
                }
                else
                {
                    // Handle the case when Session["CusID"] is null
                    promocode.Text = " ";
                    promoname.Text = " ";
                }

            }

        }

        public string Rotes()
        {
            var CollectionMarket = ddlp.CheckedItems;
            string RotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        RotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        RotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        RotID += item.Value;
                    }
                    j++;
                }
                return RotID;
            }
            else
            {
                return "rcp_rot_ID";
            }

        }


        public void Promo()
        {

      


            DataTable dtp = ObjclsFrms.loadList("SelectPromotionDropdown", "sp_Web_Promotion");
            ddlPromo.DataSource = dtp;
            ddlPromo.DataTextField = "name";
            ddlPromo.DataValueField = "id";
            ddlPromo.DataBind();
        }

        public void CustomerHeader()
        {




            DataTable dtp = ObjclsFrms.loadList("selectCusHeader", "sp_Masters");
            ddlCusHeader.DataSource = dtp;
            ddlCusHeader.DataTextField = "csh_Name";
            ddlCusHeader.DataValueField = "csh_ID";
            ddlCusHeader.DataBind();
        }

     


        public string GetRouteFromDrop()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("root"); // Root element

                    foreach (RadComboBoxItem item in ddlp.CheckedItems)
                    {
                        createNodeForComboBox(item.Value, writer);
                    }

                    writer.WriteEndElement(); // Close root element
                    writer.WriteEndDocument();
                    writer.Close();

                    return sw.ToString();
                }
            }
        }

        // Example method to create a node for RadComboBox items in XML
        private void createNodeForComboBox(string value, XmlWriter writer)
        {
            writer.WriteStartElement("row"); // Each route ID under its own element
            writer.WriteElementString("rot_ID", value);
            writer.WriteEndElement();
        }




        protected void Promoadd_Click(object sender, EventArgs e)
        {
           
                    try
                    {
                        string cusID = Session["CusID"].ToString();
                string rot = GetRouteFromDrop();
                string prmid = ddlPromo.SelectedValue.ToString();
                        string rdfromdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string rdenddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string[] arr = { cusID,  prmid, rdfromdate, rdenddate };
                        string Value;
                        int res = 0;
                        Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsCustopromotion", rot, arr);
                        res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "CustomerRoute.aspx Delete()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ErrorModal();</script>", false);
                    }
                
            
        }


        public void LoadList()
        {
           

            if (Session["CusID"] != null)
            {
                int CusId;
                if (int.TryParse(Session["CusID"].ToString(), out CusId))
                {
                    DataTable lstUser = default(DataTable);
                    lstUser = ObjclsFrms.loadList("SelectRouteCustomerPromotion", "sp_Masters_UOM", CusId.ToString());
                    if (lstUser.Rows.Count >= 0)
                    {
                        RadGrid2.DataSource = lstUser;
                    }

                }
            }
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void RadGrid2_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("DeleteS"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rcp_ID").ToString();
                ViewState["delIDS"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfims();</script>", false);
            }
        }

        protected void promodel_Click(object sender, EventArgs e)
        {
            string id = ViewState["delIDS"].ToString();
            GeneralFunctions.loadList_Static("DeletecusroutePromotion", "sp_Masters", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DelPromotionConm();</script>", false);
        }



        public void ProductMappingGroup()
        {
            string rotId = ddlrot.SelectedValue.ToString();
            string cus = Session["CusID"] != null ? Session["CusID"].ToString() : string.Empty;

            DataTable dts = ObjclsFrms.loadList("SelectPMGnameforCustomerRoute", "sp_Masters");

            if (!string.IsNullOrEmpty(cus))
            {
                string[] ar = { rotId };
                DataTable dt = ObjclsFrms.loadList("SelProductGroup", "sp_Masters", cus, ar);

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


        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edits"))
            {
                //GridDataItem dataItem = e.Item as GridDataItem;
                //string RotID = dataItem.GetDataKeyValue("rot_ID").ToString();
                //string CusID = dataItem["rcs_ID"].Text;

                //Response.Redirect("AddEditCustomerRoutes.aspx?CID=" + CusID + "&RID=" + RotID);



                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem != null)
                {
                    string RotID = dataItem.GetDataKeyValue("rot_ID").ToString();
                    string CusID = dataItem["rcs_ID"].Text;

                    // Store the values in session or view state
                    Session["R1"] = RotID;
                    Session["C1"] = CusID;

                    // Navigate to the wizard step
                    RadWizardStep step = RadWizard1.FindControl("Routemapping") as RadWizardStep;
                    if (step != null)
                    {
                        int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                        Session["ActiveStepIndex"] = stepIndex;

                        Response.Redirect(Request.RawUrl);
                        // Register JavaScript to hide the modal and reload the page
                    }
                }
            }
        }

        //protected void RorMap_Click(object sender, EventArgs e)
        //{
        //    RadWizardStep step = RadWizard1.FindControl("ListRoute") as RadWizardStep;
        //    if (step != null)
        //    {
        //        int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
        //        Session["ActiveStepIndex"] = stepIndex;

        //        // Register JavaScript to hide the modal and reload the page
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalAndReloadRoute", "hideModalAndReloadRoute();", true);
        //    }
        //}

        protected void ListRoute_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                List();

                if (Session["Routemapping"].ToString().Equals("Yes"))
                {
                    ListRoute.Enabled = true;
                    promo.Enabled = true;
                    splprice.Enabled = true;

                }

             
            }
        }

        protected void CusAdd_Click(object sender, EventArgs e)
        {
            //Response.Redirect("AddEditCustomers.aspx");


            RadWizardStep step = RadWizard1.FindControl("Routemapping") as RadWizardStep;
            if (step != null)
            {
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                Session["ActiveStepIndex"] = stepIndex;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalcusadding", "hideModalcusadding();", true);


                // Register JavaScript to hide the modal and reload the page
            }
        }


        public void FillForm(string ID)
        {


            Session["CusID"] = ID;


            DataTable lstDatas = ObjclsFrms.loadList("SelCustomerByID", "sp_Masters", ID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, code, shortname, total, used, creditdays, addres, watsap, contactperson, contactpersonAR,
                    vat, phe, email, geo, area, cls, status, nameArabic, shortnameArabic, addressArabic, custype, 
                    recaptureGeo, AltHOCode, EnableInvoiceApproval, TRN, cusHead,company;
                name = lstDatas.Rows[0]["cus_Name"].ToString();
                nameArabic = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                shortnameArabic = lstDatas.Rows[0]["cus_ShortNameArabic"].ToString();

                addressArabic = lstDatas.Rows[0]["cus_AddressArabic"].ToString();
                code = lstDatas.Rows[0]["cus_Code"].ToString();
                shortname = lstDatas.Rows[0]["cus_ShortName"].ToString();
                //total = lstDatas.Rows[0]["cus_TotalCreditLimit"].ToString();
                //used = lstDatas.Rows[0]["cus_UsedCreditLimit"].ToString();
                //creditdays = lstDatas.Rows[0]["cus_CreditDays"].ToString();
                addres = lstDatas.Rows[0]["cus_Address"].ToString();
                email = lstDatas.Rows[0]["cus_Email"].ToString();
                //vat = lstDatas.Rows[0]["cus_IsVATEnabled"].ToString();
                phe = lstDatas.Rows[0]["cus_Phone"].ToString();
                geo = lstDatas.Rows[0]["cus_GeoCode"].ToString();
                area = lstDatas.Rows[0]["cus_are_ID"].ToString();
                cls = lstDatas.Rows[0]["cus_cls_ID"].ToString();
                recaptureGeo = lstDatas.Rows[0]["cus_RecaptureGeo"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                custype = lstDatas.Rows[0]["cus_Type"].ToString();
                watsap = lstDatas.Rows[0]["cus_WhatsappNumber"].ToString();
                contactperson = lstDatas.Rows[0]["cus_ContactPerson"].ToString();
                contactpersonAR = lstDatas.Rows[0]["cus_ContactPerson_ar"].ToString();
                AltHOCode = lstDatas.Rows[0]["cus_AltHOCode"].ToString();

                EnableInvoiceApproval = lstDatas.Rows[0]["cus_EnableInvoiceApproval"].ToString();
                cusHead = lstDatas.Rows[0]["cus_csh_ID"].ToString();
                TRN = lstDatas.Rows[0]["TRN_Number"].ToString();
                company = lstDatas.Rows[0]["cus_CompanyCode"].ToString();


                txtName.Text = name.ToString();
                txtCode.Text = code.ToString();
                txtCode.Enabled = false;
                txtShortName.Text = shortname.ToString();
                txtAltHOCode.Text = AltHOCode.ToString();
                //txtUsdCrdLimits.Text = used.ToString();
                //txtCrdDayy.Text = creditdays.ToString();
                txtad.Text = addres.ToString();
                txtEmail.Text = email.ToString();
                //ddlvat.SelectedValue = vat.ToString();
                txtPerson.Text = phe.ToString();
                txtGeoLoc.Text = geo.ToString();
                ddlarea.SelectedValue = area.ToString();
                ddlcls.SelectedValue = cls.ToString();
                ddlStatuses.SelectedValue = status.ToString();
                ddlRecapture.SelectedValue = recaptureGeo.ToString();
                txtArabName.Text = nameArabic.ToString();
                //txtArabShortName.Text = shortnameArabic.ToString();
                txtArabAddress.Text = addressArabic.ToString();
                ddlcustype.SelectedValue = custype.ToString();
                txtwhatsNo.Text = watsap.ToString();
                txtContactPerson.Text = contactperson.ToString();
                txtARcontactPerson.Text = contactpersonAR.ToString();

                EnableInvAppr.SelectedValue = EnableInvoiceApproval.ToString();
                ddlCusHeader.SelectedValue = cusHead.ToString();
                txtTRN.Text = TRN.ToString();
                ddlCusCom.SelectedValue = company.ToString();

                if (custype == "NC")
                {

                    pnlCusHead.Visible = false;
                }
                else
                {

                    pnlCusHead.Visible = true;
                }
                
            }
        }

        protected void AddCustomer_Load(object sender, EventArgs e)
        {


            if (!Page.IsPostBack)
            {
                if (Mode == 1) // While loading page from edit mode
                {
                    FillForm(ResponseID.ToString());
                    closecustomer.Visible = true;
                }
              
                else
                {
                    try
                    {
                        if (Session["CusID"] != null)
                        {
                            FillForm(Session["CusID"].ToString());
                            closecustomer.Visible = false;
                        }
                        else
                        {
                            // ListRoute.Enabled = false;
                            // promo.Enabled = false;
                            // splprice.Enabled = false;
                        }
                    }
                    catch
                    {

                    }
                }
                Profile();
            }

        }

        protected void splDeleconfirm_Click(object sender, EventArgs e)
        {
            RadWizardStep step = RadWizard1.FindControl("splprice") as RadWizardStep;
            if (step != null)
            {
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                Session["ActiveStepIndex"] = stepIndex;

                // Register JavaScript to hide the modal and reload the page
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalAndReloadSpl", "hideModalAndReloadSpl();", true);
            }
        }

        protected void Promodel_Click1(object sender, EventArgs e)
        {
            RadWizardStep step = RadWizard1.FindControl("promo") as RadWizardStep;
            if (step != null)
            {
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                Session["ActiveStepIndex"] = stepIndex;

                // Register JavaScript to hide the modal and reload the page
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalAndReloadpromotion", "hideModalAndReloadpromotion();", true);
            }
        }

        protected void splprice_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Routes();
            }
        }

        protected void ApplyProfile_Click(object sender, EventArgs e)
        {
            try
            {
                Session.Remove("CustomerType");

                string pfh_Id = rdProfile.SelectedValue.ToString();
                if (!string.IsNullOrEmpty(pfh_Id))
                {
                    DataTable dt = ObjclsFrms.loadList("ProdileDetailforMasterForms", "sp_ProfileSettings", pfh_Id);

                    foreach (DataRow row in dt.Rows)
                    {
                        // Get the value of the "pfd_ControlId" column
                        object pdfControlValue = row["pfd_Values"];
                        string pdfControlValueString = pdfControlValue.ToString();

                        // Check if the value matches the required condition
                        if (pdfControlValueString == "NC")
                        {
                            // Store the value in the session
                            Session["CustomerType"] = pdfControlValue;

                            ddlcustype.SelectedValue = " ";

                            break; // Exit the loop if the condition is met
                        }
                    }
                    // Check if both values match the required condition
                
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
        public void Profiles()
        {
            rdProfile.ClearSelection();

            DataTable lstVehicle = ObjclsFrms.loadList("SelProfileHeaderforDropDown", "sp_ProfileSettings", "tb_CustomerRoute");
            if (lstVehicle.Rows.Count > 0)
            {

                RadDropDownList2.DataSource = lstVehicle;
                RadDropDownList2.DataValueField = "pfh_ID";
                RadDropDownList2.DataTextField = "pfh_ProfileName";
                RadDropDownList2.DataBind();

            }
        }


        public void Profile()
        {
            rdProfile.ClearSelection();

            DataTable lstVehicle = ObjclsFrms.loadList("SelProfileHeaderforDropDown", "sp_ProfileSettings", "tb_Customer");
            if (lstVehicle.Rows.Count > 0)
            {

                rdProfile.DataSource = lstVehicle;
                rdProfile.DataValueField = "pfh_ID";
                rdProfile.DataTextField = "pfh_ProfileName";
                rdProfile.DataBind();

            }
        }

        protected void ApplyProfileRoute_Click(object sender, EventArgs e)
        {
            try
            {
                string route = ddlrot.SelectedValue.ToString();
                if (!string.IsNullOrEmpty(route))
                {

                    string pfh_Id = RadDropDownList2.SelectedValue.ToString();
                    if (!string.IsNullOrEmpty(pfh_Id))
                    {
                        DataTable dt = ObjclsFrms.loadList("ProdileDetailforMasterForms", "sp_ProfileSettings", pfh_Id);
                        if (dt.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dt.Rows)
                            {
                                string controlId = dr["pfd_ControlId"].ToString();
                                string controlValues = dr["pfd_Values"].ToString();
                                string controlType = dr["pfd_Type"].ToString();
                                SetControlValues(controlId, controlValues, controlType);
                                // Paymodeforprofile();
                            }
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure1();</script>", false);
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
        }

      

        protected void Gotocus_Click1(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");

        }

        protected void ddlrot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string route = ddlrot.SelectedValue.ToString();

            Paymode();
            ProductMappingGroup();

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void splprice_Click(object sender, EventArgs e)
        {
            RadWizardStep step = RadWizard1.FindControl("splprice") as RadWizardStep;
            if (step != null)
            {
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                Session["ActiveStepIndex"] = stepIndex;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalRoutecusadding", "hideModalRoutecusadding();", true);


                // Register JavaScript to hide the modal and reload the page
            }
        }

        protected void gotocustomer_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");

        }

      
     
        protected void Gotocustomers_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");

        }

        protected void gotopromotion_Click1(object sender, EventArgs e)
        {
            RadWizardStep step = RadWizard1.FindControl("promo") as RadWizardStep;
            if (step != null)
            {
                int stepIndex = RadWizard1.WizardSteps.IndexOf(step);
                Session["ActiveStepIndex"] = stepIndex;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModalpromotionadding", "hideModalpromotionadding();", true);


                // Register JavaScript to hide the modal and reload the page
            }
        }

        protected void GOTOCUSTOM_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");

        }

        protected void rblStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = rblStatus.SelectedValue;

            // Find the RadDropDownList control

           // Change the selected item based on the RadioButtonList selection
                if (selectedValue == "Y")
                {
                    ddlStatuses.SelectedValue = "N"; // Set to Inactive
                }
                else
                {
                    ddlStatuses.SelectedValue = "Y"; // Set to ACTIVE
                }
            
        }
    }
}