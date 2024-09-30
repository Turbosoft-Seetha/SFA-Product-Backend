<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
    <div class="kt-portlet">
        <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
            <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                <div>

                    <div class="col-lg-12 row" style="padding-top: 10px;">

                        <div class="col-lg-8 row">
                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true" Width="100%">
                                    </telerik:RadDatePicker>
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MM-yyyy" runat="server" AutoPostBack="true"  Width="100%">
                                    </telerik:RadDatePicker>
                                    <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                </div>
                            </div>

                            <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click">
                                            Apply Filter
                        </asp:LinkButton>
                            </div>
                        </div>
                       
                    </div>


                </div>

            </div>
        </div>
    </div>
</div>

    <div class="post d-flex flex-column-fluid" id="kt_post">
        <div id="kt_content_container" class="col-lg-12">
            <div class="row">
                <!-- Add a row container -->
                <div class="col-xl-6">
                    <!-- First Grid Column -->
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                    <div class="kt-portlet__body" style="margin-top: 20px;">
                                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                         <div class="col-lg-6"> <h4>Customer Headers</h4> </div>
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
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="cus_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="200px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="invNoperAmount" AllowFiltering="true" HeaderStyle-Width="120px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Inv. No/ Amount" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="invNoperAmount">
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
                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                    BackColor="Transparent"
                                    ForeColor="Blue">
                                    <div class="col-lg-12 text-center mt-5">
                                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                    </div>
                                </telerik:RadAjaxLoadingPanel>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-6">
                    <!-- Second Grid Column -->
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                    <div class="kt-portlet__body" style="margin-top: 20px;">
                                         <div class="col-lg-6"> <h4>Customer Outlets</h4> </div>
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="RadGrid1" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="RadGrid1_NeedDataSource"
                                            OnItemCommand="RadGrid1_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="cus_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Cus. Header" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Out. Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Outlet" AllowFiltering="true" HeaderStyle-Width="200px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Outlet" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="Outlet">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="invNoperAmount" AllowFiltering="true" HeaderStyle-Width="120px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Inv. No/ Amount" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="invNoperAmount">
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
                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                    BackColor="Transparent"
                                    ForeColor="Blue">
                                    <div class="col-lg-12 text-center mt-5">
                                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                    </div>
                                </telerik:RadAjaxLoadingPanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 mt-8">
        <!--begin::Mixed Widget 14-->
        <div class="card bgi-no-repeat card-xl-stretch mb-lg-8" style="background-color: #6397b2; background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
            <!--begin::Head-->
            <div class="card-header" style="border-bottom: 0px;">
                <!--begin::Title-->
                <h3 class="card-title align-items-start flex-column">
                    <asp:LinkButton ID="totalInvoices" runat="server" OnClick="totalInvoices_Click">
                        <span class="card-label fw-bold text-dark">
                            <asp:Label ID="lblTotalInvoice" runat="server" Text="0" ForeColor="White"></asp:Label></span>
                        <span class="text-grey-400 mt-1 fw-semibold fs-6" style="color: white;">Total Invoices</span>
                    </asp:LinkButton>
                </h3>

                <!--end::Title-->
                <!--begin::Toolbar-->
                <div class="card-toolbar">
                    <p class="" style="color: white; margin-bottom: 0.5rem !important">
                        <span style="font-size: 15px;">
                            <asp:Label ID="lblCurrency" runat="server"></asp:Label></span>
                        <span class="" style="font-size: 17px;">
                            <asp:Label ID="lblTotalInvoiceSum" runat="server" Text="0"></asp:Label></span>
                    </p>
                </div>
                <!--end::Toolbar-->
            </div>
            <!--end::Head-->
            <!--begin::Body-->
            <div class="card-body d-flex flex-column mb-8">
                <!--begin::Row-->
                <div class="row  g-0 p-3">

                    <!--begin::Col-->
                    <div class="col-3">
                        <div class="d-flex align-items-center mb-12 me-2">
                            <!--begin::Symbol-->
                            <div class="symbol symbol-40px me-3">
                                <div class="symbol-label bg-white bg-opacity-90" style="width: 50px; height: 50px;">
                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                        <img src="../assets/media/dashboard/invoices.png" alt="Invoice" width="34" height="34" />
                                    </span>
                                    <!--end::Svg Icon-->
                                </div>
                            </div>
                            <!--end::Symbol-->
                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="lnkSales" runat="server" OnClick="lnkSales_Click">
                                    <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                        <asp:Label ID="lblTotalInvoices" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Sales</div>
                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                        <asp:Label ID="Label3" runat="server"></asp:Label>
                                        <span class="" style="font-size: 17px;">
                                            <asp:Label ID="lblTotalInvoicesSum" runat="server" Text="AED 0.00"></asp:Label>
                                        </span>
                                    </div>

                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                    <!--end::Col-->
                    <!--begin::Col-->
                    <div class="col-3">
                        <div class="d-flex align-items-center mb-12 ms-2">
                            <!--begin::Symbol-->
                            <div class="symbol symbol-40px me-3">
                                <div class="symbol-label bg-white bg-opacity-90" style="width: 50px; height: 50px;">
                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                        <img src="../assets/media/dashboard/gr.png" alt="Good Return" width="34" height="34" />
                                    </span>
                                    <!--end::Svg Icon-->
                                </div>
                            </div>
                            <!--end::Symbol-->
                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="lnkGRReturns" runat="server" OnClick="lnkGRReturns_Click">
                                    <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                        <asp:Label ID="lblTotalGReturns" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Good Return</div>
                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                        <asp:Label ID="Label5" runat="server"></asp:Label>
                                        <span class="" style="font-size: 17px;">
                                            <asp:Label ID="lblTotalGReturnsSum" runat="server" Text="AED 0.00"></asp:Label>
                                        </span>
                                    </div>

                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                    <!--end::Col-->
                    <!--begin::Col-->
                    <div class="col-3">
                        <div class="d-flex align-items-center me-2 mb-9">
                            <!--begin::Symbol-->
                            <div class="symbol symbol-40px me-3">
                                <div class="symbol-label bg-white bg-opacity-90" style="width: 50px; height: 50px;">
                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                        <img src="../assets/media/dashboard/br.png" alt="Bad Return" width="34" height="34" />
                                    </span>
                                    <!--end::Svg Icon-->
                                </div>
                            </div>
                            <!--end::Symbol-->
                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="lnkBRReturns" runat="server" OnClick="lnkBRReturns_Click">

                                    <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                        <asp:Label ID="lblTotalBReturns" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Bad Return</div>
                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                        <asp:Label ID="Label6" runat="server"></asp:Label>
                                        <span class="" style="font-size: 17px;">
                                            <asp:Label ID="lblTotalBReturnsSum" runat="server" Text="AED 0.00"></asp:Label>
                                        </span>
                                    </div>

                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                    <!--end::Col-->
                    <!--begin::Col-->
                    <div class="col-3">
                        <div class="d-flex align-items-center ms-2 mb-9">

                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="lnkFreeGood" runat="server" OnClick="lnkFreeGood_Click">
                                    <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                        <asp:Label ID="lblTotalFreeGoods" runat="server" Text="0"></asp:Label>
                                    </div>

                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Free of Cost</div>
                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                        <asp:Label ID="Label4" runat="server"></asp:Label>
                                        <span class="" style="font-size: 17px;">
                                            <asp:Label ID="lblFOCSum" runat="server" Text="AED 0.00"></asp:Label>
                                        </span>
                                    </div>
                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                    <!--end::Col-->
                </div>
                <!--end::Row-->
            </div>

        </div>

    </div>
   
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
