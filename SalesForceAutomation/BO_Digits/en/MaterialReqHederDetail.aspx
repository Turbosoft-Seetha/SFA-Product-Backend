<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="MaterialReqHederDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.MaterialReqHederDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet" style="background-color: white; padding: 20px;">



                        <!--begin::Form-->
                        <div class="kt-form kt-form--label-right">

                            <div class="kt-portlet__body pb-0">

                                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                    <Items>
                                        <telerik:RadPanelItem Font-Bold="true" Expanded="True" BackColor="#F2F6F9">

                                            <ContentTemplate>
                                                <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid">
                                                    <table>
                                                        <tr>
                                                            <td style="width: 75%">


                                                                <div class="col-lg-6 mb-2 ms-4">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Picking Loc:</label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblPicLoc" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>

                                                                <div class="col-lg-6 mb-2 ms-4">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Receive Loc:</label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblrcvloc" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>

                                                            </td>
                                                            <td >


                                                                <div class="col-lg-8 mb-2 ">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Date&Time:</label>
                                                                    <label class="col-lg-6 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>

                                                                <div class="col-lg-6 mb-2 ">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Exp. Date:</label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblExpDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>

                                                            </td>
                                                        </tr>

                                                    </table>


                                                </div>

                                            </ContentTemplate>
                                        </telerik:RadPanelItem>
                                    </Items>
                                </telerik:RadPanelBar>
                            </div>


                            <div class="kt-portlet__body">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true" ScrollHeight="500px">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="mrd_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>


                                            <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ReqHUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. HUOM" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ReqHUOM">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="RequestedHQty" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. HQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="RequestedHQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ReqLUOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. LUOM" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ReqLUOM">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="RequestedLQty" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. LQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="RequestedLQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>











                                        </Columns>
                                    </MasterTableView>
                                    <GroupingSettings CaseSensitive="false" />
                                    <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                        <Resizing AllowColumnResize="true"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>

    <div class="clearfix"></div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
