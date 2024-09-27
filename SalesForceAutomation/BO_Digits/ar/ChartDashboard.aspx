<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ChartDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ChartDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <%--<link href="assets/style.bundle.css" rel="stylesheet" type="text/css" />--%>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <div class="row" style="margin-right: auto;">
        <ul class="nav" style="justify-content: flex-end;">
            <li class="nav-item">
                <asp:LinkButton ID="lnkToday" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkToday_Click">اليوم</asp:LinkButton>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="lnkMonth" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkMonth_Click">شهر</asp:LinkButton>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="lnkYear" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4" OnClick="lnkYear_Click">سنة</asp:LinkButton>
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
                    
                   
                     <asp:PlaceHolder ID="plhFilter" runat="server"  Visible="false">
                    
                    <div class="col-lg-12 row">
                     
                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">منطقة</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddlregion" runat="server" EmptyMessage="اختر المنطقة"   AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged" >
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
                        <div class="col-lg-3" >
                            <label class="control-label col-lg-12">مساحة</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddldpoAreas" runat="server" EmptyMessage="حدد المنطقة"  OnSelectedIndexChanged="ddldpoAreas_SelectedIndexChanged" AutoPostBack="true">
                                </telerik:RadComboBox>

                            </div>
                        </div>
                        <div class="col-lg-3" >
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
                            <div class="col-lg-12">
                                <label class="control-label col-lg-12">طريق </label>
                            </div>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains"
                                    CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="حدد الطريق" >
                                </telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-3" >
                            <label class="control-label col-lg-12">من تاريخ</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" OnSelectedDateChanged="rdfromDate_SelectedDateChanged" DateInput-DateFormat="dd-MM-yyyy"  AutoPostBack="true">
                                </telerik:RadDatePicker>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                --%>
                            </div>
                        </div>

                        <div class="col-lg-3" >
                            <label class="control-label col-lg-12">إلى تاريخ</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MM-yyyy" runat="server" >
                                </telerik:RadDatePicker>
                                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="يجب أن يكون تاريخ الانتهاء أكبر"
                                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                <%-- <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                --%>
                            </div>
                        </div>

                        <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto;padding-left: 0px; ">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click">
                                                   تطبيق عامل التصفية
                            </asp:LinkButton>
                        </div>
                        <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto;margin-left: -17px; ">
                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" >
                                                    تصفية متقدم
                            </asp:LinkButton>
                        </div>

                    </div>
                   
                     
                        </div>
                       
                </div>
            </div>
        </div>
    </div>



    <div class="post d-flex flex-column-fluid" id="kt_post">

        <div id="kt_content_container" class="container-xxl" style="margin-left: 0px; margin-right: 0px; max-width: none;">
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
                                                    <div class="col-lg-6" style="border-left: 1px solid; text-align: left;">
                                                        <span style="font-weight: 500;">جميع<br />
                                                            الطرق</span>
                                                    </div>
                                                    <div class="col-lg-6" style="text-align: right; padding-top: 5px;">
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
                                                    <div class="col-lg-6" style="border-left: 1px solid; text-align: left;">
                                                        <span style="font-weight: 500;">طرق<br />
                                                            نشطة</span>
                                                    </div>
                                                    <div class="col-lg-6" style="text-align: right; padding-top: 5px;">
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
                                                    <div class="col-lg-7" style="border-left: 1px solid; text-align: left;">
                                                        <span style="font-weight: 500;">طرق غير<br />
                                                            نشطة</span>
                                                    </div>
                                                    <div class="col-lg-5" style="text-align: right; padding-top: 5px;">
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
                                                            <div class="fs-6 fw-semibold" style="color: black">عرض على الخريطة</div>
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
                                <div class="py-2">
                                    <div class="col-lg-12 row">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="d-flex">
                                                <span style="font-weight: 600;">الزيارات المخططة</span>
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
                                                <span style="font-weight: 500;">تمت زيارته</span>
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
                                                <span style="font-weight: 500;">قيد الانتظار</span>
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
                                                <span style="font-weight: 600;">الزيارات الفعلية</span>
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
                                                <span style="font-weight: 500;">مخطط</span>
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
                                                <span style="font-weight: 500;">غير مخطط له</span>
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
                                                <span style="font-weight: 600;">إنتاجي</span>
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
                                                <span style="font-weight: 500;">مخطط</span>
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
                                                <span style="font-weight: 500;">غير مخطط له</span>
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
                                                <span style="font-weight: 600;">غير منتج</span>
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
                                                <span style="font-weight: 500;">مخطط</span>
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
                                                <span style="font-weight: 500;">غير مخطط له</span>
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
                <div class="col-xl-6">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-color: #6397b2; background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-5" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <asp:LinkButton ID="totalInvoices" runat="server" OnClick="totalInvoices_Click">
                                    <span class="card-label fw-bold text-dark">
                                        <asp:Label ID="lblTotalInvoice" runat="server" Text="0" ForeColor="White"></asp:Label></span>
                                    <span class="text-grey-400 mt-1 fw-semibold fs-6" style="color: white;">إجمالي الفواتير</span>
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
                                                        <asp:Label ID="lblTotalInvoicesSum" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">مبيعات</div>
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
                                                        <asp:Label ID="lblTotalGReturnsSum" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">عودة جيدة</div>
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
                                                        <asp:Label ID="lblTotalBReturnsSum" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">عودة سيئة</div>
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

                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">بدون تكلفة</div>
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
                        <asp:LinkButton ID="lnkTotalOrder" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lnkTotalOrder_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">
                                <div class="py-2">
                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="d-flex">
                                            <img src="../assets/media/dashboard/orderreq2.png" class="w-40px me-6" alt="" />
                                            <div class="d-flex flex-column">
                                                <asp:Label ID="lblTotalOrder" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                                <div class="fs-6 fw-semibold" style="color: black">طلب</div>
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
                                                <div class="fs-6 fw-semibold" style="color: black">تحصيل حسابات القبض</div>
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
                                                <div class="fs-6 fw-semibold" style="color: black">مجموعة مسبقة</div>
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
                </div>
                <div class="col-xl-6" style="margin-top: 0px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1">المبيعات الشهرية</span>
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
                <div class="col-xl-6" style="margin-top: 0px;">
                    <!--begin::Charts Widget 3-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1"><a href="TopSellingDasboardDetail.aspx">الأكثر مبيعا</a></span>
                            </h3>
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <div class="w3-row">
                                    <a href="javascript:void(0)" onclick="openSelling(event, 'Item');" id="defaultOpenSelling">
                                        <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding" style="width: 63px;">غرض</div>
                                    </a>
                                    <a href="javascript:void(0)" onclick="openSelling(event, 'Sub');">
                                        <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding" style="width: 121px;">تصنيف فرعي</div>
                                    </a>
                                    <a href="javascript:void(0)" onclick="openSelling(event, 'Category');">
                                        <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding" style="width: 91px;">فئة</div>
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
                                <span class="card-label fw-bold fs-3 mb-1"><a href="MostPerformingDetail.aspx">الأكثر أداء</a></span>
                            </h3>
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <div class="w3-row">
                                    <a href="javascript:void(1)" onclick="openPerforming(event, 'Route');" id="defaultOpenPerforming">
                                        <div class="w3-third tablinks w3-bottombar w3-hover-light-grey w3-padding" style="width: 70px;">طريق</div>
                                    </a>
                                    <a href="javascript:void(1)" onclick="openPerforming(event, 'Customer');">
                                        <div class="w3-third tablinks w3-bottombar w3-hover-light-grey w3-padding" style="width: 96px;">عميل</div>
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
                                <span class="card-label fw-bold fs-3 mb-1"><a href="FrequentlyReturnedDetail.aspx">كثيرا ما عاد</a></span>
                            </h3>
                            <!--begin::Toolbar-->
                            <div class="card-toolbar">
                                <div class="w3-row">
                                    <a href="javascript:void(1)" onclick="openReturned(event, 'Good');" id="defaultopenReturned">
                                        <div class="w3-third tablinkss w3-bottombar w3-hover-light-grey w3-padding" style="width: 80px;">حسن</div>
                                    </a>
                                    <a href="javascript:void(1)" onclick="openReturned(event, 'Bad');">
                                        <div class="w3-third tablinkss w3-bottombar w3-hover-light-grey w3-padding" style="width: 57px;">سيئ</div>
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

