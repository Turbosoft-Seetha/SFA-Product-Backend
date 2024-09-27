using System;
using System.Data;
using System.Web.UI;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                Route();
                Customer();


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

                        string rot, rotname, cus, IsInvoicing, IsSO, IsMerchandising, IsAR, IsI_Sales, IsI_GR, IsI_BR, IsI_FG, TCL, UCL, CDays, VoidEnable, PT, RoundAmount,
                        IsVAT, IsPO, cusType, ACL, signatureinvoice, Remark, signatureAR, OrderReqR, UOC, UIC, PDCAmount,custCategoryType,
                        selectiontype, radius, Orderpro, IsHold, oncall, noOfInv, advpay, FG, status;


                        rot = lstDatas.Rows[0]["rcs_rot_ID"].ToString();
                        rotname = lstDatas.Rows[0]["rot_Name"].ToString();

                        cus = lstDatas.Rows[0]["cus_ID"].ToString();
                        cusType = lstDatas.Rows[0]["rcs_cusType"].ToString();
                        custCategoryType = lstDatas.Rows[0]["rcs_CustCategoryType"].ToString();
                        TCL = lstDatas.Rows[0]["rcs_TotalCreditLimit"].ToString();
                        UCL = lstDatas.Rows[0]["rcs_UsedCreditLimit"].ToString();
                        ACL = lstDatas.Rows[0]["rcs_AvailableCreditLimit"].ToString();
                        UOC = lstDatas.Rows[0]["rcs_UsedOrderCredit"].ToString();
                        UIC = lstDatas.Rows[0]["rcs_UsedInvoiceCredit"].ToString();
                        PDCAmount = lstDatas.Rows[0]["rcs_PDC_Amount"].ToString();
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
                        IsInvoicing = lstDatas.Rows[0]["IsInvoicing"].ToString();
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



                        ddlroute.SelectedValue = rot.ToString();
                        ddlcus.SelectedValue = cus.ToString();
                        ddcusType.SelectedValue = cusType.ToString();
                        ddcatType.SelectedValue = custCategoryType.ToString();
                        txtTCL.Text = TCL.ToString();
                        txtUCL.Text = UCL.ToString();
                        txtACL.Text = ACL.ToString();
                        txtUOC.Text = UOC.ToString();
                        txtUIC.Text = UIC.ToString();
                        txtpdc.Text = PDCAmount.ToString();
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

                        if (cusType == "CS")
                        {
                            Custype.Visible = false;
                        }
                        else
                        {
                            Custype.Visible = true;
                        }
                        if (IsInvoicing == "N")
                        {
                            inv.Visible = false;
                        }
                        else
                        {
                            inv.Visible = true;
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
                cusroute.Text = "Route Name : " + rotname;


            }

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

        public void SaveData()
        {
            string rot, cus, IsInvoicing, IsSO, IsMerchandising, IsAR, IsI_Sales, IsI_GR, IsI_BR, IsI_FG, TCL, UCL, CDays, VoidEnable, PT, RoundAmount, UOC, UIC, PDCAmount, custCategoryType,
            IsVAT, IsPO, cusType, ACL, signatureinvoice, Remark, signatureAR, selectiontype, radius, Orderpro, IsHold, oncall, noOfInv, advpay, FG, OrderReqR, status;

            rot = ddlroute.SelectedValue.ToString();
            cus = ddlcus.SelectedValue.ToString();
            cusType = ddcusType.SelectedValue.ToString();
            custCategoryType = ddcatType.SelectedValue.ToString();
            TCL = txtTCL.Text.ToString();
            UCL = txtUCL.Text.ToString();
            ACL = txtACL.Text.ToString();
            UOC = txtUOC.Text.ToString();
            UIC = txtUIC.Text.ToString();
            PDCAmount = txtpdc.Text.ToString();
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

            VoidEnable = ddVoidEnable.SelectedValue.ToString();
            RoundAmount = ddRoundAmount.SelectedValue.ToString();
            IsPO = ddIsPO.SelectedValue.ToString();
            signatureinvoice = ddlSI.SelectedValue.ToString();
            signatureAR = ddSAR.SelectedValue.ToString();
            Remark = ddRe.SelectedValue.ToString();
            OrderReqR = ddORR.SelectedValue.ToString();
            Orderpro = ddlordpro.SelectedValue.ToString();
            FG = ddlFGExemption.SelectedValue.ToString();

            if (cusType == "CS" && ResponseID.ToString() == "0")
            {
                TCL = "0";
                UCL = "0";
                ACL = "0";
                UOC = "0";
                UIC = "0";
                PDCAmount = "0";
                CDays = "0";
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

                    string[] arr = {   cus,cusType,TCL, UCL, ACL , CDays,PT,noOfInv,IsVAT, IsHold,selectiontype,radius,oncall,IsSO,IsInvoicing,IsI_Sales, IsI_GR, IsI_BR, IsI_FG,
                         IsAR,advpay,  IsMerchandising,   VoidEnable,  RoundAmount, IsPO,signatureinvoice,signatureAR,Remark,OrderReqR,Orderpro,FG ,status,UOC,UIC,PDCAmount,custCategoryType};

                    string Value = ob.SaveData("sp_Merchandising", "InsertCusRoute", RouteID.ToString(), arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
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
                    string[] arr = { RouteID.ToString(), cus,cusType,TCL, UCL, ACL , CDays,PT,noOfInv,IsVAT, IsHold,selectiontype,radius,oncall,IsSO,IsInvoicing,IsI_Sales, IsI_GR, IsI_BR, IsI_FG,
                            IsAR,advpay,  IsMerchandising,   VoidEnable,  RoundAmount, IsPO,signatureinvoice,signatureAR,Remark,OrderReqR,Orderpro,FG ,status,UOC,UIC,PDCAmount,custCategoryType};
                    string value = ob.SaveData("sp_Merchandising", "UpdateCusRoute", id, arr);
                    int res = Int32.Parse(value.ToString());
                    if (res > 0)
                    {
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

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string ID = ResponseID.ToString();

            DataTable lstDatas = ob.loadList("EditCusRoute", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string UCL = lstDatas.Rows[0]["rcs_UsedCreditLimit"].ToString();
                string custype = ddcusType.SelectedValue.ToString();

                decimal usedCL = Decimal.Parse(UCL.ToString());
                if (custype == "CS")
                {
                    if (usedCL > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Used Credit Limit is Greater than Zero ...Customer Type Canot be Cash');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                    }

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string ID = RouteID.ToString();
            Response.Redirect("/Admin/ListCustomerRoute.aspx?ID=" + ID);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            string ID = RouteID.ToString();
            Response.Redirect("/Admin/ListCustomerRoute.aspx?ID=" + ID);

        }

        protected void ddcusType_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string custype = ddcusType.SelectedValue.ToString();

                if (custype == "CS")
                {
                    Custype.Visible = false;
                }
                else
                {
                    Custype.Visible = true;
                }
        }

        protected void ddlIsInvoicing_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string invoice = ddlIsInvoicing.SelectedValue.ToString();
            if (invoice == "N")
            {
                inv.Visible = false;
            }
            else
            {
                inv.Visible = true;
            }
        }
    }
}