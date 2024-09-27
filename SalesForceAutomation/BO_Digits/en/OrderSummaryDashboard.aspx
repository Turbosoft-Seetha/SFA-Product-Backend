<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OrderSummaryDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OrderSummaryDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
    <div class="kt-portlet">
        <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
            <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                <div>

                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        
                       <div class="col-lg-8 row">
            <div class="col-lg-3">
                <label class="control-label col-lg-12">From Date</label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true">
                    </telerik:RadDatePicker>
                </div>
            </div>

            <div class="col-lg-3">
                <label class="control-label col-lg-12">To Date</label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MM-yyyy" runat="server" AutoPostBack="true">
                    </telerik:RadDatePicker>
                    <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                </div>
            </div>

            <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click">
                                                Apply Filter
                            </asp:LinkButton>
                        </div>
        </div>
                        <div class="col-lg-4">
            <ul class="nav" style="justify-content: flex-end;">
                <li class="nav-item">
                    <asp:LinkButton ID="lnkToday" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkToday_Click">Today</asp:LinkButton>
                </li>
                <li class="nav-item">
                    <asp:LinkButton ID="lnkMonth" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkMonth_Click">Month</asp:LinkButton>
                </li>
                <li class="nav-item">
                    <asp:LinkButton ID="lnkYear" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4" OnClick="lnkYear_Click">Year</asp:LinkButton>
                </li>
            </ul>
        </div>
    </div>


                </div>

            </div>
        </div>
    </div>
