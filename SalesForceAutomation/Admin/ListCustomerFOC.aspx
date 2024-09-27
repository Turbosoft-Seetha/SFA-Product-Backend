<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="ListCustomerFOC.aspx.cs" Inherits="SalesForceAutomation.Admin.ListCustomerFOC" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">

                    <%--                    <div class="kt-portlet__head" style="padding-top: 20px">

                        
                         
                    </div>--%>
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title"> List Customer FOC</h3>
                            <span class="kt-subheader__separator kt-hidden"></span>
                            <div class="kt-subheader__breadcrumbs" style="padding-left: 30px">


                                <a href="ListCustomerFOC.aspx" class="kt-subheader__breadcrumbs">
                                    <i class="flaticon2-shelter"></i> List Customer FOC </a>
                                <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Reviewer/Approver Assignment </a>--%>

                                <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                            </div>
                        </div>
                        <div class="kt-portlet__head-actions">

                            <div class="row">
                                <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" Style="padding-right:30px" AlternateText="Xlsx" />



                                <asp:LinkButton ID="lnkSubCat" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" Text="Add" OnClick="lnkSubCat_Click" Style="padding-top: 14px;"></asp:LinkButton>
                            </div>
                    </div>
                </div>
                <!--end: Search Form -->
                <%--                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">--%>
                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                <div class="kt-portlet__body">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">Route</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlRoute" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Route"
                                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" RenderMode="Lightweight" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </div>

                            </div>

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">Customer</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlCustomer" runat="server" Width="100%" Filter="Contains" AutoPostBack="true" EmptyMessage="Select Customer" OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged" RenderMode="Lightweight"
                                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">Product</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlprd" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Product" OnSelectedIndexChanged="ddlprd_SelectedIndexChanged" RenderMode="Lightweight"
                                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                    </telerik:RadComboBox>
                                </div>
                            </div>

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker ID="rdFromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdFromDate"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker ID="rdEndDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                    <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="rdFromDate" ControlToValidate="rdEndDate" Operator="GreaterThanEqual"
                                        ErrorMessage="To data must be greater" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdEndDate"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-2" style="text-align: center; top: 19px;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                </asp:LinkButton>
                            </div>
                        </div>
                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                            ID="grvRpt" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="grvRpt_NeedDataSource"
                            OnItemCommand="grvRpt_ItemCommand"
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="crf_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>


                                    <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                    </telerik:GridButtonColumn>

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route  " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer  " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Name" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="crf_EligibleQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Eligible Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="crf_EligibleQty">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="crf_BalanceQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Balance Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="crf_BalanceQty">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="FromDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="From Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="FromDate">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ToDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="To Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ToDate">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Status">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>

                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
