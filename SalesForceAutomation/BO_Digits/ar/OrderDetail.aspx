<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.OrderDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
  
       <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="تحميل" OnClick="imgExcel_Click" AlternateText="Xlsx" />

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
                                                                <td style="width: 56%">
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">طريق:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">عميل:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>

                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">تاريخ الإنشاء:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">انشأ من قبل:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCreatedBy" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                     <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">وضع الدفع:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblpaymode" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>



                                                                </td>
                                                                <td>
                                                                      <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;"> المجموع:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lbltotal" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">تخفيض:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblDis" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">المجموع الفرعي:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblSub" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>

                                                                   <%--  <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Line Total:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lbllinetotal" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>--%>

                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">ضريبة القيمة المضافة:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblvat" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">المجموع الإجمالي:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblGrand" Font-Bold="true" runat="server"></asp:Label></label>
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
                                                ShowFooter="false" DataKeyNames="odd_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                       <telerik:GridBoundColumn DataField="odd_TransType" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="نوع المعاملة" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="odd_TransType">
                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="false" HeaderStyle-Width="110px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="كود المنتج"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="false" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText=" منتج"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="prd_NameArabic" AllowFiltering="false" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText=" اسم المنتج عربي"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_NameArabic">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="odd_HigherUOM" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="وحدة قياس أعلى"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherUOM">
                                                    </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="odd_HigherQty" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="كمية أعلى"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherQty">
                                                    </telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="odd_HigherPrice" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="أعلى سعر"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherPrice">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="odd_LowerUOM" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="وحدة القياس السفلية"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerUOM">
                                                    </telerik:GridBoundColumn>

                                                    

                                                    <telerik:GridBoundColumn DataField="odd_LowerQty" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="كمية أقل"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerQty">
                                                    </telerik:GridBoundColumn>
                                                  
                                                    <telerik:GridBoundColumn DataField="odd_LowerPrice" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="سعر منخفض"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerPrice">
                                                    </telerik:GridBoundColumn>



                                                    <telerik:GridBoundColumn DataField="odd_Price" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="المجموع"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Price">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_Discount" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="تخفيض"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Discount">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_SubTotal" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="المجموع الفرعي"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_SubTotal">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_VATAmount" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="ضريبة القيمة المضافة"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_VATAmount">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_GrandTotal" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="مجموعه الخط"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_GrandTotal">
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