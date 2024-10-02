<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditCustomers.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditCustomers" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }

        function Confimroute() {
            $('#modalConfirmRoute').modal('show');
        }


        function hideModalAndReload() {
            $('#kt_modal_1_4').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }


        function hideModalpromotionadding() {
            $('#kt_modal_1_4').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }

        function hideModalcusadding() {
            $('#kt_modal_1_3').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }


        function hideModalRoutecusadding() {
            $('#modalConfirmRoute').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }


        function hideModalAndReloadpromotion() {
            $('#DelPromotionConfirm').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }


        function hideModalAndReloadSpl() {
            $('#pricedel').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }

        function hideModalAndReloadpromo() {
            $('#kt_modal_1_7').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }

        function hideModalAndReloadRoute() {
            $('#kt_modal_1_9').modal('hide');
            setTimeout(function () {
                location.reload();
            }, 500); // Adjust the delay as needed to ensure modal is hidden before reload
        }

        function Succcess(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#modalConfirm1').modal('hide');


            $('#success').text(a);
        }

        function Succcess9(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_9').modal('show');
            $('#modalConfirm1').modal('hide');
            $('#modalConfirmRoute').modal('hide');



            $('#success9').text(a);
        }


        function Succcess3(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_3').modal('show');
            $('#modalConfirm1').modal('hide');


            $('#success3').text(a);
        }

        function Failure1() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }

        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_55').modal('show');
        }

        function pricedelete() {
            $('#pricedel').modal('show');
            $('#modaldelConfirm2').modal('hide');
        }

        function Routemapping() {

            $('#kt_modal_1_6').modal('show');
        }
        function failedModal(res) {
            $('#modalConfirm').modal('hide');
            $('#modaldelConfirm2').modal('hide');

        }
        function Confim1() {
            $('#modalConfirm1').modal('show');
        }
        function delConfim() {
            $('#modaldelConfirm2').modal('show');
        }

        function successModal() {
            $('#modaldelConfirm2').modal('hide');
            $('#kt_modal_1_7').modal('show');
            $('#Modelpromo').modal('hide');

        }
        function successModalPromo() {

            $('#Modelpromo').modal('show');
        }

        function delConfims() {
            $('#modaldelConfirm3').modal('show');
        }

        function DelPromotionConm() {
            $('#DelPromotionConfirm').modal('show');
            $('#modaldelConfirm3').modal('hide');
        }
        function focusNextTextbox() {
            document.getElementById('<%= txtName.ClientID %>').focus();
        }


        function showLoader() {
            document.getElementById('loader').style.display = 'block';
        }

        function hideLoader() {
            document.getElementById('loader').style.display = 'none';
        }

        // Attach showLoader function to the Apply button
        document.getElementById('<%= ApplyProfile.ClientID %>').onclick = function () {
            showLoader();
        };

        // Hide the loader after AJAX request completes
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            hideLoader();
        });

     

        window.onload = function () {
            handleCustomerTypeChange(); // Ensure the validator is set correctly on page load
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">


    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


    

    

     <style>
         .rwzNav{
             display:none;
         }

       .RadPicker .rcCalPopup, .RadPicker .rcTimePopup {
    display:inline;
}


          .addCustomerTitle {
        display: inline-block;
        background-image: url('../assets/media/icons/add.png');
        background-size: contain;
        background-repeat: no-repeat;
        padding-left: 20px; /* Adjust padding to fit the image size */
        background-position: left center;
        vertical-align: middle;

		

		 </style>


    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="SavePrice">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                                       
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>


    </telerik:RadAjaxManagerProxy>




    <div class="kt-portlet__body">
        <div class="col-lg-12 row">

            <div class="demo-container size-medium">
                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Silk" />
<%--                <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">--%>


                    <telerik:RadWizard  RenderMode="Lightweight" ID="RadWizard1" runat="server" Height="1000px">


<%--                        <Localization Finish="Settle" />--%>
                        
                        <WizardSteps  >
                            
                              
                            <telerik:RadWizardStep  Title="Customer" ID="AddCustomer" OnLoad="AddCustomer_Load"  runat="server" StepType="Start" ValidationGroup="Customeradding" CausesValidation="true" SpriteCssClass="addcustomer" >

                     
    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel21">
                     
   

                            
                            
                                <div class="kt-portlet">

                                   


                                      <div class="col-lg-12 form-group pt-4">
    <h9 style="margin-top: 0;">Settings Profile</h9>
    <div class="row">
      <div class="col-lg-6">
    <div style="display: flex; align-items: center; position: relative;">
        <telerik:RadDropDownList ID="rdProfile" runat="server" CausesValidation="false" Width="200px" Filter="Contains">
            <Items>
                <telerik:DropDownListItem Text="Select Profile" Value="0" Selected="true" />
            </Items>
        </telerik:RadDropDownList>
        <asp:LinkButton ID="ApplyProfile" runat="server"
            Text="Apply" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="false" OnClick="ApplyProfile_Click" ValidationGroup="addcus"
            style="margin-left: 10px; height: 30px; padding: 5px 10px; line-height: 20px;" />
        
        <!-- Loader Element -->
        <div id="loader" style="display: none; position: absolute; right: 0;">
            <img src="../assets/media/icons/loader.gif" alt="Loading..." style="height: 30px;"/>
        </div>
    </div>
</div>




        <div class="col-lg-6 text-end">
            <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                <asp:LinkButton ID="btnDone" runat="server" CssClass="btn btn-sm fw-bold btn-success" Width="100px" ValidationGroup="addcus" OnClick="btnDone_Click1" CausesValidation="true">Save</asp:LinkButton>
            </telerik:RadAjaxPanel>
        </div>
    </div>

    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</div>

                                   <%-- <div class="col-lg-12 form-group pt-4">
    <h9 style="margin-top: 0;">Settings Profile</h9>
    <div class="row">
        <div class="col-lg-6">
            <div style="display: flex; align-items: center;">
                <telerik:RadDropDownList ID="rdProfile" runat="server" CausesValidation="false" Width="200px" Filter="Contains">
                    <Items>
                        <telerik:DropDownListItem Text="Select Profile" Value="0" Selected="true" />
                    </Items>
                </telerik:RadDropDownList>
                <asp:LinkButton ID="ApplyProfile" runat="server"
                    Text="Apply" CssClass="btn btn-sm fw-bold btn-secondary"
                    CausesValidation="False" OnClick="ApplyProfile_Click"
                    style="margin-left: 10px; height: 30px; padding: 5px 10px; line-height: 20px;" />
            </div>
        </div>
        <div class="col-lg-6 text-end">
            <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                <asp:LinkButton ID="btnDone" runat="server" CssClass="btn btn-sm fw-bold btn-success" Width="100px" ValidationGroup="addcus" OnClick="btnDone_Click1" CausesValidation="true">Save</asp:LinkButton>
            </telerik:RadAjaxPanel>
        </div>
    </div>

    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</div>--%>




                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                                        <!--Begin::Basic Info -->

                                        <div class="col-lg-12 fw-bold fs-3 mt-5">Basic Info    </div>

                                        <div class="col-lg-12 row pt-2">


                                          <div class="col-lg-4 form-group pt-2">
    <label class="control-label col-lg-12">Code <span class="required"></span></label>
    <div class="col-lg-12">
        <telerik:RadTextBox ID="txtCode" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%" OnTextChanged="txtCode_TextChanged" AutoPostBack="true" Skin="Silk"></telerik:RadTextBox>
        <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="addcus"
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
        <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="addcus"
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
                                                    <telerik:RadDropDownList ID="ddlStatuses" runat="server" RenderMode="Lightweight" Width="100%" DefaultMessage="Please Select">
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

                                        <div class="col-lg-12 fw-bold fs-3 pt-6">Categorization  </div>

                                        <div class="col-lg-12 row mb-4">

                                            <div class="col-lg-4 form-group pt-4">
                                                <label class="control-label col-lg-12">Class<span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox ID="ddlcls" runat="server" RenderMode="Lightweight" CausesValidation="true" Width="100%" Filter="Contains"
                                                        EmptyMessage="Select Class">
                                                    </telerik:RadComboBox>
                                                    <br />
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator12" runat="server" Display="Dynamic" ValidationGroup="addcus"
                                                        ControlToValidate="ddlcls" ErrorMessage="Please select Class" ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>


                                            <div class="col-lg-4 form-group pt-4">
                                                <label class="control-label col-lg-12">Customer Type <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                 <telerik:RadDropDownList ID="ddlcustype" runat="server" Width="100%"  OnSelectedIndexChanged="ddlcustype_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                            <Items>
                                                <telerik:DropDownListItem Text="Normal" Value="NC"  />
                                                <telerik:DropDownListItem Text="Branch" Value="BR" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                                    <br />
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="addcus"
                                                        ControlToValidate="ddlcustype" ErrorMessage="Please Select Customer Type " ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>


                                            <div class="col-lg-4 form-group pt-4">
                                                <label class="control-label col-lg-12">TRN Number</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadTextBox ID="txtTRN" runat="server" RenderMode="Lightweight" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                    <br />
                                                     <br />

                                                    
                                                    <asp:Label ID="lblTRN" Style="font-family: 'Segoe UI'; color: red;" runat="server" visible="false"></asp:Label>
                                                    
                                                
                                                </div>
                                            </div>

                                            <asp:PlaceHolder runat="server" ID="pnlCusHead"  Visible="false">
                                                <div class="col-lg-4 form-group pt-4">
                                                    <label class="control-label col-lg-12">Customer Header <span class="required"></span> </label>
                                                    <div class="col-lg-12">
                                                        <telerik:RadComboBox ID="ddlCusHeader" runat="server" Width="100%" RenderMode="Lightweight" EmptyMessage="Select Customer Header" Filter="Contains">
                                                        </telerik:RadComboBox>
                                                        <br/>

                                                           <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator70" runat="server" Display="Dynamic" ValidationGroup="addcus"
                                                        ControlToValidate="ddlCusHeader" ErrorMessage="Please Select Customer Header " ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>


                                                    </div>
                                                </div>
                                            </asp:PlaceHolder>

                                            <div class="col-lg-4 form-group pt-4">
                                                <label class="control-label col-lg-12">Area <span class="required"></span></label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox ID="ddlarea" runat="server" RenderMode="Lightweight" CausesValidation="true" Width="100%" Filter="Contains"
                                                        EmptyMessage="Select Area">
                                                    </telerik:RadComboBox>
                                                    <br />
                                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="addcus"
                                                        ControlToValidate="ddlarea" ErrorMessage="Please select Area" ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                </div>





                                            </div>
                                                                                        <asp:PlaceHolder runat="server" ID="closecustomer"  Visible="false">

                                              <div class="col-lg-4 pt-4 mt-5">
                              <label class="control-label col-lg-12">Close Customer </label>
                              <div class="col-lg-12">
                                  <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblStatus_SelectedIndexChanged" AutoPostBack="true">                                    
                                          <asp:ListItem Text="Close" Value="Y" style="margin-right: 10px;"></asp:ListItem>
                                      </asp:RadioButtonList>                               
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator71" runat="server" ValidationGroup="form"
                                      ControlToValidate="rblStatus" ErrorMessage="Please select Status" ForeColor="Red" Display="Dynamic"
                                      CausesValidation="false" SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                              </div>
                          </div>
                                                                                            </asp:PlaceHolder>



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
        </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel21" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
                          
                                </telerik:RadWizardStep>



                              <telerik:RadWizardStep Title="Routes" runat="server" ID="ListRoute" OnLoad="ListRoute_Load" Selected="true" SpriteCssClass="accountInfo" >

                                      <telerik:RadAjaxPanel ID="RadAjaxPanel20" runat="server" LoadingPanelID="RadAjaxLoadingPanel21">

                                 <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <!--begin::Portlet-->
                                                <div class="kt-portlet" style="background-color: white; padding: 20px;">

                                                    <div class="kt-portlet__body">

                                                        <div class="kt-portlet__body pb-3">

                                                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar1" runat="server" Expanded="false">
                                                                <Items>
                                                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                                                        <ContentTemplate>
                                                                            <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px; padding-top: 10px; padding-bottom: 10px;">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer Code :</label>

                                                                                                <asp:Label ID="Label1" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer :</label>

                                                                                                <asp:Label ID="lblcustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>

                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </telerik:RadPanelItem>
                                                                </Items>
                                                            </telerik:RadPanelBar>

                                                        </div>
                                                    </div>


                                                    <div class="col-lg-12 form-group pt-4">
                                                        <telerik:RadAjaxPanel ID="RadAjaxPanel9" runat="server" LoadingPanelID="RadAjaxLoadingPanel9">

                                                            <div class="col-lg-12 text-end mb-2">
                                                                <asp:LinkButton ID="Add" runat="server" CssClass="btn btn-sm fw-bold btn-success"  OnClick="Add_Click" CausesValidation="false">Add</asp:LinkButton>
                                                            </div>
                                                        </telerik:RadAjaxPanel>
                                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
                                                            BackColor="Transparent"
                                                            ForeColor="Blue">
                                                            <div class="col-lg-12 text-center mt-5">
                                                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                                            </div>
                                                        </telerik:RadAjaxLoadingPanel>
                                                    </div>



                                                    <!--end: Search Form -->
                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvRpt" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvRpt_NeedDataSource"
                                                                OnItemCommand="grvRpt_ItemCommand"
                                                                AllowFilteringByColumn="true" 
                                                                Skin="Material"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="rot_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Edits">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton CommandName="Edits" ID="Edits" Visible="true" AlternateText="Edits" runat="server" CausesValidation="false"
                                                                                    ImageUrl="../assets/media/svg/general/edit.svg"></asp:ImageButton>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="rot_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route ID" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rot_ID" Display="false">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="rcs_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="rcs ID" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_ID" Display="false">
                                                                        </telerik:GridBoundColumn>


                                                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Route " FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="rot_ArabicName" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Arabic Name" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rot_ArabicName" Display="false">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="PaymentTerms" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Payment Terms" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="PaymentTerms">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="rcs_PaymentModes" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Payment Mode" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_PaymentModes">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="rcs_TotalCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Credit Limit" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_TotalCreditLimit">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="rcs_GraceAmount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Grace Amount" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_GraceAmount">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedBy" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Created By" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedBy">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Modified Date" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Modified By" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Status">
                                                                        </telerik:GridBoundColumn>





                                                                    </Columns>
                                                                </MasterTableView>
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </telerik:RadAjaxPanel>
                                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
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
   </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel22" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>

                            </telerik:RadWizardStep>

                            <telerik:RadWizardStep Title="Route Mapping" runat="server"   OnLoad="Unnamed_Load" ID="Routemapping">

                                                                      <telerik:RadAjaxPanel ID="RadAjaxPanel21" runat="server" LoadingPanelID="RadAjaxLoadingPanel23">

                
                                    <div class="kt-portlet">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <!--begin::Portlet-->
                                                <div class="kt-portlet" style="background-color: white; padding: 20px;">
                                                    <div class="kt-portlet__body">
                                                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                            <%--<div class="col-lg-4 form-group">--%>
                                                            <%--<label class="control-label col-lg-12">Route <span class="required">* </span></label>--%>
                                                            <%--<div class="col-lg-12">--%>
                                                            <telerik:RadComboBox ID="ddlroute" runat="server" EmptyMessage="Select Route" CausesValidation="false" Visible="false" Width="100%" Filter="Contains" AutoPostBack="true"></telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                                                ControlToValidate="ddlroute" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic"
                                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                            <%--</div>--%>
                                                            <%--</div>--%>

                                                          <div class="kt-portlet__body">

                                                        <div class="kt-portlet__body pb-3">

                                                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar2" runat="server" Expanded="false">
                                                                <Items>
                                                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                                                        <ContentTemplate>
                                                                            <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px; padding-top: 10px; padding-bottom: 10px;">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer Code :</label>

                                                                                                <asp:Label ID="lblCusCode" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer :</label>

                                                                                                <asp:Label ID="lblCusName" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>

                                                                                          <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Route Type :</label>

                                                                                                <asp:Label ID="RotType" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>

                                                                                          <td>
                                                                                               <div class="col-lg-12 form-group ">
                                                                <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">

                                                                    <div class="col-lg-12 text-end ">
                                                                        <asp:LinkButton ID="RouCuSave" runat="server" CssClass="btn btn-sm fw-bold btn-success" Width="100px" ValidationGroup="RotMap" OnClick="RouCuSave_Click" CausesValidation="true">Save</asp:LinkButton>
                                                                    </div>
                                                                </telerik:RadAjaxPanel>
                                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
                                                                    BackColor="Transparent"
                                                                    ForeColor="Blue">
                                                                    <div class="col-lg-12 text-center mt-5">
                                                                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                                                    </div>
                                                                </telerik:RadAjaxLoadingPanel>
                                                            </div>
                                                                                        </td>

                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </telerik:RadPanelItem>
                                                                </Items>
                                                            </telerik:RadPanelBar>

                                                        </div>
                                                    </div>

                                                                                             
        <h9 style="margin-top: 0;">Settings Profile</h9>
        <div style="display: flex; align-items: center;">
            <telerik:RadDropDownList ID="RadDropDownList2" runat="server"  CausesValidation="false" Width="200px" Filter="Contains">
                <Items>
                   <telerik:DropDownListItem Text="Select Profile" Value="0" Selected="true"/>
               </Items>
            </telerik:RadDropDownList>
            <asp:LinkButton ID="ApplyProfileRoute" runat="server"
                Text="Apply" CssClass="btn btn-sm fw-bold btn-secondary"
                CausesValidation="false" OnClick="ApplyProfileRoute_Click" ValidationGroup="RotMap"
                style="margin-left: 10px; height: 30px; padding: 5px 10px; line-height: 20px;" />
        </div>
   



                                                           


                                                            <div class="col-lg-12 mt-5 row"><b>Credit Terms </b></div>
                                                            <br />
                                                            <asp:PlaceHolder ID="search" runat="server" Visible="false">
                                                                <div class="col-lg-12 row">

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Enter Customer Code or Name to Populate Customer <span class="required"></span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadTextBox ID="SearchTextBox" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadTextBox>



                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-4" style="padding-top: 15px; margin-left: 15px;">
                                                                        <asp:LinkButton ID="lnkSearch" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" CausesValidation="false" OnClick="lnkSearch_Click">
                                                    Search
                                                                        </asp:LinkButton>
                                                                    </div>



                                                                </div>
                                                            </asp:PlaceHolder>

                                                         

                                                            <div class="col-lg-12 row">



                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Route <span class="required"></span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadComboBox ID="ddlrot" runat="server" Width="100%" EmptyMessage="Select Route" Filter="Contains" AllowCustomText="true" OnSelectedIndexChanged="ddlrot_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false"></telerik:RadComboBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddlrot" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                                    </div>
                                                                </div>



                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Payment Terms<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddcusType" runat="server" Width="100%" DefaultMessage="Select Customer Type" CausesValidation="false" OnSelectedIndexChanged="ddcusType_SelectedIndexChanged" AutoPostBack="true">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="CASH" Value="CS" />
                                                                                <telerik:DropDownListItem Text="CREDIT" Value="CR" />
                                                                                <telerik:DropDownListItem Text="TEMPORARY CREDIT" Value="TC" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddcusType" ErrorMessage="Please select Customer Type" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <asp:PlaceHolder runat="server" ID="Paymodes" Visible="true">
                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Payment Mode<span class="required"></span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadComboBox ID="ddlpaymode" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" CausesValidation="false" EmptyMessage="Select Payment Modes">
                                                                            </telerik:RadComboBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" Display="Dynamic"
                                                                                ControlToValidate="ddlpaymode" ErrorMessage="Please Select Payment Modes" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                </asp:PlaceHolder>
                                                                <asp:PlaceHolder runat="server" ID="Custype">



                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-6">Total Credit Limit <span class="required"></span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadNumericTextBox ID="txtTCL" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" Display="Dynamic" ValidationGroup ="RotMap"
                                                                                ControlToValidate="txtTCL" ErrorMessage="Please Enter Total Credit Limit" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-6">Grace Amount <span class="required"></span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadNumericTextBox ID="txtGraceamount" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="txtGraceamount" ErrorMessage="Please Enter Grace Amount" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-6">Credit Days <span class="required"></span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadNumericTextBox ID="txtCDays" runat="server" CssClass="form-control" Width="100%" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="txtCDays" ErrorMessage="Please Enter Credit Days" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-6">Grace Period <span class="required"></span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadNumericTextBox ID="txtGracePeriod" runat="server" CssClass="form-control" Width="100%" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator32" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="txtGracePeriod" ErrorMessage="Please Enter Grace Period" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Allow Cash For Credit Customers<span class="required"></span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddPT" runat="server" Width="100%" OnSelectedIndexChanged="ddPT_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true" DefaultMessage="Please Select">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="ddPT" ErrorMessage="Please select Allow Cash For Credit Customers" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <asp:PlaceHolder ID="noofinvoice" runat="server">
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-6">No of Invoice</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadNumericTextBox ID="txtnoInvoice" runat="server" CssClass="form-control" Width="100%" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                                                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" Display="Dynamic" ValidationGroup="form"
                                                ControlToValidate="txtnoInvoice" ErrorMessage="Please Enter No of Invoice" ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>
                                                                </asp:PlaceHolder>



                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">VAT<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddIsVAT" runat="server" Width="100%" DefaultMessage="Please select">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddIsVAT" ErrorMessage="Please select VAT" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Hold<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlIsHold" runat="server" Width="100%" DefaultMessage="Please select">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddlIsHold" ErrorMessage="Please select Hold" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-6">ERP Customer Location </label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadTextBox ID="txtCusLocation" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>

                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator48" runat="server" Display="Dynamic"
                                                                            ControlToValidate="txtCDays" ErrorMessage="Please Enter ERP Customer Location" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Status<span class="required"></span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlstatus" runat="server" Width="100%">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Active" Value="Y" />
                                                                                <telerik:DropDownListItem Text="Inactive" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                            ControlToValidate="ddlstatus" ErrorMessage="Please select Status" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>



                                                            </div>

                                                            <br />
                                                            <div class="col-lg-12 row"><b>General Settings </b></div>
                                                            <br />
                                                            <div class="col-lg-12 row">

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Selection Type<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddltype" runat="server" Width="100%" DefaultMessage="Select Selection Type" OnSelectedIndexChanged="ddltype_SelectedIndexChanged" CausesValidation="false" ValidationGroup="form2" AutoPostBack="true">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Geocode" Value="G" />
                                                                                <telerik:DropDownListItem Text="Barcode" Value="B" />
                                                                                <telerik:DropDownListItem Text="Manual" Value="M" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator30" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddltype" ErrorMessage="Please select Selection Type" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <asp:PlaceHolder ID="pnlFencing" runat="server" Visible="true">
                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Fencing Radius (In meters)<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadNumericTextBox MinValue="20" ID="txtradius" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadNumericTextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" ValidationGroup="RotMap"
                                                                                ControlToValidate="txtradius" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Fencing Radius"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                </asp:PlaceHolder>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">On Call Features</label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadComboBox ID="ddloncal" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select On Call Features">
                                                                            <Items>

                                                                                <telerik:RadComboBoxItem Text="AR Collection" Value="AR" />
                                                                                <telerik:RadComboBoxItem Text="Advance Collection" Value="AP" />
                                                                                <telerik:RadComboBoxItem Text="Order Request" Value="OR" />
                                                                            </Items>
                                                                        </telerik:RadComboBox>
                                                                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddloncal" ErrorMessage="Please select On Call Features" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Transaction Type<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddcatType" runat="server" Width="100%" DefaultMessage="Please select" OnSelectedIndexChanged="ddcatType_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Order Based Delivery " Value="ODC" />
                                                                                <telerik:DropDownListItem Text="Direct Invocing" Value="NC" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddcatType" ErrorMessage="Please select category type" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>


                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Enforce Customer Selection<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlenforcecussel" runat="server" Width="100%" DefaultMessage="Please Select">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddlenforcecussel" ErrorMessage="Please select " ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Enable Insight<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlEnableInsight" runat="server" Width="100%" CausesValidation="false">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="false"
                                                                            ControlToValidate="ddlFS" ErrorMessage="Please select" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Void Enable<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddVoidEnable" runat="server" Width="100%">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                            ControlToValidate="ddVoidEnable" ErrorMessage="Please select Void Enable" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Void Enable Cus Insight<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddVoidEnableCusInsight" runat="server" Width="100%">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator53" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                            ControlToValidate="ddVoidEnableCusInsight" ErrorMessage="Please select Void Enable for Customer Insight" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Round Amount<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddRoundAmount" runat="server" Width="100%">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                            ControlToValidate="ddRoundAmount" ErrorMessage="Please select Round Amount" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Must Sell Item Count</label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadNumericTextBox ID="MustSellItmCnt" runat="server" CssClass="form-control" Width="100%"
                                                                            Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                                                        </telerik:RadNumericTextBox>

                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Profile Settings</label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadComboBox ID="CusProfile" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Profile Settings">
                                                                            <Items>
                                                                                <telerik:RadComboBoxItem Text="Customer Documents" Value="CDS" />
                                                                                <telerik:RadComboBoxItem Text="Promotion" Value="PRM" />
                                                                                <telerik:RadComboBoxItem Text="Special Pricing" Value="SPR" />
                                                                                <telerik:RadComboBoxItem Text="Customer Itemlist" Value="CIM" />
                                                                                <telerik:RadComboBoxItem Text="GeoCode" Value="GCD" />
                                                                                <telerik:RadComboBoxItem Text="PaymentTerms" Value="PTH" />
                                                                                <telerik:RadComboBoxItem Text="Payterms Details" Value="PTD" />

                                                                            </Items>
                                                                        </telerik:RadComboBox>

                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Partial Delivery Approval<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlEnablePD" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Enable" Value="Y"  Selected="true"/>
                                                                                <telerik:DropDownListItem Text="Disable" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddlEnablePD" ErrorMessage="Please select" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Enable Trade License Expiry Alert<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlCusDocExpiryAlert" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>

                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Alert Days</label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadNumericTextBox ID="txtAlertDay" runat="server" CssClass="form-control" Width="100%"
                                                                            Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                                                        </telerik:RadNumericTextBox>

                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Enable Price Change<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlISPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Enable" Value="Y" Selected="true" />
                                                                                <telerik:DropDownListItem Text="Disable" Value="N" />

                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator47" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                            ControlToValidate="ddlISPriceChange" ErrorMessage="Please select" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Minimum Order Value</label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadNumericTextBox ID="rdMinOrderValue" runat="server" CssClass="form-control" Width="100%"
                                                                            Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                                                        </telerik:RadNumericTextBox>

                                                                    </div>
                                                                </div>


                                                                

                                                                <div class="col-lg-4 form-group mb-4" >
                                                                    <label class="control-label col-lg-12">Product Group<span class="required"></span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadComboBox ID="ddlproductgroup" runat="server" Width="100%" Skin="Silk" Filter="Contains" OnSelectedIndexChanged="ddlproductgroup_SelectedIndexChanged" AutoPostBack="true" EmptyMessage="Select Table" RenderMode="Lightweight"></telerik:RadComboBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator55" runat="server" ValidationGroup="RotMap"
                                                                            ControlToValidate="ddlproductgroup" ErrorMessage="Please Product Group" ForeColor="Red" Display="Dynamic"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                                    </div>
                                                                </div>

                                                                  <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                    <label class="control-label col-lg-12">Enforce Buy Back free<span class="required"> </span></label>
                                                                    <div class="col-lg-12">
                                                                        <telerik:RadDropDownList ID="ddlEnforceBuyBackfree" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false" >
                                                                            <Items>
                                                                                <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                <telerik:DropDownListItem Text="Disable" Value="N" />
                                                                            </Items>
                                                                        </telerik:RadDropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator72" runat="server" Display="Dynamic" ValidationGroup="form"
                                                                            ControlToValidate="ddlEnforceBuyBackfree" ErrorMessage="Please select" ForeColor="Red"
                                                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                </div>
                                                                <div class="col-lg-12 row" style="padding-top: 25px;"><b>Transactional Settings </b></div>
                                                                <br />

                                                                <asp:PlaceHolder ID="plsSalesorder" runat="server" Visible="false">
                                                                    <div class="col-lg-12 row">

                                                                        <span class="min-w-50px fw-semibold text-gray-600  "><b>Order</b></span>


                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Sales Order<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddIsSOrder" runat="server" Width="100%" DefaultMessage="Please select">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddIsSOrder" ErrorMessage="Please select Sales Order" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Sales Order Remarks<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddORR" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator54" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddORR" ErrorMessage="Please select Order Request Remarks" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Sales Order Promotion<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlordpro" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator56" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddlordpro" ErrorMessage="Please select Promotion in Order" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>


                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Enable Order Sign</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlenableOrdrsign" runat="server" Width="100%" DefaultMessage="Please Select">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>

                                                                            </div>
                                                                        </div>


                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Price Change Approval in Order<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlOrdPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="Disable" Value="N" />

                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator33" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddlOrdPriceChange" ErrorMessage="Please select" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Enable Quotation<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlEnableQuotation" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>

                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Enable Suggested Ord<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlEnableSuggestedOrd" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>

                                                                            </div>
                                                                        </div>

                                                                    </div>

                                                                </asp:PlaceHolder>

                                                                <div class="col-lg-12 row mt-4">

                                                                    <span class="min-w-50px fw-semibold text-gray-800 "><b>Invoice</b></span>


                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Sales Job<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlIsInvoicing" runat="server" Width="100%" DefaultMessage="Please select" OnSelectedIndexChanged="ddlIsInvoicing_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                ControlToValidate="ddlIsInvoicing" ErrorMessage="Please select Invoicing" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <asp:PlaceHolder runat="server" ID="inv">
                                                                        <asp:PlaceHolder ID="pnlSalesInv" runat="server" Visible="true">
                                                                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                                <label class="control-label col-lg-12">Sales Invoicing<span class="required"></span></label>
                                                                                <div class="col-lg-12">
                                                                                    <telerik:RadDropDownList ID="ddIsI_Sales" runat="server" Width="100%" DefaultMessage="Select Sales Invoicing" Enabled="false">
                                                                                        <Items>
                                                                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                            <telerik:DropDownListItem Text="No" Value="N" />
                                                                                        </Items>
                                                                                    </telerik:RadDropDownList>
                                                                                    <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddIsI_Sales" ErrorMessage="Please select Sales Invoicing" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                                                                </div>
                                                                            </div>
                                                                        </asp:PlaceHolder>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Good Return Invoicing<span class="required"></span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddIsI_GR" runat="server" Width="100%" DefaultMessage="Select Good Return Invoicing">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic"
                                                                                    ControlToValidate="ddIsI_GR" ErrorMessage="Please select Good Return Invoicing" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Bad Return Invoicing<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddIsI_BR" runat="server" Width="100%" DefaultMessage="Select Bad Return Invoicing">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" Display="Dynamic"
                                                                                    ControlToValidate="ddIsI_BR" ErrorMessage="Please select Bad Return Invoicing" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Free of Cost Invoicing<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddIsI_FG" runat="server" Width="100%" DefaultMessage="Select Free of Cost Invoicing">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" Display="Dynamic"
                                                                                    ControlToValidate="ddIsI_FG" ErrorMessage="Please select Free of Cost Invoicing" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>


                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Alternative Invoice Required<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="rdAltInvReq" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" Display="Dynamic" ValidationGroup="form"
                                                                                    ControlToValidate="rdAltInvReq" ErrorMessage="Please select " ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                     <div class="col-lg-4 form-group" style="padding-top: 10px;">
      <label class="control-label col-lg-12">Invoice Payment Mode<span class="required"> </span></label>
      <div class="col-lg-12">
          <telerik:RadDropDownList ID="ddlInvoiceMode" runat="server" Width="100%" DefaultMessage="Please Select">
              <Items>
                   <telerik:DropDownListItem Text="Single" Value="S" />
                    <telerik:DropDownListItem Text="Multiple" Value="M" />
                     <telerik:DropDownListItem Text="Single Free Good" Value="SF" />
              </Items>
          </telerik:RadDropDownList>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" Display="Dynamic" ValidationGroup="form"
              ControlToValidate="ddlInvoiceMode" ErrorMessage="Please select " ForeColor="Red"
              SetFocusOnError="True"></asp:RequiredFieldValidator>
      </div>
  </div>



                                                                    </asp:PlaceHolder>
                                                                    <asp:PlaceHolder ID="pnlSalesJob" runat="server" Visible="true">
                                                                        <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                                                                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                                <label class="control-label col-lg-12">Signature Invoice<span class="required"> </span></label>
                                                                                <div class="col-lg-12">
                                                                                    <telerik:RadDropDownList ID="ddlSI" runat="server" Width="100%">
                                                                                        <Items>
                                                                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                                                        </Items>
                                                                                    </telerik:RadDropDownList>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator50" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                        ControlToValidate="ddlSI" ErrorMessage="Please select Signature Invoice" ForeColor="Red"
                                                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                                </div>
                                                                            </div>
                                                                        </asp:PlaceHolder>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Invoice Remarks<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddRe" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator51" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddRe" ErrorMessage="Please select Invoice Remarks" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Enable Sales Sign</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlEnablesalsign" runat="server" Width="100%" DefaultMessage="Please Select">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>

                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Free Good Exemption<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlFGExemption" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator58" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddlFGExemption" ErrorMessage="Please select Free Good Exemption" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Minimum Invoice Value<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadNumericTextBox ID="MinInvoiceVal" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                    ControlToValidate="ddlFGsep" ErrorMessage="Please enter a value" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>

                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">FG Seperate<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlFGsep" runat="server" Width="100%" DefaultMessage="Please select" CausesValidation="true" AutoPostBack="true">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                    ControlToValidate="ddlFGsep" ErrorMessage="Please select FG Seperate" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Disable Negative Invoice Amount</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlnegativeInvAmt" runat="server" Width="100%" DefaultMessage="Please Select">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>

                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Price Change Approval in Invoice<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddlPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="Disable" Value="N" />

                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator36" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                    ControlToValidate="ddlPriceChange" ErrorMessage="Please select" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">e-Invoice Send<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddleInvoice" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />

                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator37" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                    ControlToValidate="ddleInvoice" ErrorMessage="Please select" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">HC Receipt Image Mandatory<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="HCimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="None" Value="0" />
                                                                                        <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                                                        <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator38" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                    ControlToValidate="HCimgMand" ErrorMessage="Please select" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">POS Receipt Image Mandatory<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="POSimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="None" Value="0" />
                                                                                        <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                                                        <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator39" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                    ControlToValidate="POSimgMand" ErrorMessage="Please select" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">OP Receipt Image Mandatory<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="OPimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="None" Value="0" />
                                                                                        <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                                                        <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator40" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                    ControlToValidate="OPimgMand" ErrorMessage="Please select" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">GR Settings</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="rdGRSettings" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select GR Settings">
                                                                                    <Items>

                                                                                        <telerik:RadComboBoxItem Text="Open" Value="OP" />
                                                                                        <telerik:RadComboBoxItem Text="Restricted" Value="RE" />
                                                                                        <telerik:RadComboBoxItem Text="Scheduled" Value="SC" />


                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">BR Settings</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="rdBRSettings" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select BR Settings">
                                                                                    <Items>

                                                                                        <telerik:RadComboBoxItem Text="Open" Value="OP" />
                                                                                        <telerik:RadComboBoxItem Text="Restricted" Value="RE" />
                                                                                        <telerik:RadComboBoxItem Text="Scheduled" Value="SC" />


                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                            </div>
                                                                        </div>

                                                                    </asp:PlaceHolder>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Enable Forecast Sales<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlEnableForecastSales" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>

                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Enable Recent Sales<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlRecentSale" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Enable Recent Orders<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlRecentOder" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Enable" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="Disable" Value="N" Selected="true" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>

                                                                        </div>
                                                                    </div>


                                                                      <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                 <label class="control-label col-lg-12">Price Change Approval in Delivery <span class="required"> </span></label>
                                 <div class="col-lg-12">
                                     <telerik:RadDropDownList ID="ddlDelPriceChange" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="false" >
                                         <Items>
                                             <telerik:DropDownListItem Text="Enable" Value="Y" />
                                             <telerik:DropDownListItem Text="Disable" Value="N"  Selected="true"/>
                                         </Items>
                                     </telerik:RadDropDownList>
                                    
                                 </div>
                             </div>


                                                                </div>


                                                                <div class="col-lg-12 row">

                                                                    <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Account Receivables</b></span>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Account Receivables<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlIsAR" runat="server" Width="100%" OnSelectedIndexChanged="ddlIsAR_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false" DefaultMessage="Please Select">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator41" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="ddlIsAR" ErrorMessage="Please select Account Receivables" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <asp:PlaceHolder ID="pnlAR" runat="server" Visible="true">
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Signature AR<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddSAR" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator52" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddSAR" ErrorMessage="Please select Signature AR" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">AR Remarks<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="ddARRemarks" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator49" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddARRemarks" ErrorMessage="Please select  AR Remarks" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>


                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">AR Manual Allocation<span class="required"> </span></label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadDropDownList ID="IsArManAllocation" runat="server" Width="100%">
                                                                                    <Items>
                                                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                                                    </Items>
                                                                                </telerik:RadDropDownList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator42" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                    ControlToValidate="ddORR" ErrorMessage="Please select Order Request Remarks" ForeColor="Red"
                                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">HC Receipt Image Mandatory<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ARHCingmand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="None" Value="0" />
                                                                                    <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                                                    <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator43" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="ARHCingmand" ErrorMessage="Please select" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">POS Receipt Image Mandatory<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ARPOSimgMnad" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="None" Value="0" />
                                                                                    <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                                                    <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator44" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="ARPOSimgMnad" ErrorMessage="Please select" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">OP Receipt Image Mandatory<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="AROPimgMand" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="None" Value="0" />
                                                                                    <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                                                    <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator45" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="AROPimgMand" ErrorMessage="Please select" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">CH Receipt Image Mandatory<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ARCHimgMnad" runat="server" DefaultMessage="Please Select" Width="100%" CausesValidation="true">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="None" Value="0" />
                                                                                    <telerik:DropDownListItem Text="Image 1" Value="1" />
                                                                                    <telerik:DropDownListItem Text="Image 1 and 2" Value="2" />


                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator46" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="ARCHimgMnad" ErrorMessage="Please select" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>


                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">AR Payment Modes</label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadComboBox ID="rdARPayMode" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select AR Payment">
                                                                                <Items>
                                                                                    <telerik:RadComboBoxItem Text="Hard Cash" Value="HC" />
                                                                                    <telerik:RadComboBoxItem Text="POS" Value="POS" />
                                                                                    <telerik:RadComboBoxItem Text="Online Payment" Value="OP" />

                                                                                </Items>
                                                                            </telerik:RadComboBox>

                                                                        </div>
                                                                    </div>



                                                                </div>


                                                                <div class="col-lg-12 row">

                                                                    <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Advance Payment</b></span>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Advance Payment<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddladvpay" runat="server" Width="100%" DefaultMessage="Please Select">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator57" runat="server" Display="Dynamic" ValidationGroup="RotMap"
                                                                                ControlToValidate="ddladvpay" ErrorMessage="Please select Advance Payment" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 row">

                                                                    <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Inventory Monitoring</b></span>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Inventory Monitoring<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddIsMerchand" runat="server" Width="100%" OnSelectedIndexChanged="ddIsMerchand_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator59" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                ControlToValidate="ddIsMerchand" ErrorMessage="Please select Inventory Monitoring" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>


                                                                    <asp:PlaceHolder ID="pnlMandFeat" runat="server" Visible="true">
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Inventory Monitoring Features</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="ddlMandColumns" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Inventory Monitoring Feature">
                                                                                    <Items>

                                                                                        <telerik:RadComboBoxItem Text="Out Of Stock" Value="OOS" />
                                                                                        <telerik:RadComboBoxItem Text="Item Availability" Value="ITA" />
                                                                                        <telerik:RadComboBoxItem Text="Item Pricing" Value="ITP" />
                                                                                        <telerik:RadComboBoxItem Text="Customer Inventory" Value="CUI" />


                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlMandColumns" ErrorMessage="  Please  select Merchandising Features" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Mandatory Features</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="ddlmandfeatures" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select MandotoryFeature">
                                                                                    <Items>

                                                                                        <telerik:RadComboBoxItem Text="Out Of Stock" Value="OOS" />
                                                                                        <telerik:RadComboBoxItem Text="Item Availability" Value="ITA" />
                                                                                        <telerik:RadComboBoxItem Text="Item Pricing" Value="ITP" />
                                                                                        <telerik:RadComboBoxItem Text="Customer Inventory" Value="CUI" />

                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlMandColumns" ErrorMessage="  Please  select Mandatory Columns" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                                                            </div>
                                                                        </div>



                                                                    </asp:PlaceHolder>

                                                                </div>
                                                                <div class="col-lg-12 row">
                                                                    <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Activity Management</b></span>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Activity Management<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlIsActManage" runat="server" Width="100%" OnSelectedIndexChanged="ddlIsActManage_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator60" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                ControlToValidate="ddlIsActManage" ErrorMessage="Please select Activity Management" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <asp:PlaceHolder ID="pnlActmanage" runat="server" Visible="true">
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Activity Management Features</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="ddlActManage" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Activity Management Feature">
                                                                                    <Items>
                                                                                        <telerik:RadComboBoxItem Text="Competitor  Activities" Value="COA" />
                                                                                        <telerik:RadComboBoxItem Text="Survey" Value="SUY" />
                                                                                        <telerik:RadComboBoxItem Text="Display Agreements" Value="DIA" />
                                                                                        <telerik:RadComboBoxItem Text="Task" Value="TAS" />
                                                                                        <telerik:RadComboBoxItem Text="Image Capture" Value="IMC" />
                                                                                        <telerik:RadComboBoxItem Text="Customer Activity" Value="CUA" />

                                                                                    </Items>
                                                                                </telerik:RadComboBox>

                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Mandotory Features</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="ddlAMMand" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select mandotory Features">
                                                                                    <Items>
                                                                                        <telerik:RadComboBoxItem Text="Competitor  Activities" Value="COA" />
                                                                                        <telerik:RadComboBoxItem Text="Survey" Value="SUY" />
                                                                                        <telerik:RadComboBoxItem Text="Display Agreements" Value="DIA" />
                                                                                        <telerik:RadComboBoxItem Text="Task" Value="TAS" />
                                                                                        <telerik:RadComboBoxItem Text="Image Capture" Value="IMC" />
                                                                                        <telerik:RadComboBoxItem Text="Customer Activity" Value="CUA" />

                                                                                    </Items>
                                                                                </telerik:RadComboBox>

                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>

                                                                </div>
                                                                <div class="col-lg-12 row">
                                                                    <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Customer Service</b></span>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">Customer Service<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlISCusService" runat="server" Width="100%" OnSelectedIndexChanged="ddlISCusService_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator61" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                ControlToValidate="ddlIsActManage" ErrorMessage="Please select Customer Service" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <asp:PlaceHolder ID="pnlCusService" runat="server" Visible="true">
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Customer Service Features</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="ddlCusService" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Customer Service Feature">
                                                                                    <Items>
                                                                                        <telerik:RadComboBoxItem Text="Customer Complaints" Value="CUC" />
                                                                                        <telerik:RadComboBoxItem Text="Customer Request" Value="CUR" />
                                                                                        <telerik:RadComboBoxItem Text="Credit Note Request" Value="CNR" />
                                                                                        <telerik:RadComboBoxItem Text="Dispute Note Request" Value="DIS" />
                                                                                        <telerik:RadComboBoxItem Text="Scheduled Return Request" Value="SRR" />

                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Mandotory Features</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="ddlCSMand" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Mandotory Feature">
                                                                                    <Items>
                                                                                        <telerik:RadComboBoxItem Text="Customer Complaints" Value="CUC" />
                                                                                        <telerik:RadComboBoxItem Text="Customer Request" Value="CUR" />
                                                                                        <telerik:RadComboBoxItem Text="Credit Note Request" Value="CNR" />
                                                                                        <telerik:RadComboBoxItem Text="Dispute Note Request" Value="DIS" />
                                                                                        <telerik:RadComboBoxItem Text="Scheduled Return Request" Value="SRR" />

                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>
                                                                </div>
                                                                <div class="col-lg-12 row">

                                                                    <span class="min-w-50px fw-semibold text-gray-800 pt-8 "><b>Field Service</b></span>

                                                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                        <label class="control-label col-lg-12">IsFieldService<span class="required"> </span></label>
                                                                        <div class="col-lg-12">
                                                                            <telerik:RadDropDownList ID="ddlFS" runat="server" Width="100%" OnSelectedIndexChanged="ddlFS_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                                                                                <Items>
                                                                                    <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                                                    <telerik:DropDownListItem Text="No" Value="N" />
                                                                                </Items>
                                                                            </telerik:RadDropDownList>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator62" runat="server" Display="Dynamic" ValidationGroup="form2"
                                                                                ControlToValidate="ddlFS" ErrorMessage="Please Select" ForeColor="Red"
                                                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <asp:PlaceHolder ID="pnlFS" runat="server" Visible="false">
                                                                        <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                                                            <label class="control-label col-lg-12">Field Service Features</label>
                                                                            <div class="col-lg-12">
                                                                                <telerik:RadComboBox ID="ddlFSFeatures" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Field Service Feature">
                                                                                    <Items>
                                                                                        <telerik:RadComboBoxItem Text="Asset Tracking" Value="AT" />
                                                                                        <telerik:RadComboBoxItem Text="Service Request" Value="SR" />
                                                                                        <telerik:RadComboBoxItem Text="Service Job" Value="SJ" />


                                                                                    </Items>
                                                                                </telerik:RadComboBox>
                                                                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlMandColumns" ErrorMessage="  Please  select Merchandising Features" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>
                                                                </div>




                                                                <br />
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


                              
</telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel23" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>


                            </telerik:RadWizardStep>
                            
                           

                            <telerik:RadWizardStep Title="Special Pricing" ID="splprice" Selected="true" OnLoad="splprice_Load">

                                                                      <telerik:RadAjaxPanel ID="RadAjaxPanel22" runat="server" LoadingPanelID="RadAjaxLoadingPanel24">

                                                                 <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <!--begin::Portlet-->
                                                <div class="kt-portlet" style="background-color: white; padding: 20px;">

                                                    <div class="kt-portlet__body">

                                                        <div class="kt-portlet__body pb-3">

                                                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar3" runat="server" Expanded="false">
                                                                <Items>
                                                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                                                        <ContentTemplate>
                                                                            <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px; padding-top: 10px; padding-bottom: 10px;">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer Code :</label>

                                                                                                <asp:Label ID="Label2" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer :</label>

                                                                                                <asp:Label ID="Label3" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>

                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </telerik:RadPanelItem>
                                                                </Items>
                                                            </telerik:RadPanelBar>

                                                        </div>
                                                    </div>


                                                     <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">
                            
                           
                            <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                            <div class="col-lg-12 row">

                                <div class="col-lg-4 mt-4">
                                    <label class="col-lg-12">Price List Header <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlprh" runat="server" EmptyMessage="Select Price List Header" Width="100%" Filter="Contains" RenderMode="Lightweight"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator63" runat="server" ValidationGroup="price"
                                            ControlToValidate="ddlprh" ErrorMessage="Please Select" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                 <div class="col-lg-4 mt-4 ">
                                <label class="col-lg-12">Payment Mode</label>
                               <div class="col-lg-12">
    <telerik:RadDropDownList ID="RadDropDownList1" runat="server" Width="100%" RenderMode="Lightweight" DefaultMessage="Select Payment Mode">
        <Items>
            <telerik:DropDownListItem Text="Hard Cash" Value="HC" />
            <telerik:DropDownListItem Text="Credit" Value="CR" />
            <telerik:DropDownListItem Text="POS" Value="POS" />
            <telerik:DropDownListItem Text="Online Payment" Value="OP" />
        </Items>
    </telerik:RadDropDownList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator64" runat="server" ValidationGroup="form"
                                ControlToValidate="RadDropDownList1" ErrorMessage="Please Select" ForeColor="Red" Display="Dynamic"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
</div>

                            </div>

                                  <div class="col-lg-4 mt-4">
                                    <label class="col-lg-12">Route<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="rdRoute1" runat="server" EmptyMessage="Select Route" Width="100%" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator65" runat="server" ValidationGroup="price"
                                            ControlToValidate="rdRoute1" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>


                                <div class="col-lg-4 mt-4 mb-4">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">Start Date </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdFromData" DateInput-DateFormat="dd-MMM-yyyy" runat="server" RenderMode="Lightweight" Width="100%">
                                             <DateInput ReadOnly="true" runat="server"></DateInput>
                                        </telerik:RadDatePicker>
                                    </div>
                                </div>
                                <div class="col-lg-4 mt-4 mb-4">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">End Date </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdEndDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" RenderMode="Lightweight">

                                                                                         <DateInput ReadOnly="true" runat="server"></DateInput>

                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="rdFromData" ControlToValidate="rdEndDate" Operator="GreaterThanEqual"
                                            ErrorMessage="To data must be greater" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                    </div>
                                </div>
                                

                                    <div class="col-lg-2 ms-5" style="padding-top: 16px; ">
                                        <div class="col-lg-12">
                                        <asp:LinkButton ID="AddPrice"  runat="server" ValidationGroup="price" UseSubmitBehavior="false" Text="Add Special Price"
                                            CssClass="btn btn-sm fw-bold btn-primary" OnClick="AddPrice_Click" CausesValidation="true" />
                                            </div>
                                    </div>
                               
                            </div>
                             </telerik:RadAjaxPanel>
                             <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                    BackColor="Transparent"
                                    ForeColor="Blue">
                                    <div class="col-lg-12 text-center mt-5">
                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                    </div>
                                </telerik:RadAjaxLoadingPanel>

                        </div>
                    </div>


                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body" style="padding-top:8px;">

                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel10" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                    ID="RadGrid1" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="RadGrid1_NeedDataSource"
                                    OnItemCommand="RadGrid1_ItemCommand1"
                                    AllowFilteringByColumn="true"
                                      Skin="Material"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="crp_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="30px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Delete">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Delete" ID="Delete" Visible="true" CausesValidation="false" AlternateText="Delete" runat="server"
                                                        SetFocusOnError="false"
                                                        ImageUrl="../assets/media/svg/General/Trash.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" CausesValidation="false" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="prh_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Price List Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prh_Name" AllowFiltering="true" HeaderStyle-Width="140px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Price List Header " FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_Name" Visible="true">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="prh_PayMode" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Payment Mode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_PayMode">
                                            </telerik:GridBoundColumn>
                                              <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="110px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate" Visible="true">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="crp_StartDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="From Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="crp_StartDate" Visible="true">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="crp_EndDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="To Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="crp_EndDate" Visible="true">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="UserName" AllowFiltering="true" HeaderStyle-Width="110px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="UserName" Visible="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="110px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status" Visible="false">
                                            </telerik:GridBoundColumn>



                                        </Columns>
                                    </MasterTableView>
                                    <PagerStyle AlwaysVisible="true" />
                                    <GroupingSettings CaseSensitive="false" />
                                    <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                        <Resizing AllowColumnResize="true"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel10" EnableEmbeddedSkins="false"
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

                                                                          </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel24" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
                            </telerik:RadWizardStep>


                            <telerik:RadWizardStep Title="Promotion" ID="promo" OnLoad="promo_Load">
                                      <telerik:RadAjaxPanel ID="RadAjaxPanel24" runat="server" LoadingPanelID="RadAjaxLoadingPanel25">

                                 <div class="kt-portlet__body">

                                                        <div class="kt-portlet__body pb-3">

                                                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar4" runat="server" Expanded="false">
                                                                <Items>
                                                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                                                        <ContentTemplate>
                                                                            <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px; padding-top: 10px; padding-bottom: 10px;">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer Code :</label>

                                                                                                <asp:Label ID="promocode" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div>
                                                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer :</label>

                                                                                                <asp:Label ID="promoname" Font-Bold="true" runat="server"></asp:Label></label>
                                                                                            </div>
                                                                                        </td>

                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </telerik:RadPanelItem>
                                                                </Items>
                                                            </telerik:RadPanelBar>

                                                        </div>
                                                    </div>


                                  <div class="kt-portlet__body mt-5">

                            <asp:Literal ID="Literal2" runat="server"> </asp:Literal>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel23" runat="server" LoadingPanelID="RadAjaxLoadingPanel18">
                                <div class="col-lg-12 row" style="margin-bottom: 20px;">


                                      <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Select Route  <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlp" runat="server"  CheckBoxes="true" EnableCheckAllItemsCheckBox="true" CausesValidation="false"  Width="100%" Filter="Contains" RenderMode="Lightweight"
                                                EmptyMessage="Select Route Name" >
                                            </telerik:RadComboBox>
                                            <br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator66" runat="server" Display="Dynamic" ValidationGroup="Promon"
                                                ControlToValidate="ddlp" ErrorMessage="Please select route name " ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                     <div class="col-lg-4 form-group" style="">
                                        <label class="control-label col-lg-12">Select Promotion <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlPromo" runat="server" Width="100%" Filter="Contains"  RenderMode="Lightweight"
                                                EmptyMessage="Select Promotion Name">
                                            </telerik:RadComboBox>
                                            <br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator67" runat="server" ValidationGroup="Promon"
                                                ControlToValidate="ddlPromo" ErrorMessage="  Please  select promotion name" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                  

                                    
                                <div class="col-lg-2" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">Start Date </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdFromDatas" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" RenderMode="Lightweight"  Skin="Silk" ValidationGroup="frm">
                                                                                         <DateInput ReadOnly="true" runat="server"></DateInput>

                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator68" runat="server" ValidationGroup="frm"
                                            ControlToValidate="rdFromDatas" ErrorMessage="Please select from date" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                <div class="col-lg-2" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">End Date </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdEndDates" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" RenderMode="Mobile" >
                                                                                         <DateInput ReadOnly="true" runat="server"></DateInput>

                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="rdFromDatas" ControlToValidate="rdEndDates" Operator="GreaterThanEqual"
                                            ErrorMessage="To data must be greater" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator69" runat="server" ValidationGroup="frm"
                                            ControlToValidate="rdEndDates" ErrorMessage="Please select to date" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                

                             

                                   
                                 
                                </div>

                                   <div  style="padding-top: 10px; margin-left:1000px;  ">
                                        <div class="col-lg-12">
                                        <asp:LinkButton ID="AddPromo"  runat="server"  UseSubmitBehavior="false" Text="Add Promotion" ValidationGroup="Promon"
                                            CssClass="btn btn-sm fw-bold btn-primary" OnClick="AddPromo_Click" CausesValidation="true" />
                                            </div>
                                    </div>
                               
                                </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel18" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>

                          

                        </div>

                                  <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body" style="padding-top:8px;">

                            <asp:Literal ID="Literal3" runat="server"></asp:Literal>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel14" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                    ID="RadGrid2" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="RadGrid2_NeedDataSource"
                                    OnItemCommand="RadGrid2_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                      Skin="Material"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="rcp_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                          

                                             <telerik:GridTemplateColumn HeaderStyle-Width="30px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Delete">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="DeleteS" ID="Del" Visible="true" CausesValidation="false" AlternateText="Delete" runat="server"
                                                        SetFocusOnError="false"
                                                        ImageUrl="../assets/media/svg/General/Trash.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                           
                                                            <telerik:GridBoundColumn DataField="prm_Number" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Promotion Code" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="prm_Number" >
                                                            </telerik:GridBoundColumn>
                                                               <telerik:GridBoundColumn DataField="prm_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Promotion Name" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="prm_Name" >
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name" >
                                                            </telerik:GridBoundColumn>


                                                            <telerik:GridBoundColumn DataField="rcp_cus_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rcp_cus_ID" Display="false">
                                                            </telerik:GridBoundColumn>

                                                             <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="rcp_FromDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="From Date" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rcp_FromDate">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="rcp_EndDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="To Date" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rcp_EndDate">
                                                            </telerik:GridBoundColumn>




                                        </Columns>
                                    </MasterTableView>
                                    <PagerStyle AlwaysVisible="true" />
                                    <GroupingSettings CaseSensitive="false" />
                                    <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                        <Resizing AllowColumnResize="true"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel14" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                        </div>
                    </div>

                                 </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel25" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
                            </telerik:RadWizardStep>




                        </WizardSteps>
                    </telerik:RadWizard>
<%--                </telerik:RadAjaxPanel>--%>
            </div>

        </div>
        </div>
   







    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="false" />
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


      <div class="modal fade modal-center" id="modalConfirmRoute" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirms">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel25" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="LinkButton1" runat="server" Text="Yes" OnClick="LinkButton1_Click" CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="false" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel26" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirmRoute);">Cancel</button>
                </div>
            </div>
        </div>
    </div>




    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 650px;">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>

                <%-- Route Mapping starts --%>

                <div class="modal-content">


                    <div class="modal-footer">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

                            <asp:LinkButton ID="OK" runat="server" Text="Done" OnClick="OK_Click" CssClass="btn btn-sm fw-bold btn-primary" ValidationGroup="frm" CausesValidation="false" />
                            <asp:LinkButton  ID="gotopromotion" Visible="false" runat="server" Text="Add promotion" OnClick="gotopromotion_Click1" CssClass="btn btn-sm fw-bold btn-success" CausesValidation="false" />

                                                     <asp:LinkButton  ID="Gotocustomers" Visible="false" Text="Go to customer" class="btn btn-sm fw-bold btn-warning" runat="server" OnClick="Gotocustomers_Click" CausesValidation="false"/>

                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                    </div>
                </div>

                <%-- Route Mapping Ends --%>


                <%--<div class="modal-footer">
                   
                </div>--%>
            </div>
        </div>
    </div>



     <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 650px;">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success9"></span>
                </div>

                <%-- Route Mapping starts --%>

                <div class="modal-content">


                    <div class="modal-footer">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel16" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">


                            <asp:LinkButton ID="splprices" runat="server" Text="Add special price" OnClick="splprice_Click" CssClass="btn btn-sm fw-bold btn-success" CausesValidation="false" />

                                                     <asp:LinkButton  ID="gotocustomer" Text="Go to customer" class="btn btn-sm fw-bold btn-warning" runat="server" OnClick="gotocustomer_Click" CausesValidation="false"/>

<%--                            <asp:LinkButton ID="RorMap" runat="server" Text="OK" OnClick="RorMap_Click" CssClass="btn btn-sm fw-bold btn-primary" ValidationGroup="frm" CausesValidation="false" />--%>

                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel16" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
<%--                         <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">Cancel</button>--%>
                    </div>
                </div>

                <%-- Route Mapping Ends --%>


                <%--<div class="modal-footer">
                   
                </div>--%>
            </div>
        </div>
    </div>



       <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 650px;">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success3"></span>
                </div>

                <%-- Route Mapping starts --%>

                <div class="modal-content">


                    <div class="modal-footer">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel17" runat="server" LoadingPanelID="RadAjaxLoadingPanel17">


                            <asp:LinkButton ID="CusAdd" runat="server" Text="Route Mapping" OnClick="CusAdd_Click" CssClass="btn btn-sm fw-bold btn-success" CausesValidation="false" />

                                                     <asp:LinkButton  ID="Gotocus" Text="Go to customer" class="btn btn-sm fw-bold btn-warning" runat="server" OnClick="Gotocus_Click1" CausesValidation="false"/>


                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel17" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                    </div>
                </div>

                <%-- Route Mapping Ends --%>


                <%--<div class="modal-footer">
                   
                </div>--%>
            </div>
        </div>
    </div>
        <div class="modal fade modal-center" id="modalConfirm1" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm1">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel33" runat="server"  LoadingPanelID="RadAjaxLoadingPanel01" >
                        <asp:LinkButton ID="SavePrice" runat="server" Text="Yes" OnClick="SavePrice_Click" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel01" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm1);">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>



      <div class="modal fade modal-center" id="modaldelConfirm2" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel11" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnDelete" runat="server" Text="Yes" OnClick="BtnDelete_Click" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel11" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm2);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


      <div class="modal fade modal-center" id="pricedel" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Special Price Deleted Successfully.
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel18" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="splDeleconfirm" runat="server" Text="Done" OnClick="splDeleconfirm_Click" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel19" EnableEmbeddedSkins="false"
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




      <div class="modal fade modal-center" id="DelPromotionConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Promotion Deleted Successfully.
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel19" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="Pro" runat="server" Text="Done" OnClick="Promodel_Click1" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel20" EnableEmbeddedSkins="false"
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

     <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Customer Promotion Saved Successfully.</span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel12" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                    <asp:LinkButton ID="BtnDelConfrm" runat="server" OnClick="BtnDelConfrm_Click" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary">Done</asp:LinkButton>

                        <asp:LinkButton  Visible="false" ID="GOTOCUSTOM" Text="Go to customer" class="btn btn-sm fw-bold btn-warning" runat="server" OnClick="GOTOCUSTOM_Click" CausesValidation="false"/>
                   </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel12" EnableEmbeddedSkins="false"
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

     <div class="modal fade modal-center" id="Modelpromo" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm2">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel13" runat="server"  LoadingPanelID="RadAjaxLoadingPanel01" >
                        <asp:LinkButton ID="Promoadd" runat="server" Text="Yes" OnClick="Promoadd_Click" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel13" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(Modelpromo);">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>


      <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Please select Route</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>


     <div class="modal fade" id="kt_modal_1_55" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong please try again later....</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_55);">Ok</button>
                </div>
            </div>
        </div>
    </div>

      <div class="modal fade modal-center" id="modaldelConfirm3" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel15" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="promodel" runat="server" Text="Yes" OnClick="promodel_Click" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel15" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm2);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <style>
        .addcustomer{
            background-image:url(../assets/media/icons/add.png);
        }

        </style>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
