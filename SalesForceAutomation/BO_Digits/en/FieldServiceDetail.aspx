<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="FieldServiceDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.FieldServiceDetail" %>

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
                        <div class="kt-form kt-form--label-right">
                            <div class="kt-portlet__body pb-0" style="border-bottom-style: inset; border-bottom-width: thin; padding-top: 10px; margin-bottom: 10px;">


                                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                                    <Items>
                                        <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">
                                            <ContentTemplate>
                                                <div class="kt-portlet__body" style="display: grid;">
                                                    <table>
                                                        <td style="width: 56%; padding-left: 40px;">
                                                            <div class="col-lg-12 mb-2 row">
                                                                <div class="col-lg-4">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>
                                                                <div class="col-lg-4">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblCustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>
                                                                <div class="col-lg-4">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Number:</label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblNumber" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Scheduled Date:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Status:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblStatus" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                        </td>
                                                    </table>
                                                </div>
                                            </ContentTemplate>
                                        </telerik:RadPanelItem>
                                    </Items>
                                </telerik:RadPanelBar>


                            </div>


                            <!-- ---------------------------- -->


                            <!-- ---------------------------- -->




                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class="kt-portlet__body">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        AllowFilteringByColumn="false"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="50" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="true" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="sjd_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="sjd_Question" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Question" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sjd_Question">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sjd_Answer" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Answer" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sjd_Answer">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sjd_Type" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sjd_Type">
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
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
