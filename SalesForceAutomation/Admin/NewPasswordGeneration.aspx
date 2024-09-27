<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="NewPasswordGeneration.aspx.cs" Inherits="SalesForceAutomation.Admin.NewPasswordGeneration" %>

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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="kt-portlet">



                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Override Request Generation</h3>

                             <%-- breadcrumbs --%>
                        <div class="kt-subheader__breadcrumbs" style="padding-left:20px;">
                            <a href="NewPasswordGeneration.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Override Request Generation</a>

                        </div>
                         <%-- breadcrumbs --%>
                        </div>
                         <telerik:RadAjaxPanel ID="pnl" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <%--<asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" Text="Save" OnClick="lnkSave_Click" BackColor="#66ccff" BorderColor="#66ccff" CausesValidation="true" ValidationGroup="frm"></asp:LinkButton>--%>
                                &nbsp;
                             <%-- <asp:LinkButton ID="lnkSubCat" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" Text="List" OnClick="lnkSubCat_Click" Style="padding-top:14px;"></asp:LinkButton>
                                
                                    <a class="btn btn-brand btn-elevate btn-icon-sm" href="NewPasswordGeneration.aspx">Cancel
                                    </a>--%>

                             <asp:LinkButton ID="LinkButton1" Width="100px" runat="server" ValidationGroup="form" OnClick="LinkButton1_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>View List'
                                    CssClass="btn btn-brand btn-elevate btn-icon-sm"  CausesValidation="false"/>
                                <asp:LinkButton ID="LinkButton2" Width="100px" runat="server"
                                    Text="Back" CssClass="btn btn-brand btn-elevate btn-icon-sm"
                                    CausesValidation="False" OnClick="LinkButton2_Click" />
                            

                            </telerik:RadAjaxPanel>

                    </div>


                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <div class=" col-lg-8 row" style="padding-bottom: 10px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">Route Code</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdRoute" runat="server" DefaultMessage="Select Route"  EmptyMessage="Select Route" Width="100%" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged1" AutoPostBack="true">
                                            </telerik:RadDropDownList>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="rdRoute" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 10px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">Customer Code</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdCus" runat="server"  DefaultMessage="Select Customer" EmptyMessage="Select Customer" Width="100%">
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="rdCus" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 20px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">Feature</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdFeature" runat="server" DefaultMessage="Select Feature" Width="100%">
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="rdFeature" ErrorMessage="Please Select Feature" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                      
                                        </div>
                                    </div>
                                </div>

                                 <div class=" col-lg-8 row" style="padding-top: 20px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">Time Zone</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                                ID="rdTimeZone" runat="server" DefaultMessage="Select Time Zone" EmptyMessage="Select Time Zone" Width="100%">
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                        ControlToValidate="rdTimeZone" ErrorMessage="Please Select Time Zone" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                      
                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 20px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">Key</label>

                                    </div>
                                    <div class="col-lg-5">
                                        <div class="col-lg-12" style="background-color: white">
                                            <telerik:RadNumericTextBox Skin="Material" RenderMode="Lightweight" MaxLength="6" NumberFormat-AllowRounding="false" DecimalDigits="0"
                                                ID="txtKey" runat="server" NumberFormat-GroupSeparator="" Width="100%">
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                        ControlToValidate="txtKey" ErrorMessage="Please enter Key" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                           
                                        </div>
                                    </div>
                                </div>

                                <div class=" col-lg-8 row" style="padding-top: 40px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12" style="color: black">Password</label>

                                    </div>
                                    <div class="col-lg-5" style="padding-left:30px;">
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
                                                ID="btn" runat="server" Width="100%" Text="Generate Password" OnClick="btn_Click">
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
                                    <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
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
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Override Request has been saved successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server"  CssClass="btn btn-secondary">Ok</asp:LinkButton>
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
                    <span id="failres"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->
</asp:Content>
