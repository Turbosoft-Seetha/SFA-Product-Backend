<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="DeliverySummary.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.DeliverySummary" %>



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
                                        <asp:LinkButton ID="btnToday" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="btnToday_Click">Today</asp:LinkButton>
                                    </li>
                                    <li class="nav-item">
                                        <asp:LinkButton ID="btnMonth" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="btnMonth_Click">Month</asp:LinkButton>
                                    </li>
                                    <li class="nav-item">
                                        <asp:LinkButton ID="btnYear" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4" OnClick="btnYear_Click">Year</asp:LinkButton>
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
                                                            <asp:Label ID="lblActiveRoute" Text="0" runat="server"></asp:Label></span>
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
                                                            <asp:Label ID="lblProductiveRoute" Text="0" runat="server"></asp:Label></span>
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
                                                                <asp:Label ID="lblNonProductiveRoute" Text="0" runat="server"></asp:Label></span>
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

                </asp:PlaceHolder>

                <div class="col-lg-12 row g-0" style="padding-top: 20px; padding-right: 5px;">
                    <ul class="nav nav-pills nav-pills-custom mb-3" style="justify-content: space-around;">
                        <li class="nav-item col-lg-3 nav-link btn btn-sm btn-active fs-4 fw-bold px-2 active" data-kt-timeline-widget-1="tab"
                            data-bs-toggle="tab" style="background-color: white; width: 22%; height: 15vh; padding-top: 20px;"
                            href="#kt_timeline_widget_1"
                            onclick="window.location.href='RouteDeliveryDashboard.aspx?mode=1&&type=AL';">
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-3 mb-1">
                                    <asp:Label ID="lblAllCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                            </div>
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-4 mb-1" style="padding-top: 20px">
                                    <asp:Label ID="lblAll" Text="All Deliveries" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                <span style="float: right;">
                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                </span>
                            </div>
                        </li>

                        <li class="nav-item col-lg-3 nav-link btn btn-sm btn-active fs-4 fw-bold px-2" data-kt-timeline-widget-1="tab"
                            data-bs-toggle="tab" style="background-color: white; width: 22%; height: 15vh; padding-top: 20px;"
                            href="#kt_timeline_widget_2"
                            onclick="window.location.href='RouteDeliveryDashboard.aspx?mode=1&&type=FD';">
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-3 mb-1">
                                    <asp:Label ID="lblFDCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                            </div>
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-4 mb-1" style="padding-top: 20px">
                                    <asp:Label ID="lblFD" Text="Fully Delivered" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                <span style="float: right;">
                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                </span>
                            </div>
                        </li>

                        <li class="nav-item col-lg-3 nav-link btn btn-sm btn-active fs-4 fw-bold px-2" data-kt-timeline-widget-1="tab"
                            data-bs-toggle="tab" style="background-color: white; width: 22%; height: 15vh; padding-top: 20px;"
                            href="#kt_timeline_widget_3"
                            onclick="window.location.href='RouteDeliveryDashboard.aspx?mode=1&&type=PD';">
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-3 mb-1">
                                    <asp:Label ID="lblPDCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                            </div>
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-4 mb-1" style="padding-top: 20px">
                                    <asp:Label ID="lblPD" Text="Partially Delivered" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                <span style="float: right;">
                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                </span>
                            </div>
                        </li>

                        <li class="nav-item col-lg-3 nav-link btn btn-sm btn-active fs-4 fw-bold px-2" data-kt-timeline-widget-1="tab"
                            data-bs-toggle="tab" style="background-color: white; width: 22%; height: 15vh; padding-top: 20px;"
                            href="#kt_timeline_widget_4"
                            onclick="window.location.href='RouteDeliveryDashboard.aspx?mode=1&&type=ND';">
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-3 mb-1">
                                    <asp:Label ID="lblNDCount" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                            </div>
                            <div style="text-align: left; padding-left: 10px;">
                                <span class="card-label fw-bold fs-4 mb-1" style="padding-top: 20px">
                                    <asp:Label ID="lblND" Text="Not Delivered" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                <span style="float: right;">
                                    <img src="../assets/media/svg/general/arrow_right.png" height="15" width="15">
                                </span>
                            </div>
                        </li>
                    </ul>
                </div>



                <div class="col-lg-12 mt-4">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch" style="background-color: #6397b2; background-image: linear-gradient(#03CDFD, #3483D9); background-size: 100%;">

                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row  g-0 p-3">
                                <!--begin::Col-->
                                <div class="col-3">
                                    <div class="d-flex align-items-center ms-2 mb-9">

                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="totalInvoices" runat="server" OnClick="totalInvoices_Click">
                                                <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                    <asp:Label ID="lblTotalInvoice" runat="server" Text="0"></asp:Label>
                                                </div>

                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">Total Invoices</div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <asp:Label ID="Label4" runat="server"></asp:Label>
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalInvoiceSum" runat="server" Text="AED 0.00"></asp:Label>
                                                    </span>
                                                </div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                <!--begin::Col-->
                                <div class="col-3">
                                    <div class="d-flex align-items-center mb-12 me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-90" style="width: 50px; height: 50px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/invoices.png" alt="Invoice" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkSales" runat="server" OnClick="lnkSales_Click">
                                                <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                    <asp:Label ID="lblTotalInvoices" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">Sales</div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalInvoicesSum" runat="server" Text="AED 0.00"></asp:Label>
                                                    </span>
                                                </div>

                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                <!--begin::Col-->
                                <div class="col-3">
                                    <div class="d-flex align-items-center mb-12 ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-90" style="width: 50px; height: 50px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/gr.png" alt="Good Return" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkGRReturns" runat="server" OnClick="lnkGRReturns_Click">
                                                <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                    <asp:Label ID="lblTotalGReturns" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">Good Return</div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalGReturnsSum" runat="server" Text="AED 0.00"></asp:Label>
                                                    </span>
                                                </div>

                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                <!--begin::Col-->
                                <div class="col-3">
                                    <div class="d-flex align-items-center me-2 mb-9">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-90" style="width: 50px; height: 50px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/br.png" alt="Bad Return" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkBRReturns" runat="server" OnClick="lnkBRReturns_Click">

                                                <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                    <asp:Label ID="lblTotalBReturns" runat="server" Text="0"></asp:Label>
                                                </div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">Bad Return</div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <asp:Label ID="Label3" runat="server"></asp:Label>
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalBReturnsSum" runat="server" Text="AED 0.00"></asp:Label>
                                                    </span>
                                                </div>

                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->

                            </div>
                            <!--end::Row-->
                        </div>

                    </div>
                    <!--end::Mixed Widget 14-->

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
                <div class="col-xl-6" style="margin-top: 0px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1"><a href="FrequentlyReturnedDetail.aspx">Frequently Returned</a></span>
                            </h3>
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <div class="w3-row">
                                    <a href="javascript:void(1)" onclick="openReturned(event, 'Good');" id="defaultopenReturned">
                                        <div class="w3-third tablinkss w3-bottombar w3-hover-light-grey w3-padding" style="width: 70px;">Good</div>
                                    </a>
                                    <a href="javascript:void(1)" onclick="openReturned(event, 'Bad');">
                                        <div class="w3-third tablinkss w3-bottombar w3-hover-light-grey w3-padding" style="width: 57px;">Bad</div>
                                    </a>
                                </div>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Header-->
                        <!--begin::Body-->
                        <div class="card-body">
                            <!--begin::Body-->
                            <div class="card-body">
                                <!--begin::Chart-->
                                <div id="Good" class="w3-container country" style="display: none">
                                    <canvas id="FrequentlyGoodReturned"></canvas>
                                </div>
                                <div id="Bad" class="w3-container country" style="display: none">
                                    <canvas id="FrequentlyBadReturned"></canvas>
                                </div>
                                <!--end::Chart-->
                            </div>
                            <!--end::Body-->
                        </div>
                        <!--end::Body-->

                    </div>
                    <!--end::Charts Widget 3-->
                </div>

            </div>

        </div>
    </div>

    <style>
        .nav-item.active {
            background-image: url('../assets/media/svg/shapes/top-green.png');
            color: white;
            background-size: cover;
            /* Add any other styles for the active state */
        }

            .nav-item.active a {
                color: white !important;
            }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript" src="../assets/Chart.js"></script>

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
        document.getElementById("defaultOpenPerforming").click();
        document.getElementById("defaultopenReturned").click();
    </script>
</asp:Content>


