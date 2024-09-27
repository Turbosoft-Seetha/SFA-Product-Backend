<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditProductUOM.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditProductUOM" %>
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
        function Confm() {
            $('#modalConfirm1').modal('show');
        }
        function Succces(cd) {
            $('#modalConfirm1').modal('hide');
            $('#kt_modal_1_8').modal('show');
            $('#Success1').text(cd);
        }
        function Fail() {
            $('#modalConfirm').modal('hide');
            $('#Failmsg').modal('show');

        }

        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function delConfim() {
            $('#modaldelConfirm').modal('show');

        }

        function successModal() {
            $('#modaldelConfirm').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }


     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="lnkCancel" runat="server"
            Text="Back" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" OnClick="lnkCancel_Click" />
        <asp:LinkButton ID="lnkSave" runat="server" ValidationGroup="form" OnClick="lnkSave_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Update'
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
      <telerik:RadAjaxPanel ID="RadAjaxpanel3" runat="server" LoadingPanelID="LoadingPanel1">

        <div class="card-body" style="background-color: white; padding: 20px;">
            <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <!--begin::Portlet-->
                        <div class="kt-portlet">
                            <!--product-->
                             <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                        
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                            <!--End product-->

                           
                                <!--Uom header-->
                                <div class="kt-portlet__head " style="padding-top: 20px; padding-bottom: 10px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">Edit UOM
                                        </h3>
                                    </div>



                                </div>
                                <!--End Uom header-->
                                <div class="kt-portlet__body">
                                    <div class="col-lg-12 row">

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">UOM <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlUom" runat="server" Width="100%" EmptyMessage="Select Uom" Enabled="false"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="ddlUom" ErrorMessage="Please choose Uom" Display="Dynamic" ForeColor="Red"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Standard Selling Price <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtStdPrice"  runat="server" CssClass="form-control" Width="100%">
                                                     <NumberFormat AllowRounding="true" DecimalDigits="3" />
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="txtStdPrice" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Standard Selling Price"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Return Price <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtrtnPrice"  runat="server" CssClass="form-control" Width="100%">
                                                     <NumberFormat AllowRounding="true" DecimalDigits="3" />
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="txtrtnPrice" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Return Price"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">UPC <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtupc" runat="server" CssClass="form-control" RenderMode="Lightweight" Width="100%" NumberFormat-AllowRounding="false" DecimalDigits="0" Enabled="false"></telerik:RadNumericTextBox>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ValidationGroup="frm"
                                                    ControlToValidate="txtupc" ErrorMessage="Please Enter UPC" ForeColor="Red"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>


                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Default<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlDefault" runat="server" Width="100%" DefaultMessage="please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddlDefault" ErrorMessage="Please select Default" ForeColor="Red" ValidationGroup="frm"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Disable UOM<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlsaleshold" runat="server" Width="100%" DefaultMessage="please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddlsaleshold" ErrorMessage="Please select Default" ForeColor="Red" ValidationGroup="frm"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                       
                                    </div>
                                </div>
                              
                              
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to update..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
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


    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm1" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnConfim" runat="server" Text="Yes" OnClick="BtnConfim_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm1);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="Success1"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="Okbtn" runat="server" OnClick="Okbtn_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
                    <span id="Success"></span>
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
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <%--delete--%>
   
   
    <!--begin::FailedModal-->
    <div class="modal fade" id="Failmsg" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>UOM Data not inserted.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(Failmsg);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
  
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
