<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ServiceDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ServiceDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <link href="../assets/style.bundle.css" rel="stylesheet" type="text/css" />
 <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div>

                        <div class="col-lg-12 row" style="padding-top: 10px;">

                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true">
                                    </telerik:RadDatePicker>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                    --%>
                                </div>
                            </div>

                            <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                </asp:LinkButton>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="post d-flex flex-column-fluid" id="kt_post">
                <div id="kt_content_container" class="container-xxl" style="margin-left: 0px; margin-right: 0px; max-width: none;">
                    <div class="row g-5 g-xl-8" >
                        <asp:PlaceHolder ID="pnlTimeline" runat="server" Visible="true">
                            <div class="col-xl-12">
                                <div class="card">
                                    <div class="card-body" style="padding: 1rem 2rem;">
                                        <div class="py-2">
                                            <div class="col-lg-12 row">
                                                <div class="col-lg-3">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row" style="text-align: center;">
                                                            <div class="col-lg-6" style="border-right: 1px solid; text-align: right;">
                                                                <span style="font-weight: 500;">All<br />
                                                                    Service Routes</span>
                                                            </div>
                                                            <div class="col-lg-6" style="text-align: left; padding-top: 5px;">
                                                                <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                                    <asp:Label ID="lblActiveRoute" runat="server"></asp:Label></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-3">
                                                    <!--begin::Item-->
                                                    <asp:LinkButton ID="lnkProductive" runat="server" CssClass="d-flex flex-stack" OnClick="lnkProductive_Click">
                                                        <div class="col-lg-12 row" style="text-align: center;">
                                                            <div class="col-lg-6" style="border-right: 1px solid; text-align: right;">
                                                                <span style="font-weight: 500;">Active<br />
                                                                    Service Routes</span>
                                                            </div>
                                                            <div class="col-lg-6" style="text-align: left; padding-top: 5px;">
                                                                <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                                    <asp:Label ID="lblProductiveRoute" runat="server"></asp:Label></span>
                                                            </div>
                                                        </div>
                                                    </asp:LinkButton>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-3">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row" style="text-align: center;">
                                                            <div class="col-lg-7" style="border-right: 1px solid; text-align: right;">
                                                                <span style="font-weight: 500;">Inactive<br />
                                                                    Service Routes</span>
                                                            </div>
                                                            <div class="col-lg-5" style="text-align: left; padding-top: 5px;">
                                                                <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                                    <asp:Label ID="lblNonProductiveRoute" runat="server"></asp:Label></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-3">
                                                    <!--begin::Item-->
                                                    <asp:LinkButton ID="lnkMap" runat="server" CssClass="d-flex flex-stack" OnClick="lnkMap_Click">
                                            <div class="col-lg-12" style="text-align: right;">
                                                <div class="d-flex justify-content-end">
                                                    <div class="d-flex">
                                                        <img src="../assets/media/dashboard/timeline.png" class="w-40px me-6" alt="" />
                                                        <div class="d-flex flex-column" style="padding-top: 8px;">
                                                            <div class="fs-6 fw-semibold" style="color: black">View on Map</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                    </asp:LinkButton>
                                                    <!--end::Item-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:PlaceHolder>
                    </div>

                    <div class="row g-5 g-xl-8 pt-5">
                      

                        <div class="col-xl-6">
                           

                            <div class="card card-flush mb-9 mt-5" style="height: 50%;" box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">
                                <asp:LinkButton ID="lnkServiceRequest" runat="server" OnClick="lnkServiceRequest_Click">
                                    <!--begin::Header-->
                                    <div class="card-header pt-5">
                                        <!--begin::Title-->
                                        <div class="card-title d-flex flex-column">
                                            <!--begin::Info-->
                                            <div class="d-flex align-items-center">

                                                <!--begin::Amount-->
                                                <span class="fs-2hx fw-bold text-dark me-2 lh-1 ls-n2 ms-5" >
                                                    <asp:Label ID="lblServiceRequest" runat="server" Text="0" style="font-size: 26px;" class="text-gray-700"></asp:Label></span>
                                                <!--end::Amount-->

                                            </div>
                                            <!--end::Info-->
                                            <!--begin::Subtitle-->
                                            <span class="text-gray-700 pt-1 fw-bold fs-1 ms-5">Service Request</span>
                                            <!--end::Subtitle-->
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                    <!--end::Header-->
                                    <!--begin::Card body-->
                                    <div class="card-body pt-2 pb-4 d-flex flex-wrap align-items-center" style="margin-top: 20px;">

                                        <!--begin::Labels-->
                                        <div class="d-flex flex-column content-justify-center flex-row-fluid">
                                            <!--begin::Label-->
                                            <div class="d-flex fw-semibold align-items-center mt-3" >
                                                <!--begin::Bullet-->
                                                <div class="bullet w-8px h-3px rounded-2 bg-success me-3"></div>
                                                <!--end::Bullet-->
                                                <!--begin::Label-->
                                                <div class="text-gray-700 flex-grow-1 me-4">Created</div>
                                                <!--end::Label-->
                                                <!--begin::Stats-->
                                                <div class="fw-bolder text-gray-700 text-xxl-end fs-5 me-5">
                                                    <asp:Label ID="lblCreated" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <!--end::Stats-->
                                            </div>
                                            <!--end::Label-->
                                            <!--begin::Label-->
                                            <div class="d-flex fw-semibold align-items-center my-3">
                                                <!--begin::Bullet-->
                                                <div class="bullet w-8px h-3px rounded-2 bg-primary me-3"></div>
                                                <!--end::Bullet-->
                                                <!--begin::Label-->
                                                <div class="text-gray-700 flex-grow-1 me-4">Action Taken</div>
                                                <!--end::Label-->
                                                <!--begin::Stats-->
                                                <div class="fw-bolder text-gray-700 text-xxl-end fs-5 me-5">
                                                    <asp:Label ID="lblActionTaken" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <!--end::Stats-->
                                            </div>
                                            <!--end::Label-->

                                        </div>
                                        <!--end::Labels-->
                                    </div>
                                    <!--end::Card body-->
                                </asp:LinkButton>
                            </div>

                            <div class="card card-flush" style="height: 33%;" box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">
                      <asp:LinkButton ID="lnkOpenServiceJob" runat="server" OnClick="lnkOpenServiceJob_Click" CssClass="btn btn-sm ">

                                <!--begin::Header-->
                                <div class="card-header border-0 pt-2">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold text-dark fs-2">
                                            <asp:Label ID="lblOpenServiceJobs" runat="server" Text="0" style="font-size: 26px;" class="text-gray-700"></asp:Label></span>
                                        <span class="text-gray-700 mt-1 fw-semibold fs-1">Unassigned Service Jobs</span>
                                    </h3>
                                    <!--begin::Toolbar-->
                                    <div class="card-toolbar mt-5 " >
                                        <img src="../assets/media/dashboard/right.svg" height="26" width="26" />

                                    </div>
                                    <!--end::Toolbar-->
                                </div>
                                                                  </asp:LinkButton>

                                <!--end::Header-->
                            </div>

                        </div>

                        <div class="col-xl-6">
                          

                            <div class="card card-flush mb-5 mt-5" style="height: 90%;" box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">
                                <asp:LinkButton ID="lnkTodayServiceJob" runat="server" OnClick="lnkTodayServiceJob_Click">
                                    <!--begin::Header-->
                                    <div class="card-header pt-5">
                                        <!--begin::Title-->
                                        <div class="card-title d-flex flex-column">
                                            <!--begin::Info-->
                                            <div class="d-flex align-items-center">

                                                <!--begin::Amount-->
                                                <span class="fs-2hx fw-bold text-dark me-2 ms-4 lh-1 ls-n2">
                                                    <asp:Label ID="lblTodaysServiceJobs" runat="server" Text="0" style="font-size: 26px;" class="text-gray-700" ></asp:Label></span>
                                                <!--end::Amount-->

                                            </div>
                                            <!--end::Info-->
                                            <!--begin::Subtitle-->
                                            <span class="text-gray-700 pt-1 ms-4 fw-semibold fs-1">Todays Service Jobs</span>
                                            <!--end::Subtitle-->
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                    <!--end::Header-->
                                    <!--begin::Card body-->
                                    <div class="card-body pt-2 pb-4 d-flex flex-wrap align-items-center" style="margin-top: 15px;">

                                        <!--begin::Labels-->
                                        <div class="d-flex flex-column content-justify-center flex-row-fluid">
                                            <!--begin::Label-->
                                            <div class="d-flex fw-semibold align-items-center mt-4">
                                                <!--begin::Label-->
                                                <div class="text-gray-700 flex-grow-1 ms-4">Planned Attended</div>
                                                <!--end::Label-->
                                                <!--begin::Stats-->
                                                <div class="fw-bolder text-gray-700 fs-5 ms-4 text-xxl-end">
                                                    <asp:Label ID="lblPlannedAttended" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <!--end::Stats-->
                                            </div>
                                            <!--end::Label-->
                                            <!--begin::Label-->
                                            <div class="d-flex fw-semibold align-items-center my-3">
                                                <!--begin::Label-->
                                                <div class="text-gray-700 flex-grow-1 ms-4">Unplanned Attended</div>
                                                <!--end::Label-->
                                                <!--begin::Stats-->
                                                <div class="fw-bolder text-gray-700 fs-5 text-xxl-end">
                                                    <asp:Label ID="lblUnplannedAttended" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <!--end::Stats-->
                                            </div>
                                            <!--end::Label-->
                                            <!--begin::Label-->
                                            <div class="d-flex fw-semibold align-items-center">
                                                <!--begin::Label-->
                                                <div class="text-gray-700 flex-grow-1 ms-4">Action Taken</div>
                                                <!--end::Label-->
                                                <!--begin::Stats-->
                                                <div class="fw-bolder text-gray-700 fs-5 text-xxl-end">
                                                    <asp:Label ID="lblActionTakenServiceJob" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <!--end::Stats-->
                                            </div>
                                            <!--end::Label-->
                                            <!--begin::Label-->
                                            <div class="d-flex fw-semibold align-items-center my-3">
                                                <!--begin::Label-->
                                                <div class="text-gray-700 flex-grow-1 ms-4">Resolved</div>
                                                <!--end::Label-->
                                                <!--begin::Stats-->
                                                <div class="fw-bolder text-gray-700 fs-5 text-xxl-end">
                                                    <asp:Label ID="lblResolved" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <!--end::Stats-->
                                            </div>
                                            <!--end::Label-->
                                            <!--begin::Label-->
                                            <div class="d-flex fw-semibold align-items-center" style="margin-bottom: 0.75rem;">
                                                <!--begin::Label-->
                                                <div class="text-gray-700 flex-grow-1 ms-4">Planned Pending</div>
                                                <!--end::Label-->
                                                <!--begin::Stats-->
                                                <div class="fw-bolder text-gray-700 fs-5 text-xxl-end">
                                                    <asp:Label ID="lblPlannedPending" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <!--end::Stats-->
                                            </div>
                                            <!--end::Label-->

                                            <div class="form-floating  border-gray-300 rounded mb-7" style="padding-left: 10px; padding-right: 10px; border-style: dashed; border-width: thin ">
                                                <!--begin::Label-->
                                                <div class="d-flex fw-semibold align-items-center  my-3">
                                                    <!--begin::Label-->
                                                    <div class="text-gray-700 fs-5 flex-grow-1 ms-4">
                                                        Invoiced
                                                        <asp:Label ID="lblInvoiced" runat="server" Text="0" Class="fs-2 ms-10"></asp:Label>
                                                    </div>
                                                    <!--end::Label-->
                                                    <!--begin::Stats-->
                                                    <div class="fw-bolder text-gray-700 fs-5 text-xxl-end">
                                                        <asp:Label ID="lblAmount" runat="server" Text="0.00"></asp:Label>
                                                    </div>
                                                    <!--end::Stats-->
                                                </div>
                                                <!--end::Label-->
                                            </div>

                                        </div>
                                        <!--end::Labels-->
                                    </div>
                                    <!--end::Card body-->
                                </asp:LinkButton>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
             <hr style="border-color: #3d3737;"/>

            <!--end::Col-->

             <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" >

                    <div>

                        <div class="col-lg-12 row" style="padding-top: 10px;">

                            <div class="col-lg-3 ms-8">
                                <label class="control-label col-lg-12">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="ddlFromdate" Width="90%" runat="server" DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true" OnSelectedDateChanged="ddlFromdate_SelectedDateChanged" >
                                    </telerik:RadDatePicker>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                    --%>
                                </div>
                            </div>

                               <div class="col-lg-3">
                                <label class="control-label col-lg-12">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="ddlTodate" Width="90%" DateInput-DateFormat="dd-MM-yyyy" runat="server" AutoPostBack="true" OnSelectedDateChanged="ddlTodate_SelectedDateChanged">
                                    </telerik:RadDatePicker>
                                    <asp:CompareValidator ID="dd" runat="server" ControlToValidate="ddlTodate" ControlToCompare="ddlFromdate" ErrorMessage="End date must be greater"
                                        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    <%-- <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                    --%>
                                </div>
                            </div>

                            <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;margin-left:10px;">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="LinkButton1_Click">
                                                    Apply Filter
                                </asp:LinkButton>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

             <div class="col-lg-12 row mt-5 g-5 ms-4">
                 <div class="col-lg-6">
                        <div class="card bgi-no-repeat  mb-lg-8" style="background-color:#9ed4e6;  background-size: 100% 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkServiceReq" OnClick="lnkServiceReq_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                       

                                        <div class="flex-grow-1 me-6">
                                            <span  class="text-gray-700  ms-4 fw-semibold fs-2 d-block" style="font-weight: bold;">Completed Service Jobs</span>
                                        </div>

                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblSalesOrd">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label class ="text-gray-700" runat="server" ID="lblCompletedJobCount" Text="0"  style="font-size: 25px;"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-6 ">
                        <div class="card bgi-no-repeat  mb-lg-8" style="background-color:#eed4ac; background-size: 100% 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="InvServiceJob" OnClick="InvServiceJob_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-gray-700  ms-4 fw-semibold fs-2 d-block" style="font-weight: bold;">Invoiced Service Jobs</span>
                                        </div>

                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblrotDeliverys">
                                            <asp:PlaceHolder ID="pnldel" runat="server" Visible="false">
                                            <asp:Label runat="server" ID="lbldelcount"></asp:Label>
                                                </asp:PlaceHolder>
                                            <asp:Label class ="text-gray-700" runat="server" ID="lblInvoicedJobCount" Text="18"  style="font-size: 25px;"></asp:Label>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>

                 </div>

              <div class="col-lg-12 row  g-5 ms-4 me-4">
                            <div class="col-xl-6" style="margin-top: 1px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1">Service Done For Asset Types</span>
                            </h3>
                        </div>
                         
                        <!--end::Header-->
                        <!--begin::Body-->
                       
                            <!--begin::Body-->
                            <div class="card-body">
                                <!--begin::Chart-->
                              
                                    <canvas id="ServiceAsset"></canvas>
                                
                             
                                <!--end::Chart-->
                            </div>
                            <!--end::Body-->
                       
                        <!--end::Body-->

                    </div>
                    <!--end::Charts Widget 3-->
                </div>
                <div class="col-xl-6" style="margin-top: 1px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1">Service Done Against Complaint Types</span>
                            </h3>
                            <!--begin::Toolbar-->
                        
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body">
                            
                             <canvas id="ComplaintType"></canvas>
                       
                                                </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Charts Widget 3-->
                </div>
                  </div>

        </div>
    </div>



    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript" src="../assets/Chart.js"></script>



</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
