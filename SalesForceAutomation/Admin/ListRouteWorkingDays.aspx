<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="ListRouteWorkingDays.aspx.cs" Inherits="SalesForceAutomation.Admin.ListRouteWorkingDays" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">List Route Working Days</h3>
                            <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs" style="padding-left:30px;">


                            <a href="ListRoute.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> List Route </a>
                         <%--   <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>--%>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link"> List Route Working Days</a>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                        </div>
                        <div class="kt-portlet__head-actions">
                            <div class="row">
                                <asp:LinkButton ID="BtnAdd" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" Text="Add" OnClick="BtnAdd_Click" Style="padding-top:14px;"></asp:LinkButton>
                                   </div>
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
                            AllowPaging="true" PageSize="10" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="rmd_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>

                                    <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="5px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                    </telerik:GridButtonColumn>

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="rmd_Month" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Month" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rmd_Month">
                                    </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="rmd_WorkingDays" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Working Days" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rmd_WorkingDays">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="CreatedBy" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Created By" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedBy">
                                    </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Status">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
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
                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                </div>
            </div>
        </div>
    </div>

</asp:Content>