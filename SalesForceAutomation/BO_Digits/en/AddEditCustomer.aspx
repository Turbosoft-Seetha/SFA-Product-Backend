<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditCustomer.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditCustomer" %>

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
        function Routemapping() {

            $('#kt_modal_1_6').modal('show');
        }
        function failedModal(res) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('show');
            $('#failres').text(res);

        }

    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <div style="border: 1px solid #ccc; padding: 10px; border-radius: 5px;">
        <h9 style="margin-top: 0;">Settings Profile</h9>
        <div style="display: flex; align-items: center;">
            <telerik:RadDropDownList ID="rdProfile" runat="server"  CausesValidation="false" Width="200px" Filter="Contains">
                <Items>
                   <telerik:DropDownListItem Text="Select Profile" Value="0" Selected="true"/>
               </Items>
            </telerik:RadDropDownList>
            <asp:LinkButton ID="ApplyProfile" runat="server"
                Text="Apply" CssClass="btn btn-sm fw-bold btn-secondary"
                CausesValidation="False" OnClick="ApplyProfile_Click" 
                style="margin-left: 10px; height: 30px; padding: 5px 10px; line-height: 20px;" />
        </div>
    </div>
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
        <asp:PlaceHolder runat="server" ID="pnlRotMapping" Visible="false">
            <asp:LinkButton ID="Routemap" runat="server" Text="Proceed to route mapping" CssClass="btn btn-sm fw-bold btn-secondary" CausesValidation="true" ValidationGroup="form" OnClick="Routemap_Click" />
        </asp:PlaceHolder>

        <asp:LinkButton ID="LinkCancel" runat="server" Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary" CausesValidation="False" OnClick="LinkCancel_Click" />

        <asp:LinkButton ID="LinkSave" runat="server" OnClick="LinkSave_Click" Text='<i class="icon-ok"></i>Proceed' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" ValidationGroup="form" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-portlet__body" style="margin: 10px;">

                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                                 <!--Begin::Basic Info -->

                                <div class="col-lg-12 fw-bold fs-3">    Basic Info    </div>

                                    <div class="col-lg-12 row pt-2">


                                        <div class="col-lg-4 form-group pt-2">
                                            <label class="control-label col-lg-12">Code <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtCode" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%" OnTextChanged="txtCode_TextChanged" AutoPostBack="true"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtCode" ErrorMessage="Please Enter Code " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-2">
                                            <label class="control-label col-lg-12">Name <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtName" runat="server" RenderMode="Lightweight" Rows="2" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtName" ErrorMessage="Please Enter Name " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-2">
                                            <label class="control-label col-lg-12">Name Arabic </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtArabName" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Short Name</label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtShortName" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Address</label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtad" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Address Arabic</label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtArabAddress" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Contact Email </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtEmail" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>

                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Phone</label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtPerson" runat="server" RenderMode="Lightweight" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" CssClass="form-control" Width="100%"></telerik:RadNumericTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Whatsapp No </label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtwhatsNo" runat="server" RenderMode="Lightweight" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" CssClass="form-control" Width="100%"></telerik:RadNumericTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Contact Person </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtContactPerson" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Contact Person Arabic </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtARcontactPerson" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">GeoCode</label>
                                            <div class="col-lg-12">

                                                <telerik:RadTextBox ID="txtGeoLoc" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Recapture GeoCode <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlRecapture" runat="server" RenderMode="Lightweight" Width="100%" DefaultMessage="Please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Alternative HOCode</label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtAltHOCode" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Enable Invoice Approval<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="EnableInvAppr" runat="server" RenderMode="Lightweight" Width="100%" DefaultMessage="Please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <br />

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Status <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlStatus" runat="server" RenderMode="Lightweight" Width="100%" DefaultMessage="Please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                                        <telerik:DropDownListItem Text="Inactive" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>

                                            </div>
                                        </div>

                                    </div>

                                 <!--End::Basic Info -->

                                 <!--begin::Categorization -->

                                <div class="col-lg-12 fw-bold fs-3 pt-6">  Categorization  </div>
                                   
                                    <div class="col-lg-12 row mb-4">

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Class<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlcls" runat="server" RenderMode="Lightweight" CausesValidation="false" Width="100%" Filter="Contains"
                                                    EmptyMessage="Select Class">
                                                </telerik:RadComboBox>
                                                <br />
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator12" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlcls" ErrorMessage="Please select Class" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Customer Type <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlcustype" runat="server" Width="100%" RenderMode="Lightweight" EmptyMessage="Select Customer Type" Filter="Contains"
                                                    OnSelectedIndexChanged="ddlcustype_SelectedIndexChanged" AutoPostBack="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Normal" Value="NC" />
                                                        <telerik:RadComboBoxItem Text="Branch" Value="BR" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <br />
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlcustype" ErrorMessage="Please Select Customer Type " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                       
                                            <div class="col-lg-4 form-group pt-4">
                                                <label class="control-label col-lg-12">TRN Number</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtTRN" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                    <br />

                                                </div>
                                            </div>
                                      
                                        <asp:PlaceHolder runat="server" ID="pnlCusHead" Visible="false">
                                            <div class="col-lg-4 form-group pt-4">
                                                <label class="control-label col-lg-12">Customer Header <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox ID="ddlCusHeader" runat="server" Width="100%" RenderMode="Lightweight" EmptyMessage="Select Customer Header" Filter="Contains">
                                                    </telerik:RadComboBox>

                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlCusHeader" ErrorMessage="Please Select Customer Header " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                        </asp:PlaceHolder>

                                        <div class="col-lg-4 form-group pt-4">
                                            <label class="control-label col-lg-12">Area <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlarea" runat="server" RenderMode="Lightweight" CausesValidation="false" Width="100%" Filter="Contains"
                                                    EmptyMessage="Select Area">
                                                </telerik:RadComboBox>
                                                <br />
                                                <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlarea" ErrorMessage="Please select Area" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                            </div>


                                        </div>

                                    </div>

                                 <!--End::Categorization -->
                               

                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
    </div>


    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:650px;">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>

                <%-- Route Mapping starts --%>

                     <div class="modal-content">
                     <div class="modal-header">
                         <h5 class="modal-title">Customer Route Mapping
                         </h5>
                     </div>

                     <div class="modal-body">
                         <div class="col-lg-6 form-group pt-4">
                             <label class="control-label col-lg-12">Route</label>
                             <div class="col-lg-12">
                                 <telerik:RadComboBox ID="ddlRoute" runat="server" EmptyMessage="Choose Route for mapping" Filter="Contains" RenderMode="Lightweight" Skin="Silk" Width="100%"></telerik:RadComboBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="frm" ControlToValidate="ddlRoute" ErrorMessage="Please select Route" ForeColor="Red" Display="Dynamic"
                                     SetFocusOnError="True"></asp:RequiredFieldValidator>
                             </div>
                         </div>

                     </div>


                     <div class="modal-footer">
                         <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

                             <asp:LinkButton ID="Proceedmap" runat="server" Text="Proceed with Route Mapping" OnClick="Proceedmap_Click" CssClass="btn btn-sm fw-bold btn-primary" ValidationGroup="frm" CausesValidation="true" />
                             <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Proceed without Route Mapping</asp:LinkButton>
                            
                         </telerik:RadAjaxPanel>
                         <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                             BackColor="Transparent"
                             ForeColor="Blue">
                             <div class="col-lg-12 text-center mt-5">
                                 <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                             </div>
                         </telerik:RadAjaxLoadingPanel>
                        <%-- <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">Cancel</button>--%>
                     </div>
                 </div>

                <%-- Route Mapping Ends --%>


                <%--<div class="modal-footer">
                   
                </div>--%>
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


    <div class="modal fade modal-center" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
               <div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title">Customer Route Mapping
        </h5>
    </div>

    <div class="modal-body">
        <div class="col-lg-6 form-group pt-4">
            <label class="control-label col-lg-12">Route</label>
            <div class="col-lg-12">
                <telerik:RadComboBox ID="ddlRoutes" runat="server" EmptyMessage="Choose Route for mapping" Filter="Contains" RenderMode="Lightweight" Skin="Silk" Width="100%"></telerik:RadComboBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="frms" ControlToValidate="ddlRoutes" ErrorMessage="Please select Route" ForeColor="Red" Display="Dynamic"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
        </div>

    </div>


    <div class="modal-footer">
        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

            <asp:LinkButton ID="lnkProceedmapEdit" runat="server" Text="Proceed with Route Mapping" OnClick="lnkProceedmapEdit_Click" CssClass="btn btn-sm fw-bold btn-primary" ValidationGroup="frms" CausesValidation="true" />
            <asp:LinkButton ID="lnkProceedwithoutEdit" runat="server" OnClick="lnkProceedwithoutEdit_Click" CssClass="btn btn-sm fw-bold btn-secondary">Proceed without Route Mapping</asp:LinkButton>
                            
        </telerik:RadAjaxPanel>
        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
            BackColor="Transparent"
            ForeColor="Blue">
            <div class="col-lg-12 text-center mt-5">
                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
            </div>
        </telerik:RadAjaxLoadingPanel>
       <%-- <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">Cancel</button>--%>
    </div>
</div>
        </div>
    </div>

    <!--end::FailedModal-->
      <div class="modal fade" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Oops..!</h5>
              </div>
              <div class="modal-body">
                  <span id="failres"></span>
              </div>
              <div class="modal-footer">
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_2);">Ok</button>
              </div>
          </div>
      </div>
  </div>
</asp:Content>
