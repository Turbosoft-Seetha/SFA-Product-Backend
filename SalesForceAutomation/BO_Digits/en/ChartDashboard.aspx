<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ChartDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ChartDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <%--<link href="assets/style.bundle.css" rel="stylesheet" type="text/css" />--%>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <div class="row" style="margin-right: auto;">
        <ul class="nav" style="justify-content: flex-end;">
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div>


                        <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false">

                            <div class="col-lg-12 row">

                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Region</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="ddlregion" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Depot</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="ddldepots" runat="server" EmptyMessage="Select Depot" OnSelectedIndexChanged="ddldepots_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Area</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="ddldpoAreas" runat="server" EmptyMessage="Select Area" OnSelectedIndexChanged="ddldpoAreas_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Subarea</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>


                            </div>

                        </asp:PlaceHolder>

                        <div class="col-lg-12 row" style="padding-top: 10px;">
                            <div class="col-lg-3">
                                <div class="col-lg-12">
                                    <label class="control-label col-lg-12">Route </label>
                                </div>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains"
                                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route">
                                    </telerik:RadComboBox>
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" OnSelectedDateChanged="rdfromDate_SelectedDateChanged" DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true">
                                    </telerik:RadDatePicker>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                    --%>
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MM-yyyy" runat="server" AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged">
                                    </telerik:RadDatePicker>
                                    <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate"  ErrorMessage="End date must be greater"
                                        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    <%-- <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                    --%>
                                </div>
                            </div>

                            <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                </asp:LinkButton>
                            </div>
                            <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; margin-left: -17px;">
                                <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click">
                                                    Advanced Filter
                                </asp:LinkButton>
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
                <asp:PlaceHolder ID="pnlTimeline" runat="server" Visible="false">
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
                                                        <span style="font-weight: 500;">Day<br />
                                                            Started</span>
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
                                                    <asp:LinkButton ID="lnkNotStarted" runat="server" CssClass="d-flex flex-stack" OnClick="lnkNotStarted_Click">
                                                    <div class="col-lg-7 pe-3" style="border-right: 1px solid; text-align: right;">
                                                        <span style="font-weight: 500;">Not<br />
                                                            Started</span>
                                                    </div>
                                                    <div class="col-lg-5 ps-3" style="text-align: left; padding-top: 5px;">
                                                        <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                            <asp:Label ID="lblNonProductiveRoute" runat="server"></asp:Label></span>
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
                <div class="col-lg-6 mt-8">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-lg-8" style="background-color: #6397b2; background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <asp:LinkButton ID="totalInvoices" runat="server" OnClick="totalInvoices_Click">
                                    <span class="card-label fw-bold text-dark">
                                        <asp:Label ID="lblTotalInvoice" runat="server" Text="0" ForeColor="White"></asp:Label></span>
                                    <span class="text-grey-400 mt-1 fw-semibold fs-6" style="color: white;">Total Invoices</span>
                                </asp:LinkButton>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important">
                                    <span style="font-size: 15px;">
                                        <asp:Label ID="lblCurrency" runat="server"></asp:Label></span>
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalInvoiceSum" runat="server" Text="0"></asp:Label></span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column mb-8">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center mb-12 me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
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
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalInvoicesSum" CssClass="ps-2" runat="server" Text="0"></asp:Label>
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
                                    <div class="d-flex align-items-center mb-12 ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
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
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalGReturnsSum" CssClass="ps-2" runat="server" Text="0"></asp:Label>
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
                                    <div class="d-flex align-items-center me-2 mb-9">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
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
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <asp:Label ID="Label3" runat="server"></asp:Label>
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalBReturnsSum" CssClass="ps-2" runat="server" Text="0"></asp:Label>
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
                                    <div class="d-flex align-items-center ms-2 mb-9">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-90" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs045.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/foc.png" alt="Free of cost" width="34" height="34" />
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
                    <%--<div class="col-xl-12" style=" padding-top: -17px; margin-top: -15px;">
                         <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-color: #6397b2; background-image:linear-gradient(#dfa633, #f2a517); background-size: 100%; border-radius: 40px;">
                       <asp:LinkButton runat="server" ID="lnkRotdeliv" OnClick="lnkRotdeliv_Click">
                           <div class=" card-xl-stretch m-4">

                               <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                <div class="symbol symbol-50px me-5">                                       
                                </div>

                                <div class="flex-grow-1 me-6">
                                   <span class="text-white fw-semibold fs-3 d-block">Route Deliveries</span>                                          
                                </div>

                                    <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblrotDelivery">
                                    <asp:Label runat="server" ID="lbldelcount" >/</asp:Label> <asp:Label runat="server" ID="lblOrdcount" ></asp:Label> 
                                    </span></span>
                                 
                                        <div class="symbol symbol-30px me-5">
                                          <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>
                                    
    
                                   </div>
                              </div>

                              </asp:LinkButton>
                             </div>
                        </div>--%>
                </div>

                <div class="col-xl-6 row mt-8">
                    <div class="col-xl-6">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <asp:LinkButton runat="server" ID="lnkQuotations" OnClick="lnkQuotations_Click">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <img src="../assets/media/dashboard/Quotations.png" class="w-30px me-6" alt="" />
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;"></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex ">
                                                <div class="d-flex">
                                                    <span style="font-weight: 800;">
                                                        <asp:Label ID="lblQuotations" runat="server" Text="0"></asp:Label></span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-1">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Quotations</span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="Label4" runat="server"></asp:Label>
                                                        <asp:Label ID="lblQuotationSum" CssClass="ps-2" runat="server" Text="0.00"></asp:Label>
                                                    </span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <asp:LinkButton runat="server" ID="lnkSalesOrder" OnClick="lnkSalesOrder_Click">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <img src="../assets/media/dashboard/orderreq2.png" class="w-30px me-6" alt="" />
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;"></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex ">
                                                <div class="d-flex">
                                                    <span style="font-weight: 800;">
                                                        <asp:Label ID="lblTotalOrder" runat="server" Text="0.00"></asp:Label></span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-1">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Sales Order</span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="Label5" runat="server"></asp:Label>
                                                        <asp:Label ID="lblTotalOrderSum" CssClass="ps-2" runat="server" Text="0.00"></asp:Label></span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <asp:LinkButton runat="server" ID="lnkARColl" OnClick="lnkARColl_Click">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <img src="../assets/media/dashboard/ar2.png" class="w-30px me-6" alt="" />
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;"></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex ">
                                                <div class="d-flex">
                                                    <span style="font-weight: 800;">
                                                        <asp:Label ID="lblTotalAR" runat="server" Text="0"></asp:Label></span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-1">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">AR Collection</span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="Label6" runat="server"></asp:Label>
                                                        <asp:Label ID="lblTotalARSum" CssClass="ps-2" runat="server" Text="0.00"></asp:Label></span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <asp:LinkButton runat="server" ID="lnkAdvColl" OnClick="lnkAdvColl_Click">
                                        <div class="col-lg-12 row">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <img src="../assets/media/dashboard/advance2.png" class="w-30px me-6" alt="" />
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <span style="font-weight: 600;"></span>
                                                </div>
                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex ">
                                                <div class="d-flex">
                                                    <span style="font-weight: 800;">

                                                        <asp:Label ID="lblTotalAdvance" runat="server" Text="0"></asp:Label>

                                                    </span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-1">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 500;">Advance Collection</span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                        <div class="col-lg-12 row pt-2">
                                            <!--begin::Item-->
                                            <div class="d-flex flex-stack">
                                                <div class="d-flex">
                                                    <span style="font-weight: 600;">
                                                        <asp:Label ID="Label7" runat="server"></asp:Label>
                                                        <asp:Label ID="lblTotalAdvanceSum" CssClass="ps-2" runat="server" Text="0.00"></asp:Label></span>
                                                </div>

                                            </div>
                                            <!--end::Item-->
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <%-- <div class="col-xl-6" style="margin-top:15px;">
                    <div class="card" style="background-color: #c0e2f4;">
                        <asp:LinkButton ID="lnkTotalOrder" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lnkTotalOrder_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="d-flex">
                                            <img src="../assets/media/dashboard/orderreq2.png" class="w-40px me-6" alt="" />
                                            <div class="d-flex flex-column">
                                                <asp:Label ID="lblTotalOrder" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                                <div class="fs-6 fw-semibold" style="color: black">Order Request</div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                                <span style="font-size: 15px;">
                                                    <asp:Label ID="Label4" runat="server"></asp:Label></span>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalOrderSum" runat="server" Text="0"></asp:Label></span>
                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                    <div class="card" style="margin-top: 12px; background-color: #fcebff;">
                        <asp:LinkButton ID="lnkTotalAR" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server" OnClick="lnkTotalAR_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="d-flex">
                                            <img src="../assets/media/dashboard/ar2.png" class="w-40px me-6" alt="" />
                                            <div class="d-flex flex-column">
                                                <asp:Label ID="lblTotalAR" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                                <div class="fs-6 fw-semibold" style="color: black">Account Receivable Collection</div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                                <span style="font-size: 15px;">
                                                    <asp:Label ID="Label5" runat="server"></asp:Label></span>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalARSum" runat="server" Text="0"></asp:Label></span>
                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                    <div class="card" style="margin-top: 12px; background-color: #fff8dd;">
                        <asp:LinkButton ID="lnkTotalAdvance" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lnkTotalAdvance_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="d-flex">
                                            <img src="../assets/media/dashboard/advance2.png" class="w-40px me-6" alt="" />
                                            <div class="d-flex flex-column">
                                                <asp:Label ID="lblTotalAdvance" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                                <div class="fs-6 fw-semibold" style="color: black">Advance Collection</div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <p class="" style="color: black; margin-bottom: 0.5rem !important">
                                                <span style="font-size: 15px;">
                                                    <asp:Label ID="Label6" runat="server"> </asp:Label></span>
                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblTotalAdvanceSum" runat="server" Text="0"></asp:Label></span>
                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>--%>

                <%--Route delivery tag--%>
                <div class="col-lg-12 row">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #6397b2; background-image: linear-gradient(to right,#6fb091, #80c3d4); background-size: 100% 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkSaleOrdiv" OnClick="lnkSaleOrdiv_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/so.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-white fw-semibold fs-3 d-block">Sales Order Status</span>
                                        </div>

                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblSalesOrd">
                                            <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblSaleOrdcount" Text="0"></asp:Label>
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
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #6397b2; background-image: linear-gradient(to right,#b675b9, #c5bd7e); background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkRotdeliv" OnClick="lnkRotdeliv_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/rd.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-white fw-semibold fs-3 d-block">Route Deliveries</span>
                                        </div>

                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblrotDeliverys">
                                            <asp:PlaceHolder ID="pnldel" runat="server" Visible="false">
                                                <asp:Label runat="server" ID="lbldelcount"></asp:Label>
                                            </asp:PlaceHolder>
                                            <asp:Label runat="server" ID="lblOrdcount" Text="0"></asp:Label>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #6397b2; background-image: linear-gradient(to right,#b47f63, #ce8eb3); background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkOutstandingInv" OnClick="lnkOutstandingInv_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/oi.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-white fw-semibold fs-3 d-block">Outstanding Invoices</span>
                                        </div>

                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblOutstanding">

                                            <asp:Label runat="server" ID="lblOutstanding" Text="0"></asp:Label>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <asp:PlaceHolder ID="pnlInvMonit" runat="server" >
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #6397b2; background-image: linear-gradient(to right,#8075bc, #77bebf); background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkInvMonitoring" OnClick="lnkInvMonitoring_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/im.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-white fw-semibold fs-3 d-block"><asp:label ID="lblopt1" runat="server"></asp:label></span>
                                        </div>

