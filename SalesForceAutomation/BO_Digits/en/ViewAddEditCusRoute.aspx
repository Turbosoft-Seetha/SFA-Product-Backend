<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditCusRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ViewAddEditCusRoute" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">


                    <div class="kt-portlet__body">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">





                            <%--<div class="col-lg-4 form-group">--%>
                            <%--<label class="control-label col-lg-12">Route <span class="required">* </span></label>--%>
                            <%--<div class="col-lg-12">--%>
                            <telerik:RadComboBox ID="ddlroute" runat="server" EmptyMessage="Select Route" CausesValidation="false" Visible="false" Width="100%" Filter="Contains" AutoPostBack="true"></telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                ControlToValidate="ddlroute" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                            <%--</div>--%>
                            <%--</div>--%>


                            <div class="col-lg-12 row"><b>Credit Terms </b></div>
                            <br />

                            <div class="col-lg-12 row">

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Customer <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlcus" runat="server" EmptyMessage="Select Customer" Width="100%" Filter="Contains"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlcus" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Payment Terms<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddcusType" runat="server" Width="100%" DefaultMessage="Select Customer Type"  CausesValidation="false">
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
                                        <label class="control-label col-lg-6">Credit Days <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="txtCDays" runat="server" CssClass="form-control" Width="100%" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="txtCDays" ErrorMessage="Please Enter Credit Days" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Allow Cash For Credit Customers<span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddPT" runat="server" Width="100%" CausesValidation="false" AutoPostBack="true" DefaultMessage="Please Select">
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
                                        <telerik:RadDropDownList ID="ddIsVAT" runat="server" Width="100%">
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
                                        <telerik:RadDropDownList ID="ddlIsHold" runat="server" Width="100%">
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
                                        <telerik:RadDropDownList ID="ddltype" runat="server" Width="100%" DefaultMessage="Select Selection Type"  CausesValidation="false" >
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
                                        <telerik:RadDropDownList ID="ddcatType" runat="server" Width="100%"  CausesValidation="false">
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
                                <asp:PlaceHolder ID="plsSalesorder" runat="server" Visible="false">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Sales Order<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddIsSOrder" runat="server" Width="100%">
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
                                </asp:PlaceHolder>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Sales Job<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlIsInvoicing" runat="server" Width="100%" emptymessage="please Select"  CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlIsInvoicing" ErrorMessage="Please select Invoicing" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <asp:PlaceHolder runat="server" ID="inv">
                                    <asp:PlaceHolder ID="pnlSalesInv" runat="server" Visible="false">
                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                            <label class="control-label col-lg-12">Sales Invoicing<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddIsI_Sales" runat="server" Width="100%" DefaultMessage="Select Sales Invoicing">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddIsI_Sales" ErrorMessage="Please select Sales Invoicing" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
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

                                </asp:PlaceHolder>
                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Account Receivables<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlIsAR" runat="server" Width="100%" CausesValidation="false">
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

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Advance Payment<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddladvpay" runat="server" Width="100%">
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

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Merchandising<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddIsMerchand" runat="server" Width="100%"  CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddIsMerchand" ErrorMessage="Please select Merchandising" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>


                                <asp:PlaceHolder ID="pnlMandFeat" runat="server" Visible="true">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Merchandising Features</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlMandColumns" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Merchandising Feature">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Delivery Check" Value="DC" />
                                                    <telerik:RadComboBoxItem Text="Out Of Stock" Value="OOS" />
                                                    <telerik:RadComboBoxItem Text="Competitor  Activities" Value="CA" />
                                                    <telerik:RadComboBoxItem Text="Customer Complaints" Value="CC" />
                                                    <telerik:RadComboBoxItem Text="Asset Tracking" Value="AT" />
                                                    <telerik:RadComboBoxItem Text="Item Availability" Value="IA" />
                                                    <telerik:RadComboBoxItem Text="Item Pricing" Value="IP" />
                                                    <telerik:RadComboBoxItem Text="Customer Inventory" Value="I" />
                                                    <telerik:RadComboBoxItem Text="Survey" Value="S" />
                                                    <telerik:RadComboBoxItem Text="Display Agreements" Value="DA" />
                                                    <telerik:RadComboBoxItem Text="Task" Value="T" />
                                                    <telerik:RadComboBoxItem Text="Image Capture" Value="IC" />

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
                                            <telerik:RadComboBox ID="ddlmandfeatures" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Merchandising Feature">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Delivery Check" Value="DC" />
                                                    <telerik:RadComboBoxItem Text="Out Of Stock" Value="OOS" />
                                                    <telerik:RadComboBoxItem Text="Competitor  Activities" Value="CA" />
                                                    <telerik:RadComboBoxItem Text="Customer Complaints" Value="CC" />
                                                    <telerik:RadComboBoxItem Text="Asset Tracking" Value="AT" />
                                                    <telerik:RadComboBoxItem Text="Item Availability" Value="IA" />
                                                    <telerik:RadComboBoxItem Text="Item Pricing" Value="IP" />
                                                    <telerik:RadComboBoxItem Text="Customer Inventory" Value="I" />
                                                    <telerik:RadComboBoxItem Text="Survey" Value="S" />
                                                    <telerik:RadComboBoxItem Text="Display Agreements" Value="DA" />
                                                    <telerik:RadComboBoxItem Text="Task" Value="T" />
                                                    <telerik:RadComboBoxItem Text="Image Capture" Value="IC" />

                                                </Items>
                                            </telerik:RadComboBox>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlMandColumns" ErrorMessage="  Please  select Mandatory Columns" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>
                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Enforce Customer Selection<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlenforcecussel" runat="server" Width="100%" DefaultMessage="Please Select">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="1" />
                                                <telerik:DropDownListItem Text="No" Value="0" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlenforcecussel" ErrorMessage="Please select " ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <br />


                            <div class="col-lg-12 row"><b>Transactional Settings </b></div>
                            <br />

                            <div class="col-lg-12 row">

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
                                    <label class="control-label col-lg-12">Print Out<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddIsPO" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator49" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddIsPO" ErrorMessage="Please select Print Out" ForeColor="Red"
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
                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="pnlSalesJob" runat="server" Visible="true">

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Signature Invoice<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlSI" runat="server" Width="100%">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator50" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="ddlSI" ErrorMessage="Please select Signature Invoice" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

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

                                </asp:PlaceHolder>

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
                                    <label class="control-label col-lg-12">Enable Order Sign<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlenableOrdrsign" runat="server" Width="100%" DefaultMessage="Please Select">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlenableOrdrsign" ErrorMessage="Please select " ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Enable Sales Sign<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlEnablesalsign" runat="server" Width="100%" DefaultMessage="Please Select">
                                            <Items>
                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                <telerik:DropDownListItem Text="No" Value="N" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlEnablesalsign" ErrorMessage="Please select " ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                 <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                    <label class="control-label col-lg-12">Invoice Mode<span class="required" > </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlInvoiceMode" runat="server" Width="100%" DefaultMessage="Please Select">
                                            <Items>
                                                <telerik:DropDownListItem Text="Single" Value="S" />
                                                <telerik:DropDownListItem Text="Multiple" Value="M" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" Display="Dynamic" ValidationGroup="form"
                                            ControlToValidate="ddlInvoiceMode" ErrorMessage="Please select " ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                            </div>


                        </telerik:RadAjaxPanel>
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

   
</asp:Content>
