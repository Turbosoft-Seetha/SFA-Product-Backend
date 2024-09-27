<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AddEditUser.aspx.cs" Inherits="SalesForceAutomation.Admin.AddEditUser" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

    <script type="text/javascript">
        function Confim(val) {

            $('#modalConfirm').modal('show');

        }
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <div class="kt-portlet__head" style="padding-top: 20px">

                            <span class="kt-subheader__separator kt-hidden"></span>
                            <div class="kt-subheader__breadcrumbs">


                                <a href="Users.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Users </a>
                                <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>--%>
                                <span class="kt-subheader__breadcrumbs-separator">></span>
                                <a class="kt-subheader__breadcrumbs-link">Add Edit User </a>

                                <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                            </div>
                        </div>
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Add Edit User
                            </h3>
                        </div>

                    </div>
                    <div class="kt-portlet__body">
                        <div class="col-lg-12 row">
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">UserName (Email ID) <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="txtEmail" ErrorMessage="Please Enter UserName" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ForeColor="Red" Display="Dynamic"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail"
                                        ErrorMessage="Please enter valid email address"></asp:RegularExpressionValidator>--%>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Employee Code <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <asp:TextBox ID="txtEmpCode" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                        ControlToValidate="txtEmpCode" ErrorMessage="Please Enter Employee Code" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">First Name <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="txtFirstName" ErrorMessage="Please Enter First Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ForeColor="Red" Display="Dynamic"
                                        ValidationExpression="^[a-zA-Z .]+$" ControlToValidate="txtFirstName" ErrorMessage="Only alphabets allowed."></asp:RegularExpressionValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Last Name</label>
                                <div class="col-lg-12">
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                ControlToValidate="txtLastName" ErrorMessage="Please Enter Last Name" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ForeColor="Red" Display="Dynamic"
                                                ValidationExpression="^[a-zA-Z]+$" ControlToValidate="txtLastName" ErrorMessage="Only alphabets allowed."></asp:RegularExpressionValidator>--%>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Contact No</label>
                                <div class="col-lg-12">
                                    <asp:TextBox ID="txtContactInfo" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ForeColor="Red" Display="Dynamic"
                                        ValidationExpression="^[\+\d]?(?:[\d-.\s()]*){10}" ControlToValidate="txtContactInfo" ErrorMessage="Only numeric allowed."></asp:RegularExpressionValidator>
                                </div>
                            </div>

                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Division </label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlDivision" EmptyMessage="Select Division/s" runat="server" RenderMode="Lightweight"
                                            Width="100%" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlDivision" ErrorMessage="Please Select Division" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-1 form-group">
                                <label class="control-label col-lg-12">Active</label>
                                <div class="col-lg-12">
                                    <asp:CheckBox ID="chkActive" runat="server" />
                                </div>
                            </div>
                        </div>
                        
                        <asp:UpdatePanel ID="pnlMaster" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <div class="col-lg-12 form-actions">
                                    <div class="col-lg-12 row">
                                        <div class="col-md-9">
                                            <asp:LinkButton ID="btnSave" Width="100px" runat="server" ValidationGroup="form" OnClientClick="return Confim('Are you sure want to Update..?');" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Save'
                                                CssClass="btn btn-brand btn-elevate btn-icon-sm" />
                                            <asp:LinkButton ID="btnCancel" runat="server"
                                                OnClick="btnCancel_Click" Width="100px" Text="Cancel" CssClass="btn btn-brand btn-elevate btn-icon-sm"
                                                CausesValidation="False" />

                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
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
                    <h5 class="modal-title" id="Confirm">Are You sure want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lnkAdds" runat="server" Text="Yes" OnClick="btnSave_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>

    <style type="text/css">
        .modal-center {
            position: absolute;
            top: 50% !important;
            transform: translate(0, -50%) !important;
            -ms-transform: translate(0, -50%) !important;
            -webkit-transform: translate(0, -50%) !important;
            margin: auto 5%;
        }
    </style>
    <a href="javascript:;" class="page-quick-sidebar-toggler">
        <i class="icon-login"></i>
    </a>
</asp:Content>
