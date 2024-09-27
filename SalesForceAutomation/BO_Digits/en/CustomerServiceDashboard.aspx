<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerServiceDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerServiceDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    
                        <div class="col-lg-2" >
                            <div class="col-lg-12">
                                <label class="control-label col-lg-12">Route </label>
                            </div>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains"
                                    CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route" Width="100%">
                                </telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-2"          >
                            <label class="control-label col-lg-12">From Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged" >
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-2"  >
                            <label class="control-label col-lg-12">To Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" OnSelectedDateChanged="rdendDate_SelectedDateChanged" AutoPostBack="true">
                                </telerik:RadDatePicker>
                                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-2 p-0 pt-3 ps-4">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    Apply Filter
                            </asp:LinkButton>
                        </div>
                    <div class="col-lg-4">
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

            </div>
            </div>
        </div>
    </div>
    <div class="post d-flex flex-column-fluid" id="kt_post">
        <div id="kt_content_container" class="container-xxl p-0" style="margin-left: 0px; margin-right: 0px; max-width: none;">
            <div class="row g-5 g-xl-8">
                <asp:PlaceHolder ID="pnlTimeline" runat="server" Visible="true">

                    <div class="col-xl-12">
                        <div class="row">
                            <div class="col-xl-9">
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
                                                    <div class="col-lg-6" style="border-right: 1px solid; text-align: right; color:black;">
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
                                                    <div class="col-lg-7 pe-3" style="border-right: 1px solid; text-align: right; color:black; ">
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
                        
                            <div class="col-xl-3" >
                                <asp:LinkButton ID="lnkvistedCustomer" runat="server" OnClick="lnkvistedCustomer_Click">
                                <div class="card">
                                <div class="card-body" style="padding: 1rem 2rem;">
                                    <div class="py-2">
                                        <div class="col-lg-12 row">
                                            <div class="d-flex flex-stack">
                                                
                                                <div class="col-lg-12 row" style="text-align: center;">
                                                    <div class="col-lg-7" style="border-right: 1px solid; text-align: right; color: black;">
                                                        <span style="font-weight: 500;">Visited<br />
                                                            Customers</span>
                                                    </div>
                                                    <div class="col-lg-5" style="text-align: left; padding-top: 5px;">
                                                        <span style="font-weight: 600; font-size: 20px; color: black;">
                                                            <asp:Label ID="lblVisitedCustomers" runat="server"></asp:Label></span>
                                                    </div>
                                                </div>
                                               
                                            </div>
                                        </div>
                                    </div>
                                </div>
                               </div>
                             </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                     

                    <div class="col-xl-3">
                        <div class="card">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <asp:LinkButton runat="server" ID="lnkPlannedVisit" OnClick="lnkPlannedVisit_Click">
                                <div class="py-2">
                                    <div class="col-lg-12 row" style="color:black;">
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
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
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
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
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
                                    <div class="col-lg-12 row" style="color:black;">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 600; ">Actual Visits</span>
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 600;">
                                                    <asp:Label ID="lblTotalActualVisit" runat="server"></asp:Label></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
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
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
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
                                    <div class="col-lg-12 row" style="color:black;">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 600; color:black;">Productive</span>
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 600;">
                                                    <asp:Label ID="lblTotalProductiveVisit" runat="server"></asp:Label></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; color:black;">Planned</span>
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 500;">
                                                    <asp:Label ID="lblPlannedProductive" runat="server"></asp:Label></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; color:black;">Unplanned</span>
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
                                    <div class="col-lg-12 row" style="color:black;">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 600; color:black;">Non Productive</span>
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 600;">
                                                    <asp:Label ID="lblTotalNonProductiveVisit" runat="server"></asp:Label></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500;">Planned</span>
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <span style="font-weight: 500; color:black;">
                                                    <asp:Label ID="lblPlannedNonProd" runat="server"></asp:Label></span>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px; color:black;">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 500; color:black;">Unplanned</span>
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

               <div class="col-xl-6" >
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-25" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Customer Requests</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <%--<div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblReqPerformed" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
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
                </div>

                <div class="col-xl-6">
                    <div class="col-lg-12">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkgnrlComp" OnClick="lnkgnrlComp_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/complaints.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">General Complaints</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_genComp">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblgeneralComplaints" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkPrdComp" OnClick="lnkPrdComp_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/complaints.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Product Complaints</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_prdcomp">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblprdComp" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <div class="col-xl-12 row">
                        <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkCreditNote" OnClick="lnkCreditNote_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/cnr.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Credit Note Request</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_lblCustomerInventory">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblCreditNote" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white;">
                            <asp:LinkButton runat="server" ID="lnkDisputeReqNote" OnClick="lnkDisputeReqNote_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/dr.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Dispute Note Request</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_DisputeReqNote">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblDisputeReqNote" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                  </div>

                <div class="col-xl-12 row">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkReturnRequest" OnClick="lnkReturnRequest_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/srr.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Return Request</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_ReturnRequest">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblReturnRequest" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
