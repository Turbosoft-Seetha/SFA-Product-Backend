<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerSpecialPriceHeader.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerSpecialPriceHeader" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
     
     function delConfim(msg) {
         $('#modaldelConfirm').modal('show');
         $('#delmsg').text(msg);
     }

     function successModal() {
         $('#modaldelConfirm').modal('hide');
         $('#kt_modal_1_7').modal('show');
         }
     function failedModal(res) {
         $('#modaldelConfirm').modal('hide');
             $('#kt_modal_1_2').modal('show');
             $('#failres').text(res);
         }
    


     </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <asp:LinkButton ID="BtnAdd" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" OnClick="BtnAdd_Click" ></asp:LinkButton>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <div class="kt-portlet__body">

                        <div class="kt-portlet__body pb-3">

                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar1" runat="server" Expanded="false" >
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px; padding-top:10px; padding-bottom:10px;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <div>
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer Code :</label>
                                                            
                                                                <asp:Label ID="lblcuscode" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer :</label>

                                                                <asp:Label ID="lblcustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                        </td>

                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>

                        </div>
                    </div>
                        <!--end: Search Form -->
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-portlet__body">
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
                                        ShowFooter="false" DataKeyNames="prh_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>


                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Delete">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="Delete" ID="Delete" Visible="true" AlternateText="Delete" runat="server"
                                                SetFocusOnError="false"
                                                ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                             <telerik:GridBoundColumn DataField="prh_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="prh_ID" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="prh_ID" Display="false">
                                     </telerik:GridBoundColumn>
                                       <telerik:GridBoundColumn DataField="rot_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="rot_ID" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="rot_ID"  Display="false">
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="pricing" AllowFiltering="true" HeaderStyle-Width="100px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="pricing" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="pricing"  Display="false">
                                     </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="prh_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prh_Name" AllowFiltering="true" HeaderStyle-Width="160px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prh_Name">
                                            </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                     </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                     </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="prh_PayMode" AllowFiltering="true" HeaderStyle-Width="150px"
                                         HeaderStyle-Font-Size="Smaller" HeaderText="Payment Mode" FilterControlWidth="100%"
                                         CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                         HeaderStyle-Font-Bold="true" UniqueName="prh_PayMode">
                                     </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="StartDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Start Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="StartDate">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="EndDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="End Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="EndDate">
                                            </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="160px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                        </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="pld_uom_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="UOM" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="pld_uom_ID">
                                         </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_Price" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Standard Price" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="pru_Price">
                                            </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="pld_Price" AllowFiltering="true" HeaderStyle-Width="80px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Special Price" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="pld_Price">
                                         </telerik:GridBoundColumn>
                                            
                                            

                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <PagerStyle AlwaysVisible="true" />
                                    <GroupingSettings CaseSensitive="false" />
                                    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                        <Resizing AllowColumnResize="true"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                    </ClientSettings>
                                </telerik:RadGrid>
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

   
      <div class="modal fade modal-center" id="modaldelConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
             <div class="modal-header">
                     <h5 class="modal-title">Remove</h5>
                 </div>
                 <div class="modal-body">
                     <span id="delmsg"></span>
                 </div>
              <div class="modal-footer">
                  <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                      <asp:LinkButton ID="BtnConfrmDelete" runat="server" Text="Yes" OnClick="BtnConfrmDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                  </telerik:RadAjaxPanel>
                  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
                  <span>Pricing removed Successfully.</span>
              </div>
              <div class="modal-footer">
                  <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
              </div>
          </div>
      </div>
  </div>
  <!--end::SuccessModal-->
       <div class="modal fade" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
       <div class="modal-dialog" role="document">
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title">Oops..!</h5>
               </div>
               <div class="modal-body">
                   <span id="failres"></span>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_2);">Ok</button>
               </div>
           </div>
       </div>
   </div>
</asp:Content>
