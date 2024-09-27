<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ProfileHeaderNew.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ProfileHeaderNew" %>
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
                                    CssClass="btn btn-sm fw-bold btn-primary"  CausesValidation="true" />

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
        <telerik:AjaxSetting AjaxControlID="ddlTable">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="grvRpt" />
            <telerik:AjaxUpdatedControl ControlID="phValueOptions" />
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
     
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
         <div class="row">
             <div class="col-lg-12">
                <div class="kt-portlet">
                    <div class="card-body" style="background-color:white; padding:20px;">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" >
                                
                        <div class="col-lg-12 row">

                            <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Profile Code <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%"  AutoPostBack="true" OnTextChanged="txtcode_TextChanged"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtcode" ErrorMessage="Please Enter Profile Code" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">Profile Name <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtprofName" runat="server" CssClass="form-control" Width="100%" MaxLength="100" ></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtprofName" ErrorMessage="Please Enter Profile Name" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                       <div class="col-lg-3 form-group mb-4">
                                    <label class="control-label col-lg-12">Master<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlTable" runat="server" Width="100%" Skin="Silk" Filter="Contains" OnSelectedIndexChanged="ddlTable_SelectedIndexChanged" AutoPostBack="true" EmptyMessage="Select Master" RenderMode="Lightweight"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlTable" ErrorMessage="Please Select Table" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                       <div class="col-lg-2 form-group">
                                        <label class="control-label col-lg-12">Active</label>
                                        <div class="col-lg-12">
                                            <asp:CheckBox ID="chkActive" runat="server" />
                                        </div>
                                    </div>
                          </div>
                 
                            </telerik:RadAjaxPanel>
                           
    
    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
    
    
        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                       <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
    ID="grvRpt" GridLines="None"
    ShowFooter="True" AllowSorting="True"
    OnNeedDataSource="grvRpt_NeedDataSource"
    OnItemCommand="grvRpt_ItemCommand"
    OnItemDataBound="grvRpt_ItemDataBound"
    AllowFilteringByColumn="false"
    ClientSettings-Resizing-ClipCellContentOnResize="true"
    EnableAjaxSkinRendering="true"
    AllowPaging="true" PageSize="200" CellSpacing="0">
    <ClientSettings>
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
    </ClientSettings>
    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
        ShowFooter="false" DataKeyNames="pfm_ID"
        EnableHeaderContextMenu="true">
        <Columns>

           

            

            <telerik:GridBoundColumn DataField="pfm_Settingname" AllowFiltering="true" HeaderStyle-Width="50px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Setting" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfm_Settingname">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="pfm_type" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="pfm_type" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfm_type" Display="false">
            </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="pfm_ColumnValue" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="pfm_ColumnValue" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfm_ColumnValue" Display="false" >
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="pfm_ColumnName" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="pfm_ColumnName" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfm_ColumnName" Display="false" >
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="pfm_ValueText" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="pfm_ValueText" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfm_ValueText" Display="false" >
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="pfm_delimiter" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="pfm_delimiter" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="pfm_delimiter" Display="false" >
            </telerik:GridBoundColumn>

            <telerik:GridTemplateColumn AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Setting Value" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="SettingValue">
                <ItemTemplate>
                <div style="display: flex; align-items: center;">
                    <telerik:RadCheckBoxList ID="cbl" runat="server" Visible="false" Direction="Horizontal" AutoPostBack="false">
                    </telerik:RadCheckBoxList>
                    <telerik:RadRadioButtonList ID="rbl" runat="server" Visible="false" Direction="Horizontal" AutoPostBack="false" OnSelectedIndexChanged="rbl_SelectedIndexChanged">
                    </telerik:RadRadioButtonList>
                    <telerik:RadNumericTextBox ID="txtN" runat="server" Visible="false" Direction="Horizontal" AutoPostBack="false">
                    </telerik:RadNumericTextBox>
                    <telerik:RadTextBox ID="txtT" runat="server" Visible="false" Direction="Horizontal" AutoPostBack="false">
                    </telerik:RadTextBox>
                   </div>
                </ItemTemplate>
              </telerik:GridTemplateColumn>

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
                </div>
                 </div>
             </div>
     </div>
       
    
     
      <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" style="height:auto" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure want to Confirm..??
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
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
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
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
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
    
    
   <style>
        .gridbold{
            font-weight:bolder;
            font-size:12px;
            color:blue !important;
        }
        
        
        
    </style>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
