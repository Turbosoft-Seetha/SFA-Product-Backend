<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="AddEditMasterDataNotifications.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.AddEditMasterDataNotifications" %>
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
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
<telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                  <asp:LinkButton ID="LinkCancel" Width="100px" runat="server"
                                    Text="يلغي"   
                                    CausesValidation="False" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="LinkCancel_Click" />
                          

                                <asp:LinkButton ID="LinkSave" Width="100px" runat="server" ValidationGroup="form" OnClick="LinkSave_Click" UseSubmitBehavior="false" 
                                    Text='<i class="icon-ok"></i>يتابع' CssClass="btn btn-sm fw-bold btn-primary"  CausesValidation="true"/>
                               
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   
                   
                    <div class="kt-portlet__body">
                        <div class="col-lg-12 row" style="padding-top:9px;">
                            
                           <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12" >طريق <span class="required" > </span></label>
                                <div class="col-lg-12">
                                     <telerik:RadComboBox ID="ddlRoute" runat="server" Width="100%" EmptyMessage="حدد الطريق" Filter="Contains"
                                          CheckBoxes="true" EnableCheckAllItemsCheckBox="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlRoute" CssClass="form-control" ErrorMessage="الرجاء تحديد المسار" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">ملاحظات</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtRemarks" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                                     ControlToValidate="txtRemarks" ErrorMessage="الرجاء إدخال الملاحظات" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                             <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تحميل فان ستوك</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlVanStock" runat="server" Width="100%" >
                                        <items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                           
                        </div>
                         <div class="col-lg-12 row" style="padding-top:9px;">
                                 <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">ماجستير تنزيل البيانات</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%" >
                                        <items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                         </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
   
     <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">ل أنت متأكد أنك تريد الحفظ .. ؟؟
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                    <asp:LinkButton ID="save" runat="server" Text="نعم" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                        </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">يلغي</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
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
                    <h5 class="modal-title">أُووبس..!</h5>
                </div>
                <div class="modal-body">
                    <span>هناك شئ خاطئ، يرجى المحاولة فى وقت لاحق.</span>
                </div>
                <div class="modal-footer">
                  <%--  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal();">OK</button>  --%>              
                     <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

</asp:Content>

