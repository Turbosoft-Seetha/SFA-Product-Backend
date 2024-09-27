<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AddEditRouteMonthlyTarget.aspx.cs" Inherits="SalesForceAutomation.Admin.AddEditRouteMonthlyTarget" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
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
        function Fail() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_6').modal('show');
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
                            <h3 class="kt-portlet__head-title">Add Edit Route Monthly Target
                            </h3>

                              <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs" style="padding-left:30px;">


                            <a href="RouteMonthlyTarget.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Route Monthly Target</a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Add Edit Route Monthly Target </a>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                        </div>
                        <div class="kt-portlet__head-actions">
                            <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:LinkButton ID="LinkButton1" Width="100px" runat="server" ValidationGroup="form" OnClick="LinkButton1_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Save'
                                    CssClass="btn btn-brand btn-elevate btn-icon-sm" CausesValidation="true" />
                                <asp:LinkButton ID="LinkButton2" Width="100px" runat="server"
                                    Text="Back" CssClass="btn btn-brand btn-elevate btn-icon-sm"
                                    CausesValidation="False" OnClick="LinkButton2_Click" />
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
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                        <div class="kt-portlet__body">


                            <div class="col-lg-12 row">



                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Route <span class="required">* </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlrot" runat="server" EmptyMessage="Select Route" CausesValidation="false" RenderMode="Lightweight" Width="100%" Filter="Contains"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlrot" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>


                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Target Package<span class="required">* </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlTarget" runat="server" EmptyMessage="Select Target Package" RenderMode="Lightweight" CausesValidation="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlTarget_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlTarget" ErrorMessage="Please Select Target Package" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                 <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12 ">Month </label>
                                    <div class="col-lg-12">
                                        <telerik:RadMonthYearPicker ID="radmonth" DateInput-DateFormat="yyyy-MM-dd" runat="server" MinDate="2022-01-01"   RenderMode="Lightweight"
                                            Width="100%" OnSelectedDateChanged="radmonth_SelectedDateChanged" AutoPostBack="true">
                                        </telerik:RadMonthYearPicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"  ErrorMessage="Month is mandatory" ForeColor="Red" ControlToValidate="radmonth">
                                    </asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                
                            
                      

                                  <div class="col-lg-3 form-group" >
                                <label class="control-label col-lg-12">Working Days</label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtworkdays" runat="server"  RenderMode="Lightweight" CausesValidation="false" Enabled="false" Width="100%"></telerik:RadNumericTextBox>
                                   
                                </div>
                            </div>

                                 <div class="col-lg-3 form-group" >
                                <label class="control-label col-lg-12">Quantity</label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtQuantity" runat="server" RenderMode="Lightweight" CausesValidation="false"  Width="100%"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtQuantity" ErrorMessage="Please Enter Quantity" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                                  <div class="col-lg-3 form-group" >
                                <label class="control-label col-lg-12">Amount</label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtAmount" runat="server"  RenderMode="Lightweight" CausesValidation="false"  Width="100%"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtAmount" ErrorMessage="Please Enter Amount" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>






                                 <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Status<span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStat" runat="server" Width="100%" RenderMode="Lightweight">
                                        <Items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlStat" ErrorMessage="Please select Status" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            </div>


                        </div>
                        <!-- package header-->
                        <asp:PlaceHolder ID="pnls" runat="server" Visible="false">
                            <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                <div class="kt-portlet__head-label">
                                    <h3 class="kt-portlet__head-title">Package Header
                                    </h3>
                                </div>

                            </div>
                            <div class="kt-portlet__body">
                                <%-- <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">--%>
                                <div class="col-lg-12 row">
                                    <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="RadGrid1" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="RadGrid1_NeedDataSource"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="tpd_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>



                                                <telerik:GridBoundColumn DataField="tph_Number" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Number" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="tph_Number">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="tph_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="tph_Name">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="tpd_Qty" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Quantity" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="tpd_Qty">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="tpd_Amount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="tpd_Amount">
                                                </telerik:GridBoundColumn>



                                            </Columns>
                                        </MasterTableView>
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                            <Resizing AllowColumnResize="true"></Resizing>
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                        </ClientSettings>
                                    </telerik:RadGrid>


                                </div>
                                <!--end::portlet-->




                            </div>
                        </asp:PlaceHolder>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <!--end Package header-->

                </div>
            </div>

            <div class="clearfix"></div>
            <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                            </h5>
                        </div>
                        <div class="modal-footer">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                            <button type="reset" data-dismiss="modal" class="btn btn-secondary">
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!--begin::SuccessModal-->
            <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Success</h5>
                        </div>
                        <div class="modal-body">
                            <span id="Success"></span>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
            <!--end::SuccessModal-->

            <!--begin::FailedModal-->
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
                            <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--end::FailedModal-->

              <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>This Month is Already Assigned for this Route..Try another one</span>
                </div>
                <div class="modal-footer">
                            <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                   
                </div>
            </div>
        </div>
    </div>
        </div>
    </div>
</asp:Content>
