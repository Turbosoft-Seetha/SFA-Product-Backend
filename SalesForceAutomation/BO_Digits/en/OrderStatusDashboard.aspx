<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OrderStatusDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OrderStatusDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
</telerik:RadAjaxManager>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="lblQtncount">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="grvRptQuatation" />

            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="lblSOcount">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="grvRptSalesOrder" />

            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="lblCSOcount">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="grvRptConfirmSO" />

            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="liQuotation">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="grvRptSalesOrder" />
                <telerik:AjaxUpdatedControl ControlID="grvRptQuatation" />
                <telerik:AjaxUpdatedControl ControlID="grvRptConfirmSO" />

            </UpdatedControls>
        </telerik:AjaxSetting>
         <telerik:AjaxSetting AjaxControlID="liSalesOrd">
     <UpdatedControls>
         <telerik:AjaxUpdatedControl ControlID="grvRptSalesOrder" />
         <telerik:AjaxUpdatedControl ControlID="grvRptQuatation" />
         <telerik:AjaxUpdatedControl ControlID="grvRptConfirmSO" />

     </UpdatedControls>
 </telerik:AjaxSetting>
         <telerik:AjaxSetting AjaxControlID="liConSalesOrd">
     <UpdatedControls>
         <telerik:AjaxUpdatedControl ControlID="grvRptSalesOrder" />
         <telerik:AjaxUpdatedControl ControlID="grvRptQuatation" />
         <telerik:AjaxUpdatedControl ControlID="grvRptConfirmSO" />

     </UpdatedControls>
 </telerik:AjaxSetting>

    </AjaxSettings>

</telerik:RadAjaxManagerProxy>
   




