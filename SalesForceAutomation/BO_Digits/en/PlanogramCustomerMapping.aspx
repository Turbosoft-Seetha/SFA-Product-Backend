<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="PlanogramCustomerMapping.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.PlanogramCustomerMapping" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>



<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script>
    function Confim() {
        $('#modalConfirm').modal('show');
        $('#kt_modal_1_4').modal('hide');
        $('#kt_modal_1_6').modal('hide');
        $('#kt_modal_1_5').modal('hide');
        $('#modalConfirm1').modal('hide');
    }
         function Succcess(a) {
             $('#modalConfirm').modal('hide');
             $('#kt_modal_1_4').modal('show');
             $('#kt_modal_1_6').modal('hide');
             $('#kt_modal_1_5').modal('hide');
             $('#modalConfirm1').modal('hide');
            
             $('#success').text(a);
    }
         function Success1(a) {
                 $('#modalConfirm').modal('hide');
                 $('#kt_modal_1_6').modal('show');
                 $('#kt_modal_1_4').modal('hide');
                 $('#kt_modal_1_5').modal('hide');
                 $('#modalConfirm1').modal('hide');
                 $('#success1').text(a);
    }
    function failedModal() {
        $('#kt_modal_1_5').modal('show');
        $('#modalConfirm1').modal('hide');
        $('#modalConfirm').modal('hide');
        $('#kt_modal_1_6').modal('hide');
        $('#kt_modal_1_4').modal('hide');
    }
    function Confim1() {
        $('#modalConfirm1').modal('show');
        $('#modalConfirm').modal('hide');
        $('#kt_modal_1_6').modal('hide');
        $('#kt_modal_1_4').modal('hide');
        $('#kt_modal_1_5').modal('hide');
    }
         function failedModals() {


             $('#kt_modal_1_7').modal('show');


         }
         function Delete() {
             $('#kt_modal_1_2').modal('show');
         }
         function failedModal1() {


             $('#kt_modal_1_8').modal('show');


         }
         
  
     </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" OnClick="btnSave_Click"></asp:LinkButton>
    </telerik:RadAjaxPanel>
     <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
     <asp:LinkButton ID="lnkDelete" Width="100px" runat="server" ValidationGroup="form" OnClick="lnkDelete_Click" UseSubmitBehavior="false" Text="Delete"
         CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
 </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
   <%-- <asp:LinkButton ID="btnCancel" Width="100px" runat="server"
        Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
        CausesValidation="False" OnClick="btnCancel_Click" />--%>



</asp:Content>



    <asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
               <telerik:RadAjaxManager ID="RadAjaxManager2" runat="server">
 </telerik:RadAjaxManager>
 <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
     <AjaxSettings>
         <telerik:AjaxSetting AjaxControlID="btnOK">
             <UpdatedControls>
                   <telerik:AjaxUpdatedControl ControlID="grvRpt" />

                         


             </UpdatedControls>
         </telerik:AjaxSetting>

     </AjaxSettings>
     <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="btnDeleteOk">
        <UpdatedControls>
              <telerik:AjaxUpdatedControl ControlID="grvRpt" />

                    


        </UpdatedControls>
    </telerik:AjaxSetting>

</AjaxSettings>

