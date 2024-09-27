<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="InventoryHeader.aspx.cs" Inherits="SalesForceAutomation.Admin.InventoryHeader" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   <%-- <div class="kt-portlet__head" style="padding-top: 20px;  padding-bottom: 20px;">

                      c
                        <%--<div class="kt-portlet__head-actions">

                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

                         </div>--%>
                    <%--</div>--%>

                    <div class="kt-portlet__head" style="padding-top: 8px; padding-bottom: 8px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Inventory </h3>
                              <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs" style="padding-left:30px">


                            <a href="InventoryHeader.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i>Inventory </a>
                            <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Reviewer/Approver Assignment </a>--%>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                        </div>
                        <div class="kt-portlet__head-actions" >

                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" style="padding-right:25px" AlternateText="Xlsx" />


                            <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="assets/media/icons/file.png" Height="40" Width="30" ToolTip="Print"
                                OnClick="btnPDF_Click" AlternateText="pdf" />
                        </div>

                    </div>

                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                                   

                                     <div class="col-lg-3">
                                        <label class="control-label col-lg-12">Route</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="rdRoute" runat="server" EmptyMessage="Select Route"  Width="100%" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12">Customer</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="rdCustomer" runat="server" EmptyMessage="Select Customer" Width="100%" OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    
                                     <div class="col-lg-2 ">
                                        <label  class="control-label col-lg-12">From Date</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 ">
                                        <label  class="control-label col-lg-12">To Date</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" Width="100%" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                            <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-2" style=" top: 10px; text-align:center;">
                                        <asp:LinkButton ID="lnkDOwnload" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="false" OnClick="lnkDOwnload_Click">
                                                   Apply Filter
                                        </asp:LinkButton>
                                    </div>

                                </div>
                                <!--end: Search Form -->
                               
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
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="inh_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>


                                                    <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <asp:ImageButton CommandName="Item" ID="RadImageButton2" Visible="true" AlternateText="Item" runat="server"
                                                                ImageUrl="assets/media/icons/svg/General/Star.svg"></asp:ImageButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer " FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>
                                                    
                                                    <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="inh_Number" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Inventory Number" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="inh_Number">
                                                    </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="usr_Code" AllowFiltering="true" HeaderStyle-Width="70px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="User Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="usr_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="inh_Remarks" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="inh_Remarks" Visible="false">
                                                    </telerik:GridBoundColumn>



                                                </Columns>
                                            </MasterTableView>
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
                                    <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                        </div>
                    </div>
                </div>
            </div>
   
</asp:Content>
