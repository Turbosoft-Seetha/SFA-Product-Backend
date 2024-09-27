<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OrderDetailListing.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OrderDetailListing" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
 function Assign() {

 $('#kt_modal_1_7').modal('show');
     }
     function successModal(a) {
         $('#modalConfirm').modal('hide');
         $('#kt_modal_1_7').modal('hide');
         $('#kt_modal_1_0').modal('hide');
         $('#kt_modal_1_4').modal('show');
         $('#success').text(a);
     }
     function failedModal(b) {
         $('#kt_modal_1_7').modal('hide');
         $('#kt_modal_1_5').modal('show');
         $('#failtext').text(b);
     }
     function failedModals() {
         $('#kt_modal_1_3').modal('hide');
         $('#kt_modal_1_4').modal('hide');
         $('#kt_modal_1_5').modal('hide');
         $('#kt_modal_1_6').modal('hide');
         $('#kt_modal_1_7').modal('hide');
         $('#kt_modal_1_9').modal('show');
     }
     </script>
</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
     <asp:linkbutton  ID="btnConfirm" Visible="true" CssClass="btn btn-sm btn-light-primary me-2"  runat="server" onClick="btnConfirm_Click" >Confirm Order
   </asp:linkbutton>
    <asp:linkbutton  ID="Linkbtn1" Visible="true" CssClass="btn btn-sm btn-primary me-2"  runat="server" onClick="Linkbtn1_Click" >Modify Items
      </asp:linkbutton>
                   </telerik:RadAjaxPanel>
<telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
    BackColor="Transparent"
    ForeColor="Blue">
    <div class="col-lg-12 text-center mt-5">
        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
    </div>
</telerik:RadAjaxLoadingPanel>
       <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color:white; padding:20px;">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
              <%--  <a href="OrderDetail.aspx">OrderDetail.aspx</a>--%>
                <div class="kt-portlet">




                   



                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body" ">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">


                                <!--begin::Form-->
                                <div class="kt-form kt-form--label-right">
                                     <div class="card-body" style="background-color:white; padding-bottom:10px;">
                               <div class="kt-portlet__head-actions" style=" text-align-last: end;">


                         
                        </div>

                                        <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                            <Items>
                                                <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                                    <ContentTemplate>
                                                        <div class="kt-portlet__body" style="background-color: white; display: grid ;padding-left:20px;">
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
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Created By:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblCreatedBy" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                     <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Pay Mode:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblpaymode" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>



                                                                </td>
                                                                <td>

                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Discount:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblDis" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">SubTotal:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblSub" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>

                                                                     <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Line Total:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lbllinetotal" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>

                                                                    <div class="col-lg-6 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">VAT:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblvat" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Grand Total:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblGrand" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>

                                                                </td>
                                                            </table>


                                                        </div>

                                                    </ContentTemplate>
                                                </telerik:RadPanelItem>
                                            </Items>
                                        </telerik:RadPanelBar>
                                    </div>
                                    <!--end: Search Form -->
                                    
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" >
                                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                        <%--<div class="kt-portlet__body">--%>
                                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                            ID="grvRpt" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="grvRpt_NeedDataSource"
                                            OnItemCommand="grvRpt_ItemCommand"
                                            AllowFilteringByColumn="false"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="odd_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>



                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="false" HeaderStyle-Width="110px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Code"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="false" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Product"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="odd_HigherUOM" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherUOM">
                                                    </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="odd_HigherQty" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherQty">
                                                           <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="odd_LowerUOM" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerUOM">
                                                    </telerik:GridBoundColumn>

                                                    

                                                    <telerik:GridBoundColumn DataField="odd_LowerQty" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerQty">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="odd_HigherPrice" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher Price"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherPrice">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="odd_LowerPrice" AllowFiltering="false" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower Price"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerPrice">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>



                                                    <telerik:GridBoundColumn DataField="odd_Price" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Price">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_Discount" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Discount"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Discount">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_SubTotal" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Sub Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_SubTotal">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_VATAmount" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="VAT"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_VATAmount">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_GrandTotal" AllowFiltering="false" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Line Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_GrandTotal">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                    <%--<telerik:GridBoundColumn DataField="odd_ReturnPieceQty" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Return Piece Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="odd_ReturnPieceQty">
                                    </telerik:GridBoundColumn>
                                    


                                    <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Status">
                                    </telerik:GridBoundColumn>--%>
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
        </div>
    </div>
</div>
    <div class="modal fade" id="kt_modal_1_7" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Assign Route</h5>
                </div>
                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row">
                      
                            <div class="col-lg-6">
                                <label class="control-label">Route<span class="required"></span></label>
                                <telerik:RadComboBox ID="ddlRoute" runat="server" EmptyMessage="Select Route" Width="100%" Filter="Contains" RenderMode="Lightweight" CausesValidation="false"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="frm" ControlToValidate="ddlRoute" ErrorMessage="Please Select Route" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-lg-6">
                                <label class="control-label">Exp. Delivery Date</label>
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdExpDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"></telerik:RadDatePicker>
                            </div>
                        </div>
                

                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

                        <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="btn btn-sm fw-bold btn-success" ValidationGroup="frm" CausesValidation="true" OnClick="lnkSubmit_Click">
                                                    Confirm
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <br />
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_7);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
        <div class="modal fade" id="kt_modal_1_4" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Success</h5>
            </div>
            <div class="modal-body">
                <span id="success"></span>
            </div>
            <div class="modal-footer">
                <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
            </div>
        </div>
    </div>
</div>
  
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
</asp:Content>