</telerik:RadAjaxManagerProxy>




       <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <!--begin::Form-->


                    <!--end: Search Form -->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                        <div class="card-body" style="background-color: white; padding: 20px;">

                            <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                
                                <div class=" col-lg-12 row" style="padding-bottom: 20px">
                                    <div class="col-lg-3" style="margin-left: 4px;">
                                         <label class="control-label col-lg-12">Customer</label>
 <div class="col-lg-12">
      <telerik:RadComboBox ID="ddlCustomer" runat="server" Width="100%" EmptyMessage="Select Customer" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
          Filter="Contains" Skin="Silk"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                    ControlToValidate="ddlCustomer" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic"
                                    SetFocusOnError="True" InitialValue="Select Customer"></asp:RequiredFieldValidator><br />

 </div>
                                    </div>


                                      
                                   
                              

                                  </div>


                                <%--</telerik:RadAjaxPanel>--%>



                                                          <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
        ID="grvRpt" GridLines="None"
        ShowFooter="True" AllowSorting="True"
        OnNeedDataSource="grvRpt_NeedDataSource"
        OnItemDataBound="grvRpt_ItemDataBound"
        OnItemCommand="grvRpt_ItemCommand"
        AllowFilteringByColumn="true"
        ClientSettings-Resizing-ClipCellContentOnResize="true"
        EnableAjaxSkinRendering="true"
        AllowPaging="true" PageSize="10" CellSpacing="0">
        <ClientSettings>
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
        </ClientSettings>
        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
            ShowFooter="false" DataKeyNames="plc_ID"
            EnableHeaderContextMenu="true">
            <Columns>
                <telerik:GridClientSelectColumn HeaderStyle-Width="30px" UniqueName="chkAll"></telerik:GridClientSelectColumn>

                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                </telerik:GridBoundColumn>
             <%--<telerik:GridTemplateColumn HeaderStyle-Width="90px" AllowFiltering="false" HeaderText="Delete" UniqueName="Cnf" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
<ItemTemplate>
  <asp:LinkButton ID="lnkDelete" runat="server" Font-Size="X-Small" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" Text="Delete" CommandName="Delete"  ></asp:LinkButton>

  </ItemTemplate>
</telerik:GridTemplateColumn>  --%>
                 <%--<telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Delete">
     <ItemTemplate>
         <asp:ImageButton CommandName="Delete" ID="lnkDelete" Visible="true" AlternateText="Delete" runat="server"
             SetFocusOnError="false"
             ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
     </ItemTemplate>
 </telerik:GridTemplateColumn>--%>
            </Columns>
        </MasterTableView>
        <GroupingSettings CaseSensitive="false" />
        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
            <Resizing AllowColumnResize="true"></Resizing>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
        </ClientSettings>
    </telerik:RadGrid>




           


<%--  </div>--%>
                                </telerik:RadAjaxPanel>
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
                    <asp:LinkButton ID="SaveCus" runat="server" Text="Yes" OnClick="SaveCus_Click" CausesValidation="false" CssClass="btn btn-sm fw-bold btn-primary" />
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
                 <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                     <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                 </telerik:RadAjaxPanel>
                 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
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
     <div class="modal fade modal-center" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="Delete">Are you sure you want to Delete??
                 </h5>
             </div>
             <div class="modal-footer">
                 <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                     <asp:LinkButton ID="btnDelete" runat="server" Text="Yes" OnClick="Delete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                 </telerik:RadAjaxPanel>
                 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                     BackColor="Transparent"
                     ForeColor="Blue">
                     <div class="col-lg-12 text-center mt-5">
                         <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                     </div>
                 </telerik:RadAjaxLoadingPanel>
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_2);">Cancel</button>
             </div>
         </div>
     </div>
 </div>
        <!--begin::FailedModal-->
                                <div class="modal fade" id="kt_modal_1_8" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                   <div class="modal-dialog" role="document">
                                         <div class="modal-content">
                                              <div class="modal-header">
                                                <h5 class="modal-title">Oops..!</h5>
                                              </div>
                                          <div class="modal-body">
                                            <span id="failtext"></span>
                                          </div>
                                     <div class="modal-footer">
                                              <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_8);">Ok</button>
                                         </div>
                                  </div>
                            </div>
                          </div>

        <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Success</h5>
            </div>
            <div class="modal-body">
                <span id="success1"></span>
            </div>
            <div class="modal-footer">
                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                    <asp:LinkButton ID="btnDeleteOk" runat="server" OnClick="btnDeleteOk_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
</asp:Content>