</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
   <%-- <div class="card-body" style="padding: 20px;">--%>

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="col-lg-12 row pt-4" style="display: -webkit-box; ">
         <div class="col-lg-2">
     <label class="control-label" style="padding-left: 15px;">Filter by <span class="required"></span></label>
     <div class="col-lg-12">
         <telerik:RadComboBox RenderMode="Lightweight" ID="ddlDatefilter"  runat="server" Width="100%">
             <Items>
                 <telerik:RadComboBoxItem Text="Created On" Value="CO"/>
                 <telerik:RadComboBoxItem Text="Expected Delivery" Value="ED" Selected="true"/>
             </Items>
         </telerik:RadComboBox>
     </div>
 </div>
        <div class="col-lg-2">
            <label class="control-label" style="padding-left: 15px;">From Date <span class="required"></span></label>
            <div class="col-lg-12">
                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
                </telerik:RadDatePicker>
            </div>
        </div>
        <div class="col-lg-2">
            <label class="control-label" style="padding-left: 15px;">To Date <span class="required"></span></label>
            <div class="col-lg-12">
                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged">
                </telerik:RadDatePicker>
                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                        
            </div>
        </div>
        <div class="col-lg-2">
            <label class="control-label" >Order Route <span class="required"></span></label>
            <div class="col-lg-12">
                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                    ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true" Width="100%">
                </telerik:RadComboBox>
            </div>
        </div>

        <div class="col-lg-2">
            <label class="control-label" >Customer <span class="required"></span></label>
            <div class="col-lg-12">
                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                    ID="rdCustomer" runat="server" EmptyMessage="Select Customer" AutoPostBack="true" Width="100%">
                </telerik:RadComboBox>
                <br />
            </div>
        </div>



        <div class="col-lg-2" style="padding-top: 15px;" >
            <div class="col-lg-8" style="width:auto;">
                <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
          Apply Filter
                </asp:LinkButton>
            </div>
        </div>

    </div>

            <div class="col-lg-12 row" style="padding-top: 10px;">

                <ul class="nav nav-pills nav-pills-custom mb-3" style="justify-content:space-around;">

                    <li id="liQuotation" class="nav-item col-lg-4 nav-link btn btn-sm btn-color-muted btn-active btn-active-purple fs-4 fw-bold px-4 me-1 " 
                        data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 31rem; height: 6.5rem; padding-top: 20px; " 
                        href="#kt_timeline_widget_1" runat="server" >
                    <%--<li class="nav-item col-lg-3 nav-link btn btn-sm text-hover-white btn-active btn-active-purple fs-4 fw-bold px-4 me-1 text-dark active text-white" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="width: 19.5rem; height: 6.5rem; padding-top: 20px;" href="#kt_timeline_widget_1">--%>
   
                        <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                        <%--<a class="nav-link text-black text-hover-white fs-4 fw-bold px-4 me-1 " style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1">Quatation  
                              
                        </a>--%>
                        <h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1 ">
                                <asp:Label ID="lblQtncount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>
                        <h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 text-black " style="padding-top: 20px">
                                <asp:Label ID="Label1" Text="Quotation" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>



                    </li>


                    <li id="liSalesOrd" class="nav-item col-lg-4 nav-link btn btn-sm btn-color-muted btn-active btn-active-purple fs-4 fw-bold px-4 me-1 " 
                        data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 31rem; height: 6.5rem; padding-top: 20px;" 
                        href="#kt_timeline_widget_2" runat="server">
                        <%--  <a class="nav-link text-black  fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_2">Sales Orders
                                    
                        </a>--%>
                        <h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1">
                                <asp:Label ID="lblSOcount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>
                        <h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 text-black " style="padding-top: 20px">
                                <asp:Label ID="Label2" Text="Sales Orders" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>

                    </li>
                    <li id="liConSalesOrd" class="nav-item col-lg-4 nav-link btn btn-sm btn-color-muted btn-active btn-active-purple fs-4 fw-bold px-4 me-1 " 
                        data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 31rem; height: 6.5rem; padding-top: 20px;" 
                        href="#kt_timeline_widget_3" runat="server">
                        <%--  <a class="nav-link text-black fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_3">Confirmed Sales Orders 
                
                        </a>--%>
                        <h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1">
                                <asp:Label ID="lblCSOcount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>
                        <h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 text-black " style="padding-top: 20px">
                                <asp:Label ID="Label3" Text="Confirmed Sales Orders" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>

                    </li>
                  <%--  <li id="liDelivered class="nav-item col-lg-3 nav-link btn btn-sm btn-color-muted btn-active btn-active-purple fs-4 fw-bold px-4 me-1 "
                      data-kt-timeline-widget-1="tab" data-bs-toggle="tab" style="background-color: white; width: 19.7rem; height: 6.5rem; padding-top: 20px;" 
                      href="#kt_timeline_widget_4" runat="server">
                     --%>   <%--  <a class="nav-link text-black fs-4 fw-bold px-4 me-1" style="padding-top: 10px" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_4">Delivered
                
                        </a>--%>
                        <%--<h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-3 mb-1">
                                <asp:Label ID="lblNDcount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>
                        <h6 style="text-align: left; padding-left: 10px;">
                            <span class="card-label fw-bold fs-4 mb-1 text-black " style="padding-top: 20px">
                                <asp:Label ID="Label4" Text="Delivered" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                        </h6>

                    </li>--%>

                </ul>


            </div>

            
            <div class="card-body" style="background-color: white;" >
                <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
            <div class="col-lg-12" style="padding-left: 15px;  padding-right: 15px; padding-top: 15px; background-color: white; margin-top: 35px">
                <div class="tab-content"  style="padding:10px;height:700px;">
                    <div class="tab-pane fade show active" id="kt_timeline_widget_1" style="height:700px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:700px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->



                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRptQuatation" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRptQuatation_NeedDataSource"
                                 OnItemCommand="grvRptQuatation_ItemCommand"
                               
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="ord_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                           <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered On" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Exp.Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cusname">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rotname">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status" ItemStyle-HorizontalAlign="Left">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks" ItemStyle-HorizontalAlign="Left">
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
                        </div>

                    </div>
                    <div class="tab-pane fade show " id="kt_timeline_widget_2" style="height:700px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:700px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRptSalesOrder" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRptSalesOrder_NeedDataSource"
                                OnItemCommand="grvRptSalesOrder_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="ord_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                         <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="SODetail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered On" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Exp.Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cusname">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rotname">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status" ItemStyle-HorizontalAlign="Left">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks" ItemStyle-HorizontalAlign="Left">
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
                        </div>

                    </div>
                    <div class="tab-pane fade show " id="kt_timeline_widget_3" style="height:700px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:700px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRptConfirmSO" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRptConfirmSO_NeedDataSource"
                                OnItemCommand="grvRptConfirmSO_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="ord_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                         <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="ConfirmedSODetail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered On" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Exp.Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cusname">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rotname">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status" ItemStyle-HorizontalAlign="Left">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks" ItemStyle-HorizontalAlign="Left">
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
                        </div>

                    </div>
                    <div class="tab-pane fade show " id="kt_timeline_widget_4" style="height:700px;">
                        <!--begin::Table container-->
                        <div class="table-responsive" style="height:700px;">



                            <!--begin::Portlet-->


                            <!--end: Search Form -->

                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRptDelivered" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRptDelivered_NeedDataSource"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="ord_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered On" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Exp.Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Del.Date" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Del.Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Del.Date">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="130px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cusname">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rotname">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="delrotname" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="delrotname">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="del_rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Del.Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="del_rot_Code">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status" ItemStyle-HorizontalAlign="Left">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks" ItemStyle-HorizontalAlign="Left">
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
                        </div>

                    </div>
                </div>

            </div>

                    </telerik:RadAjaxPanel>
<telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
    BackColor="Transparent"
    ForeColor="Blue">
    <div class="col-lg-12 text-center mt-5">
        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
    </div>
</telerik:RadAjaxLoadingPanel>
</div>
        </div>
    <%--</div>--%>
    <style>
       .btn-active-purple.active,
.btn-active-purple:active,
.btn-active-purple:focus {
    background-color: purple !important;
    border-color: purple !important;
}

/* Define a custom class for text color when active */
.btn-active-purple.active .card-label,
.btn-active-purple.active .card-label * {
    color: white !important;
}

    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
