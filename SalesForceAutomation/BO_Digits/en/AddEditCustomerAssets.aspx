<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditCustomerAssets.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditCustomerAssets" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function redirect() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("CId");
            window.location.href = "ListAssetMaster.aspx?Id=" + c;
        }

     </script>
</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
    <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn btn-sm fw-bold btn-secondary" Text="Cancel" OnClick="lnkCancel_Click"></asp:LinkButton>
                               
    <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Proceed" OnClick="lnkSave_Click" CausesValidation="true" ValidationGroup="form"></asp:LinkButton>
              </telerik:RadAjaxPanel>

                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
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
                    <div class="col-lg-12" style="padding-bottom:7px;">


     <h6 class="kt-portlet__head-title"><asp:Literal ID="ltrlCustomer" runat="server"></asp:Literal> 
     </h6>
    
 </div>
                    <!--begin::Forkt-->

                    <div class="kt-portlet__body" style="padding-top:20px;">
                        <div class="col-lg-12 row">
                              <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                              <label class="control-label col-lg-12">Customer <span class="required"> </span></label>
                              <div class="col-lg-12">
                                  <telerik:RadComboBox ID="ddlcustomer" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Customer"></telerik:RadComboBox>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                      ControlToValidate="ddlcustomer" ErrorMessage="Please Select Customer" Display="Dynamic" ForeColor="Red"
                                      SetFocusOnError="True"></asp:RequiredFieldValidator>
                              </div>
                          </div>


                          
                             <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                 <label class="control-label col-lg-12">Assets Type <span class="required"> </span></label>
                                 <div class="col-lg-12">
                                     <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Assets Type" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                         ControlToValidate="ddlType" ErrorMessage="Please Select Assets Type" Display="Dynamic" ForeColor="Red"
                                         SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                              <label class="control-label col-lg-12">Assets<span class="required"> </span></label>
                              <div class="col-lg-12">
                                  <telerik:RadComboBox ID="ddlasset" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Assets"></telerik:RadComboBox>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                      ControlToValidate="ddlasset" ErrorMessage="Please Select Assets" Display="Dynamic" ForeColor="Red"
                                      SetFocusOnError="True"></asp:RequiredFieldValidator>
                              </div>
                          </div>
                           

                        

                            <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Status <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%">
                                        <Items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <!--end::Form-->
                    </div>
                    <!--end::Portlet-->

                </div>
            </div>
        </div>
    </div>
    </div>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog"  style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to save ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="Linksave" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="Linksave_Click">
                                                    Save
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                     <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog"  style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Asset master has been updated successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog"  style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <!--end::FailureModal-->
</asp:Content>
