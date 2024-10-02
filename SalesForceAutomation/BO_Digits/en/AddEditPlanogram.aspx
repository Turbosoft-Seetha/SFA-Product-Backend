<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditPlanogram.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditPlanogram" %>

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
        function failModal() {
            $('#kt_modal').modal('show');
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
                $telerik.$("#img1").attr('src', '../assets/media/svg/files/Folder-cloud.svg');
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
   <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                          
                               <a class="btn btn-sm fw-bold btn-secondary" href="ListTasks.aspx">Cancel
                               </a> &nbsp;
    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Proceed" OnClick="LinkButton2_Click" CausesValidation="true" ValidationGroup="form"></asp:LinkButton>
                           
                       </telerik:RadAjaxPanel>

                       <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                           BackColor="Transparent"
                           ForeColor="Blue">
                           <div class="col-lg-12 text-center">
                               <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                           </div>
                       </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
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
                $telerik.$("#img1").attr('src', '../assets/media/svg/files/Folder-cloud.svg');
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


    <%--<div class="card-body" style="background-color: white; padding: 20px;">
       <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
           <div class="row">
               <div class="col-lg-12">
                   <!--begin::Portlet-->
                   <div class="kt-portlet">
                       <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                           <div class="kt-portlet__body">
                               <div class="col-lg-12 row">
                                   <div class="col-lg-4 form-group">
                                       <label class="control-label col-lg-12">Code <span class="required"></span></label>
                                       <div class="col-lg-12">
                                           <telerik:RadTextBox ID="RadTextBox1" runat="server" CssClass="form-control" Width="100%" OnTextChanged="txtcode_TextChanged" AutoPostBack="true"></telerik:RadTextBox>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                               ControlToValidate="txtcode" ErrorMessage="Please Enter  Code" ForeColor="Red" Display="Dynamic"
                                               SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                           <asp:Label ID="Label1" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                       </div>
                                   </div>
                                   <div class="col-lg-4 form-group">
                                       <label class="control-label col-lg-12">Name <span class="required"></span></label>
                                       <div class="col-lg-12">
                                           <telerik:RadTextBox ID="RadTextBox2" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                               ControlToValidate="txtname" ErrorMessage="Please Enter  Name" ForeColor="Red" Display="Dynamic"
                                               SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                       </div>
                                   </div>
                                   <div class="col-lg-4 form-group">
                                       <label class="control-label col-lg-12">Route<span class="required"></span></label>
                                       <div class="col-lg-12">
                                           <telerik:RadComboBox ID="RadComboBox1" runat="server" DefaultMessage="Select Route" Width="100%" Filter="Contains"></telerik:RadComboBox>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                               ControlToValidate="ddlRout" ErrorMessage="Please choose Route" ForeColor="Red" Display="Dynamic"
                                               SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                       </div>
                                   </div>
                                   <div class="col-lg-4 form-group">
                                       <label class="control-label col-lg-12">Company<span class="required"></span></label>
                                       <div class="col-lg-12">
                                           <telerik:RadComboBox ID="RadComboBox2" runat="server" Width="100%" DefaultMessage="Select Company" Filter="Contains"></telerik:RadComboBox>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="form"
                                               ControlToValidate="ddlplgcomp" ErrorMessage="Please Choose Company" ForeColor="Red" Display="Dynamic"
                                               SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                       </div>
                                   </div>
                               </div>
                               <div class="col-lg-3 form-group" style="padding-bottom: 15px;">
                                   <label class="control-label col-lg-12">Image</label>
                                   <asp:HiddenField ID="HiddenField1" runat="server" Value="Overall claim picture" />
                                   <label style="color: #464646; font-size: smaller; margin-lef: 11px;">Only .jpeg / jpg files are allowed with maximum size 6MB</label>
                                   <br />
                                   <div class="col-lg-12 row" style="margin-lef: 5px;">


                                       <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                                           ID="RadAsyncUpload1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Disabled" MaxFileSize="6242880"
                                           UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                           OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1"
                                           Style="padding: 10px; text-align: center; padding-bottom: 10px;">
                                           <Localization Select="Browse Image" />
                                           <FileFilters>
                                               <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG" />
                                           </FileFilters>
                                       </telerik:RadAsyncUpload>




                                       <div class="col-lg-12 mt-2">
                                           <asp:HiddenField ID="HiddenField2" runat="server" />
                                           <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank">
                                               <asp:Image ID="Image1" runat="server" Style="margin-top: 10px" ImageUrl="../assets/media/svg/files/File-cloud.svg" Height="70px" />
                                           </asp:HyperLink>
                                       </div>
                                       <i class="fas fa-upload " style="color: black; height: 10px; padding-top: 15px; margin-left: 30px; margin-top: 1px"></i>
                                       </asp:LinkButton>
                                   </div>

                                   <img src="http://ctt.trains.com/sitefiles/images/no-preview-available.png" id="img1" height="100" width="100" style="margin-top: 10px" alt="Preview image here" />
                               </div>

                                <div class="col-lg-2">
    <label class="control-label col-lg-12">Customer</label>
    <div class="col-lg-12">
        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" Width="100%"
            ID="rdCustomer" runat="server" EmptyMessage="Select Customer" OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" AutoPostBack="true">
        </telerik:RadComboBox>

    </div>
</div>             
                           </div>
                       </telerik:RadAjaxPanel>
                   </div>

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
   </div>--%>


    <div class="card-body" style="background-color: white; padding: 20px;">
    <div class="kt-container kt-container--fluid kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <div class="kt-portlet__body">
                            <!-- Remove col-lg-12 row to avoid nested row conflicts -->
                            <div class="row">
                                <!-- First column -->
                                <div class="col-lg-4 form-group">
                                    <label class="control-label">Code <span class="required"></span></label>
                                    <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%" OnTextChanged="txtcode_TextChanged" AutoPostBack="true"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtcode" ErrorMessage="Please Enter  Code" ForeColor="Red" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                </div>
                                
                                <!-- Second column -->
                                <div class="col-lg-4 form-group">
                                    <label class="control-label">Name <span class="required"></span></label>
                                    <telerik:RadTextBox ID="txtname" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtname" ErrorMessage="Please Enter  Name" ForeColor="Red" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>

                                <!-- Third column -->
                                <div class="col-lg-4 form-group">
                                    <label class="control-label">Route<span class="required"></span></label>
                                    <telerik:RadComboBox ID="ddlRout" runat="server" DefaultMessage="Select Route" Width="100%" Filter="Contains" EmptyMessage="Select Route"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form" ControlToValidate="ddlRout" ErrorMessage="Please choose Route" ForeColor="Red" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>

                                <!-- Fourth column -->
                                <div class="col-lg-4 form-group pt-4" >
                                    <label class="control-label">Company<span class="required"></span></label>
                                    <telerik:RadComboBox ID="ddlplgcomp" runat="server" Width="100%" DefaultMessage="Select Company" Filter="Contains" EmptyMessage="Select Company"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form" ControlToValidate="ddlplgcomp" ErrorMessage="Please Choose Company" ForeColor="Red" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>

                                <!-- Fifth column: Image Upload -->
                                <div class="col-lg-4 form-group pt-4">
                                    <label class="control-label col-lg-12">Image<span class="required"> </span></label>
                                    <asp:HiddenField ID="txt1" runat="server" Value="Overall claim picture" />
                                    <label style="color: #464646; font-size: smaller; margin-left: 11px;">Only .jpeg / jpg files are allowed with maximum size 6MB</label>
                                    <br />
                                    <div class="col-lg-12 row" style="margin-left: 5px;">
                                        <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                                            ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Disabled" MaxFileSize="6242880"
                                            UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                            OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1"
                                            Style="padding: 10px; text-align: center; padding-bottom: 10px;">
                                            <Localization Select="Browse Image" />
                                            <FileFilters>
                                                <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG" />
                                            </FileFilters>
                                        </telerik:RadAsyncUpload>
                                        <div class="col-lg-12 mt-2">
                                            <asp:HiddenField ID="hlval1" runat="server" />
                                            <asp:HyperLink ID="hpl1" runat="server" Target="_blank">
                                                <asp:Image ID="img1" runat="server" Style="margin-top: 10px" ImageUrl="../assets/media/icons/File-cloud.svg" Height="70px" />
                                            </asp:HyperLink>
                                        </div>
                                        <%--<i class="fas fa-upload " style="color: black; height: 10px; padding-top: 15px; margin-left: 30px; margin-top: 1px"></i>--%>
                                        <%--</asp:LinkButton>--%>
                                    </div>

                                    <%--<img src="http://ctt.trains.com/sitefiles/images/no-preview-available.png" id="img1" height="100" width="100" style="margin-top: 10px" alt="Preview image here" />--%>
       </div>
                            </div>
                        </div>
                    </telerik:RadAjaxPanel>
                </div>

                <!-- Loading panel -->
                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false" BackColor="Transparent" ForeColor="Blue">
                    <div class="text-center mt-5">
                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                    </div>
                </telerik:RadAjaxLoadingPanel>
            </div>
        </div>
    </div>
</div>





    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="heigh: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
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
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="heigh: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="heigh: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

     <div class="modal fade" id="kt_modal" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Oops..!</h5>
            </div>
            <div class="modal-body">
                <span>File missing..please upload file</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal);">Ok</button>
            </div>
        </div>
    </div>
</div>
   
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
