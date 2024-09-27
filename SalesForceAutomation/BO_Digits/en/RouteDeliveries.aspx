<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteDeliveries.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteDeliveries" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body p-8" style="background-color: white;">
         <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
        <div class="col-lg-12 row ">

            <div class="col-lg-2">
                <label class="control-label col-lg-12">From Date</label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight"  OnSelectedDateChanged="rdDate_SelectedDateChanged" ID="rdDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" AutoPostBack="true">
                    </telerik:RadDatePicker>
                </div>
            </div>
            <div class="col-lg-2">
                <label class="control-label col-lg-12">To Date</label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" OnSelectedDateChanged="rdendDate_SelectedDateChanged" AutoPostBack="true" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
                    </telerik:RadDatePicker>
                    <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdDate" ErrorMessage="To date must be greater"
                        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                </div>
            </div>


            <div class="col-lg-3">
                <label class="control-label col-lg-12">Route</label>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Filter="Contains" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged"></telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="dfs" runat="server" ControlToValidate="rdRoute" ForeColor="Red" ErrorMessage="Please Choose Route"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-lg-3">
                <label class="control-label col-lg-12">Customer</label>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="rdCustomer" runat="server" EmptyMessage="Select Customer" Filter="Contains" Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true"></telerik:RadComboBox>
                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdCustomer"  ForeColor="Red" ErrorMessage="Please Choose Customer"
                                    Display="Dynamic"></asp:RequiredFieldValidator>--%>
                </div>
            </div>
            <div class="col-lg-2 pt-5" style="text-align: center; ">
                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkFilter_Click">
                                                    Apply Filter
                </asp:LinkButton>
            </div>

        </div>
               
        <div class="col-xl-12 row ms-2 mt-10">
            <!--begin::Row-->
            <div class="col-xl-12  mb-5 mb-xl-10">
                <!--begin::Timeline Widget 1-->
                <div class="card card-flush h-xl-100">

                    <!--begin::Card toolbar-->
                    <div class="card-toolbar">
                        <div class="p-4" style="background-color: #f5f8fa;">
                            <!--begin::Tabs-->
                            <ul class="nav col-lg-12">
                                <li class="nav-item col-lg-3" style="width: 30%;">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-secondary fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_All">
                                        <div class="nav-icon">
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1 p-2 px-8">All</span>
                                        <!--end::Subtitle-->
                                        <div>
                                            <asp:Label ID="lblAllCount" runat="server" CssClass="fw-bold fs-6 text-gray-700"></asp:Label>

                                        </div>

                                    </a>

                                </li>
                              
                               
                               
                                <li class="nav-item col-lg-3" style="width: 30%;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-secondary fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_FullyDelivered">
                                        <!--begin::Icon-->
                                        <div class="nav-icon">
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1 p-2 px-8">Delivered</span>
                                        <!--end::Subtitle-->
                                        <div>
                                            <asp:Label ID="lblFDCount" runat="server" Text="40" CssClass="fw-bold fs-6 text-gray-700"></asp:Label>
                                       
                                        </div>
                                    </a>
                                </li>
                                <li class="nav-item col-lg-3" style="width: 30%;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-secondary fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_NotDelivered">
                                        <!--begin::Icon-->
                                        <div class="nav-icon">
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1 p-2 px-8">Not Delivered</span>
                                        <!--end::Subtitle-->
                                        <div>
                                            <asp:Label ID="lblNDCount" runat="server" Text="40" CssClass="fw-bold fs-6 text-gray-700"></asp:Label>
                                        
                                        </div>
                                    </a>
                                </li>
                            </ul>
                            <!--end::Tabs-->
                        </div>
                    </div>
                    <!--end::Card toolbar-->

                    <!--end::Card header-->
                    <div class="separator separator-groove mt-10"></div>

                    <!--begin::Card body-->
                    <div class="card-body p-0">
                         <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <!--begin::Tab content-->
                        <div class="tab-content">
                            <!--begin::Tab pane-->
                            <div class="tab-pane active" id="kt_timeline_widget_1_All" role="tabpanel" aria-labelledby="day-tab" data-kt-timeline-widget-1-blockui="true">
                                <div class="table-responsive">
                                    <!--begin::Table-->
                                    
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px" ></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="ord_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                             <telerik:GridTemplateColumn HeaderStyle-Width="30px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                               <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered On" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="ord_ExpectedDelDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Expected Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_ExpectedDelDate">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks">
                                        </telerik:GridBoundColumn>
                                      
                                        


                                    </Columns>
                                </MasterTableView>
                                 <PagerStyle AlwaysVisible="true" />
                                <GroupingSettings CaseSensitive="false" />
                                <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                    <Resizing AllowColumnResize="true"></Resizing>
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                </ClientSettings>
                            </telerik:RadGrid>
                                 
                                    <!--end::Table-->
                                    <div hidden="hidden">
                                        <div id="kt_timeline_widget_1_1" class="vis-timeline-custom h-350px min-w-700px" data-kt-timeline-widget-1-image-root="assets/media/"></div>
                                    </div>

                                    <!--end::Timeline-->
                                    <!--end::Timeline-->
                                </div>
                            </div>
                            <!--end::Tab pane-->
                           
                            <!--begin::Tab pane-->
                            <div class="tab-pane" id="kt_timeline_widget_1_FullyDelivered" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">

                                <div class="table-responsive pb-0 vis-timeline-custom">
                                    <!--begin::Table-->
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="RadGrid3" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="RadGrid3_NeedDataSource"
                                        OnItemCommand="RadGrid3_ItemCommand"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px" ></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="sal_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                             <telerik:GridTemplateColumn HeaderStyle-Width="30px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                         <telerik:GridBoundColumn DataField="sal_number" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Sales No" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="sal_number">
                                        </telerik:GridBoundColumn>


                                               <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered On" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Delivery Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
                                        </telerik:GridBoundColumn>
                                          <telerik:GridBoundColumn DataField="ord_ExpectedDelDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Expected Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_ExpectedDelDate">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="ord_DeliveryStatus" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Delivery Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_DeliveryStatus">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks">
                                        </telerik:GridBoundColumn>
                                      
                                        


                                    </Columns>
                                </MasterTableView>
                                 <PagerStyle AlwaysVisible="true" />
                                <GroupingSettings CaseSensitive="false" />
                                <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                    <Resizing AllowColumnResize="true"></Resizing>
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                </ClientSettings>
                            </telerik:RadGrid>
                                    <!--end::Table-->


                                    <!--end::Timeline-->
                                </div>
                            </div>
                            <!--end::Tab pane-->
                            <!--begin::Tab pane-->
                            <div class="tab-pane" id="kt_timeline_widget_1_NotDelivered" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">

                                <div class="table-responsive pb-0 vis-timeline-custom">
                                    <!--begin::Table-->
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="RadGrid4" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="RadGrid4_NeedDataSource"
                                OnItemCommand="RadGrid4_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px" ></Scrolling>
                                </ClientSettings>
                                 <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="ord_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                             <telerik:GridTemplateColumn HeaderStyle-Width="30px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                               <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered On" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="ord_ExpectedDelDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Expected Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_ExpectedDelDate">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks">
                                        </telerik:GridBoundColumn>
                                      
                                        


                                    </Columns>
                                </MasterTableView>
                                 <PagerStyle AlwaysVisible="true" />
                                <GroupingSettings CaseSensitive="false" />
                                <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                    <Resizing AllowColumnResize="true"></Resizing>
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                </ClientSettings>
                            </telerik:RadGrid>
                                    <!--end::Table-->


                                    <!--end::Timeline-->
                                </div>
                            </div>
                            <!--end::Tab pane-->
                        </div>
                        <!--end::Tab content-->
                    </div>
                    <!--end::Card body-->
                </div>
                <!--end::Timeline Widget 1-->
            </div>
            <!--end::Row-->
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
