<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditNewRequest.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditNewRequest" %>

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
                  $telerik.$("#img1").attr('src', '../assets/media/icons/File-cloud.svg');
              }
          }
      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
      <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                               
                                <asp:LinkButton ID="lnkCancel" runat="server"
                                    Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
                                    CausesValidation="False" OnClick="lnkCancel_Click" />
          <asp:LinkButton ID="lnkSave" runat="server" ValidationGroup="form" OnClick="lnkSave_Click" UseSubmitBehavior="false" Text="Proceed"
                                    CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
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
                   $telerik.$("#img1").attr('src', '../assets/media/icons/File-cloud.svg');
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

      <div class="card-body row p-8" style="background-color:white;">
                        <div class="col-lg-12 row">

                          

                            <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Code<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%" Enabled="false" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ValidationGroup="form" 
                                        ControlToValidate="txtcode" ErrorMessage="Please Enter Code" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                        
                            
                            <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Response Type<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlResponse" runat="server" Width="100%" >
                                        <Items>
                                            <telerik:DropDownListItem Text="Accepted" Value="Accepted" Selected="true" />
                                            <telerik:DropDownListItem Text="Rejected" Value="Rejected" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                               <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Remarks<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtremarks" runat="server" CssClass="form-control" Width="100%" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ValidationGroup="form" 
                                        ControlToValidate="txtremarks" ErrorMessage="Please Enter Remarks" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                                  <div class="col-lg-4">
                                    <label class="control-label col-lg-12">Response Image<span class="required"> </span></label>
                                    <asp:HiddenField ID="txt1" runat="server" Value="Overall claim picture" />
                                    <label style="color: #464646; font-size: smaller; margin-left:11px;">Only .jpeg / jpg files are allowed with maximum size 6MB</label>
                                    <br />
                                    <div class="col-lg-12 row" style="margin-left:5px;">
                                        <telerik:RadAsyncUpload  runat="server" MaxFileInputsCount="5"
                                            ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Automatic" MaxFileSize="6242880"
                                            UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                            OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1" 
                                            Style="padding: 10px; text-align: center; padding-bottom: 5px;" >
                                            <Localization Select="Browse Image" />
                                            <FileFilters>
                                                <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG" />
                                            </FileFilters>
                                        </telerik:RadAsyncUpload>
                                       
                                       <%-- <div class="col-lg-12 mt-2">
                                            <asp:HiddenField ID="hlval1" runat="server" />
                                            <asp:HyperLink ID="hpl1" runat="server" Target="_blank">
                                                <asp:Image ID="img1" runat="server" Style="margin-top: 10px" ImageUrl="../assets/media/icons/File-cloud.svg" Height="70px" />
                                            </asp:HyperLink>
                                        </div>--%>
                                       
                                        <%--<i class="fas fa-upload " style="color: black; height: 10px; padding-top: 15px; margin-left: 30px; margin-top: 1px"></i>--%>
                                        <%--</asp:LinkButton>--%>
                                        <div class="col-lg-12">
                                         <asp:Literal ID="ltr" runat="server"></asp:Literal>
                                           
                                            </div>
                                    </div>

                                    <%--<img src="http://ctt.trains.com/sitefiles/images/no-preview-available.png" id="img1" height="100" width="100" style="margin-top: 10px" alt="Preview image here" />--%>
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
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
