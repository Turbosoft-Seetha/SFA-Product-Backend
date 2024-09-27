<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AddEditCustomer.aspx.cs" Inherits="SalesForceAutomation.Admin.AddEditCustomer" %>
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Add Edit Customer 
                            </h3>
                               <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs" style="padding-left:30px;">


                            <a href="ListCustomer.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Customer </a>
                            <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>--%>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Add/Edit Customer  </a>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                        </div>
                      <div class="kt-portlet__head-actions">
                            <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:LinkButton ID="LinkButton1" Width="100px" runat="server" ValidationGroup="form" OnClick="LinkButton1_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Save'
                                    CssClass="btn btn-brand btn-elevate btn-icon-sm"  CausesValidation="true"/>
                                <asp:LinkButton ID="LinkButton2" Width="100px" runat="server"
                                    Text="Cancel" CssClass="btn btn-brand btn-elevate btn-icon-sm"
                                    CausesValidation="False" OnClick="LinkButton2_Click" />
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                        </div>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                    </div>
                   
                       

                    <div class="kt-portlet__body">
                      
                        <div class="col-lg-12 row"><b>Basic Info</b> <br/>
                            <div class="col-lg-12 row">
                        <div class="col-lg-12 row" style="padding-top:10px;">
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Name <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtName" runat="server" Rows="2"  CssClass="form-control" Width="80%" ></telerik:RadTextBox>
                                 <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtName" ErrorMessage="Please Enter Name " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                             <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Name Arabic <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtArabName" runat="server" CssClass="form-control" Width="80%" ></telerik:RadTextBox>
                                <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtArabName" ErrorMessage="Please Enter Name in Arabic " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Code <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtCode" runat="server" CssClass="form-control" Width="80%" ></telerik:RadTextBox>
                                <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtCode" ErrorMessage="Please Enter Code " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                         
                        </div>

                        <div class="col-lg-12 row" style="padding-top:10px;">
                               <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Short Name</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtShortName" runat="server" CssClass="form-control" Width="80%" ></telerik:RadTextBox>
                                 <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtShortName" ErrorMessage="Please Enter Short Name " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                               <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Short Name Arabic</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtArabShortName" runat="server" CssClass="form-control" Width="80%" ></telerik:RadTextBox>
                                 <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtArabShortName" ErrorMessage="Please Enter Short Name in Arabic " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                             <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Address<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtad" runat="server" CssClass="form-control" Width="80%"></telerik:RadTextBox>
                                <br />
                                </div>
                            </div>

                           

                       </div>


                        <div class="col-lg-12 row" style="padding-top:10px;">

                             <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Address Arabic<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtArabAddress" runat="server" CssClass="form-control" Width="80%"></telerik:RadTextBox>
                                <br />
                                </div>
                            </div>
                            
                             <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Contact Email <span class="required"></span></label>
                                <div class="col-lg-12">
                                     <telerik:RadTextBox ID="txtEmail" runat="server" CssClass="form-control" Width="80%"></telerik:RadTextBox>
                           
                                    
                                                                   <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator15" runat="server" Display="Dynamic" ValidationGroup="form"
                                         ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail"
                                        ErrorMessage="Please enter valid email address" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                  
                                </div>
                            </div>
                             
                           <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Phone <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtPerson" runat="server" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" CssClass="form-control" Width="80%"></telerik:RadNumericTextBox>
                                 <br />
                                   
                                </div>
                            </div>

                            
                          
                            </div>

                            <div class="col-lg-12 row" style="padding-top:10px;"> 

                                  <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">GeoCode<span class="required"></span></label>
                                <div class="col-lg-12">
                                   
                                    <telerik:RadTextBox ID="txtGeoLoc" runat="server" CssClass="form-control" Width="80%"></telerik:RadTextBox>
                                 <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtGeoLoc" ErrorMessage="Please Enter Geo code " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                   
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">Status <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="80%">
                                        <items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                                     
                                </div>
                            </div>
                            </div>


                               </div>
                            </div>

                             <div class="col-lg-12 row" style="padding-top:15px;"><b>Credit Terms</b> <br/>
                                  <div class="col-lg-12 row">

                        

                        <div class="col-lg-12 row" style="padding-top:10px;">
                                <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Total Credit Limit<span class="required"></span></label>
                                <div class="col-lg-12">
                                      <telerik:RadTextBox ID="txtTotCrLimit" runat="server" CssClass="form-control" Width="80%" ></telerik:RadTextBox>
                                 <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtTotCrLimit" ErrorMessage="Please Enter Total Credit Limit " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                  
                                </div>
                            </div>  

                             <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12" > Used Credit Limits <span class="required"></span></label>
                                <div class="col-lg-12" >
                                <telerik:RadNumericTextBox ID="txtUsdCrdLimits" runat="server" CssClass="form-control" Width="80%" NumberFormat-DecimalDigits="2"></telerik:RadNumericTextBox>
                                <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtUsdCrdLimits" ErrorMessage="Please Enter Used Credit Limit " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                             <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Credit Days <span class="required"></span></label>
                                <div class="col-lg-12">
                                    
                                    <telerik:RadTextBox ID="txtCrdDayy" runat="server" CssClass="form-control" Width="80%" ></telerik:RadTextBox>
                                <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator9" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtCrdDayy" ErrorMessage="Please Enter Credit Days " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            </div>
                            
                           
                            

                         
                        

                       
                           
                             <div class="col-lg-12 row" style="padding-top:10px;">

                             <div class="col-lg-4 form-group" >
                                     <label class="control-label col-lg-12">VAT Enabled <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlvat" runat="server" Width="80%">
                                        <items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                               
                            </div>

                        </div>
                            </div>
                          </div>
                                 </div>
                           
                            
                     
                          <div class="col-lg-12 row" style="padding-top:15px;"><b>Categorisation</b> <br/>
                              <div class="col-lg-12 row">
                        <div class="col-lg-12 row" style="  padding-bottom:40px; padding-top:10px;">
                            
                            <div class="col-lg-4 form-group"">
                                <label class="control-label col-lg-12">Class<span class="required">*</span></label>
                                <div class="col-lg-12">
                                 <telerik:RadComboBox ID="ddlcls" runat="server" CausesValidation="false" Width="80%" Filter="Contains"
                                        EmptyMessage="Select Class Name"   ></telerik:RadComboBox>
                                    <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator12" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlcls" ErrorMessage="Please Enter ClassName " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            
                             
                            <div class="col-lg-4 form-group"   >
                                <label class="control-label col-lg-12" >Area <span class="required">*</span></label>
                                <div class="col-lg-12" >
                                     <telerik:RadComboBox ID="ddlarea" runat="server" CausesValidation="false" Width="80%" Filter="Contains"
                                        EmptyMessage="Select Area Name"   ></telerik:RadComboBox>
                                    <br />
                                    <asp:RequiredFieldValidator Filter="Contains" ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlarea" ErrorMessage="Please Enter Area Name " ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                     
                            </div>
                             
                        
                        </div>

                       </div>
                       </div> 
                    </div>

                        
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
   <%-- </div>--%>

    
     <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                    <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />
                        </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click1" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
