<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddServiceRequest.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddServiceRequest" %>

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

        function NoProducts(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_20').modal('show');
            $('#failed').text(a);
        }
        function Failure(b) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#failure').text(b);
        }
        function RequiredModal() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_0').modal('show');
        }
        function Fail(msg) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('show');
            $('#failmsg').text(msg);
        }
        function failedModal() {

            $('#kt_modal_1_9').modal('show');

        }
        function CompareModel() {

            $('#kt_modal_1_10').modal('show');

        }
        function CompareModel1() {

            $('#kt_modal_1_11').modal('show');

        }
        function UOMValidation1() {

            $('#uomvalidation1').modal('show');

        }
        function UOMValidation2() {

            $('#uomvalidation2').modal('show');

        }
        function UOMValidation3() {

            $('#uomvalidation3').modal('show');

        }
        function CompareModel2() {

            $('#kt_modal_1_12').modal('show');

        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="lnkCancel" Width="100px" runat="server"
            Text="Cancel"
            CausesValidation="False" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="lnkCancel_Click" />


        <asp:LinkButton ID="lnkSave" Width="100px" runat="server" ValidationGroup="frm" OnClick="lnkSave_Click" UseSubmitBehavior="false"
            Text='<i class="icon-ok"></i>Proceed' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
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
            var fileInput = args.get_fileInputField(); // Get the file input field
            var file = fileInput.files[0]; // Get the first file from the input field

            if (file) {
                var fileExtension = file.name.substring(file.name.lastIndexOf('.') + 1);

                if (fileExtension !== 'pdf') {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $telerik.$("#img1").attr('src', e.target.result);
                    };

                    reader.readAsDataURL(file);
                } else {
                    $telerik.$("#img1").attr('src', '../assets/media/svg/files/Folder-cloud.svg');
                }
            } else {
                $telerik.$("#img1").attr('src', '../assets/media/svg/files/Folder-cloud.svg');
            }
        }

    </script>

    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <br />
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        
                        <div class="kt-portlet__body" style="color:#727173;">
                            <telerik:RadAjaxPanel ID="cdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

                                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 form-group d-flex">
                                        <label class="control-label col-lg-2 mb-2 ps-8 fs-5"><b>Select an option :</b></label>
                                        <div class="col-lg-6 pt-1 pb-8">

                                            <asp:RadioButtonList ID="rbActions" runat="server" RepeatDirection="Horizontal" CssClass="radioList" OnSelectedIndexChanged="rbActions_SelectedIndexChanged" AutoPostBack="true">

                                                <asp:ListItem ID="rdcustomer" Text="Customer" Value="cus" style="padding-right: 15px; gap:1px;" Selected="True" />
                                                <asp:ListItem ID="rdAssettype" Text="Asset Type" Value="ast" style="padding-right: 15px;" />
                                                <asp:ListItem ID="rdSerialNo" Text="Asset Serial Number" Value="serial" style="padding-right: 15px;" />

                                            </asp:RadioButtonList>

                                        </div>
                                    </div>

                                </div>

                                 <div  class="col-lg-12 row pe-8">

                                <div  class="col-lg-12 row ms-8 pt-8" style="background-color:beige; border-radius:15px;">

                                <asp:PlaceHolder ID="pnlcus" runat="server" Visible="true">
                                    <div class="col-lg-12 row pb-4 ps-4 pt-8">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Enter Customer Code or Name to Populate Customer </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="SearchTextBox" runat="server" RenderMode="Lightweight" CssClass="form-control" OnTextChanged="SearchTextBox_TextChanged" AutoPostBack="true" Width="100%" Enabled="true"></telerik:RadTextBox>

                                            </div>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>

                                <asp:PlaceHolder ID="pnlAsset" runat="server" Visible="false">
                                    <div class="col-lg-12 row pb-4 pt-8">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Choose Any Asset Type </label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlAstType" runat="server" Width="100%" EmptyMessage="Select Asset Type" Filter="Contains" AutoPostBack="true" OnSelectedIndexChanged="ddlAstType_SelectedIndexChanged"
                                                    CausesValidation="false" RenderMode="Lightweight">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>

                                <asp:PlaceHolder ID="pnlSerailNo" runat="server" Visible="false">
                                    <div class="col-lg-12 row pb-4 pt-4">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Enter Asset Serial Number or Name to Populate Assets </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtAssetSearch" runat="server"  RenderMode="Lightweight" CssClass="form-control" OnTextChanged="txtAssetSearch_TextChanged" AutoPostBack="true" Width="100%" Enabled="true"></telerik:RadTextBox>

                                            </div>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>

                              <%--  <hr>--%>

                               
                                <div class="col-lg-4 fs-4"><b>Customer Info </b>

                                <div class="col-lg-12" style="padding-top: 10px;">

                                    <div class="col-lg-12 form-group">
                                        <label class="control-label col-lg-12">Customer <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlCus" runat="server"  RenderMode="Lightweight" Width="100%" EmptyMessage="Select Customer" Filter="Contains" AutoPostBack="true" OnSelectedIndexChanged="ddlCus_SelectedIndexChanged"
                                                CausesValidation="false">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="frm" runat="server"
                                                ControlToValidate="ddlCus" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                </div>
                                
                                </div>
                                <br />

                                <div class="col-lg-8 row pb-8 fs-4"><b>Asset Info </b>

                                <div class="col-lg-12 row" style="padding-top: 10px;">

                                    <div class="col-6">

                                        <div class="col-lg-12 form-group">
                                            <label class="control-label col-lg-12">Assets<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlAstSlNo" runat="server" RenderMode="Lightweight" Width="100%" EmptyMessage="Select Asset" Filter="Contains"
                                                    CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlAstSlNo_SelectedIndexChanged">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="frm" runat="server"
                                                    ControlToValidate="ddlAstSlNo" ErrorMessage="Please Select Asset" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>
                                        <asp:PlaceHolder ID="pnlassetType" runat="server" Visible="false">
                                            <div class="col-lg-12 form-group" style="padding-top: 10px;">
                                                <label class="control-label col-lg-12">Asset Type</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtAssetType" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%" Filter="Contains"
                                                        CausesValidation="false">
                                                    </telerik:RadTextBox>

                                                </div>
                                            </div>
                                        </asp:PlaceHolder>

                                    </div>
                                    <div class="col-2">
                                        <div class="col-lg-12 form-group" style="align-items: end;">
                                            <label class="control-label col-lg-12">Planogram</label>
                                            <div class="col-lg-12">
                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl="../assets/media/svg/files/File-cloud.svg" Height="70px" Width="70px" />
                                                </asp:HyperLink>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <asp:PlaceHolder ID="pnlAssetHistory" runat="server" Visible="false">
                                        <div class="col-lg-12 form-group" style="align-items: end;padding-top: 30px;">
                                            <asp:LinkButton ID="lnkServiceDetail" Width="150px" runat="server" OnClick="lnkServiceDetail_Click" 
                                                Text='Service History' CssClass="btn btn-sm fw-bold btn-primary" />
                                        </div>
                                        </asp:PlaceHolder>
                                    </div>

                                </div>
                                
                                </div>

                                 </div>
                               <%-- <hr />--%>
                                <br />

                                <div  class="col-lg-12 row ms-8 mt-2 pt-8 ps-6" style="background-color:lavender; border-radius:15px;">
                                <div class="col-lg-12 row fs-4 pb-6"><b>Complaint Info </b>


                                <div class="col-lg-12 row" style="padding-top: 10px;">

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Complaint Type<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlcmpType" runat="server" RenderMode="Lightweight" Width="100%" EmptyMessage="Select Complaint Type" Filter="Contains"
                                                CausesValidation="false">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="frm" runat="server"
                                                ControlToValidate="ddlcmpType" ErrorMessage="Please Select Complaint Type" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Complaint Title<span class="required"> </span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtCmpTitle" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%" Filter="Contains"
                                                CausesValidation="false">
                                            </telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="frm" runat="server"
                                                ControlToValidate="txtCmpTitle" ErrorMessage="Please Enter Complaint Title" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                </div>
                                
                                </div>
                                <br />

                                <div class="col-lg-12 row fs-4 pb-6"><b>Preferred Date & Time </b>

                                <div class="col-lg-12 row" style="padding-top: 10px;">

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Schedule To<span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker ID="SCHdate" Width="100%" RenderMode="Lightweight" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="frm" ErrorMessage="Date is mandatory" ForeColor="Red" ControlToValidate="SCHdate"></asp:RequiredFieldValidator>
                                            <br />

                                        </div>
                                    </div>
                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Preferred Time<span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadTimePicker ID="radTimePicker" Width="100%" RenderMode="Lightweight" SelectedTime="00:00:00" TimeView-Interval="30" runat="server">
                                            </telerik:RadTimePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="frm" ErrorMessage="Time is mandatory" ForeColor="Red" ControlToValidate="radTimePicker"></asp:RequiredFieldValidator>
                                            <br />

                                        </div>
                                    </div>
                                    
                                </div>
                                
                                </div>
                                <br />

                                <div class="col-lg-12 row fs-4 pb-6"><b>Attachment & Remarks </b>

                                <div class="col-lg-12 row" style="padding-top: 10px;">

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Remarks</label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="100%" RenderMode="Lightweight" CssClass="form-control" Filter="Contains"
                                                CausesValidation="false">
                                            </telerik:RadTextBox>

                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <label class="control-label col-lg-12">Supporting Attachment</label>
                                        <asp:HiddenField ID="txt1" runat="server" Value="Overall claim picture" />
                                        <label style="color: #464646; font-size: smaller; margin-left: 11px;">Only .jpeg / jpg files are allowed with maximum size 6MB</label>
                                        <br />
                                        <div class="col-lg-12 row" style="margin-left: 5px;">
                                            <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="10"
                                                ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Automatic" MaxFileSize="6242880"
                                                UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                                OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1"
                                                Style="padding: 10px; text-align: center; padding-bottom: 5px;">
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
                                </div>
                                </div>
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" CssClass="btn btn-sm fw-bold btn-primary" OnClick="save_Click" />
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
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
    <div class="modal fade" id="kt_modal_1_20" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops...</h5>
                </div>
                <div class="modal-body">
                    <span id="failed"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_20);">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failure"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="kt_modal_1_0" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ooops..!</h5>
                </div>
                <div class="modal-body">
                    <p>You must enter Quantity for all checked items.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_0);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-body">
                    <span>Invoice Is Already Exist !!!</span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_10" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ooops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Entered requested return higher qty is greater than the eligible higher qty. Kindly enter equal or lesser value ..</span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_10);">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_11" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ooops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Entered requested return lower qty is greater than the eligible lower qty. Kindly enter equal or lesser value ..</span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_11);">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_12" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ooops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Entered requested return  qty is greater than the eligible  qty. Kindly enter equal or lesser value ..</span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_12);">OK</button>
                </div>
            </div>
        </div>
    </div>

    <%--uomvalidation1--%>
    <div class="modal fade" id="uomvalidation1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ooops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Please add atleast one uom for each item</span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation1);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <%--uomvalidation2--%>
    <div class="modal fade" id="uomvalidation2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Please add quanity for the uom</span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation2);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <%--uomvalidation3--%>
    <div class="modal fade" id="uomvalidation3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ooops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Please add any quantity</span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation3);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="kt_modal_1_2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failmsg"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel9" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                        <button class="btn btn-secondary" onclick="cancelModal(kt_modal_1_2);">Ok</button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
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

    <style>
        .RadUpload_Silk .ruButton {
            padding-bottom: 0px !important;
            color: black !important;
            width: 122px !important;
            margin-left: 0px !important;
            padding-top: 0px;
            display: flex;
        }
    </style>
    <style>
        .RadUpload_Silk .ruButton.ruRemove {
            order: -1;
            padding-bottom: 0px !important;
            color: black !important;
            width: 122px !important;
            margin-left: 0px !important;
            padding-top: 0px !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>

