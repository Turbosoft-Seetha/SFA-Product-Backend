<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteWiseServiceJobsHeader.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteWiseServiceJobsHeader" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <span class="fw-bolder"> Date : </span> 
    <asp:Label runat="server" ID="lbldate" Text=""></asp:Label>
    <span class="mx-4 fw-bolder"> Route :  </span>
    <asp:Label runat="server" ID="lblroute" Text=""></asp:Label>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <asp:PlaceHolder ID="pnlPlanned" runat="server" Visible="true">
            <div class="col-lg-12 row" style="padding-top: 10px;">
                <ul class="nav nav-pills nav-pills-custom mb-3" style="justify-content:space-around;">

                    <li class="nav-item col-lg-4 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 active " data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 27.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_1">
                         
                  
                        <%--<h6 style="text-align: left;padding-left: 10px;">--%>
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label  fw-bold fs-3 mb-1">
                                <asp:Label ID="lblAllCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       <%-- </h6>--%>
                       <%-- <h6 style="text-align: left;padding-left: 10px;">--%>
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1" style="padding-top: 20px">
                                <asp:Label ID="lblAll" Text="All Planned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       <%-- </h6>--%>
                    </li>
                    <li class="nav-item col-lg-4 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 27.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_2">
                        <%--  <a class="nav-link text-black  fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_2">Sales Orders
                                    
                        </a>--%>
                      <%--  <h6 style="text-align: left;padding-left: 10px;">--%>
                         <div style="text-align: left; padding-left: 5px;">
                            <span class="card-label fw-bold fs-3 mb-1" style="align-items:flex-start;">
                                <asp:Label ID="lblOpenCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                             </div>
                      <%--  </h6>--%>
                      <%--  <h6 style="text-align: left;padding-left: 10px;">--%>
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1  " style="padding-top: 20px">
                                <asp:Label ID="lblOpen" Text="Pending" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       <%-- </h6>--%>

                    </li>
                    <li class="nav-item col-lg-4 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 27.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_3">
                        <%--  <a class="nav-link text-black fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_3">Confirmed Sales Orders 
                
                        </a>--%>
                        <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1">
                                <asp:Label ID="lblATCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                      </div>
                       <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 " style="padding-top: 20px">
                                <asp:Label ID="lblAT" Text="Visited" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                      </div>

                    </li>
                    
                </ul>
            </div>
            </asp:PlaceHolder>

           <asp:PlaceHolder ID="pnlActual" runat="server" Visible="true">
            <div class="col-lg-12 row" style="padding-top: 10px;">
                <ul class="nav nav-pills nav-pills-custom mb-3" style="justify-content:space-around;">

                    <li class="nav-item col-lg-4 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 active " data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 27.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_4">
                         
                  
                        
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label  fw-bold fs-3 mb-1">
                                <asp:Label ID="lblAllVisited" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1" style="padding-top: 20px">
                                <asp:Label ID="Label2" Text="All Visited" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                       


                    </li>
                    <li class="nav-item col-lg-4 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 27.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_5">
                        
                         <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1" style="align-items:flex-start;">
                                <asp:Label ID="lblPlannedCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                             </div>
                      
                          <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1  " style="padding-top: 20px">
                                <asp:Label ID="Label4" Text="Planned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                              </div>
                      

                    </li>
                    <li class="nav-item col-lg-4 nav-link btn btn-sm  btn-active  fs-4 fw-bold px-4 me-1 " data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 27.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_6">
                        
                        <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1">
                                <asp:Label ID="lblUnplanned" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                      </div>
                       <div style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 " style="padding-top: 20px">
                                <asp:Label ID="Label6" Text="Unplanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                      </div>

                    </li>
                    
                </ul>
            </div>
            </asp:PlaceHolder>
            
            <div class="col-lg-12" style="padding-top: 10px; background-color: white; margin-top: 20px">
                <div class="tab-content" style="padding:10px;height:520px;">
                    <asp:PlaceHolder ID="pnlplannedGrids" runat="server" Visible="true">
                    <div class="tab-pane fade show active" id="kt_timeline_widget_1"  style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:500px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->



                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvTodaysJob" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvTodaysJob_NeedDataSource"
                                    OnItemCommand="grvTodaysJob_ItemCommand"
                                     OnItemDataBound="grvTodaysJob_ItemDataBound"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="sjh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" UniqueName="detail" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadDetail" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                           
                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Serial Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ScheduledDate">
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
                        </div>

                    </div>
                    <div class="tab-pane fade show active" id="kt_timeline_widget_2" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:500px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                            <div class="kt-portlet__body">
                                <%--<telerik:RadSkinManager ID="RadSkinManager16" runat="server" Skin="Material" />--%>
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvTodayOpen" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvTodayOpen_NeedDataSource"
                                    OnItemCommand="grvTodayOpen_ItemCommand"
                                     OnItemDataBound="grvTodayOpen_ItemDataBound"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="sjh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" UniqueName="detail" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadDetail1" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Serial Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ScheduledDate">
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
                            </div>
                        </div>

                    </div>
                    <div class="tab-pane fade show active" id="kt_timeline_widget_3" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive"style="height:500px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                            <div class="kt-portlet__body">
                                <%--<telerik:RadSkinManager ID="RadSkinManager16" runat="server" Skin="Material" />--%>
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvTodayActionTaken" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvTodayActionTaken_NeedDataSource"
                                    OnItemCommand="grvTodayActionTaken_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="sjh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" UniqueName="detail" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                              <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Serial Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ScheduledDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ActualEndTime" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ActualEndTime">
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
                            </div>
                        </div>

                    </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="pnlActualGrids" runat="server" Visible="true">
                    <div class="tab-pane fade show active" id="kt_timeline_widget_4"  style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive"style="height:500px;">



                            <!--begin::Portlet-->
                            <div class="kt-portlet__body">
                                <%--<telerik:RadSkinManager ID="RadSkinManager17" runat="server" Skin="Material" />--%>
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvTotalPlanned" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvTotalPlanned_NeedDataSource"
                                    OnItemCommand="grvTotalPlanned_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="sjh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" UniqueName="detail" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                          <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Serial Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ScheduledDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ActualEndTime" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ActualEndTime">
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
                            </div>

                            <!--end: Search Form -->

                           
                        </div>

                    </div>
                    
                    <div class="tab-pane fade show " id="kt_timeline_widget_5" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive"style="height:500px;">



                            <!--begin::Portlet-->
                            <div class="kt-portlet__body">
                                <%--<telerik:RadSkinManager ID="RadSkinManager17" runat="server" Skin="Material" />--%>
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvPlanned" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvPlanned_NeedDataSource"
                                    OnItemCommand="grvPlanned_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="sjh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" UniqueName="detail" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                          <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Serial Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ScheduledDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ActualEndTime" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ActualEndTime">
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
                            </div>

                            <!--end: Search Form -->

                           
                        </div>

                    </div>
                    <div class="tab-pane fade show " id="kt_timeline_widget_6" style="height:500px;">
                        <!--begin::Table container-->
                        <div class="table-responsive"style="height:500px;">



                            <!--begin::Portlet-->
                            <div class="kt-portlet__body">
                                <%--<telerik:RadSkinManager ID="RadSkinManager17" runat="server" Skin="Material" />--%>
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvUnplanned" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvUnplanned_NeedDataSource"
                                    OnItemCommand="grvUnplanned_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="sjh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" UniqueName="detail" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                          <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Serial Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ScheduledDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sjh_ActualEndTime" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sjh_ActualEndTime">
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
                            </div>

                            <!--end: Search Form -->

                           
                        </div>

                    </div>
                        </asp:PlaceHolder>
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