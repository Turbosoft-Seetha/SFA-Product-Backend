﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AdminChartDashboard.aspx.cs" Inherits="SalesForceAutomation.Admin.AdminChartDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' />
    <link href="assets/style.bundle.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.js"></script>
    <script type="text/javascript" src="assets/Chart.js"></script>
    <style type="text/css">
        .chartBox{
           
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <div class="col-lg-12" style="padding-left: 40px; padding-right: 40px;">
            <div class="kt-portlet">
                <div class="kt-portlet__head" style="background-color: #f2f3f8; padding: 0px; border-bottom: 0px;">
                    <div class="kt-portlet__head-label">
                        <div class="col-lg-12 row">
                            <div class="col-lg-4">
                                <label class="control-label col-lg-12">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <label class="control-label col-lg-12">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4" style="text-align: center; top: 19px;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <div class="kt-portlet__head-actions">
                        <ul class="nav" style="padding-top: 22px;">
                            <li class="nav-item">
                                <asp:LinkButton ID="lnkToday" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkToday_Click">Today</asp:LinkButton>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="lnkMonth" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkMonth_Click">Month</asp:LinkButton>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="lnkYear" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4" OnClick="lnkYear_Click">Year</asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="post d-flex flex-column-fluid" id="kt_post">

            <div id="kt_content_container" class="container-xxl" style="margin-left: 0px; margin-right: 0px; max-width: none;">
                <div class="row g-5 g-xl-8">
                    <div class="col-xl-6">
                        <!--begin::Mixed Widget 14-->
                        <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-color: #6397b2; background-image: url(assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                            <!--begin::Head-->
                            <div class="card-header pt-5" style="border-bottom: 0px;">
                                <!--begin::Title-->
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold text-dark">
                                        <asp:Label ID="lblTotalInvoice" runat="server" Text="0" ForeColor="White"></asp:Label></span>
                                    <span class="text-grey-400 mt-1 fw-semibold fs-6" style="color: white;">Total Invoices</span>
                                </h3>
                                <!--end::Title-->
                                <!--begin::Toolbar-->
                                <div class="card-toolbar">
                                    <p class="" style="color: white; margin-bottom: 0.5rem !important">
                                        <span style="font-size: 15px;"><asp:Label ID="Label1" runat="server" ></asp:Label></span>
                                        <span class="" style="font-size: 17px;">
                                            <asp:Label ID="lblTotalInvoiceSum" runat="server" Text="0"></asp:Label></span>
                                    </p>
                                </div>
                                <!--end::Toolbar-->
                            </div>
                            <!--end::Head-->
                            <!--begin::Body-->
                            <div class="card-body d-flex flex-column">
                                <!--begin::Row-->
                                <div class="row g-0">
                                    <!--begin::Col-->
                                    <div class="col-6">
                                        <div class="d-flex align-items-center mb-9 me-2">
                                            <!--begin::Symbol-->
                                            <div class="symbol symbol-40px me-3">
                                                <div class="symbol-label bg-white bg-opacity-50" style="width: 60px; height: 60px;">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <img src="assets/media/dashboard/invoices.png" alt="Invoice" width="34" height="34" />
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
                                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                        <asp:Label ID="Label2" runat="server" ></asp:Label>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalInvoicesSum" runat="server" Text="0"></asp:Label>
                                                </span>
                                                    </div>
                                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Sales</div>
                                                </asp:LinkButton>
                                            </div>
                                            <!--end::Title-->
                                        </div>
                                    </div>
                                    <!--end::Col-->
                                    <!--begin::Col-->
                                    <div class="col-6">
                                        <div class="d-flex align-items-center mb-9 ms-2">
                                            <!--begin::Symbol-->
                                            <div class="symbol symbol-40px me-3">
                                                <div class="symbol-label bg-white bg-opacity-50" style="width: 60px; height: 60px;">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <img src="assets/media/dashboard/gr.png" alt="Good Return" width="34" height="34" />
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
                                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                        <asp:Label ID="Label3" runat="server" ></asp:Label>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalGReturnsSum" runat="server" Text="0"></asp:Label>
                                                </span>
                                                    </div>
                                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Good Return</div>
                                                </asp:LinkButton>
                                            </div>
                                            <!--end::Title-->
                                        </div>
                                    </div>
                                    <!--end::Col-->
                                    <!--begin::Col-->
                                    <div class="col-6">
                                        <div class="d-flex align-items-center me-2">
                                            <!--begin::Symbol-->
                                            <div class="symbol symbol-40px me-3">
                                                <div class="symbol-label bg-white bg-opacity-50" style="width: 60px; height: 60px;">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <img src="assets/media/dashboard/br.png" alt="Bad Return" width="34" height="34" />
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
                                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                        <asp:Label ID="Label4" runat="server" ></asp:Label>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalBReturnsSum" runat="server" Text="0"></asp:Label>
                                                </span>
                                                    </div>
                                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Bad Return</div>
                                                </asp:LinkButton>
                                            </div>
                                            <!--end::Title-->
                                        </div>
                                    </div>
                                    <!--end::Col-->
                                    <!--begin::Col-->
                                    <div class="col-6">
                                        <div class="d-flex align-items-center ms-2">
                                            <!--begin::Symbol-->
                                            <div class="symbol symbol-40px me-3">
                                                <div class="symbol-label bg-white bg-opacity-50" style="width: 60px; height: 60px;">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs045.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <img src="assets/media/dashboard/foc.png" alt="Free of cost" width="34" height="34" />
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <!--end::Symbol-->
                                            <!--begin::Title-->
                                            <div>
                                                <asp:LinkButton ID="lnkFreeGood" runat="server" OnClick="lnkFreeGood_Click">
                                                    <div class="fs-5 fw-bolder lh-1" style="color: white;">
                                                        <asp:Label ID="lblTotalFreeGoods" runat="server" Text="0"></asp:Label>
                                                    </div>

                                                    <div class="fs-7 fw-bold" style="color: whitesmoke;">Free of cost</div>
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
                    <div class="col-xl-6">
                        <div class="card" style="background-color: #c0e2f4;">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="d-flex">
                                            <img src="assets/media/dashboard/orderreq2.png" class="w-40px me-6" alt="" />
                                            <div class="d-flex flex-column">
                                                <asp:LinkButton ID="lnkTotalOrder" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lnkTotalOrder_Click">
                                                    <asp:Label ID="lblTotalOrder" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                                </asp:LinkButton>
                                                <div class="fs-6 fw-semibold" style="color: black">Order Request</div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                                <span style="font-size: 15px;"><asp:Label ID="Label5" runat="server" ></asp:Label></span>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalOrderSum" runat="server" Text="0"></asp:Label></span>
                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->
                                </div>
                            </div>
                        </div>
                        <div class="card" style="margin-top: 12px; background-color: #fcebff;">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="d-flex">
                                            <img src="assets/media/dashboard/ar2.png" class="w-40px me-6" alt="" />
                                            <div class="d-flex flex-column">
                                                <asp:LinkButton ID="lnkTotalAR" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server" OnClick="lnkTotalAR_Click">
                                                    <asp:Label ID="lblTotalAR" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                                </asp:LinkButton>
                                                <div class="fs-6 fw-semibold" style="color: black">Account Receivable Collection</div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                                <span style="font-size: 15px;"><asp:Label ID="Label6" runat="server" ></asp:Label></span>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalARSum" runat="server" Text="0"></asp:Label></span>
                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->
                                </div>
                            </div>
                        </div>
                        <div class="card" style="margin-top: 12px; background-color: #fff8dd;">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="d-flex">
                                            <img src="assets/media/dashboard/advance2.png" class="w-40px me-6" alt="" />
                                            <div class="d-flex flex-column">
                                                <asp:LinkButton ID="lnkTotalAdvance" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lnkTotalAdvance_Click">
                                                    <asp:Label ID="lblTotalAdvance" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                                </asp:LinkButton>
                                                <div class="fs-6 fw-semibold" style="color: black">Advance Collection</div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                                <span style="font-size: 15px;"><asp:Label ID="Label7" runat="server" ></asp:Label></span>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalAdvanceSum" runat="server" Text="0"></asp:Label></span>
                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
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
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <div class="card card-xl-stretch mb-5 mb-xl-8">
                            <!--begin::Header-->
                            <div class="card-header border-0 pt-5">
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">Top Selling</span>
                                </h3>
                                <!--begin::Toolbar-->
                                <div class="card-toolbar">
                                    <asp:LinkButton CssClass="btn btn-sm btn-color-muted btn-active btn-active-primary px-4 me-1" ID="btnItem" runat="server" OnClick="btnItem_Click">Item</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-sm btn-color-muted btn-active btn-active-primary px-4 me-1" ID="btnSubCat" runat="server" OnClick="btnSubCat_Click">Sub Category</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-sm btn-color-muted btn-active btn-active-primary px-4" ID="btnCategory" runat="server" OnClick="btnCategory_Click">Category</asp:LinkButton>
                                </div>
                                <!--end::Toolbar-->
                            </div>
                            <!--end::Header-->
                            <!--begin::Body-->
                            <div class="card-body">
                                <div class="chartBox">
                                <!--begin::Chart-->
                                <asp:PlaceHolder ID="pnlItems" Visible="true" runat="server">
                                    <canvas id="TopSellingItem"></canvas>
                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="pnlSubCat" Visible="true" runat="server">
                                    <canvas id="TopSellingSubCat"></canvas>
                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="pnlCategory" Visible="true" runat="server">
                                    <canvas id="TopSellingCategory"></canvas>
                                </asp:PlaceHolder>
                                <!--end::Chart-->
                                    </div>
                            </div>
                            <!--end::Body-->
                        </div>
                        <!--end::Charts Widget 3-->
                    </div>
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <div class="card card-xl-stretch mb-5 mb-xl-8">
                            <!--begin::Header-->
                            <div class="card-header border-0 pt-5">
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">Most Performing</span>
                                </h3>
                                <!--begin::Toolbar-->
                                <div class="card-toolbar">
                                    <asp:LinkButton CssClass="btn btn-sm btn-color-muted btn-active btn-active-primary px-4 me-1" ID="lnkRoute" runat="server" OnClick="lnkRoute_Click">Route</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-sm btn-color-muted btn-active btn-active-primary px-4 me-1" ID="lnkCustomer" runat="server" OnClick="lnkCustomer_Click">Customer</asp:LinkButton>
                                </div>
                                <!--end::Toolbar-->
                            </div>
                            <!--end::Header-->
                            <!--begin::Body-->
                            <div class="card-body">
                                <div class="chartBox">
                                <!--begin::Chart-->
                                <asp:PlaceHolder ID="pnlRoute" Visible="true" runat="server">
                                    <canvas id="MostPerformingRoute"></canvas>
                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="pnlCustomer" Visible="true" runat="server">
                                    <canvas id="MostPerformingCustomer"></canvas>
                                </asp:PlaceHolder>
                                <!--end::Chart-->
                                    </div>
                            </div>
                            <!--end::Body-->

                        </div>
                        <!--end::Charts Widget 3-->
                    </div>
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <div class="card card-xl-stretch mb-5 mb-xl-8">
                            <!--begin::Header-->
                            <div class="card-header border-0 pt-5">
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">Frequently Returned</span>
                                </h3>
                            </div>
                            <!--end::Header-->
                            <!--begin::Body-->
                            <div class="card-body">
                                <div class="chartBox">
                                <!--begin::Chart-->
                                <canvas id="FrequentlyReturned"></canvas>
                                <!--end::Chart-->
                                    </div>
                            </div>
                            <!--end::Body-->

                        </div>
                        <!--end::Charts Widget 3-->
                    </div>
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <div class="card card-xl-stretch mb-5 mb-xl-8">
                            <!--begin::Header-->
                            <div class="card-header border-0 pt-5">
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">Target Acheived Sales Man</span>
                                </h3>
                            </div>
                            <!--end::Header-->
                            <!--begin::Body-->
                            <div class="card-body">
                                <div class="chartBox">
                                <!--begin::Chart-->
                                <canvas id="TargetAcheivedSalesMan"></canvas>
                                <!--end::Chart-->
                                    </div>
                            </div>
                            <!--end::Body-->

                        </div>
                        <!--end::Charts Widget 3-->
                    </div>
                </div>

            </div>
        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const ctx1 = document.getElementById('FrequentlyReturned');
        const myChart1 = new Chart(ctx1, {
            type: 'bubble',
            data: {
                datasets: [{
                    label: 'First Dataset',
                    data: [{
                        x: 20,
                        y: 30,
                        r: 15
                    }, {
                        x: 40,
                        y: 10,
                        r: 10
                    }],
                    backgroundColor: 'rgb(255, 99, 132)'
                }]
            },
            options: {}
        });
    </script>
    <script>
        const ctx2 = document.getElementById('TargetAcheivedSalesMan');
        const myChart2 = new Chart(ctx2, {
            type: 'scatter',
            data : {
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
    

</asp:Content>