<%--                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblMerchandising">

                                            <%--<asp:Label runat="server" ID="lblMerchandising" Text="0"></asp:Label>--%>
<%--                                        </span></span>--%>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                        </asp:PlaceHolder>
                     <asp:PlaceHolder ID="pnlActManage" runat="server">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #6397b2; background-image: linear-gradient(to right,#8075bc, #77bebf); background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkActManagement" OnClick="lnkActManagement_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/am.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-white fw-semibold fs-3 d-block"><asp:label ID="lblopt2" runat="server"></asp:label></span>
                                        </div>

<%--                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblMerchandising">

                                            <%--<asp:Label runat="server" ID="lblMerchandising" Text="0"></asp:Label>--%>
<%--                                        </span></span>--%>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                            </asp:PlaceHolder>
<asp:PlaceHolder ID="pnlcusservice" runat="server">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: #6397b2; background-image: linear-gradient(to right,#8075bc, #77bebf); background-size: 100%; border-radius: 12px;">
                            <asp:LinkButton runat="server" ID="lnkcusservice" OnClick="lnkcusservice_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/cs.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-white fw-semibold fs-3 d-block"><asp:label ID="lblopt3" runat="server"></asp:label></span>
                                        </div>

<%--                                        <span class="text-white fs-3 fw-bold py-1 me-12"><span id="MainContent_lblMerchandising">

                                            <%--<asp:Label runat="server" ID="lblMerchandising" Text="0"></asp:Label>--%>
<%--                                        </span></span>--%>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/white-arrow.png" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
     </asp:PlaceHolder>
                </div>
                <%--Route delivery tag--%>

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
                <%--<div class="col-xl-6">
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
                </div>--%>
            </div>

        </div>
    </div>

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
