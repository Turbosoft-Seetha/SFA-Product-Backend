﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewSpecialPrice.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewSpecialPrice" %>
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

                        <div class="kt-portlet__head">


                            <div class="kt-portlet__head-actions" style="text-align-last: end; padding-bottom: 10px;">
                            </div>
                        </div>
                        <!--end: Search Form -->
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-portlet__body">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="prh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="10px" AllowFiltering="false" HeaderText="منظر" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="View">
                                                <ItemTemplate>
                                                    <asp:LinkButton CommandName="Edit" ID="view" Visible="true" runat="server" Height="20px" Width="20px">
                                                   <svg xmlns="http://www.w3.org/2000/svg" width="22" height="15" viewBox="0 0 22 15">
                                                    <g id="Group_6028" data-name="Group 6028" transform="translate(-10731 2571)">
                                                        <path id="Path_1810" data-name="Path 1810" d="M12,4.5A11.827,11.827,0,0,0,1,12a11.817,11.817,0,0,0,22,0A11.827,11.827,0,0,0,12,4.5ZM12,17a5,5,0,1,1,5-5A5,5,0,0,1,12,17Z" transform="translate(10730 -2575.5)" fill="#d6d6da" />
                                                        <ellipse id="Ellipse_418" data-name="Ellipse 418" cx="3" cy="3.5" rx="3" ry="3.5" transform="translate(10739 -2567)" fill="#b5b5c3" />
                                                    </g>
                                                </svg>  
                                                    </asp:LinkButton>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="10px" AllowFiltering="false" HeaderText="التفاصيل" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="10px" AllowFiltering="false" HeaderText="تعيين" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="CusAssign">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="CusAssign" ID="CusAssign" Visible="true" AlternateText="Assign" runat="server"
                                                        ImageUrl="../assets/media/svg/General/Clipboard.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="prh_Code" AllowFiltering="true" HeaderStyle-Width="20px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="شفرة" FilterControlWidth="50%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prh_Name" AllowFiltering="true" HeaderStyle-Width="20px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم" FilterControlWidth="50%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="20px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="تم إنشاؤها على" FilterControlWidth="50%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prh_PayMode" AllowFiltering="true" HeaderStyle-Width="20px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="50%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_PayMode" Visible="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="20px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="حالة" FilterControlWidth="50%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
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
