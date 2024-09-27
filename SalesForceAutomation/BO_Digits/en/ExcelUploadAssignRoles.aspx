<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ExcelUploadAssignRoles.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ExcelUploadAssignRoles" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
      <script>
     function Confim() {
         $('#modalConfirm').modal('show');
     }
     function successModal() {
         $('#modalConfirm').modal('hide');
         $('#kt_modal_1_4').modal('show');
     }
     function failedModal() {
         $('#modalConfirm').modal('hide');
         $('#kt_modal_1_5').modal('show');
     }
     function redirect() {
         var url = new URL(window.location.href);
         var c = url.searchParams.get("Id");
         window.location.href = "EmployeesAssignApproval.aspx?Id=" + c;
     }
      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
 </telerik:RadAjaxManager>
 <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
     <AjaxSettings>
         <telerik:AjaxSetting AjaxControlID="grvRpt">
             <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="modalConfirm" />
                 <telerik:AjaxUpdatedControl ControlID="lblType" />
                 <telerik:AjaxUpdatedControl ControlID="ddlRoles" />
             </UpdatedControls>
         </telerik:AjaxSetting>
     </AjaxSettings>

 </telerik:RadAjaxManagerProxy>



      <div class="card-body" style="background-color:white; padding:20px;">
   <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
      <div class="row">
          <div class="col-lg-12">
              <!--begin::Portlet-->
              <div class="kt-portlet">                   
                  
                  <!--begin::Form-->
                  <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                  <div class="kt-portlet__body">

                      <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                          <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                          <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                              ID="grvRpt" GridLines="None"
                              ShowFooter="True" AllowSorting="True"
                              OnNeedDataSource="grvRpt_NeedDataSource"
                              OnItemCommand="grvRpt_ItemCommand"
                              AllowFilteringByColumn="true"
                              ClientSettings-Resizing-ClipCellContentOnResize="true"
                              EnableAjaxSkinRendering="true"
                              AllowPaging="true" PageSize="5000" CellSpacing="0">
                              <ClientSettings>
                                  <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                              </ClientSettings>
                              <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                  ShowFooter="false" DataKeyNames="upt_ID"
                                  EnableHeaderContextMenu="true">
                                  <Columns> 
                                       
                                      <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Assign Roles" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="EditCol" ID="EditCol" Visible="true" AlternateText="Edit" runat="server"
                                                    ImageUrl="../assets/media/svg/general/edit.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                      <telerik:GridBoundColumn DataField="upt_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="upt_Name">
                                      </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="Roles" AllowFiltering="true" HeaderStyle-Width="100px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Roles" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="Roles">
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
                   </div>
                   </telerik:RadAjaxPanel>
                      
                      <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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

     <div class="clearfix"></div>
 <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content" style="width:600px;">
             <div class="modal-header">
                
                  <div class="card-body" style="background-color: white; padding: 20px;">
     <div class="kt-portlet__body">
         <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
             <div class="col-lg-12 row">

                 <div class="col-lg-12 form-group row pb-4">
                     <span class="control-label col-lg-2 fw-bold fs-3">Type :</span> <span class="control-label col-lg-10 fw-bold fs-3"> <asp:Label runat="server" ID="lblType"></asp:Label> </span> 
                     <%--<div class="col-lg-12">
                         <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" EmptyMessage="Select ddlType" Filter="Contains" RenderMode="Lightweight"></telerik:RadComboBox>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                             ControlToValidate="ddlType" ErrorMessage="Please Select Type" ForeColor="Red" Display="Dynamic"
                             SetFocusOnError="True" InitialValue="Select Process"></asp:RequiredFieldValidator><br />
                     </div>--%>
                 </div>

                 <div class="col-lg-8 form-group">
                     <label class="control-label col-lg-12">Roles</label>
                     <div class="col-lg-12">
                         <telerik:RadComboBox ID="ddlRoles" runat="server" Width="100%" EmptyMessage="Select Roles" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Filter="Contains" RenderMode="Lightweight"></telerik:RadComboBox>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                             ControlToValidate="ddlRoles" ErrorMessage="Please Select Roles" ForeColor="Red" Display="Dynamic"
                             SetFocusOnError="True" InitialValue="Select Roles"></asp:RequiredFieldValidator><br />
                     </div>
                 </div>

             </div>
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
             </div>
             <div class="modal-footer">
                 <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                     <asp:LinkButton ID="lnkAdds" runat="server" Text="Save" OnClick="lnkAdds_Click" CssClass="btn btn-sm fw-bold btn-primary" />
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
 <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title">Success</h5>
             </div>
             <div class="modal-body">
                 <span>Excel upload Roles assigned successfully.</span>
             </div>
             <div class="modal-footer">
                 <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
