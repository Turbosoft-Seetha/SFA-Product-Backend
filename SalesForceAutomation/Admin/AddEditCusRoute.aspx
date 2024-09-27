<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AddEditCusRoute.aspx.cs" Inherits="SalesForceAutomation.Admin.AddEditCusRoute" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script>
        function Confim() {

            $('#modalConfirm').modal('show');
        }
        function Succcess(ab) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#Success').text(ab);
        }
        function FailureAlert(res) {
            $('#FailureAlert').modal('show');
            $('#failres').text(res);
            x++;
        }
        function Cusroute() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("RID");
            window.location.href = "ListCustomerRoute.aspx?ID=" + c;
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
                            <h3 class="kt-portlet__head-title">Add Edit Customer Route /
                            </h3>
                            <telerik:RadLabel ID="cusroute" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>

                            <div class="kt-subheader__breadcrumbs" style="padding-left:20px;">
                             <a href="ListRoute.aspx" class="kt-subheader__breadcrumbs-link">
                                <i class="flaticon2-shelter"></i> Route</a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:Cusroute();" class="kt-subheader__breadcrumbs-link">
                                <i class="kt-subheader__breadcrumbs-link"></i> Customer Route</a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link"> Add Edit Customer Route </a>

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
                           
                        </div>
                    </div>
                    <div class="kt-portlet__body">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"  >
                            

                        
                       
                       
                            <%--<div class="col-lg-4 form-group">--%>
                                <%--<label class="control-label col-lg-12">Route <span class="required">* </span></label>--%>
                                <%--<div class="col-lg-12">--%>
                                    <telerik:RadComboBox ID="ddlroute" runat="server" EmptyMessage="Select Route" CausesValidation="false" Visible="false" Width="100%" Filter="Contains" AutoPostBack="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlroute" ErrorMessage="Please Select Route" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                <%--</div>--%>
                            <%--</div>--%>
                         
                           
                                  <div class="col-lg-12 row"> <b> Credit Terms </b> </div> <br />

                             <div class="col-lg-12 row">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Customer <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlcus" runat="server"  EmptyMessage="Select Customer" Width="100%" Filter="Contains"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlcus" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Customer Type<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddcusType" runat="server" Width="100%" DefaultMessage="Select Customer Type" OnSelectedIndexChanged="ddcusType_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true">
                                  <items>
                                  <telerik:DropDownListItem Text="CASH" Value="CS" /> 
                                  <telerik:DropDownListItem Text="CREDIT" Value="CR"  />                                 
                                  <telerik:DropDownListItem Text="TEMPORARY CREDIT" Value="TC" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddcusType" ErrorMessage="Please select Customer Type" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>
                             
                                 <asp:PlaceHolder runat="server" ID="Custype">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-6">Total Credit Limit <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtTCL" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" Display="Dynamic" 
                                        ControlToValidate="txtTCL" ErrorMessage="Please Enter Total Credit Limit" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-6">Used Credit Limit <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtUCL" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" Display="Dynamic"
                                        ControlToValidate="txtUCL" ErrorMessage="Please Enter Used Credit Limit" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Available Credit Limit <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtACL" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" 
                                        ControlToValidate="txtACL" ErrorMessage="Please Enter Available Credit Limit" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>

                                      <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Used Order Credit <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtUOC" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" Display="Dynamic" 
                                        ControlToValidate="txtUOC" ErrorMessage="Please Enter Available Credit Limit" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>
                                      <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Used Invoice Credit <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtUIC" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" Display="Dynamic" 
                                        ControlToValidate="txtUIC" ErrorMessage="Please Enter Available Credit Limit" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>

                                          
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-6">PDC Amount<span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtpdc" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtpdc" ErrorMessage="Please Enter PDC Amount" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>
                                    
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-6">Credit Days <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtCDays" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtCDays" ErrorMessage="Please Enter Credit Days" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>
                                  </asp:PlaceHolder>
                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Allow Cash For Credit Customers<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddPT" runat="server" Width="100%">
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y" />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddPT" ErrorMessage="Please select Allow Cash For Credit Customers" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-6">No of Invoice <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtnoInvoice" runat="server" CssClass="form-control" width="100%" Enabled="true"></telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtnoInvoice" ErrorMessage="Please Enter No of Invoice" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>
                          

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">VAT<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsVAT" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddIsVAT" ErrorMessage="Please select VAT" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Hold<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlIsHold" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlIsHold" ErrorMessage="Please select Hold" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                                  <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Status<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlstatus" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Active" Value="Y"  />
                                  <telerik:DropDownListItem Text="Inactive" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlstatus" ErrorMessage="Please select Status" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                         </div> <br />

                            
                              <div class="col-lg-12 row"> <b> General Settings </b> </div> <br />

                         <div class="col-lg-12 row">

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Selection Type<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddltype" runat="server" Width="100%" DefaultMessage="Select Selection Type" >
                                  <items>
                                  <telerik:DropDownListItem Text="Geocode" Value="G"  />
                                  <telerik:DropDownListItem Text="Barcode" Value="B" />
                                      <telerik:DropDownListItem Text="Manual" Value="M" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator30" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddltype" ErrorMessage="Please select Selection Type" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12" >Fencing Radius <span class="required">* </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox  MinValue="20" ID="txtradius" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtradius" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Fencing Radius"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">On Call Features</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddloncal" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select On Call Features">
                                        <Items>
                                           
                                            <telerik:RadComboBoxItem Text="AR Collection" Value="AR" />
                                            <telerik:RadComboBoxItem Text="Advance Collection" Value="AP" />
                                            <telerik:RadComboBoxItem Text="Order Request" Value="OR" />
                                        </Items>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddloncal" ErrorMessage="Please select On Call Features" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Sales Order<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsSOrder" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddIsSOrder" ErrorMessage="Please select Sales Order" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Invoicing<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlIsInvoicing" runat="server" Width="100%" emptymessage="please Select" OnSelectedIndexChanged="ddlIsInvoicing_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true">
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlIsInvoicing" ErrorMessage="Please select Invoicing" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>
                            
                             <asp:PlaceHolder runat="server" ID="inv">

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Sales Invoicing<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsI_Sales" runat="server" Width="100%" DefaultMessage="Select Sales Invoicing" >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" 
                                        ControlToValidate="ddIsI_Sales" ErrorMessage="Please select Sales Invoicing" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Good Return Invoicing<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsI_GR" runat="server" Width="100%" DefaultMessage="Select Good Return Invoicing" >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" 
                                        ControlToValidate="ddIsI_GR" ErrorMessage="Please select Good Return Invoicing" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Bad Return Invoicing<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsI_BR" runat="server" Width="100%" DefaultMessage="Select Bad Return Invoicing" >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic" 
                                        ControlToValidate="ddIsI_BR" ErrorMessage="Please select Bad Return Invoicing" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Free of Cost Invoicing<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsI_FG" runat="server" Width="100%" DefaultMessage="Select Free of Cost Invoicing">
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic"
                                        ControlToValidate="ddIsI_FG" ErrorMessage="Please select Free of Cost Invoicing" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>  
                                 
                            </asp:PlaceHolder>
                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Account Receivables<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlIsAR" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlIsAR" ErrorMessage="Please select Account Receivables" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Advance Payment<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddladvpay" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator38" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddladvpay" ErrorMessage="Please select Advance Payment" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Merchandising<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsMerchand" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddIsMerchand" ErrorMessage="Please select Merchandising" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                             <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Category Type<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddcatType" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="ODC" Value="ODC"  />
                                  <telerik:DropDownListItem Text="NC" Value="NC" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddcatType" ErrorMessage="Please select category type" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                             </div> <br />
                            

                            <div class="col-lg-12 row"> <b> Transactional Settings </b> </div> <br />

                         <div class="col-lg-12 row">

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Void Enable<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddVoidEnable" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddVoidEnable" ErrorMessage="Please select Void Enable" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Round Amount<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddRoundAmount" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddRoundAmount" ErrorMessage="Please select Round Amount" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Print Out<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddIsPO" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator49" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddIsPO" ErrorMessage="Please select Print Out" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>
                             
                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Signature Invoice<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlSI" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator50" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlSI" ErrorMessage="Please select Signature Invoice" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Signature AR<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddSAR" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator52" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddSAR" ErrorMessage="Please select Signature AR" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Invoice Remarks<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddRe" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator51" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddRe" ErrorMessage="Please select Invoice Remarks" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Order Request Remarks<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddORR" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator54" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddORR" ErrorMessage="Please select Order Request Remarks" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>
                           
                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Promotion in Order<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlordpro" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator56" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlordpro" ErrorMessage="Please select Promotion in Order" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>
                             
                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">Free Good Exemption<span class="required">* </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlFGExemption" runat="server" Width="100%"  >
                                  <items>
                                  <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                  <telerik:DropDownListItem Text="No" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator58" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlFGExemption" ErrorMessage="Please select Free Good Exemption" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>

                              
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
                    <span id="Success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
     <div class="modal fade" id="FailureAlert" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Failure</h5>
                                </div>
                                <div class="modal-body">
                                    <span style="color:red"><strong></strong> &nbsp;&nbsp; <span id="failres"></span></span>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Dismiss</button>
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
                    <span id="fail"></span>
                </div>
                <div class="modal-footer">
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
     
</asp:Content>
