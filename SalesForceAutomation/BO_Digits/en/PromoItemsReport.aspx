<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="PromoItemsReport.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.PromoItemsReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
                 <asp:ImageButton ID="Excel" runat="server" ImageUrl="../assets/media/icons/excel.png" style="height: 50px; " ToolTip="Download" OnClick="Excel_Click" AlternateText="Xlsx"  />
            </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
         <div class="row">
             <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                     <div class="card-body" style="background-color:white; padding:20px;">
                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
             <div class="col-lg-12">
                  <div class="card-body" style="background-color: white; padding: 20px;">
                      <div class=" col-lg-12 row" style="padding-bottom: 10px;">
                          <div class="col-lg-4">
                            <label class="control-label col-lg-12">Route</label>
                            <div class="col-lg-12">
                            <telerik:RadComboBox ID="ddlRoute"   width=100% runat="server" EmptyMessage="Select Route" Filter="Contains" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" >
                            </telerik:RadComboBox>
                            </div>
                            </div>
                            <div class="col-lg-4">
                            <label class="control-label col-lg-12">Promotion</label>
                            <div class="col-lg-12">
                            <telerik:RadComboBox ID="ddPromotion" width=100% runat="server" EmptyMessage="Select Promotion" Filter="Contains" RenderMode="Lightweight" >
                            
                            </telerik:RadComboBox>
                            </div>
                        </div>
                          <div class="col-lg-4" style="top: 10px; text-align: center; padding-top: 15px;">
                                        <asp:LinkButton ID="Filter"  runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                                                    Apply Filter
                                        </asp:LinkButton>
                             </div>
                      </div>
                  </div>
             </div>
                  <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                       <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
    ID="grvRpt" GridLines="None"
    ShowFooter="True" AllowSorting="True"
    OnNeedDataSource="grvRpt_NeedDataSource"
    OnItemCommand="grvRpt_ItemCommand"
    AllowFilteringByColumn="true"
    ClientSettings-Resizing-ClipCellContentOnResize="true"
    EnableAjaxSkinRendering="true"
    AllowPaging="true" PageSize="100" CellSpacing="0">
    <ClientSettings>
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
    </ClientSettings>
    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
        ShowFooter="false" DataKeyNames="ID"
        EnableHeaderContextMenu="true">
        <Columns>
                                         <telerik:GridBoundColumn DataField="rot_code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_code">
                                        </telerik:GridBoundColumn>

                                        
                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Sub Category" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
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

             </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
     </div>
</asp:Content>