</div>

    <div class="post d-flex flex-column-fluid" id="kt_post">

        <div id="kt_content_container" class="col-lg-12">
            <div class="row g-5 g-xl-8">
                <asp:PlaceHolder ID="pnlTimeline" runat="server">

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
                                                        <span style="font-weight: 500;">Active<br />
                                                            Routes</span>
                                                    </div>
                                                    <div class="col-lg-6" style="text-align: left; padding-top: 5px;">
                                                        <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                            <asp:Label ID="lblActiveRoute" Text="50" runat="server"></asp:Label></span>
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
                                                        <span style="font-weight: 500;">Day<br />
                                                            Started</span>
                                                    </div>
                                                    <div class="col-lg-6" style="text-align: left; padding-top: 5px;">
                                                        <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                            <asp:Label ID="lblProductiveRoute" Text="47" runat="server"></asp:Label></span>
                                                    </div>
                                                </div>
                                            </asp:LinkButton>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-3">
                                            <!--begin::Item-->

                                            <div class="d-flex flex-stack">
                                                <div class="col-lg-12 row" style="text-align: center;">
                                                    <asp:LinkButton ID="lnkNotStarted" runat="server" CssClass="d-flex flex-stack" OnClick="lnkNotStarted_Click">
                                                        <div class="col-lg-7 pe-3" style="border-right: 1px solid; text-align: right;">
                                                            <span style="font-weight: 500;">Not<br />
                                                                Started</span>
                                                        </div>
                                                        <div class="col-lg-5 ps-3" style="text-align: left; padding-top: 5px;">
                                                            <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                                <asp:Label ID="lblNonProductiveRoute" Text="3" runat="server"></asp:Label></span>
                                                        </div>
                                                    </asp:LinkButton>
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

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <asp:LinkButton runat="server" ID="lnkPlannedVisit" OnClick="lnkPlannedVisit_Click">
                                    <div class="py-2">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">Planned Visits</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="lblTotalPlannedVisit" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Visited</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblVisitedPlanned" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Pending</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblPendingPlanned" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <asp:LinkButton runat="server" ID="lnkActualVisit" OnClick="lnkActualVisit_Click">
                                    <div class="py-2">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">Actual Visits</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="lblTotalActualVisit" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Planned</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblPlannedActual" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Unplanned</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblUnplannedActual" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <asp:LinkButton runat="server" ID="lnkProdVisit" OnClick="lnkProdVisit_Click">
                                    <div class="py-2">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">Productive</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="lblTotalProductiveVisit" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Planned</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblPlannedProductive" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Unplanned</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblUnplannedProductive" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <asp:LinkButton runat="server" ID="lnkNonProdVisit" OnClick="lnkNonProdVisit_Click">
                                    <div class="py-2">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">Non Productive</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="lblTotalNonProductiveVisit" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Planned</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblPlannedNonProd" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row" style="padding-top: 10px;">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Unplanned</span>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 500;">
                                                        <asp:Label ID="lblUnplannedNonProd" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>


                </asp:PlaceHolder>


                <div class="col-lg-12 mt-8">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch" style="background-size: 100%; background: radial-gradient(circle at 10% 20%, rgb(100, 200, 150) 0%, rgb(130, 150, 200) 100.2%);">
                        <!--begin::Head-->
                        <div id="customSalesHeader" class="card-header" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h2 class="card-title align-items-start flex-column" style="margin-bottom: 20px;">                                
                                     <span class="text-grey-200 mt-2 fw-semibold fs-2" style="color: white;">Sales Order Status</span>                                
                            </h2>
                            <!--end::Title-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row ">

                                <ul class="nav nav-pills nav-pills-custom mb-3" style="display: flex; justify-content: space-around;">
                                    <li class="nav-item col-lg-3 nav-link btn btn-sm fs-6 fw-bold px-4 me-1"
                                        style="flex: 1; background-color: white; height: 7.5rem; padding-top: 20px; margin-left: 15px; color: #333;"
                                        data-kt-timeline-widget-1="tab" data-bs-toggle="tab" onclick="window.location.href='OrderStatusDashboard.aspx?type=QOT';">


                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-4 mb-1">
                                                <asp:Label ID="lblQot" Text="0" runat="server"></asp:Label></span>
                                        </div>

                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label fw-semibold fs-6 mb-1">
                                                <asp:Label ID="Label2" Text="Quotations" runat="server"></asp:Label>
                                                <span style="float: right;">
                                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                                </span>
                                            </span>
                                        </div>
                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-6 mb-1">
                                                <asp:Label ID="lblQotAmt" Text="AED 0.00" runat="server"></asp:Label></span>
                                        </div>

                                    </li>

                                    <li class="nav-item col-lg-3 nav-link btn btn-sm btn-active btn-active-purple fs-6 fw-bold px-4 me-1"
                                        style="flex: 1; background-color: white; height: 7.5rem; padding-top: 20px; margin-left: 15px; color: #333;"
                                        data-kt-timeline-widget-1="tab" data-bs-toggle="tab" onclick="window.location.href='OrderStatusDashboard.aspx?type=SAL';">

                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-4 mb-1">
                                                <asp:Label ID="lblSales" Text="0" runat="server"></asp:Label></span>
                                        </div>
                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label fw-semibold fs-6 mb-1">
                                                <asp:Label ID="Label5" Text="Sales Orders" runat="server"></asp:Label>
                                                <span style="float: right;">
                                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                                </span>
                                            </span>
                                        </div>

                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-6 mb-1">
                                                <asp:Label ID="lblSalesAmt" Text="AED 0.00" runat="server"></asp:Label></span>
                                        </div>

                                    </li>

                                    <li class="nav-item col-lg-3 nav-link btn btn-sm btn-active btn-active-purple fs-6 fw-bold px-4 me-1"
                                        style="flex: 1; background-color: white; height: 7.5rem; padding-top: 20px; margin-left: 15px; color: #333;"
                                        data-kt-timeline-widget-1="tab" data-bs-toggle="tab" onclick="window.location.href='OrderStatusDashboard.aspx?type=CSO';">



                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-4 mb-1">
                                                <asp:Label ID="lblConSal" Text="0" runat="server"></asp:Label></span>
                                        </div>
                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label fw-semibold fs-6 mb-1">
                                                <asp:Label ID="Label4" Text="Confirmed Sales Orders" runat="server"></asp:Label>
                                                <span style="float: right;">
                                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                                </span>
                                            </span>
                                        </div>
                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-6 mb-1">
                                                <asp:Label ID="lblConSalAmt" Text="AED 0.00" runat="server"></asp:Label></span>
                                        </div>
                                    </li>

                                    <li class="nav-item col-lg-3 nav-link btn btn-sm btn-active btn-active-purple fs-6 fw-bold px-4 me-1"
                                        style="flex: 1; background-color: white; height: 7.5rem; padding-top: 20px; margin-left: 15px; color: #333;"
                                        data-kt-timeline-widget-1="tab" data-bs-toggle="tab">


                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-5 mb-1">
                                                <asp:Label ID="lblDel" Text="0" runat="server"></asp:Label></span>
                                        </div>

                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label fw-semibold fs-6 mb-1">
                                                <asp:Label ID="Label9" Text="Delivered" runat="server"></asp:Label>
                                                <span style="float: right;">
                                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                                </span>
                                            </span>
                                        </div>
                                        <div style="text-align: left; padding-left: 10px;">
                                            <span class="card-label  fw-semibold fs-6 mb-1">
                                                <asp:Label ID="lblDelAmt" Text="AED 0.00" runat="server"></asp:Label></span>
                                        </div>

                                    </li>

                                </ul>

                            </div>
                            <!--end::Row-->
                        </div>

                    </div>
                    <!--end::Mixed Widget 14-->

                </div>



                <div class="col-lg-12 row">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #6397b2; background-image: linear-gradient(to right,#b47f63, #ce8eb3); background-size: 100% 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkOutstanding" OnClick="lnkOutstanding_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/so.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblSalesOrdCount">
                                                <asp:Label runat="server" ID="lblTotOutstandingCount" Text="0"></asp:Label>

                                            </span></span>
                                            <span class="text-white fw-semibold fs-3 d-block">Outstanding Invoices </span>
                                        </div>

                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblSalesOrd">
                                            <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblTotOutstandingAmount" Text="0"></asp:Label>
                                            <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arrow_right_white.png" height="15" width="15">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkAr" OnClick="lnkAr_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/oi.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_lblrotDeliverysCount">
                                                <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                                                    <asp:Label runat="server" ID="Label1"></asp:Label>
                                                </asp:PlaceHolder>
                                                <asp:Label runat="server" ID="lblTotalArCount" Text="0"></asp:Label>
                                            </span></span>
                                            <span class="text-black fw-semibold fs-3 d-block">AR Collections</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_lblrotDeliverys">
                                            <asp:PlaceHolder ID="pnldel" runat="server" Visible="false">
                                                <asp:Label runat="server" ID="lbldelcount"></asp:Label>
                                            </asp:PlaceHolder>
                                            <asp:Label runat="server" ID="lblTotalArAmount" Text="0"></asp:Label>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/icons/svg/general/arrow_right_white.png" height="15" width="15">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                </div>


                <div class="col-xl-6" style="margin-top: 35px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1">Monthly Sales</span>
                            </h3>
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body">
                            <div class="chartBox">
                                <!--begin::Chart-->
                                <canvas id="MonthlySales"></canvas>
                                <!--end::Chart-->
                            </div>
                        </div>
                        <!--end::Body-->

                    </div>
                    <!--end::Charts Widget 3-->
                </div>
                <div class="col-xl-6" style="margin-top: 35px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1"><a href="TopSellingDasboardDetail.aspx">Top Selling</a></span>
                            </h3>
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <div class="w3-row">
                                    <a href="javascript:void(0)" onclick="openSelling(event, 'Item');" id="defaultOpenSelling">
                                        <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding" style="width: 63px;">Item</div>
                                    </a>
                                    <a href="javascript:void(0)" onclick="openSelling(event, 'Sub');">
                                        <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding" style="width: 121px;">Sub Category</div>
                                    </a>
                                    <a href="javascript:void(0)" onclick="openSelling(event, 'Category');">
                                        <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding" style="width: 91px;">Category</div>
                                    </a>
                                </div>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body">
                            <!--begin::Chart-->
                            <div id="Item" class="w3-container city" style="display: none">
                                <canvas id="TopSellingItem"></canvas>
                            </div>
                            <div id="Sub" class="w3-container city" style="display: none">
                                <canvas id="TopSellingSubCat"></canvas>
                            </div>
                            <div id="Category" class="w3-container city" style="display: none">
                                <canvas id="TopSellingCategory"></canvas>
                            </div>
                            <!--end::Chart-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Charts Widget 3-->
                </div>
                <div class="col-xl-6" style="margin-top: 0px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1"><a href="MostPerformingDetail.aspx">Most Performing</a></span>
                            </h3>
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <div class="w3-row">
                                    <a href="javascript:void(1)" onclick="openPerforming(event, 'Route');" id="defaultOpenPerforming">
                                        <div class="w3-third tablinks w3-bottombar w3-hover-light-grey w3-padding" style="width: 70px;">Route</div>
                                    </a>
                                    <a href="javascript:void(1)" onclick="openPerforming(event, 'Customer');">
                                        <div class="w3-third tablinks w3-bottombar w3-hover-light-grey w3-padding" style="width: 96px;">Customer</div>
                                    </a>
                                </div>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body">
                            <!--begin::Chart-->
                            <div id="Route" class="w3-container shop" style="display: none">
                                <canvas id="MostPerformingRoute"></canvas>
                            </div>
                            <div id="Customer" class="w3-container shop" style="display: none">
                                <canvas id="MostPerformingCustomer"></canvas>
                            </div>
                            <!--end::Chart-->
                        </div>
                        <!--end::Body-->

                    </div>
                    <!--end::Charts Widget 3-->
                </div>


            </div>

        </div>
    </div>

        <style>
    
    #customSalesHeader {
    min-height: 35px !important;
 padding: 10px 2.25rem !important;
    
}

    
</style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript" src="../assets/Chart.js"></script>
<script>
    const ctx7 = document.getElementById('TargetAcheivedSalesMan');
    const myChart7 = new Chart(ctx7, {
        type: 'scatter',
        data: {
            labels: [
                'January',
                'February',
                'March',
                'April'
            ],
            datasets: [{
                type: 'bar',
                label: 'Bar Dataset',
                data: [10, 20, 30, 40],
                borderColor: 'rgb(255, 99, 132)',
                backgroundColor: 'rgba(255, 99, 132, 0.2)'
            }, {
                type: 'line',
                label: 'Line Dataset',
                data: [50, 50, 50, 50],
                fill: false,
                borderColor: 'rgb(54, 162, 235)'
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

<script>
    function openSelling(evt, cityName) {
        var i, x, tablinks;
        x = document.getElementsByClassName("city");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablink");
        for (i = 0; i < x.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" w3-border-red", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.firstElementChild.className += " w3-border-red";
    }
</script>
<script>
    function openPerforming(evtn, performingName) {
        var j, y, tablin;
        y = document.getElementsByClassName("shop");
        for (j = 0; j < y.length; j++) {
            y[j].style.display = "none";
        }
        tablin = document.getElementsByClassName("tablinks");
        for (j = 0; j < y.length; j++) {
            tablin[j].className = tablin[j].className.replace(" w3-border-red", "");
        }
        document.getElementById(performingName).style.display = "block";
        evtn.currentTarget.firstElementChild.className += " w3-border-red";
    }
</script>
<script>
    function openReturned(evts, returningType) {
        var k, z, tabli;
        z = document.getElementsByClassName("country");
        for (k = 0; k < z.length; k++) {
            z[k].style.display = "none";
        }
        tabli = document.getElementsByClassName("tablinkss");
        for (k = 0; k < z.length; k++) {
            tabli[k].className = tabli[k].className.replace(" w3-border-red", "");
        }
        document.getElementById(returningType).style.display = "block";
        evts.currentTarget.firstElementChild.className += " w3-border-red";
    }
</script>
<script>
    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpenSelling").click();
    document.getElementById("defaultOpenPerforming").click();
    document.getElementById("defaultopenReturned").click();
</script>
</asp:Content>



