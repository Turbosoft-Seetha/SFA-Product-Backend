<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ResolvedServiceRequestDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ResolvedServiceRequestDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
     function Confim() {
         $('#modalConfirm').modal('show');
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
     function Assign() {

         $('#kt_modal_1_7').modal('show');
     }
     function deleteSucces(c) {
         $('#modalConfirm').modal('hide');
         $('#kt_modal_1_7').modal('hide');
         $('#kt_modal_1_8').modal('show');
         $('#delsuccess').text(c);
         }
         function ViewReqsts() {
            
             $('#kt_modal_1_9').modal('show');
             
         }
         function TroubleShoot() {

             $('#kt_modal_1_0').modal('show');

         }
         function failedModals() {


             $('#kt_modal_1_8').modal('show');


         }
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

     
                        
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>   
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
<AjaxSettings>
    
    <telerik:AjaxSetting AjaxControlID="btnViewReqst">
    <UpdatedControls>
                
    <telerik:AjaxUpdatedControl ControlID="RadGridSuccess" />

     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>



    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-form kt-form--label-right">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->

                                                <div class="col-4">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Service Request ID</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblServicerqstID" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>
                                                <!--end::Col-->
                                                                                            <div class="col-4">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5" >Date&Time</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>

                                                                                                <div class="col-4">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Current Status</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>


                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>
                                <div class="col-lg-12 row" >
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->

                                                <div class="col-6">
                                                    <div class="col-lg-12">
                                                   
                                                        <div class="d-flex align-items-center me-2 mb-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12 mb-4" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Customer</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblCustomer" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                        </div>
                                                           <div class="col-12">
                                                   
                                                        <div class="d-flex align-items-center  me-2 mb-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Asset</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblAsset" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>

                                                </div>
                                                <!--end::Col-->
                                                                                            <div class="col-6">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Planogram</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                     <div class="col-lg-12">
                                                                          <asp:HiddenField ID="hlval1" runat="server" />
                                                                          <asp:HyperLink ID="hpl1" runat="server" Target="_blank">
                                                                              <asp:Image ID="img1" runat="server" ImageUrl="../assets/media/svg/files/File-cloud.svg" Height="70px" Width="70px" />
                                                                          </asp:HyperLink>
                                                                      </div>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>



                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>


                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->

                                                <div class="col-6">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Complaint Title</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblComplaint" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>
                                                <!--end::Col-->
                                                                                            <div class="col-6">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Complaint Type</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblComplaintType" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>



                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>
                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->

                                                <div class="col-12">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Comments</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblComments" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>
                                                <!--end::Col-->



                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>


                                <div class="col-lg-12 row" >
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->

                                                <div class="col-12">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Attached Images</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                     <div class="col-lg-12 ">
                                                                       <asp:HiddenField ID="HiddenField1" runat="server" />
                                                                         <asp:PlaceHolder ID="pnlimg" runat="server">

                                                                         </asp:PlaceHolder>
                                                                     
                                                                   </div>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>
                                                <!--end::Col-->
                                                                                               


                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>
                                <asp:PlaceHolder ID="pnltroubleshoot" runat="server" Visible="false">
                                  <div class="col-lg-12 row ml-2" style="border-top-style:outset;border-top-width:thick;padding-left:10px;">
                                                                <div class="kt-portlet__head" style="padding-top: 20px;padding-bottom:10px;">
                                                                    <div class="kt-portlet__head-label">
                                                                        <h3 class="kt-portlet__head-title" style="font-size:14px;">
                                                                            <span class="min-w-40px  fw-semibold text-gray-600 pt-5">Suggested Troubleshoots</span>
                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                        
                                                                <div class="card-body d-flex flex-column mb-3">
                                                                    <!--begin::Row-->
                                                                  
                                                                        <!--begin::Col-->
                                                                        <div class="col-12" style="padding-left: 40px;">
                                                   
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                          <%--  <div class="col-12" style="padding-left: 40px;">--%>

                                                

                                                                <div class="fs-8 fw-bold pt-2 pl-3" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblTroubleShoot" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                           <%-- </div>--%>
                                                            <!--end::Title-->

                                                    
                                                   
                                                </div>
                                                                   
                                                                    <!--end::Row-->
                                                                </div>
                                                            </div>

                                 </asp:PlaceHolder>

                                                                <asp:PlaceHolder ID="pnlServiceJob" runat="server" Visible="false">
                                  <div class="col-lg-12 row ml-2" style="border-top-style:outset;border-top-width:thick;padding-left:10px;">
                                                                <div class="kt-portlet__head" style="padding-top: 20px;padding-bottom:10px;">
                                                                    <div class="kt-portlet__head-label">
                                                                        <h3 class="kt-portlet__head-title" style="font-size:14px;">
                                                                            <span class="min-w-40px  fw-semibold text-gray-600 pt-5">Service Jobs</span>
                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                        
                                                                <div class="card-body d-flex flex-column mb-3">
                                                                    <!--begin::Row-->
                                                                  
                                                                        <!--begin::Col-->
                                                                        <div class="col-12" style="padding-left: 3px;">
                       <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />                         
   <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
    ID="RadGridServiceJob" GridLines="None"
     AllowSorting="True"
    OnNeedDataSource="RadGridServiceJob_NeedDataSource"
        OnItemCommand="RadGridServiceJob_ItemCommand"
    AllowFilteringByColumn="true"
 ClientSettings-Resizing-ClipCellContentOnResize="true"
 EnableAjaxSkinRendering="true"
 AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
 <ClientSettings>
     <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="250px"></Scrolling>
 </ClientSettings>
 <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
     ShowFooter="false" DataKeyNames="sjh_ID"
     EnableHeaderContextMenu="true">
     <Columns>

          <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
     <ItemTemplate>
         <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
             ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
     </ItemTemplate>
 </telerik:GridTemplateColumn>
                  <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="RequiredParts" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
    <ItemTemplate>
        <asp:ImageButton CommandName="ReqParts" ID="RadImageButton1" Visible="true" AlternateText="Detail" runat="server"
            ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
    </ItemTemplate>
</telerik:GridTemplateColumn>

                  <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Invoice" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
    <ItemTemplate>
        <asp:ImageButton CommandName="Invoice" ID="RadInvoice" Visible="true" AlternateText="Invoice" runat="server"
            ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
    </ItemTemplate>
</telerik:GridTemplateColumn>


                            
              <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="100px"
      HeaderStyle-Font-Size="Smaller" HeaderText="Job ID" FilterControlWidth="100%"
      CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
      HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
  </telerik:GridBoundColumn>

           <telerik:GridBoundColumn DataField="snr_rot_ID" AllowFiltering="true" HeaderStyle-Width="100px"
    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
    HeaderStyle-Font-Bold="true" UniqueName="snr_rot_ID">
</telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Customer" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="Customer">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Date" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
            </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="Route" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Route" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Route">
             </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="ScheduledDate">
            </telerik:GridBoundColumn>
                  <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="80px"
    HeaderStyle-Font-Size="Smaller" HeaderText="Trans Time" FilterControlWidth="100%"
    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
    HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
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
                                                                   
                                                                    <!--end::Row-->
                                                                </div>
                                                            </div>

                                 </asp:PlaceHolder>

                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
        </div>
    </div>
        <div class="modal fade" id="kt_modal_1_7" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Assign To Service Route</h5>
                </div>
                                                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-6 form-group">
                <label class="control-label col-lg-12" >Route<span class="required"></span></label>
                <div class="col-lg-12">
                      <telerik:RadComboBox ID="ddlRoute" runat="server" EmptyMessage="Select Route" Width="100%" Filter="Contains" RenderMode="Lightweight" CausesValidation="false"></telerik:RadComboBox>

   
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"  ValidationGroup="frm"
                    ControlToValidate="ddlRoute" ErrorMessage="Please Select Route " ForeColor="Red" 
                  SetFocusOnError="True" ></asp:RequiredFieldValidator><br />
                    
                    </div>
                         </div>

                  <div class="col-lg-6 form-group">
                <label class="control-label col-lg-12" >Schedule To<span class="required"></span></label>
                <div class="col-lg-12">
                       <telerik:RadDatePicker RenderMode="Lightweight" ID="SCHdate" Width="100%"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                 </telerik:RadDatePicker>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"  ValidationGroup="frm" ErrorMessage="Date is mandatory" ForeColor="Red" ControlToValidate="SCHdate"></asp:RequiredFieldValidator>
                                                   <br />
                    
                    </div>
                         </div>

                        </div>
                   <div class="col-lg-12 row" style="width:max-content" >
                           <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

      
  <asp:LinkButton ID="btnViewReqst" runat="server" CssClass="btn btn-sm fw-bold btn-primary"  ValidationGroup="frm" CausesValidation="true" OnClick="btnViewReqst_Click">
                      View Jobs        
      </asp:LinkButton>
    </telerik:RadAjaxPanel>
<telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
BackColor="Transparent"
ForeColor="Blue">
    <div class="col-lg-12 text-center mt-5">
        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
    </div>
</telerik:RadAjaxLoadingPanel>

                   </div>               
                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        
                        <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="btn btn-sm fw-bold btn-success" ValidationGroup="frm" CausesValidation="true" OnClick="lnkSubmit_Click">
                                                    Submit
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
        <div class="modal fade" id="kt_modal_1_9" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:800px;">
            <div class="modal-header">
                <h5 class="modal-title">Assigned Requests</h5>
            </div>
                <div class="modal-body">
      
        <div class="col-lg-12 row" style="padding-top: 10px;">
         <div class="col-lg-12 form-group">
   
    <div class="col-lg-12 pt-3">
    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
    ID="RadGridSuccess" GridLines="None"
     AllowSorting="True"
    OnNeedDataSource="RadGridSuccess_NeedDataSource"
   
   
    ClientSettings-Resizing-ClipCellContentOnResize="true"
    EnableAjaxSkinRendering="true"
    AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
    <ClientSettings>
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="200px"></Scrolling>
    </ClientSettings>
    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
        ShowFooter="false" DataKeyNames="snr_ID"
        EnableHeaderContextMenu="true">
        <Columns>

                            
              <telerik:GridBoundColumn DataField="snr_Code" AllowFiltering="true" HeaderStyle-Width="100px"
      HeaderStyle-Font-Size="Smaller" HeaderText="RequestID" FilterControlWidth="100%"
      CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
      HeaderStyle-Font-Bold="true" UniqueName="snr_Code">
  </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Route" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Route" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="Route">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Customer" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="Customer">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="CreatedDate" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="ScheduledDate" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="ScheduledDate">
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
             </div>
       
            </div>
         
      
                </div>
            <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">Ok</button>
            </div>
        </div>
    </div>
</div>
            <div class="modal fade" id="kt_modal_1_0" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:800px;">
            <div class="modal-header">
                <h5 class="modal-title">Suggest Troubleshooting Options</h5>
            </div>
                <div class="modal-body">
      
        <div class="col-lg-12 row" style="padding-top: 10px;">
         <div class="col-lg-12 form-group">
   
    <div class="col-lg-12 pt-3">
    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
    ID="RadGrid1" GridLines="None"
     AllowSorting="True"
    OnNeedDataSource="RadGrid1_NeedDataSource"
   
   
    ClientSettings-Resizing-ClipCellContentOnResize="true"
    EnableAjaxSkinRendering="true"
     PageSize="50" CellSpacing="0" >
    <ClientSettings>
        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="200px"></Scrolling>
    </ClientSettings>
    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
        ShowFooter="false" DataKeyNames="sts_ID"
        EnableHeaderContextMenu="true">
        <Columns>
             <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
           </telerik:GridClientSelectColumn>
                            
            

            <telerik:GridBoundColumn DataField="sts_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Troubleshooting Methods" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="sts_Name">
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
             </div>
       
            </div>
         
      
                </div>
            <div class="modal-footer">
                <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
    
    <asp:LinkButton ID="btnTroubleshootSubmit" runat="server" CssClass="btn btn-sm fw-bold btn-success"  CausesValidation="true" OnClick="btnTroubleshootSubmit_Click">
                                Submit
    </asp:LinkButton>
</telerik:RadAjaxPanel>
<telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
    BackColor="Transparent"
    ForeColor="Blue">
    <div class="col-lg-12 text-center mt-5">
        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
    </div>
</telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_0);">Cancel</button>
            </div>
        </div>
    </div>
</div>
        <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">No selection found..!</h5>
            </div>
            <div class="modal-body">
                <p>Please make selection and try again.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_8);">Ok</button>
            </div>
        </div>
    </div>
</div>

<style>
    .instruction-container {
        padding-bottom: 10px; /* Adjust the amount of padding as needed */
    }

    .bubble {
        display: inline-block;
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background-color:darkgray; /* You can customize the color */
        margin-right: 10px; /* Adjust the spacing between the bubble and the text */
        vertical-align: middle; /* Center the bubble vertically */

    }
     .sentence {
        padding-bottom: 20px; /* Adjust the amount of margin as needed */
    }
</style>

    <!--end::FailedModal-->
</asp:Content>



<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>