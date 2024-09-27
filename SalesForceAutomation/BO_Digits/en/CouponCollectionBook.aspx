<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CouponCollectionBook.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CouponCollectionBook" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
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
                                                                <td style="width: 56%">
                                                                    <div class="col-lg-12 mb-4 mt-4">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                     <div class="col-lg-6 mb-4 mt-4">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Coupon:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblNumber" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                     <div class="col-lg-6 mb-4 mt-4">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Coupon Number:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCop" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                  

                                                                   


                                                                </td>

                                                                  <td style="width: 56%">
                                                                        <div class="col-lg-12 mb-4 mt-4">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Higher Qty:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblHqty" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>

                                                                        <div class="col-lg-12 mb-4 mt-4">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Adj Higher Qty:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblADJQty" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                        <div class="col-lg-12 mb-4 mt-4">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Final Higher Qty:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblFinal" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                       
                                                                      </td>
                                                              
                                                            </table>


                                                        </div>

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
                                                ShowFooter="false" DataKeyNames="cpb_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                       <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                                        

                                            <telerik:GridBoundColumn DataField="cpb_BookNumber" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Book Number" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cpb_BookNumber">
                                    </telerik:GridBoundColumn>

                                                   

                                                     <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="false" HeaderStyle-Width="70px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Created Date"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
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
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
