<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SpecialPriceBulkDelete.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SpecialPriceBulkDelete" %>

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
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_9').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body p-8" style="background-color: white;">

        <div class="kt-portlet__body">
            <div class="card-body" style="background-color: white; padding-bottom: 10px;">
                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="98%" ID="RadPanelBar0" runat="server">
                    <Items>
                        <telerik:RadPanelItem Font-Bold="true" Text="Note:" Expanded="false" ForeColor="Blue" BackColor="white">
                            <ContentTemplate>
                                <div class="kt-portlet__body" style="background-color: white; display: grid; padding: 15px;">
                                    <table>
                                        <td style="width: 100%">

                                            <div class="fs-6 text-dark-400 fw-bold pe-7">When you remove Special price from certain routes, several things will happen: </div>
                                            <div class="fs-6 text-gray-700 pe-7">
                                                1. The assigned special price will be marked as inactive for the customers those who are under the selecetd Route in ' Route' with the selected special prise and payment mode.
                                            </div>
                                            <div class="fs-6 text-gray-700 pe-7">2.Once you deactivate it, you can't take it back. If you want to do that, you need to assign it as new special price</div>
                                            
                                        </td>
                                    </table>
                                </div>
                            </ContentTemplate>
                        </telerik:RadPanelItem>
                    </Items>
                </telerik:RadPanelBar>
            </div>
        </div>

        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

            <div class=" col-lg-12 row" style="padding-bottom: 10px; padding-top: 15px">

                <div class="col-lg-3">
                    <label class="control-label col-lg-12">Select Special Price</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Filter="Contains" Skin="Material" RenderMode="Lightweight"
                            ID="ddlSP" runat="server" EmptyMessage="Select Special Price" OnSelectedIndexChanged="ddlSP_SelectedIndexChanged" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>
                </div>

                <div class="col-lg-3" style="margin-left: -22px;">
                    <label class="control-label col-lg-12">Select Payment Mode</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Skin="Material" Filter="Contains"  RenderMode="Lightweight"
                            ID="ddlPayMode" runat="server" EmptyMessage="Select Payment Mode" OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>
                </div>
                <div class="col-lg-3" style="margin-left: -20px;">
                    <label class="control-label col-lg-12">Select Route</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                            ID="ddlRoute" runat="server" EmptyMessage="Select Route" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>
                </div>


                <div class="col-lg-3" style="top: 10px; text-align: center; padding-top: 15px; margin-left: -70px;">
                    <asp:LinkButton ID="Delete" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Delete_Click">
                                                    Remove
                    </asp:LinkButton>
                </div>




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
     <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to Update..??
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>

                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">No selection found..!</h5>
                </div>
                <div class="modal-body">
                    <p>Please make selection and try again.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
