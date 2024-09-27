<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ExpiryNotification.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ExpiryNotification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
                 <asp:ImageButton ID="Excel" runat="server" ImageUrl="../assets/media/icons/excel.png" style="height: 50px; " ToolTip="Download" OnClick="Excel_Click" AlternateText="Xlsx" />
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
                            <label class="control-label col-lg-12">Type</label>
                            <div class="col-lg-12">
                            <telerik:RadComboBox ID="ddlType"  width=100% runat="server" EmptyMessage="Select Type" Filter="Contains" RenderMode="Lightweight" AutoPostBack="true">
                            <Items>
                            <telerik:RadComboBoxItem Text="Special Price" Value="S"/>
                            <telerik:RadComboBoxItem Text="Promotion" Value="P"/>
                            <telerik:RadComboBoxItem Text="Customer FOC" Value="C"/>                                     
                            </Items>
                            </telerik:RadComboBox>
                            </div>
                            </div>
                            <div class="col-lg-4">
                            <label class="control-label col-lg-12">Expires In</label>
                            <div class="col-lg-12">
                            <telerik:RadComboBox ID="ddlExpriry" width=100% runat="server" EmptyMessage="Select Duration" Filter="Contains" RenderMode="Lightweight" AutoPostBack="true">
                            <Items>
                            <telerik:RadComboBoxItem Text="7 Days" Value="7"/>
                            <telerik:RadComboBoxItem Text="15 Days" Value="15"/>
                            <telerik:RadComboBoxItem Text="One Month" Value="30"/>                                   
                            </Items>
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
    OnItemDataBound="grvRpt_ItemDataBound"
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

            
            
            <telerik:GridBoundColumn DataField="rot_name" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="rot_name" >
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="cus_code" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="cus_code" >
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="cus_name" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="cus_name" >
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Name" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="Name" >
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="prd_code" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="prd_Code" >
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="prd_Name" >
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="FromDate" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Start Date" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="FromDate" >
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="EndDate" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="End Date" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="EndDate" >
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

