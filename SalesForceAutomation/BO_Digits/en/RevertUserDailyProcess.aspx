<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RevertUserDailyProcess.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RevertUserDailyProcess" %>
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
    function failedModal() {
        $('#modalConfirm').modal('hide');
        $('#kt_modal_1_5').modal('show');
    }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
   </telerik:RadAjaxManager>
   <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
       <AjaxSettings>
           <telerik:AjaxSetting AjaxControlID="grvRpt">
               <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="lnkRevert" />

                           


               </UpdatedControls>
           </telerik:AjaxSetting>

       </AjaxSettings>

  </telerik:RadAjaxManagerProxy>

 <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
     <div class="row">
         <div class="col-lg-12">


             <!--end: Search Form -->
             <div class="kt-portlet">


            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
     <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
     <div class="card-body" style="background-color: white; padding: 20px;">

                 <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                         <div class=" col-lg-12 row" style="padding-bottom: 10px">


                                    <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false" >
                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">Region</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddlregion" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
                                        <label class="control-label col-lg-12">Depot</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                RenderMode="Lightweight"
                                                ID="ddldepot" runat="server" EmptyMessage="Select Depot"
                                                OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
                                        <label class="control-label col-lg-12">Area</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldpoArea" runat="server" EmptyMessage="Select Area"
                                                OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
                                        <label class="control-label col-lg-12">Subarea</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                        </asp:PlaceHolder>
                                      </div>

                      <div class=" col-lg-12 row"style="padding-bottom:10px;">
                                    <div class="col-lg-2">
    <label class="control-label col-lg-12">Route Type</label>
    <div class="col-lg-12">
        <telerik:RadComboBox ID="ddlRotType" Width="80%" runat="server" EmptyMessage="Select Route Type" Filter="Contains" RenderMode="Lightweight" OnSelectedIndexChanged="ddlRotType_SelectedIndexChanged" AutoPostBack="true">
             <Items>
                <telerik:RadComboBoxItem Text="All" Value="AL" Selected="true"/>
                <telerik:RadComboBoxItem Text="Sales" Value="SL"/>
                <telerik:RadComboBoxItem Text="Order" Value="OR"/>
                <telerik:RadComboBoxItem Text="AR" Value="AR"/>
                <telerik:RadComboBoxItem Text="Order & AR" Value="OA"/>
                <telerik:RadComboBoxItem Text="Delivery" Value="DL"/>
                <telerik:RadComboBoxItem Text="Merchandising" Value="MER"/>
                <telerik:RadComboBoxItem Text="Field Services" Value="FS"/>                                       
            </Items>
        </telerik:RadComboBox>
    </div>
</div>
                                   <div class="col-lg-2">
                                       <label class="control-label col-lg-12">Route</label>
                                       <div class="col-lg-12">
                                           <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                               ID="rdRoute" runat="server" EmptyMessage="Select Route"  OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true" Width="100%">
                                           </telerik:RadComboBox>

                                       </div>
                                   </div>

 

     <div class="col-lg-3 ">
         <label class="control-label col-lg-12">From Date</label>
         <div class="col-lg-10">
             <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
             </telerik:RadDatePicker>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
         </div>
     </div>

     <div class="col-lg-3 ">
         <label class="control-label col-lg-12">To Date</label>
         <div class="col-lg-10">
             <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
             </telerik:RadDatePicker>
             <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                 Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
         </div>
     </div>
     <div class="col-lg-1" style="top: 10px; text-align: center; padding-top: 15px; margin-left: -43px;width: auto;">
         <asp:LinkButton ID="Filter"  runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                     Apply Filter
         </asp:LinkButton>
     </div>
    
</div>

 <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
 <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
     ID="grvRpt" GridLines="None"
     ShowFooter="True" AllowSorting="True"
     OnNeedDataSource="grvRpt_NeedDataSource"
     OnItemCommand="grvRpt_ItemCommand"
     OnItemDataBound="grvRpt_ItemDataBound"
    
     AllowFilteringByColumn="true"
     ClientSettings-Resizing-ClipCellContentOnResize="true"
     EnableAjaxSkinRendering="true"
     AllowPaging="true" PageSize="50" CellSpacing="0">
     <ClientSettings>
         <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
     </ClientSettings>
     <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
         ShowFooter="false" DataKeyNames="udp_ID"
         EnableHeaderContextMenu="true">
         <Columns>



           

             <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="110px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
             </telerik:GridBoundColumn>
                          <telerik:GridBoundColumn DataField="udp_LoadOutStatus" AllowFiltering="true" HeaderStyle-Width="110px"
  HeaderStyle-Font-Size="Smaller" HeaderText="Load Out" FilterControlWidth="100%"
  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
  HeaderStyle-Font-Bold="true" UniqueName="udp_LoadOutStatus">
</telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="udp_IsAppProcessComplete" AllowFiltering="true" HeaderStyle-Width="110px"
  HeaderStyle-Font-Size="Smaller" HeaderText="App Process" FilterControlWidth="100%"
  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
  HeaderStyle-Font-Bold="true" UniqueName="udp_IsAppProcessComplete">
</telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="udp_SettlementStatus" AllowFiltering="true" HeaderStyle-Width="110px"
  HeaderStyle-Font-Size="Smaller" HeaderText="Settlement" FilterControlWidth="100%"
  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
  HeaderStyle-Font-Bold="true" UniqueName="udp_SettlementStatus">
</telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="110px"
  HeaderStyle-Font-Size="Smaller" HeaderText="End Day" FilterControlWidth="100%"
  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
  HeaderStyle-Font-Bold="true" UniqueName="udp_EndDayStatus">
</telerik:GridBoundColumn>
         
              <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="110px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Date and Time" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
              </telerik:GridBoundColumn>

               
           

           <telerik:GridTemplateColumn HeaderStyle-Width="90px" AllowFiltering="false" HeaderText="Revert" UniqueName="Cnf" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
           <ItemTemplate>
             <asp:LinkButton ID="lnkRevert" runat="server" Font-Size="X-Small" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" Text="Revert" CommandName="Revert"  ></asp:LinkButton>

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
         </div>
  </telerik:RadAjaxPanel>
                  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
     BackColor="Transparent"
     ForeColor="Blue">
     <div class="col-lg-12 text-center mt-5">
         <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
     </div>
 </telerik:RadAjaxLoadingPanel>
            </div>

        </div>
    </div>
 </div>

     <div class="clearfix"></div>
 <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="Confirm">Are you sure you want to Revert??
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
                 <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                     <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
 <!--end::SuccessModal-->
 <!--end::SuccessModal-->
 .
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
</asp:Content>
