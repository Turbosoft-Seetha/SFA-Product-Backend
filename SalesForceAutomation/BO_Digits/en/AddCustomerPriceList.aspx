<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddCustomerPriceList.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddCustomerPriceList" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function Delete() {
            $('#kt_modal_1_6').modal('show');
        }
        function TypeSelect() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }
        function DeleteFailed() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_9').modal('show');

        }

  


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

      

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

        <asp:LinkButton ID="lnkcancel" runat="server" ValidationGroup="form" OnClick="lnkcancel_Click"
            UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Cancel'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
        <asp:LinkButton ID="LinkSave" runat="server" ValidationGroup="form" OnClick="LinkSave_Click"
            UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
                <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">



                    <div class="col-lg-4">
                        <label class="control-label col-lg-12">Route Type</label>
                        <div class="col-lg-12">
                            <telerik:RadComboBox ID="ddlRotType" Width="100%" runat="server" EmptyMessage="Select Route Type" Filter="Contains" RenderMode="Lightweight" AutoPostBack="true" OnSelectedIndexChanged="ddlRotType_SelectedIndexChanged" >
                                <Items>
                                    <telerik:RadComboBoxItem Text="All" Value="AL"  Selected="true"  />
                                    <telerik:RadComboBoxItem Text="Sales" Value="SL"/>
                                    <telerik:RadComboBoxItem Text="Order" Value="OR" />
                                    <telerik:RadComboBoxItem Text="AR" Value="AR" />
                                    <telerik:RadComboBoxItem Text="Order & AR" Value="OA" />
                                    <telerik:RadComboBoxItem Text="Delivery" Value="DL" />
                                    <telerik:RadComboBoxItem Text="Merchandising" Value="MER" />
                                    <telerik:RadComboBoxItem Text="Field Services" Value="FS" />
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                    </div>


                    <div class="col-lg-4">
                        <label class="control-label col-lg-12">Route </label>
                        <div class="col-lg-12">
                            <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains"
                                RenderMode="Lightweight" EmptyMessage="Select Route" Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                            </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                            ControlToValidate="ddlRoute" ErrorMessage="Please choose Route" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <label class="control-label col-lg-12">Special Price </label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlSp" runat="server" Filter="Contains"
                                            RenderMode="Lightweight" EmptyMessage="Select Special Price" Width="100%" >
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                            ControlToValidate="ddlSp" ErrorMessage="Please choose Special Price" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <label class="control-label col-lg-12">Payment Mode</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlPayMode" runat="server" DefaultMessage="Select Payment Mode" EmptyMessage="Select Payment Mode" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Hard Cash" Value="HC" />
                                                <telerik:RadComboBoxItem Text="Credit" Value="CR" />
                                                <telerik:RadComboBoxItem Text="POS" Value="POS" />
                                                <telerik:RadComboBoxItem Text="Online Payment" Value="OP" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ControlToValidate="ddlPayMode" ErrorMessage="Please choose payment mode" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                
                                <div class="col-lg-4" >
                                    <label class="control-label col-lg-12">From Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
                                        <%--                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>

                 <div class="col-lg-4" >
                                    <label class="control-label col-lg-12">To Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                        <%--                                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                            </div>
            </div>
            <div class="col-lg-12 row">
                 

            </div>
        </div>
    </div>

    <%-- modal start --%>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to add ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel9">
                        <asp:LinkButton ID="LnkaddConfirm" runat="server" OnClick="LnkaddConfirm_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                    OK
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success">Price List added successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="SuccessOK" runat="server" OnClick="SuccessOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>
                </div>
            </div>
        </div>
    </div>
  

 
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
