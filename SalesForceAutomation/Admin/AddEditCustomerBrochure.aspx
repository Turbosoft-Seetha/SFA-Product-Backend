<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AddEditCustomerBrochure.aspx.cs" Inherits="SalesForceAutomation.Admin.AddEditCustomerBrochure" %>
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
          function failModal() {
              $('#kt_modal_1_3').modal('hide');
              $('#kt_modal').modal('show');
          }
      </script>
    <script>
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <script>
         function OnClientFileUploadRemoved1(sender, args) {
             $telerik.$("#img1").attr('src', "http://ctt.trains.com/sitefiles/images/no-preview-available.png");
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
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid" style="padding-top: 40px;">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <div class="kt-portlet__head" style="padding-top: 20px">

                        <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs">


                            <a href="ListCustomerBrochure.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Customer Brochure </a>
                            <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>--%>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link"> Add Edit Customer Brochure </a>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                    </div>
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Add Edit Customer Brochure
                            </h3>
                        </div>
                        <div class="kt-portlet__head-actions">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:LinkButton ID="lnkSaves" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" Text="Save" OnClick="lnkSaves_Click" CausesValidation="true" ValidationGroup="form"></asp:LinkButton>
                                &nbsp;
                                    <a class="btn btn-brand btn-elevate btn-icon-sm" href="ListCustomerBrochure.aspx">Cancel
                                    </a>
                            </telerik:RadAjaxPanel>

                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center">
                                    <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                        </div>
                    </div>
                    <!--begin::Forkt-->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <div class="kt-portlet__body">

                            <div class="col-lg-12 row">
                                <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Route<span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlRoute" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Route" AutoPostBack="true" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlRoute" ErrorMessage="Please Select Route" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                                <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                    <label class="control-label col-lg-12">Customer Name <span class="required">* </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlCustomers" EmptyMessage="Select Customer/s" runat="server"
                                            Width="100%" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlCustomers" ErrorMessage="Please Select Customers" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                    <label class="control-label col-lg-12">Name <span class="required">* </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtName" ErrorMessage="Please Enter Name" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                    <label class="control-label col-lg-12">From Date <span class="required">* </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="txtFrom" runat="server" Width="100%">
                                            <DateInput DateFormat="dd/MM/yyyy" runat="server" DisplayDateFormat="dd/MM/yyyy" />
                                        </telerik:RadDatePicker>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtFrom" ErrorMessage="Please Select From Date" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                    <label class="control-label col-lg-12">To Date <span class="required">* </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="txtToDate" runat="server" Width="100%">
                                            <DateInput DateFormat="dd/MM/yyyy" runat="server" DisplayDateFormat="dd/MM/yyyy" />
                                        </telerik:RadDatePicker>
                                         <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="txtFrom" ControlToValidate="txtToDate" Operator="GreaterThanEqual"
                                                ErrorMessage="To date must be greater" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtToDate" ErrorMessage="Please Select To Date" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                    <label class="control-label col-lg-12">PDF <span class="required">* </span></label>
                                    <asp:HiddenField ID="txt1" runat="server" Value="Overall claim picture" />
                                    <label style="color: #464646; font-size: smaller; margin-left: 11px;">Only .pdf files are allowed with maximum size 6MB</label>
                                    <br />
                                    <div class="col-lg-12 row" style="margin-left: 5px;">
                                        <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                                            ID="upd1" AllowedFileExtensions=".pdf" MultipleFileSelection="Disabled" MaxFileSize="6242880"
                                            UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                            OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1"
                                            Style="padding: 10px; text-align: center; padding-bottom: 10px;">
                                            <Localization Select="Browse File" />
                                            <FileFilters>
                                                <telerik:FileFilter Description="" Extensions=".pdf" />
                                            </FileFilters>
                                        </telerik:RadAsyncUpload>
                                        <div class="col-lg-12 mt-2">
                                            <asp:HiddenField ID="hlval1" runat="server" />
                                            <asp:HyperLink ID="hpl1" runat="server" Target="_blank">
                                                <asp:Image ID="img1" runat="server" Style="margin-top: 10px" ImageUrl="assets/media/icons/svg/Files/File-cloud.svg" Height="70px" />
                                            </asp:HyperLink>
                                        </div>
                                        <%--<i class="fas fa-upload " style="color: black; height: 10px; padding-top: 15px; margin-left: 30px; margin-top: 1px"></i>--%>
                                        <%--</asp:LinkButton>--%>
                                    </div>

                                    <%--<img src="http://ctt.trains.com/sitefiles/images/no-preview-available.png" id="img1" height="100" width="100" style="margin-top: 10px" alt="Preview image here" />--%>
                                </div>

                            </div>

                            <!--end::Form-->
                        </div>
                        <!--end::Portlet-->
                    </telerik:RadAjaxPanel>

                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to save ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" OnClick="lnkSave_Click">
                                                    Save
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
                    <span>Customer brochure has been inserted successfully.</span>
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
