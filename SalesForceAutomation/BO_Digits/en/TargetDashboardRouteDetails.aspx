<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="TargetDashboardRouteDetails.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.TargetDashboardRouteDetails" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Question() {
            $('#kt_modal_1_8').modal('show');
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript" src="../assets/Chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <div class="col-lg-12 row">
        <div class="col-lg-6">
            <label class="control-label col-lg-12">Month</label>
            <div class="col-lg-12">
                <telerik:RadMonthYearPicker RenderMode="Lightweight" ID="rdMonth" runat="server" DateInput-DateFormat="MMM-yyyy" Width="100%">
                </telerik:RadMonthYearPicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Month is mandatory" ForeColor="Red" ControlToValidate="rdMonth"></asp:RequiredFieldValidator>
            </div>
        </div>


        <div class="col-lg-6" style="text-align: end; padding-top: 10px;">
            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm  btn-primary" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    Apply Filter
            </asp:LinkButton>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="lnkViewProducts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ltTable" />


                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />



                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="grvRpt">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lnkLink" />
                     <telerik:AjaxUpdatedControl ControlID="ltTable" />

                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="col-lg-12 row">
                <h3 class="kt-portlet__head-title">
                    <telerik:RadLabel ID="lblPageHeading" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                </h3>
            </div>
            <!--Begin:Load-->
            <div class="col-xl-12 row">
                <div class="col-xl-2 card mb-5 mb-xl-8" >
    <!-- Tile 1 - Total Working Days! -->
    <div class="card card-xxl-stretch mb-5 " style="background-color: #f5f5f5; height: 90px; ">
        <!-- Title -->
        <div class="flex-grow-1 me-2" style="text-align: center;">
            <h4 class="d-flex flex-column" style="font-family: 'Segoe UI'; padding-top: 20px;">Total Working Days</h4>
        </div>
        <!-- Label -->
        <div style="text-align: center; padding-bottom: 20px;">
            <h5 class="fw-bold py-1" style="font-size: 20px;">
                <asp:Label ID="lbltotwrkdays" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>
            </h5>
        </div>
    </div>

    <!-- Tile 2 - Completed Working Days -->
    <div class="card card-xxl-stretch mb-5 " style="background-color: #f5f5f5; height: 105px; ">
        <!-- Title -->
        <div class="flex-grow-1 me-2" style="text-align: center;">
            <h4 class="d-flex flex-column" style="font-family: 'Segoe UI'; padding-top: 20px;">Completed Working Days</h4>

        </div>
        <!-- Label -->
        <div style="text-align: center; padding-bottom: 20px;">
            <h5 class="fw-bold py-1" style="font-size: 20px;">
                <asp:Label ID="lblcmpltdwrkdays" Style="font-family: 'Segoe UI'; " runat="server"></asp:Label>
            </h5>
        </div>
    </div>
</div>

                <!--Begin:Load In Chart-->
                <div class="col-xl-5">
                    <!--begin::Charts Widget 3-->

                    <div class="card card-xl-stretch mb-5 mb-xl-8" style="background-color: #f5f5f5;">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">

                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Target Amount</span>
                            </h3>
                            <div class="card-toolbar">
                                <h6 class="card-title align-items-end  flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">
                                        <asp:Label ID="lbltargetamnt" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                </h6>
                            </div>


                        </div>
                        <!--end::Header-->
                        <div class="col-xl-12 row">
                            <div class="col-xl-5">
                                <!--begin::Body-->
                                <div class="card-body">
                                    <div class="chartBox">
                                        <!--begin::Chart-->
                                        <canvas id="targetamnt"></canvas>
                                        <!--end::Chart-->
                                    </div>
                                </div>
                                <!--end::Body-->
                            </div>
                            <div class="col-xl-7" style="padding-top: 2rem;">

                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-2">
                                        <img src="../assets/media/dashboard/KPI/Pills/achvd.png"  />
                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">Achieved</small>
                                    </div>
                                    <div class="col-lg-6" style="text-align: end;">
                                        <asp:Label ID="lblachvdamnt" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="0"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-2">
                                        <img src="../assets/media/dashboard/KPI/Pills/mtd.png"  />
                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">MTD Gap </small>
                                    </div>
                                    <div class="col-lg-6" style="text-align: end;">
                                        <asp:Label ID="lblmtdgapamnt" Style="font-family: 'Segoe UI';" runat="server" Font-Size="medium" Font-Bold="true" Text="0"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-2">
                                        <img src="../assets/media/dashboard/KPI/Pills/mg.png"  />
                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">Remaining Gap</small>
                                    </div>
                                    <div class="col-lg-6" style="text-align: end;">
                                        <asp:Label ID="lblmonthlygapamnt" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="0"></asp:Label>
                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>

                    <!--end::Charts Widget 3-->
                </div>
                <!--End:Load In Chart-->
                <div class="col-xl-5">
                    <!--begin::Charts Widget 3-->

                    <div class="card card-xl-stretch mb-5 mb-xl-8" style="background-color: #f5f5f5;">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">

                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Target Quantity</span>
                            </h3>
                            <div class="card-toolbar" >
                                <h6 class="card-title align-items-end  flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">
                                        <asp:Label ID="lbltargetqty" Text="0" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                </h6>
                            </div>


                        </div>
                        <!--end::Header-->
                        <div class="col-xl-12 row">
                            <div class="col-xl-5">
                                <!--begin::Body-->
                                <div class="card-body">
                                    <div class="chartBox">
                                        <!--begin::Chart-->
                                        <canvas id="targetQty"></canvas>
                                        <!--end::Chart-->
                                    </div>
                                </div>
                                <!--end::Body-->
                            </div>
                            <div class="col-xl-7" style="padding-top: 2rem;">

                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-2 ">
                                        <img src="../assets/media/dashboard/KPI/Pills/Achvd.png"  />

                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">Acheived</small>
                                    </div>
                                    <div class="col-lg-6" style="text-align: end;">
                                        <asp:Label ID="lblachvdqty" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="0"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-2">
                                        <img src="../assets/media/dashboard/KPI/Pills/mtd.png" />
                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">MTD Gap</small>
                                    </div>
                                    <div class="col-lg-6" style="text-align: end;">
                                        <asp:Label ID="lblmtdgapqty" Style="font-family: 'Segoe UI';" runat="server" Font-Size="medium" Font-Bold="true" Text="0"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-2">
                                        <img src="../assets/media/dashboard/KPI/Pills/mg.png"  />
                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">Remaining Gap</small>
                                    </div>
                                    <div class="col-lg-6" style="text-align: end;">
                                        <asp:Label ID="lblmonthgapqty" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="0"></asp:Label>
                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>

                    <!--end::Charts Widget 3-->
                </div>

            </div>
            <!--End:Load-->
            <div class="kt-portlet__head" style="border-bottom-style: ridge; border-bottom-width: thin; padding-bottom: 20px;" hidden="hidden">
                <%-- <div class="col-lg-12 row">
                    <h3 class="kt-portlet__head-title">
                        <telerik:RadLabel ID="lblPageHeading" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                    </h3>
                </div>--%>
                <div class="kt-portlet__head-actions col-lg-12 row">
                    <div class="col-lg-6" style="padding-right: 20px;">
                        <div class="card-body d-flex align-items-end pt-0">
                            <!--begin::Progress-->
                            <div class="d-flex align-items-center flex-column mt-3 w-100">
                                <div class="d-flex justify-content-between w-100 mt-auto mb-2">
                                    <span class=" fs-5 text-dark">Total Quantity</span>
                                    <span class=" fs-5 text-dark-400">
                                        <asp:Label ID="lblTotalQtyPerc" Text="0%" runat="server">
                                            
                                        </asp:Label>
                                    </span>
                                </div>
                                <div class=" mx-3 w-100 rounded" style="background-color: #efeeee; height: 15px;">

                                    <asp:Literal ID="ltrQtyPerc" runat="server"></asp:Literal>


                                </div>
                            </div>
                            <!--end::Progress-->
                        </div>
                        <div class="card-header pt-5">
                            <div class="col-lg-12 row">
                                <div class="col-lg-4" style="border-right-style: dashed; border-right-width: thin; border-right-color: #0000007d;">

                                    <!--begin::Title-->
                                    <div class="card-title d-flex flex-column">
                                        <!--begin::Info-->
                                        <div class="d-flex align-items-center">
                                            <!--begin::Currency-->

                                            <!--end::Currency-->
                                            <!--begin::Amount-->
                                            <span class="fs-1 fw-bold text-dark me-2 lh-1 ls-n2">
                                                <asp:Label ID="lblTotalTargetQty" Text="0" runat="server">

                                                </asp:Label>

                                            </span>
                                            <!--end::Amount-->
                                            <!--begin::Badge-->

                                            <!--end::Badge-->
                                        </div>
                                        <!--end::Info-->
                                        <!--begin::Subtitle-->
                                        <span class="text-gray-400 pt-1 fw-semibold fs-6">Target</span>
                                        <!--end::Subtitle-->
                                    </div>
                                </div>
                                <div class="col-lg-4" style="border-right-style: dashed; border-right-width: thin; border-right-color: #0000007d;">

                                    <!--begin::Title-->
                                    <div class="card-title d-flex flex-column">
                                        <!--begin::Info-->
                                        <div class="d-flex align-items-center">
                                            <!--begin::Currency-->

                                            <!--end::Currency-->
                                            <!--begin::Amount-->
                                            <span class="fs-1 fw-bold text-dark me-2 lh-1 ls-n2">
                                                <asp:Label ID="lblTotalAchievedQty" runat="server">
                                                </asp:Label>

                                            </span>
                                            <!--end::Amount-->
                                            <!--begin::Badge-->
                                            <span class="badge badge-light-success fs-base">
                                                <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->
                                                <span class="svg-icon svg-icon-7 svg-icon-success ms-n1">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <rect opacity="0.5" x="13" y="6" width="13" height="2" rx="1" transform="rotate(90 13 6)" fill="currentColor" />
                                                        <path d="M12.5657 8.56569L16.75 12.75C17.1642 13.1642 17.8358 13.1642 18.25 12.75C18.6642 12.3358 18.6642 11.6642 18.25 11.25L12.7071 5.70711C12.3166 5.31658 11.6834 5.31658 11.2929 5.70711L5.75 11.25C5.33579 11.6642 5.33579 12.3358 5.75 12.75C6.16421 13.1642 6.83579 13.1642 7.25 12.75L11.4343 8.56569C11.7467 8.25327 12.2533 8.25327 12.5657 8.56569Z" fill="currentColor" />
                                                    </svg>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <asp:Label ID="lblTotalAchievedQtyPerc" runat="server">
                                                </asp:Label></span>
                                            <!--end::Badge-->
                                        </div>
                                        <!--end::Info-->
                                        <!--begin::Subtitle-->
                                        <span class="text-gray-400 pt-1 fw-semibold fs-6">Achieved</span>
                                        <!--end::Subtitle-->
                                    </div>
                                </div>
                                <div class="col-lg-4">

                                    <!--begin::Title-->
                                    <div class="card-title d-flex flex-column">
                                        <!--begin::Info-->
                                        <div class="d-flex align-items-center">
                                            <!--begin::Currency-->

                                            <!--end::Currency-->
                                            <!--begin::Amount-->
                                            <span class="fs-1 fw-bold text-dark me-2 lh-1 ls-n2">
                                                <asp:Label ID="lblTotalGapQty" runat="server">
                                                </asp:Label>

                                            </span>
                                            <!--end::Amount-->
                                            <!--begin::Badge-->
                                            <span class="badge badge-light-warning fs-base">
                                                <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->
                                                <span class="svg-icon svg-icon-7  svg-icon-warning ms-n1">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <rect opacity="0.5" x="13" y="6" width="13" height="2" rx="1" transform="rotate(90 13 6)" fill="currentColor" />
                                                        <path d="M12.5657 8.56569L16.75 12.75C17.1642 13.1642 17.8358 13.1642 18.25 12.75C18.6642 12.3358 18.6642 11.6642 18.25 11.25L12.7071 5.70711C12.3166 5.31658 11.6834 5.31658 11.2929 5.70711L5.75 11.25C5.33579 11.6642 5.33579 12.3358 5.75 12.75C6.16421 13.1642 6.83579 13.1642 7.25 12.75L11.4343 8.56569C11.7467 8.25327 12.2533 8.25327 12.5657 8.56569Z" fill="currentColor" />
                                                    </svg>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <asp:Label ID="lblTotalGapQtyPerc" runat="server">
                                                </asp:Label>
                                            </span>
                                            <!--end::Badge-->
                                        </div>
                                        <!--end::Info-->
                                        <!--begin::Subtitle-->
                                        <span class="text-gray-400 pt-1 fw-semibold fs-6">Gap</span>
                                        <!--end::Subtitle-->
                                    </div>
                                </div>

                            </div>
                            <!--end::Title-->
                        </div>


                    </div>


                    <div class="col-lg-6" style="padding-left: 20px;">
                        <div class="card-body d-flex align-items-end pt-0">
                            <!--begin::Progress-->
                            <div class="d-flex align-items-center flex-column mt-3 w-100">
                                <div class="d-flex justify-content-between w-100 mt-auto mb-2">
                                    <span class=" fs-5 text-dark">Total Amount</span>
                                    <span class=" fs-5 text-dark-400">
                                        <asp:Label ID="lblTotalAmountPerc" Text="0" runat="server">
                                        </asp:Label>
                                    </span>
                                </div>
                                <div class=" mx-3 w-100  rounded" style="background-color: #efeeee; height: 15px;">
                                    <asp:Literal runat="server" ID="ltrAmtPerc">

                                    </asp:Literal>
                                </div>
                            </div>
                            <!--end::Progress-->
                        </div>
                        <div class="card-header pt-5">
                            <div class="col-lg-12 row">
                                <div class="col-lg-4" style="border-right-style: dashed; border-right-width: thin; border-right-color: #0000007d;">

                                    <!--begin::Title-->
                                    <div class="card-title d-flex flex-column">
                                        <!--begin::Info-->
                                        <div class="d-flex align-items-center">
                                            <!--begin::Currency-->

                                            <!--end::Currency-->
                                            <!--begin::Amount-->
                                            <span class="fs-1 fw-bold text-dark me-2 lh-1 ls-n2">
                                                <asp:Label ID="lblTotalTargetAmt" Text="0" runat="server">
                                                    
                                                </asp:Label></span>
                                            <!--end::Amount-->
                                            <!--begin::Badge-->

                                            <!--end::Badge-->
                                        </div>
                                        <!--end::Info-->
                                        <!--begin::Subtitle-->
                                        <span class="text-gray-400 pt-1 fw-semibold fs-6">Target</span>
                                        <!--end::Subtitle-->
                                    </div>
                                </div>
                                <div class="col-lg-4" style="border-right-style: dashed; border-right-width: thin; border-right-color: #0000007d;">

                                    <!--begin::Title-->
                                    <div class="card-title d-flex flex-column">
                                        <!--begin::Info-->
                                        <div class="d-flex align-items-center">
                                            <!--begin::Currency-->

                                            <!--end::Currency-->
                                            <!--begin::Amount-->
                                            <span class="fs-1 fw-bold text-dark me-2 lh-1 ls-n2">
                                                <asp:Label ID="lblTotalAchievedAmt" Text="0" runat="server">
                                                </asp:Label></span>
                                            <!--end::Amount-->
                                            <!--begin::Badge-->
                                            <span class="badge badge-light-success fs-base">
                                                <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->
                                                <span class="svg-icon svg-icon-7 svg-icon-success ms-n1">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <rect opacity="0.5" x="13" y="6" width="13" height="2" rx="1" transform="rotate(90 13 6)" fill="currentColor" />
                                                        <path d="M12.5657 8.56569L16.75 12.75C17.1642 13.1642 17.8358 13.1642 18.25 12.75C18.6642 12.3358 18.6642 11.6642 18.25 11.25L12.7071 5.70711C12.3166 5.31658 11.6834 5.31658 11.2929 5.70711L5.75 11.25C5.33579 11.6642 5.33579 12.3358 5.75 12.75C6.16421 13.1642 6.83579 13.1642 7.25 12.75L11.4343 8.56569C11.7467 8.25327 12.2533 8.25327 12.5657 8.56569Z" fill="currentColor" />
                                                    </svg>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <asp:Label ID="lblTotalAchievedAmtPerc" Text="0" runat="server">
                                                </asp:Label></span>
                                            <!--end::Badge-->
                                        </div>
                                        <!--end::Info-->
                                        <!--begin::Subtitle-->
                                        <span class="text-gray-400 pt-1 fw-semibold fs-6">Achieved</span>
                                        <!--end::Subtitle-->
                                    </div>
                                </div>
                                <div class="col-lg-4">

                                    <!--begin::Title-->
                                    <div class="card-title d-flex flex-column">
                                        <!--begin::Info-->
                                        <div class="d-flex align-items-center">
                                            <!--begin::Currency-->

                                            <!--end::Currency-->
                                            <!--begin::Amount-->
                                            <span class="fs-1 fw-bold text-dark me-2 lh-1 ls-n2">
                                                <asp:Label ID="lblTotalGapAmt" Text="0" runat="server">
                                                </asp:Label></span>
                                            <!--end::Amount-->
                                            <!--begin::Badge-->
                                            <span class="badge badge-light-warning fs-base">
                                                <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->
                                                <span class="svg-icon svg-icon-7  svg-icon-warning ms-n1">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <rect opacity="0.5" x="13" y="6" width="13" height="2" rx="1" transform="rotate(90 13 6)" fill="currentColor" />
                                                        <path d="M12.5657 8.56569L16.75 12.75C17.1642 13.1642 17.8358 13.1642 18.25 12.75C18.6642 12.3358 18.6642 11.6642 18.25 11.25L12.7071 5.70711C12.3166 5.31658 11.6834 5.31658 11.2929 5.70711L5.75 11.25C5.33579 11.6642 5.33579 12.3358 5.75 12.75C6.16421 13.1642 6.83579 13.1642 7.25 12.75L11.4343 8.56569C11.7467 8.25327 12.2533 8.25327 12.5657 8.56569Z" fill="currentColor" />
                                                    </svg>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <asp:Label ID="lblTotalGapAmtPerc" Text="0" runat="server">
                                                </asp:Label></span>
                                            <!--end::Badge-->
                                        </div>
                                        <!--end::Info-->
                                        <!--begin::Subtitle-->
                                        <span class="text-gray-400 pt-1 fw-semibold fs-6">Gap</span>
                                        <!--end::Subtitle-->
                                    </div>
                                </div>

                            </div>
                            <!--end::Title-->
                        </div>


                    </div>
                </div>
            </div>

            <div class="col-lg-12 row" style="padding-top: 10px;">
                <div class="col-lg-6">
                    <h3 class="kt-portlet__head-title">
                        <telerik:RadLabel ID="lblHeading" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                    </h3>
                </div>
                <div class="col-lg-6" style="display: flex; justify-content: end; align-items: flex-end;">
                    <div style="padding-right: 10px;">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:LinkButton ID="lnkViewProducts" runat="server" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="lnkViewProducts_Click"> View Products
                            </asp:LinkButton>
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>

                    </div>
                    <div style="border-style: groove; border-radius: 4px; border-width: 1px;">
                        <asp:LinkButton ID="reportdetail" runat="server" OnClick="reportdetail_Click" Visible="false">
                          <span class="svg-icon svg-icon-muted svg-icon-2hx  pe-4">
                              <svg width="24" height="24" viewBox="-5 -15 20 55" fill="none" xmlns="http://www.w3.org/2000/svg">
                             <path d="M21 22H3C2.4 22 2 21.6 2 21C2 20.4 2.4 20 3 20H21C21.6 20 22 20.4 22 21C22 21.6 21.6 22 21 22ZM13 13.4V3C13 2.4 12.6 2 12 2C11.4 2 11 2.4 11 3V13.4H13Z" fill="currentColor"/>
                             <path opacity="0.3" d="M7 13.4H17L12.7 17.7C12.3 18.1 11.7 18.1 11.3 17.7L7 13.4Z" fill="currentColor"/>
                             </svg> 
                              Detail Report
                            </span>


                        </asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-lg-12" style="padding-top: 10px;">
                <div class="tab-content">


                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">


                        <!--begin::Portlet-->


                        <!--end: Search Form -->



                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                            ID="grvRpt" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="grvRpt_NeedDataSource"
                            OnItemCommand="grvRpt_ItemCommand"
                            OnPreRender="grvRpt_PreRender"
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="10" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="340px"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="ID"
                                EnableHeaderContextMenu="true">
                                <Columns>




                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Detail">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="Detail" ID="lnkLink" Visible="true" AlternateText="Detail" runat="server"
                                                ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100%"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code" Display="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100%"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name" Display="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="tph_Number" AllowFiltering="true" HeaderStyle-Width="100%"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Pckg Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="tph_Number">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="tph_Name" AllowFiltering="true" HeaderStyle-Width="100%"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Package Name" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="tph_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="TargetAmount" AllowFiltering="true" HeaderStyle-Width="100%"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Tgt Amt" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="TargetAmount">
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="Achvd Amt" HeaderStyle-Width="100%" HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:Literal runat="server" Text='<%# Eval("MonthAchAmount") %>'></asp:Literal>
                                            (<asp:Literal runat="server" Text='<%# Eval("AmountPerc")+ "%"  %> '><style font-size: 08px;></style></asp:Literal>)
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="MTD Gap Amt" HeaderStyle-Width="100%" HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:Literal runat="server" Text='<%# Eval("MTDGapAmt") %>'></asp:Literal>
                                            (<asp:Literal runat="server" Text='<%# Eval("MTDGapAmtperc")+ "%"  %> '><style font-size: 08px;></style></asp:Literal>)
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Rem.Gap Amt" HeaderStyle-Width="100%" HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:Literal runat="server" Text='<%# Eval("MonthlyGapAmount") %>'></asp:Literal>
                                            (<asp:Literal runat="server" Text='<%# Eval("gapAmountPerc")+ "%"  %> '><style font-size: 08px;></style></asp:Literal>)
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>

                                    <%--  <telerik:GridBoundColumn DataField="RemAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Monthly Gap Amt" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="RemAmount">
                                        </telerik:GridBoundColumn>--%>


                                    <telerik:GridBoundColumn DataField="TargetQty" AllowFiltering="true" HeaderStyle-Width="100%"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Tgt Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="TargetQty">
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="Achvd Qty" HeaderStyle-Width="100%" HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:Literal runat="server" Text='<%# Eval("MonthAchQty") %>'></asp:Literal>
                                            (<asp:Literal runat="server" Text='<%# Eval("MonthAchQtyPerc")+ "%"  %> '><style font-size: 08px;></style></asp:Literal>)
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>

                                    <%-- <telerik:GridBoundColumn DataField="AchievedQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Achvd Qty" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="AchievedQty">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="QtyPerc" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Achvd Qty %" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="QtyPerc">
                                        </telerik:GridBoundColumn>--%>
                                    <telerik:GridTemplateColumn HeaderText="MTD Gap Qty" HeaderStyle-Width="100%" HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:Literal runat="server" Text='<%# Eval("MTDGapQty") %>'></asp:Literal>
                                            (<asp:Literal runat="server" Text='<%# Eval("MTDGapQtyPerc")+ "%"  %> '><style font-size: 08px;></style></asp:Literal>)
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />

                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Rem.Gap Qty" HeaderStyle-Width="100%" HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:Literal runat="server" Text='<%# Eval("MonthlyGapQty") %>'></asp:Literal>
                                            (<asp:Literal runat="server" Text='<%# Eval("MonthlyGapQtyPerc")+ "%"  %> '><style font-size: 08px;></style></asp:Literal>)
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>

                                </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </telerik:RadAjaxPanel>


                </div>

            </div>

        </div>
    </div>
    <div class="clearfix"></div>
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content rounded" style="overflow: auto; width: 800px; height: 800px;">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <asp:Label ID="prdHeading" runat="server">Products

                        </asp:Label>
                    </h5>
                      <asp:ImageButton ID="Excel" runat="server" ImageUrl="../assets/media/icons/excel.png" style="height: 50px; " ToolTip="Download" 
                                OnClick="Excel_Click" AlternateText="Xlsx" />

                </div>
                <div class="modal-body">
                    <asp:Literal ID="ltTable" runat="server" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_8);">Ok</button>
                </div>
            </div>
        
            
        </div>
    </div>
        

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
