<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="PartialDeliveryDetailApproval.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.PartialDeliveryDetailApproval" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
        
        function Confim() {
                $('#modalConfirm').modal('show');
        }
        function successModal(a) {
                $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
         }
         function RequiredModal() {

             $('#kt_modal_1_0').modal('show');
         }
         function failedModal(b) {
             $('#kt_modal_1_5').modal('show');
             $('#failtext').text(b);
         }
         function failedModals() {
             $('#kt_modal_1_3').modal('hide');
             $('#kt_modal_1_4').modal('hide');
             $('#kt_modal_1_5').modal('hide');
            
             $('#kt_modal_1_9').modal('show');


         }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                    
     <asp:LinkButton ID="lnkConfirm" runat="server" ValidationGroup="form" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Confirm'
                                    CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" OnClick="lnkConfirm_Click"/>
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
     <div class="card-body p-8" style="background-color:white;"> 
              <div class="kt-portlet__body pb-0">

                        <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                            <Items>
                                <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">
                                    <ContentTemplate>
                                        <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid;">
                                            <table>

                                                  <td>
                                                    <div class="col-lg-12 my-4 ps-4" >
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Order ID:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblOrderID" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    
                                            
                                                    <div class="col-lg-12 my-4 ps-4">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Route ID:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblRouteID" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    </td>
                                                <td>
                                                     <div class="col-lg-12 my-4 ps-4">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Expct Del Date:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblExpDelDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                             
                                                     <div class="col-lg-12 my-4 ps-4 ">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblcustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    
                                                </td>

                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </telerik:RadPanelItem>
                            </Items>
                        </telerik:RadPanelBar>
                    </div>

              <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">
                   
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"
                                 OnItemDataBound="grvRpt_ItemDataBound"
                                 OnPreRender="grvRpt_PreRender"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="dad_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                      
                                      
                                      
                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="prd_Desc" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Desc" Display="false">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="OrderedHQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderedHQty">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="OrderedLQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Ordered LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="OrderedLQty">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="deliveringHQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Delivery HQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="deliveringHQty">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="DeliveringLQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Delivery LQty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="DeliveringLQty">
                                        </telerik:GridBoundColumn>
                                          <telerik:GridBoundColumn DataField="rsn_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Reason From App" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rsn_Name">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridTemplateColumn UniqueName="DropDownColum" AllowFiltering="false" HeaderStyle-Width="120px"
                                             HeaderText="Reason" FilterControlWidth="100%" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                          <ItemTemplate>
                                           <telerik:RadComboBox ID="ddlReason" runat="server" Filter="Contains" EmptyMessage="Select Reason"
                                               Width="100%" RenderMode="Lightweight">
                                          
                                         </telerik:RadComboBox>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                           <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Actions" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="btn">

                                             <ItemTemplate>
                                                   <asp:RadioButtonList ID="rbActions" runat="server" RepeatDirection="Horizontal" CssClass="radioList">
                                                        <asp:ListItem ID="rdApprove" Text="Approve" Value="A" style="color:blue;padding-right:5px;"/>
                                                        <asp:ListItem ID="rdReject" Text="Reject" Value="R" style="color:Red;"/>
                                                    </asp:RadioButtonList>
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
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>

         </div>

      <%--delete--%>
   <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" style="height:auto;" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
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
    <div class="modal fade" id="kt_modal_1_4" style="height:auto;"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <div class="modal fade" id="kt_modal_1_5" style="height:auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
      <div class="modal fade" id="kt_modal_1_0" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ooops..!</h5>
                </div>
                <div class="modal-body">
                    <p>You must select any  Reason and should do approve or reject for all the items listed here.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_0);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
     <div class="modal fade" id="kt_modal_1_9" style="height:auto;"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
