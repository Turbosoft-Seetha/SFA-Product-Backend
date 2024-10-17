<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ItemWiseDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ItemWiseDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <div class="row" style="margin-right: auto;">
        <ul class="nav" style="justify-content: flex-end;">
            <li class="nav-item">
                <asp:LinkButton ID="lnkToday" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkToday_Click">Today</asp:LinkButton>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="lnkMonth" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkMonth_Click">Month</asp:LinkButton>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="lnkYear" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4" OnClick="lnkYear_Click">Year</asp:LinkButton>
            </li>
        </ul>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript"> 
            function ItemRowClick(sender, args) {
                var ClickedIndex = args._itemIndexHierarchical; // Get the index of the clicked row
                var grid = $find("<%= ItemGrid.ClientID %>");

            if (grid) {
                var MasterTable = grid.get_masterTableView(); // Access the MasterTable
                var Rows = MasterTable.get_dataItems(); // Get all rows

                // Show the loading panel before triggering the postback
                var loadingPanel = $find("<%= RadAjaxLoadingPanel1.ClientID %>");
                    if (loadingPanel) {
                        loadingPanel.show(); // Show the loading panel
                    }

                    for (var i = 0; i < Rows.length; i++) {
                        var row = Rows[i];
                        if (ClickedIndex != null && ClickedIndex == i) { // Check if the index matches the clicked row
                            MasterTable.fireCommand("ItemClick", ClickedIndex); // Trigger the server-side command
                            break; // Exit the loop after firing the command
                        }
                    }
                }
            }

            function CustomerRowClick(sender, args) {
                var ClickedIndex = args._itemIndexHierarchical;
                var grid = $find("<%= CustGrid.ClientID %>");

            // Find the loading panel
            var loadingPanel = $find("<%= RadAjaxLoadingPanel1.ClientID %>");

                if (grid) {
                    var MasterTable = grid.get_masterTableView();
                    var Rows = MasterTable.get_dataItems();

                    for (var i = 0; i < Rows.length; i++) {
                        var row = Rows[i];
                        if (ClickedIndex != null && ClickedIndex == i) {
                            // Show the loading panel
                            if (loadingPanel) {
                                loadingPanel.show();
                            }

                            // Fire the command
                            MasterTable.fireCommand("CustomerClick", ClickedIndex);
                            break; // Exit the loop after firing the command
                        }
                    }
                }
            }

        </script>
    </telerik:RadScriptBlock>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>


            <telerik:AjaxSetting AjaxControlID="ItemGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ItemGrid" />
                    <telerik:AjaxUpdatedControl ControlID="CustGrid" />
                    <telerik:AjaxUpdatedControl ControlID="InvoiceGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="CustGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ItemGrid" />
                    <telerik:AjaxUpdatedControl ControlID="CustGrid" />
                    <telerik:AjaxUpdatedControl ControlID="InvoiceGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>


        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div>

                        <div class="col-lg-12 row" style="padding-top: 10px;">

                            <div class="col-lg-12 row">
                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">From Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true" Width="100%">
                                        </telerik:RadDatePicker>
                                    </div>
                                </div>

                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">To Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MM-yyyy" runat="server" AutoPostBack="true" Width="100%">
                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    </div>
                                </div>

                                <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;">
                                    <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click">Apply Filter</asp:LinkButton>
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
                        <div class="card-body" style="padding: 1rem 1rem;">
                            <div class="py-2">
                                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                <div class="kt-portlet__body" style="margin-top: 10px;">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h4>Items</h4>

                                        <div class="button-group">
                                            <asp:ImageButton ID="ItemExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="40"
                                                ToolTip="Download" OnClick="ItemExcel_Click" AlternateText="Xlsx" style="padding: 0; margin: 0; vertical-align: middle;"/>
                                            <asp:ImageButton ID="ItemReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"
                                                AlternateText="reset" OnClick="ItemReset_Click" style="padding: 0; margin: 0; vertical-align: middle;"/>
                                        </div>
                                    </div>

                                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="ItemGrid" GridLines="None" ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="ItemGrid_NeedDataSource" OnItemCommand="ItemGrid_ItemCommand"
                                            AllowFilteringByColumn="true" ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true" AllowPaging="true" PageSize="50" CellSpacing="0"
                                            OnSelectedIndexChanged="ItemGrid_SelectedIndexChanged">
                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="400px"></Scrolling>
                                                <ClientEvents OnRowClick="ItemRowClick" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small"
                                                CanRetrieveAllData="false" ShowFooter="false" DataKeyNames="prd_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code" />
                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name" />
                                                    <telerik:GridBoundColumn DataField="TotalInvoice" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="No: of Invoices" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalInvoice" />
                                                    <telerik:GridBoundColumn DataField="TotalQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Quantity" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalQty" />
                                                    <telerik:GridBoundColumn DataField="TotalSales" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Sales" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalSales" />
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
                                        <div class="col-lg-12 text-center mt-5">
                                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="col-xl-6">
                    <!-- Second Grid Column -->
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 1rem;">
                            <div class="py-2">

                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                <div class="kt-portlet__body" style="margin-top: 10px;">

                                    <div class="d-flex justify-content-between align-items-center">
                                        <h4>Customer Outlets</h4>
                                        <div class="button-group">
                                            <asp:ImageButton ID="OutletExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="40"
                                                AlternateText="excel" OnClick="OutletExcel_Click" Style="padding: 0; margin: 0; vertical-align: middle;" />
                                            <asp:ImageButton ID="OutletReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"
                                                AlternateText="reset" OnClick="OutletReset_Click" Style="padding: 0; margin: 0; vertical-align: middle;" />
                                        </div>
                                    </div>

                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="CustGrid" GridLines="None"
                                            ShowFooter="true" AllowSorting="True"
                                            OnNeedDataSource="CustGrid_NeedDataSource"
                                            OnItemCommand="CustGrid_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0"
                                            OnSelectedIndexChanged="CustGrid_SelectedIndexChanged">
                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                <Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400px"></Scrolling>
                                                <ClientEvents OnRowClick="CustomerRowClick" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="cus_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Outlet Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="prd_ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="TotalInvoice" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="No: of Invoices" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalInvoice">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="TotalQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Quantity" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalQty">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="TotalSales" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Sales" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalSales">
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
                                        <div class="col-lg-12 text-center mt-5">
                                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-12" style="padding-top: 10px;">

                    <div class="card">
                        <div class="card-body" style="padding: 1rem 1rem;">
                            <div class="py-2">

                                <asp:Literal ID="Literal2" runat="server"></asp:Literal>
                                <div class="kt-portlet__body" style="margin-top: 10px;">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h4>Invoices</h4>
                                        <asp:ImageButton ID="InvoiceExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="40"
                                            AlternateText="excel" OnClick="InvoiceExcel_Click" />
                                        <%--<asp:ImageButton ID="InvoiceReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"
                                            AlternateText="reset" OnClick="InvoiceReset_Click" />--%>
                                    </div>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="InvoiceGrid" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="InvoiceGrid_NeedDataSource"
                                            OnItemCommand="InvoiceGrid_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="400px"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="inv_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Outlet Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Outlet Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="200px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Item Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="120px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Invoice ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="TotalQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Quantity" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalQty">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="TotalSales" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Sales" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalSales">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="TransType" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Trans. Type" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TransType">
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
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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


    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
