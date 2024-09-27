<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ViewCustomerItemMappingDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ViewCustomerItemMappingDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color:white; padding:20px;">
                    
                   
                        <h6 class="kt-portlet__head-label">
                            Product Mapping Detail 
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            
                        </h6>
                    


                    <div class="col-lg-12 row" >
                        <div class="col-lg-6">

                            <!--begin::Portlet-->
                            <div class="kt-portlet" style="background-color:white; padding:20px;">

                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="col-lg-10">
                                        <h3 class="kt-portlet__head-title">Unassigned Products
                                        </h3>
                                    </div>
                                    <div class="col-lg-2">
                                       
                                    </div>
                                </div>

                                <!--begin::Form-->
                                <div class="kt-form kt-form--label-right">
                                    <div class="kt-portlet__body">
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                        <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="RadGrid1" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="RadGrid1_NeedDataSource"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="prd_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>
                                                         <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller"  FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                                        </telerik:GridBoundColumn>


                                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="pmg_Name">
                                                        </telerik:GridBoundColumn>


                                                        <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Subcategory" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
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
                                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-6">
                            <!--begin::Portlet-->
                            <div class="kt-portlet" style="background-color:white; padding:20px;">
                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="col-lg-10">
                                        <h3 class="kt-portlet__head-title">Assigned Products
                                        </h3>
                                    </div>
                                    <div class="col-lg-2" >
                                      
                                    </div>
                                </div>
                                <!--begin::Form-->
                                <div class="kt-form kt-form--label-right">
                                    <div class="kt-portlet__body">
                                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                                        <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="grvRpt" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="grvRpt_NeedDataSource"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="prd_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller"  FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="pmg_Name">
                                                        </telerik:GridBoundColumn>


                                                        <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Subcategory" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
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
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
