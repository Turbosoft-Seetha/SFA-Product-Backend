<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AssetRemoveReqApproval.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AssetRemoveReqApproval" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">

        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Reject() {
            $('#kt_modal_1_2').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function failedModal(b) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#failtext').text(b);
        }
        function failedModals() {


            $('#kt_modal_1_7').modal('show');


        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

        <asp:LinkButton ID="lnkReject" Width="100px" runat="server"
            Text="Reject" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" OnClick="lnkReject_Click" />
        <asp:LinkButton ID="lnkApprove" Width="100px" runat="server" ValidationGroup="form" OnClick="lnkApprove_Click" UseSubmitBehavior="false" Text="Approve"
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
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
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <!--begin::Form-->
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                         
                                       OnItemDataBound="grvRpt_ItemDataBound"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="arq_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>
                                                <telerik:GridClientSelectColumn HeaderStyle-Width="30px" UniqueName="chkAll"></telerik:GridClientSelectColumn>


                                                   <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                       HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                       CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                       HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                   </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Route" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="Route">
                                                    </telerik:GridBoundColumn>

                                                 <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                         HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                         HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                     </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                </telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                          HeaderStyle-Font-Size="Smaller" HeaderText="Request Date" FilterControlWidth="100%"
                                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                          HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                      </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Asset Serial No" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="atm_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Reference Name" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="atm_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ast_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Asset Type" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="ast_Name">
                                                </telerik:GridBoundColumn>

                                             

                                                  <telerik:GridBoundColumn DataField="arq_cus_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                      HeaderStyle-Font-Size="Smaller" HeaderText="arq_cus_ID" FilterControlWidth="100%"
                                                      CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                      HeaderStyle-Font-Bold="true" UniqueName="arq_cus_ID" Display="false">
                                                  </telerik:GridBoundColumn>

                                                

                                                <telerik:GridBoundColumn DataField="rsn_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Reason" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rsn_Name">
                                                </telerik:GridBoundColumn>

                                              

                                                <telerik:GridBoundColumn DataField="rsn_Type" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Reason Type" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rsn_Type" Display="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="arq_Remarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="arq_Remarks">
                                                </telerik:GridBoundColumn>

                                                      <telerik:GridBoundColumn DataField="arq_img" AllowFiltering="true" HeaderStyle-Width="100px" Display="false"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="arq_img">
                                                        </telerik:GridBoundColumn>
                                                  <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Images" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
      <ItemTemplate>
      </ItemTemplate>
  </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="arq_Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="arq_Status" Display="false">
                                                </telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn DataField="arq_ast_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="arq_ast_ID" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="arq_ast_ID" Display="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="arq_asc_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="asc_ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="arq_asc_ID" Display="false">
                                                    </telerik:GridBoundColumn>





                                                <%-- <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                </telerik:GridBoundColumn>--%>
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
                            </div>
                        </telerik:RadAjaxPanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
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
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
    <!--end::SuccessModal-->
    <!--end::SuccessModal-->
    <div class="modal fade modal-center" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="Reject">Are you sure you want to Reject..??
                </h5>
            </div>
            <div class="modal-footer">
                <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                    <asp:LinkButton ID="btnRejectSave" runat="server" Text="Yes" OnClick="btnRejectSave_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                    BackColor="Transparent"
                    ForeColor="Blue">
                    <div class="col-lg-12 text-center mt-5">
                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                    </div>
                </telerik:RadAjaxLoadingPanel>
                <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
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
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
