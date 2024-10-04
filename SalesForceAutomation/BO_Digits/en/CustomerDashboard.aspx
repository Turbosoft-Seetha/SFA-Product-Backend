<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

      <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
          <script type="text/javascript"> 
              function HeaderRowClick(sender, args) {
                  var ClickedIndex = args._itemIndexHierarchical; // Get the index of the clicked row
                  var grid = $find("<%= grvRpt.ClientID %>"); // Find the RadGrid instance

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
                              MasterTable.fireCommand("HeaderClick", ClickedIndex); // Trigger the server-side command
                              break; // Exit the loop after firing the command
                          }
                      }
                  }
              }


              function OutletRowClick(sender, args) {
                  var ClickedIndex = args._itemIndexHierarchical;
                  var grid = $find("<%= RadGrid1.ClientID %>");

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
                              MasterTable.fireCommand("OutletClick", ClickedIndex);
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


            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <telerik:AjaxUpdatedControl ControlID="plcTiles" />
                    <telerik:AjaxUpdatedControl ControlID="OutletReset" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="grvRpt">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="plcTiles" />
                    <telerik:AjaxUpdatedControl ControlID="HeaderReset" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="HeaderReset">
                <UpdatedControls>                  
                    <telerik:AjaxUpdatedControl ControlID="plcTiles" />
                     <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                     <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="OutletReset">
                <UpdatedControls>                    
                    <telerik:AjaxUpdatedControl ControlID="plcTiles" />
                     <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="grvRpt">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="HeaderReset" />
                    <telerik:AjaxUpdatedControl ControlID="OutletReset" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="HeaderReset" />
                    <telerik:AjaxUpdatedControl ControlID="OutletReset" />
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
            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
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
                                            <h4>Customer Headers</h4>
                                            <asp:ImageButton ID="HeaderReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"
                                                AlternateText="reset" OnClick="HeaderReset_Click" />
                                        </div>
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="grvRpt" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="grvRpt_NeedDataSource"
                                            OnItemCommand="grvRpt_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true" AutoGenerateColumns="false"
                                            OnSelectedIndexChanged="grvRpt_SelectedIndexChanged">
                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>    
                                                <ClientEvents OnRowClick="HeaderRowClick" /> 
                                            </ClientSettings>
                                            <MasterTableView FilterItemStyle-Font-Size="Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="csh_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="csh_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="csh_Code">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="csh_Name" AllowFiltering="true" HeaderStyle-Width="200px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="csh_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="TotalInvoice" AllowFiltering="true" HeaderStyle-Width="120px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Inv. No/ Amount" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="TotalInvoice">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="csh_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="csh_ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="csh_ID" Display="false">
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
                                            <asp:ImageButton ID="OutletReset" runat="server" ImageUrl="../assets/media/UDP/reset.png" Height="20"
                                                AlternateText="reset" OnClick="OutletReset_Click" />
                                        </div>
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="RadGrid1" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="RadGrid1_NeedDataSource"
                                            OnItemCommand="RadGrid1_ItemCommand"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true" 
                                            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" AutoGenerateColumns="false">
                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                 <Selecting AllowRowSelect="true" />
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                <ClientEvents OnRowClick="OutletRowClick" />                                               
                                            </ClientSettings>
                                            <MasterTableView FilterItemStyle-Font-Size="Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="cus_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="csh_Code" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Header" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="csh_Code">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Out. Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Outlet" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="InvoiceTotal" AllowFiltering="true" HeaderStyle-Width="120px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Inv. No/ Amount" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="InvoiceTotal">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_csh_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="cus_csh_ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_csh_ID" Display="false">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="cus_ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_ID" Display="false">
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
                            </div>
                        </div>
                    </div>

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

    <asp:PlaceHolder ID="plcTiles" runat="server" >
    <div class="col-lg-12 mt-8 pb-0">
    <!--begin::Mixed Widget 14-->
    <div class="card bgi-no-repeat card-xl-stretch mb-lg-12"
         style="background-color: #6397b2; background-image: url(../assets/media/dashboard/custdbsmall.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
        <!--begin::Head-->
        <div class="card-header" style="border-bottom: 0px; display: flex; justify-content: space-between;">
            <!--begin::Title-->
            <h3 class="card-title align-items-start flex-column text-center">
                <asp:Label ID="lblTotalInvoice" runat="server" Text="0" ForeColor="White" style="font-size: 20px; margin-top: 10px;"></asp:Label>
                <asp:LinkButton ID="totalInvoices" runat="server" OnClick="totalInvoices_Click" style="font-size: 20px; color: white; display: block; margin-top: 10px;">
                    Total Invoices
                </asp:LinkButton>
            </h3>
            <!--end::Title-->
            <!--begin::Toolbar-->
            <div class="card-toolbar">
                <p style="color: white; margin-bottom: 0.5rem !important">
                    <span style="font-size: 20px;">
                        <asp:Label ID="lblCurrency" runat="server"></asp:Label></span>
                    <span style="font-size: 20px;">
                        <asp:Label ID="lblTotalInvoiceSum" runat="server" Text="0.00"></asp:Label></span>
                </p>
            </div>
            <!--end::Toolbar-->
        </div>
        <!--end::Head-->

        <!--begin::Body-->
        <div class="card-body" style="padding: 30px; height: 170px;">
            <!--begin::Row-->
            <div class="row" style="display: flex; justify-content: space-between;">
                <!--begin::Col-->
                <div class="col-lg-3 col-md-3" style="display: flex; align-items: stretch; ">
                    <div class="card" style="background-color: #c4e5f6; border-radius: 12px; padding: 10px; width: 100%; display: flex; align-items: flex-start; height: 110px; border: 2px solid white;">
                        <!-- Reduced padding and set a fixed height -->
                        <div class="d-flex mb-12 me-2" style="padding: 10px">
                            <!--begin::Symbol-->
                            <div class="symbol symbol-40px me-3">
                                <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
                                    <!-- Adjusted width and height -->
                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                        <img src="../assets/media/dashboard/invoices.png" alt="Invoice" width="34" height="34" />
                                    </span>
                                </div>
                            </div>
                            <!--end::Symbol-->
                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="salesLink" runat="server" OnClick="salesLink_Click" Style="color: black; padding: 0; border: none; background: none;">
                                    <div class="fs-5 fw-bolder lh-1" style="color: black; padding: 2px">
                                        <asp:Label ID="lblSalesCount" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="fs-5 fw-bold" style="color: black; font-size: 16px; padding: 2px;">Sales</div>
                                    <div class="fs-5 fw-bold" style="color: black;">
                                        <asp:Label ID="Label6" runat="server"></asp:Label>
                                        <span class="" style="font-size: 14px; padding: 2px">
                                            <asp:Label ID="lblSalesSum" runat="server" Text="0"></asp:Label>
                                        </span>
                                    </div>
                                    
                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                </div>


                <!--end::Col-->

                <!--begin::Col-->

                <div class="col-lg-3 col-md-3" style="display: flex; align-items: stretch;">
                    <div class="card" style="background-color: #def7e3; border-radius: 12px; padding: 10px; width: 100%; display: flex; align-items: flex-start; height: 110px; border: 2px solid white;">
                        <!-- Reduced padding and set a fixed height -->
                        <div class="d-flex mb-12 me-2" style="padding: 10px;">
                            <!--begin::Symbol-->
                            <div class="symbol symbol-40px me-3">
                                <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
                                    <!-- Adjusted width and height -->
                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                        <img src="../assets/media/dashboard/gr.png" alt="Invoice" width="34" height="34" />
                                    </span>
                                </div>
                            </div>
                            <!--end::Symbol-->
                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="goodReturnLink" runat="server" OnClick="goodReturnLink_Click" Style="color: black; padding: 0; border: none; background: none;">
                                    <div class="fs-5 fw-bolder lh-1" style="color: black; padding: 2px"">
                                        <asp:Label ID="lblTotalGReturns" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="fs-5 fw-bold" style="color: black; font-size: 14px; padding: 2px"">Good Return</div>
                                    <div class="fs-5 fw-bold" style="color: black;">
                                        <asp:Label ID="label70" runat="server"></asp:Label>
                                        <span class="" style="font-size: 14px; padding: 2px"">
                                            <asp:Label ID="lblTotalGReturnsSum" runat="server" Text="0"></asp:Label>
                                        </span>
                                    </div>
                                    
                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                </div>

                
                <!--end::Col-->

                <!--begin::Col-->

                <div class="col-lg-3 col-md-3" style="display: flex; align-items: stretch;">
                    <div class="card" style="background-color: #ffd3e4; border-radius: 12px; padding: 10px; width: 100%; display: flex; align-items: flex-start; height: 110px; border: 2px solid white;">
                        <!-- Reduced padding and set a fixed height -->
                        <div class="d-flex mb-12 me-2" style="padding: 10px;">
                            <!--begin::Symbol-->
                            <div class="symbol symbol-40px me-3">
                                <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
                                    <!-- Adjusted width and height -->
                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                        <img src="../assets/media/dashboard/invoices.png" alt="Invoice" width="34" height="34" />
                                    </span>
                                </div>
                            </div>
                            <!--end::Symbol-->
                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="badReturnLink" runat="server" OnClick="badReturnLink_Click" Style="color: black; padding: 0; border: none; background: none;">
                                    <div class="fs-5 fw-bolder lh-1" style="color: black; padding: 2px"">
                                        <asp:Label ID="lblTotalBReturns" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="fs-5 fw-bold" style="color: black; font-size: 14px; padding: 2px"">Bad Return</div>
                                    <div class="fs-5 fw-bold" style="color: black;">
                                        <asp:Label ID="Label10" runat="server"></asp:Label>
                                        <span class="" style="font-size: 14px; padding: 2px"">
                                            <asp:Label ID="lblTotalBReturnsSum" runat="server" Text="0"></asp:Label>
                                        </span>
                                    </div>
                                    
                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                </div>

             
                <!--end::Col-->

                <!--begin::Col-->

                <div class="col-lg-3 col-md-3" style="display: flex; align-items: stretch;">
                    <div class="card" style="background-color: #f8f7d4; border-radius: 12px; padding: 10px; width: 100%; display: flex; align-items: flex-start; height: 110px; border: 2px solid white;">
                        <!-- Reduced padding and set a fixed height -->
                        <div class="d-flex mb-12 me-2" style="padding: 10px;">
                            <!--begin::Symbol-->
                            <div class="symbol symbol-40px me-3">
                                <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
                                    <!-- Adjusted width and height -->
                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                        <img src="../assets/media/dashboard/gr.png" alt="Invoice" width="34" height="34" />
                                    </span>
                                </div>
                            </div>
                            <!--end::Symbol-->
                            <!--begin::Title-->
                            <div>
                                <asp:LinkButton ID="freeOfCostLink" runat="server" OnClick="freeOfCostLink_Click" Style="color: black; padding: 0; border: none; background: none;">
                                    <div class="fs-5 fw-bolder lh-1" style="color: black;">
                                        <asp:Label ID="lblTotalFreeGoods" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="fs-5 fw-bold" style="color: black; font-size: 14px; padding: 2px;">Free of cost</div>
                                   

                                </asp:LinkButton>
                            </div>
                            <!--end::Title-->
                        </div>
                    </div>
                </div>
                
                <!--end::Col-->
            </div>
            </div>
            <!--end::Row-->
        </div>
    </div>




        <div class="col-lg-12 row">
            <div class="col-lg-6 row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <asp:LinkButton runat="server" ID="lnkQuotations" OnClick="lnkQuotations_Click">
                                    <div class="col-lg-12 row">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <img src="../assets/media/dashboard/Quotations.png" class="w-30px me-6" alt="" />
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 600;"></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex ">
                                            <div class="d-flex">
                                                <span style="font-weight: 800; font-size: 15px;">
                                                    <asp:Label ID="lblQuotations" runat="server" Text="0"></asp:Label></span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-1">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">Quotations</span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">
                                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                                    <asp:Label ID="lblQuotationSum" runat="server" Text="0.00"></asp:Label>
                                                </span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 ">
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <asp:LinkButton runat="server" ID="lnkSalesOrder" OnClick="lnkSalesOrder_Click">
                                    <div class="col-lg-12 row">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <img src="../assets/media/dashboard/orderreq2.png" class="w-30px me-6" alt="" />
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 600;"></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex ">
                                            <div class="d-flex">
                                                <span style="font-weight: 800; font-size: 15px;">
                                                    <asp:Label ID="lblTotalOrder" runat="server" Text="0"></asp:Label></span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-1">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">Sales Order</span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">
                                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                                    <asp:Label ID="lblTotalOrderSum" runat="server" Text="0.00"></asp:Label></span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <asp:LinkButton runat="server" ID="lnkARColl" OnClick="lnkARColl_Click">
                                    <div class="col-lg-12 row">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <img src="../assets/media/dashboard/ar2.png" class="w-30px me-6" alt="" />
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 600;"></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex ">
                                            <div class="d-flex">
                                                <span style="font-weight: 800; font-size: 15px;">
                                                    <asp:Label ID="lblTotalAR" runat="server" Text="0"></asp:Label></span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-1">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">AR Collection</span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">
                                                    <asp:Label ID="Label7" runat="server"></asp:Label>
                                                    <asp:Label ID="lblTotalARSum" runat="server" Text="0.00"></asp:Label></span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6  ">
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <asp:LinkButton runat="server" ID="lnkAdvColl" OnClick="lnkAdvColl_Click">
                                    <div class="col-lg-12 row">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <img src="../assets/media/dashboard/advance2.png" class="w-30px me-6" alt="" />
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 600;"></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex ">
                                            <div class="d-flex">
                                                <span style="font-weight: 800; font-size: 15px;">

                                                    <asp:Label ID="lblTotalAdvance" runat="server" Text="0"></asp:Label>

                                                </span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-1">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">Advance Collection</span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row pt-2">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; font-size: 15px;">
                                                    <asp:Label ID="Label8" runat="server"></asp:Label>
                                                    <asp:Label ID="lblTotalAdvanceSum" runat="server" Text="0.00"></asp:Label></span>
                                            </div>

                                        </div>
                                        <!--end::Item-->
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




            <div class="col-lg-6 row">

                <div class="col-lg-6">
                    <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #69a3bc; background-image: linear-gradient(to right,#1593ca, #6db2ce); background-size: 100% 100%; border-radius: 12px;">
                        <asp:LinkButton runat="server" ID="lnkSaleOrdiv" OnClick="lnkSaleOrdiv_Click">
                            <div class="card-xl-stretch m-4">
                                <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                    <div class="symbol symbol-35px me-3">
                                        <!-- Adjusted margin -->
                                        <img src="../assets/media/dashboard/so.png" class="w-30px" alt="" />
                                    </div>
                                    <span class="text-white fs-3 fw-bold" style="padding: 0;">
                                        <asp:Label runat="server" ID="lblSaleOrdcount" Style="padding: 0;" Text="0" Font-Bold="true"></asp:Label>
                                    </span>
                                </div>
                                <div class="flex-grow-1 me-6">
                                    <span class="text-white fw-semibold fs-5 d-block" style="margin-top: 2px;">
                                        <!-- Added margin for better spacing -->
                                        Sales Order Status
                                    </span>
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #5ca356; background-image: linear-gradient(to right,#168d0c, #62a05d); background-size: 100% 100%; border-radius: 12px;">
                        <asp:LinkButton runat="server" ID="lnkRotdeliv" OnClick="lnkRotdeliv_Click">
                            <div class="card-xl-stretch m-4">
                                <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                    <!-- Increased padding -->
                                    <div class="symbol symbol-35px me-3">
                                        <!-- Adjusted margin -->
                                        <img src="../assets/media/dashboard/rd.png" class="w-30px" alt="" />
                                    </div>
                                    <span class="text-white fs-3 fw-bold" style="padding: 0;">
                                        <asp:Label runat="server" ID="lbldelcount" Text="0" Font-Bold="true"></asp:Label>
                                    </span>
                                </div>
                                <div class="flex-grow-1 me-6">
                                    <span class="text-white fw-semibold fs-5 d-block" style="margin-top: 2px;">
                                        <!-- Added margin for spacing -->
                                        Route Deliveries
                                    </span>
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card bgi-no-repeat card-lg-stretch mb-lg-8 ms-2" style="background-color: #7c5c97; background-image: linear-gradient(to right,#5d1498, #7d599a); background-size: 100%; border-radius: 12px;">
                        <asp:LinkButton runat="server" ID="lnkOutstandingInv" OnClick="lnkOutstandingInv_Click">
                            <div class="card-xl-stretch m-4">
                                <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                    <!-- Increased padding -->
                                    <div class="symbol symbol-35px me-3">
                                        <!-- Adjusted margin -->
                                        <img src="../assets/media/dashboard/oi.png" class="w-30px" alt="" />
                                    </div>
                                    <span class="text-white fs-3 fw-bold" style="padding: 0;">
                                        <asp:Label runat="server" ID="lblOutstanding" Text="0" Font-Bold="true"></asp:Label>
                                    </span>
                                </div>
                                <div class="flex-grow-1 me-6">
                                    <span class="text-white fw-semibold fs-5 d-block" style="margin-top: 2px;">
                                        <!-- Added margin for spacing -->
                                        Outstanding Invoices
                                    </span>
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card bgi-no-repeat card-lg-stretch mb-lg-8 ms-2" style="background-color: #b93e32; background-image: linear-gradient(to right,#b61707, #b0675f); background-size: 100%; border-radius: 12px;">
                        <asp:LinkButton runat="server" ID="lnkInvMonitoring" OnClick="lnkInvMonitoring_Click">
            <div class="card-xl-stretch m-4">
                <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12"> <!-- Increased padding -->
                    <div class="symbol symbol-35px me-3"> <!-- Adjusted margin -->
                        <img src="../assets/media/dashboard/im.png" class="w-30px" alt="" />
                    </div>
                    <%-- Uncommented label if needed --%>
                    <!-- 
                    <span class="text-white fs-3 fw-bold" style="padding: 0;"> 
                        <asp:Label runat="server" ID="lblInvMonitoring" Text="0" Font-Bold="true"></asp:Label>
                    </span>
                    -->
                </div>
                <div class="flex-grow-1 me-6">
                    <span class="text-white fw-semibold fs-5 d-block" style="margin-top: 2px;"> <!-- Added margin for spacing -->
                        Inventory Monitoring
                    </span>
                </div>
            </div>
                        </asp:LinkButton>
                    </div>
                </div>


                <asp:PlaceHolder ID="pnlActManage" runat="server">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch ms-2" style="background-color: #8e3a09; background-image: linear-gradient(to right,#933702, #a06e52); background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkActManagement" OnClick="lnkActManagement_Click">
                <div class="card-xl-stretch m-4">
                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12"> <!-- Increased padding -->
                        <div class="symbol symbol-35px me-3"> <!-- Adjusted margin -->
                            <img src="../assets/media/dashboard/am.png" class="w-30px" alt="" />
                        </div>
                        <%-- Uncomment this if you want to display the label --%>
                        <!-- 
                        <span class="text-white fs-3 fw-bold" style="padding: 0;"> 
                            <asp:Label runat="server" ID="lblOutlet" Text="0" Font-Bold="true"></asp:Label>
                        </span>
                        -->
                    </div>
                    <div class="flex-grow-1 me-6">
                        <span class="text-white fw-semibold fs-5 d-block" style="margin-top: 2px;"> <!-- Added margin for spacing -->
                            Outlet Activities
                        </span>
                    </div>
                </div>
                            </asp:LinkButton>
                        </div>
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="pnlcusservice" runat="server">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8 ms-2" style="background-color: #21459f; background-image: linear-gradient(to right,#032784, #6d7a9b); background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkcusservice" OnClick="lnkcusservice_Click">
                <div class="card-xl-stretch m-4">
                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12"> <!-- Increased padding -->
                        <div class="symbol symbol-35px me-3"> <!-- Adjusted margin -->
                            <img src="../assets/media/dashboard/cs.png" class="w-30px" alt="" />
                        </div>
                        
                    </div>
                    <div class="flex-grow-1 me-6">
                        <span class="text-white fw-semibold fs-5 d-block" style="margin-top: 2px;"> <!-- Added margin for spacing -->
                            Customer Services
                        </span>
                    </div>
                </div>
                            </asp:LinkButton>
                        </div>
                    </div>
                </asp:PlaceHolder>

            </div>

        </div>


    </asp:PlaceHolder>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
