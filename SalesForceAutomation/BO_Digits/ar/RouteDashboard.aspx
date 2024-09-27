﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="RouteDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.RouteDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <link href="../assets/style.bundle.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />

</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <asp:LinkButton ID="btnVanStock" runat="server" CssClass="btn btn-sm  btn-primary" CausesValidation="true" OnClick="btnVanStock_Click">
                                                    الحالية فان الأسهم
    </asp:LinkButton>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 10px">
                     <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false">
                    <div class="col-lg-12 row">
                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">منطقة</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddlregion" runat="server" EmptyMessage="اختر المنطقة"  AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                </telerik:RadComboBox>

                            </div>
                        </div>
                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">مستودع</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddldepots" runat="server" EmptyMessage="حدد المستودع"  OnSelectedIndexChanged="ddldepots_SelectedIndexChanged" AutoPostBack="true">
                                </telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">مساحة</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddldpoArea" runat="server" EmptyMessage="حدد المنطقة"  OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                </telerik:RadComboBox>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">المنطقة الفرعية</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddldpoSubArea" runat="server" EmptyMessage="حدد المنطقة الفرعية"  OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                </telerik:RadComboBox>
                            </div>
                        </div>
                    </div>
                    </asp:PlaceHolder>
                    <div class="col-lg-12 row" style="padding-top:10px;">
                        <div class="col-lg-3" >
                            <label class="control-label col-lg-12">طريق</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="حدد الطريق" Filter="Contains"  RenderMode="Lightweight" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">تاريخ</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MM-yyyy" >
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="من تاريخ إلزامي" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto;padding-left: 0px; ">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2 myLink" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    تطبيق عامل التصفية
                            </asp:LinkButton>
                        </div>
                         <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto;margin-left: -17px; ">
                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click">
                                                   تصفية متقدم
                            </asp:LinkButton>
                        </div>


                    </div>




                </div>


            </div>

        </div>
    </div>


    <div class="post d-flex flex-column-fluid" id="kt_post">

        <div id="kt_content_container" class="container-xxl" style="margin-left: 0px; margin-right: 0px; max-width: none;">
            <div class="row g-5 g-xl-8" style="margin-top: 0px;">
                <div class="col-xl-6 row">
                    <div class="col-xl-6" style="margin-top: 0px;">
                        <asp:LinkButton ID="PlannedVisits" runat="server" OnClick="PlannedVisits_Click" CausesValidation="true">
                            <!--begin::Charts Widget 3-->
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5">
                                    <h6 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">الزيارات المخططة</span>
                                    </h6>
                                    <div class="card-toolbar">
                                        <h6 class="card-title align-items-start flex-column">
                                            <span class="card-label fw-bold fs-3 mb-1">
                                                <asp:Label ID="lblPlannedVisit" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                        </h6>
                                    </div>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="card-body" style="min-height: 259px;">
                                    <div class="chartBox">
                                        <!--begin::Chart-->
                                        <canvas id="CusTotalVisits"></canvas>
                                        <!--end::Chart-->
                                    </div>
                                </div>
                                <!--end::Body-->

                            </div>
                        </asp:LinkButton>
                        <!--end::Charts Widget 3-->
                    </div>
                    <div class="col-xl-6" style="margin-top: 0px;">
                        <asp:LinkButton ID="ActualVisits" runat="server" OnClick="ActualVisits_Click" CausesValidation="true">
                            <!--begin::Charts Widget 3-->
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">الزيارات الفعلية</span>
                                    </h3>
                                    <div class="card-toolbar">
                                        <h6 class="card-title align-items-start flex-column">
                                            <span class="card-label fw-bold fs-3 mb-1">
                                                <asp:Label ID="lblActualVisit" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                        </h6>
                                    </div>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="card-body" style="min-height: 259px;">
                                    <div class="chartBox">
                                        <!--begin::Chart-->
                                        <canvas id="CusTotalSchedule"></canvas>
                                        <!--end::Chart-->
                                    </div>
                                </div>
                                <!--end::Body-->

                            </div>
                        </asp:LinkButton>
                        <!--end::Charts Widget 3-->
                    </div>
                </div>
                <div class="col-xl-6" style="margin-top: 0px;">
                    <div class="col-xl-12">
                        <asp:LinkButton ID="Productivevisits" runat="server" OnClick="Productivevisits_Click" CausesValidation="true">
                            <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-color: #6397b2; background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                                <div class="col-xl-12 row" style="padding-top: 30px;">
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600; font-family: 'Segoe UI';">إنتاجي
                                        <br />
                                            الزيارات</h6>
                                    </div>
                                    <div class="col-xl-6 row">
                                        <div class="col-xl-3"></div>
                                        <div class="col-xl-2">
                                            <h5 style="color: white; font-weight: 600;">
                                                <asp:Label ID="lblTotalProductive" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h5>
                                        </div>
                                        <div class="col-xl-2">
                                            <h5 style="color: white; font-weight: 600;">-</h5>
                                        </div>
                                        <div class="col-xl-2">
                                            <h5 style="color: white; font-weight: 600;">
                                                <asp:Label ID="lblTotalNonProductive" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h5>
                                        </div>
                                        <div class="col-xl-3"></div>
                                    </div>
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600; font-family: 'Segoe UI';">غير منتج
                                        <br />
                                           الزيارات</h6>
                                    </div>
                                </div>
                                <div class="col-xl-12 row" style="padding-top: 10px; padding-bottom: 10px;">
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblProductivePlanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="btn btn-warning" style="width: 100%; font-family: 'Segoe UI';">مخطط</div>
                                    </div>
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblNonProductivePlanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                </div>
                                <div class="col-xl-12 row" style="padding-top: 10px; padding-bottom: 30px;">
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblProductiveUnplanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="btn btn-primary" style="width: 100%; font-family: 'Segoe UI';">غير مخطط له</div>
                                    </div>
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblNonProductiveUnplanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>

                    <div class="col-xl-12">
                        <asp:LinkButton ID="TotalOrder" runat="server" OnClick="TotalOrder_Click" CausesValidation="true">
                            <div class="d-flex align-items-center rounded p-4 mb-7" style="background-color: #b534b5;">
                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                <span class="svg-icon svg-icon-1 me-5">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path opacity="0.3" d="M21.25 18.525L13.05 21.825C12.35 22.125 11.65 22.125 10.95 21.825L2.75 18.525C1.75 18.125 1.75 16.725 2.75 16.325L4.04999 15.825L10.25 18.325C10.85 18.525 11.45 18.625 12.05 18.625C12.65 18.625 13.25 18.525 13.85 18.325L20.05 15.825L21.35 16.325C22.35 16.725 22.35 18.125 21.25 18.525ZM13.05 16.425L21.25 13.125C22.25 12.725 22.25 11.325 21.25 10.925L13.05 7.62502C12.35 7.32502 11.65 7.32502 10.95 7.62502L2.75 10.925C1.75 11.325 1.75 12.725 2.75 13.125L10.95 16.425C11.65 16.725 12.45 16.725 13.05 16.425Z" fill="currentColor" />
                                        <path d="M11.05 11.025L2.84998 7.725C1.84998 7.325 1.84998 5.925 2.84998 5.525L11.05 2.225C11.75 1.925 12.45 1.925 13.15 2.225L21.35 5.525C22.35 5.925 22.35 7.325 21.35 7.725L13.05 11.025C12.45 11.325 11.65 11.325 11.05 11.025Z" fill="currentColor" />
                                    </svg>
                                </span>
                                <!--end::Svg Icon-->
                                <!--begin::Title-->
                                <div class="flex-grow-1 me-2">

                                    <h6 href="#" class="fw-bold text-white-800 text-hover-primary fs-6" style="color: white; font-family: 'Segoe UI';">إجمالي الطلبات</h6>
                                </div>
                                <!--end::Title-->
                                <!--begin::Lable-->
                                <h6 class="fw-bold py-1" style="color: white">
                                    <asp:Label ID="lblTotOrdCount" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                <!--end::Lable-->
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <div class="col-xl-12 row">
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <div class="card card-xl-stretch mb-5 mb-xl-8">
                            <!--begin::Header-->
                            <div class="card-header border-0 pt-5">
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">
                                        <asp:LinkButton ID="lnkTarget" runat="server" OnClick="lnkTarget_Click" CausesValidation="true" Style="font-family: 'Segoe UI';">
                                                   استهداف
                                        </asp:LinkButton></span>
                                </h3>



                                <div class="card-toolbar">

                                    <div class="w3-row">
                                        <a href="javascript:void(1)" onclick="openPerforming(event, 'Route');" id="defaultOpenPerforming">
                                            <div class="w3-third tablinks w3-bottombar w3-hover-light-grey w3-padding" style="width: 65px; font-family: 'Segoe UI';">يوميًا</div>
                                        </a>
                                        <a href="javascript:void(1)" onclick="openPerforming(event, 'Customer');">
                                            <div class="w3-third tablinks w3-bottombar w3-hover-light-grey w3-padding" style="width: 84px; font-family: 'Segoe UI';">شهريا</div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!--end::Header-->
                            <!--begin::Body-->
                            <div class="card-body">
                                <div class="chartBox">
                                    <!--begin::Chart-->
                                    <div id="Route" class="w3-container shop" style="display: none">
                                        <canvas id="TargetAcheivedDaily"></canvas>
                                    </div>
                                    <div id="Customer" class="w3-container shop" style="display: none">
                                        <canvas id="TargetAcheivedMonthly"></canvas>
                                    </div>
                                    <!--end::Chart-->
                                </div>
                            </div>
                            <!--end::Body-->

                        </div>
                        <!--end::Charts Widget 3-->
                    </div>
                    <div class="col-xl-6 row">
                        <div class="col-xl-12">
                            <!--begin::List Widget 6-->
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0" style="min-height: 45px !important">
                                    <h3 class="card-label fw-bold fs-3 mb-1 ">
                                        <asp:LinkButton ID="inkAR" runat="server" Style="font-family: 'Segoe UI';" OnClick="inkAR_Click" CausesValidation="true">تحصيل حسابات القبض</asp:LinkButton></h3>
                                    <div class="card-toolbar">
                                        <h3 class="card-label fw-bold fs-3 mb-1">
                                            <asp:Label ID="lblTotalArAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h3>
                                    </div>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="col-lg-12 row" style="padding-left: 5%">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3  col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success">
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="24" width="24" />
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div>
                                        </div>
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold ">
                                                <asp:Label ID="lblArHcCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblArHcAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">مال صعب</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3 col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold">
                                                <asp:Label ID="lblArPosCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblArPosAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">نقاط البيع</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3  col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold">
                                                <asp:Label ID="lblArOpCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblArOpAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">الدفع الالكتروني</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3 col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/cheque@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold">
                                                <asp:Label ID="lblArChequeCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblArChequeAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">التحقق من</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>

                                </div>
                                <!--end::Body-->
                            </div>
                            <!--end::List Widget 6-->
                        </div>
                        <div class="col-xl-12">
                            <!--begin::List Widget 6-->
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0" style="min-height: 45px !important">
                                    <h3 class="card-label fw-bold fs-3 mb-1">
                                        <asp:LinkButton ID="LinkAP" runat="server" Style="font-family: 'Segoe UI';" OnClick="LinkAP_Click" CausesValidation="true">مجموعة مسبقة</asp:LinkButton></h3>
                                    <div class="card-toolbar">
                                        <h3 class="card-label fw-bold fs-3 mb-1">
                                            <asp:Label ID="lblTotalAdvAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h3>
                                    </div>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="col-lg-12 row" style="padding-left: 5%">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3  col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success">
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="24" width="24" />
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold ">
                                                <asp:Label ID="lblAdvHcCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblAdvHcAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">مال صعب</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3 col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold ">
                                                <asp:Label ID="lblAdvPosCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblAdvPosAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">نقاط البيع</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3  col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold ">
                                                <asp:Label ID="lblAdvOpCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblAdvOpAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">الدفع الالكتروني</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-3 col-lg-6" style="border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/cheque@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="fw-bold ">
                                                <asp:Label ID="lblAdvChequeCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblAdvChequeAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">التحقق من</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>

                                </div>
                                <!--end::Body-->
                            </div>
                            <!--end::List Widget 6-->
                        </div>
                    </div>
                </div>


                <div class="col-xl-12">

                    <!--begin::Charts Widget 3-->

                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <div class="col-xl-12 row">
                            <div class="col-xl-6">
                                <asp:LinkButton ID="salessummary" runat="server" OnClick="salessummary_Click">
                         
                                   <div class="card-header border-0 pt-5">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family:'Segoe UI';"></span>ملخص المبيعات
                                    </h3>
                                </div>
                                      
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="card-body">
                                    <div class="chartBox">
                                        <!--begin::Chart-->
                                        <canvas id="salesReport"></canvas>
                                        <!--end::Chart-->
                                    </div>
                                </div>
                                <!--end::Body-->
                                </asp:LinkButton>
                            </div>
                            <!--begin::Header-->

                            <div class="col-xl-6 row">


                                <div class="col-xl-12">
                                    <!--begin::List Widget 6-->
                                    <div class="card card-xl-stretch mb-5 mb-xl-8 mt-5">
                                        <!--begin::Header-->
                                        <div class="card-header border-0" style="min-height: 45px !important">
                                            <h3 class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">
                                                <asp:LinkButton ID="LinkInv" runat="server" OnClick="salessummary_Click"> الفواتير</asp:LinkButton></h3>
                                            <div class="card-toolbar">
                                                <h3 class="card-label fw-bold fs-3 mb-1">
                                                    <asp:Label ID="lblTotalInvoices" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h3>
                                            </div>
                                        </div>
                                        <!--end::Header-->
                                        <!--begin::Body-->
                                        <div class="col-lg-12 row" style="padding-left: 5%">
                                            <!--begin::Item-->
                                            <div class="d-flex align-items-center border-1 rounded p-3 mb-3  col-lg-5">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-warning svg-icon-1 me-5">
                                                    <img src="../assets/media/dashboard/KPI/Pills/sales.png" height="20" style="width: 41px;" />
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <a href="#" class="fw-bold text-dark-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">مبيعات</a>

                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <span class="fw-bold py-1">
                                                    <asp:Label ID="lblSales" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                                <!--end::Lable-->
                                            </div>
                                            <!--end::Item-->
                                            <!--begin::Item-->
                                            <div class="col-lg-1"></div>

                                            <div class="d-flex align-items-center border-1 rounded p-3 mb-3 col-lg-5">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-success svg-icon-1 me-5">
                                                    <img src="../assets/media/dashboard/KPI/Pills/Rectangle -1.png" height="20" />
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <a href="#" class="fw-bold text-dark-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">عودة جيدة</a>
                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <span class="fw-bold py-1">
                                                    <asp:Label ID="lblGoodReturn" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                                <!--end::Lable-->
                                            </div>

                                            <div class="d-flex align-items-center border-1 rounded p-3 mb-3  col-lg-5">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-warning svg-icon-1 me-5">
                                                    <img src="../assets/media/dashboard/KPI/Pills/li_completed.png" height="20" />
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">عودة سيئة</a>

                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <span class="fw-bold py-1">
                                                    <asp:Label ID="lblBadReturn" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                                <!--end::Lable-->
                                            </div>
                                            <!--end::Item-->
                                            <!--begin::Item-->
                                            <div class="col-lg-1"></div>

                                            <div class="d-flex align-items-center border-1 rounded p-3 mb-3 col-lg-5">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-success svg-icon-1 me-5">
                                                    <img src="../assets/media/dashboard/KPI/Pills/Rectangle 517.png" height="20" />
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">بدون تكلفة</a>
                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <span class="fw-bold py-1">
                                                    <asp:Label ID="lblFoc" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                                <!--end::Lable-->
                                            </div>

                                        </div>
                                        <!--end::Body-->
                                    </div>
                                    <!--end::List Widget 6-->
                                </div>
                                <div class="col-xl-12">
                                    <!--begin::List Widget 6-->
                                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                                        <!--begin::Header-->
                                        <div class="card-header border-0" style="min-height: 45px !important">
                                            <h3 class="card-title fw-bold text-dark" style="font-family: 'Segoe UI';">
                                                <asp:LinkButton ID="LinkInvAmount" Style="font-family: 'Segoe UI';" runat="server" OnClick="salessummary_Click">المبلغ الإجمالي للفاتورة</asp:LinkButton></h3>
                                            <div class="card-toolbar">
                                                <h3 class="card-title fw-bold text-dark mr-5" style="font-family: 'Segoe UI';">
                                                    <asp:Label ID="lblTotalInvAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h3>
                                            </div>
                                        </div>
                                        <!--end::Header-->
                                        <!--begin::Body-->
                                        <div class="col-lg-12 row" style="padding-left: 5%">
                                            <!--begin::Item-->
                                            <div class="d-flex align-items-center border-1 rounded p-2 mb-3  col-lg-6" style="border-width: 2px !important;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <div class="symbol symbol-50px me-5">
                                                    <span class="symbol-label bg-light-success">
                                                        <img src="../assets/media/dashboard/KPI/hc@2x.png" height="24" width="24" />
                                                    </span>
                                                </div>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <span class="fw-bold ">
                                                        <asp:Label ID="lblInvHcCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblInvHcAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">مال صعب</span>
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <!--end::Lable-->
                                            </div>
                                            <!--end::Item-->
                                            <!--begin::Item-->

                                            <div class="d-flex align-items-center border-1 rounded p-2 mb-3 col-lg-6" style="border-width: 2px !important;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <div class="symbol symbol-50px me-5">
                                                    <span class="symbol-label bg-light-primary">
                                                        <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                        <img src="../assets/media/dashboard/KPI/pos@2x.png" height="24" width="24" />
                                                        <!--end::Svg Icon-->
                                                    </span>
                                                </div>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <span class="fw-bold ">
                                                        <asp:Label ID="lblInvPosCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblInvPosAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">نقاط البيع</span>
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <!--end::Lable-->
                                            </div>

                                            <div class="d-flex align-items-center border-1 rounded p-2 mb-3  col-lg-6" style="border-width: 2px !important;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <div class="symbol symbol-50px me-5">
                                                    <span class="symbol-label bg-light-warning">
                                                        <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                        <img src="../assets/media/dashboard/KPI/op@2x.png" height="24" width="24" />
                                                        <!--end::Svg Icon-->
                                                    </span>
                                                </div>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <span class="fw-bold ">
                                                        <asp:Label ID="lblInvOpCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblInvOpAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">الدفع الالكتروني</span>
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <!--end::Lable-->
                                            </div>
                                            <!--end::Item-->
                                            <!--begin::Item-->

                                            <div class="d-flex align-items-center border-1 rounded p-2 mb-3 col-lg-6" style="border-width: 2px !important;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <div class="symbol symbol-50px me-5">
                                                    <span class="symbol-label bg-light-primary">
                                                        <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                        <img src="../assets/media/dashboard/KPI/credit@2x.png" height="24" width="24" />
                                                        <!--end::Svg Icon-->
                                                    </span>
                                                </div>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <span class="fw-bold ">
                                                        <asp:Label ID="lblInvCreditCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblInvCreditAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">ائتمان</span>
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <!--end::Lable-->
                                            </div>

                                        </div>
                                        <!--end::Body-->
                                    </div>
                                    <!--end::List Widget 6-->
                                </div>


                            </div>

                        </div>

                    </div>

                    <!--end::Charts Widget 3-->
                </div>

                <!--Begin:Load-->
                <div class="col-xl-12 row">

                    <!--Begin:Load In Chart-->
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <asp:LinkButton ID="LoadIn" runat="server" OnClick="LoadIn_Click">
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5">

                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">تحميل في</span>
                                    </h3>
                                    <div class="card-toolbar">
                                        <h6 class="card-title align-items-start flex-column">
                                            <span class="card-label fw-bold fs-3 mb-1">
                                                <asp:Label ID="lblLoadIn" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                        </h6>
                                    </div>


                                </div>
                                <!--end::Header-->
                                <div class="col-xl-12 row">
                                    <div class="col-xl-6">
                                        <!--begin::Body-->
                                        <div class="card-body">
                                            <div class="chartBox">
                                                <!--begin::Chart-->
                                                <canvas id="LoadRprts"></canvas>
                                                <!--end::Chart-->
                                            </div>
                                        </div>
                                        <!--end::Body-->
                                    </div>
                                    <div class="col-xl-6" style="padding-top: 4rem;">

                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-3">
                                                <img src="../assets/media/dashboard/KPI/Pills/Rectangle -1.png" height="20" />
                                            </div>
                                            <div class="col-lg-6">

                                                <small style="font-family: 'Segoe UI';">اكتمل التحميل</small>
                                            </div>
                                            <div class="col-lg-3">
                                                <asp:Label ID="lblLICompleted" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-3">
                                                <img src="../assets/media/dashboard/KPI/Pills/Rectangle 517.png" height="20" />
                                            </div>
                                            <div class="col-lg-6">

                                                <small style="font-family: 'Segoe UI';">تحميل في انتظار الموافقة</small>
                                            </div>
                                            <div class="col-lg-3">
                                                <asp:Label ID="lblLIPending" Style="font-family: 'Segoe UI';" runat="server" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-3">
                                                <img src="../assets/media/dashboard/KPI/Pills/notprocessed.png" height="20" />
                                            </div>
                                            <div class="col-lg-6">

                                                <small style="font-family: 'Segoe UI';">تحميل في غير معالج</small>
                                            </div>
                                            <div class="col-lg-3">
                                                <asp:Label ID="lblLINotProcss" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-3">
                                                <img src="../assets/media/dashboard/KPI/Pills/li_completed.png" height="20" />
                                            </div>
                                            <div class="col-lg-6">

                                                <small style="font-family: 'Segoe UI';">تحميل مرفوض</small>
                                            </div>
                                            <div class="col-lg-3">
                                                <asp:Label ID="lblLIRejected" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                            </div>
                        </asp:LinkButton>
                        <!--end::Charts Widget 3-->
                    </div>
                    <!--End:Load In Chart-->

                    <div class="col-xl-6">
                        <div class="col-xl-12 row" style="margin-top: 0px;">
                            <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="padding-left: 30px;">
                                <asp:LinkButton runat="server" ID="lnkLT" Style="font-family: 'Segoe UI';" OnClick="lnkLT_Click" CausesValidation="true"> نقل الحمولة </asp:LinkButton></h3>
                            <div class="card col-xl-5" style="border-width: 3px; margin-left: 30px;">
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5">
                                            <img src="../assets/media/dashboard/KPI/gs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">مخزون جيد</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lblLTGoodStock" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                            <div class="card col-xl-5" style="border-width: 3px; margin-left: 23px;">
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5">
                                            <img src="../assets/media/dashboard/KPI/bs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">مخزون سيء</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lblLTBadStock" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-12 row" style="margin-top: 0px;">
                            <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="padding-left: 30px;">
                                <asp:LinkButton runat="server" ID="LinkLO" OnClick="lnkLT_Click" CausesValidation="true">تحميل</asp:LinkButton></h3>
                            <div class="card col-xl-5" style="border-width: 3px; margin-left: 30px;">
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5">
                                            <img src="../assets/media/dashboard/KPI/gs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">مخزون جيد</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="svg-icon svg-icon-1">
                                            <asp:PlaceHolder ID="pnlGDgreen" runat="server" Visible="false">
                                                <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="24" width="24" />
                                            </asp:PlaceHolder>
                                            <asp:PlaceHolder ID="pnlGDred" runat="server" Visible="false">
                                                <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="24" width="24" />
                                            </asp:PlaceHolder>
                                        </span>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                                <div class="card card-xl-stretch">
                                    <div class="col-xl-12 row">
                                        <div class="col-xl-5">
                                            <div class="d-flex align-items-center rounded p-2">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-1 me-3">
                                                    <asp:PlaceHolder ID="pnlGDEndGreen" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="pnlGDEndRed" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">نهاية المخزون</h6>
                                                </div>
                                                <!--end::Title-->

                                            </div>
                                        </div>
                                        <div class="col-xl-4">
                                            <div class="d-flex align-items-center rounded p-2">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-1 me-3">
                                                    <asp:PlaceHolder ID="pnlGDOffGreen" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="pnlGDOffRed" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">تفريغ</h6>
                                                </div>
                                                <!--end::Title-->

                                            </div>
                                        </div>
                                        <div class="col-xl-3">
                                            <div class="d-flex align-items-center rounded p-2">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-1 me-3">
                                                    <asp:PlaceHolder ID="pnlGDAdjGreen" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="pnlGDAdjRed" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">تعديل</h6>
                                                </div>
                                                <!--end::Title-->

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="card col-xl-5" style="border-width: 3px; margin-left: 23px;">
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5">
                                            <img src="../assets/media/dashboard/KPI/bs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">مخزون سيء</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="svg-icon svg-icon-1">
                                            <asp:PlaceHolder ID="pnlBDgreen" runat="server" Visible="false">
                                                <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="24" width="24" />
                                            </asp:PlaceHolder>
                                            <asp:PlaceHolder ID="pnlBDred" runat="server" Visible="false">
                                                <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="24" width="24" />
                                            </asp:PlaceHolder>
                                        </span>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                                <div class="card card-xl-stretch">
                                    <div class="col-xl-12 row">
                                        <div class="col-xl-6">
                                            <div class="d-flex align-items-center rounded p-2">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-1 me-3">
                                                    <asp:PlaceHolder ID="pnlBDOffGreen" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="pnlBDOffRed" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">تفريغ</h6>
                                                </div>
                                                <!--end::Title-->

                                            </div>
                                        </div>
                                        <div class="col-xl-6">
                                            <div class="d-flex align-items-center rounded p-2">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-1 me-3">
                                                    <asp:PlaceHolder ID="pnlBDAdjGreen" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="pnlBDAdjRed" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">تعديل</h6>
                                                </div>
                                                <!--end::Title-->

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End:Load-->

                <!--Begin:TimeLine-->
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <div class="col-lg-12 row">

                                    <div class="col-lg-3">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="border-left: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">تبدأ اليوم</span>
                                                </div>
                                                <div class="col-lg-12" style="padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 15px; font-family: 'Segoe UI';">
                                                        <asp:Label ID="lblStartTime" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-2">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="border-left: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">تحميل</span>
                                                </div>
                                                <div class="col-lg-12" style="padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 15px; font-family: 'Segoe UI';">
                                                        <asp:Label ID="lblLoadout" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-2">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="border-left: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">عملية التطبيق</span>
                                                </div>
                                                <div class="col-lg-12" style="padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 15px; font-family: 'Segoe UI';">
                                                        <asp:Label ID="lblAppProcess" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-2">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="border-left: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">مستعمرة</span>
                                                </div>
                                                <div class="col-lg-12" style="padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 15px; font-family: 'Segoe UI';">
                                                        <asp:Label ID="lblSettlement" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>


                                    <div class="col-lg-3">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">يوم الانتهاء</span>
                                                </div>
                                                <div class="col-lg-12" style="padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 15px; font-family: 'Segoe UI';">
                                                        <asp:Label ID="lblEndDay" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>




                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <div class="col-lg-12 row">



                                    <div class="col-lg-4">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="border-left: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">تنفق مع العملاء</span>
                                                </div>
                                                <div class="col-lg-12" style="padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 15px; font-family: 'Segoe UI';">
                                                        <asp:Label ID="lblSpendWithCus" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-4">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="border-left: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">إجمالي المدة الزمنية</span>
                                                </div>
                                                <div class="col-lg-12" style="padding-top: 5px;">
                                                    <span style="font-weight: 600; font-size: 15px; font-family: 'Segoe UI';">
                                                        <asp:Label ID="lblHours" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end::Item-->
                                    </div>
                                    <div class="col-lg-4">
                                        <!--begin::Item-->
                                        <asp:LinkButton ID="lnkTimeline" runat="server" CssClass="d-flex flex-stack" OnClick="lnkTimeline_Click">
                                            <div class="col-lg-12" style="text-align: right;">
                                                <div class="d-flex justify-content-end">
                                                    <div class="d-flex">
                                                        <img src="../assets/media/dashboard/timeline.png" class="w-40px me-6" alt="" />
                                                        <div class="d-flex flex-column" style="padding-top: 8px;">
                                                            <div class="fs-6 fw-semibold" style="color: black; font-family :'Segoe UI';">عرض الجدول الزمني</div>
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
                <!--End:TimeLine-->

                <!--Begin:Settlement-->
                <div class="col-xl-12 row" style="margin-top: 30px;">
                    <h1 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="font-family: 'Segoe UI';">تفاصيل التسوية</h1>
                    <div class="col-xl-8 row">
                        <div class="col-xl-4">
                            <!--begin::List Widget 1-->
                            <div class="card card-xl-stretch mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5" style="border-bottom: 1px solid;">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="text-muted mt-1 fw-semibold fs-7" style="font-family: 'Segoe UI';">مجموع المبالغ النقدية</span>
                                        <span class="card-label fw-bold text-dark" style="font-family: 'Segoe UI';">
                                            <asp:Label ID="lblCashTotal" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                    </h3>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="card-body pt-5">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success">
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="34" width="34" />
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="text-muted fw-bold" style="font-family: 'Segoe UI';">مال صعب</a>
                                            <span class="text-dark text-hover-primary fs-6 fw-bold">
                                                <asp:Label ID="lblHardCash" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="text-muted fw-bold" style="font-family: 'Segoe UI';">الدفع الالكتروني</a>
                                            <span class="text-dark text-hover-primary fs-6 fw-bold">
                                                <asp:Label ID="lblOnlinePayment" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="text-muted fw-bold" style="font-family: 'Segoe UI';">نقاط البيع</a>
                                            <span class="text-dark text-hover-primary fs-6 fw-bold">
                                                <asp:Label ID="lblPOS" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                </div>
                                <!--end::Body-->
                            </div>
                            <!--end::List Widget 1-->
                        </div>
                        <div class="col-xl-4">
                            <!--begin::List Widget 1-->
                            <div class="card card-xl-stretch mb-xl-8" style="background-image: url('../assets/media/route/top-green.png')">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5" style="border-bottom: 1px solid;">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="mt-1 fw-semibold fs-7" style="color: white; font-family: 'Segoe UI';">الإجمالي المحصل</span>
                                        <span class="card-label fw-bold " style="color: white;">
                                            <asp:Label ID="lblCollectedTotal" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                    </h3>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="card-body pt-5">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">مال صعب</a>
                                            <span class=" text-hover-primary fs-6 fw-bold" style="color: white;">
                                                <asp:Label ID="lblCollectedHard" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">الدفع الالكتروني</a>
                                            <span class=" text-hover-primary fs-6 fw-bold" style="color: white; font-family: 'Segoe UI';">
                                                <asp:Label ID="lblCollectedOnline" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">نقاط البيع</a>
                                            <span class=" text-hover-primary fs-6 fw-bold" style="color: white;">
                                                <asp:Label ID="lblCollectedPos" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                </div>
                                <!--end::Body-->
                            </div>
                            <!--end::List Widget 1-->
                        </div>
                        <div class="col-xl-4">
                            <!--begin::List Widget 1-->
                            <div class="card card-xl-stretch mb-xl-8" style="background-color: #F1416C; background-image: url(../assets/media/dashboard/top-red.png)">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5" style="border-bottom: 1px solid;">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="mt-1 fw-semibold fs-7" style="color: white; font-family: 'Segoe UI';">إجمالي التباين</span>
                                        <span class="card-label fw-bold" style="color: white;">
                                            <asp:Label ID="lblTotalVariance" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                    </h3>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="card-body pt-5">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">مال صعب</a>
                                            <span class="text-hover-primary fs-6 fw-bold" style="color: white;">
                                                <asp:Label ID="lblVarianceHard" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">الدفع الالكتروني</a>
                                            <span class="text-hover-primary fs-6 fw-bold" style="color: white;">
                                                <asp:Label ID="lblVarainceOnline" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-7">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="34" width="34" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Text-->
                                        <div class="d-flex flex-column">
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">نقاط البيع</a>
                                            <span class="text-hover-primary fs-6 fw-bold" style="color: white;">
                                                <asp:Label ID="lblVariancePos" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Text-->
                                    </div>
                                    <!--end::Item-->
                                </div>
                                <!--end::Body-->
                            </div>
                            <!--end::List Widget 1-->
                        </div>
                    </div>
                    <div class="col-xl-4">
                        <div style="border-style: groove; border-radius: 20px; border-width: 2px;">
                            <div class="col-lg-12" style="border-bottom-style: groove; display: flex; padding: 15px; border-width: 2px;">
                                <div class="col-lg-5">
                                    <small style="font-weight: bold; font-family: 'Segoe UI';">إجمالي الشيك</small>
                                </div>

                                <div class="col-lg-7 text-right">
                                    <asp:Label ID="lblTotalCheque" Style="font-family: 'Segoe UI';" runat="server" ForeColor="Black" Font-Bold="true"></asp:Label>
                                </div>
                            </div>

                            <div class="card card-flush h-xl-100" style="border-radius: 20px;">
                                <div class="card-body">
                                    <div class="hover-scroll-overlay-y pe-6 me-n6" style="height: 17rem">
                                        <asp:Repeater runat="server" ID="rptCheque">
                                            <ItemTemplate>
                                                <div class="rounded border-gray-300 border-1 border-gray-300 border-dashed px-7 py-3 mb-6">
                                                    <div class="d-flex flex-stack mb-3">
                                                        <span class="text-black-400">
                                                            <asp:Label ID="lblChqNo" Style="font-family: 'Segoe UI';" Text='<%# Eval("ChequeNo") %>' runat="server"></asp:Label></span>
                                                        <span class="badge text-gray-400 fw-bolder">
                                                            <asp:Label ID="lblBnkName" Style="font-family: 'Segoe UI';" Text='<%# Eval("BankArabicName") %>' runat="server"></asp:Label></span>
                                                    </div>
                                                    <div class="d-flex flex-stack">
                                                        <span class="text-black-400">
                                                            <asp:Label ID="lblDate" Style="font-family: 'Segoe UI';" Text='<%# Eval("ChequeDate") %>' runat="server"></asp:Label></span>

                                                        <span class="badge badge-light-success">
                                                            <asp:Label ID="lblType" Style="font-family: 'Segoe UI';" Text='<%# Eval("TypeArabic") %>' runat="server"></asp:Label>
                                                            -
                                                            <asp:Label ID="lblAmount" Style="font-family: 'Segoe UI';" Text='<%# Eval("Amount") %>' runat="server"></asp:Label></span>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End:Settlement-->

            </div>
        </div>
    </div>


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
        // Get the element with id="defaultOpen" and click on it
        document.getElementById("defaultOpenPerforming").click();
    </script>
   </asp:Content>
