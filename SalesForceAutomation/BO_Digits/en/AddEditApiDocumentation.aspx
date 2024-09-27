<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditApiDocumentation.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditApiDocumentation" %>
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
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
      <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary" CausesValidation="False" OnClick="lnkCancel_Click" />
        <asp:LinkButton ID="lnkAdd" runat="server" ValidationGroup="form" OnClick="lnkAdd_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

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
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                            <div class="kt-portlet__body">
                                <div class="col-lg-12 row">
                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12">API</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="rdapiname" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select API"
                                                RenderMode="Lightweight">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ControlToValidate="rdapiname" ErrorMessage="Please select API" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                    <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Heading <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtHeading" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                                ControlToValidate="txtHeading" ErrorMessage="Please Enter Heading" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                

                                    <div class="col-lg-2 form-group">
                                        <label class="control-label col-lg-12">Type <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlType" runat="server" Width="100%" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                                <Items>
                                                    <telerik:DropDownListItem Text="HTML" Value="HTML" Selected="true" />
                                                    <telerik:DropDownListItem Text="Table" Value="T" />
                                                    <telerik:DropDownListItem Text="plain Text" Value="PT" />
                                                     <telerik:DropDownListItem Text="Code" Value="C" />


                                                </Items>
                                            </telerik:RadDropDownList>
                                        </div>
                                    </div>

                                        <div class="col-lg-2 form-group">
                                        <label class="control-label col-lg-12">Order <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtorder" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ControlToValidate="txtorder" ErrorMessage="Please Enter Order" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                          <div class="col-lg-12 mt-5">
                                   <label class="control-label col-lg-12">Sub Heading</label>
                                   <div class="col-lg-12">
                                       <textarea id="txtsub" runat="server" rows="4" cols="50" class="form-control" causesvalidation="false"></textarea>
                                   </div>
                               </div>


                                                                        <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="true">
 
                                    <!-- CKEditor Textarea -->
                                    <div class="col-lg-12 form-group mt-5">
                                        <label class="control-label col-lg-12">Content</label>
                                      <%--  <div class="col-lg-12">
                                            <textarea id="txtContent" name="txtContent" runat="server" rows="10" cols="80" class="form-control"></textarea>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorContent" runat="server"
                                                ControlToValidate="txtContent" ErrorMessage="Please Enter Content" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>--%>


                                         <telerik:RadEditor RenderMode="Lightweight" runat="server" ID="RadEditor1" SkinID="DefaultSetOfTools"
                Height="675px">
                <ImageManager ViewPaths="~/Editor/images/UserDir/Marketing,~/Editor/images/UserDir/PublicRelations"
                    UploadPaths="~/Editor/images/UserDir/Marketing,~/Editor/images/UserDir/PublicRelations"
                    DeletePaths="~/Editor/images/UserDir/Marketing,~/Editor/images/UserDir/PublicRelations"
                    EnableAsyncUpload="true"></ImageManager>
            </telerik:RadEditor>
                                    </div>
                                                                            </asp:PlaceHolder>

                                   <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false">

                                      <div class="col-lg-12 form-group mt-5">
                                        <label class="control-label col-lg-12">Content</label>
                                        <div class="col-lg-12">
                                            <textarea id="txtContent" name="txtContent" runat="server" rows="10" cols="80" class="form-control"></textarea>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorContent" runat="server"
                                                ControlToValidate="txtContent" ErrorMessage="Please Enter Content" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>


                                        
                                    </div>
                                       </asp:PlaceHolder>


                                     


                                </div>
                            </div>
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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

    <!-- Modal and other elements here -->

    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    <script>
        CKEDITOR.replace('txtContent');
    </script>

     <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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


</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
