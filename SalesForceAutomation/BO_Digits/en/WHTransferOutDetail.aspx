<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="WHTransferOutDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.WHTransferOutDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function redirect() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("hid");
            window.location.href = "InventoryItem.aspx?Id=" + c;
        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">


    <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <!--begin::Form-->
                        <div class="card-body" style="background-color: white; padding-bottom: 10px;">


                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: white; display: grid; padding: 20px;">
                                                <table>
                                                    <tr>
                                                        <td style="width: 80%">


                                                            <div class="col-lg-6 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">MR Number:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblmrnum" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-6 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Picking Number:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblpicnum" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-6 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Date:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblCreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                        </td>
                                                        <td>

                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Picking Loc:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblStore" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Receiving Loc:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblWarehouse" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lbluser" Font-Bold="true" runat="server"></asp:Label></label>
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
                                        ShowFooter="false" DataKeyNames="wtd_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="wtd_TransferedHUOM" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Transfered HUOM" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="wtd_TransferedHUOM">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="wtd_TransferedHQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Transfered HQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="wtd_TransferedHQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="wtd_TransferedLUOM" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Transfered LUOM" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="wtd_TransferedLUOM">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="wtd_TransferedLQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Transfered LQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="wtd_TransferedLQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="wtd_PickedHQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Picked HQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="wtd_PickedHQty" Display="false">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="wtd_PickedLQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Picked LQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="wtd_PickedLQty" Display="false">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="str_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Store" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="str_Name" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="war_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Warehouse" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="war_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status" Display="false">
                                            </telerik:GridBoundColumn>

                                        </Columns>
                                    </MasterTableView>
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


