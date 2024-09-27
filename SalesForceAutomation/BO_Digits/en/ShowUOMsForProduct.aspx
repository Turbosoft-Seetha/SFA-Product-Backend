<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ShowUOMsForProduct.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ShowUOMsForProduct" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <!--begin::Form-->


                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource" 
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="pru_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="udp_EndDayStatus" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="EndDayStatus" Display="false">
                                                </telerik:GridBoundColumn>

                                                <%--  <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Deletes">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Delete" ID="Delete" Visible="true" AlternateText="Delete" runat="server"
                                                            SetFocusOnError="false"
                                                            ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>

                                                <telerik:GridBoundColumn DataField="uom_Code" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UOM Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Code">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="uom_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Name">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_Price" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Standard Selling Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_Price">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_ReturnPrice" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Return Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_ReturnPrice">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_upc" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UPC" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_upc">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_IsDefault" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Default" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_IsDefault">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="isSalesHold" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Disable UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="isSalesHold">
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
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
