<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SJDetailFromFSRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SJDetailFromFSRoute" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-form kt-form--label-right">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class="kt-portlet__head" style="padding-top: 20px;padding-bottom:10px;">
                                                                    <div class="kt-portlet__head-label">
                                                                        <h3 class="kt-portlet__head-title" style="font-size:20px;">
                                                                            Service Request Detail
                                                                        </h3>
                                                                    </div>
                                                                </div>
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

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Asset Serial Number</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblAssetSno" runat="server"></asp:Label>
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
                                                                                                <div class="col-4">
                                                   
                                                        
                                                   
                                                        <div class="d-flex align-items-center  me-2 mb-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Asset Type</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblAsset" runat="server"></asp:Label>
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
                                                                                            <div class="col-4">
                                                   
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

                                                                <asp:PlaceHolder ID="pnlServiceJob" runat="server" Visible="true">
                                                                   <div class="col-lg-12 row ml-2" style="border-top-style:outset;border-top-width:thick;padding-left:10px;">
                                                                <div class="kt-portlet__head" style="padding-top: 20px;padding-bottom:10px;">
                                                                    <div class="kt-portlet__head-label">
                                                                        <h3 class="kt-portlet__head-title" style="font-size:20px;">
                                                                            Service Job Detail
                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                        
                                                                <div class="card-body d-flex flex-column mb-3">
                                                                   <div class="col-lg-12">

                                                                       <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->
                                                 <div class="col-3">
    
         <div class="d-flex align-items-center mb-2 me-2">
             <!--begin::Symbol-->
           
             <!--end::Symbol-->
             <!--begin::Title-->
             <div class="col-12" style="padding-left: 10px;">

   <span class="min-w-50px fw-semibold text-gray-500 pt-5">Service Job ID</span>

                 <div class="fs-7 fw-bold pt-1" style="color: black;">

                     <span class="" style="font-size: 14px;">
                         <asp:Label ID="lblJobID" runat="server"></asp:Label>
                     </span>
                 </div>


             </div>
             <!--end::Title-->

         </div>
    
 </div>
                                                <div class="col-3">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Service Request ID</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblSerJobID" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>
                                                <!--end::Col-->
                                                                                            <div class="col-3">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5" >Date&Time</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lbljobDate" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>

                                                                                                <div class="col-3">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Current Status</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblJobCurrStatus" runat="server"></asp:Label>
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

                                 <div class="col-lg-12 row ml-2" style="padding-left:10px;">
                               <div class="kt-portlet__head" style="padding-top: 20px;padding-bottom:10px;">
                                   <div class="kt-portlet__head-label">
                                       <h3 class="kt-portlet__head-title" style="font-size:15px;">
                                           <span class="min-w-40px  fw-semibold text-gray-600 pt-5">Inspection Updates</span>
                                       </h3>
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

   <span class="min-w-50px fw-semibold text-gray-500 pt-5">Working Status</span>

                 <div class="fs-7 fw-bold pt-1" style="color: black;">

                     <span class="" style="font-size: 14px;">
                         <asp:Label ID="lblWorkStatus" runat="server"></asp:Label>
                     </span>
                 </div>


             </div>
             <!--end::Title-->

         </div>
    
 </div>
                                                <div class="col-6">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Service Type</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblServiceType" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>

                                                 <span class="min-w-50px fw-semibold text-gray-500 pt-5">Comments :</span>

                                                        <%-- <div class="fs-7 fw-bold pt-1" style="color: black;">--%>

                                                             <span class="min-w-50px fw-semibold text-gray-500 pt-5">
                                                                 <asp:Label ID="lblTypeComments" runat="server"></asp:Label>
                                                             </span>
                                                        <%-- </div>--%>
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

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5" >Warranty</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblWarranty" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>


                                                            </div>
                                                            <!--end::Title-->

                                                        </div>
                                                   
                                                </div>

                                                                                                <div class="col-6">
                                                   
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <!--begin::Symbol-->
                                                          
                                                            <!--end::Symbol-->
                                                            <!--begin::Title-->
                                                            <div class="col-12" style="padding-left: 10px;">

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5">Remarks</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblRemarks" runat="server"></asp:Label>
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

                                                  <span class="min-w-50px fw-semibold text-gray-500 pt-5"> Attached Images of Job</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                     <div class="col-lg-12 ">
                                                                       <asp:HiddenField ID="HiddenField2" runat="server" />
                                                                         <asp:PlaceHolder ID="pnljob" runat="server">

                                                                         </asp:PlaceHolder>
                                                                     
                                                                   </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </div>

                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <div class="row g">
                                                 <div class="col-12">
    
                                                        <div class="d-flex align-items-center mb-2 me-2">
                                                            <div class="col-12" style="padding-left: 10px;">

                                                                <span class="min-w-50px fw-semibold text-gray-500 pt-5">Action Type</span>

                                                                <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblActionType" runat="server"></asp:Label>
                                                                    </span>
                                                                </div>
                                                             </div>
                                                         </div>
    
                                                 </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                    
                                                                    </div>
                                                                </div>
                                                                   
                                                                    <!--end::Row-->
                                                                </div>
                                                                 </asp:PlaceHolder>
                                </telerik:RadAjaxPanel>
                                                            </div>
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
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>


