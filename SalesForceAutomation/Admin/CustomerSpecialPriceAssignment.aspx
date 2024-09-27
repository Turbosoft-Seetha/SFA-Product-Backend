<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="CustomerSpecialPriceAssignment.aspx.cs" Inherits="SalesForceAutomation.Admin.CustomerSpecialPriceAssignment" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

    <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function Delete() {
            $('#kt_modal_1_6').modal('show');
        }
        function DeleteSuccess() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }
        function DeleteFailed() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function Question() {
            $('#kt_modal_1_8').modal('show');
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_9').modal('show');
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


                            <div class="kt-subheader__breadcrumbs" style="padding-left: 20px;">
                                <a href="ListProductMappingGroup.aspx" class="kt-subheader__breadcrumbs">
                                    <i class="flaticon2-shelter"></i>Product Mapping Group </a>
                                <span class="kt-subheader__breadcrumbs-separator">></span>
                                <%-- <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>--%>
                                <a class="kt-subheader__breadcrumbs-link">Customer SpecialPrice  Assignment </a>

                                <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                            </div>

                        </div>
                    </div>
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Special Price Assignment
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            </h3>
                        </div>
                    </div>

                      <%--<telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                    --%>
                          <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                      
                            <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Route</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains"  RenderMode="Lightweight"
                                            ID="rdRoute" runat="server" EmptyMessage="Select Route" Width="100%" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged1" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Customer</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains"  RenderMode="Lightweight"
                                            ID="rdCustomer" runat="server" EmptyMessage="Select Customer" Width="100%" OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>

                                <div class="col-lg-2 ">
                                    <label class="control-label col-lg-12">From Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
<%--                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>

                                <div class="col-lg-2 ">
                                    <label class="control-label col-lg-12">To Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
<%--                                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>


                            </div>
                        
                    </div>
<%--                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center">
                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>--%>

                    <div class="col-lg-12 row">
                        <div class="col-lg-6">

                            <!--begin::Portlet-->
                            <div class="kt-portlet">

                                <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">Un Assigned Special Price
                                        </h3>
                                    </div>
                                    <div class="kt-portlet__head-actions">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                            <asp:LinkButton ID="lnkAddQuestion" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" OnClientClick="Confim();" Style="background-color: green; border-color: green;">
                                                    Add
                                            </asp:LinkButton>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center">
                                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                    </div>
                                </div>

                                <!--begin::Form-->
                                <div class="kt-form kt-form--label-right">
                                    <div class="kt-portlet__body">
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                        <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="RadGrid1" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="RadGrid1_NeedDataSource1"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="prh_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridBoundColumn DataField="prh_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_ID" Display="false">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prh_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prh_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="S.P Name" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_Name">
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
                                        </telerik:RadAjaxPanel>

                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center">
                                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-6">
                            <!--begin::Portlet-->
                            <div class="kt-portlet">
                                <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">Assigned Special price
                                        </h3>
                                    </div>
                                    <div class="kt-portlet__head-actions">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                            <asp:LinkButton ID="lnkRemove" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" Text="Remove" OnClientClick="Delete()" Style="background-color: red; border-color: red;"></asp:LinkButton>
                                        </telerik:RadAjaxPanel>

                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center">
                                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                    </div>
                                </div>
                                <!--begin::Form-->
                                <div class="kt-form kt-form--label-right">
                                    <div class="kt-portlet__body">
                                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                                        <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
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
                                                    ShowFooter="false" DataKeyNames="prh_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridBoundColumn DataField="prh_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_ID" Display="false">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prh_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prh_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="S.P Name" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_Name">
                                                        </telerik:GridBoundColumn>



                                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:ImageButton CommandName="Delete" ID="RadImageButton3" Visible="true" AlternateText="Delete" runat="server"
                                                                    ImageUrl="assets/media/icons/svg/General/Trash.svg"></asp:ImageButton>
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
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
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
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to add ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" OnClick="LinkButton1_Click">
                                                    Add
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Product  has been updated successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" OnClick="lnkDelete_Click">
                                                    Yes
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Product has been deleted successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Questions assigned for survey</h5>
                </div>
                <div class="modal-body">
                    <asp:Literal ID="ltTable" runat="server" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">No selection found..!</h5>
                </div>
                <div class="modal-body">
                    <p>Please make selection and try again.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

</asp:Content>
