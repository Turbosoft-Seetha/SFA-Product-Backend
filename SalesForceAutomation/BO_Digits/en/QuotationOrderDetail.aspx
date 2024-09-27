<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="QuotationOrderDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.QuotationOrderDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
  
       <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color:white; padding:20px;">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
              <%--  <a href="OrderDetail.aspx">OrderDetail.aspx</a>--%>
                <div class="kt-portlet">




                   



                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body" ">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">


                                <!--begin::Form-->
                                <div class="kt-form kt-form--label-right">
                                     <div class="card-body" style="background-color:white; padding-bottom:10px;">
                               <div class="kt-portlet__head-actions" style=" text-align-last: end;">


                         
                        </div>

                                        <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                            <Items>
                                                <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                                    <ContentTemplate>
                                                        <div class="kt-portlet__body" style="background-color: white; display: grid ;padding-left:20px;">
                                                            <table>
                                                                <td style="width: 50%">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>

                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Created Date:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Created By:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCreatedBy" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                     <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Pay Mode:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblpaymode" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>



                                                                </td>
                                                               <td  style="width: 10%">
                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Total:</label>

                                                                    </div>
                                                                   <div class="col-lg-12 mb-2">
                                                                       <label class="col-lg-2 col-form-label" style="display: contents;">Discount:</label>

                                                                   </div>
                                                                   <div class="col-lg-6 mb-2">
                                                                       <label class="col-lg-2 col-form-label" style="display: contents;">SubTotal:</label>

                                                                   </div>

                                                                   <%--  <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Line Total:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lbllinetotal" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>--%>

                                                                   <div class="col-lg-6 mb-2">
                                                                       <label class="col-lg-2 col-form-label" style="display: contents;">VAT:</label>

                                                                   </div>
                                                                   <div class="col-lg-12 mb-2">
                                                                       <label class="col-lg-2 col-form-label" style="display: contents;">Grand Total:</label>

                                                                   </div>

                                                               </td>
                                                                <td class="align-right" style="width: 40%">
                                                                    <div class="col-lg-6 mb-2">
                                                                       
                                                                        <label class="col-lg-6 col-form-label" style="display: contents; text-align: right;">
                                                                            <asp:Label ID="lbltotal" Font-Bold="true" runat="server"></asp:Label>
                                                                        </label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">
                                                                       
                                                                        <label class="col-lg-6 col-form-label" style="display: contents; text-align:;">
                                                                            <asp:Label ID="lblDis" Font-Bold="true" runat="server"></asp:Label>
                                                                        </label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">
                                                                      
                                                                        <label class="col-lg-6 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblSub" Font-Bold="true" runat="server"></asp:Label>
                                                                        </label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">
                                                                      
                                                                        <label class="col-lg-6 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblvat" Font-Bold="true" runat="server"></asp:Label>
                                                                        </label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">

                                                                        <label class="col-lg-6 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblGrand" Font-Bold="true" runat="server"></asp:Label>
                                                                        </label>
                                                                    </div>
                                                                </td>

                                                            </table>


                                                        </div>
                                                        <style>
                                                            .align-right {
                                                                text-align: right;
                                                            }
                                                        </style>
                                                    </ContentTemplate>
                                                </telerik:RadPanelItem>
                                            </Items>
                                        </telerik:RadPanelBar>
                                     </div>
                                    <!--end: Search Form -->
                                    
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" >
                                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                        <%--<div class="kt-portlet__body">--%>
                                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="grvRpt" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="grvRpt_NeedDataSource"
                                            OnItemCommand="grvRpt_ItemCommand"
                                            AllowFilteringByColumn="false"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="odd_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                       <telerik:GridBoundColumn DataField="odd_TransType" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Transaction Type" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="odd_TransType">
                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="false" HeaderStyle-Width="110px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Code"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="false" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Product"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="odd_HigherUOM" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherUOM">
                                                    </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="odd_HigherQty" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherQty">
                                                         <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="odd_HigherPrice" AllowFiltering="false" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher Price"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherPrice">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="odd_LowerUOM" AllowFiltering="false" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerUOM">
                                                    </telerik:GridBoundColumn>

                                                    

                                                    <telerik:GridBoundColumn DataField="odd_LowerQty" AllowFiltering="false" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerQty">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                  
                                                    <telerik:GridBoundColumn DataField="odd_LowerPrice" AllowFiltering="false" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower Price"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerPrice">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>



                                                    <telerik:GridBoundColumn DataField="odd_Price" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Price">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_Discount" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Discount"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Discount">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_SubTotal" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Sub Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_SubTotal">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_VATAmount" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="VAT"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_VATAmount">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_GrandTotal" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Line Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_GrandTotal">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                 
                                    


                                  <%--  <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Status">
                                    </telerik:GridBoundColumn>--%>
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
    </div>
</div>
</asp:Content>
