<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListcustomerFOCDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListcustomerFOCDetail" %>

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
     function Failure(b) {
         $('#modalConfirm').modal('hide');
         $('#kt_modal_1_5').modal('show');
         $('#failure').text(b);
     }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
    
     <asp:LinkButton ID="lnkproceed" Width="100px" runat="server" ValidationGroup="form" OnClick="lnkproceed_Click" UseSubmitBehavior="false"
         Text='<i class="icon-ok"></i>Update' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
 </telerik:RadAjaxPanel>
 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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

                        <!--begin::Form-->
                        <div class="kt-form kt-form--label-right">
                            <div class="card-body" style="background-color: white; padding-bottom: 10px;">



                                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                    <Items>
                                        <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                            <ContentTemplate>
                                                <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px;">
                                                    <table>
                                                        <td style="width: 56%">
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-6 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblCustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                            <div class="col-lg-6 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Created Date:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblCreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <%--<div class="col-lg-12 mb-2">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Created By:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblCreatedBy" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>--%>
                                                    

                                                        </td>
                                                        <td>

                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">From Date:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblfromdate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>


                                                            <div class="col-lg-6 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">To Date:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lbltodate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div>
                                                                <label><asp:label class="control-label col-lg-12 " runat="server" Font-Bold="true" >Change To Date to :</asp:label></label>
<div class="col-lg-4" style="padding-bottom:5px;">
    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdEndDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
    </telerik:RadDatePicker>
   <%-- <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdEndDate" ControlToCompare="lblfromdate" ErrorMessage="End date must be greater"
        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>--%>
</div>
                                                            </div>


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
                                    AllowFilteringByColumn="false"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="cfd_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>
                                             <telerik:GridBoundColumn DataField="cfd_ID" AllowFiltering="true" HeaderStyle-Width="60px"
     HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
     HeaderStyle-Font-Bold="true" UniqueName="cfd_ID" Display="false">
 </telerik:GridBoundColumn>
                                          
                                            <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                            </telerik:GridBoundColumn>
                                            
                                            <telerik:GridTemplateColumn UniqueName="cfd_TotalQty" AllowFiltering="false" HeaderStyle-Width="60px"
                                                HeaderText="Total Qty" FilterControlWidth="80%" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" >
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="cfd_TotalQty" runat="server" Filter="Contains" NumberFormat-AllowRounding="false" DecimalDigits="0" OnTextChanged="cfd_TotalQty_TextChanged" AutoPostBack="true" 
                                                        Width="100%" RenderMode="Lightweight">
                                                    </telerik:RadNumericTextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="cfdTotalQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Total Qty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cfdTotalQty" Display="false">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cfd_soldQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="FOC given Qty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cfd_soldQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cfd_BalanceQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Balance Qty" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cfd_BalanceQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
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
                        </div>
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
                      <asp:LinkButton ID="save" runat="server" Text="Yes" CssClass="btn btn-sm fw-bold btn-primary" OnClick="save_Click" />
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
                  <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
              </div>
          </div>
      </div>
  </div>
  <!--end::SuccessModal-->

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
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>
              </div>
          </div>
      </div>
  </div>
  <!--end::FailedModal-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
