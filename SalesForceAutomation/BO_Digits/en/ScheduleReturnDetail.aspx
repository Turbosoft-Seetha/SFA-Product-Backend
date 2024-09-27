<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ScheduleReturnDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ScheduleReturnDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

    <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="33" ToolTip="PDF" OnClick="btnPDF_Click" AlternateText="pdf" />



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <!--begin::Form-->
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                    <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12 mb-3" Width="100%" ID="RadPanelBar0" runat="server">
                                        <Items>
                                            <telerik:RadPanelItem Font-Bold="true" Expanded="True" BackColor="white">

                                                <ContentTemplate>
                                                    <div class="kt-portlet__body mt-5 mb-2" style="background-color: white; display: grid; padding-left: 20px;">
                                                        <table>
                                                            <tr>
                                                                <td class="col-lg-5">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Return Request Number:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblNum" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </td>

                                                                <td class="col-lg-4">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Invoice ID:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblinv" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </td>

                                                                <td class="col-lg-3">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Total Amount (Excl.VAT):</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblTotalAmt" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <%--<td class="col-lg-5">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblcus" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </td>--%>
                                                                <td class="col-lg-5">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Customer code:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblcuscode" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </td>

                                                                <td class="col-lg-4">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </td>
                                                                  <td class="col-lg-5">
                                                                     <div class="col-lg-12 mb-2">
                                                                         <label class="col-lg-2 col-form-label" style="display: contents;">VAT Amount:</label>
                                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                             <asp:Label ID="lblVATTot" Font-Bold="true" runat="server"></asp:Label></label>
                                                                     </div>
                                                                 </td>

                                                            </tr>

                                                            <tr>
                                                                <%-- <td class="col-lg-5">
                                                                     <div class="col-lg-12 mb-2">
                                                                         <label class="col-lg-2 col-form-label" style="display: contents;">Remarks:</label>
                                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                             <asp:Label ID="lblRemarks" Font-Bold="true" runat="server"></asp:Label></label>
                                                                     </div>
                                                                 </td>--%>
                                                                 <td class="col-lg-5">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblcus" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </td>

                                                                <td class="col-lg-4">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Signature:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                             <asp:Label ID="lblSignature" Font-Bold="true" runat="server"></asp:Label></label>

                                                                              <asp:PlaceHolder runat="server" ID="pnlSignature" Visible="false">
                                                                                  <asp:HyperLink ID="hl" runat="server" NavigateUrl=' <%#  Eval("rrh_Signature") %>' Target="_blank">
                                                                                        <asp:Image ID="Signature" runat="server" ImageUrl=' <%#  Eval("rrh_Signature") %>' Height="30px" Width="50px" />
                                                                                    </asp:HyperLink>
                                                                              </asp:PlaceHolder>
                                                                             
                                                                    </div>
                                                                </td>
                                                               
                                                                   <td class="col-lg-5">
                                                                     <div class="col-lg-12 mb-2">
                                                                         <label class="col-lg-2 col-form-label" style="display: contents;">Total Amount  (Inc.VAT):</label>
                                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                             <asp:Label ID="lblTotalWithVAt" Font-Bold="true" runat="server"></asp:Label></label>
                                                                     </div>
                                                                 </td>                                                               
                                                            </tr>
                                                            <tr>

                                                                 <td class="col-lg-5">
                                                                     <div class="col-lg-12 mb-2">
                                                                         <label class="col-lg-2 col-form-label" style="display: contents;">Remarks:</label>
                                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                             <asp:Label ID="lblRemarks" Font-Bold="true" runat="server"></asp:Label></label>
                                                                     </div>
                                                                 </td>


                                                            </tr>


                                                        </table>
                                                    </div>

                                                </ContentTemplate>
                                            </telerik:RadPanelItem>
                                        </Items>
                                    </telerik:RadPanelBar>

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
                                            ShowFooter="false" DataKeyNames="rrd_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>



                                                <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Product Name" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="prd_ItemLongDesc" AllowFiltering="true" HeaderStyle-Width="170px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Product Description" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_ItemLongDesc">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="uom_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Name">
                                                </telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn DataField="rrd_HQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rrd_HQty">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />

                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="luom_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="luom_Name">
                                                </telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn DataField="lqty" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lqty">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />

                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="rrd_HigherPrice" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Higher Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rrd_HigherPrice">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />

                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="rrd_LowerPrice" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Lower Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rrd_LowerPrice">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />

                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="rsn_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Reason" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rsn_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="80px" HeaderText="Attached Image" HeaderStyle-Font-Size="Smaller"
                                                    HeaderStyle-Font-Bold="true">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="pp" runat="server" NavigateUrl=' <%#  Eval("rrd_Image") %>' Target="_blank">
                                                            <asp:Image ID="itmImage" runat="server" ImageUrl=' <%#  Eval("rrd_Image") %>' Height="20px" Width="20px" />
                                                        </asp:HyperLink>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>



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
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
