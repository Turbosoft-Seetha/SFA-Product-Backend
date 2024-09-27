<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SalesForecasting.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SalesForecasting" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

    <div class="col-lg-12 row ">

    
     <div class="col-lg-6">
         <label class="control-label col-lg-12">Date</label>
         <div class="col-lg-12">
             <telerik:RadDatePicker RenderMode="Lightweight" ID="rdDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
             </telerik:RadDatePicker>
         
         </div>
     </div>
     
     <div class="col-lg-6 pt-5" style="text-align: center; ">
         <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkFilter_Click">
                                             Apply Filter
         </asp:LinkButton>
     </div>

 </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="grvRptRoutes">
                <UpdatedControls>                   
                                       
                     <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCustomerCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblItemCount" />

                     <telerik:AjaxUpdatedControl ControlID="grvRptRoutes" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptCustomers" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptItems" />

                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="grvRptCustomers">
                <UpdatedControls>

                     <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCustomerCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblItemCount" />
   
                    <telerik:AjaxUpdatedControl ControlID="grvRptRoutes" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptCustomers" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptItems" />


                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="grvRptItems">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCustomerCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblItemCount" />

                    <telerik:AjaxUpdatedControl ControlID="grvRptRoutes" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptCustomers" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptItems" />
                    


                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="lnkFilter">
                <UpdatedControls>                   
                    <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCustomerCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblItemCount" />

                    <telerik:AjaxUpdatedControl ControlID="grvRptRoutes" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptCustomers" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptItems" />

                    <telerik:AjaxUpdatedControl ControlID="lblReloadTime" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RouteReset">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="rdDate" />

                     <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCustomerCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblItemCount" />

                    <telerik:AjaxUpdatedControl ControlID="grvRptRoutes" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptCustomers" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptItems" />

                </UpdatedControls>
            </telerik:AjaxSetting>

              <telerik:AjaxSetting AjaxControlID="CustomerReset">
                <UpdatedControls>
                       <telerik:AjaxUpdatedControl ControlID="rdDate" />
                     <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCustomerCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblItemCount" />

                    <telerik:AjaxUpdatedControl ControlID="grvRptRoutes" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptCustomers" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptItems" />

                </UpdatedControls>
            </telerik:AjaxSetting>

              <telerik:AjaxSetting AjaxControlID="ItemReset">
                <UpdatedControls>
                       <telerik:AjaxUpdatedControl ControlID="rdDate" />
                     <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCustomerCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblItemCount" />

                    <telerik:AjaxUpdatedControl ControlID="grvRptRoutes" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptCustomers" />
                    <telerik:AjaxUpdatedControl ControlID="grvRptItems" />

                </UpdatedControls>
            </telerik:AjaxSetting>
           

        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>



    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript"> 
            function grvRpt_RouteRowClick(sender, args) {
                /*debugger;*/
                var ClickedIndex = args._itemIndexHierarchical;
                //changed code here 
                var grid = $find("<%=grvRptRoutes.ClientID %>");
                if (grid) {
                    var MasterTable = grid.get_masterTableView();
                    var Rows = MasterTable.get_dataItems();
                    for (var i = 0; i < Rows.length; i++) {
                        var row = Rows[i];
                        if (ClickedIndex != null && ClickedIndex == i) { // newly added
                            MasterTable.fireCommand("MyClick1", ClickedIndex); // newly added
                        } // newly added
                    }
                }
            }
            function grvRpt_CustomerRowClick(sender, args) {
                /*debugger;*/
                var ClickedIndex = args._itemIndexHierarchical;
                //changed code here 
                var grid = $find("<%=grvRptCustomers.ClientID %>");
                if (grid) {
                    var MasterTable = grid.get_masterTableView();
                    var Rows = MasterTable.get_dataItems();
                    for (var i = 0; i < Rows.length; i++) {
                        var row = Rows[i];
                        if (ClickedIndex != null && ClickedIndex == i) { // newly added
                            MasterTable.fireCommand("MyClick2", ClickedIndex); // newly added
                        } // newly added
                    }
                }
            }
            function grvRpt_ItemRowClick(sender, args) {
                /*debugger;*/
                var ClickedIndex = args._itemIndexHierarchical;
                //changed code here 
                var grid = $find("<%=grvRptItems.ClientID %>");
                if (grid) {
                    var MasterTable = grid.get_masterTableView();
                    var Rows = MasterTable.get_dataItems();
                    for (var i = 0; i < Rows.length; i++) {
                        var row = Rows[i];
                        if (ClickedIndex != null && ClickedIndex == i) { // newly added
                            MasterTable.fireCommand("MyClick3", ClickedIndex); // newly added
                        } // newly added
                    }
                }
            }
        </script>
    </telerik:RadScriptBlock>
    
    <div class="col-lg-12 row">
        <div class="col-xl-4">

            <div class="row g-5 ">

                <div class="col-xl-12 mb-xl-10">
                    <!--begin::Slider Widget 1-->
                    <div id="kt_sliders_widget_1_slider1" class="card card-flush carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="5000" style="height: 127px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                        <!--begin::Header-->
                        <div class="card-header pt-5" style="display: none;">
                            <!--begin::Title-->
                            <h4 class="card-title d-flex align-items-start flex-column">
                                <span style="font-size: 17px;" class="card-label fw-bold"></span>
                            </h4>
                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body pt-8">
                            <!--begin::Carousel-->
                            <div class="d-flex flex-column content-justify-center flex-row-fluid">
                                <!--begin::Label-->
                                <div class="d-flex fw-semibold col-lg-12">
                                    <!--begin::Label-->
                                    <div class="text-xxl-start col-lg-8">
                                        <div class="flex-grow-1 me-4" style="font-size: 25px;">
                                            <%-- <span style="font-size: 25px;">--%>
                                            <asp:Label ID="lblRouteCount" runat="server" Text="0"></asp:Label>

                                            <%--  </span>--%>
                                            <%--<br />--%>
                                            <div class="flex-grow-1 me-4" style="font-size: 17px;">Forecasted Routes</div>

                                        </div>
                                    </div>
                                    <!--end::Label-->

                                </div>
                                <!--end::Label-->

                            </div>
                            <!--end::Carousel-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Slider Widget 1-->
                </div>

            </div>
        </div>
        <div class="col-xl-4">

            <div class="row g-5 ">

                <div class="col-xl-12 mb-xl-10">
                    <!--begin::Slider Widget 1-->
                    <div id="kt_sliders_widget_1_slider2" class="card card-flush carousel carousel-custom carousel-stretch slide rounded bgi-no-repeat bgi-size-cover bgi-position-y-top bgi-position-x-center h-127px" data-bs-ride="carousel" data-bs-interval="5000" style="height: 127px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); background-image: url('../assets/media/svg/shapes/top-green.png');">
                        <!--begin::Header-->
                        <div class="card-header pt-5" style="display: none;">
                            <!--begin::Title-->
                            <h4 class="card-title d-flex align-items-start flex-column">
                                <span style="font-size: 17px;" class="card-label fw-bold"></span>
                            </h4>
                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body pt-8">
                            <!--begin::Carousel-->
                            <div class="d-flex flex-column content-justify-center flex-row-fluid">
                                <!--begin::Label-->
                                <div class="d-flex fw-semibold col-lg-12">
                                    <!--begin::Label-->
                                    <div class="text-xxl-start col-lg-8" style="color: white;">
                                        <div class="flex-grow-1 me-4" style="font-size: 25px;">
                                            <%-- <span style="font-size: 25px;">--%>
                                            <asp:Label ID="lblCustomerCount" runat="server" Text="0"></asp:Label>

                                            <%--  </span>--%>
                                            <%--<br />--%>
                                            <div class="flex-grow-1 me-4" style="font-size: 17px;">Forecasted Customers</div>

                                        </div>
                                    </div>
                                    <!--end::Label-->

                                </div>
                                <!--end::Label-->

                            </div>
                            <!--end::Carousel-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Slider Widget 1-->
                </div>

            </div>
        </div>
        <div class="col-xl-4">

            <div class="row g-5 ">

                <div class="col-xl-12 mb-xl-10">
                    <!--begin::Slider Widget 1-->
                    <div id="kt_sliders_widget_1_slider3" class="card card-flush carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="5000" style="height: 127px; background-color: #4497DF; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                        <!--begin::Header-->
                        <div class="card-header pt-5" style="display: none;">
                            <!--begin::Title-->
                            <h4 class="card-title d-flex align-items-start flex-column">
                                <span style="font-size: 17px;" class="card-label fw-bold"></span>
                            </h4>
                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body pt-8">
                            <!--begin::Carousel-->
                            <div class="d-flex flex-column content-justify-center flex-row-fluid">
                                <!--begin::Label-->
                                <div class="d-flex fw-semibold col-lg-12">
                                    <!--begin::Label-->
                                    <div class="text-xxl-start col-lg-8">
                                        <div class="text-white flex-grow-1 me-4" style="font-size: 25px;">
                                            <%-- <span style="font-size: 25px;">--%>
                                            <asp:Label ID="lblItemCount" runat="server" Text="0"></asp:Label>

                                            <%--  </span>--%>
                                            <%--<br />--%>
                                            <div class="text-white flex-grow-1 me-4" style="font-size: 17px; ">Forecasted Items</div>

                                        </div>
                                    </div>
                                    <!--end::Label-->

                                </div>
                                <!--end::Label-->

                            </div>
                            <!--end::Carousel-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Slider Widget 1-->
                </div>

            </div>
        </div>
    </div>
        
        
    <div class="row">
        <div class="col-lg-12">

            <div class="kt-portlet">
                <div class="col-lg-12 row">
   <div class="col-lg-12" style="padding-top: 8px; background-color: white;">
            <div class="row">
                <!-- First Grid -->
                <div class="col-lg-6" style="padding-top: 10px; background-color: white; ">
                    <div class="card-body" style="padding: 20px;">
                        <div class="d-flex justify-content-between mb-3">
                            <h4>Routes</h4>
                            <div class="col-lg-6 d-flex justify-content-end">
                                            <asp:ImageButton ID="RouteReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"  AlternateText="reset" OnClick="RouteReset_Click" />

                                        </div>
                        </div>
                        <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                        <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />

                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                            ID="grvRptRoutes" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="grvRptRoutes_NeedDataSource"
                                            OnItemCommand="grvRptRoutes_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                <ClientEvents OnRowClick="grvRpt_RouteRowClick" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridBoundColumn DataField="RouteCode" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteCode">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="RouteName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="CustomerCount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="No:of Customers" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CustomerCount">
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

                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center">
                                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
                                </div>
                            </div>
                                        </div>
                </div>
                <div class="col-lg-6" style="padding-top: 8px; background-color: white; ">
                    <div class="card-body" style="padding: 20px;">
                        <div class="d-flex justify-content-between mb-3">
                            <h4>Customers</h4>
                           <div class="col-lg-6 d-flex justify-content-end">
                                            <asp:ImageButton ID="CustomerReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"  AlternateText="reset" OnClick="CustomerReset_Click" />

                                        </div>
                        </div>
                        <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                        <asp:Literal ID="Literal2" runat="server"></asp:Literal>

                                        

                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                            ID="grvRptCustomers" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="grvRptCustomers_NeedDataSource"
                                            OnItemCommand="grvRptCustomers_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                <ClientEvents OnRowClick="grvRpt_CustomerRowClick" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                     <telerik:GridBoundColumn DataField="CustomerCode" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CustomerCode">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="CustomerName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CustomerName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="ItemCount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="No:of Items" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="ItemCount">
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

                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center">
                                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
                                </div>
                            </div>
                                        </div>
                                    </div>

                               
       </div>
     </div>
        <div class="col-lg-12" style="padding-top: 10px; background-color: white; margin-top: 20px">
            <div class="card-body" style="padding: 20px;">
                <div class="d-flex justify-content-between mb-3">
                    <h4>Items</h4>
                    <div class="col-lg-6 d-flex justify-content-end">
                                            <asp:ImageButton ID="ItemReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"  AlternateText="reset" OnClick="ItemReset_Click" />

                                        </div>
                </div>
                <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                        <asp:Literal ID="Literal3" runat="server"></asp:Literal>

                                        

                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                            ID="grvRptItems" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="grvRptItems_NeedDataSource"
                                            OnItemCommand="grvRptItems_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                <ClientEvents OnRowClick="grvRpt_ItemRowClick" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridBoundColumn DataField="RouteCode" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteCode">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="RouteName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="CustomerCode" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CustomerCode">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="CustomerName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CustomerName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="ProductCode" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="ProductCode">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="ProductName" AllowFiltering="true" HeaderStyle-Width="200px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Description" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="ProductName">
                                                    </telerik:GridBoundColumn>                                                                                                       

                                                    <telerik:GridBoundColumn DataField="BaseUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Base UOM" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="BaseUOM">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="Qty" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Quantity" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="Qty">
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

                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center">
                                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
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

