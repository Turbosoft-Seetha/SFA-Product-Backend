<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditPromotionRange.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditPromotionRange" %>

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
        function Failure(b) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#fail').text(b);
        }
        function redirect() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("HId");
            window.location.href = "ListPromotionRange.aspx?Id=" + c;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

        <asp:LinkButton ID="lnkCancel" runat="server"
            Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" OnClick="lnkCancel_Click" />

        <asp:LinkButton ID="lnkSave" runat="server" ValidationGroup="form" OnClick="lnkSave_Click"
            UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <%--  <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Add Edit Promotion Range
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            </h3> 
                             
                        </div>
                        

                    </div>--%>
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                <div class="col-lg-12 row" style="padding-top: 9px;">

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Min Range</label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="txtMin" runat="server" CssClass="form-control" Width="100%"></telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="form"
                                                ControlToValidate="txtMin" ErrorMessage="Please Enter Min Value" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Max Range</label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="txtMax" runat="server" CssClass="form-control" Width="100%"></telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                                                ControlToValidate="txtMax" ErrorMessage="Please Enter Max Value" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            <asp:CompareValidator ID="dd" runat="server" ControlToValidate="txtMax" ControlToCompare="txtMin" ErrorMessage="Max Range must be greater"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer" ValidationGroup="form"></asp:CompareValidator>

                                        </div>

                                    </div>

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Offer Value</label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="txtValue" runat="server" CssClass="form-control" Width="100%"></telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                                ControlToValidate="txtValue" ErrorMessage="Please Enter Value" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                              <%--  </div>
                                <div class="col-lg-12 row" style="padding-top: 9px;">--%>

                                    <div class="col-lg-4 form-group" style="padding-top: 9px;">
                                        <label class="control-label col-lg-12">Repeat Type</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlrpttype" runat="server" Width="100%" OnSelectedIndexChanged="ddlrpttype_SelectedIndexChanged" AutoPostBack="true">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Same Min val & max val-A" Value="A" Selected="true" />
                                                    <telerik:DropDownListItem Text="Different Min val & Max val-B" Value="B" />
                                                    <telerik:DropDownListItem Text="No Repeatation" Value="C" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </div>
                                    </div>
                                    <asp:PlaceHolder ID="pnlIteration" runat="server">
                                    
                                        <div class="col-lg-4 form-group" style="padding-top: 9px;">
                                            <label class="control-label col-lg-12">Offer Value Increment</label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtofrvalInc" runat="server" CssClass="form-control" Width="100%" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                                    ControlToValidate="txtValue" ErrorMessage="Please Enter " ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>
                                        <div class="col-lg-4 form-group" style="padding-top: 9px;">
                                            <label class="control-label col-lg-12">Iteration Count</label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtitrcount" runat="server" CssClass="form-control" Width="100%" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                                    ControlToValidate="txtValue" ErrorMessage="Please Enter " ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>
                                   </asp:PlaceHolder>
                             <%--   </div>
                                <div class="col-lg-12 row" style="padding-top: 9px;">--%>
                                    <div class="col-lg-4 form-group" hidden="hidden">
                                        <label class="control-label col-lg-12">Limit Value</label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="txtLimit" runat="server" Value="0" CssClass="form-control" Width="100%"></telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ControlToValidate="txtLimit" ErrorMessage="Please Enter Limit Value" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group" hidden="hidden">
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
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="lnkAdd" runat="server" Text="Yes" OnClick="lnkAdd_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="fail">hai</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
