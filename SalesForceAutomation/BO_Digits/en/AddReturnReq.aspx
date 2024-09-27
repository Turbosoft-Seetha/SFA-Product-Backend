<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddReturnReq.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddReturnReq" %>
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
        function RequiredModal() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_0').modal('show');
        }
        function failedModal() {
           
            $('#kt_modal_1_9').modal('show');

         }
         function CompareModel() {

             $('#kt_modal_1_10').modal('show');

         }
         function CompareModel1() {

             $('#kt_modal_1_11').modal('show');

         }
         function UOMValidation1() {

             $('#uomvalidation1').modal('show');

         }
         function UOMValidation2() {

             $('#uomvalidation2').modal('show');

         }
         function UOMValidation3() {

             $('#uomvalidation3').modal('show');

         }
         function CompareModel2() {

             $('#kt_modal_1_12').modal('show');

         }

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                 <asp:LinkButton ID="LinkButton2" Width="100px" runat="server"
                                    Text="Cancel"  
                                    CausesValidation="False" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="LinkButton2_Click" />
                          

                                <asp:LinkButton ID="LinkButton1" Width="100px" runat="server" ValidationGroup="form" OnClick="LinkButton1_Click" UseSubmitBehavior="false" 
                                    Text='<i class="icon-ok"></i>Proceed' CssClass="btn btn-sm fw-bold btn-primary"   CausesValidation="true" />
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
     <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <br />
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <%--<div class="kt-portlet__head" style="padding-top: 20px">

                       
                    </div>--%>
                   

                    <div class="kt-portlet__body">
                         <telerik:RadAjaxPanel ID="cdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                           
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                      <div class="col-lg-12 row">
                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Route <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlroute" runat="server" EmptyMessage="Select Route Name" RenderMode="Lightweight" AutoPostBack="true" OnSelectedIndexChanged="ddlroute_SelectedIndexChanged"
                                        CausesValidation="false" Width="100%" Filter="Contains">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="ddlroute" ErrorMessage="Please select Route Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Customer <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlCus" runat="server"  Width="100%" EmptyMessage="Select Customer" RenderMode="Lightweight" Filter="Contains" AutoPostBack="true"
                                        CausesValidation="false"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="ddlCus" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True" InitialValue="Select Route"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Return <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlReturn" runat="server" Width="100%" DefaultMessage="Select Return Type" RenderMode="Lightweight" AutoPostBack="true">
                                        <Items>
                                            <telerik:DropDownListItem Text="Good Return" Value="GR" />
                                            <telerik:DropDownListItem Text="Bad Return" Value="BR" />
                                           
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                          

                      <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Type <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlType" runat="server" Width="100%" DefaultMessage="Select Type" RenderMode="Lightweight" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                        <Items>
                                            <telerik:DropDownListItem Text="With Invoice" Value="I" />
                                            <telerik:DropDownListItem Text="Without Invoice" Value="OI" />
                                           
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                           <asp:PlaceHolder ID="ddlinv" runat="server" Visible="false">
                         <div class="col-lg-3 mt-3 form-group">
                                <label class="control-label col-lg-12">Invoice ID </label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlinvID" runat="server" EmptyMessage="Select Invoice ID" RenderMode="Lightweight" AutoPostBack="true" OnSelectedIndexChanged="ddlinvID_SelectedIndexChanged"
                                        CausesValidation="false" Width="100%" Filter="Contains">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="ddlinvID" ErrorMessage="Please select Invoice ID" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                                </asp:PlaceHolder>

                         

    </div>

                             <br>
                           
                             

                                      <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                     <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                     <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                         ID="grvRpt" GridLines="None" OnSelectedIndexChanged="grvRpt_SelectedIndexChanged"
                         ShowFooter="True" AllowSorting="True"
                         OnNeedDataSource="grvRpt_NeedDataSource"
                         OnItemDataBound="grvRpt_ItemDataBound1"
                         
                         AllowFilteringByColumn="true"
                         ClientSettings-Resizing-ClipCellContentOnResize="true"
                         EnableAjaxSkinRendering="true"
                         AllowPaging="true" PageSize="100" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                         <ClientSettings>
                             <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                         </ClientSettings>
                         <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                             ShowFooter="false" DataKeyNames="prd_ID"
                             EnableHeaderContextMenu="true">
                             <Columns>

                               

                                  <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="50px"
                                     HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                     HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                 </telerik:GridBoundColumn>


                                 <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                     HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                     HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                 </telerik:GridBoundColumn>


                                     <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="140px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                    </telerik:GridBoundColumn>

                                 
                                  <telerik:GridBoundColumn DataField="ind_HigherUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_HigherUOM">
                                    </telerik:GridBoundColumn>
                                   <telerik:GridBoundColumn DataField="ind_HigherQty"  AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Eligible Higher Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_HigherQty">
                                    </telerik:GridBoundColumn>

                                   <telerik:GridTemplateColumn HeaderStyle-Width="140px" AllowFiltering="false" UniqueName="txteligible" HeaderText="Requested Return Higher Qty"   HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                     <ItemTemplate>
                                         <telerik:RadNumericTextBox ID="txteligible" Width="100px" OnTextChanged="txteligible_TextChanged"   AutoPostBack="true" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                         </telerik:RadNumericTextBox>
                                      
                                     </ItemTemplate>
                                 </telerik:GridTemplateColumn>


                                   <telerik:GridBoundColumn DataField="ind_LowerUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_LowerUOM">
                                    </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="ind_LowerQty" AllowFiltering="true" HeaderStyle-Width="70px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Eligible Lower Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_LowerQty">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="HUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="H UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" Display="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="HUOM">
                                    </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="LUOM" AllowFiltering="true" HeaderStyle-Width="70px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="L UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" Display="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="LUOM">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" UniqueName="txtLqnty" HeaderText="Requested Return Lower Qty"   HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                     <ItemTemplate>
                                         <telerik:RadNumericTextBox ID="txtLqnty" Width="100px" OnTextChanged="txtLqnty_TextChanged"   AutoPostBack="true" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                         </telerik:RadNumericTextBox>
                                      
                                     </ItemTemplate>
                                 </telerik:GridTemplateColumn>

                                  <telerik:GridTemplateColumn  HeaderText="Higher UOM" UniqueName="HigherUOM" HeaderStyle-Width="120px">
                                   <ItemTemplate>
                                 
                                        <telerik:RadComboBox ID="ddlHUom" runat="server" AutoPostBack="true" EmptyMessage="Select Higher UOM" Width="100%" 
                                            RenderMode="Lightweight" OnSelectedIndexChanged="ddlHUom_SelectedIndexChanged">
                                        </telerik:RadComboBox>

                                    </ItemTemplate>
                                  </telerik:GridTemplateColumn>

                                  <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="Eligible Qty" UniqueName="txteHqty"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                     <ItemTemplate>
                                         <telerik:RadNumericTextBox ID="txteHqty" Width="100px"    AutoPostBack="true" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                         </telerik:RadNumericTextBox>
                                      
                                     </ItemTemplate>
                                 </telerik:GridTemplateColumn>
                                  <telerik:GridTemplateColumn  HeaderText="Lower UOM" UniqueName="LowerUOM" HeaderStyle-Width="120px">
                                   <ItemTemplate>
                                 
                                        <telerik:RadComboBox ID="ddlLuom" runat="server" AutoPostBack="true" EmptyMessage="Select Lower UOM" Width="100%" 
                                            RenderMode="Lightweight" CausesValidation="false">
                                        </telerik:RadComboBox>

                                    </ItemTemplate>
                                  </telerik:GridTemplateColumn>

                                 
                                   <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="Lower Qty"  UniqueName="ddlLqty"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                     <ItemTemplate>
                                         <telerik:RadNumericTextBox ID="ddlLqty" Width="100px"  AutoPostBack="true" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                         </telerik:RadNumericTextBox>
                                      
                                     </ItemTemplate>
                                 </telerik:GridTemplateColumn>


                               
                                    <telerik:GridTemplateColumn  HeaderText="Reason" UniqueName="rsncode" HeaderStyle-Width="150px" >
  <ItemTemplate>

       <telerik:RadComboBox ID="ddlrsn" runat="server" AutoPostBack="true" EmptyMessage="Select Reason" Width="100%" 
           RenderMode="Lightweight">
       </telerik:RadComboBox>

   </ItemTemplate>
 </telerik:GridTemplateColumn>

                                

                              

                             </Columns>
                         </MasterTableView>
                         <PagerStyle AlwaysVisible="true" />
                         <GroupingSettings CaseSensitive="false" />
                         <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                             <Resizing AllowColumnResize="true"></Resizing>
                             <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                         </ClientSettings>
                     </telerik:RadGrid>

                             

                          
                        </telerik:RadAjaxPanel>
                         <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
    

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true" style="height:auto;">
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
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
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
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
    <div class="modal fade" id="kt_modal_1_0" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Ooops..!</h5>
            </div>
            <div class="modal-body">
                <p>You must enter Quantity for all checked items.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_0);">OK</button>
            </div>
        </div>
    </div>
