<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="NewPasswordGeneration.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.NewPasswordGeneration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
        }
        function failedModal(res) {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#failres').text(res);
        }
       
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
 <asp:LinkButton ID="LinkButton2" Width="100px" runat="server" 
                                    Text="يلغي" CssClass="btn btn-sm fw-bold btn-secondary"
                                    CausesValidation="False" OnClick="LinkButton2_Click" />
                             <asp:LinkButton ID="LinkButton1" Width="110px" runat="server" 
                         ValidationGroup="form" OnClick="LinkButton1_Click"  UseSubmitBehavior="false" 
                                 Text='<i class="icon-ok"></i>عرض القائمة' CssClass="btn btn-sm fw-bold btn-primary"  CausesValidation="false"/>
                               </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
                <div class="kt-portlet">



                   

                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <div class=" col-lg-8 row" style="padding-bottom: 10px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">كود الطريق</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdRoute" runat="server" DefaultMessage="حدد الطريق"  EmptyMessage="حدد الطريق" Width="100%" 
                                                OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="rdRoute" ErrorMessage="الرجاء تحديد المسار" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 10px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">كود العميل</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdCus" runat="server"  DefaultMessage="حدد العميل" EmptyMessage="حدد العميل" Width="100%">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="rdCus" ErrorMessage="الرجاء تحديد العميل" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 20px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">ميزة</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdFeature" runat="server" DefaultMessage="حدد الميزة" Width="100%">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="rdFeature" ErrorMessage="يرجى تحديد الميزة" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                      
                                        </div>
                                    </div>
                                </div>

                                 <div class=" col-lg-8 row" style="padding-top: 20px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">وحدة زمنية</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdTimeZone" runat="server" DefaultMessage="اختر المجال الزمني" EmptyMessage="اختر المجال الزمني" Width="100%">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                        ControlToValidate="rdTimeZone" ErrorMessage="يرجى تحديد المنطقة الزمنية" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                      
                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 20px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">مفتاح</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12" style="background-color: white">
                                            <telerik:RadNumericTextBox Skin="Material" RenderMode="Lightweight" MaxLength="6" NumberFormat-AllowRounding="false" DecimalDigits="0"
                                                ID="txtKey" runat="server" NumberFormat-GroupSeparator="" Width="100%">
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                        ControlToValidate="txtKey" ErrorMessage="الرجاء إدخال المفتاح" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                           
                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 40px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">كلمة المرور</label>

                                    </div>
                                    <div class="col-lg-5" style="padding-left:23px;">
                                        <div class="col-lg-12" style="background-color: #f0f0f0;">
                                            <telerik:RadTextBox Skin="Material" RenderMode="Lightweight" ForeColor="#000000"
                                                ID="txtPass" runat="server" Width="100%" Font-Bold="true" Enabled="false">
                                            </telerik:RadTextBox>

                                        </div>
                                    </div>
                                </div>
                                <div class=" col-lg-8 row" style="padding-top: 50px; padding-left: 200px">
                                    <div class="col-lg-5" style="padding-left:20px;">
                                        <div class="col-lg-12">
                                            <telerik:RadButton Skin="Material" RenderMode="Lightweight" ValidationGroup="form"
                                                ID="btn" runat="server" Width="100%" Text="توليد كلمة المرور" OnClick="btn_Click">
                                            </telerik:RadButton>
                                           
                                        </div>
                                    </div>
                                </div>

                                 <div class="col-lg-8 row" style="padding-top: 30px; padding-left: 200px">  
                                     <asp:Literal ID="ltrSuccess" runat="server"></asp:Literal> 
                                     
                                </div>

                            </telerik:RadAjaxPanel>
                               <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
                </div>

     <!--begin::ValidationModal-->
   <%-- <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
    </div>--%>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span>تم حفظ طلب التجاوز بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server"  CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
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
                    <h5 class="modal-title">أُووبس..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failres"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->
</asp:Content>
