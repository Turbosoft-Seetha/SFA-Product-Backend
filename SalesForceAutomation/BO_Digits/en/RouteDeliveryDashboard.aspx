 <%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteDeliveryDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteDeliveryDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

    

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12" style="padding-left: 20px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div>
                        <div class="col-lg-12 row ">


                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdFromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
                                    </telerik:RadDatePicker>

                                </div>
                            </div>

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdEndDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
                                    </telerik:RadDatePicker>

                                </div>
                            </div>


                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">Delivery Route</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Filter="Contains" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged"></telerik:RadComboBox>
                                    <%-- <asp:RequiredFieldValidator ID="dfs" runat="server" ControlToValidate="rdRoute" ForeColor="Red" ErrorMessage="Please Choose Route"
                Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">Customer</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="rdCustomer" runat="server" EmptyMessage="Select Customer" Filter="Contains" Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true"></telerik:RadComboBox>
                                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdCustomer"  ForeColor="Red" ErrorMessage="Please Choose Customer"
                            Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                            <div class="col-lg-2 pt-5" style="text-align: center;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="Filter_Click">
                                            Apply Filter
                                </asp:LinkButton>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    <div class="card-body" style="padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">


            <div class="col-lg-12 row" style="padding-top: 10px;">

                <ul class="nav nav-pills nav-pills-custom mb-3" style="justify-content:space-around;">

                    <li id="liAllDeliveries" class="nav-item col-lg-3 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" 
                        data-bs-toggle="tab" style="background-color: white; width: 19.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_1" runat="server">
                         
                  
                        <%--<h6 style="text-align: left;padding-left: 10px;">--%>
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label  fw-bold fs-3 mb-1">
                                <asp:Label ID="lblAllCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       <%-- </h6>--%>
                       <%-- <h6 style="text-align: left;padding-left: 10px;">--%>
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1" style="padding-top: 20px">
                                <asp:Label ID="lblAll" Text="All Deliveries" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       <%-- </h6>--%>


                    </li>


                    <li id="liFullyDelivered" class="nav-item col-lg-3 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" 
                        data-bs-toggle="tab" style="background-color: white; width: 19.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_2" runat="server">
                        <%--  <a class="nav-link text-black  fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_2">Sales Orders
                                    
                        </a>--%>
                      <%--  <h6 style="text-align: left;padding-left: 10px;">--%>
                         <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1" style="align-items:flex-start;">
                                <asp:Label ID="lblFDCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                             </div>
                      <%--  </h6>--%>
                      <%--  <h6 style="text-align: left;padding-left: 10px;">--%>
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1  " style="padding-top: 20px">
                                <asp:Label ID="lblFD" Text="Fully Delivered" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       <%-- </h6>--%>

                    </li>
                    <li id="liPartiallyDelivered" class="nav-item col-lg-3 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" 
                        data-bs-toggle="tab" style="background-color: white; width: 19.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_3" runat="server">
                        <%--  <a class="nav-link text-black fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_3">Confirmed Sales Orders 
                
                        </a>--%>
                        <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1">
                                <asp:Label ID="lblPDCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                      </div>
                       <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 " style="padding-top: 20px">
                                <asp:Label ID="lblPD" Text="Partially Delivered" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                      </div>

                    </li>
                    <li id="liNotDelivered" class="nav-item col-lg-3 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" 
                        data-bs-toggle="tab" style="background-color: white; width: 19.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_4" runat="server">
                        <%--  <a class="nav-link text-black fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_4">Delivered
                
                        </a>--%>
                       <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1">
                                <asp:Label ID="lblNDCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                       </div>
                       <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 " style="padding-top: 20px">
                                <asp:Label ID="lblND" Text="Not Delivered" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                       </div>

                    </li>

                </ul>


            </div>
            <div class="col-lg-12" style="padding-top: 10px; background-color: white; margin-top: 20px">
                <div class="tab-content" style="padding:10px;height:520px;">
                    <div class="tab-pane fade show active" id="kt_timeline_widget_1" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:500px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->



                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRptAll" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRptAll_NeedDataSource"
                                OnItemCommand="grvRptAll_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="400px" ></Scrolling>
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
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>
                                                                          <telerik:GridBoundColumn DataField="DelRotCode" AllowFiltering="true" HeaderStyle-Width="150px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route Code" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="DelRotCode">
                                     </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="DelRotName" AllowFiltering="true" HeaderStyle-Width="180px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="DelRotName">
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
                        </div>

                    </div>
                    <div class="tab-pane fade show " id="kt_timeline_widget_2" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:500px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRptFD" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRptFD_NeedDataSource"
                                        OnItemCommand="grvRptFD_ItemCommand"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="400px" ></Scrolling>
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
                                        <telerik:GridBoundColumn DataField="DelDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Delivery Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="DelDate">
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
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>
                                          <telerik:GridBoundColumn DataField="DelRotCode" AllowFiltering="true" HeaderStyle-Width="150px"
                                                 HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route Code" FilterControlWidth="100%"
                                                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                 HeaderStyle-Font-Bold="true" UniqueName="DelRotCode">
                                             </telerik:GridBoundColumn>

                                               <telerik:GridBoundColumn DataField="DelRotName" AllowFiltering="true" HeaderStyle-Width="180px"
                                                 HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route" FilterControlWidth="100%"
                                                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                 HeaderStyle-Font-Bold="true" UniqueName="DelRotName">
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
                        </div>

                    </div>
                    <div class="tab-pane fade show " id="kt_timeline_widget_3" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive"style="height:500px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRptPD" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRptPD_NeedDataSource"
                                        OnItemCommand="grvRptPD_ItemCommand"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="400px" ></Scrolling>
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
                                        <telerik:GridBoundColumn DataField="DelDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Delivery Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="DelDate">
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
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>

                                           <telerik:GridBoundColumn DataField="DelRotCode" AllowFiltering="true" HeaderStyle-Width="150px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route Code" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="DelRotCode">
                                         </telerik:GridBoundColumn>

                                           <telerik:GridBoundColumn DataField="DelRotName" AllowFiltering="true" HeaderStyle-Width="180px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="DelRotName">
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
                        </div>

                    </div>
                    <div class="tab-pane fade show " id="kt_timeline_widget_4" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:500px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRptND" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRptND_NeedDataSource"
                                OnItemCommand="grvRptND_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="400px" ></Scrolling>
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
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="DelRotCode" AllowFiltering="true" HeaderStyle-Width="150px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route Code" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="DelRotCode">
                                         </telerik:GridBoundColumn>

                                           <telerik:GridBoundColumn DataField="DelRotName" AllowFiltering="true" HeaderStyle-Width="180px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="DelRotName">
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
                        </div>

                    </div>
                </div>

            </div>

        </div>
    </div>
    <style>
    .nav-item.active {
  
    background-image: url('../assets/media/svg/shapes/top-green.png');
    color: white;
    background-size: cover;
    /* Add any other styles for the active state */
}
    .nav-item.active a {
    color: white !important;
}

</style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>

