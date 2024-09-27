<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="UserDailyProcessDetail.aspx.cs" Inherits="SalesForceAutomation.Admin.UserDailyProcessDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="grvRpt">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lnkSales" />
                    <telerik:AjaxUpdatedControl ControlID="lnkOrder" />
                    <telerik:AjaxUpdatedControl ControlID="lnkAR" />
                    <telerik:AjaxUpdatedControl ControlID="lnkAP" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <div class="kt-portlet__head" style="padding-top: 20px">

                        <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs">
                            <div class="kt-portlet__head-label" style=" margin-bottom: 3px;">
                                <h3 class="kt-portlet__head-title">
                                    <asp:Label ID="lblrotname" runat="server"></asp:Label>
                                </h3>
                            </div>

                            <a href="UserDailyProcess.aspx" class="kt-subheader__breadcrumbs">User Daily Process </a>
                            <span class="kt-subheader__breadcrumbs-separator">.</span>
                            <%--<a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>--%>
                            <%--<span class="kt-subheader__breadcrumbs-separator">></span>--%>
                            <a class="kt-subheader__breadcrumbs-link">User Daily Process Detail </a>
                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->


                        </div>
                        <div class="kt-portlet__head-actions" style="margin-left:auto;">
                            <div class="row">
                                <div class="col-sm-3">
                                    
                                      <asp:ImageButton ID="map" Visible="true" AlternateText="Map" runat="server" Height="20" OnClick="map_Click"
                                        ImageUrl="assets/media/UDP/tracking.png"></asp:ImageButton>
                                </div>
                                <div class="col-sm-3" style="padding-right:35px;">
                                  <asp:ImageButton ID="report" Visible="true" AlternateText="Report" Height="20" runat="server" OnClick="report_Click"
                                        ImageUrl="assets/media/UDP/kpi.png"></asp:ImageButton>

                                </div>
                                <div class="col-sm-3" style="padding-right:35px;">
                                    <asp:ImageButton ID="settlement" runat="server" ImageUrl="assets/media/UDP/settlement.png" Height="20" ToolTip="Settlement" OnClick="Settelment_Click1" AlternateText="Xlsx" />
                                </div>
                                <div class="col-sm-3" style="padding-right:35px;">
                                    <asp:ImageButton ID="ImageButton1" Visible="false" runat="server" ImageUrl="assets/media/UDP/excel.png" Height="20" ToolTip="Download" AlternateText="Xlsx" />
                                </div>
                                <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn" BackColor="#E2E5EE" OnClick="lnkCancel_Click" Visible="false">Cancel</asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <div class="kt-portlet__body pb-0" style="padding: 0px;">


                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="">
                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="display: normal;">
                                                <div class="row">


                                                    <div class="col-sm-3">
                                                        <img src="assets/media/UDP/User.png" class="img-responsive" style="height: 20px;" alt="Image">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <img src="assets/media/UDP/version.png" class="img-responsive" style="height: 20px;" alt="Image">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Version:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblVersion" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>


                                                    <div class="col-sm-2">
                                                        <img src="assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Start Time:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <img src="assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">End Time:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <img src="assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Duration:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblDuration" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>

                                                </div>
                                                <div class="col-lg-12 row">
                                                   
                                                    <div class="col-lg-4" style="padding-top: 30px; margin-top:20px; font-size:large; opacity:0.85">

                                                        <asp:Panel ID="code" runat="server" Visible="true" >

                                                        <asp:LinkButton ID="LinkButton2" runat="server" visible="true">
                                                            <div class="fs-7 fw-bold lh-1" style="color: black; font-weight:bold; font-size:35px;">
                                                                <asp:Label ID="lblTotalVisits" runat="server"></asp:Label>
                                                            </div>
                                                          
                                                            <div class="fs-7 fw-bold" style="color: black; font-weight:bold;">Customer visits</div>
                                                        </asp:LinkButton>  

                                                          </asp:Panel>
                                                        <asp:Panel ID="cus" runat="server" Visible="false">

                                                        <asp:LinkButton ID="LinkButton3" runat="server" >
                                                            
                                                            <div class="fs-7 fw-bold lh-1" style="color: black; font-weight:bold; font-size:17px;">
                                                                <asp:Label ID="lblcode" runat="server"></asp:Label>
                                                                
                                                            </div>
                                                            <div class="fs-7 fw-bold lh-1" style="color: black; font-weight:bold; font-size:17px;">
                                                             
                                                                <asp:Label ID="lblcusName" runat="server" ></asp:Label>
                                                            </div>
                                                            <div class="fs-7 fw-bold lh-1 row" style="color: black; font-size:13px;  margin-bottom:2px; margin-top:20px;">
                                                              <div style="margin-left:9px;">
                                                                Start Time : 
                                                            <span class="">
                                                                <asp:Label ID="lblsTime" runat="server" ></asp:Label>
                                                            </span>
                                                                  </div>
                                                                <div style="margin-left:42px;">
                                                                 End Time : 
                                                            <span class="">
                                                                <asp:Label ID="lbleTime" runat="server" ></asp:Label>
                                                            </span>
                                                                  </div>
                                                            </div>

                                                            <div class="fs-7 fw-bold" style="color: black; font-size:13px;">
                                                                Duration :
                                                                <span class="" >
                                                                <asp:Label ID="lbldurations" runat="server" ></asp:Label>
                                                            </span>
                                                            </div>
                                                               
                                                        </asp:LinkButton>   
                                                            
                                                             </asp:Panel>
                                                    </div>
                                                      


                                                   




                                                    <div class="col-lg-8">
                                                        <div class="card-body d-flex flex-column">
                                                            <!--begin::Row-->
                                                            <div class="row g-0">
                                                                
                                                                <!--begin::Col-->
                                                                <div class="col-6">
                                                                    <div class="d-flex align-items-center mb-9 me-2">
                                                                        <!--begin::Symbol-->
                                                                        <div class="symbol symbol-40px me-3" style="background-color: white; margin-right: 40px; padding-top: 20px;">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:10px;">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <img src="assets/media/UDP/invoice.png" alt="Invoice" width="28" height="25" style="margin:10px; margin-left:15px; margin-right:15px;"/>
                                                                                </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                        <!--end::Symbol-->
                                                                        <!--begin::Title-->
                                                                        <div style="margin-right:75px;">
                                                                            <asp:LinkButton ID="lnkinvoices" runat="server" OnClick="lnkinvoices_Click">
                                                                                <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                                                    <asp:Label ID="lblTotalInvoices" runat="server" Text="20"></asp:Label>
                                                                                </div>
                                                                                <div class="fs-7 fw-bold" style="color: black;">
                                                                                   
                                                <span class="" style="font-size: 17px; font-weight:bold;">
                                                    <asp:Label ID="lblTotalInvoice" runat="server"></asp:Label>
                                                </span>
                                                                                </div>
                                                                                <div class="fs-7 fw-bold" style="color: black; margin-right:40px;">Invoices</div>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                        <!--end::Title-->
                                                                        <div class="symbol symbol-40px me-3" style="background-color: white; margin-right: 40px; padding-top: 20px;">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:7px;">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <asp:ImageButton ID="RadImageButton3" Visible="true" AlternateText="arrow" runat="server" Height="15" style="padding-top:4px; margin:7px;"
                                                                                          ImageUrl="assets/media/icons/svg/General/right-arrow.svg"></asp:ImageButton>
                                                                                    </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <!--end::Col-->
                                                                <!--begin::Col-->
                                                                <div class="col-6">
                                                                    <div class="d-flex align-items-center mb-9 ms-2">
                                                                        <!--begin::Symbol-->
                                                                        <div class="symbol symbol-40px me-3" style="margin-right:40px; padding-top: 20px;">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:10px;">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <img src="assets/media/UDP/orders.png" alt="Orders" width="28" height="25" style="margin:10px; margin-left:15px; margin-right:15px;" />
                                                                                </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                        <!--end::Symbol-->
                                                                        <!--begin::Title-->
                                                                        <div>
                                                                            <asp:LinkButton ID="lnkOrders" runat="server" OnClick="lnkOrders_Click">
                                                                                <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                                                    <asp:Label ID="lblTotalGReturns" runat="server" Text="0"></asp:Label>
                                                                                </div>
                                                                                <div class="fs-7 fw-bold" style="color: black;">
                                                                                   
                                                <span class="" style="font-size: 17px; font-weight:bold;">
                                                    <asp:Label ID="lblTotalOrders" runat="server"></asp:Label>
                                                </span>
                                                                                </div>
                                                                                <div class="fs-7 fw-bold" style="color: black;">Orders</div>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                        <!--end::Title-->
                                                                          <div class="symbol symbol-40px me-3" style="background-color: white; margin-right: 40px; padding-top: 20px;">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:7px; margin-left: 85px;">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <asp:ImageButton ID="ImageButton2" Visible="true" AlternateText="arrow" runat="server" Height="15" style="padding-top:4px; margin:7px;"
                                                                                          ImageUrl="assets/media/icons/svg/General/right-arrow.svg"></asp:ImageButton>
                                                                                    </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <!--end::Col-->
                                                               
                                                                <!--begin::Col-->
                                                                <div class="col-6">
                                                                    <div class="d-flex align-items-center me-2">
                                                                        <!--begin::Symbol-->
                                                                        <div class="symbol symbol-40px me-3" style="margin-right:40px; padding-top: 20px; ">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:10px;">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <img src="assets/media/UDP/ar.png" alt="AR" width="28" height="25" style="margin:10px; margin-left:15px; margin-right:15px;" />
                                                                                </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                        <!--end::Symbol-->
                                                                        <!--begin::Title-->
                                                                        <div style="margin-right:75px;">
                                                                            <asp:LinkButton ID="lnkAr" runat="server" OnClick="lnkAr_Click">
                                                                                <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                                                    <asp:Label ID="lblTotalBReturns" runat="server" Text="0"></asp:Label>
                                                                                </div>
                                                                                <div class="fs-7 fw-bold" style="color: black;">
                                                                                  
                                                <span class="" style="font-size: 17px; font-weight:bold;">
                                                    <asp:Label ID="lblTotalAR" runat="server"></asp:Label>
                                                </span>
                                                                                </div>
                                                                                <div class="fs-7 fw-bold" style="color: black; margin-right:40px;">Account Receivables</div>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                        <!--end::Title-->
                                                                          <div class="symbol symbol-40px me-3" style="background-color: white; margin-right: 40px; padding-top: 20px;">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:7px; ">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <asp:ImageButton ID="ImageButton3" Visible="true" AlternateText="arrow" runat="server" Height="15" style="padding-top:4px; margin:7px;"
                                                                                          ImageUrl="assets/media/icons/svg/General/right-arrow.svg"></asp:ImageButton>
                                                                                    </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <!--end::Col-->
                                                                <!--begin::Col-->
                                                                <div class="col-6">
                                                                    <div class="d-flex align-items-center ms-2">
                                                                        <!--begin::Symbol-->
                                                                        <div class="symbol symbol-40px me-3" style="margin-right:40px; padding-top: 20px; ">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:10px;">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs045.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <img src="assets/media/UDP/advance.png" alt="AP" width="28" height="25" style="margin:10px; margin-left:15px; margin-right:15px;" />
                                                                                </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                        <!--end::Symbol-->
                                                                        <!--begin::Title-->
                                                                        <div>
                                                                            <asp:LinkButton ID="lnkAp" runat="server" OnClick="lnkAp_Click">
                                                                              <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                                                    <asp:Label ID="lblTotalFreeGoodsreturns" runat="server" Text="0"></asp:Label>
                                                                                </div>
                                                                                 <div class="fs-7 fw-bold" style="color: black;">
                                                                                  
                                                <span class="" style="font-size: 17px; font-weight:bold;">
                                                    <asp:Label ID="lblTotalAP" runat="server"></asp:Label>
                                                </span>
                                                                                </div>
                                                                                <div class="fs-7 fw-bold" style="color: black;">Advance Collection</div>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                        <!--end::Title-->
                                                                          <div class="symbol symbol-40px me-3" style="background-color: white; margin-right: 40px; padding-top: 20px;">
                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius:7px; margin-left: 56px;">
                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                    <asp:ImageButton ID="ImageButton5" Visible="true" AlternateText="arrow" runat="server" Height="15" style="padding-top:4px; margin:7px;"
                                                                                          ImageUrl="assets/media/icons/svg/General/right-arrow.svg"></asp:ImageButton>
                                                                                    </span>
                                                                                <!--end::Svg Icon-->
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <!--end::Col-->
                                                               
                                                            </div>
                                                            <!--end::Row-->
                                                        </div>
                                                    </div>
                                                </div>
                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>


                            <div class="col-lg-12 row" style="padding-bottom: 30px;" hidden="hidden">

                                <div class="col-lg-3" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">Select Customer </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <%--  <telerik:RadComboBox Skin="Material" Filter="Contains" CloseDropDownOnBlur="true" RenderMode="Lightweight"
                                            ID="ddlCustomer" runat="server"
                                            EmptyMessage="Select Customer" Width="100%">
                                        </telerik:RadComboBox>--%>

                                        <telerik:RadComboBox ID="ddlCustomer" runat="server" Filter="Contains"
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" EmptyMessage="Select Customer" Width="100%">
                                        </telerik:RadComboBox>
                                    </div>
                                </div>




                            </div>

                        </div>

                           

                        
                            <div class="kt-portlet__body">
                                <%--<h3 style="color: blue">Customer Visits </h3>--%>

                                <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                    <script type="text/javascript"> 
                                        function grvRpt_RowDblClick(sender, args) {
                                            debugger;
                                            var ClickedIndex = args._itemIndexHierarchical;
                                            //changed code here 
                                            var grid = $find("<%=grvRpt.ClientID %>");
                                            if (grid) {
                                                var MasterTable = grid.get_masterTableView();
                                                var Rows = MasterTable.get_dataItems();
                                                for (var i = 0; i < Rows.length; i++) {
                                                    var row = Rows[i];
                                                    if (ClickedIndex != null && ClickedIndex == i) { // newly added
                                                        MasterTable.fireCommand("MyClick1", ClickedIndex); // newly added
                                                    } // newly added
                                                }
                                            }
                                        }
                                    </script>
                                </telerik:RadScriptBlock>


                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None" BorderWidth="0" 
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="50" CellSpacing="0">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        <ClientEvents OnRowClick="grvRpt_RowDblClick" />
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false" 
                                        ShowFooter="false" DataKeyNames="cse_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <%--   <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="det" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="assets/media/icons/svg/General/Clipboard.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>

                                            <%--<telerik:GridBoundColumn DataField="cse_ID" AllowFiltering="true" HeaderStyle-Width="150px" Display="false"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cse_ID">
                                            </telerik:GridBoundColumn>--%>

                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Customer" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="customer">
                                            </telerik:GridBoundColumn>

                                            <%-- <telerik:GridBoundColumn DataField="csh_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Site Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="csh_Code">
                                            </telerik:GridBoundColumn>--%>

                                            <telerik:GridBoundColumn DataField="cse_StartTime" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Start Time" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cse_StartTime">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cse_Endime" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="End Time" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cse_Endime">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Duration" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Duration" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Duration">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="salecount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Invoices" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="salecount">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ordercount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Orders" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ordercount">
                                            </telerik:GridBoundColumn>

                                            <%-- <telerik:GridBoundColumn DataField="inventorycount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AR" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="inventorycount">
                                            </telerik:GridBoundColumn>--%>

                                            <telerik:GridBoundColumn DataField="ARcount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AR" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ARcount">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Adpaymentcount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Advance" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Adpaymentcount">
                                            </telerik:GridBoundColumn>

                                            <%-- <telerik:GridBoundColumn DataField="cse_EndGeoCodeName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="End GeoCode Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cse_EndGeoCodeName">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="SyncedDatetime" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Synced Datetime" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="SyncedDatetime">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="CreationMode" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Creation Mode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreationMode">
                                            </telerik:GridBoundColumn>--%>
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
                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                            </div>

                        </telerik:RadAjaxLoadingPanel>
                    </div>

                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body pb-0">

                            <div class="col-lg-12 row" style="padding-bottom: 30px;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
