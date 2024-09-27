<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OutstandingManage.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OutstandingManage" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

      <script type="text/javascript">
     function Assign() {

     $('#kt_modal_1_7').modal('show');
         }
         function successModal(a) {
             $('#modalConfirm').modal('hide');
             $('#kt_modal_1_7').modal('hide');
             $('#kt_modal_1_0').modal('hide');
             $('#kt_modal_1_4').modal('show');
             $('#success').text(a);
         }
         function failedModal(b) {
             $('#kt_modal_1_7').modal('hide');
             $('#kt_modal_1_5').modal('show');
             $('#failtext').text(b);
         }
         function failedModals() {
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

    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                      <asp:linkbutton  ID="btnChngRoute" Visible="true" CssClass="btn btn-sm btn-light-primary me-2"  runat="server" onClick="btnChngRoute_Click" > Change Route
</asp:linkbutton>
    
         
  
             </telerik:RadAjaxPanel>
  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
      BackColor="Transparent"
      ForeColor="Blue">
      <div class="col-lg-12 text-center mt-5">
          <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
      </div>
  </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


     <script type="text/javascript">
         function ToggleAllCheckboxes(masterCheckbox) {
             var grid = masterCheckbox.closest('.RadGrid'); // Find the closest RadGrid element
             var checkboxes = grid.querySelectorAll('input[type="checkbox"][id*="chkSelect"]');
             for (var i = 0; i < checkboxes.length; i++) {
                 checkboxes[i].checked = masterCheckbox.checked;
             }
         }


         function onRowClick(sender, eventArgs) {
             var gridDataItem = eventArgs.get_item(); // Get the clicked item (row)
             var checkBox = gridDataItem.findElement("chkSelect"); // Find the checkbox in the row

             if (checkBox) {
                 checkBox.checked = !checkBox.checked; // Toggle the checkbox state
             }
         }


         function ToggleAllCheckboxes(source) {
             var checkboxes = document.querySelectorAll('input[id$="chkSelect"]');
             for (var i = 0; i < checkboxes.length; i++) {
                 checkboxes[i].checked = source.checked;
             }
         }
     </script>


     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">



                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        <div class="card-body">

                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                               

                                    <div class=" col-lg-12 row" style="padding-bottom: 10px">

                                       

<%--                                        <div class="col-lg-4">
                                            <label class="control-label col-lg-12">Customer</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" Width="100%"
                                                    ID="rdCustomer" runat="server" EmptyMessage="Select Customer"  AutoPostBack="true">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>


                                    

                                        <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; margin-left: 17px;">
                                            <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                                                    Apply Filter
                                            </asp:LinkButton>
                                        </div>--%>



                                          <div class="col-lg-12 row">

                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enter Customer Code or Name to Populate Customer <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="CusTxtBOX" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadTextBox>



                                        </div>
                                    </div>
                                    <div class="col-lg-4" style="padding-top: 15px; margin-left: 15px;">
                                        <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" CausesValidation="false" OnClick="Filter_Click">
                                                    Search
                                        </asp:LinkButton>
                                    </div>

                                </div>
                                    


                                    </div>
                                <!--begin::Form-->
                                <!--end: Search Form -->

                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />



                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    <ClientEvents OnRowClick="onRowClick" />

                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="oid_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>
                                             <telerik:GridTemplateColumn HeaderStyle-Width="30px" AllowFiltering="false" HeaderText="Select" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
    <HeaderTemplate>
        <asp:CheckBox ID="chkSelectAll" runat="server" onclick="ToggleAllCheckboxes(this)" />
    </HeaderTemplate>
    <ItemTemplate>
        <asp:CheckBox ID="chkSelect" runat="server" />
    </ItemTemplate>
</telerik:GridTemplateColumn>



                                       

                                            <telerik:GridBoundColumn DataField="InvoiceID" AllowFiltering="true" HeaderStyle-Width="130px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Invoice ID" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="InvoiceID">
             </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                    HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                    HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                </telerik:GridBoundColumn>
            
                  <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                    HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                </telerik:GridBoundColumn>
             
               <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
             </telerik:GridBoundColumn>
               <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
            </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="cus_CreditDays" AllowFiltering="true" HeaderStyle-Width="120px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Credit Days" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="cus_CreditDays">
            </telerik:GridBoundColumn>
               <telerik:GridBoundColumn DataField="InvoicedOn" AllowFiltering="true" HeaderStyle-Width="130px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Invoiced On" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="InvoicedOn">
             </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="InvoiceAmount" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Amount" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="InvoiceAmount">
                 <ItemStyle HorizontalAlign="Right" />
                 <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>
            
               <telerik:GridBoundColumn DataField="AmountPaid" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Amount Paid" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="AmountPaid">
                   <ItemStyle HorizontalAlign="Right" />
                 <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>
             
                <telerik:GridBoundColumn DataField="InvoiceBalance" AllowFiltering="true" HeaderStyle-Width="120px"
              HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Balance" FilterControlWidth="100%"
              CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
              HeaderStyle-Font-Bold="true" UniqueName="InvoiceBalance">
                  <ItemStyle HorizontalAlign="Right" />
                 <HeaderStyle HorizontalAlign="Right" />
          </telerik:GridBoundColumn>

          <%--  <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="130px"
              HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
              CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
              HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
          </telerik:GridBoundColumn>--%>


              <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Status">
             </telerik:GridBoundColumn>
           
             
                                        </Columns>
                                    </MasterTableView>
                                    <PagerStyle AlwaysVisible="true" />
                                    <GroupingSettings CaseSensitive="false" />
                                    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                        <Resizing AllowColumnResize="true"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </telerik:RadAjaxPanel>
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">Ok</button>
                </div>
            </div>
        </div>
    </div>


     <div class="modal fade" id="kt_modal_1_7" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Assign Route</h5>
                </div>
                                                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-12 form-group">
                <label class="control-label col-lg-12" >Route<span class="required"></span></label>
                <div class="col-lg-12">
                      <telerik:RadComboBox ID="ddlRoute" runat="server" EmptyMessage="Select Route" Width="100%" Filter="Contains" RenderMode="Lightweight" CausesValidation="false"></telerik:RadComboBox>

   
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"  ValidationGroup="frm"
                    ControlToValidate="ddlRoute" ErrorMessage="Please Select Route " ForeColor="Red" 
                  SetFocusOnError="True" ></asp:RequiredFieldValidator><br />
                    
                    </div>
                         </div>


                        </div>
                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        
                        <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="btn btn-sm fw-bold btn-success" ValidationGroup="frm" CausesValidation="true" OnClick="lnkSubmit_Click">
                                                    Confirm
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <br />
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_7);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


      <div class="modal fade" id="kt_modal_1_4" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>


      <div class="modal fade" id="kt_modal_1_5" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failtext"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
