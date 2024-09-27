<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="MerchandisingDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.MerchandisingDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
      <div class="row" style="margin-right: auto;">
                        <ul class="nav" style="padding-top: 10px; justify-content: flex-end;">
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
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
      <div class="col-lg-12">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div class="col-lg-12">
                        <asp:PlaceHolder   ID="advancedFilter"   visible="false"   runat="server">
                        <div   class="col-lg-12     row">
                             <div class="col-lg-3" >
                                        <label class="control-label col-lg-12">Region</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox  Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddlRegion" runat="server" EmptyMessage="Select Region" Width="100%" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                         <div class="col-lg-3" >
                                        <label class="control-label col-lg-12">Depot</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox  Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldepot" runat="server" EmptyMessage="Select Depot" Width="100%" OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                      <div class="col-lg-3" >
                                        <label class="control-label col-lg-12">Area</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox  Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldpoArea" runat="server" EmptyMessage="Select Area" Width="100%" OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                      <div class="col-lg-3" >
                                        <label class="control-label col-lg-12">Subarea</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox  Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" Width="100%" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                            </div>
                            </asp:PlaceHolder>
                        <div  class="col-lg-12      row"         style="padding-top:10px;">


                        <div class="col-lg-3" >
                            <div class="col-lg-12">
                                <label class="control-label col-lg-12">Route </label>
                            </div>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains"
                                    CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route" Width="100%">
                                </telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-3"          >
                            <label class="control-label col-lg-12">From Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" OnSelectedDateChanged="rdfromDate_SelectedDateChanged" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" AutoPostBack="true">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-3"  >
                            <label class="control-label col-lg-12">To Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                                </telerik:RadDatePicker>
                                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-3 p-0 pt-3 ps-4">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    Apply Filter
                            </asp:LinkButton>
                             <asp:LinkButton ID="btnAdvancedFilter" runat="server" CssClass="btn btn-sm btn-primary me-0" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="true" OnClick="btnAdvancedFilter_Click">
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
        <div id="kt_content_container" class="container-xxl p-0" style="margin-left: 0px; margin-right: 0px; max-width: none;">
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
                                                        <span style="font-weight: 500;">All<br />
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
                                                        <span style="font-weight: 500;">Active<br />
                                                            Routes</span>
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
                                                            Routes</span>
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

                    <%-- <div class="col-xl-3" >
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <div class="col-lg-12 row">
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="text-align: center;">
                                                <div class="col-lg-7" style="border-right: 1px solid; text-align: right;">
                                                    <span style="font-weight: 500;">Visited<br />
                                                        Customers</span>
                                                </div>
                                                <div class="col-lg-5" style="text-align: left; padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 20px; color: #03CDFD;">
                                                        <asp:Label ID="lblVisitedCustomers" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>--%>

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
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
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
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
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
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
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
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
                            </div>
                        </div>
                    </div>

                </asp:PlaceHolder>
                <asp:PlaceHolder ID="pnl1" Visible="false" runat="server">
                <div class="col-xl-6">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                        <!--begin::Head-->
                        <asp:LinkButton runat="server" ID="buttonOutofStock" OnClick="buttonOutofStock_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Out Of Stock</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalOutOfStock" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                            </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/items_oos.png" alt="OOS Items" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkOosItems" runat="server" OnClick="lnkOosItems_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalOosItems" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">OOS Items</div>
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
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/customers_oos.png" alt="OOS Customers" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkOosCustomers" runat="server" OnClick="lnkOosCustomers_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblOosCustomers" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">OOS Customers</div>
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
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#E1AF36, #D27C25); background-size: 100%;">
                        <!--begin::Head-->
                         <asp:LinkButton runat="server" ID="ButtonItemAvailability" OnClick="ButtonItemAvailability_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Item Availability</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalItemAvailability" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                             </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/items_ia.png" alt="Not Available Items" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNotAvailableItem" runat="server" OnClick="lnkNotAvailableItem_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNotAvailableItems" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Not Available Items</div>
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
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/customers_ia.png" alt="Not Available Customers" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNotAvailableCustomers" runat="server" OnClick="lnkNotAvailableCustomers_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNotAvailableCustomers" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Not Available Customers</div>
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
                    </asp:PlaceHolder>
                <div class="col-xl-12" style="margin-top:20px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8">
                        <!--begin::Body-->
                      
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                              <%--  <div class="col-3">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-dark bg-opacity-10" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/deliverycheck.png" alt="Delivery Check" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkDeliveryCheck" runat="server" OnClick="lnkDeliveryCheck_Click">
                                                <div class="fs-7 fw-bold" style="color: black;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblDeliveryCheck" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: grey;">Delivery Check</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>--%>
                                <!--end::Col-->
                                <!--begin::Col-->
                                  <asp:PlaceHolder ID="PlaceHolder1" Visible="false" runat="server">
                                <div class="col-4">
                                    <div class="d-flex align-items-center ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-dark bg-opacity-10" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/pricing.png" alt="Item Pricing" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkItemPricing" runat="server" OnClick="lnkItemPricing_Click">
                                                <div class="fs-7 fw-bold" style="color: black;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblItemPricing" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: grey;">Item Pricing</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                <!--begin::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-dark bg-opacity-10" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/competitor.png" alt="Competitor Activities" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCompetitorActivities" runat="server" OnClick="lnkCompetitorActivities_Click">
                                                <div class="fs-7 fw-bold" style="color: black;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCompetitorActivities" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: grey;">Competitor Activities</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                <!--begin::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-dark bg-opacity-10" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/inventory.png" alt="Customer Inventory" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCustomerInventory" runat="server" OnClick="lnkCustomerInventory_Click">
                                                <div class="fs-7 fw-bold" style="color: black;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCustomerInventory" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: grey;">Customer Inventory</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                </asp:PlaceHolder>
                                <!--end::Col-->
                            </div>
                        </div>
                            
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                
                                <!--begin::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-dark bg-opacity-10" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/complaints.png" alt="Complaints" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkComplaints" runat="server" OnClick="lnkComplaints_Click">
                                                <div class="fs-7 fw-bold" style="color: black;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblComplaints" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: grey;">Product Complaints</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                 <!--begin::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-dark bg-opacity-10" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/complaints.png" alt="Complaints" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="ButtonGComplaints" runat="server" OnClick="ButtonGComplaints_Click">
                                                <div class="fs-7 fw-bold" style="color: black;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblGComplaints" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: grey;">General Complaints</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                <!--begin::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-dark bg-opacity-10" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/imagecapture.png" alt="Image Capture" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkImageCapture" runat="server" OnClick="lnkImageCapture_Click">
                                                <div class="fs-7 fw-bold" style="color: black;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblImageCapture" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: grey;">Image Capture</div>
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

                <div class="col-xl-6" style="margin-top:0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#F35D82, #CC4868); background-size: 100%;">
                        <!--begin::Head-->
                         <asp:LinkButton runat="server" ID="ButtonSurvey" OnClick="ButtonSurvey_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Survey</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalSurvey" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                             </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkAssignedSurveys" runat="server" OnClick="lnkAssignedSurveys_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblAssignedSurveys" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Assigned Surveys</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCompletedSurveys" runat="server" OnClick="lnkCompletedSurveys_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCompletedSurveys" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Completed Surveys</div>
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
                 <asp:PlaceHolder ID="PlaceHolder2" Visible="false" runat="server">
                <div class="col-xl-6" style="margin-top:0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#47C581, #2DA566); background-size: 100%;">
                        <!--begin::Head-->
                         <asp:LinkButton runat="server" ID="ButtonAssetTracking" OnClick="ButtonAssetTracking_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Asset Tracking</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalAssetTracking" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                             </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkAssignedAssets" runat="server" OnClick="lnkAssignedAssets_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblAssignedAssets" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Assigned Assets</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkTrackedAssets" runat="server" OnClick="lnkTrackedAssets_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTrackedAssets" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Tracked Assets</div>
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

                <div class="col-xl-6" style="margin-top:0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#AB73C2, #814698); background-size: 100%;">
                        <!--begin::Head-->
                         <asp:LinkButton runat="server" ID="ButtonDisplayAgreement" OnClick="ButtonDisplayAgreement_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Disp Agreement</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalDispAgreement" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                             </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNewAgreements" runat="server" OnClick="lnkNewAgreements_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNewAgreements" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">New Agreements</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkActiveAgreements" runat="server" OnClick="lnkActiveAgreements_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblActiveAgreements" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Active Agreements</div>
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

                <div class="col-xl-6" style="margin-top:0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#BCBF52, #B5A11F); background-size: 100%;">
                        <!--begin::Head-->
                         <asp:LinkButton runat="server" ID="ButtonTasks" OnClick="ButtonTasks_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Tasks</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalTasks" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                             </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkAssignedTask" runat="server" OnClick="lnkAssignedTask_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblAssignedTask" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Assigned Tasks</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCompletedTasks" runat="server" OnClick="lnkCompletedTasks_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCompletedTasks" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Completed Tasks</div>
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

                  <div class="col-xl-6" style="margin-top:0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#47C581, #2DA566); background-size: 100%;">
                        <!--begin::Head-->
                         <asp:LinkButton runat="server" ID="ButtonCusAct" OnClick="ButtonCusAct_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;"> Customer Activities</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblCusActPerformed" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                             </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkOpenCusAct" runat="server" OnClick="lnkOpenCusAct_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblOpenCusAct" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Open</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCompletedCusAct" runat="server" OnClick="lnkCompletedCusAct_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCompletedCusAct" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Completed</div>
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
                     </asp:PlaceHolder>

                <div class="col-xl-6" style="margin-top:0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                        <!--begin::Head-->
                         <asp:LinkButton runat="server" ID="ButtonRequest" OnClick="ButtonRequest_Click">
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Requests</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblReqPerformed" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>
                            <!--end::Toolbar-->
                        </div>
                             </asp:LinkButton>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNewRequest" runat="server" OnClick="lnkNewRequest_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNewRequest" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">New Requests</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;">
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkRepondedRequest" runat="server" OnClick="lnkRepondedRequest_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblRepondedRequest" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Responded Requests</div>
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
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