</div>
      <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">No selection found..!</h5>
              </div>
              <div class="modal-body">
                  <span>Atleast Select one Item..</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
              </div>
          </div>
      </div>
  </div>

     <div class="modal fade" id="kt_modal_1_10" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span>Entered requested return higher qty is greater than the eligible higher qty. Kindly enter equal or lesser value ..</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_10);">OK</button>
              </div>
          </div>
      </div>
  </div>

     <div class="modal fade" id="kt_modal_1_11" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span>Entered requested return lower qty is greater than the eligible lower qty. Kindly enter equal or lesser value ..</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_11);">OK</button>
              </div>
          </div>
      </div>
  </div>

      <div class="modal fade" id="kt_modal_1_12" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span>Entered requested return  qty is greater than the eligible  qty. Kindly enter equal or lesser value ..</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_12);">OK</button>
              </div>
          </div>
      </div>
  </div>

    <%--uomvalidation1--%>
    <div class="modal fade" id="uomvalidation1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span> Please add atleast one uom for each item</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation1);">OK</button>
              </div>
          </div>
      </div>
  </div>
    <%--uomvalidation2--%>
    <div class="modal fade" id="uomvalidation2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span> Please add quanity for the uom</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation2);">OK</button>
              </div>
          </div>
      </div>
  </div>
     <%--uomvalidation3--%>
    <div class="modal fade" id="uomvalidation3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span> Please add any quantity</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation3);">OK</button>
              </div>
          </div>
      </div>
  </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
