<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListSettingsProfiles.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListSettingsProfiles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="card-body p-1" style="background-color:white;">

         <div class="col-lg-12 row p-3 mb-6 mx-0" style="border-width:2px; border-style:groove;"> 
                                 <div class="col-lg-4 row fw-bold fs-3"> Master :  

                                <div class="col-lg-8 fw-bold fs-3"> <asp:Label runat="server" ID="lblMaster" > </asp:Label></div>
                                     </div>

                                 <div class="col-lg-4 row fw-bold fs-3"> Profile:  

                                <div class="col-lg-8 fw-bold fs-3"> <asp:Label runat="server" ID="lblProfileName" > </asp:Label></div>
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
        ShowFooter="false" DataKeyNames="pfm_ID"
        EnableHeaderContextMenu="true">
        <Columns>

            <telerik:GridBoundColumn DataField="pfd_SettingsName" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Setting" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfd_SettingsName">
            </telerik:GridBoundColumn>

            
            <telerik:GridBoundColumn DataField="pfd_ValueText" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Setting Value" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfd_ValueText" >
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
