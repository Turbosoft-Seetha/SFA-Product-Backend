<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddDiscountCredits.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddDiscountCredits" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>

        function FailureAlert(res) {
            $('#FailureAlert').modal('show');
            $('#failres').text(res);
            x++;
        }

        function SaveAlert() {
            $('#SaveAlert').modal('show');
        }

        function SaveSuccess(res) {
            $('#SaveSuccess').modal('show');
            $('#clrIDs').text(res);
            $('#SaveAlert').modal('hide');
            x++;
        }

    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary" CausesValidation="False" OnClick="lnkCancel_Click" />
        <asp:LinkButton ID="lnkConfirm" runat="server" ValidationGroup="frm" OnClick="lnkConfirm_Click" UseSubmitBehavior="false" Text='Proceed' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="pnls" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

                                <div class="kt-portlet__body">

                                    <div class="col-lg-12 row mt-3">
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Customer <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlCustomer" EmptyMessage="Select Customer" Width="100%" runat="server" Filter="Contains" RenderMode="Lightweight" DateInput-DateFormat="MMM-yyyy"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCustomer" ErrorMessage="<br/> Please choose customer" ForeColor="Red" Display="Dynamic" ValidationGroup="frm"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Month <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadMonthYearPicker ID="rdMonth" OnSelectedDateChanged="rdMonth_SelectedDateChanged" AutoPostBack="true" runat="server" Width="100%" RenderMode="Lightweight" ></telerik:RadMonthYearPicker>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdMonth" ErrorMessage="<br/> Please choose month" ForeColor="Red" Display="Dynamic" ValidationGroup="frm"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Discount %<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtDiscount" Enabled="false" runat="server" Width="100%" CssClass="form-control" ></telerik:RadNumericTextBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Minimum Amount<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtAmount" Enabled="false" runat="server" Width="100%" CssClass="form-control" ></telerik:RadNumericTextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="kt-portlet__body">
                                    <h4 style="padding-top: 20px;">Applicable invoices</h4>
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        Height="300px"
                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="inv_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Number" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="CreatedOn" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Invoiced On" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedOn">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="inv_SubTotal" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_SubTotal">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <PagerStyle AlwaysVisible="true" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                            <Resizing AllowColumnResize="true"></Resizing>
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                        </ClientSettings>
                                    </telerik:RadGrid>

                                </div>
                            </telerik:RadAjaxPanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="FailureAlert" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Failure</h5>
                </div>
                <div class="modal-body">
                    <span style="color: red"><strong></strong>&nbsp;&nbsp; <span id="failres"></span></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Dismiss</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="SaveAlert" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure want to confirm?</h5>
                </div>
                <div class="modal-body">
                    <%--<telerik:RadTextBox ID="txtRemarks" EmptyMessage="Please enter remarks if any" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Width="100%"></telerik:RadTextBox>--%>
                    <small style="color: red">No Amendments once confirmed!!</small>
                </div>

                <telerik:RadAjaxPanel ID="pl" LoadingPanelID="RadAjaxLoadingPanel2" runat="server">

                    <div class="modal-footer">
                        <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="btn btn-secondary">Yes</asp:LinkButton>
                        <button type="button" class="btn btn-secondary" onclick="cancelModal(SaveAlert);">No</button>
                    </div>
                </telerik:RadAjaxPanel>

                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                    BackColor="Transparent"
                    ForeColor="Blue">
                    <div class="col-lg-12 text-center mt-5">
                        <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                    </div>

                </telerik:RadAjaxLoadingPanel>

            </div>
        </div>
    </div>

    <div class="modal fade" id="SaveSuccess" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span><strong><span id="clrIDs"></span></strong>&nbsp; Discount Credit Note has been created for this cusotmer on the selected month</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnReqSuccess" runat="server" OnClick="btnReqSuccess_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
