<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col-lg-12">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">
                    <div class=" col-lg-12 row" style="padding-bottom: 10px">
                        <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false">
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
                                    <telerik:RadComboBox  Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                        RenderMode="Lightweight"
                                        ID="ddldepot" runat="server" EmptyMessage="Select Depot"
                                        OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>

                                </div>
                            </div>
                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">Area</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox  Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                        ID="ddldpoArea" runat="server" EmptyMessage="Select Area"
                                        OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>

                                </div>
                            </div>
                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">Subarea</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox  Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                        ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>

                                </div>
                            </div>
                        </asp:PlaceHolder>
                    </div>
                    <div class="col-lg-12 row" style="padding-bottom: 10px">

                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">Route</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox RenderMode="Lightweight" ID="ddlRoute" runat="server" Width="100%"
                                    EmptyMessage="Select Route" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-2">
                            <label class="control-label col-lg-12">From Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server"  Width="100%" DateInput-DateFormat="dd-MMM-yyyy">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-2">
                            <label class="control-label col-lg-12">To Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"  Width="100%">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-2" style="text-align: center; padding-top: 10px; padding-left: 10px; top: 19px; margin-left: -50px;">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    Apply Filter
                            </asp:LinkButton>
                        </div>
                        <div class="col-lg-2" style="text-align: center; padding-top: 10px; margin-left: -36px; width: auto;">
                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" Visible="false">
                                                    Advanced Filter
                            </asp:LinkButton>
                        </div>


                    </div>

                </div>
            </div>
        </div>
    </div>
    <asp:PlaceHolder ID="pnlOld" runat="server" Visible="false">
        <!--begin::Row-->
        <div class="row g-5 g-xl-8">
            <div class="col-xl-4">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="lnkSchVisNoTrans" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSchVisNoTrans_Click" BackColor="#e75a7d">
                    <!--begin::Body-->
                    <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                        <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                        <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                            <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                                <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                                <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                        <div>
                            <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                        </div>
                        <div class="text-white fw-bold fs-2 mb-2">Scheduled - Visited - No Trans</div>
                        <div class="fw-semibold text-white">Click here to download report</div>
                    </div>
                    <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
            </div>
            <div class="col-xl-4">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="lnkUnSchVisNoTrans" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkUnSchVisNoTrans_Click" BackColor="#419fd5">
                    <!--begin::Body-->
                    <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                        <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm008.svg-->
                        <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                            <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path opacity="0.3" d="M14 12V21H10V12C10 11.4 10.4 11 11 11H13C13.6 11 14 11.4 14 12ZM7 2H5C4.4 2 4 2.4 4 3V21H8V3C8 2.4 7.6 2 7 2Z" fill="currentColor" />
                                <path d="M21 20H20V16C20 15.4 19.6 15 19 15H17C16.4 15 16 15.4 16 16V20H3C2.4 20 2 20.4 2 21C2 21.6 2.4 22 3 22H21C21.6 22 22 21.6 22 21C22 20.4 21.6 20 21 20Z" fill="currentColor" />
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                        <div>
                            <asp:Label ID="lblUnSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                        </div>
                        <div class="text-white fw-bold fs-2 mb-2">Unscheduled - Visited - No Trans</div>
                        <div class="fw-semibold text-white">Click here to download report</div>
                    </div>
                    <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
            </div>
            <div class="col-xl-4">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="lnkSchNotVis" runat="server" CssClass="card hoverable card-xl-stretch mb-5 mb-xl-8" OnClick="lnkSchNotVis_Click" BackColor="#7fc9a1">
                    <!--begin::Body-->
                    <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                        <!--begin::Svg Icon | path: icons/duotune/graphs/gra005.svg-->
                        <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                            <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path opacity="0.3" d="M8.4 14L15.6 8.79999L20 9.90002V6L16 4L9 11L5 12V14H8.4Z" fill="currentColor" />
                                <path d="M21 18H20V12L16 11L9 16H6V3C6 2.4 5.6 2 5 2C4.4 2 4 2.4 4 3V18H3C2.4 18 2 18.4 2 19C2 19.6 2.4 20 3 20H4V21C4 21.6 4.4 22 5 22C5.6 22 6 21.6 6 21V20H21C21.6 20 22 19.6 22 19C22 18.4 21.6 18 21 18Z" fill="currentColor" />
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                        <div>
                            <asp:Label ID="lblSchNotVis" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                        </div>
                        <div class="text-white fw-bold fs-2 mb-2">Scheduled - Not Visited</div>
                        <div class="fw-semibold text-white">Click here to download report</div>
                    </div>
                    <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
            </div>
        </div>
        <!--end::Row-->
        <!--begin::Row-->
        <div class="row g-5 g-xl-8">
            <div class="col-xl-3">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="lnkNoSaleCustom" runat="server" CssClass="card bg-body hoverable card-xl-stretch mb-xl-8" OnClick="lnkNoSaleCustom_Click">
                    <!--begin::Body-->
                    <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                        <!--begin::Svg Icon | path: icons/duotune/general/gen032.svg-->
                        <span class="svg-icon svg-icon-primary svg-icon-3x ms-n1" style="margin-right: -10px;">
                            <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M16.0173 9H15.3945C14.2833 9 13.263 9.61425 12.7431 10.5963L12.154 11.7091C12.0645 11.8781 12.1072 12.0868 12.2559 12.2071L12.6402 12.5183C13.2631 13.0225 13.7556 13.6691 14.0764 14.4035L14.2321 14.7601C14.2957 14.9058 14.4396 15 14.5987 15H18.6747C19.7297 15 20.4057 13.8774 19.912 12.945L18.6686 10.5963C18.1487 9.61425 17.1285 9 16.0173 9Z" fill="currentColor" />
                                <rect opacity="0.3" x="14" y="4" width="4" height="4" rx="2" fill="currentColor" />
                                <path d="M4.65486 14.8559C5.40389 13.1224 7.11161 12 9 12C10.8884 12 12.5961 13.1224 13.3451 14.8559L14.793 18.2067C15.3636 19.5271 14.3955 21 12.9571 21H5.04292C3.60453 21 2.63644 19.5271 3.20698 18.2067L4.65486 14.8559Z" fill="currentColor" />
                                <rect opacity="0.3" x="6" y="5" width="6" height="6" rx="3" fill="currentColor" />
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                        <div>
                            <asp:Label ID="lblNoSaleCustom" runat="server" CssClass="text-gray-900 fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                        </div>
                        <div class="text-gray-900 fw-bold fs-2 mb-2">No Sale Customers</div>
                        <div class="fw-semibold text-gray-400">Click here to download report</div>
                    </div>
                    <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
            </div>

            <div class="col-xl-3">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="lnkNotVisited" runat="server" CssClass="card hoverable card-xl-stretch mb-5 mb-xl-8" OnClick="lnkNotVisited_Click" BackColor="#866eb9">
                    <!--begin::Body-->
                    <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                        <!--begin::Svg Icon | path: icons/duotune/graphs/gra007.svg-->
                        <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                            <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect opacity="0.3" x="2" y="2" width="20" height="20" rx="10" fill="currentColor" />
                                <rect x="11" y="14" width="7" height="2" rx="1" transform="rotate(-90 11 14)" fill="currentColor" />
                                <rect x="11" y="17" width="2" height="2" rx="1" transform="rotate(-90 11 17)" fill="currentColor" />
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                        <div>
                            <asp:Label ID="lblNotVisited" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                        </div>
                        <div class="text-white fw-bold fs-2 mb-2">Not Visited</div>
                        <div class="fw-semibold text-white">Click here to download report</div>
                    </div>
                    <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
            </div>
        </div>
        <!--end::Row-->
    </asp:PlaceHolder>

    <!--begin::New Layout-->
    <div class="row g-5 g-xl-8">
        <!--begin::Col-->
        <div class="col-xl-4">
            <!--begin::Mixed Widget 2-->
            <div class="card card-xl-stretch mb-xl-8">
                <asp:LinkButton ID="lnkTotalScheduled" runat="server" OnClick="lnkTotalScheduled_Click">
                <!--begin::Header-->
                <div class="card-header border-0 py-5" style="background-image: linear-gradient(to right, #33b670, #40cd81);">
                    <h3 class="card-title fw-bold text-white"></h3>
                    <div class="card-toolbar">
                        <!--begin::Svg Icon | path: icons/duotune/general/gen024.svg-->
                        <span class="svg-icon svg-icon-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="80.875" height="80.875" viewBox="0 0 80.875 80.875">
                                <g id="Icon_feather-download" data-name="Icon feather-download" opacity="0.99">
                                    <path id="Path_1802" data-name="Path 1802" d="M76.375,22.5V38.472a7.986,7.986,0,0,1-7.986,7.986h-55.9A7.986,7.986,0,0,1,4.5,38.472V22.5" transform="translate(0 29.917)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                    <path id="Path_1803" data-name="Path 1803" d="M10.5,15,30.465,34.965,50.431,15" transform="translate(9.972 17.451)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                    <path id="Path_1804" data-name="Path 1804" d="M18,52.417V4.5" transform="translate(22.438 0)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                </g>
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                    </div>
                </div>
                <!--end::Header-->
                </asp:LinkButton>
                <!--begin::Body-->
                <div class="card-body p-0">
                    <!--begin::Chart-->
                    <div class="card-rounded-bottom" data-kt-color="info" style="height: 160px; background-image: linear-gradient(to right, #33b670, #40cd81);">
                        <div class="d-flex text-center flex-column text-white pt-8">
                            <span class="fw-semibold fs-2">Scheduled Customers</span>
                            <span class="fw-bold fs-2x pt-1">
                                <asp:Label ID="lblTotalScheduled" runat="server"></asp:Label></span>
                        </div>
                    </div>
                    <!--end::Chart-->
                    <!--begin::Stats-->
                    <div class="card-p mt-n20 position-relative">
                        <!--begin::Row-->
                        <div class="row g-0">
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2 me-7 mb-7">
                                <!--begin::Svg Icon | path: icons/duotune/general/gen032.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkScheduledVisited" runat="server" OnClick="lnkScheduledVisited_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblScheduledVisited" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6">Visited</a>
                            </div>
                            <!--end::Col-->
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2 mb-7">
                                <!--begin::Svg Icon | path: icons/duotune/finance/fin006.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkScheduledProd" runat="server" OnClick="lnkScheduledProd_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblScheduledProd" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6">Productive</a>
                            </div>
                            <!--end::Col-->
                        </div>
                        <!--end::Row-->
                        <!--begin::Row-->
                        <div class="row g-0">
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2 me-7">
                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkScheduledNonProd" runat="server" OnClick="lnkScheduledNonProd_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblScheduledNonProd" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6 mt-2">Non Productive</a>

                            </div>
                            <!--end::Col-->
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2">
                                <!--begin::Svg Icon | path: icons/duotune/communication/com010.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkScheduledNotVisited" runat="server" OnClick="lnkScheduledNotVisited_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblScheduledNotVisited" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6 mt-2">Not Visited</a>
                            </div>
                            <!--end::Col-->
                        </div>
                        <!--end::Row-->
                    </div>
                    <!--end::Stats-->
                </div>
                <!--end::Body-->
            </div>
            <!--end::Mixed Widget 2-->
        </div>
        <!--end::Col-->
        <!--begin::Col-->
        <div class="col-xl-4">
            <!--begin::Mixed Widget 2-->
            <div class="card mb-xl-8">
                <asp:LinkButton ID="lnkTotalUnscheduledVisit" runat="server" OnClick="lnkTotalUnscheduledVisit_Click">
                <!--begin::Header-->
                <div class="card-header border-0 py-5" style="background-image: linear-gradient(to right, #bd307c, #c7428b);">
                    <h3 class="card-title fw-bold text-white"></h3>
                    <div class="card-toolbar">
                        <!--begin::Svg Icon | path: icons/duotune/general/gen024.svg-->
                        <span class="svg-icon svg-icon-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="80.875" height="80.875" viewBox="0 0 80.875 80.875">
                                <g id="Icon_feather-downloads" data-name="Icon feather-download" opacity="0.99">
                                    <path id="Path_1805" data-name="Path 1802" d="M76.375,22.5V38.472a7.986,7.986,0,0,1-7.986,7.986h-55.9A7.986,7.986,0,0,1,4.5,38.472V22.5" transform="translate(0 29.917)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                    <path id="Path_1806" data-name="Path 1803" d="M10.5,15,30.465,34.965,50.431,15" transform="translate(9.972 17.451)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                    <path id="Path_1807" data-name="Path 1804" d="M18,52.417V4.5" transform="translate(22.438 0)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                </g>
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                    </div>
                </div>
                <!--end::Header-->
                </asp:LinkButton>
                <!--begin::Body-->
                <div class="card-body p-0">
                    <!--begin::Chart-->
                    <div class="card-rounded-bottom" data-kt-color="danger" style="height: 160px; background-image: linear-gradient(to right, #bd307c, #c7428b);">
                        <div class="d-flex text-center flex-column text-white pt-8">
                            <span class="fw-semibold fs-2">Un Scheduled Visits</span>
                            <span class="fw-bold fs-2x pt-1">
                                <asp:Label ID="lblTotalUnScheduled" runat="server"></asp:Label></span>
                        </div>
                    </div>
                    <!--end::Chart-->
                    <!--begin::Stats-->
                    <div class="card-p mt-n20 position-relative">
                        <!--begin::Row-->
                        <div class="row g-0">
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2 me-7">
                                <!--begin::Svg Icon | path: icons/duotune/general/gen032.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkUnscheduledProd" runat="server" OnClick="lnkUnscheduledProd_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblUnscheduledProd" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6">Productive</a>
                            </div>
                            <!--end::Col-->
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2">
                                <!--begin::Svg Icon | path: icons/duotune/finance/fin006.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkUnscheduledNonProd" runat="server" OnClick="lnkUnscheduledNonProd_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblUnscheduledNonProd" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6">Non Productive</a>
                            </div>
                            <!--end::Col-->
                        </div>
                        <!--end::Row-->
                    </div>
                    <!--end::Stats-->
                </div>
                <!--end::Body-->
            </div>
            <!--end::Mixed Widget 2-->
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkNoSaleItem" runat="server" CssClass="card hoverable mb-xl-8" OnClick="lnkNoSaleItem_Click" BackColor="#d83f63">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <div>
                        <asp:Label ID="lblNoSaleItem" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>
                    <div class="text-gray-100 fw-bold fs-2 mb-2">No Sale Items</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <!--end::Col-->
        <!--begin::Col-->
        <div class="col-xl-4">
            <!--begin::Mixed Widget 2-->
            <div class="card mb-5 mb-xl-8">
                <asp:LinkButton ID="lnkTotalNonProdCustomer" runat="server" OnClick="lnkTotalNonProdCustomer_Click">
                <!--begin::Header-->
                <div class="card-header border-0 py-5" style="background-image: linear-gradient(to right, #888887, #989898);">
                    <h3 class="card-title fw-bold text-white"></h3>
                    <div class="card-toolbar">
                        <!--begin::Svg Icon | path: icons/duotune/general/gen024.svg-->
                        <span class="svg-icon svg-icon-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="80.875" height="80.875" viewBox="0 0 80.875 80.875">
                                <g id="Icon_feather-downloadss" data-name="Icon feather-download" opacity="0.99">
                                    <path id="Path_1808" data-name="Path 1802" d="M76.375,22.5V38.472a7.986,7.986,0,0,1-7.986,7.986h-55.9A7.986,7.986,0,0,1,4.5,38.472V22.5" transform="translate(0 29.917)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                    <path id="Path_1809" data-name="Path 1803" d="M10.5,15,30.465,34.965,50.431,15" transform="translate(9.972 17.451)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                    <path id="Path_1801" data-name="Path 1804" d="M18,52.417V4.5" transform="translate(22.438 0)" fill="none" stroke="#dcdcdc" stroke-linecap="round" stroke-linejoin="round" stroke-width="9" />
                                </g>
                            </svg>
                        </span>
                        <!--end::Svg Icon-->
                    </div>
                </div>
                <!--end::Header-->
                </asp:LinkButton>
                <!--begin::Body-->
                <div class="card-body p-0">
                    <!--begin::Chart-->
                    <div class="card-rounded-bottom" data-kt-color="primary" style="height: 160px; background-image: linear-gradient(to right, #888887, #989898);">
                        <div class="d-flex text-center flex-column text-white pt-8">
                            <span class="fw-semibold fs-2">No Transaction Customers</span>
                            <span class="fw-bold fs-2x pt-1">
                                <asp:Label ID="lblTotlaNonProdCustomers" runat="server"></asp:Label>
                            </span>
                        </div>
                    </div>
                    <!--end::Chart-->
                    <!--begin::Stats-->
                    <div class="card-p mt-n20 position-relative">
                        <!--begin::Row-->
                        <div class="row g-0">
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2 me-7">
                                <!--begin::Svg Icon | path: icons/duotune/general/gen032.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkNonProdCustScheduled" runat="server" OnClick="lnkNonProdCustScheduled_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblScheduledNonProdCust" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6">Scheduled</a>
                            </div>
                            <!--end::Col-->
                            <!--begin::Col-->
                            <div class="col bg-light px-6 py-8 rounded-2">
                                <!--begin::Svg Icon | path: icons/duotune/finance/fin006.svg-->
                                <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                    <asp:LinkButton ID="lnkNonProdCustUnscheduled" runat="server" OnClick="lnkNonProdCustUnscheduled_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">
                                        <asp:Label ID="lblUnscheduledNonProdCust" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </span>
                                <!--end::Svg Icon-->
                                <a href="#" class="text-gray-500 fw-semibold fs-6">Unscheduled</a>
                            </div>
                            <!--end::Col-->
                        </div>
                        <!--end::Row-->
                    </div>
                    <!--end::Stats-->
                </div>
                <!--end::Body-->
            </div>
            <!--end::Mixed Widget 2-->
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkItemWiseSale" runat="server" CssClass="card hoverable mb-xl-8" OnClick="lnkItemWiseSale_Click" BackColor="#603db4">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <div>
                        <asp:Label ID="lblItemWiseSale" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>
                    <div class="text-white fw-bold fs-2 mb-2">Item Wise Sale</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <!--end::Col-->

    </div>
    <!--end::New Layout-->

</asp:Content>
