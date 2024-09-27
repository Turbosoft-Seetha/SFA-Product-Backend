<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="NotstartedRoutes.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.NotstartedRoutes" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="kt-portlet" style="background-color: white; padding: 20px;">
     <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
 <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
     ID="grvRpt" GridLines="None"
     ShowFooter="True" AllowSorting="True"
     OnNeedDataSource="grvRpt_NeedDataSource"
     AllowFilteringByColumn="true"
     ClientSettings-Resizing-ClipCellContentOnResize="true"
     EnableAjaxSkinRendering="true"
     AllowPaging="true" PageSize="5000" CellSpacing="0">
     <ClientSettings>
         <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
     </ClientSettings>
     <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
         ShowFooter="false" DataKeyNames="rot_ID"
         EnableHeaderContextMenu="true">
         <Columns>

             <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route Name" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="rot_Type" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Route Type" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="rot_Type">
            </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="usr_code" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Sales Person Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="usr_code">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Sales Person Name" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
