<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="MaterialReqApprovalDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.MaterialReqApprovalDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">

        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm11').modal('hide');
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#kt_modal_1_2').modal('hide');
            $('#success').text(a);
           
        }
        function RequiredModal() {
            $('#kt_modal_1_0').modal('show');
        }
        function failedModal(b) {
            $('#kt_modal_1_5').modal('show');          
            $('#failtext').text(b);
        }
        function failedModal2(b) {   
            $('#kt_modal_1_5').modal('show');   
            $('#kt_modal_1_2').modal('hide');
            $('#failtext').text(b);
        }

        function failedModals() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');           
            $('#kt_modal_1_5').modal('hide'); 
            $('#kt_modal_1_2').modal('show');
            $('#kt_modal_1_9').modal('show');


        }
        function Confimmodel() {
            $('#modalConfirm11').modal('show');
        }

        function Reject() {
            $('#kt_modal_1_2').modal('show');
        }
        function cancelModal() {
            $('#kt_modal_1_2').modal('hide');
        }
       
        
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

        <asp:LinkButton ID="lnkReject" Width="100px" runat="server"
            Text="Reject" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" OnClick="lnkReject_Click" />
        <asp:LinkButton ID="lnkUnHold" Width="100px" runat="server"
            Text="UnHold" CssClass="btn btn-sm fw-bold btn-warning"
            CausesValidation="False" OnClick="lnkUnHold_Click" Visible="false" />
        <asp:LinkButton ID="lnkapvHold" Width="150px" runat="server"
            Text="Approve and Hold" CssClass="btn btn-sm fw-bold btn-warning"
            CausesValidation="False" OnClick="lnkapvHold_Click" />
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <style>
         .rwzNav{
             display:none;
         }

       .RadPicker .rcCalPopup, .RadPicker .rcTimePopup {
    display:inline;
}

       .RadInput_Material {
               padding: 8px 13px;
       }

       /* .RadComboBox .rcbActionButton {
            border-width: 11px 0 0 1px;
        }
        .RadComboBox_Material .rcbInner {
            padding: 25px 50px 8px 13px;
        }*/
        </style>
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
       
        <div class="col-lg-12 row mb-4">
             <asp:PlaceHolder ID="pnlwar" runat="server">
            <div class="col-lg-2">
                <label class="control-label col-lg-12">Change Picking Location<span class="required"></span></label>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="ddlWarehouse" runat="server" Width="100%" EmptyMessage="Please Select " RenderMode="Lightweight" Filter="Contains"
                        CausesValidation="true" ValidationGroup="form">
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="form" runat="server"
                        ControlToValidate="ddlWarehouse" ErrorMessage="Please choose one " ForeColor="Red" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                </div>
            </div>
            </asp:PlaceHolder>
             <asp:PlaceHolder ID="phApp" runat="server">
             <div class="col-lg-2">
                <label class="control-label col-lg-12">Change Receiving Location<span class="required"></span></label>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="ddlRecLoc" runat="server" Width="100%" EmptyMessage="Please Select " RenderMode="Lightweight" Filter="Contains"
                        CausesValidation="true" ValidationGroup="form">
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="form" runat="server"
                        ControlToValidate="ddlRecLoc" ErrorMessage="Please choose one " ForeColor="Red" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                </div>
            </div>
             <div class="col-lg-2">
                <label class="control-label col-lg-12">Change Exp. Date<span class="required"></span></label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdExpDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                        </telerik:RadDatePicker>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Exp Date is mandatory" ForeColor="Red" ControlToValidate="rdExpDate" ValidationGroup="form"></asp:RequiredFieldValidator>
                    
                </div>
            </div>
</asp:PlaceHolder>
        </div>

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet" style="background-color: white; padding: 20px;">



                        <!--begin::Form-->
                        <div class="kt-form kt-form--label-right">

                            <div class="kt-portlet__body pb-0">

                                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                    <Items>
                                        <telerik:RadPanelItem Font-Bold="true" Expanded="True" BackColor="#F2F6F9">

                                            <ContentTemplate>
                                                <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid">
                                                    <table>

                                                        <td style="width: 70%">


                                                            <div class="col-lg-6 mb-2 ms-4">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Date&Time:</label>
                                                                <label class="col-lg4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                            <div class="col-lg-6 mb-2 ms-4">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Exp. Date:</label>
                                                                <label class="col-lg4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblExpDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>


                                                        </td>
                                                         <td >


                                                            <div class="col-lg-8 mb-2 ">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Receiving Location:</label>
                                                                <label class="col-lg-6 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblStore" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                            <div class="col-lg-8 mb-2 ">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Picking Location:</label>
                                                                <label class="col-lg-6 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblWarehouse" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>


                                                        </td>
                                                    </table>


                                                </div>

                                            </ContentTemplate>
                                        </telerik:RadPanelItem>
                                    </Items>
                                </telerik:RadPanelBar>
                            </div>
                          
                            <div class="kt-portlet__body">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    OnItemDataBound="grvRpt_ItemDataBound"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true" ScrollHeight="500px">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="mrd_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="prd_ID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ReqHUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. HUOM" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ReqHUOM">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="RequestedHQty" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. HQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="RequestedHQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="90px" AllowFiltering="false" HeaderText="Approved HQty" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtAdjustedHQty" Width="100%" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                                    </telerik:RadNumericTextBox>


                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="ReqLUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. LUOM" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ReqLUOM">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="RequestedLQty" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Req. LQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="RequestedLQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>





                                            <telerik:GridTemplateColumn HeaderStyle-Width="90px" AllowFiltering="false" HeaderText="Approved LQty" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtAdjustedLQty" Width="100%" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                                    </telerik:RadNumericTextBox>


                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="AdjustedLQty" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AdjustedLQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="AdjustedLQty" Display="false">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AdjustedHQty" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AdjustedHQty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="AdjustedHQty" Display="false">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>


                                        </Columns>
                                    </MasterTableView>
                                    <GroupingSettings CaseSensitive="false" />
                                    <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                        <Resizing AllowColumnResize="true"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>

    <div class="clearfix"></div>

    <!--begin::SuccessModal-->
<div class="modal fade" id="kt_modal_1_4" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
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
   <style>   
    .modal-open .modal-backdrop {
        pointer-events: none;
    }
</style>


    <!--end::SuccessModal-->
    <!--begin::FailedModal-->
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

    <!--end::FailedModal-->

    <div class="modal fade modal-center" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Reject">Are you sure you want to Reject..??
                    </h5>
                </div>

                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-12 form-group">
                                   <label class="control-label col-lg-12">Remark</label>
                                   <div class="col-lg-12">
                                       <textarea id="txtRemarks" runat="server" style="width: 100%;" rows="4" cols="50" class="form-control" causesvalidation="false"></textarea>
                                   </div>
                               </div>

                    </div>

                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                        <asp:LinkButton ID="btnRejectSave" runat="server" Text="Yes" OnClick="btnRejectSave_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
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

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>

