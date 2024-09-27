<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AddEditCustomerTask.aspx.cs" Inherits="SalesForceAutomation.Admin.AddEditCustomerTask" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
      <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal(a) {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);

        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function failModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal').modal('show');
        }
        
        function existModal() {
            $('#kt_modal_1_6').modal('show');
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
   

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>

  <%--  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="LoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
        </div>

    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxPanel ID="RadAjaxpanel3" runat="server" LoadingPanelID="LoadingPanel1">--%>
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid" >
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                  

                       <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Add Customer Task
                                <telerik:RadLabel runat="server" ID="labelqno" Text=""></telerik:RadLabel>
                            </h3>
                             <%-- breadcrumbs --%>
                        <div class="kt-subheader__breadcrumbs" style="padding-left:20px;">
                            <a href="ListCustomerTasks.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Customer Task </a>
                            <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>--%>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Add Customer Task </a>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                        <%-- breadcrumbs --%>
                        </div>
                         <div class="kt-portlet__head-actions">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" Text="Save" OnClick="lnkSave_Click" CausesValidation="true" ValidationGroup="form"></asp:LinkButton>
                                &nbsp;
                                    <a class="btn btn-brand btn-elevate btn-icon-sm" href="ListCustomerTasks.aspx">Cancel
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
                     <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                       
                    <div class="kt-portlet__body">
                            
                        <div class="col-lg-12 row">

                           
                             <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Route <span class="required">* </span></label>
                                <div class="col-lg-12">
                                     <telerik:RadComboBox ID="ddlroute" runat="server" Filter="Contains" Width="100%" EmptyMessage="Select Route" RenderMode="Lightweight" OnSelectedIndexChanged="ddlroute_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlroute" ErrorMessage="Please choose Route" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                             <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Customer <span class="required">* </span></label>
                                <div class="col-lg-12">
                                     <telerik:RadComboBox ID="ddlCus" runat="server" Filter="Contains" Width="100%" EmptyMessage="Select Customer" RenderMode="Lightweight" OnSelectedIndexChanged="ddlCus_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlCus" ErrorMessage="Please choose Customer" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                             <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Task Name <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtCTName" runat="server" CssClass="form-control"  Width="100%"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtCTName" ErrorMessage="Please Enter Task" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                             <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Brand <span class="required">* </span></label>
                                <div class="col-lg-12">
                                     <telerik:RadComboBox ID="ddlBrd" runat="server" Filter="Contains" Width="100%" EmptyMessage="Select Brand" RenderMode="Lightweight" OnSelectedIndexChanged="ddlBrd_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlCus" ErrorMessage="Please choose Brand" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                             <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Description <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" Width="100%"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtDesc" ErrorMessage="Please Enter Description" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                             <div class="col-lg-4 form-group" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">Due Date </label>
                                    </div>
                                    <div class="col-lg-12">
                                     
                                        <telerik:RadDatePicker ID="duedate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" ></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                            ControlToValidate="duedate" ErrorMessage="Please select due date" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                           

                         <div class="col-lg-4">
                                    <label class="control-label col-lg-12">Reference Image<span class="required">* </span></label>
                                    <asp:HiddenField ID="txt1" runat="server" Value="Overall claim picture" />
                                    <label style="color: #464646; font-size: smaller; margin-left:11px;">Only .jpeg / jpg files are allowed with maximum size 6MB</label>
                                    <br />
                                    <div class="col-lg-12 row" style="margin-left:5px;">
                                        <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                                            ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Disabled" MaxFileSize="6242880"
                                            UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                            OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1" 
                                            Style="padding: 10px; text-align: center; padding-bottom: 10px;" >
                                            <Localization Select="Browse Image" />
                                            <FileFilters>
                                                <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG" />
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
                           </telerik:RadAjaxPanel>
                          <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
        </div>

    </telerik:RadAjaxLoadingPanel>
                    <!--end::Portlet-->

                </div>
            </div>
        </div>
    </div>
   <%-- </telerik:RadAjaxPanel>--%>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to save ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" OnClick="LinkButton1_Click">
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
                    <span id="success"></span>
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


    <!--begin::ExistModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Category code already exist. Please try again with new code.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ExistModal-->

    <style>
        .RadUpload_Silk .ruButton {
            padding-bottom: 0px !important;
            color: black !important;
            width: 122px !important;
            background: transparent !important;
            background-color: transparent !important;
            margin-left: 0px !important;
            padding-top:0px;
        }


        .RadUpload .ruFileWrap.ruStyled {
            display: grid;
            width: 126px !important;
        }

      
        /*.RadUpload .ruUploadProgress {
            display: contents;
        }
        .RadUpload .radIcon {
            visibility: hidden;
        }*/

        /*div.RadUpload .ruRemove
            {
            
                background-image: url('assets/media/icons/svg/Files/Deleted-file.svg') !important;
                background-position: -2px 0px;
                width: 50px;
                height: 14px;
            }*/

        #preview-image {
            max-height: 300px;
            max-width: 300px;
        }
    </style>

</asp:Content>
