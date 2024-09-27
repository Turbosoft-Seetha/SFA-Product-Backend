<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddGeneralCredit.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddGeneralCredit" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>

        function FailureAlert(res) {
            $('#FailureAlert').modal('show');
            $('#failres').text(res);
            x++;
        }
        function failModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal').modal('show');
        }

        function SaveAlert() {
            $('#SaveAlert').modal('show');
        }

        function SaveSuccess(res) {
            $('#SaveSuccess').modal('show');
            $('#clrIDs').text(res);
            $('#SaveAlert').modal('hide');
            x++;
        }
        function OnClientValidationFailed(sender, args) {
            var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);
            if (args.get_fileName().lastIndexOf('.') != -1) {//this checks if the extension is correct
                if (sender.get_allowedFileExtensions().indexOf(fileExtention) == -1) {
                    alert("File extension is wrong, Please choose mentioned file format !!");
                }
                else {
                    //alert(sender.get_allowedFileExtensions().indexOf(fileExtention));
                    alert("File too big to upload, Kindly choose the file with approriate size !!");
                }
            }
            else {
                alert("File extension is wrong, Please choose mentioned file format !!");
            }
        }

        function toProperCase(s) {
            return s.toLowerCase().replace(/^(.)|\s(.)/g,
                function ($1) { return $1.toUpperCase(); });
        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary" CausesValidation="False" OnClick="lnkCancel_Click" />
        <asp:LinkButton ID="lnkConfirm" runat="server" ValidationGroup="frm" OnClick="lnkConfirm_Click" UseSubmitBehavior="false" Text='Proceed' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        // https://www.telerik.com/support/kb/aspnet-ajax/upload-(async)/details/access-selected-file-in-the-arguments-of-onclientfileselected-event-of-asyncupload
        Telerik.Web.UI.RadAsyncUpload.prototype._onFileSelected = function (row, fileInput, fileName, shouldAddNewInput, file) {
            var args = {
                row: row,
                fileInputField: fileInput,
                file: file
            };
            args.rowIndex = $telerik.$(row).index();
            args.fileName = fileName;
            this._selectedFilesCount++;
            shouldAddNewInput = shouldAddNewInput &&
                (this.get_maxFileCount() == 0 || this._selectedFilesCount < this.get_maxFileCount());
            this._marshalUpload(row, fileName, shouldAddNewInput);
            var labels = $telerik.$("label", row);
            if (labels.length > 0)
                labels.remove();
            $telerik.$.raiseControlEvent(this, "fileSelected", args);
        }
    </script>
    <script>
        function OnClientFileUploadRemoved1(sender, args) {
            $telerik.$("#img1").attr('src', "../Media/noPreview.jpg");
        }

        function OnClientFileSelected1(sender, args) {

            var file = args.get_file();
            var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);

            if (file && fileExtention != 'pdf') {
                // https://stackoverflow.com/a/4459419
                var reader = new FileReader();
                reader.onload = function (e) {
                    $telerik.$("#img1").attr('src', e.target.result);

                }

                reader.readAsDataURL(file);
            } else {
                $telerik.$("#img1").attr('src', 'assets/media/icons/svg/Files/Folder-cloud.svg');
            }
        }

    </script>
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <div class="kt-portlet__body">

                            <div class="col-lg-12 row mt-3">
                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Customer <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlCustomer" EmptyMessage="Select Customer" Width="100%" runat="server" Filter="Contains"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCustomer" ErrorMessage="<br/> Please choose customer" ForeColor="Red" Display="Dynamic" ValidationGroup="frm"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Month<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadMonthYearPicker ID="rdMonth" runat="server" Width="100%"></telerik:RadMonthYearPicker>
                                        <asp:RequiredFieldValidator ID="as" runat="server" ControlToValidate="rdMonth" ErrorMessage="<br/> Please choose date" ForeColor="Red" Display="Dynamic" ValidationGroup="frm"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Amount<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtAmount" runat="server" NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator="" MinValue="0" Width="100%"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAmount" ErrorMessage="<br/> Please enter amount" ForeColor="Red" Display="Dynamic" ValidationGroup="frm"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Attachment <span class="required">* </span></label>
                                    <asp:HiddenField ID="txt1" runat="server" Value="" />
                                    <label style="color: #464646; font-size: smaller; margin-left: 11px;">Only .jpeg / jpg / pdf files are allowed with maximum size 6MB</label>
                                    <br />
                                    <div class="col-lg-12 row" style="margin-left: 5px;">
                                        <telerik:RadAsyncUpload runat="server" MaxFileInputsCount="1"
                                            ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG,.pdf" MultipleFileSelection="Disabled" MaxFileSize="6242880"
                                            UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                            OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1"
                                            Style="padding: 10px; text-align: center; padding-bottom: 10px;">
                                            <Localization Select="Browse" />
                                            <FileFilters>
                                                <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG,.pdf" />
                                            </FileFilters>
                                        </telerik:RadAsyncUpload>
                                        <div class="col-lg-12 mt-2">
                                            <asp:HiddenField ID="hlval1" runat="server" />
                                            <%--  <asp:HyperLink ID="hpl1" runat="server" Target="_blank">
                                                <asp:Image ID="img1" runat="server" Style="margin-top: 10px" ImageUrl="assets/media/icons/svg/Files/File-cloud.svg" Height="70px" />
                                            </asp:HyperLink>--%>
                                        </div>
                                        <%--<i class="fas fa-upload " style="color: black; height: 10px; padding-top: 15px; margin-left: 30px; margin-top: 1px"></i>--%>
                                        <%--</asp:LinkButton>--%>
                                    </div>

                                    <img src="../Media/noimage.png" id="img1" height="70" width="70" style="margin-top: 0px; margin-left: 30px;" alt="Preview image here" />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="FailureAlert" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Failure</h5>
                </div>
                <div class="modal-body">
                    <span style="color: red"><strong></strong>&nbsp;&nbsp; <span id="failres"></span></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Dismiss</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="SaveAlert" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure want to confirm?</h5>
                </div>
                <div class="modal-body">
                    <%--<telerik:RadTextBox ID="txtRemarks" EmptyMessage="Please enter remarks if any" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Width="100%"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRemarks" ErrorMessage="<br/> Remarks is mandatory" ForeColor="Red" Display="Dynamic" ValidationGroup="rm"></asp:RequiredFieldValidator>--%>
                    <small style="color: red">No Amendments once confirmed!!</small>
                </div>

                <telerik:RadAjaxPanel ID="pl" LoadingPanelID="RadAjaxLoadingPanel2" runat="server">

                    <div class="modal-footer">
                        <asp:LinkButton ID="btnSave" ValidationGroup="rm" CausesValidation="true" runat="server" OnClick="btnSave_Click" CssClass="btn btn-secondary">Yes</asp:LinkButton>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
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

    <div class="modal fade" id="SaveSuccess" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span><strong><span id="clrIDs"></span></strong>&nbsp; General Credit Note has been created for the selected month</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="BtnReqSuccess" runat="server" OnClick="btnReqSuccess_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>File missing..please upload file</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Ok</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
