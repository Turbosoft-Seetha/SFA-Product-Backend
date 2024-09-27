<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="LoadForecastingReport.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.LoadForecastingReport" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <div class="col-lg-12">

        <div class="col-lg-12 d-flex justify-content-end fw-bold mb-2 gap-2" style="color: #a0a1a4;">
            Last reload on : 
         <asp:Label runat="server" ID="lblReloadTime" ForeColor="#a0a1a4" Font-Bold="true" Font-Size="Small"></asp:Label>
        </div>
        <div class="col-lg-12">
            <asp:Label runat="server" ID="lbldata" ForeColor="#003399" Font-Bold="true" Font-Size="Medium">The refreshed data will be visible upon clicking the "Apply Filter" button.</asp:Label>
        </div>



        <div class="col-lg-12 pt-4 d-flex justify-content-end" style="display: -webkit-box;">

            <div class="col-lg-4">
                <label class="control-label">Date </label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Date is mandatory" ForeColor="Red"
                        ControlToValidate="rdDate"></asp:RequiredFieldValidator>

                    <br />
                </div>
            </div>



            <div class="col-lg-3" style="padding-top: 15px;">
                <div class="col-lg-8" style="width: auto;">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">


                        <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                                        Apply Filter
                        </asp:LinkButton>


                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" />

                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RadGrid2">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" />

                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="Filter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblRouteCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblProductCode" />

                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" />

                    <telerik:AjaxUpdatedControl ControlID="lblReloadTime" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="lnkRouteReset">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                     <telerik:AjaxUpdatedControl ControlID="RadGrid2" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="lnkItemReset">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>



    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript"> 
            function grvRpt_RouteRowDblClick(sender, args) {
                /*debugger;*/
                var ClickedIndex = args._itemIndexHierarchical;
                //changed code here 
                var grid = $find("<%=RadGrid1.ClientID %>");
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
            function grvRpt_ItemRowDblClick(sender, args) {
                /*debugger;*/
                var ClickedIndex = args._itemIndexHierarchical;
                //changed code here 
                var grid = $find("<%=RadGrid2.ClientID %>");
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
        </script>
    </telerik:RadScriptBlock>




    <div class="col-lg-12 row">
        <div class="col-xl-4">

            <div class="row g-5 ">

                <div class="col-xl-12 mb-xl-10">
                    <!--begin::Slider Widget 1-->
                    <div id="kt_sliders_widget_1_slider" class="card card-flush carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="5000" style="height: 127px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
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
                                            <div class="flex-grow-1 me-4" style="font-size: 17px;">Routes</div>

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
                    <div id="kt_sliders_widget_1_slider1" class="card card-flush carousel carousel-custom carousel-stretch slide rounded bgi-no-repeat bgi-size-cover bgi-position-y-top bgi-position-x-center h-127px" data-bs-ride="carousel" data-bs-interval="5000" style="height: 127px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); background-image: url('../assets/media/svg/shapes/top-green.png');">
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
                                            <asp:Label ID="lblProductCode" runat="server" Text="0"></asp:Label>

                                            <%--  </span>--%>
                                            <%--<br />--%>
                                            <div class="flex-grow-1 me-4" style="font-size: 17px;">Items</div>

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
                <div class="col-lg-12 row" style="padding-top: 20px;">
                    <div class="col-lg-12">
                        <!--begin::Portlet-->
                        <div class="kt-portlet" style="background-color: white; padding: 20px;">

                            <div class="kt-portlet__head">
                                <div class="col-lg-12 row">
                                    <div class="col-lg-6">
                                        <div class="kt-portlet__head-label">
                                            <h3 class="kt-portlet__head-title pt-2">Routes
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 d-flex justify-content-end mb-4">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                            <asp:ImageButton ID="lnkRouteReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"  AlternateText="reset" OnClick="lnkRouteReset_Click1" />
                                           <%-- <asp:LinkButton ID="lnkRouteReset" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkRouteReset_Click">
                                                     Reset Filter
                                            </asp:LinkButton>--%>
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

                            <!--begin::Form-->
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                        <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />

                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                            ID="RadGrid1" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="RadGrid1_NeedDataSource"
                                            OnItemCommand="RadGrid1_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                <ClientEvents OnRowClick="grvRpt_RouteRowDblClick" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridBoundColumn DataField="RouteCode" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteCode">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="RouteName" AllowFiltering="true" HeaderStyle-Width="200px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="ItemCount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="No of Items" FilterControlWidth="100%"
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
                    <div class="col-lg-12 pt-8">
                        <!--begin::Portlet-->
                        <div class="kt-portlet" style="background-color: white; padding: 20px;">

                            <div class="kt-portlet__head">
                                <div class="col-lg-12 row">
                                    <div class="col-lg-6">
                                        <div class="kt-portlet__head-label">
                                            <h3 class="kt-portlet__head-title pt-2">Items
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 d-flex justify-content-end mb-4">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                            <asp:ImageButton ID="lnkItemReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"  AlternateText="reset" OnClick="lnkItemReset_Click1" />
                                            <%--<asp:LinkButton ID="lnkItemReset" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkItemReset_Click">
                                             Reset Filter
                                            </asp:LinkButton>--%>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center">
                                                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                    </div>

                                </div>
                            </div>

                            <!--begin::Form-->
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">
                                        <asp:Literal ID="Literal2" runat="server"></asp:Literal>

                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                            ID="RadGrid2" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="RadGrid2_NeedDataSource"
                                            OnItemCommand="RadGrid2_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                <ClientEvents OnRowClick="grvRpt_ItemRowDblClick" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridBoundColumn DataField="RouteCode" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteCode">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="RouteName" AllowFiltering="true" HeaderStyle-Width="200px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RouteName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="ProductCode" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="ProductCode">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="ProductName" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Description" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="ProductName">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="BaseUOM" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="BaseUOM" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="BaseUOM">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="Qty" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Qty" FilterControlWidth="100%"
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
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
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
