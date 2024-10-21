<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="LoadRequestDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.LoadRequestDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess() {
            $('#modalConfirm').modal('hide');
            $('#modalConfirmApr').modal('hide');
            $('#kt_modal_1_4').modal('show');
        }
        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#modalConfirmApr').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm11').modal('hide');
            $('#modalConfirm').modal('hide');
            $('#modalConfirmApr').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#kt_modal_1_2').modal('hide');
            $('#success').text(a);
        }
        function successModal(b) {
            $('#modalConfirm11').modal('hide');
            $('#modalConfirm').modal('hide');
            $('#modalConfirmApr').modal('hide');
            $('#kt_modal_1_7').modal('show');
            $('#kt_modal_1_2').modal('hide');
            $('#success').text(b);
        }
        function failedModal(b) {
            $('#kt_modal_1_5').modal('show');
            $('#failtext').text(b);
        }
        function Reject() {
            $('#kt_modal_1_2').modal('show');
        }
        function cancelModal() {
            $('#kt_modal_1_2').modal('hide');
        }

      
        function ConfimExcel() {
                $('#modalConfirmpdf').modal('show');
        }
            function Confimclose() {
                $('#modalConfirm').modal('hide');
        }
        function ConfimApr(a) {
            $('#modalConfirmApr').modal('show');
            $('#confirmApr').text(a);
        }
    
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

 
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
             <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/file.png" Style="height: 30px; padding-top: 2px; padding-left: 20px;" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

        <asp:LinkButton ID="lnkApprove" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" BackColor="#50cd89" OnClick="lnkApprove_Click">
                                                    Approve
        </asp:LinkButton>
        <asp:LinkButton ID="lnkReject" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" BackColor="#d9214e" OnClick="lnkReject_Click">
                                                    Reject
        </asp:LinkButton>
    </telerik:RadAjaxPanel>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid">
                                                <table>
                                                    <td style="width: 56%" >
                                                        <tr>
                                                            <div class="col-lg-12 mb-2 row" style="padding-left: 11px; padding-top: 8px;">
                                                        <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                          <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Expected Date:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRQDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                         <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Status:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblStatus" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        </div>
                                                        </tr>
                                                        
                                                        
                                                    </td>
                                                    
                                                </table>


                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </div>
                        <div class="kt-portlet__body pb-0">
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemDataBound="grvRpt_ItemDataBound"
                                OnItemCommand="grvRpt_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="lrd_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        <%-- <telerik:GridTemplateColumn HeaderStyle-Width="30px"  AllowFiltering="false" HeaderText="Remove" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:CheckBox  ID="checkbx" Visible="true" AlternateText="Remove" runat="server"  CheckBoxes="true" EnableCheckAllItemsCheckBox="true" />
                                                </asp:CheckBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Detail">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="lnkLink" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                           <telerik:GridBoundColumn DataField="lrd_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="lrd_ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_ID" Display="false">
                                        </telerik:GridBoundColumn>


                                           <telerik:GridBoundColumn DataField="lrd_prd_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Item ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_prd_ID" Display="false">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="60%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Item" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name"> 
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prd_NameArabic" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Item Arabic Name" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_NameArabic"> 
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="lrd_HUOM" AllowFiltering="true" HeaderStyle-Width="40px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_HUOM" >
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="lrd_HQty" AllowFiltering="true" HeaderStyle-Width="40px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_HQty" >                                             
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Approved HQty" HeaderStyle-Font-Size="Smaller"
                                            HeaderStyle-Font-Bold="true" DataField="lrd_apv_HQty" UniqueName="lrd_apv_HQty" AutoPostBackOnFilter="true">
                                          
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox ID="txt_apv_HQty" Width="100%" runat="server" Enabled="true" 
                                                    Text='<%# Bind("lrd_apv_HQty") %>' NumberFormat-DecimalDigits="0">
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridBoundColumn DataField="lrd_LUOM" AllowFiltering="true" HeaderStyle-Width="40px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_LUOM" >
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="lrd_LQty" AllowFiltering="true" HeaderStyle-Width="40px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_LQty" >
                                           
                                        </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Approved LQty" HeaderStyle-Font-Size="Smaller"
                                            HeaderStyle-Font-Bold="true" DataField="lrd_apv_LQty" UniqueName="lrd_apv_LQty" AutoPostBackOnFilter="true">
                                           
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox ID="txt_apv_LQty" Width="100%" runat="server" Enabled="true" 
                                                    Text='<%# Bind("lrd_apv_LQty") %>' NumberFormat-DecimalDigits="0">
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <%--<telerik:GridBoundColumn DataField="lrd_apv_caseQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Approved caseQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_apv_caseQty" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>--%>

                                        <telerik:GridBoundColumn DataField="lrd_totalQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Qty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_totalQty"  Display="false">
                                            
                                        </telerik:GridBoundColumn>

                                       <%-- <telerik:GridBoundColumn DataField="lrd_apv_HUOM" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Approved HUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_apv_HUOM" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="lrd_apv_HQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Approved HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_apv_HQty" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="lrd_apv_LUOM" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Approved LUOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_apv_LUOM" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>--%>
                                        <%--<telerik:GridBoundColumn DataField="lrd_apv_LQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Approved LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_apv_LQty" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="lrd_apv_totalQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Approved TotalQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lrd_apv_totalQty" ItemStyle-HorizontalAlign="Right">
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
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to Approve..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="Approvenow" runat="server" Text="Yes" OnClick="Approvenow_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button  type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                  <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../assets/media/icons/file.png" Style="height: 30px; padding-top: 2px; padding-left: 20px;" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

                </div>
                <div class="modal-body">
                    <span>Load Request Has Been Approved Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="reset" data-dismiss="modal" class="btn btn-secondary">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade modal-center" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Reject">Reject
                    </h5>
                </div>

                <div class="modal-body">
                    <span>
                         <span>Are you sure you want to Reject..??</span>
                    </span>
                    

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

   <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Load Request Has Been Rejected Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>


     <div class="modal fade modal-center" id="modalConfirmpdf" tabindex="-1" role="dialog"  aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirms">Download from here..
                    </h5>
                </div>
                <div class="modal-body">
                    <span id="body" text=""></span>
                      
                    <div class="col-lg-12 row">
                        <div class="col-lg-3" style="width: max-content;">
                            <asp:LinkButton ID="withapqty" runat="server" Text="With Approved Qty" OnClick="withapqty_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                        </div>
                        <div class="col-lg-3" style="width: max-content;">
                            <asp:LinkButton ID="withoutapqty" runat="server" Text="Without Approved Qty" OnClick="withoutapqty_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                        </div>
                    </div>
                          
                </div>
                   <div class="modal-footer">
     
       <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirmpdf);">OK</button>
   </div>
               
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <div class="modal fade modal-center" id="modalConfirmApr" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmApr"></h5>
            </div>

            <div class="modal-footer">
                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                    <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="Approvenow_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                    BackColor="Transparent"
                    ForeColor="Blue">
                    <div class="col-lg-12 text-center mt-5">
                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                    </div>
                </telerik:RadAjaxLoadingPanel>
                <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirmApr);">Cancel</button>
            </div>
        </div>
    </div>
</div>
</asp:Content>
