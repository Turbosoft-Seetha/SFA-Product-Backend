<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="ExcelUpload.aspx.cs" Inherits="SalesForceAutomation.Admin.ExcelUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
      <script>
        function successModal() {
            $('#kt_modal_1_9').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#kt_modal_1_5').modal('hide');
        }

        function DraftModal() {
            $('#kt_modal_1_10').modal('hide');
            $('#kt_modal_1_4a').modal('show');
        }

        function OpenInsert() {
            $('#kt_modal_1_9').modal('show');
        }


        function openDraft() {
            $('#kt_modal_1_10').modal('show');
        }

        function failedModal() {
            $('#kt_modal_1_9').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('show');

        }

        function ErrorModal(res) {
            $('#spnMsg').text(res);
            $('#kt_modal_1_9').modal('hide');
            $('#kt_modal_1_6').modal('show');
        }

        function WizValidate() {
            wizardEl = KTUtil.get('kt_wizard_v3');
            formEl = $('#kt_form');
            wizardEl.steps();
            //var mySteps = $('#kt_wizard_v3').steps();
            //steps_api = steps.data('plugin_Steps');
            //steps_api.next();

        }



      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdExcUnMatch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdExcUnMatch" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="rdImpExc" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="rdMatchingImages"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RdNonMatchImages"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="successlabel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="successlabel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="failurelabel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="failureLabel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lnkDraft"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lnkSave"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkValidate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdExcUnMatch" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="rdImpExc" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="rdMatchingImages"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RdNonMatchImages"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="successlabel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="successlabel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="failurelabel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="failureLabel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lnkDraft"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lnkSave"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkDrafts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lnkDraft"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="tmrFinal">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblTimerSuc"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
                        <telerik:AjaxSetting AjaxControlID="btnSav">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lnkExit"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server">
    </telerik:RadAjaxLoadingPanel>

     <telerik:RadSkinManager ID="ff" runat="server" Skin="Silk"></telerik:RadSkinManager>
    <div class="kt-content  kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor" id="kt_content">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="kt-portlet">
                <div class="kt-portlet__body kt-portlet__body--fit">
                    <div class="kt-grid kt-wizard-v3 kt-wizard-v3--white" id="kt_wizard_v3" data-ktwizard-state="step-first">
                        <div class="kt-grid__item col-lg-10">

                            <!--begin: Form Wizard Nav -->
                            <div class="kt-wizard-v3__nav">
                                <div class="kt-wizard-v3__nav-items">

                                    <!--doc: Replace A tag with SPAN tag to disable the step link click -->
                                    <div class="kt-wizard-v3__nav-item" data-ktwizard-type="step" data-ktwizard-state="current">
                                        <div class="kt-wizard-v3__nav-body">
                                            <div class="kt-wizard-v3__nav-label">
                                                <span>1</span> Upload File
														
                                            </div>
                                            <div class="kt-wizard-v3__nav-bar"></div>
                                        </div>

                                    </div>
                                    <div class="kt-wizard-v3__nav-item" data-ktwizard-type="step">
                                        <div class="kt-wizard-v3__nav-body">
                                            <div class="kt-wizard-v3__nav-label">
                                                <span>2</span> View Data
														
                                            </div>
                                            <div class="kt-wizard-v3__nav-bar"></div>
                                        </div>
                                    </div>
                                    <div class="kt-wizard-v3__nav-item" data-ktwizard-type="step">
                                        <div class="kt-wizard-v3__nav-body">
                                            <div class="kt-wizard-v3__nav-label">
                                                <span>3</span> Submit
														
                                            </div>
                                            <div class="kt-wizard-v3__nav-bar"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--end: Form Wizard Nav -->
                        </div>
                        <div class="kt-grid__item kt-grid__item--fluid kt-wizard-v3__wrapper">


                            <!--begin: Form Wizard Form-->
                            <div class="kt-form col-lg-11 ml-3" id="kt_form" style="padding-top: 0px !important">

                                <!--begin: Form Wizard Step 1-->
                                <div class="kt-wizard-v3__content" data-ktwizard-type="step-content">

                                    <div class="kt-form__section kt-form__section--first">
                                        <div class="kt-wizard-v3__form" style="margin-top: 0px !important">
                                            <telerik:RadAjaxPanel ID="pnlOne" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                            <div class="col-lg-12 mt-3 row" style="padding-top: 23px;">
                                                <div class="col-lg-6">
                                                <h5 style="color: #464646">1 Select the Type</h5>
                                                <label style="color: #464646; font-size: smaller">Please select the type to get the download template</label>
                                                <div class="col-lg-12 kt--align-center mt-2" style="padding-left: 0px !important;">
                                                  <telerik:RadComboBox ID="cmbType" runat="server" EmptyMessage="Select Type" Filter="Contains" 
                                                      OnSelectedIndexChanged="cmbType_SelectedIndexChanged" Width="50%" AutoPostBack="true"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rdl" runat="server" ErrorMessage="Choose Type" ForeColor="Red" ValidationGroup="upload"
                                                        ControlToValidate="cmbType"
                                                        ></asp:RequiredFieldValidator>
                                                   <%--  <i class="fas fa-download" style="color: black; padding-top: 15px; margin-left: 0px;">
                                                    </i>--%>
                                                </div>
                                                    </div>

                                                  <div class="col-lg-6 ">
                                                <asp:PlaceHolder ID="plcTemplate" runat="server" Visible="false">
                                                      <h5 style="color: #464646"> Download Template </h5>
                                                <label style="color: #464646; font-size: smaller">Please download the template for  <asp:Label ID="lblTemplateName" runat="server"></asp:Label></label>
                                                <div class="col-lg-12 kt--align-center mt-2" style="padding-left: 0px !important;">
                                                <%--   <a href="../UploadFiles/Template/Claim_Template_rep.xlsx" class="btn btn-secondary"
                                                        style="padding-top: 3px; padding-bottom: 3px;">
                                                        <span>&nbsp;<span style="font-size: small">Download </span></span>
                                                    </a>--%>
                                                    <asp:HyperLink ID="lnkDnload" runat="server" CssClass="btn btn-secondary" style="padding-top: 3px; padding-bottom: 3px;" Text="Download"></asp:HyperLink>
                                                    
                                                     <i class="fas fa-download" style="color: black; padding-top: 15px; margin-left: 0px;">

                                                    </i>
                                                </div>
                                                    </asp:PlaceHolder>
                                                    </div>
                                            </div>
                                                   
                                          
                                              <div class="col-lg-12 row">
                                            <div class="col-lg-6 mt-5">
                                                <h5 style="color: #464646">2.a Choose Excel</h5>
                                                <label style="color: #464646; font-size: smaller">Please fill the template you downloaded and upload the same</label>
                                                <br />
                                                <div class="col-lg-6 row">
                                                  
                                                    <%--<asp:LinkButton ID="kk" Width="40%" runat="server" style="margin-left:0px !important; padding-left:0px;" BackColor="Transparent" class="col-lg-2"  BorderStyle="None" >--%>
                                                    <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                                                        ID="updImg" AllowedFileExtensions="xlsx" MultipleFileSelection="Disabled"
                                                        UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px"
                                                        Style="padding-top: 10px; text-align: center;">

                                                        <Localization Select="Browse" />
                                                        <FileFilters>
                                                            <telerik:FileFilter Description="" Extensions="xlsx" />
                                                        </FileFilters>
                                                    </telerik:RadAsyncUpload>
                                                      <i class="fas fa-upload" style="color: black; padding-top: 15px; margin-left: 12px;"></i>
                                                    <%--</asp:LinkButton>--%>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 mt-5">
                                                <asp:PlaceHolder ID="plcImageUpload" runat="server" Visible="false">
                                                <h5 style="color: #464646">2.b Choose ZIP file</h5>
                                                <label style="color: #464646; font-size: smaller">Upload images as .zip file</label>
                                                <br />
                                                <div class="col-lg-6 row">
                                                    
                                                    <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server"
                                                        ID="updZip" AllowedFileExtensions="zip" MultipleFileSelection="Disabled"
                                                        UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px"
                                                        Style="padding-top: 10px; text-align: center;">
                                                        <Localization Select="Browse" />
                                                        <FileFilters>
                                                            <telerik:FileFilter Description="" Extensions="zip" />
                                                        </FileFilters>
                                                    </telerik:RadAsyncUpload>
                                                    <i class="fas fa-upload" style="color: black; padding-top: 15px; margin-left: 18px;"></i>
                                                    <%--</asp:LinkButton>--%>
                                                </div>
                                                    </asp:PlaceHolder>
                                            </div>
                                                  </div>
                                                </telerik:RadAjaxPanel>
                                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent">
                                                    <div class="row">
                                                        <div class="mt-5 col-lg-1">
                                                            <img alt="Loading..." src="../Media/loader.gif" />

                                                        </div>
                                                     
                                                    </div>

                                                </telerik:RadAjaxLoadingPanel>
                                             
                                            <div class="col-lg-6 mt-5">
                                                <h5 style="color: #464646">3. Validation</h5>
                                                <label style="color: #464646; font-size: smaller">We will valdiate the data and show you if any corrections needed</label>
                                                <br />
                                                <telerik:RadAjaxPanel ID="pl1" runat="server" LoadingPanelID="radloadingvaldate">
                                                    
                                                    <asp:LinkButton ID="lnkValidate" runat="server"
                                                         CausesValidation="true" OnClick="lnkValidate_Click" ValidationGroup="upload"
                                                        Style="padding-top: 3px; padding-bottom: 3px;"
                                                        CssClass="btn btn-secondary"
                                                        Text='<span><span>View Data</span></span>'>            
                                                    </asp:LinkButton>
                                                    <i class="fas fa-clipboard-check" style="color: black; padding-top: 15px; margin-right: 10px;"></i>
                                                    <br />
                                                    <asp:PlaceHolder ID="plcSUccess" runat="server" Visible="false">
                                                        <img alt="Loading..." style="height: 10px" src="../Media/success.svg" />
                                                        <asp:Label ID="uploaded" runat="server" Text="Click Next Step"></asp:Label>
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="plcFailed" runat="server" Visible="false">
                                                        <img alt="Loading..." style="height: 10px" src="../Media/fail.svg" />
                                                        <asp:Label ID="Label1" runat="server" Text="Failed"></asp:Label>
                                                    </asp:PlaceHolder>
                                                </telerik:RadAjaxPanel>

                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="radloadingvaldate" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent">
                                                    <div class="row">
                                                        <div class="mt-5 col-lg-1">
                                                            <img alt="Loading..." src="../Media/loading3.gif" />

                                                        </div>
                                                        <div class="col-lg-2 mt-5">Loading...</div>
                                                    </div>

                                                </telerik:RadAjaxLoadingPanel>
                                            </div>
                                                


                                        </div>
                                    </div>
                                </div>

                                <!--end: Form Wizard Step 1-->

                                <!--begin: Form Wizard Step 2-->
                                <div class="kt-wizard-v3__content" data-ktwizard-type="step-content">
                                    <div class="kt-form__section kt-form__section--first">
                                        <div class="kt-wizard-v3__form">

                                            <div class="kt-wizard-v3__form-label"></div>

                                            <telerik:RadAjaxPanel ID="pnlGrid" runat="server">
                                                <div class="col-lg-12 mt-3" style="padding-top: 23px;">
                                                    <h5 style="color: #464646">1. Uploaded Data</h5>
                                                    <asp:Label Style="color: #464646; font-size: smaller" ID="successlabel" runat="server"></asp:Label>
                                                    <div class="col-lg-12 kt--align-center mt-2">
                                                        <telerik:RadGrid RenderMode="Lightweight" Visible="true" runat="server" AllowMultiRowSelection="false"
                                                            ID="rdImpExc" AutoGenerateColumns="true" GridLines="None"
                                                            ShowFooter="True" AllowSorting="True"
                                                           
                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                            EnableAjaxSkinRendering="true"
                                                            
                                                            AllowPaging="true" PageSize="20" CellSpacing="0">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
                                                                <Resizing EnableRealTimeResize="true" />
                                                            </ClientSettings>
                                                            <MasterTableView AutoGenerateColumns="true"  CanRetrieveAllData="true" ShowFooter="true"
                                                                EnableHeaderContextMenu="true">
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </div>
                                              
                                                
                                                <div class="" hidden="hidden">
                                                <div class="col-lg-12 mt-3" hidden="hidden" style="padding-top: 23px;">
                                                    <h5 style="color: #464646">2. Related Images</h5>
                                                    <asp:Label Style="color: #464646; font-size: smaller" ID="successlabel2" runat="server"></asp:Label>
                                                    <div class="col-lg-12 kt--align-center mt-2">
                                                        <telerik:RadImageGallery ID="rdMatchingImages" DataTitleField="Title" Visible="false"
                                                            DataImageField="img" runat="server" Height="90px" Width="50%" RenderMode="Classic" target="_blank" DataThumbnailField="img" DisplayAreaMode="LightBox">
                                                        </telerik:RadImageGallery>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 mt-3" style="padding-top: 23px;">
                                                    <h5 style="color: #464646">3. Not Verified Data</h5>
                                                    <asp:Label Style="color: #464646; font-size: smaller" ID="failurelabel1" runat="server"></asp:Label>
                                                    <div class="col-lg-12 kt--align-center mt-2">
                                                        <telerik:RadGrid RenderMode="Lightweight" Visible="false" runat="server" AllowMultiRowSelection="false"
                                                            ID="rdExcUnMatch" AutoGenerateColumns="true" GridLines="None"
                                                            ShowFooter="True" AllowSorting="True" Height="300px"
                                                            OnNeedDataSource="rdExcUnMatch_NeedDataSource"
                                                            OnItemCommand="rdExcUnMatch_ItemCommand"
                                                            OnUpdateCommand="rdExcUnMatch_UpdateCommand"
                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                            EnableAjaxSkinRendering="true"
                                                            AllowPaging="true" PageSize="20" CellSpacing="0">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" ScrollHeight="280px" SaveScrollPosition="true"></Scrolling>
                                                                <%--<Resizing  EnableRealTimeResize="true" />--%>
                                                            </ClientSettings>

                                                            <MasterTableView AutoGenerateColumns="true" EditMode="EditForms" CanRetrieveAllData="true" DataKeyNames="S#" ShowFooter="false"
                                                                EnableHeaderContextMenu="true">
                                                        
                                                                <EditFormSettings UserControlName="ClaimDetails.ascx" EditFormType="WebUserControl">
                                                                    <EditColumn UniqueName="EditCommandColumn1">
                                                                    </EditColumn>

                                                                </EditFormSettings>

                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 mt-3" hidden="hidden" style="padding-top: 23px;">
                                                    <h5 style="color: #464646">4. Related Images</h5>
                                                    <asp:Label Style="color: #464646; font-size: smaller" ID="failureLabel2" runat="server"></asp:Label>
                                                    <div class="col-lg-12 kt--align-center mt-2">
                                                        <telerik:RadImageGallery ID="RdNonMatchImages" DataTitleField="Title" Visible="false"
                                                            DataImageField="img" runat="server" Height="90px" Width="50%" DataThumbnailField="img" DisplayAreaMode="LightBox">
                                                        </telerik:RadImageGallery>
                                                    </div>
                                                </div>
                                                </div>
                                            </telerik:RadAjaxPanel>

                                        </div>
                                    </div>
                                </div>

                                <!--end: Form Wizard Step 2-->

                                <!--begin: Form Wizard Step 3-->
                                <div class="kt-wizard-v3__content" data-ktwizard-type="step-content">
                                    <div class="kt-form__section kt-form__section--first">
                                        <telerik:RadAjaxPanel ID="pnlSubmit" runat="server">
                                            <div class="kt-wizard-v3__form">
                                             

                                                <div class="col-lg-6 mt-3" style="padding-top: 23px;">
                                                    <h5 style="color: #464646">1. Submit</h5>
                                                    <asp:Label Style="color: #464646; font-size: smaller" ID="Label5" runat="server" Text="Please click Proceed to submit your data"></asp:Label>
                                                    <div class="col-lg-12 kt--align-center mt-2">
                                                        <div class="col-lg-12 kt-mt-10">
                                                            <div class="col-lg-12 kt--align-center">
                                                                <asp:LinkButton ID="lnkSave" runat="server"
                                                                    OnClientClick="OpenInsert();" CausesValidation="false"
                                                                    CssClass="btn btn-outline-success  btn btn--custom btn--icon btn--air btn--pill"
                                                                    Text='<span><span>Proceed</span> &nbsp;<i class="fa fa-save"></i></span>'>            
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </telerik:RadAjaxPanel>
                                    </div>
                                </div>

                                <!--end: Form Wizard Step 3-->

                                <!--begin: Form Wizard Step 4--

												<!--end: Form Wizard Step 4-->


                                <!--end: Form Wizard Step 5-->

                                <!--begin: Form Actions -->
                                <div class="kt-form__actions">
                                    <button class="btn btn-secondary btn-md btn-tall btn-wide kt-font-bold kt-font-transform-u" data-ktwizard-type="action-prev">
                                        Previous
												
                                    </button>
                                    <%--	<button class="btn btn-success btn-md btn-tall btn-wide kt-font-bold kt-font-transform-u" data-ktwizard-type="action-submit">
														Submit
													</button>--%>
                                    <button class="btn btn-brand btn-md btn-tall btn-wide kt-font-bold kt-font-transform-u" data-ktwizard-type="action-next">
                                        Next Step
												
                                    </button>
                                </div>

                                <!--end: Form Actions -->
                            </div>
                            <!--end: Form Wizard Form-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Excel data has been uploaded successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lnkOk" runat="server" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_4a" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Unmatched claims saved as drafts, please proceed with the matched claims.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" data-dismiss="modal" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><span id="spnMsg"></span></h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    

    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure want to upload the data?</h5>
                </div>
              <telerik:RadAjaxPanel ID="d" runat="server">
                   
                <asp:Timer ID="tmrFinal" runat="server" Interval="1000"  Enabled="false" OnTick="tmrFinal_Tick"></asp:Timer>
                   
              </telerik:RadAjaxPanel>
                  <telerik:RadAjaxPanel ID="pnlSave" LoadingPanelID="RadAjaxLoadingPanel1" runat="server">
                    <div class="modal-body">
                       
                       
                               <div class="col-lg-12">
                                    <asp:PlaceHolder ID="plcBtns" runat="server" Visible="true">
                        <asp:LinkButton ID="btnSav" runat="server" OnClick="btnSav_Click"  CssClass="btn btn-secondary">Yes</asp:LinkButton>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                   
                                        </asp:PlaceHolder>
                                    
                              </div>
                              <div class="col-lg-12 mt-2">
                          <asp:PlaceHolder ID="plcSuc" runat="server" Visible="false"> 
                                       <span style="color:green; font-size:smaller" >File Upload Completed, you will be redirected to Dashboard in
                                           <asp:Label ID="lblTimerSuc" runat="server" Text="5"></asp:Label> seconds</span>
                                       </asp:PlaceHolder>
                       <asp:PlaceHolder ID="plcFail" runat="server" Visible="false"> 
                                       <span style="color:red; font-size:smaller" >Data you are trying to upload may already exisits or the format may be incorrect<br/> Please check the Excel data</span>
                                       </asp:PlaceHolder>
                                     <asp:PlaceHolder ID="plcWrong" runat="server" Visible="false"> 
                                       <span style="color:red; font-size:smaller" ><asp:Label ID="lblError" runat="server"></asp:Label></span>
                                       </asp:PlaceHolder>
                                  </div>
                               
                         
                    </div>
                    
               </telerik:RadAjaxPanel>
                <div class="modal-footer">

              

                    <div class="col-lg-12">
                              <asp:LinkButton ID="lnkExit" runat="server"  OnClick="lnkExit_Click" Visible="false" CssClass="btn btn-danger">Exit</asp:LinkButton>
                      <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                    BackColor="Transparent"
                    ForeColor="Blue">
                   <div class="mt-5 col-lg-1">
                                                            <img alt="Loading..." src="../Media/loading3.gif" />

                                                        </div>
                                                        <div class="col-lg-2">Uploading...</div>

                </telerik:RadAjaxLoadingPanel>
                        </div>
                </div>
             

            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_10" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">All the unmatched claims will be saved as draft and you will notified when the new technical data uploaded</h5>
                </div>
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" LoadingPanelID="RadAjaxLoadingPanel3" runat="server">


                    <div class="modal-footer">
                       
                        <asp:LinkButton ID="lnkDrafts" runat="server"  CssClass="btn btn-secondary">Yes</asp:LinkButton>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        
                        
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

    <style>
        .RadUpload_Silk .ruSelectWrap .ruButton {
            padding-bottom: 20px !important;
            color: black !important;
            background-color: transparent !important;
            background-image: url() !important;
        }

        .RadGrid .rgHoveredRow {
            background-color: darkgray !important;
        }

        .RadGrid .rgSelectedRow {
            background-image: none !important;
            background-color: red !important;
        }
        .RadUpload .ruFileLI .ruButton {
        display:block;
        }
        .RadAjaxPanel{
            display:inline;
        }

    </style>
</asp:Content>
