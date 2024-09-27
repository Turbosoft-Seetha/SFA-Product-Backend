<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="SettlementReports.aspx.cs" Inherits="SalesForceAutomation.Admin.SettlementReports" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function failedModal(res) {
            $('#kt_modal_1_6').modal('show');
            $('#failres').text(res);
        }
        function loadOutModal() {
            $('#kt_modal_1_7').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtHardCash">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblHardCashVariance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtPos">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblPOSVariance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtOnlinePayment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblOnlinePaymentVariance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <div style="display: grid">
                                <div style="display: block">
                                    <h3 class="kt-portlet__head-title">Settlement Report
                                    </h3>
                                </div>
                                <div style="display: block">
                                    <div class="kt-subheader__breadcrumbs">
                                        <a href="UserDailyProcess.aspx" class="kt-subheader__breadcrumbs">
                                            <i class="flaticon2-shelter"></i> User Daily Process </a>
                                        <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>--%>
                                        <span class="kt-subheader__breadcrumbs-separator">></span>
                                        <a class="kt-subheader__breadcrumbs-link">Settlement Report </a>
                                        <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="kt-portlet__head-actions" style="width:40%;">
                            <div class="col-lg-12 row" style="font-size: 15px;">
                                <div class="col-lg-6 row">
                                <div class="col-lg-5">
                                    <label class="control-label col-lg-12" style="padding-top: 10px;">Route: </label>
                                </div>
                                <div class="col-lg-7" style="font-weight: 600;padding-top: 10px;">
                                    <%--<telerik:RadComboBox ID="ddlRoute" runat="server" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" EmptyMessage="Select Route" RenderMode="Lightweight"></telerik:RadComboBox>--%>
                                    <asp:Label ID="lblRoute" runat="server"></asp:Label>
                                </div>
                                </div>
                                <div class="col-lg-6 row">
                                    <div class="col-lg-7">
                                    <label class="control-label col-lg-12" style="padding-top: 10px;">LO Status: </label>
                                </div>
                                <div class="col-lg-5" style="font-weight: 600;padding-top: 10px;">
                                    <%--<telerik:RadComboBox ID="ddlRoute" runat="server" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" EmptyMessage="Select Route" RenderMode="Lightweight"></telerik:RadComboBox>--%>
                                    <asp:Label ID="lblLoadOutStatus" runat="server"></asp:Label>
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="kt-portlet__body">
                        <div class="col-lg-12 row">

                            <div class="demo-container size-medium">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                <telerik:RadWizard RenderMode="Lightweight" ID="RadWizard1" runat="server" Height="700px" OnFinishButtonClick="RadWizard1_FinishButtonClick">
                                    <WizardSteps>
                                        <telerik:RadWizardStep Title="Orders Report" CssClass="loginStep">
                                            <div class="kt-portlet">
                                                <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h3 class="kt-portlet__head-title">Order Report</h3>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__head" style="margin-top: -30px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h6>Total Orders :
                                                            <asp:Label ID="lblOrderCount" runat="server"></asp:Label></h6>
                                                    </div>
                                                    <div class="kt-portlet__head-actions">
                                                        <div class="kt-portlet__head-label">
                                                            <h6 style="padding-top: 18px;">Total Amount :
                                                                <asp:Label ID="lblOrderAmount" runat="server"></asp:Label></h6>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__body">

                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                        ID="grvOrders" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="grvOrders_NeedDataSource"
                                                        AllowFilteringByColumn="false"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="ord_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Order#" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="ord_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="ord_GrandTotal">
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
                                            </div>
                                        </telerik:RadWizardStep>
                                        <telerik:RadWizardStep Title="Credit Invoices">
                                            <div class="kt-portlet">
                                                <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h3 class="kt-portlet__head-title">Credit Invoices</h3>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__head" style="margin-top: -30px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h6>Total Credit :
                                                            <asp:Label ID="lblCreditCount" runat="server"></asp:Label></h6>
                                                    </div>
                                                    <div class="kt-portlet__head-actions">
                                                        <div class="kt-portlet__head-label">
                                                            <h6 style="padding-top: 18px;">Total Credit Amount :
                                                                <asp:Label ID="lblCreditAmount" runat="server"></asp:Label></h6>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__body">
                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                        ID="grvCredit" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="grvCredit_NeedDataSource"
                                                        AllowFilteringByColumn="false"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="inv_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Invoice#" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
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
                                            </div>
                                        </telerik:RadWizardStep>
                                        <telerik:RadWizardStep Title="Cash Invoices">
                                            <div class="kt-portlet">
                                                <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h3 class="kt-portlet__head-title">Cash Invoices</h3>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__head" style="margin-top: -30px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h6>Total Cash :
                                                            <asp:Label ID="lblCashCount" runat="server"></asp:Label></h6>
                                                    </div>
                                                    <div class="kt-portlet__head-actions">
                                                        <div class="kt-portlet__head-label">
                                                            <h6 style="padding-top: 18px;">Total Cash Amount :
                                                                <asp:Label ID="lblCashAmount" runat="server"></asp:Label></h6>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__body">
                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                        ID="grvCash" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="grvCash_NeedDataSource"
                                                        AllowFilteringByColumn="false"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="inv_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Invoice#" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
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
                                            </div>
                                        </telerik:RadWizardStep>
                                        <telerik:RadWizardStep Title="AR Collections">
                                            <div class="kt-portlet">
                                                <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h3 class="kt-portlet__head-title">AR Collection</h3>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__head" style="margin-top: -30px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h6>Total AR :
                                                            <asp:Label ID="lblARCount" runat="server"></asp:Label></h6>
                                                    </div>
                                                    <div class="kt-portlet__head-actions">
                                                        <div class="kt-portlet__head-label">
                                                            <h6 style="padding-top: 18px;">Total AR Amount :
                                                                <asp:Label ID="lblARAmount" runat="server"></asp:Label></h6>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__body">
                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                        ID="grvAR" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="grvAR_NeedDataSource"
                                                        AllowFilteringByColumn="false"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="arh_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="arh_ARNumber" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="AR#" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="arh_ARNumber">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="arh_PayType" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="arh_PayType">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="arh_CollectedAmount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="arh_CollectedAmount">
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
                                            </div>
                                        </telerik:RadWizardStep>
                                        <telerik:RadWizardStep Title="Advance Collections">
                                            <div class="kt-portlet">
                                                <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h3 class="kt-portlet__head-title">Advance Collections</h3>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__head" style="margin-top: -30px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h6>Total Advance :
                                                            <asp:Label ID="lblAdvanceCount" runat="server"></asp:Label></h6>
                                                    </div>
                                                    <div class="kt-portlet__head-actions">
                                                        <div class="kt-portlet__head-label">
                                                            <h6 style="padding-top: 18px;">Total Advance Amount :
                                                                <asp:Label ID="lblAdvanceAmount" runat="server"></asp:Label></h6>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__body">
                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                        ID="grvAdvance" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="grvAdvance_NeedDataSource"
                                                        AllowFilteringByColumn="false"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="adp_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="adp_Number" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Advance#" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="adp_Number">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="adp_PaymentMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="adp_PaymentMode">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="adp_Amount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="adp_Amount">
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
                                            </div>
                                        </telerik:RadWizardStep>
                                        <telerik:RadWizardStep Title="Payment" Active="true">
                                            <div class="kt-portlet">
                                                <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h3 class="kt-portlet__head-title">Payment</h3>
                                                    </div>
                                                </div>
                                                <div class="kt-portlet__body" style="padding-top: 0px;">
                                                    <div class="col-lg-12 row">
                                                        <div class="col-lg-12 row" style="border-bottom: 1px solid darkgrey; padding-bottom: 10px;">
                                                            <div class="col-lg-5" style="border-right: 1px solid darkgrey;">
                                                                <table class="col-lg-12">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="padding-bottom: 10px; color: green; font-weight: 400;">Cash</th>
                                                                            <th style="padding-bottom: 10px; color: green; font-weight: 400;">:</th>
                                                                            <th style="padding-bottom: 10px; color: green; font-weight: 400;"> AED  
                                                                                <asp:Label ID="lblPCash" runat="server"></asp:Label>
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">Cash Invoices</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;"> AED  
                                                                                <asp:Label ID="lblPCashInvoices" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">AR Collection Cash</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;"> AED  
                                                                                <asp:Label ID="lblPArCollectionCash" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">Advance Collection Cash</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;"> AED  
                                                                                <asp:Label ID="lblPAdvanceCash" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                            <div class="col-lg-7">
                                                                <table class="col-lg-12">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="padding-bottom: 10px;">Total Cash</th>
                                                                            <th></th>
                                                                            <th></th>
                                                                            <th style="padding-bottom: 10px;">Received Cash</th>
                                                                            <th style="padding-bottom: 10px;">Variance </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">Hard Cash</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                <asp:Label ID="lblHardCash" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                <telerik:RadAjaxPanel ID="rapHardCash" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                    <telerik:RadNumericTextBox ID="txtHardCash" runat="server" CssClass="form-control" Width="80%" AutoPostBack="true" EmptyMessage="0.00" OnTextChanged="txtHardCash_TextChanged"></telerik:RadNumericTextBox>
                                                                                </telerik:RadAjaxPanel>
                                                                            </td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                <asp:Label ID="lblHardCashVariance" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">POS</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                <asp:Label ID="lblPOS" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                <telerik:RadAjaxPanel ID="rapPos" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                    <telerik:RadNumericTextBox ID="txtPos" runat="server" CssClass="form-control" Width="80%" AutoPostBack="true" EmptyMessage="0.00" OnTextChanged="txtPos_TextChanged"></telerik:RadNumericTextBox>
                                                                                </telerik:RadAjaxPanel>
                                                                            </td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                <asp:Label ID="lblPOSVariance" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">Online Payment</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                <asp:Label ID="lblOnlinePayment" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                <telerik:RadAjaxPanel ID="rapOnlinePay" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                    <telerik:RadNumericTextBox ID="txtOnlinePayment" runat="server" CssClass="form-control" Width="80%" AutoPostBack="true" EmptyMessage="0.00" OnTextChanged="txtOnlinePayment_TextChanged"></telerik:RadNumericTextBox>
                                                                                </telerik:RadAjaxPanel>
                                                                            </td>
                                                                            <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                <asp:Label ID="lblOnlinePaymentVariance" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <div class="col-lg-12 row" style="padding-left: 0px;">
                                                                    <div class="col-lg-5" style="padding-left: 0px; padding-right: 0px;">
                                                                        <span style="font-size: 14px; color: green; font-weight: 500;">AR Collection Cheque</span>
                                                                    </div>
                                                                    <div class="col-lg-1">
                                                                        <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <span style="font-size: 14px; color: green; font-weight: 500;">AED
                                                                            <asp:Label ID="lblARCollCheque" runat="server"></asp:Label></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="col-lg-12 row" style="padding-left: 0px;">
                                                                    <div class="col-lg-6" style="padding-left: 0px; padding-right: 0px;">
                                                                        <span style="font-size: 14px; color: green; font-weight: 500;">Advance Collection Cheque</span>
                                                                    </div>
                                                                    <div class="col-lg-1">
                                                                        <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
                                                                    </div>
                                                                    <div class="col-lg-5">
                                                                        <span style="font-size: 14px; color: green; font-weight: 500;">AED
                                                                            <asp:Label ID="lblAdvCollCheque" runat="server"></asp:Label></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                            ID="grvPayment" GridLines="None"
                                                            ShowFooter="True" AllowSorting="True"
                                                            OnNeedDataSource="grvPayment_NeedDataSource"
                                                            AllowFilteringByColumn="false"
                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                            EnableAjaxSkinRendering="true"
                                                            AllowPaging="true" PageSize="10" CellSpacing="0">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                ShowFooter="false" DataKeyNames="id"
                                                                EnableHeaderContextMenu="true">
                                                                <Columns>

                                                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="name" AllowFiltering="true" HeaderStyle-Width="30px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="name">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="type" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="40%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="type">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="chequeNo" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Cheque#" FilterControlWidth="40%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="chequeNo">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="chequeDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Cheque Date" FilterControlWidth="40%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="chequeDate">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" HeaderText="Image" HeaderStyle-Width="10px" HeaderStyle-Font-Size="Smaller"
                                                                        HeaderStyle-Font-Bold="true">
                                                                        <ItemTemplate>
                                                                            <asp:HyperLink ID="Img" runat="server" NavigateUrl=' <%#  Eval("image") %>' Target="_blank">
                                                                                <asp:Image ID="Image" runat="server" ImageUrl=' <%#  Eval("image") %>' Height="65px" />
                                                                            </asp:HyperLink>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridBoundColumn DataField="amount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="amount">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="colID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="id" FilterControlWidth="40%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="colID" Display="false">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridClientSelectColumn HeaderStyle-Width="10px" UniqueName="chkAll">
                                                                    </telerik:GridClientSelectColumn>

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
                                                </div>
                                            </div>
                                        </telerik:RadWizardStep>
                                    </WizardSteps>
                                </telerik:RadWizard>
                                </telerik:RadAjaxPanel>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to update..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                    <asp:LinkButton ID="btnSave" runat="server" Text="Yes" OnClick="btnSave_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />
                        </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Received cash cannot be greater than </span><span id="failres"></span>
                </div>
                <div class="modal-footer">
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

    <!--begin::LoadOutNotDoneModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Load out not done..!</h5>
                </div>
                <div class="modal-body">
                    <span>Please complete load out in order to complete settlement.</span>
                </div>
                <div class="modal-footer">
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
