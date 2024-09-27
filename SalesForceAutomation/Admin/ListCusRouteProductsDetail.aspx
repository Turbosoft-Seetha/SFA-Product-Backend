<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="ListCusRouteProductsDetail.aspx.cs" Inherits="SalesForceAutomation.Admin.ListCusRouteProductsDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

    <script type="text/javascript">
        function cusroute() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("Id");
            var R = url.searchParams.get("RID");
            window.location.href = "ListCustomerRoute.aspx?Id=" + R;
        }
        function cusproduct() {
            var url = new URL(window.location.href);
            var S = url.searchParams.get("ID");
            var P = url.searchParams.get("RID");
            window.location.href = "ListCusRouteProducts.aspx?CID=" + S + "&RID=" + P;
        }
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(ab) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#Success').text(ab);
        }
        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">

                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">

                            <h3 class="kt-portlet__head-title">Customer Route Products
                            </h3>
                              <div class="kt-subheader__breadcrumbs" style="padding-left:20px;">
                            <a href="ListRoute.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Route </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:cusroute();" class="kt-subheader__breadcrumbs-link">Route Customer </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:cusproduct();" class="kt-subheader__breadcrumbs-link">Customer Special Price </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Customer Special Price Detail</a>
                            <%--<span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Add Edit Customer Route Products </span> -->--%>
                        </div>
                          <div class="kt-portlet__head-actions" style="padding-left:200px;">
                           
                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" ImageAlign="Right"/>
                      </div>
                        </div>
                       
                    </div>
                     <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                   
                     <div>
                            <telerik:RadLabel ID="lblprhname" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                            <telerik:RadLabel ID="lblpaymode" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                        </div>
                         
                         </div>

                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">




                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

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
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="crp_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>

                                       
                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="std_Price" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Standard Price" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="std_Price">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="pld_uom_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product UOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="pld_uom_ID">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="Special_Price" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Special Price" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Special_Price">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Sub Category" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
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

                </div>
            </div>
        </div>
    </div>
</asp:Content>
