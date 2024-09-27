<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AddEditPromotionHeader.aspx.cs" Inherits="SalesForceAutomation.Admin.AddEditPromotionHeader" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
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
                            <h3 class="kt-portlet__head-title">Add Edit Promotion Header
                            </h3>


                            <%-- breadcrumbs starts --%>
                            <div class="kt-subheader__breadcrumbs" style="padding-left:20px;">
                                <a href="ListPromotionHeader.aspx" class="kt-subheader__breadcrumbs">
                                    <i class="flaticon2-shelter"></i> List Promotion Header </a>
                                <span class="kt-subheader__breadcrumbs-separator">></span>
                                <a class="kt-subheader__breadcrumbs-link">Add Edit Promotion Header </a>
                            </div>
                            <%-- breadcrumbs ends --%>
                        </div>
                        <div class="kt-portlet__head-actions">
                            <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:LinkButton ID="lnkSave" Width="100px" runat="server" ValidationGroup="form" OnClick="lnkSave_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Save'
                                    CssClass="btn btn-brand btn-elevate btn-icon-sm" CausesValidation="true" />
                                <asp:LinkButton ID="lnkCancel" Width="100px" runat="server"
                                    Text="Cancel" CssClass="btn btn-brand btn-elevate btn-icon-sm"
                                    CausesValidation="False" OnClick="lnkCancel_Click" />
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
                    <div class="kt-portlet__body">
                         <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                              
                        <div class="col-lg-12 row">

                            <asp:PlaceHolder runat="server" ID="Num">
                             <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">Number</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtNumber" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                </div>
                            </div>
                           </asp:PlaceHolder>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Name</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                        ControlToValidate="txtName" ErrorMessage="Please Enter Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Promotion Type</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Type" CausesValidation="false"
                                        OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="ddlType" ErrorMessage="Please Select Type" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Qualification</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlQualificaiton" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Qualificaiton"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="ddlQualificaiton" ErrorMessage="Please Select Qualificaiton" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                             
                            <asp:PlaceHolder runat="server" ID="asg">                            
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Assignment</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlAssignment" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Assignment"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="ddlAssignment" ErrorMessage="Please Select Assignment" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                            </asp:PlaceHolder>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Repeat Range</label>
                                <div class="col-lg-12">
                                    <%-- <telerik:RadNumericTextBox ID="txtRepeatRngs" runat="server" CssClass="form-control"  Width="100%"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                        ControlToValidate="txtRepeatRngs" ErrorMessage="Please Enter Repeat Range" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                    <telerik:RadDropDownList ID="ddlrange" runat="server" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="0" Value="0" Selected="true" />
                                            <telerik:DropDownListItem Text="1" Value="1" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Status</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Enabled" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Disabled" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                        </div>

                              </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
                        <asp:LinkButton ID="lnkAdd" runat="server" Text="Yes" OnClick="lnkAdd_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />
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
                    <span id="success"></span>
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
</asp:Content>
