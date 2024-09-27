<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListUserWorkFlow.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListUserWorkFlow" %>
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
         function Confm() {
             $('#modalConfirm1').modal('show');
         }
         function Succces(cd) {
             $('#modalConfirm1').modal('hide');
             $('#kt_modal_1_8').modal('show');
             $('#Success1').text(cd);
         }

         function delConfim() {
             $('#modaldelConfirm').modal('show');

         }

         function successModal() {
             $('#modaldelConfirm').modal('hide');
             $('#kt_modal_1_7').modal('show');
         }


         function Failure(b) {
             $('#kt_modal_1_5').modal('show');
             $('#failure').text(b);
         }

     </script>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

    <asp:LinkButton ID="lnkcancel" runat="server" CssClass="btn btn-sm fw-bold btn-secondary"   Text="Cancel" OnClick="lnkcancel_Click"></asp:LinkButton>
                                   
                                 
                                <asp:LinkButton ID="lnkAdd" runat="server" Text='<i class="icon-ok"></i>Confirm' CssClass="btn btn-sm fw-bold btn-primary" 
                                    OnClick="lnkAdd_Click" CausesValidation="true" ValidationGroup="frm"></asp:LinkButton>
                                
                                   </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>    
</asp:Content>--%>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>   
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
<AjaxSettings>
    
    <telerik:AjaxSetting AjaxControlID="AddItem">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
    <%--<telerik:AjaxUpdatedControl ControlID="pnls" />--%>

     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


      <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid" >
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    
                   
                    <!--begin::Forkt-->
                     <div class="kt-portlet__body">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">


                            <div class="col-lg-12 row">

                                 <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">Workflow <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlWorkflow" runat="server" Width="100%" EmptyMessage="Select Workflow" Filter="Contains" AutoPostBack="true" RenderMode="Lightweight" OnSelectedIndexChanged="ddlWorkflow_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlWorkflow" ErrorMessage="Please choose Workflow" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                              

                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">Current Level  <span class="required"> </span></label>
                                    <div class="col-lg-12">

                                        <telerik:RadComboBox ID="ddllevel" runat="server" AutoPostBack="true" EmptyMessage="Select Level" Width="100%" Filter="Contains" RenderMode="Lightweight" >
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddllevel" ErrorMessage="Please choose current level" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>


                                 <div class="col-lg-2" style="text-align: center; padding-top: 20px;">
                                        <asp:LinkButton ID="AddItem" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="AddItem_Click" ValidationGroup="form" CausesValidation="true"  BackColor="#DAE9F8" ForeColor="#009EF7">
                                                    ADD 
                                        </asp:LinkButton>
                                    </div>

                            </div>
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                        <!--end::Form-->
                    </div>
                  <%--  <asp:PlaceHolder ID="pnls" runat="server" Visible="true">
                   --%>     <!--Detail header-->
                        <div class="kt-portlet__head" style="padding-top: 30px; padding-bottom: 20px;">
                            <div class="kt-portlet__head-label">
                                <h3 class="kt-portlet__head-title">Details
                                </h3>
                            </div>
                        </div>
                        <!--End Detail header-->
                        <!--Detail Body-->
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                <div class="col-lg-12 row">

                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        OnItemCommand="grvRpt_ItemCommand"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                 <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Delete" ID="Deletebtn" Visible="true" AlternateText="Delete" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                                <telerik:GridBoundColumn DataField="wfm_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Workflow" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="wfm_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="uwl_level" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Current Level" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="CurrentLevel">
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
                   <%-- </asp:PlaceHolder>--%>
                </div>
            </div>
        </div>
    </div>
             </div>




       <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

      <%--delete--%>
    <div class="modal fade modal-center" id="modaldelConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnConfrmDelete" runat="server" Text="Yes" OnClick="BtnConfrmDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Data Deleted Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="delOk" runat="server" OnClick="delOk_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
</asp:Content>
