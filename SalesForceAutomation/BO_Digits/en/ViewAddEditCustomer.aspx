<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditCustomer.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ViewAddEditCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-portlet__body" style="margin: 10px;">

                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                <div class="col-lg-12 row">
                                    <b>Basic Info</b>
                                    <br />
                                    <div class="col-lg-12 row">
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Name <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtName" runat="server" Rows="2" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                    <br />
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="form"
                                                        ControlToValidate="txtName" ErrorMessage="Please Enter Name " ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Name Arabic <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtArabName" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                    <br />
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="form"
                                                        ControlToValidate="txtArabName" ErrorMessage="Please Enter Name in Arabic " ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Code <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtCode" runat="server" CssClass="form-control" Width="100%" OnTextChanged="txtCode_TextChanged" AutoPostBack="true" Enabled="false"></telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="form"
                                                        ControlToValidate="txtCode" ErrorMessage="Please Enter Code " ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                    <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                                </div>
                                            </div>


                                        </div>

                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Short Name</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtShortName" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                    <br />
                                                    <%--<asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtShortName" ErrorMessage="Please Enter Short Name " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Address</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtad" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                    <br />

                                                </div>
                                            </div>

                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Address Arabic</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtArabAddress" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                    <br />

                                                </div>
                                            </div>

                                        </div>


                                        <div class="col-lg-12 row" style="padding-top: 10px;">



                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Contact Email </label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtEmail" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>

                                                    <br />

                                                </div>
                                            </div>

                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Phone</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadNumericTextBox ID="txtPerson" runat="server" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadNumericTextBox>
                                                    <br />

                                                </div>
                                            </div>

                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Whatsapp No </label>
                                                <div class="col-lg-12">
                                                    <telerik:RadNumericTextBox ID="txtwhatsNo" runat="server" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadNumericTextBox>
                                                    <br />

                                                </div>
                                            </div>
                                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                <label class="control-label col-lg-12">Contact Person <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtContactPerson" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                    <br />
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ValidationGroup="form"
                                                        ControlToValidate="txtContactPerson" ErrorMessage="Please Enter Name  " ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                <label class="control-label col-lg-12">Contact Person Arabic <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtARcontactPerson" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                    <br />
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator13" runat="server" Display="Dynamic" ValidationGroup="form"
                                                        ControlToValidate="txtARcontactPerson" ErrorMessage="Please Enter Name in Arabic " ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                <label class="control-label col-lg-12">GeoCode</label>
                                                <div class="col-lg-12">

                                                    <telerik:RadTextBox ID="txtGeoLoc" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>

                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-lg-12 row" style="padding-top: 10px;">


                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Recapture GeoCode <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadDropDownList ID="ddlRecapture" runat="server" Width="100%" Enabled="false">
                                                        <Items>
                                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                                            <telerik:DropDownListItem Text="No" Value="N" />
                                                        </Items>
                                                    </telerik:RadDropDownList>

                                                </div>
                                            </div>



                                            <div class="col-lg-4 form-group">
                                                <label class="control-label col-lg-12">Status <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%" Enabled="false">
                                                        <Items>
                                                            <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                                        </Items>
                                                    </telerik:RadDropDownList>

                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>



                            <div class="col-lg-12 row" style="padding-top: 15px;">
                                <b>Categorization</b>
                                <br />
                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 row" style="padding-bottom: 40px; padding-top: 10px;">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Class<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlcls" runat="server" CausesValidation="false" Width="100%" Filter="Contains" Enabled="false"
                                                    EmptyMessage="Select Class Name">
                                                </telerik:RadComboBox>
                                                <br />
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator12" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlcls" ErrorMessage="Please Enter ClassName " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Customer Type <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlcustype" runat="server" Width="100%" EmptyMessage="Select Customer Type" Filter="Contains" Enabled="false">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Normal" Value="NR" Selected="true" />
                                                        <telerik:RadComboBoxItem Text="Head Office" Value="HO" />
                                                        <telerik:RadComboBoxItem Text="Branch" Value="BR" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <br />
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlcustype" ErrorMessage="Please Select Customer Type " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>


                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Area <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlarea" runat="server" CausesValidation="false" Width="100%" Filter="Contains" Enabled="false"
                                                    EmptyMessage="Select Area Name">
                                                </telerik:RadComboBox>
                                                <br />
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlarea" ErrorMessage="Please Enter Area Name " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                            </div>


                                        </div>

                                    </div>
                                </div>
                            </div>



                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
