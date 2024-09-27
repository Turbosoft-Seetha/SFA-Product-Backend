<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditCusRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditCusRoute" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {

            $('#modalConfirm').modal('show');
        }
        function Succcess(ab) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#Success').text(ab);
        }
        function FailureAlert(res) {
            $('#FailureAlert').modal('show');
            $('#failres').text(res);
            x++;
        }
        function Cusroute() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("RID");
            window.location.href = "ListCustomerRoute.aspx?ID=" + c;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <div style="border: 1px solid #ccc; padding: 10px; border-radius: 5px;">
        <h9 style="margin-top: 0;">Settings Profile</h9>
        <div style="display: flex; align-items: center;">
            <telerik:RadDropDownList ID="rdProfile" runat="server" CausesValidation="false" Width="200px" Filter="Contains">
                <Items>
                    <telerik:DropDownListItem Text="Select Profile" Value="0" Selected="true" />
                </Items>
            </telerik:RadDropDownList>
            <asp:LinkButton ID="ApplyProfile" runat="server"
                Text="Apply" CssClass="btn btn-sm fw-bold btn-secondary"
                CausesValidation="False" OnClick="ApplyProfile_Click"
                Style="margin-left: 10px; height: 30px; padding: 5px 10px; line-height: 20px;" />
        </div>
    </div>
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

        <asp:PlaceHolder runat="server" ID="pnlItemMapping" Visible="false">
            <asp:LinkButton ID="Itemmap" runat="server" Text="Proceed to Item mapping" CssClass="btn btn-sm fw-bold btn-secondary" CausesValidation="false" OnClick="Itemmap_Click" />
        </asp:PlaceHolder>

        <asp:LinkButton ID="LinkButton2" Width="100px" runat="server" Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary" CausesValidation="False" OnClick="LinkButton2_Click" />
        <asp:LinkButton ID="LinkButton1" Width="100px" runat="server" ValidationGroup="form" OnClick="LinkButton1_Click" UseSubmitBehavior="false" Text='Proceed'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">
                    <div class="kt-portlet__body">
                        <%--<telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">--%>
                        <%--<div class="col-lg-4 form-group">--%>
                        <%--<label class="control-label col-lg-12">Route <span class="required">* </span></label>--%>
                        <%--<div class="col-lg-12">--%>
                        <telerik:RadComboBox ID="ddlroute" runat="server" EmptyMessage="Select Route" CausesValidation="false" Visible="false" Width="100%" Filter="Contains" AutoPostBack="true"></telerik:RadComboBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                            ControlToValidate="ddlroute" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                        <%--</div>--%>
                        <%--</div>--%>

                        <div class="col-lg-12 row p-4 mb-6" style="border-width: 2px; border-style: groove;">
                            <div class="col-lg-4 row fw-bold fs-3">
                                Route Code :  

                                <div class="col-lg-8 fw-bold fs-3">
                                    <asp:Label runat="server" ID="lblRouteCode"> </asp:Label></div>
                            </div>

                            <div class="col-lg-4 row fw-bold fs-3">
                                Route Name:  

                                <div class="col-lg-8 fw-bold fs-3">
                                    <asp:Label runat="server" ID="lblRouteName"> </asp:Label></div>
                            </div>
                            <div class="col-lg-4 row fw-bold fs-3">
                                Route Type:  

                                 <div class="col-lg-8 fw-bold fs-3">
                                     <asp:Label runat="server" ID="lblRouteType"> </asp:Label></div>
                            </div>


                        </div>

                        <div class="col-lg-12 row"><b>Credit Terms </b></div>
                        <br />
                        <asp:PlaceHolder ID="search" runat="server" Visible="false">
                            <div class="col-lg-12 row">

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Enter Customer Code or Name to Populate Customer <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="SearchTextBox" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadTextBox>



                                    </div>
                                </div>
                                <div class="col-lg-4" style="padding-top: 15px; margin-left: 15px;">
                                    <asp:LinkButton ID="lnkSearch" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" CausesValidation="false" OnClick="lnkSearch_Click">
                                                    Search
                                    </asp:LinkButton>
                                </div>

                            </div>
                        </asp:PlaceHolder>

                        <div class="col-lg-12 row">



                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Customer <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlcus" runat="server" Width="100%" EmptyMessage="Select Customer" Filter="Contains" OnTextChanged="ddlcus_TextChanged" AllowCustomText="true" CausesValidation="false" OnSelectedIndexChanged="ddlcus_SelectedIndexChanged"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlcus" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Payment Terms<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddcusType" runat="server" Width="100%" DefaultMessage="Select Customer Type" OnSelectedIndexChanged="ddcusType_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true">
                                        <Items>
                                            <telerik:DropDownListItem Text="CASH" Value="CS" />
                                            <telerik:DropDownListItem Text="CREDIT" Value="CR" />
                                            <telerik:DropDownListItem Text="TEMPORARY CREDIT" Value="TC" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddcusType" ErrorMessage="Please select Customer Type" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <asp:PlaceHolder runat="server" ID="Paymodes" Visible="true">
                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Payment Mode<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlpaymode" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Payment Modes">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" Display="Dynamic"
                                            ControlToValidate="ddlpaymode" ErrorMessage="Please Select Payment Modes" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </asp:PlaceHolder>
                            <asp:PlaceHolder runat="server" ID="Custype">



                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-6">Total Credit Limit <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtTCL" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" Display="Dynamic"
                                            ControlToValidate="txtTCL" ErrorMessage="Please Enter Total Credit Limit" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-6">Grace Amount <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtGraceamount" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="txtGraceamount" ErrorMessage="Please Enter Grace Amount" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-6">Credit Days <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtCDays" runat="server" CssClass="form-control" Width="100%" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="txtCDays" ErrorMessage="Please Enter Credit Days" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-6">Grace Period <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtGracePeriod" runat="server" CssClass="form-control" Width="100%" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator32" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="txtGracePeriod" ErrorMessage="Please Enter Grace Period" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Allow Cash For Credit Customers<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddPT" runat="server" Width="100%" OnSelectedIndexChanged="ddPT_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true" DefaultMessage="Please Select">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddPT" ErrorMessage="Please select Allow Cash For Credit Customers" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:PlaceHolder ID="noofinvoice" runat="server">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-6">No of Invoice <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="txtnoInvoice" runat="server" CssClass="form-control" Width="100%" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="txtnoInvoice" ErrorMessage="Please Enter No of Invoice" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>
                            </asp:PlaceHolder>



                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">VAT<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddIsVAT" runat="server" Width="100%" DefaultMessage="Please select">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddIsVAT" ErrorMessage="Please select VAT" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Hold<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlIsHold" runat="server" Width="100%" DefaultMessage="Please select">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlIsHold" ErrorMessage="Please select Hold" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-6">ERP Customer Location </label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtCusLocation" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator48" runat="server" Display="Dynamic"
                                        ControlToValidate="txtCDays" ErrorMessage="Please Enter ERP Customer Location" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Status<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlstatus" runat="server" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlstatus" ErrorMessage="Please select Status" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>



                        </div>

                        <br />
                        <div class="col-lg-12 row"><b>General Settings </b></div>
                        <br />
                        <div class="col-lg-12 row">

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Selection Type<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddltype" runat="server" Width="100%" DefaultMessage="Select Selection Type" OnSelectedIndexChanged="ddltype_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true">
                                        <Items>
                                            <telerik:DropDownListItem Text="Geocode" Value="G" />
                                            <telerik:DropDownListItem Text="Barcode" Value="B" />
                                            <telerik:DropDownListItem Text="Manual" Value="M" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator30" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddltype" ErrorMessage="Please select Selection Type" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <asp:PlaceHolder ID="pnlFencing" runat="server" Visible="true">
                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Fencing Radius (In meters)<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox MinValue="20" ID="txtradius" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtradius" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Fencing Radius"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </asp:PlaceHolder>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">On Call Features</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddloncal" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select On Call Features">
                                        <Items>

                                            <telerik:RadComboBoxItem Text="AR Collection" Value="AR" />
                                            <telerik:RadComboBoxItem Text="Advance Collection" Value="AP" />
                                            <telerik:RadComboBoxItem Text="Order Request" Value="OR" />
                                        </Items>
                                    </telerik:RadComboBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddloncal" ErrorMessage="Please select On Call Features" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Transaction Type<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddcatType" runat="server" Width="100%" DefaultMessage="Please select" OnSelectedIndexChanged="ddcatType_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Order Based Delivery " Value="ODC" />
                                            <telerik:DropDownListItem Text="Direct Invocing" Value="NC" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddcatType" ErrorMessage="Please select category type" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>


                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enforce Customer Selection<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlenforcecussel" runat="server" Width="100%" DefaultMessage="Please Select">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlenforcecussel" ErrorMessage="Please select " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enable Insight<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlEnableInsight" runat="server" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlFS" ErrorMessage="Please select" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Void Enable<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddVoidEnable" runat="server" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddVoidEnable" ErrorMessage="Please select Void Enable" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Void inside customer<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddVoidEnableCusInsight" runat="server" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator53" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddVoidEnableCusInsight" ErrorMessage="Please select Void Enable for Customer Insight" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Round Amount<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddRoundAmount" runat="server" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddRoundAmount" ErrorMessage="Please select Round Amount" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Must Sell Item Count</label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="MustSellItmCnt" runat="server" CssClass="form-control" Width="100%"
                                        Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                    </telerik:RadNumericTextBox>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Profile Settings</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="CusProfile" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Profile Settings">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="Customer Documents" Value="CDS" />
                                            <telerik:RadComboBoxItem Text="Promotion" Value="PRM" />
                                            <telerik:RadComboBoxItem Text="Special Pricing" Value="SPR" />
                                            <telerik:RadComboBoxItem Text="Customer Itemlist" Value="CIM" />
                                            <telerik:RadComboBoxItem Text="GeoCode" Value="GCD" />
                                            <telerik:RadComboBoxItem Text="PaymentTerms" Value="PTH" />
                                            <telerik:RadComboBoxItem Text="Payterms Details" Value="PTD" />

                                        </Items>
                                    </telerik:RadComboBox>

                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Partial Delivery Approval<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlEnablePD" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Enable" Value="Y" />
                                            <telerik:DropDownListItem Text="Disable" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlEnablePD" ErrorMessage="Please select" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enable Trade License Expiry Alert<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlCusDocExpiryAlert" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                        </Items>
                                    </telerik:RadDropDownList>

                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Alert Days</label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtAlertDay" runat="server" CssClass="form-control" Width="100%"
                                        Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                    </telerik:RadNumericTextBox>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enable Price Change<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlISPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Enable" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Disable" Value="N" />

                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator47" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlISPriceChange" ErrorMessage="Please select" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Minimum Order Value</label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="rdMinOrderValue" runat="server" CssClass="form-control" Width="100%"
                                        Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                    </telerik:RadNumericTextBox>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group mb-4">
                                <label class="control-label col-lg-12">Product Group<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlproductgroup" runat="server" Width="100%" Skin="Silk" Filter="Contains" EmptyMessage="Select Table" RenderMode="Lightweight"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator55" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlproductgroup" ErrorMessage="Please Product Group" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Must sell Approval<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlMustSellApproval" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                        </Items>
                                    </telerik:RadDropDownList>

                                </div>
                            </div>
                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enable Instant Order Delivery<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlInstDelivery" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                        </Items>
                                    </telerik:RadDropDownList>

                                </div>
                            </div>


                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-6">Current Security Deposit <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtCurrentSecDeposit" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator59" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtCurrentSecDeposit" ErrorMessage="Please Enter Security Deposit" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>


                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Coupon Pay Mode</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="rdCouponPayMode" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Coupon Settings">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="Hard Cash" Value="HC" />
                                            <telerik:RadComboBoxItem Text="POS" Value="POS" />
                                            <telerik:RadComboBoxItem Text="Online Payment" Value="OP" />

                                        </Items>
                                    </telerik:RadComboBox>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enable Suggested Load Request<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlSuggLoadReq" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                        </Items>
                                    </telerik:RadDropDownList>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enable Coupon<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlISCouponEnable" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                        </Items>
                                    </telerik:RadDropDownList>

                                </div>
                            </div>


                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Insight Customer Settings </label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="rdInsCusSetting" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Insight Customer Settings">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="Sales " Value="SL" />
                                            <telerik:RadComboBoxItem Text="Order" Value="OR" />
                                            <telerik:RadComboBoxItem Text="Advance Payment" Value="AP" />
                                            <telerik:RadComboBoxItem Text="Account Recievable" Value="AR" />

                                        </Items>
                                    </telerik:RadComboBox>

                                </div>
                            </div>


                        </div>
                        <div class="col-lg-12 row" style="padding-top: 25px;"><b>Transactional Settings </b></div>
                        <br />

                        <asp:PlaceHolder ID="plsSalesorder" runat="server" Visible="false">
                            <div class="col-lg-12 row">

                                <span class="min-w-50px fw-semibold text-gray-600  "><b>Order</b></span>


                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Sales Order<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddIsSOrder" runat="server" Width="100%" DefaultMessage="Please select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddIsSOrder" ErrorMessage="Please select Sales Order" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Sales Order Remarks<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddORR" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator54" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddORR" ErrorMessage="Please select Order Request Remarks" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Sales Order Promotion<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlordpro" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator56" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlordpro" ErrorMessage="Please select Promotion in Order" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>


                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enable Order Sign</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlenableOrdrsign" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>


                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Price Change Approval in Order<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlOrdPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                    <telerik:DropDownListItem Text="Disable" Value="N" />

                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlOrdPriceChange" ErrorMessage="Please select" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enable Quotation<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlEnableQuotation" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                    <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enable Suggested Ord<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlEnableSuggestedOrd" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                    <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Attachments Order</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlIsAttachmentsOrder" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enable Free Sample Order</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlEnableFreeSampleOrder" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enable Free Sample Order Approval</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlEnableFreeSampleOrderApproval" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Option for Full Delivery</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="rdFulldelivery" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>

                                </div>

                            </asp:PlaceHolder>

                        <div class="col-lg-12 row mt-4">

                            <span class="min-w-50px fw-semibold text-gray-800 "><b>Invoice</b></span>


                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Sales Job<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlIsInvoicing" runat="server" Width="100%" DefaultMessage="Please select" OnSelectedIndexChanged="ddlIsInvoicing_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlIsInvoicing" ErrorMessage="Please select Invoicing" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <asp:PlaceHolder runat="server" ID="inv">
                                    <asp:PlaceHolder ID="pnlSalesInv" runat="server" Visible="true">
                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                            <label class="control-label col-lg-12">Sales Invoicing<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddIsI_Sales" runat="server" Width="100%" DefaultMessage="Select Sales Invoicing" Enabled="false">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddIsI_Sales" ErrorMessage="Please select Sales Invoicing" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                            </div>
                                        </div>
                                    </asp:PlaceHolder>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Good Return Invoicing<span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddIsI_GR" runat="server" Width="100%" DefaultMessage="Select Good Return Invoicing">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic"
                                                ControlToValidate="ddIsI_GR" ErrorMessage="Please select Good Return Invoicing" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Bad Return Invoicing<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddIsI_BR" runat="server" Width="100%" DefaultMessage="Select Bad Return Invoicing">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic"
                                                ControlToValidate="ddIsI_BR" ErrorMessage="Please select Bad Return Invoicing" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Free of Cost Invoicing<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddIsI_FG" runat="server" Width="100%" DefaultMessage="Select Free of Cost Invoicing">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic"
                                                ControlToValidate="ddIsI_FG" ErrorMessage="Please select Free of Cost Invoicing" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>


                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Alternative Invoice Required<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="rdAltInvReq" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="rdAltInvReq" ErrorMessage="Please select " ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Invoice   Mode<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlInvoiceMode" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Single" Value="S" />
                                                    <telerik:DropDownListItem Text="Multiple" Value="M" />
                                                    <telerik:DropDownListItem Text="Single Free Good" Value="SF" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlInvoiceMode" ErrorMessage="Please select " ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>



                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="pnlSalesJob" runat="server" Visible="true">
                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                            <label class="control-label col-lg-12">Signature Invoice<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlSI" runat="server" Width="100%">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator50" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlSI" ErrorMessage="Please select Signature Invoice" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </asp:PlaceHolder>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Invoice Remarks<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddRe" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator51" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddRe" ErrorMessage="Please select Invoice Remarks" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enable Sales Sign</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlEnablesalsign" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Free Good Exemption<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlFGExemption" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator58" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlFGExemption" ErrorMessage="Please select Free Good Exemption" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Minimum Invoice Value<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="MinInvoiceVal" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlFGsep" ErrorMessage="Please enter a value" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>

                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">FG Seperate<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlFGsep" runat="server" Width="100%" DefaultMessage="Please select" CausesValidation="false" AutoPostBack="true">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlFGsep" ErrorMessage="Please select FG Seperate" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Disable Negative Invoice Amount</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlnegativeInvAmt" runat="server" Width="100%" DefaultMessage="Please Select">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Price Change Approval in Invoice<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                    <telerik:DropDownListItem Text="Disable" Value="N" />

                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator36" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlPriceChange" ErrorMessage="Please select" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">e-Invoice Send<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddleInvoice" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />

                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddleInvoice" ErrorMessage="Please select" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Attachment Invoice<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlAttachmentInvoice" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />

                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator60" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlAttachmentInvoice" ErrorMessage="Please select" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">HC Receipt Image Mandatory<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="HCimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="None" Value="0" />
                                                    <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                    <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator37" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="HCimgMand" ErrorMessage="Please select" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">POS Receipt Image Mandatory<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="POSimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="None" Value="0" />
                                                    <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                    <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator39" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="POSimgMand" ErrorMessage="Please select" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">OP Receipt Image Mandatory<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="OPimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="None" Value="0" />
                                                    <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                    <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator40" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="OPimgMand" ErrorMessage="Please select" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">GR Settings</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="rdGRSettings" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select GR Settings">
                                                <Items>

                                                    <telerik:RadComboBoxItem Text="Open" Value="OP" />
                                                    <telerik:RadComboBoxItem Text="Restricted" Value="RE" />
                                                    <telerik:RadComboBoxItem Text="Scheduled" Value="SC" />


                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">BR Settings</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="rdBRSettings" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select BR Settings">
                                                <Items>

                                                    <telerik:RadComboBoxItem Text="Open" Value="OP" />
                                                    <telerik:RadComboBoxItem Text="Restricted" Value="RE" />
                                                    <telerik:RadComboBoxItem Text="Scheduled" Value="SC" />


                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>

                                </asp:PlaceHolder>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Enable Forecast Sales<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlEnableForecastSales" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                            </Items>
                                        </telerik:RadDropDownList>

                                    </div>
                                </div>
                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Enable Recent Sales<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlRecentSale" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                            </Items>
                                        </telerik:RadDropDownList>

                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Enable Recent Orders<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlRecentOder" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                            </Items>
                                        </telerik:RadDropDownList>

                                    </div>

                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Price Change Approval in Delivery <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlDelPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                            </Items>
                                        </telerik:RadDropDownList>

                                    </div>
                                </div>


                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Enforce buy back free<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlEnforceBuyBackfree" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                            </Items>
                                        </telerik:RadDropDownList>

                                    </div>
                                </div>

                                


                            </div>


                            <div class="col-lg-12 row">

                                <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Account Receivables</b></span>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Account Receivables<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlIsAR" runat="server" Width="100%" OnSelectedIndexChanged="ddlIsAR_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false" DefaultMessage="Please Select">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlIsAR" ErrorMessage="Please select Account Receivables" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:PlaceHolder ID="pnlAR" runat="server" Visible="true">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Signature AR<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddSAR" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator52" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddSAR" ErrorMessage="Please select Signature AR" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">AR Remarks<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddARRemarks" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator49" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddARRemarks" ErrorMessage="Please select  AR Remarks" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>


                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">AR Manual Allocation<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="IsArManAllocation" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="IsArManAllocation" ErrorMessage="Please select Order Request Remarks" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">AR Attachments<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="IsAttachmentsAR" runat="server" Width="100%"> 
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator57" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="IsAttachmentsAR" ErrorMessage="Please select is Attachment needed" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>                                  
                                </asp:PlaceHolder>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">HC Receipt Image Mandatory<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ARHCingmand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="None" Value="0" />
                                                <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator41" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ARHCingmand" ErrorMessage="Please select" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">POS Receipt Image Mandatory<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ARPOSimgMnad" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="None" Value="0" />
                                                <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator42" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ARPOSimgMnad" ErrorMessage="Please select" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">OP Receipt Image Mandatory<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="AROPimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="None" Value="0" />
                                                <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator43" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="AROPimgMand" ErrorMessage="Please select" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">CH Receipt Image Mandatory<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ARCHimgMnad" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="None" Value="0" />
                                                <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator44" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ARCHimgMnad" ErrorMessage="Please select" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">AR Payment Modes</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="rdARPayMode" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select AR Payment">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Hard Cash" Value="HC" />
                                                <telerik:RadComboBoxItem Text="POS" Value="POS" />
                                                <telerik:RadComboBoxItem Text="Online Payment" Value="OP" />

                                            </Items>
                                        </telerik:RadComboBox>

                                    </div>
                                </div>



                            </div>


                            <div class="col-lg-12 row">

                                <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Advance Payment</b></span>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Advance Payment<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddladvpay" runat="server" Width="100%" DefaultMessage="Please Select">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator38" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddladvpay" ErrorMessage="Please select Advance Payment" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 row">

                                <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Inventory Monitoring</b></span>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Inventory Monitoring<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddIsMerchand" runat="server" Width="100%" OnSelectedIndexChanged="ddIsMerchand_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddIsMerchand" ErrorMessage="Please select Inventory Monitoring" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>


                                <asp:PlaceHolder ID="pnlMandFeat" runat="server" Visible="true">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Inventory Monitoring Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlMandColumns" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Inventory Monitoring Feature">
                                                <Items>

                                                    <telerik:RadComboBoxItem Text="Out Of Stock" Value="OOS" />
                                                    <telerik:RadComboBoxItem Text="Item Availability" Value="ITA" />
                                                    <telerik:RadComboBoxItem Text="Item Pricing" Value="ITP" />
                                                    <telerik:RadComboBoxItem Text="Customer Inventory" Value="CUI" />


                                                </Items>
                                            </telerik:RadComboBox>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlMandColumns" ErrorMessage="  Please  select Merchandising Features" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Mandatory Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlmandfeatures" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select MandotoryFeature">
                                                <Items>

                                                    <telerik:RadComboBoxItem Text="Out Of Stock" Value="OOS" />
                                                    <telerik:RadComboBoxItem Text="Item Availability" Value="ITA" />
                                                    <telerik:RadComboBoxItem Text="Item Pricing" Value="ITP" />
                                                    <telerik:RadComboBoxItem Text="Customer Inventory" Value="CUI" />

                                                </Items>
                                            </telerik:RadComboBox>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlMandColumns" ErrorMessage="  Please  select Mandatory Columns" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                        </div>
                                    </div>



                                </asp:PlaceHolder>

                            </div>
                            <div class="col-lg-12 row">
                                <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Activity Management</b></span>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Activity Management<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlIsActManage" runat="server" Width="100%" OnSelectedIndexChanged="ddlIsActManage_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator45" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlIsActManage" ErrorMessage="Please select Activity Management" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:PlaceHolder ID="pnlActmanage" runat="server" Visible="true">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Activity Management Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlActManage" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Activity Management Feature">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Competitor  Activities" Value="COA" />
                                                    <telerik:RadComboBoxItem Text="Survey" Value="SUY" />
                                                    <telerik:RadComboBoxItem Text="Display Agreements" Value="DIA" />
                                                    <telerik:RadComboBoxItem Text="Task" Value="TAS" />
                                                    <telerik:RadComboBoxItem Text="Image Capture" Value="IMC" />
                                                    <telerik:RadComboBoxItem Text="Customer Activity" Value="CUA" />

                                                </Items>
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Mandotory Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlAMMand" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select mandotory Features">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Competitor  Activities" Value="COA" />
                                                    <telerik:RadComboBoxItem Text="Survey" Value="SUY" />
                                                    <telerik:RadComboBoxItem Text="Display Agreements" Value="DIA" />
                                                    <telerik:RadComboBoxItem Text="Task" Value="TAS" />
                                                    <telerik:RadComboBoxItem Text="Image Capture" Value="IMC" />
                                                    <telerik:RadComboBoxItem Text="Customer Activity" Value="CUA" />

                                                </Items>
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                </asp:PlaceHolder>

                            </div>
                            <div class="col-lg-12 row">
                                <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Customer Service</b></span>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Customer Service<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlISCusService" runat="server" Width="100%" OnSelectedIndexChanged="ddlISCusService_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator46" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlIsActManage" ErrorMessage="Please select Customer Service" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:PlaceHolder ID="pnlCusService" runat="server" Visible="true">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Customer Service Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlCusService" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Customer Service Feature">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Customer Complaints" Value="CUC" />
                                                    <telerik:RadComboBoxItem Text="Customer Request" Value="CUR" />
                                                    <telerik:RadComboBoxItem Text="Credit Note Request" Value="CNR" />
                                                    <telerik:RadComboBoxItem Text="Dispute Note Request" Value="DIS" />
                                                    <telerik:RadComboBoxItem Text="Scheduled Return Request" Value="SRR" />
                                                    <telerik:RadComboBoxItem Text="Planogram" Value="PNG" />

                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Mandotory Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlCSMand" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Mandotory Feature">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Customer Complaints" Value="CUC" />
                                                    <telerik:RadComboBoxItem Text="Customer Request" Value="CUR" />
                                                    <telerik:RadComboBoxItem Text="Credit Note Request" Value="CNR" />
                                                    <telerik:RadComboBoxItem Text="Dispute Note Request" Value="DIS" />
                                                    <telerik:RadComboBoxItem Text="Scheduled Return Request" Value="SRR" />
                                                    <telerik:RadComboBoxItem Text="Planogram" Value="PNG" />

                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>
                            </div>
                            <div class="col-lg-12 row">

                                <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Field Service</b></span>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">IsFieldService<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlFS" runat="server" Width="100%" OnSelectedIndexChanged="ddlFS_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlFS" ErrorMessage="Please Select" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:PlaceHolder ID="pnlFS" runat="server" Visible="false">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Field Service Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlFSFeatures" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Field Service Feature">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Asset Tracking" Value="AT" />
                                                    <telerik:RadComboBoxItem Text="Service Request" Value="SR" />
                                                    <telerik:RadComboBoxItem Text="Service Job" Value="SJ" />


                                                </Items>
                                            </telerik:RadComboBox>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlMandColumns" ErrorMessage="  Please  select Merchandising Features" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>
                            </div>




                            <br />







                            <%--</telerik:RadAjaxPanel>--%>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary"></asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 650px;">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="Success"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

                        <asp:LinkButton ID="Proceedmap" runat="server" Text="Proceed with Item Mapping" OnClick="Proceedmap_Click" CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="false" Visible="false" />
                        <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary" Text="OK" Visible="true"></asp:LinkButton>
                        <asp:LinkButton ID="btnspclpriceassign" runat="server" OnClick="btnspclpriceassign_Click" CssClass="btn btn-sm fw-bold btn-primary" Text="Assign Special Price"></asp:LinkButton>

                        <asp:LinkButton ID="lnkGotoCus" runat="server" OnClick="lnkGotoCus_Click" CssClass="btn btn-sm fw-bold btn-warning">Go to Customer</asp:LinkButton>

                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <%-- <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_4);">Cancel</button>--%>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="FailureAlert" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Failure</h5>
                </div>
                <div class="modal-body">
                    <span style="color: red"><strong></strong>&nbsp;&nbsp; <span id="failres"></span></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(FailureAlert);">Dismiss</button>
                </div>
            </div>
        </div>
    </div>

    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="fail"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
