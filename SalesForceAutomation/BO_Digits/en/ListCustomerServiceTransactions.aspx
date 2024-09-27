<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListCustomerServiceTransactions.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListCustomerServiceTransactions" %>
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


                     <div class="kt-portlet__head" style="border-bottom-style: ridge; border-bottom-width: thin;">

                         <div class="kt-portlet__head-actions col-lg-12 row">
                             <div class="col-lg-6">
                                 <h3 class="card-title text-gray-800">
                                     <asp:Repeater runat="server" ID="rptRoute">
                                         <ItemTemplate>
                                             Route &nbsp;  
                                           <asp:Label ID="lblrot" runat="server" Text='<%# Eval("routeName") %>'> </asp:Label>
                                         </ItemTemplate>
                                     </asp:Repeater>
                                 </h3>
                             </div>

                         </div>
                     </div>



                     <!--begin::Form-->
                     <div class="kt-form kt-form--label-right">
                         <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                             <div class="kt-portlet__body pb-0" style="border-bottom-style: inset; border-bottom-width: thin;">


                                 <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                                     <Items>
                                         <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="">
                                             <ContentTemplate>
                                                 <div class="col-lg-12 row mb-2 pt-4">

                                                     <div class="col-sm-4">
                                                         <span class="svg-icon svg-icon-2">
                                                             <svg id="Group_1833" data-name="Group 1833" xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                                 <path id="Path_1746" data-name="Path 1746" d="M0,0H17V17H0Z" fill="none" fill-rule="evenodd" />
                                                                 <path id="Path_1747" data-name="Path 1747" d="M10.833,8.667a2.833,2.833,0,1,1,2.833-2.833A2.833,2.833,0,0,1,10.833,8.667Z" transform="translate(-2.333 -0.875)" fill="#6092aa" opacity="0.3" />
                                                                 <path id="Path_1748" data-name="Path 1748" d="M3,18.1C3.275,14.719,6.019,13,9.363,13c3.391,0,6.178,1.624,6.385,5.1a.487.487,0,0,1-.532.567H3.515A.784.784,0,0,1,3,18.1Z" transform="translate(-0.875 -3.792)" fill="#6092aa" />
                                                             </svg>

                                                         </span>
                                                         <%--<img src="../assets/media/UDP/User.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                         <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                             <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                     </div>

                                                     <div class="col-sm-4">
                                                         <span class="svg-icon svg-icon-2">
                                                             <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                                 <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                                     <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                                     <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                                     <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                                 </g>
                                                             </svg>

                                                         </span>
                                                         <%--  <img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                         <label class="col-lg-2 col-form-label" style="display: contents;">Start Time:</label>
                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                             <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                     </div>

                                                     <div class="col-sm-4">
                                                         <span class="svg-icon svg-icon-2">
                                                             <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                                 <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                                     <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                                     <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                                     <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                                 </g>
                                                             </svg>

                                                         </span>
                                                         <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                         <label class="col-lg-2 col-form-label" style="display: contents;">Process Complete:</label>
                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                             <asp:Label ID="lblProcess" Font-Bold="true" runat="server">  </asp:Label></label>
                                                     </div>
                                                 </div>
                                                 <div class="col-lg-12 row mb-4 py-4 " style="border-bottom-style: ridge; border-bottom-width: thin;">

                                                     <div class="col-sm-4">
                                                         <span class="svg-icon svg-icon-2">
                                                             <svg id="Group_1825" data-name="Group 1825" xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                                 <rect id="Rectangle_959" data-name="Rectangle 959" width="17" height="17" fill="none" />
                                                                 <path id="Path_1738" data-name="Path 1738" d="M15.11,13.72,11,9.61V3.742a.742.742,0,1,1,1.483,0V9l3.676,3.676,1.623-1.623a.371.371,0,0,1,.633.262v3.925a.371.371,0,0,1-.371.371H14.12a.371.371,0,0,1-.262-.633Z" transform="translate(-2.395 -1.255)" fill="#6092aa" />
                                                                 <path id="Path_1739" data-name="Path 1739" d="M6.155,16.116,7.639,17.6a.371.371,0,0,1-.262.633H3.4a.371.371,0,0,1-.371-.371V13.885a.371.371,0,0,1,.633-.262L5.1,15.063l2.246-1.9L8.306,14.3Z" transform="translate(-0.335 -3.882)" fill="#6092aa" opacity="0.3" />
                                                             </svg>

                                                         </span>
                                                         <%-- <img src="../assets/media/UDP/version.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                         <label class="col-lg-2 col-form-label" style="display: contents;">Version:</label>
                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                             <asp:Label ID="lblVersion" Font-Bold="true" runat="server"></asp:Label></label>
                                                     </div>

                                                     <div class="col-sm-4">
                                                         <span class="svg-icon svg-icon-2">
                                                             <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                                 <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                                     <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                                     <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                                     <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                                 </g>
                                                             </svg>

                                                         </span>
                                                         <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                         <label class="col-lg-2 col-form-label" style="display: contents;">End Time:</label>
                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                             <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                     </div>

                                                     <div class="col-sm-4">
                                                         <span class="svg-icon svg-icon-2">
                                                             <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                                 <g id="Group_1828" data-name="Group 1828" transform="translate(-0.305)">
                                                                     <rect id="Rectangle_961" data-name="Rectangle 961" width="17" height="17" transform="translate(0.305)" fill="none" />
                                                                     <path id="Path_1742" data-name="Path 1742" d="M9.667,16.333a5.667,5.667,0,1,1,5.667-5.667A5.667,5.667,0,0,1,9.667,16.333Z" transform="translate(-1.167 -1.458)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                                     <path id="Path_1743" data-name="Path 1743" d="M11.833,4.169a5.744,5.744,0,0,0-1.417,0V3.417H9.708A.708.708,0,0,1,9.708,2h2.833a.708.708,0,1,1,0,1.417h-.708Z" transform="translate(-2.625 -0.583)" fill="#6092aa" fill-rule="evenodd" />
                                                                     <path id="Path_1744" data-name="Path 1744" d="M16.71,6.206l.585-.585a.708.708,0,1,1,1,1l-.554.554A5.7,5.7,0,0,0,16.71,6.206Z" transform="translate(-4.874 -1.579)" fill="#6092aa" fill-rule="evenodd" />
                                                                     <path id="Path_1745" data-name="Path 1745" d="M11.694,7.5h.052a.354.354,0,0,1,.353.327l.3,3.9a.354.354,0,0,1-.326.38h-.679a.354.354,0,0,1-.354-.354c0-.009,0-.018,0-.027l.3-3.9A.354.354,0,0,1,11.694,7.5Z" transform="translate(-3.22 -2.187)" fill="#6092aa" fill-rule="evenodd" />
                                                                 </g>
                                                             </svg>

                                                         </span>
                                                         <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                         <label class="col-lg-2 col-form-label" style="display: contents;">Duration:</label>
                                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                                             <asp:Label ID="lblDuration" Font-Bold="true" runat="server"></asp:Label></label>
                                                     </div>

                                                 </div>

                                                 <div class="col-lg-12 row mb-4 ps-2">

                                                     <div class="col-lg-4" style="font-size: large; opacity: 0.80">

                                                         <asp:Panel ID="code" runat="server" Visible="true">
                                                             <div class="m-2">
                                                                 <div class="" style="color: black; font-weight: bold;">
                                                                     <asp:Label ID="lblTotalVisits" runat="server"></asp:Label>
                                                                 </div>

                                                                 <div class="" style="color: black; font-weight: bold;">Customer visits</div>

                                                             </div>
                                                         </asp:Panel>
                                                     </div>
                                                     <asp:Panel ID="cus" runat="server" Visible="false">
                                                         <div class="col-lg-12 row">
                                                             <div class="col-lg-4 mt-4">

                                                                 <div class="fs-2 fw-bold lh-1 pb-3" style="color: black; font-size: 17px;">
                                                                     <asp:Label ID="lblcode" Text="Code" runat="server"></asp:Label>

                                                                 </div>

                                                                 <div class="fs-3 fw-bold lh-1 pb-2" style="color: black; font-size: 17px;">

                                                                     <asp:Label ID="lblcusName" Text="CusName" runat="server"></asp:Label>
                                                                 </div>
                                                             </div>
                                                             <div class="col-lg-8">
                                                                 <div class="col-lg-12 row" style="display: flex; justify-content: flex-end;">
                                                                     <div class="col-sm-3 fs-7 mt-8" style="color: black; font-size: 13px; display: block;">
                                                                         Start Time : 
                                                       <span class="">
                                                           <asp:Label ID="lblsTime" runat="server"></asp:Label>
                                                       </span>
                                                                     </div>

                                                                     <div class="col-sm-3 fs-7 mt-8" style="color: black; font-size: 13px; display: block;">
                                                                         End Time : 
                                                       <span class="">
                                                           <asp:Label ID="lbleTime" runat="server"></asp:Label>
                                                       </span>

                                                                     </div>

                                                                     <div class="col-sm-3 fs-7 mt-8" style="color: black; font-size: 13px; display: block;">
                                                                         Duration :
                                                           <span class="">
                                                               <asp:Label ID="lbldurations" runat="server"></asp:Label>
                                                           </span>
                                                                     </div>
                                                                 </div>
                                                             </div>
                                                         </div>
                                                     </asp:Panel>




                                                 </div>

                                                 <div class="col-lg-12 row" style="margin-bottom: 15px;">
                                                     <div class="col-lg-12 mb-4">
                                                         <div class="kt-portlet__head" style="padding-top: 5px;">
                                                             <div class="kt-portlet__head-label">
                                                                 <h3 class="kt-portlet__head-title" style="font-size: medium;">
                                                                     <span class="min-w-70px fw-semibold text-gray-700 pt-5"><asp:Label runat="server" ID="lblcusserv"></asp:Label></span>
                                                                 </h3>
                                                             </div>
                                                         </div>

                                                         <div class="card-body d-flex flex-column">
                                                             <!--begin::Row-->
                                                             <div class="row g">

                                                                 <!--begin::Col-->
                                                                 <asp:PlaceHolder ID="pnl2" runat="server">
                                                                     <!--begin::Col-->
                                                                     <div class="col-4">
                                                                         <asp:LinkButton runat="server" ID="BtnGComplaints" OnClick="BtnGComplaints_Click">
                                                                             <div class="d-flex align-items-center mb-2 me-2">
                                                                                 <!--begin::Symbol-->
                                                                                 <div class="col-2">
                                                                                     <div class="symbol symbol-40px me-3" style="padding-top: 20px;">
                                                                                         <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                             <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                                                             <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                 <img src="../assets/media/MerchTransaction/complaints.png" alt="AR" width="28" height="25" style="margin: 10px;" />
                                                                                             </span>
                                                                                             <!--end::Svg Icon-->
                                                                                         </div>
                                                                                     </div>
                                                                                 </div>
                                                                                 <!--end::Symbol-->
                                                                                 <!--begin::Title-->
                                                                                 <div class="col-10" style="padding-left: 10px;">

                                                                                     <div class="fs-7 fw-semibold pt-6" style="color: black;">

                                                                                         <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                             <asp:Label ID="lblTotalGComplaints" runat="server"></asp:Label>
                                                                                         </span>
                                                                                     </div>
                                                                                     <div class="fs-7 fw-semibold" style="color: black; margin-right: 40px;">General Complaints</div>

                                                                                 </div>
                                                                                 <!--end::Title-->

                                                                             </div>
                                                                         </asp:LinkButton>
                                                                     </div>
                                                                     <!--end::Col-->

                                                                     <div class="col-4">
                                                                         <asp:LinkButton runat="server" ID="ProdComplaint" OnClick="ProdComplaint_Click">
                                                                             <div class="d-flex align-items-center mb-2 me-2">
                                                                                 <!--begin::Symbol-->
                                                                                 <div class="col-2">
                                                                                     <div class="symbol symbol-40px me-3" style="background-color: white; padding-top: 20px;">
                                                                                         <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                             <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                             <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                 <img src="../assets/media/MerchTransaction/complaints.png" alt="Invoice" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                             </span>
                                                                                             <!--end::Svg Icon-->
                                                                                         </div>
                                                                                     </div>
                                                                                 </div>
                                                                                 <!--end::Symbol-->
                                                                                 <!--begin::Title-->
                                                                                 <div class="col-10" style="padding-left: 10px;">


                                                                                     <div class="fs-7 fw-semibold pt-6" style="color: black;">

                                                                                         <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                             <asp:Label ID="lblTotProComplaints" runat="server"></asp:Label>
                                                                                         </span>
                                                                                     </div>
                                                                                     <div class="fs-7 fw-semibold" style="color: black; margin-right: 40px;">Product Complaints</div>


                                                                                 </div>
                                                                                 <!--end::Title-->

                                                                             </div>
                                                                         </asp:LinkButton>
                                                                     </div>
                                                                     <!--end::Col-->

                                                                     <div class="col-4">
                                                                         <asp:LinkButton runat="server" ID="DNReq" OnClick="DNReq_Click">
                                                                             <div class="d-flex align-items-center mb-2 me-2">
                                                                                 <!--begin::Symbol-->
                                                                                 <div class="col-2">
                                                                                     <div class="symbol symbol-40px me-3" style="background-color: white; padding-top: 20px;">
                                                                                         <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                             <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                             <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                 <img src="../assets/media/MerchTransaction/dr.png" alt="Invoice" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                             </span>
                                                                                             <!--end::Svg Icon-->
                                                                                         </div>
                                                                                     </div>
                                                                                 </div>
                                                                                 <!--end::Symbol-->
                                                                                 <!--begin::Title-->
                                                                                 <div class="col-10" style="padding-left: 10px;">


                                                                                     <div class="fs-7 fw-semibold pt-6" style="color: black;">

                                                                                         <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                             <asp:Label ID="lblTotDNR" runat="server"></asp:Label>
                                                                                         </span>
                                                                                     </div>
                                                                                     <div class="fs-7 fw-semibold" style="color: black; margin-right: 40px;">Dispute Note Requests</div>


                                                                                 </div>
                                                                                 <!--end::Title-->

                                                                             </div>
                                                                         </asp:LinkButton>
                                                                     </div>

                                                                     <div class="col-4">
                                                                         <asp:LinkButton runat="server" ID="CNReq" OnClick="CNReq_Click">
                                                                             <div class="d-flex align-items-center mb-2 me-2">
                                                                                 <!--begin::Symbol-->
                                                                                 <div class="col-2">
                                                                                     <div class="symbol symbol-40px me-3" style="background-color: white; padding-top: 20px;">
                                                                                         <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                             <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                             <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                 <img src="../assets/media/MerchTransaction/cnr.png" alt="Invoice" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                             </span>
                                                                                             <!--end::Svg Icon-->
                                                                                         </div>
                                                                                     </div>
                                                                                 </div>
                                                                                 <!--end::Symbol-->
                                                                                 <!--begin::Title-->
                                                                                 <div class="col-10" style="padding-left: 10px;">


                                                                                     <div class="fs-7 fw-semibold pt-6" style="color: black;">

                                                                                         <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                             <asp:Label ID="lblTotCNR" runat="server"></asp:Label>
                                                                                         </span>
                                                                                     </div>
                                                                                     <div class="fs-7 fw-semibold" style="color: black; margin-right: 40px;">Credit Note Requests</div>


                                                                                 </div>
                                                                                 <!--end::Title-->

                                                                             </div>
                                                                         </asp:LinkButton>
                                                                     </div>

                                                                     <div class="col-4">
                                                                         <asp:LinkButton runat="server" ID="RetReq" OnClick="RetReq_Click">
                                                                             <div class="d-flex align-items-center mb-2 me-2">
                                                                                 <!--begin::Symbol-->
                                                                                 <div class="col-2">
                                                                                     <div class="symbol symbol-40px me-3" style="background-color: white; padding-top: 20px;">
                                                                                         <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                             <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                             <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                 <img src="../assets/media/MerchTransaction/srr.png" alt="Invoice" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                             </span>
                                                                                             <!--end::Svg Icon-->
                                                                                         </div>
                                                                                     </div>
                                                                                 </div>
                                                                                 <!--end::Symbol-->
                                                                                 <!--begin::Title-->
                                                                                 <div class="col-10" style="padding-left: 10px;">


                                                                                     <div class="fs-7 fw-semibold pt-6" style="color: black;">

                                                                                         <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                             <asp:Label ID="lblTotRetReq" runat="server"></asp:Label>
                                                                                         </span>
                                                                                     </div>
                                                                                     <div class="fs-7 fw-semibold" style="color: black; margin-right: 40px;">Return Requests</div>


                                                                                 </div>
                                                                                 <!--end::Title-->

                                                                             </div>
                                                                         </asp:LinkButton>
                                                                     </div>
                                                                       <div class="col-4">
      <asp:LinkButton runat="server" ID="lnkcusreq" OnClick="lnkcusreq_Click">
          <div class="d-flex align-items-center mb-2 me-2">
              <!--begin::Symbol-->
              <div class="col-2">
                  <div class="symbol symbol-40px me-3" style="background-color: white; padding-top: 20px;">
                      <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                          <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                          <span class="svg-icon svg-icon-1 svg-icon-dark">
                              <img src="../assets/media/MerchTransaction/srr.png" alt="cusreq" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                          </span>
                          <!--end::Svg Icon-->
                      </div>
                  </div>
              </div>
              <!--end::Symbol-->
              <!--begin::Title-->
              <div class="col-10" style="padding-left: 10px;">


                  <div class="fs-7 fw-semibold pt-6" style="color: black;">

                      <span class="" style="font-size: 17px; font-weight: bold;">
                          <asp:Label ID="lblcusreq" runat="server"></asp:Label>
                      </span>
                  </div>
                  <div class="fs-7 fw-semibold" style="color: black; margin-right: 40px;">Customer Requests</div>


              </div>
              <!--end::Title-->

          </div>
      </asp:LinkButton>
  </div>

                                                                 </asp:PlaceHolder>





                                                             </div>
                                                             <!--end::Row-->
                                                         </div>
                                                     </div>


                                                 </div>
                                             </ContentTemplate>
                                         </telerik:RadPanelItem>
                                     </Items>
                                 </telerik:RadPanelBar>


                            
                             </div>





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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
