using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewAddEditCusRoute : System.Web.UI.Page
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                Route();
                Customer();
                Paymode();

                string Id = ResponseID.ToString();
                if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                {

                    CustomerwithoutRoute();
                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {

                    DataTable lstDatas = ob.loadList("EditCusRoute", "sp_Masters", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {
                        Customer();

                        string rot, rotname, cus, IsInvoicing, IsSO, IsMerchandising, IsAR, IsI_Sales, IsI_GR, IsI_BR, IsI_FG, TCL, CDays, VoidEnable, PT, RoundAmount,
                        IsVAT, IsPO, cusType, signatureinvoice, Remark, signatureAR, OrderReqR, custCategoryType,
                        selectiontype, radius, Orderpro, IsHold, oncall, noOfInv, advpay, FG, status, MerchColumns, paymode, mandcolumns, enforcecussel, Cheque, SalSign, OrdSign, InvMode;


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
                        paymode = lstDatas.Rows[0]["rcs_PaymentModes"].ToString();
                        enforcecussel = lstDatas.Rows[0]["rcs_EnforceCustSelection"].ToString();
                        SalSign = lstDatas.Rows[0]["rcs_EnableSalesSign"].ToString();
                        OrdSign = lstDatas.Rows[0]["rcs_EnableOrderSign"].ToString();
                        InvMode = lstDatas.Rows[0]["rcs_InvoiceMode"].ToString();
                        Cheque = lstDatas.Rows[0]["Cheque_Amount"].ToString();
                        string[] arry = MerchColumns.Split('-');
                        string[] array = mandcolumns.Split('-');
                        string[] ar = paymode.Split('-');


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
                        ddRoundAmount.SelectedValue = RoundAmount.ToString();
                        ddIsPO.SelectedValue = IsPO.ToString();
                        ddlSI.SelectedValue = signatureinvoice.ToString();
                        ddSAR.SelectedValue = signatureAR.ToString();
                        ddRe.SelectedValue = Remark.ToString();
                        ddORR.SelectedValue = OrderReqR.ToString();
                        ddlordpro.SelectedValue = Orderpro.ToString();
                        ddlFGExemption.SelectedValue = FG.ToString();
                        ddlenforcecussel.SelectedValue = enforcecussel.ToString();
                        ddlEnablesalsign.SelectedValue = SalSign.ToString();
                        ddlenableOrdrsign.SelectedValue = OrdSign.ToString();
                        ddlInvoiceMode.SelectedValue = InvMode.ToString();
                        //txtCheqAmnt.Text = Cheque.ToString();
                        ddlcus.Enabled = false;
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
                            ddIsSOrder.Visible = false;
                        }
                        else
                        {
                            ddIsSOrder.Visible = true;
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

                        txtTCL.Enabled = false;

                        if (ddPT.SelectedValue == "N")
                        {
                            Paymodes.Visible = false;
                        }
                        else
                        {
                            Paymodes.Visible = true;
                        }
                    }
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
            DataTable dt = ob.loadList("selcus", "sp_Masters", RouteID.ToString());
            ddlcus.DataSource = dt;
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
    }
}