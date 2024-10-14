<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerConnectSettings.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerConnectSettings" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function failedModals() {          
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_9').modal('show');
            $('#kt_modal_1_1').modal('hide');
        }

        function Failure(b) {
            $('#kt_modal_1_5').modal('show');
            $('#kt_modal_1_1').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_9').modal('hide');
            $('#failure').text(b);
        }
        function Delete() {
            $('#kt_modal_1_6').modal('show');
            $('#kt_modal_1_1').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_9').modal('hide');
        }
        function Success(b) {
            $('#kt_modal_1_1').modal('show');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_9').modal('hide');
            $('#success').text(b);
        }
        function Succcess(a) {           
            $('#kt_modal_1_4').modal('show');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_9').modal('hide');
            $('#Profilesuccess').text(a);
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <br />
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                        <div class="kt-portlet__body">
                            <div class="col-lg-12 row">

                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Parent Node<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlParNode" runat="server" EmptyMessage="Select Parent Node" CausesValidation="false" Width="100%" RenderMode="Lightweight"
                                            Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" OnSelectedIndexChanged="ddlParNode_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlParNode" ErrorMessage="Please Select Parent Node" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Child Node<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlChiNode" runat="server" EmptyMessage="Select Child Node" CausesValidation="false" Width="100%"
                                            Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" RenderMode="Lightweight">
                                        </telerik:RadComboBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlChiNode" ErrorMessage="Please Select Child Node" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
                                    <asp:LinkButton ID="Add" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="Add_Click" RenderMode="Lightweight">Add
                                    </asp:LinkButton>
                                </div>

                                <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
                                    <asp:LinkButton ID="Remove" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="Remove" OnClick="Remove_Click">
                                    </asp:LinkButton>

                                </div>
                            </div>
                            <div class="col-lg-12 row form-group mb-4 pt-7">
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Settings Profile<span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <div style="display: flex; align-items: center; position: relative;">
                                            <telerik:RadDropDownList ID="rdProfile" runat="server" CausesValidation="false" Width="100%" Filter="Contains" RenderMode="Lightweight"
                                                OnSelectedIndexChanged="rdProfile_SelectedIndexChanged" AutoPostBack="true">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Select Profile" Value="0" Selected="true" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:LinkButton ID="ApplyProfile" runat="server"
                                                Text="Apply" CssClass="btn btn-sm fw-bold btn-secondary"
                                                CausesValidation="false" OnClick="ApplyProfile_Click" ValidationGroup="addcus"
                                                Style="margin-left: 10px; height: 30px; padding: 5px 10px; line-height: 20px;" RenderMode="Lightweight" />

                                            <!-- Loader Element -->
                                            <div id="loader" style="display: none; position: absolute; right: 0;">
                                                <img src="../assets/media/icons/loader.gif" alt="Loading..." style="height: 30px;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 form-group mb-4 pt-7">
                                    <asp:LinkButton ID="lblPage" runat="server" OnClick="lblPage_Click" CssClass="control-label col-lg-12" Visible="false">
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <div style="padding: 20px;">

                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="ccs_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>

                                         <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll"> </telerik:GridClientSelectColumn>

                                        <telerik:GridBoundColumn DataField="cac_ParentNodeDesc" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Parent Node" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cac_ParentNodeDesc">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cac_ChildNodeDesc" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Child Node" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cac_ChildNodeDesc">
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

                        <!--End Detail Body-->
                        <!--Delete Anser-->

                        <!--end::Portlet-->
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

       <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failure"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
       <!--begin::FailedModal-->
<div class="modal fade" id="kt_modal_1_1" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Success</h5>
            </div>
            <div class="modal-body">
                <span id="success"></span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_1);">Cancel</button>
            </div>
        </div>
    </div>
</div>
<!--end::FailedModal-->
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
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
             </div>
         </div>
     </div>
 </div>

     <!--begin::ValidationModal-->
 <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title">Are you sure you want to delete ?</h5>
             </div>
             <div class="modal-footer">
                 <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                     <asp:LinkButton ID="lnkDelete" runat="server" OnClick="lnkDelete_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                 Yes
                     </asp:LinkButton>
                 </telerik:RadAjaxPanel>
                 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel10" EnableEmbeddedSkins="false"
                     BackColor="Transparent"
                     ForeColor="Blue">
                     <div class="col-lg-12 text-center mt-5">
                         <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                     </div>
                 </telerik:RadAjaxLoadingPanel>
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">Cancel</button>
             </div>
         </div>
     </div>
 </div>
 <!--end::ValidationModal-->
     <!--begin::SuccessModal-->
 <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title">Success</h5>
             </div>
             <div class="modal-body">
                 <span id="Profilesuccess"></span>
             </div>
             <div class="modal-footer">
                 <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
             </div>
         </div>
     </div>
 </div>
 <!--end::SuccessModal-->
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
