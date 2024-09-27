<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="DashboardReport.aspx.cs" Inherits="SalesForceAutomation.Admin.DashboardReport" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' />
    <link href="assets/style.bundle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
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
                <!--begin::Col-->
                <div class="col-xl-4">
                    
                    <!--begin::Mixed Widget 13-->
                    <div class="card card-xl-stretch mb-xl-8" style="background-color:#f1928d;">
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Wrapper-->
                            <div class="d-flex flex-column flex-grow-1">
                                <!--begin::Chart-->
                                <div class="mixed-widget-13-chart" style="height: 100px">
                                    <img src="assets/media/dashboard/chart.png" alt="Invoice" style="width: 100%;" />
                                </div>
                                <!--end::Chart-->
                            </div>
                            <!--end::Wrapper-->
                            <!--begin::Stats-->
                            <div class="pt-5">
                                <asp:LinkButton ID="lnkInvoice" runat="server" OnClick="lnkInvoice_Click">
                                <h3><span class="" style="color: white; font-weight: 600">
                                    <asp:Label ID="lblTotalInvoice" runat="server" Text="0" ForeColor="White"></asp:Label></span></h3>
                                <p class="" style="color: white; margin-bottom: 0.5rem !important">
                                    <span style="font-size: 15px;">AED</span>
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalInvoiceSum" runat="server" Text="0"></asp:Label></span>
                                </p>
                                <p style="color: whitesmoke; margin-bottom: 0px;">Invoices</p>
                                </asp:LinkButton>
                            </div>
                            <!--end::Stats-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Mixed Widget 13-->
                    
                </div>
                <!--end::Col-->
                <div class="col-xl-8">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-color: #6397b2; background-position: right bottom; background-size: 25% auto; background-image: url(assets/media/dashboard/sales.png)">
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Wrapper-->
                            <div class="d-flex flex-column mb-7">
                                <!--begin::Title-->
                                <p class="fw-fw-bold fs-3" style="color:white;">Sales Jobs</p>
                                <!--end::Title-->
                            </div>
                            <!--end::Wrapper-->
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
                                            <div class="fs-5 fw-bolder lh-1" style="color:white;">
                                                <asp:Label ID="lblTotalInvoices" runat="server" Text="0"></asp:Label>
                                            </div>
                                            <div class="fs-7 fw-bold" style="color:whitesmoke;">
                                                AED
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalInvoicesSum" runat="server" Text="0"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="fs-7 fw-bold" style="color:whitesmoke;">Sales</div>
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
                                            <div class="fs-5 fw-bolder lh-1" style="color:white;">
                                                <asp:Label ID="lblTotalGReturns" runat="server" Text="0"></asp:Label>
                                            </div>
                                            <div class="fs-7 fw-bold" style="color:whitesmoke;">
                                                AED
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalGReturnsSum" runat="server" Text="0"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="fs-7 fw-bold" style="color:whitesmoke;">Good Return</div>
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
                                            <div class="fs-5 fw-bolder lh-1" style="color:white;">
                                                <asp:Label ID="lblTotalBReturns" runat="server" Text="0"></asp:Label>
                                            </div>
                                            <div class="fs-7 fw-bold" style="color:whitesmoke;">
                                                AED
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalBReturnsSum" runat="server" Text="0"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="fs-7 fw-bold" style="color:whitesmoke;">Bad Return</div>
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
                                            <div class="fs-5 fw-bolder lh-1" style="color:white;">
                                                <asp:Label ID="lblTotalFreeGoods" runat="server" Text="0"></asp:Label>
                                            </div>
                                            
                                            <div class="fs-7 fw-bold" style="color:whitesmoke;">Free of cost</div>
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
            </div>

            <div class="row g-5 g-xl-8">
                <div class="col-xl-4">
                    <!--begin::Statistics Widget 1-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-color:#fff8dd; background-position: right top; background-size: 85% auto; background-image: url(assets/media/dashboard/order.png)">
                        <!--begin::Body-->
                        <div class="card-body">
                            <asp:LinkButton ID="lnkTotalOrder" runat="server" OnClick="lnkTotalOrder_Click">
                            <h3 style="padding-top: 20px;"><span class="" style="color: white; font-weight: 600">
                                <asp:Label ID="lblTotalOrder" runat="server" Text="0" ForeColor="Black"></asp:Label></span></h3>
                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                <span style="font-size: 15px;">AED</span>
                                <span class="" style="font-size: 17px;">
                                    <asp:Label ID="lblTotalOrderSum" runat="server" Text="0"></asp:Label></span>
                            </p>
                            <p style="color: grey; margin-bottom: 0px;">Order Requests</p>
                            </asp:LinkButton>
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Statistics Widget 1-->
                </div>
                <div class="col-xl-4">
                    <!--begin::Statistics Widget 1-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-position: right top; background-size: 85% auto; background-image: url(assets/media/dashboard/ar.png)">
                        <!--begin::Body-->
                        <div class="card-body">
                            <asp:LinkButton ID="lnkTotalAR" runat="server" OnClick="lnkTotalAR_Click">
                            <h3 style="padding-top: 20px;"><span class="" style="color: white; font-weight: 600">
                                <asp:Label ID="lblTotalAR" runat="server" Text="0" ForeColor="Black"></asp:Label></span></h3>
                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                <span style="font-size: 15px;">AED</span>
                                <span class="" style="font-size: 17px;">
                                    <asp:Label ID="lblTotalARSum" runat="server" Text="0"></asp:Label></span>
                            </p>
                            <p style="color: grey; margin-bottom: 0px;">AR Collection</p>
                            </asp:LinkButton>
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Statistics Widget 1-->
                </div>
                <div class="col-xl-4">
                    <!--begin::Statistics Widget 1-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-5 mb-xl-8" style="background-color: #fcebff; background-position: right top; background-size: 85% auto; background-image: url(assets/media/dashboard/advance.png)">
                        <!--begin::Body-->
                        <div class="card-body">
                            <asp:LinkButton ID="lnkTotalAdvance" runat="server" OnClick="lnkTotalAdvance_Click">
                            <h3 style="padding-top: 20px;"><span class="" style="color: white; font-weight: 600">
                                <asp:Label ID="lblTotalAdvance" runat="server" Text="0" ForeColor="Black"></asp:Label></span></h3>
                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                <span style="font-size: 15px;">AED</span>
                                <span class="" style="font-size: 17px;">
                                    <asp:Label ID="lblTotalAdvanceSum" runat="server" Text="0"></asp:Label></span>
                            </p>
                            <p style="color: grey; margin-bottom: 0px;">Advance Collection</p>
                            </asp:LinkButton>
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Statistics Widget 1-->
                </div>
            </div>
        </div>
    </div>


</asp:Content>
