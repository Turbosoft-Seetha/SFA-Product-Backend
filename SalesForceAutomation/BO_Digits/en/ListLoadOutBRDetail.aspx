﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListLoadOutBRDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListLoadOutBRDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
            
   <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Style="height: 60px; padding-top: 10px; padding-left: 20px;" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color:white; padding:20px;">
                     <div class="kt-portlet__body pb-0">

                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid">
                                                <table>
                                                    <td style="width: 56%" >
                                                        <tr>
                                                            <div class="col-lg-12 mb-2 row" style="padding-left: 11px; padding-top: 8px;">
                                                        <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                          <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Date:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                         <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Status:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblstatus" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        </div>
                                                        </tr>
                                                        
                                                        
                                                    </td>
                                                    
                                                </table>


                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </div>
                   
                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">
                           <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"  >
                         
                        
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true" ScrollHeight="500px">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="lod_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        <%--<telerik:GridTemplateColumn HeaderStyle-Width="40px" UniqueName="Detail" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="assets/media/icons/svg/General/Clipboard.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Batch/Serial" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Batch" ID="Batch" Visible="true" AlternateText="Item" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Item" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="lod_CurrentStockHUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Current Stock HUOM " FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_CurrentStockHUOM">
                                        </telerik:GridBoundColumn>
                                          
                                            <telerik:GridBoundColumn DataField="lod_CurrentStockHQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Current Stock HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_CurrentStockHQty">
                                                 <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="lod_CurrentStockLUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Current Stock LUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_CurrentStockLUOM">
                                        </telerik:GridBoundColumn>

                                     
                                          
                                        <telerik:GridBoundColumn DataField="lod_CurrentStockLQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Current Stock LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_CurrentStockLQty">
                                             <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>

                                        
                                        <telerik:GridBoundColumn DataField="lod_EndStockHUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Stock HUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_EndStockHUOM">
                                        </telerik:GridBoundColumn>


                                          <telerik:GridBoundColumn DataField="lod_EndStockHQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Stock HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_EndStockHQty">
                                               <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="lod_EndStockLUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Stock LUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_EndStockLUOM">
                                        </telerik:GridBoundColumn>

                                       

                                         <telerik:GridBoundColumn DataField="lod_EndStockLQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Stock LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_EndStockLQty">
                                              <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="lod_OffloadHUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Off load HUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_OffloadHUOM">
                                        </telerik:GridBoundColumn>

                                           <telerik:GridBoundColumn DataField="lod_OffloadHQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Off load HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_OffloadHQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="lod_OffloadLUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Off load LUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_OffloadLUOM" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                      

                                         <telerik:GridBoundColumn DataField="lod_OffloadLQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Off load LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_OffloadLQty">
                                              <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="lod_AdjHUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Adj HUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_AdjHUOM" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="lod_AdjHQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Adj HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_AdjHQty">
                                              <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="lod_AdjLUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Adj LUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_AdjLUOM">
                                        </telerik:GridBoundColumn>

                                        
                                         <telerik:GridBoundColumn DataField="lod_AdjLQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Adj LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_AdjLQty">
                                              <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>

                                       

                                         <telerik:GridBoundColumn DataField="lod_BalanceHUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Balance HUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_BalanceHUOM" Visible="false">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="lod_BalanceHQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Balance HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_BalanceHQty" Visible="false">
                                               <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="lod_BalanceLUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Balance LUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_BalanceLUOM" Visible="false">
                                        </telerik:GridBoundColumn>

                                      

                                         <telerik:GridBoundColumn DataField="lod_BalanceLQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Balance LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_BalanceLQty" Visible="false">
                                              <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>


                                        
                                        <telerik:GridBoundColumn DataField="lod_ExcessTotalQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Excess Qty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lod_ExcessTotalQty">
                                             <ItemStyle HorizontalAlign="Right" />
                                               <HeaderStyle HorizontalAlign="Right" />
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
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
