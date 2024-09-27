<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ProfileHeader.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ProfileHeader" %>
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
         function FailureSave() {
             $('#modalConfirm').modal('hide');
             $('#kt_modal_1_7').modal('show');
         }

         function FailureRange() {
             $('#modalConfirm').modal('hide');
             $('#kt_modal_1_8').modal('show');
         }

         function failModal() {
             $('#kt_modal_1_3').modal('hide');
             $('#kt_modal').modal('show');
         }

         function existModal() {
             $('#kt_modal_1_6').modal('show');
         }
         function DelConfim() {
             $('#modalDelte').modal('show');
         }
         function successModal() {
             $('#modalDelte').modal('hide');
         }
         function ChangeConfirm() {
             $('#kt_modalChange').modal('show');
         }
         function successModalChange() {
             $('#kt_modalChange').modal('hide');
         }

      
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

          <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"  CausesValidation="False" OnClick="btnCancel_Click" />

          <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="form" OnClick="btnSave_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
                                    CssClass="btn btn-sm fw-bold btn-primary"  CausesValidation="true"/>

  </telerik:RadAjaxPanel>

                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="AddRange">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="grvRpt" />
            <telerik:AjaxUpdatedControl ControlID="dllSettingsText" />
        <telerik:AjaxUpdatedControl ControlID="dllmultisettings" />
            <telerik:AjaxUpdatedControl ControlID="ddlTable" />
            <telerik:AjaxUpdatedControl ControlID="Multiple" />
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
        <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="BtnConfrmDelete">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="grvRpt" />
            <telerik:AjaxUpdatedControl ControlID="rdColumnName" />
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
        <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btndeletecancel">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="grvRpt" />
       
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
        <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdColumnName">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="Single" />
        <telerik:AjaxUpdatedControl ControlID="Multiple" />
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
        <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ddlTable">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="rdColumnName" />
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
         <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ChangeMasterProceed">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="grvRpt" />
            <telerik:AjaxUpdatedControl ControlID="rdColumnName" />
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

        

    </telerik:RadAjaxManagerProxy>
     
       
    
     <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                  <div class="card-body p-8" style="background-color:white;"> 
                        <div class="col-lg-12 row">
                                       <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">Profile Name <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtprofName" runat="server" CssClass="form-control" Width="100%"  AutoPostBack="true" OnTextChanged="txtprofName_TextChanged"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtprofName" ErrorMessage="Please Enter Profile Name" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>
                                       <div class="col-lg-4 form-group mb-4">
                                    <label class="control-label col-lg-12">Master<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlTable" runat="server" Width="100%" Skin="Silk" Filter="Contains" OnSelectedIndexChanged="ddlTable_SelectedIndexChanged" AutoPostBack="true" EmptyMessage="Select Master" RenderMode="Lightweight"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlTable" ErrorMessage="Please Select Table" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                       <div class="col-lg-4 form-group">
                                        <label class="control-label col-lg-12">Active</label>
                                        <div class="col-lg-12">
                                            <asp:CheckBox ID="chkActive" runat="server" />
                                        </div>
                                    </div>
                          </div>
                        
                    </div>
                            </telerik:RadAjaxPanel>
                           
    
    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
    <div class="card-body p-8" style="background-color:white;"> 
                    <div class="col-lg-12 row">
                        <h2>Profile Detail</h2>
                    </div>
                        <div class="col-lg-12 row">
                             <div class="col-lg-4 form-group mb-4">
                                    <label class="control-label col-lg-12">Settings</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="rdColumnName" runat="server" Width="100%" Skin="Silk" Filter="Contains" OnSelectedIndexChanged="rdColumnName_SelectedIndexChanged" AutoPostBack="true" EmptyMessage="Select Setting" RenderMode="Lightweight"></telerik:RadComboBox>
                                       <br />
                                    </div>
                                 </div>
                            

                            
                                <div class="col-lg-4 form-group  mb-4">
                                    <asp:PlaceHolder runat="server" ID="Single" Visible="false">
                                <label class="control-label col-lg-12">Settings Value </label>
                                <div class="col-lg-12">
                                   <telerik:RadComboBox ID="dllSettingsText" runat="server" EmptyMessage="Select settings value" CausesValidation="false" Width="100%" Filter="Contains" Skin="Silk"></telerik:RadComboBox>
                               <br />
                                </div>
                                </asp:PlaceHolder> 
                                    <asp:PlaceHolder runat="server" ID="Multiple" Visible="false">
                                        <label class="control-label col-lg-12">Settings Value <span class="required"></span></label>
                                <div class="col-lg-12">
                                   <telerik:RadComboBox ID="dllmultisettings" runat="server" EmptyMessage="Select settings value" 
                                CausesValidation="false" Width="100%" Filter="Contains" CheckBoxes="true" AutoPostBack="true" Skin="Silk">
                                </telerik:RadComboBox>
                              <br />
                                </div>
                                    </asp:PlaceHolder> 
                            </div>

                            <div class="col-lg-4 form-group mb-4 pt-3">
                                <asp:Button ID="btnAddRange" runat="server" Text="Add" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="AddRange_Click" />
                            </div>
                        </div>
                </div>
    <div class="card-body p-8" style="background-color:white;">
        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                            ID="grvRpt" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="grvRpt_NeedDataSource"
                            OnItemCommand="grvRpt_ItemCommand"
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="50" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="pfd_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Delete">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Delete" ID="Delete" Visible="true" AlternateText="Delete" runat="server"
                                                    ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="pfd_Columns" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Min Range" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pfd_Columns" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="pfd_SettingsName" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Setting" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pfd_SettingsName">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="pfd_ControlId" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Max Range" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pfd_ControlId" Display="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="pfd_Values" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Value" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pfd_Values" Display="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="pfd_ValueText" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Setting Value" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pfd_ValueText">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="pfd_type" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Setting Value" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pfd_type" Display="false">
                                    </telerik:GridBoundColumn>

                                </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>
    </div>
                </telerik:RadAjaxPanel>
      <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" style="height:auto" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnCnfrmSave" runat="server" Text="Yes" OnClick="BtnCnfrmSave_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="height:auto" aria-hidden="true">
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
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="height:auto" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal();">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="height:auto" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Please add atleast one Settings.</span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_7);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="height:auto" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Please Choose Setting Or Value</span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_8);">Ok</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade modal-center" id="kt_modalChange" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" style="height:auto" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Alert..!</h5>
                </div>
                <div class="modal-body">
                    <span>You already Add some Settings,If you Change Master, your added settings will be deleted!! Do You want to Continue?</span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <asp:LinkButton ID="ChangeMasterProceed" runat="server" Text="Yes" OnClick="ChangeMasterProceed_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
<%--                    <button type="button" id="btndeletecancel" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalDelte);">Cancel</button>--%>
                    <asp:LinkButton ID="ChangeMasterCancel" runat="server" Text="Cancel" OnClick="ChangeMasterCancel_Click" CssClass="btn btn-sm fw-bold btn-secondary" />
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade modal-center" id="modalDelte" style="height:auto" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <asp:LinkButton ID="BtnConfrmDelete" runat="server" Text="Yes" OnClick="BtnConfrmDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
<%--                    <button type="button" id="btndeletecancel" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalDelte);">Cancel</button>--%>
                    <asp:LinkButton ID="btndeletecancel" runat="server" Text="Cancel" OnClick="btndeletecancel_click" CssClass="btn btn-sm fw-bold btn-secondary" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>