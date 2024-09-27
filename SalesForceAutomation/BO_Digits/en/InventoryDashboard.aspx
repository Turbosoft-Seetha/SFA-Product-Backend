<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="InventoryDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.InventoryDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col-lg-12 row">
        <div class="col-lg-2">
            <label class="control-label col-lg-12">From Date</label>
            <div class="col-lg-12">
                <telerik:RadDatePicker RenderMode="Lightweight" Width="100%" ID="rdfromDate" runat="server"  DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged" >
                </telerik:RadDatePicker>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                --%>
            </div>
        </div>

        <div class="col-lg-2">
            <label class="control-label col-lg-12">To Date</label>
            <div class="col-lg-12">
                <telerik:RadDatePicker RenderMode="Lightweight" Width="100%" ID="rdendDate" DateInput-DateFormat="dd-MM-yyyy" runat="server" AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged" >
                </telerik:RadDatePicker>
                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                <%-- <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                --%>
            </div>
        </div>

        <div class="col-lg-2 pt-4" style="text-align: center;">
            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click" Width="80%">
                                            Apply Filter
            </asp:LinkButton>
        </div>
    </div>

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">

        <div class="col-lg-12 row">
            <!--begin::Row-->
            <div class="row g-5 g-xl-8 mt-0">
                <!--begin::Col-->
                <div class="col-xl-4">
                    <asp:LinkButton ID="lblpicking" runat="server"  OnClick="lblpicking_Click">
                    <!--begin::Mixed Widget 1-->
                    <div class="card card-xl-stretch mb-xl-8">
                        <!--begin::Body-->
                        <div class="card-body p-0">
                            <!--begin::Header-->
                            <div class="px-9 pt-7 card-rounded h-275px w-100" style="background-color: #009ef7;">
                                <!--begin::Heading-->
                                <div class="d-flex flex-stack">
                                    <h3 class="m-0 text-white fw-bold fs-3">Picking</h3>
                                    <div class="ms-1">
                                        <!--begin::Menu-->

                                        <!--begin::Menu 3-->
                                        <!--end::Menu 3-->
                                        <!--end::Menu-->
                                    </div>
                                </div>
                                <!--end::Heading-->
                                <!--begin::Balance-->
                                <div class="d-flex text-center flex-column text-white pt-8">
                                    <span class="fw-semibold fs-7">All Picking</span>
                                    <span class="fw-bold fs-2x pt-1">
                                        <asp:Label runat="server" ID="lblTotalPicking" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <!--end::Balance-->
                            </div>
                            <!--end::Header-->
                            <!--begin::Items-->
                            <div class="bg-body shadow-sm card-rounded mx-9 mb-9 px-6 py-9 position-relative z-index-1" style="margin-top: -120px">

                                <h3 class="m-0 text-black fw-bold fs-5" style="padding-bottom:5px; margin-top:-15px;">Picker</h3>
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6 mt-2">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/maps/map004.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M18.4 5.59998C21.9 9.09998 21.9 14.8 18.4 18.3C14.9 21.8 9.2 21.8 5.7 18.3L18.4 5.59998Z" fill="currentColor" />
                                                    <path d="M12 2C6.5 2 2 6.5 2 12C2 17.5 6.5 22 12 22C17.5 22 22 17.5 22 12C22 6.5 17.5 2 12 2ZM19.9 11H13V8.8999C14.9 8.6999 16.7 8.00005 18.1 6.80005C19.1 8.00005 19.7 9.4 19.9 11ZM11 19.8999C9.7 19.6999 8.39999 19.2 7.39999 18.5C8.49999 17.7 9.7 17.2001 11 17.1001V19.8999ZM5.89999 6.90002C7.39999 8.10002 9.2 8.8 11 9V11.1001H4.10001C4.30001 9.4001 4.89999 8.00002 5.89999 6.90002ZM7.39999 5.5C8.49999 4.7 9.7 4.19998 11 4.09998V7C9.7 6.8 8.39999 6.3 7.39999 5.5ZM13 17.1001C14.3 17.3001 15.6 17.8 16.6 18.5C15.5 19.3 14.3 19.7999 13 19.8999V17.1001ZM13 4.09998C14.3 4.29998 15.6 4.8 16.6 5.5C15.5 6.3 14.3 6.80002 13 6.90002V4.09998ZM4.10001 13H11V15.1001C9.1 15.3001 7.29999 16 5.89999 17.2C4.89999 16 4.30001 14.6 4.10001 13ZM18.1 17.1001C16.6 15.9001 14.8 15.2 13 15V12.8999H19.9C19.7 14.5999 19.1 16.0001 18.1 17.1001Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Pending</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Picking not started</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblPickPending" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Parked</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Started then parked</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblPickParked" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/electronics/elc005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M15 19H7C5.9 19 5 18.1 5 17V7C5 5.9 5.9 5 7 5H15C16.1 5 17 5.9 17 7V17C17 18.1 16.1 19 15 19Z" fill="currentColor" />
                                                    <path d="M8.5 2H13.4C14 2 14.5 2.4 14.6 3L14.9 5H6.89999L7.2 3C7.4 2.4 7.9 2 8.5 2ZM7.3 21C7.4 21.6 7.9 22 8.5 22H13.4C14 22 14.5 21.6 14.6 21L14.9 19H6.89999L7.3 21ZM18.3 10.2C18.5 9.39995 18.5 8.49995 18.3 7.69995C18.2 7.29995 17.8 6.90002 17.3 6.90002H17V10.9H17.3C17.8 11 18.2 10.7 18.3 10.2Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Ongoing</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Picking ongoing</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblPickOngoing" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                             <%--   <div class="d-flex align-items-center" hidden="hidden">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M19 22H5C4.4 22 4 21.6 4 21V3C4 2.4 4.4 2 5 2H14L20 8V21C20 21.6 19.6 22 19 22ZM12.5 18C12.5 17.4 12.6 17.5 12 17.5H8.5C7.9 17.5 8 17.4 8 18C8 18.6 7.9 18.5 8.5 18.5L12 18C12.6 18 12.5 18.6 12.5 18ZM16.5 13C16.5 12.4 16.6 12.5 16 12.5H8.5C7.9 12.5 8 12.4 8 13C8 13.6 7.9 13.5 8.5 13.5H15.5C16.1 13.5 16.5 13.6 16.5 13ZM12.5 8C12.5 7.4 12.6 7.5 12 7.5H8C7.4 7.5 7.5 7.4 7.5 8C7.5 8.6 7.4 8.5 8 8.5H12C12.6 8.5 12.5 8.6 12.5 8Z" fill="currentColor" />
                                                    <rect x="7" y="17" width="6" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="12" width="10" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="7" width="6" height="2" rx="1" fill="currentColor" />
                                                    <path d="M15 8H20L14 2V7C14 7.6 14.4 8 15 8Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Completed</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Picking completed</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblPickCompleted" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>--%>
                                <!--end::Item-->
                            </div>
                            <!--end::Items-->
                            <!--begin::Items-->
                            <div class="bg-body shadow-sm card-rounded mx-9 mb-9 px-6 py-9 position-relative z-index-1">
                                 <h3 class="m-0 text-black fw-bold fs-5" style="padding-bottom:5px; margin-top:-15px;">Checker</h3>
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/maps/map004.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M18.4 5.59998C21.9 9.09998 21.9 14.8 18.4 18.3C14.9 21.8 9.2 21.8 5.7 18.3L18.4 5.59998Z" fill="currentColor" />
                                                    <path d="M12 2C6.5 2 2 6.5 2 12C2 17.5 6.5 22 12 22C17.5 22 22 17.5 22 12C22 6.5 17.5 2 12 2ZM19.9 11H13V8.8999C14.9 8.6999 16.7 8.00005 18.1 6.80005C19.1 8.00005 19.7 9.4 19.9 11ZM11 19.8999C9.7 19.6999 8.39999 19.2 7.39999 18.5C8.49999 17.7 9.7 17.2001 11 17.1001V19.8999ZM5.89999 6.90002C7.39999 8.10002 9.2 8.8 11 9V11.1001H4.10001C4.30001 9.4001 4.89999 8.00002 5.89999 6.90002ZM7.39999 5.5C8.49999 4.7 9.7 4.19998 11 4.09998V7C9.7 6.8 8.39999 6.3 7.39999 5.5ZM13 17.1001C14.3 17.3001 15.6 17.8 16.6 18.5C15.5 19.3 14.3 19.7999 13 19.8999V17.1001ZM13 4.09998C14.3 4.29998 15.6 4.8 16.6 5.5C15.5 6.3 14.3 6.80002 13 6.90002V4.09998ZM4.10001 13H11V15.1001C9.1 15.3001 7.29999 16 5.89999 17.2C4.89999 16 4.30001 14.6 4.10001 13ZM18.1 17.1001C16.6 15.9001 14.8 15.2 13 15V12.8999H19.9C19.7 14.5999 19.1 16.0001 18.1 17.1001Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Pending</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Picking not started</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkpickpending" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Parked</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Started then parked</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkpickpark" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/electronics/elc005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M15 19H7C5.9 19 5 18.1 5 17V7C5 5.9 5.9 5 7 5H15C16.1 5 17 5.9 17 7V17C17 18.1 16.1 19 15 19Z" fill="currentColor" />
                                                    <path d="M8.5 2H13.4C14 2 14.5 2.4 14.6 3L14.9 5H6.89999L7.2 3C7.4 2.4 7.9 2 8.5 2ZM7.3 21C7.4 21.6 7.9 22 8.5 22H13.4C14 22 14.5 21.6 14.6 21L14.9 19H6.89999L7.3 21ZM18.3 10.2C18.5 9.39995 18.5 8.49995 18.3 7.69995C18.2 7.29995 17.8 6.90002 17.3 6.90002H17V10.9H17.3C17.8 11 18.2 10.7 18.3 10.2Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Ongoing</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Picking ongoing</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkpickongoing" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M19 22H5C4.4 22 4 21.6 4 21V3C4 2.4 4.4 2 5 2H14L20 8V21C20 21.6 19.6 22 19 22ZM12.5 18C12.5 17.4 12.6 17.5 12 17.5H8.5C7.9 17.5 8 17.4 8 18C8 18.6 7.9 18.5 8.5 18.5L12 18C12.6 18 12.5 18.6 12.5 18ZM16.5 13C16.5 12.4 16.6 12.5 16 12.5H8.5C7.9 12.5 8 12.4 8 13C8 13.6 7.9 13.5 8.5 13.5H15.5C16.1 13.5 16.5 13.6 16.5 13ZM12.5 8C12.5 7.4 12.6 7.5 12 7.5H8C7.4 7.5 7.5 7.4 7.5 8C7.5 8.6 7.4 8.5 8 8.5H12C12.6 8.5 12.5 8.6 12.5 8Z" fill="currentColor" />
                                                    <rect x="7" y="17" width="6" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="12" width="10" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="7" width="6" height="2" rx="1" fill="currentColor" />
                                                    <path d="M15 8H20L14 2V7C14 7.6 14.4 8 15 8Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Completed</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Picking completed</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkpickcomplete" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                            </div>
                            <!--end::Items-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Mixed Widget 1-->
                    </asp:LinkButton>
                </div>
                <!--end::Col-->
                <!--begin::Col-->
                <div class="col-xl-4">
                    <asp:LinkButton ID="lblReceiving" runat="server"  OnClick="lblReceiving_Click">
                    <!--begin::Mixed Widget 1-->
                    <div class="card card-xl-stretch mb-xl-8">
                        <!--begin::Body-->
                        <div class="card-body p-0">
                            <!--begin::Header-->
                            <div class="px-9 pt-7 card-rounded h-275px w-100 bg-danger">
                                <!--begin::Heading-->
                                <div class="d-flex flex-stack">
                                    <h3 class="m-0 text-white fw-bold fs-3">Goods Receiving</h3>
                                    <div class="ms-1">
                                        <!--begin::Menu-->

                                        <!--begin::Menu 3-->
                                        <!--end::Menu 3-->
                                        <!--end::Menu-->
                                    </div>
                                </div>
                                <!--end::Heading-->
                                <!--begin::Balance-->
                                <div class="d-flex text-center flex-column text-white pt-8">
                                    <span class="fw-semibold fs-7">All GRN</span>
                                    <span class="fw-bold fs-2x pt-1">
                                        <asp:Label runat="server" ID="lblGRTotal" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <!--end::Balance-->
                            </div>
                            <!--end::Header-->
                            <!--begin::Items-->
                            <div class="bg-body shadow-sm card-rounded mx-9 mb-9 px-6 py-9 position-relative z-index-1" style="margin-top: -120px">
                                 <h3 class="m-0 text-black fw-bold fs-5" style="padding-bottom:5px; margin-top:-15px;">Receiver</h3>
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/maps/map004.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M18.4 5.59998C21.9 9.09998 21.9 14.8 18.4 18.3C14.9 21.8 9.2 21.8 5.7 18.3L18.4 5.59998Z" fill="currentColor" />
                                                    <path d="M12 2C6.5 2 2 6.5 2 12C2 17.5 6.5 22 12 22C17.5 22 22 17.5 22 12C22 6.5 17.5 2 12 2ZM19.9 11H13V8.8999C14.9 8.6999 16.7 8.00005 18.1 6.80005C19.1 8.00005 19.7 9.4 19.9 11ZM11 19.8999C9.7 19.6999 8.39999 19.2 7.39999 18.5C8.49999 17.7 9.7 17.2001 11 17.1001V19.8999ZM5.89999 6.90002C7.39999 8.10002 9.2 8.8 11 9V11.1001H4.10001C4.30001 9.4001 4.89999 8.00002 5.89999 6.90002ZM7.39999 5.5C8.49999 4.7 9.7 4.19998 11 4.09998V7C9.7 6.8 8.39999 6.3 7.39999 5.5ZM13 17.1001C14.3 17.3001 15.6 17.8 16.6 18.5C15.5 19.3 14.3 19.7999 13 19.8999V17.1001ZM13 4.09998C14.3 4.29998 15.6 4.8 16.6 5.5C15.5 6.3 14.3 6.80002 13 6.90002V4.09998ZM4.10001 13H11V15.1001C9.1 15.3001 7.29999 16 5.89999 17.2C4.89999 16 4.30001 14.6 4.10001 13ZM18.1 17.1001C16.6 15.9001 14.8 15.2 13 15V12.8999H19.9C19.7 14.5999 19.1 16.0001 18.1 17.1001Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Pending</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Receiving not started</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblGRPending" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Parked</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Started then parked</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblGRParked" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/electronics/elc005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M15 19H7C5.9 19 5 18.1 5 17V7C5 5.9 5.9 5 7 5H15C16.1 5 17 5.9 17 7V17C17 18.1 16.1 19 15 19Z" fill="currentColor" />
                                                    <path d="M8.5 2H13.4C14 2 14.5 2.4 14.6 3L14.9 5H6.89999L7.2 3C7.4 2.4 7.9 2 8.5 2ZM7.3 21C7.4 21.6 7.9 22 8.5 22H13.4C14 22 14.5 21.6 14.6 21L14.9 19H6.89999L7.3 21ZM18.3 10.2C18.5 9.39995 18.5 8.49995 18.3 7.69995C18.2 7.29995 17.8 6.90002 17.3 6.90002H17V10.9H17.3C17.8 11 18.2 10.7 18.3 10.2Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Ongoing</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Receiving Ongoing</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblGROngoing" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                              <%--  <div class="d-flex align-items-center" hidden="hidden">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M19 22H5C4.4 22 4 21.6 4 21V3C4 2.4 4.4 2 5 2H14L20 8V21C20 21.6 19.6 22 19 22ZM12.5 18C12.5 17.4 12.6 17.5 12 17.5H8.5C7.9 17.5 8 17.4 8 18C8 18.6 7.9 18.5 8.5 18.5L12 18C12.6 18 12.5 18.6 12.5 18ZM16.5 13C16.5 12.4 16.6 12.5 16 12.5H8.5C7.9 12.5 8 12.4 8 13C8 13.6 7.9 13.5 8.5 13.5H15.5C16.1 13.5 16.5 13.6 16.5 13ZM12.5 8C12.5 7.4 12.6 7.5 12 7.5H8C7.4 7.5 7.5 7.4 7.5 8C7.5 8.6 7.4 8.5 8 8.5H12C12.6 8.5 12.5 8.6 12.5 8Z" fill="currentColor" />
                                                    <rect x="7" y="17" width="6" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="12" width="10" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="7" width="6" height="2" rx="1" fill="currentColor" />
                                                    <path d="M15 8H20L14 2V7C14 7.6 14.4 8 15 8Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Completed</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Receiving completed</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblGRCompleted" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>--%>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <!--end::Item-->
                            </div>
                            <!--end::Items-->
                            <!--begin::Items-->
                            <div class="bg-body shadow-sm card-rounded mx-9 mb-9 px-6 py-9 position-relative z-index-1">
                                 <h3 class="m-0 text-black fw-bold fs-4" style="padding-bottom:5px; margin-top:-15px;">Checker</h3>
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/maps/map004.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M18.4 5.59998C21.9 9.09998 21.9 14.8 18.4 18.3C14.9 21.8 9.2 21.8 5.7 18.3L18.4 5.59998Z" fill="currentColor" />
                                                    <path d="M12 2C6.5 2 2 6.5 2 12C2 17.5 6.5 22 12 22C17.5 22 22 17.5 22 12C22 6.5 17.5 2 12 2ZM19.9 11H13V8.8999C14.9 8.6999 16.7 8.00005 18.1 6.80005C19.1 8.00005 19.7 9.4 19.9 11ZM11 19.8999C9.7 19.6999 8.39999 19.2 7.39999 18.5C8.49999 17.7 9.7 17.2001 11 17.1001V19.8999ZM5.89999 6.90002C7.39999 8.10002 9.2 8.8 11 9V11.1001H4.10001C4.30001 9.4001 4.89999 8.00002 5.89999 6.90002ZM7.39999 5.5C8.49999 4.7 9.7 4.19998 11 4.09998V7C9.7 6.8 8.39999 6.3 7.39999 5.5ZM13 17.1001C14.3 17.3001 15.6 17.8 16.6 18.5C15.5 19.3 14.3 19.7999 13 19.8999V17.1001ZM13 4.09998C14.3 4.29998 15.6 4.8 16.6 5.5C15.5 6.3 14.3 6.80002 13 6.90002V4.09998ZM4.10001 13H11V15.1001C9.1 15.3001 7.29999 16 5.89999 17.2C4.89999 16 4.30001 14.6 4.10001 13ZM18.1 17.1001C16.6 15.9001 14.8 15.2 13 15V12.8999H19.9C19.7 14.5999 19.1 16.0001 18.1 17.1001Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Pending</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Receiving not started</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkreceivpending" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Parked</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Started then parked</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkreceivpark" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/electronics/elc005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M15 19H7C5.9 19 5 18.1 5 17V7C5 5.9 5.9 5 7 5H15C16.1 5 17 5.9 17 7V17C17 18.1 16.1 19 15 19Z" fill="currentColor" />
                                                    <path d="M8.5 2H13.4C14 2 14.5 2.4 14.6 3L14.9 5H6.89999L7.2 3C7.4 2.4 7.9 2 8.5 2ZM7.3 21C7.4 21.6 7.9 22 8.5 22H13.4C14 22 14.5 21.6 14.6 21L14.9 19H6.89999L7.3 21ZM18.3 10.2C18.5 9.39995 18.5 8.49995 18.3 7.69995C18.2 7.29995 17.8 6.90002 17.3 6.90002H17V10.9H17.3C17.8 11 18.2 10.7 18.3 10.2Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Ongoing</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Receiving Ongoing</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkreveivOngoing" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M19 22H5C4.4 22 4 21.6 4 21V3C4 2.4 4.4 2 5 2H14L20 8V21C20 21.6 19.6 22 19 22ZM12.5 18C12.5 17.4 12.6 17.5 12 17.5H8.5C7.9 17.5 8 17.4 8 18C8 18.6 7.9 18.5 8.5 18.5L12 18C12.6 18 12.5 18.6 12.5 18ZM16.5 13C16.5 12.4 16.6 12.5 16 12.5H8.5C7.9 12.5 8 12.4 8 13C8 13.6 7.9 13.5 8.5 13.5H15.5C16.1 13.5 16.5 13.6 16.5 13ZM12.5 8C12.5 7.4 12.6 7.5 12 7.5H8C7.4 7.5 7.5 7.4 7.5 8C7.5 8.6 7.4 8.5 8 8.5H12C12.6 8.5 12.5 8.6 12.5 8Z" fill="currentColor" />
                                                    <rect x="7" y="17" width="6" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="12" width="10" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="7" width="6" height="2" rx="1" fill="currentColor" />
                                                    <path d="M15 8H20L14 2V7C14 7.6 14.4 8 15 8Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Completed</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Receiving completed</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkreceivcomplete" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <!--end::Item-->
                            </div>
                            <!--end::Items-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Mixed Widget 1-->
                    </asp:LinkButton>
                </div>
                <!--end::Col-->
                <!--begin::Col-->
                <div class="col-xl-4">
                    <asp:LinkButton ID="lblStockCount" runat="server"  OnClick="lblStockCount_Click">
                    <!--begin::Mixed Widget 1-->
                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <!--begin::Body-->
                        <div class="card-body p-0">
                            <!--begin::Header-->
                            <div class="px-9 pt-7 card-rounded h-275px w-100" style="background-color: #3bab48;">
                                <!--begin::Heading-->
                                <div class="d-flex flex-stack">
                                    <h3 class="m-0 text-white fw-bold fs-3">Stock Counting</h3>
                                    <div class="ms-1">
                                        <!--begin::Menu-->

                                        <!--begin::Menu 3-->
                                        <!--end::Menu 3-->
                                        <!--end::Menu-->
                                    </div>
                                </div>
                                <!--end::Heading-->
                                <div class="d-flex flex-stack">
                                    <!--begin::Balance-->
                                    <div class="text-left flex-column text-white pt-8">
                                        <span class="fw-semibold fs-7">Scheduled</span>
                                        <br />
                                        <span class="fw-bold fs-2x pt-1">
                                            <asp:Label runat="server" ID="lblScheduled" Text="0"></asp:Label>
                                        </span>
                                    </div>
                                    <!--end::Balance-->
                                    <!--begin::Balance-->
                                    <div class="text-right flex-column text-white pt-8 justify-content-end">
                                        <span class="fw-semibold fs-7">Instant</span>
                                        <br />
                                        <span class="fw-bold fs-2x pt-1">
                                            <asp:Label runat="server" ID="lblInstant" Text="0"></asp:Label>
                                        </span>
                                    </div>
                                    <!--end::Balance-->
                                </div>
                            </div>
                            <!--end::Header-->
                            <!--begin::Items-->
                            <div class="bg-body shadow-sm card-rounded mx-9 mb-9 px-6 py-9 position-relative z-index-1" style="margin-top: -120px">
                                 <h3 class="m-0 text-black fw-bold fs-5" style="padding-bottom:5px; margin-top:-15px;">Stock Counter</h3>
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/maps/map004.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M18.4 5.59998C21.9 9.09998 21.9 14.8 18.4 18.3C14.9 21.8 9.2 21.8 5.7 18.3L18.4 5.59998Z" fill="currentColor" />
                                                    <path d="M12 2C6.5 2 2 6.5 2 12C2 17.5 6.5 22 12 22C17.5 22 22 17.5 22 12C22 6.5 17.5 2 12 2ZM19.9 11H13V8.8999C14.9 8.6999 16.7 8.00005 18.1 6.80005C19.1 8.00005 19.7 9.4 19.9 11ZM11 19.8999C9.7 19.6999 8.39999 19.2 7.39999 18.5C8.49999 17.7 9.7 17.2001 11 17.1001V19.8999ZM5.89999 6.90002C7.39999 8.10002 9.2 8.8 11 9V11.1001H4.10001C4.30001 9.4001 4.89999 8.00002 5.89999 6.90002ZM7.39999 5.5C8.49999 4.7 9.7 4.19998 11 4.09998V7C9.7 6.8 8.39999 6.3 7.39999 5.5ZM13 17.1001C14.3 17.3001 15.6 17.8 16.6 18.5C15.5 19.3 14.3 19.7999 13 19.8999V17.1001ZM13 4.09998C14.3 4.29998 15.6 4.8 16.6 5.5C15.5 6.3 14.3 6.80002 13 6.90002V4.09998ZM4.10001 13H11V15.1001C9.1 15.3001 7.29999 16 5.89999 17.2C4.89999 16 4.30001 14.6 4.10001 13ZM18.1 17.1001C16.6 15.9001 14.8 15.2 13 15V12.8999H19.9C19.7 14.5999 19.1 16.0001 18.1 17.1001Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Pending</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Counting not started</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblSCPending" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Parked</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Started then parked</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblSCParked" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/electronics/elc005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M15 19H7C5.9 19 5 18.1 5 17V7C5 5.9 5.9 5 7 5H15C16.1 5 17 5.9 17 7V17C17 18.1 16.1 19 15 19Z" fill="currentColor" />
                                                    <path d="M8.5 2H13.4C14 2 14.5 2.4 14.6 3L14.9 5H6.89999L7.2 3C7.4 2.4 7.9 2 8.5 2ZM7.3 21C7.4 21.6 7.9 22 8.5 22H13.4C14 22 14.5 21.6 14.6 21L14.9 19H6.89999L7.3 21ZM18.3 10.2C18.5 9.39995 18.5 8.49995 18.3 7.69995C18.2 7.29995 17.8 6.90002 17.3 6.90002H17V10.9H17.3C17.8 11 18.2 10.7 18.3 10.2Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Ongoing</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Counting ongoing</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblSCOngoing" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                              <%--  <div class="d-flex align-items-center" hidden="hidden">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M19 22H5C4.4 22 4 21.6 4 21V3C4 2.4 4.4 2 5 2H14L20 8V21C20 21.6 19.6 22 19 22ZM12.5 18C12.5 17.4 12.6 17.5 12 17.5H8.5C7.9 17.5 8 17.4 8 18C8 18.6 7.9 18.5 8.5 18.5L12 18C12.6 18 12.5 18.6 12.5 18ZM16.5 13C16.5 12.4 16.6 12.5 16 12.5H8.5C7.9 12.5 8 12.4 8 13C8 13.6 7.9 13.5 8.5 13.5H15.5C16.1 13.5 16.5 13.6 16.5 13ZM12.5 8C12.5 7.4 12.6 7.5 12 7.5H8C7.4 7.5 7.5 7.4 7.5 8C7.5 8.6 7.4 8.5 8 8.5H12C12.6 8.5 12.5 8.6 12.5 8Z" fill="currentColor" />
                                                    <rect x="7" y="17" width="6" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="12" width="10" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="7" width="6" height="2" rx="1" fill="currentColor" />
                                                    <path d="M15 8H20L14 2V7C14 7.6 14.4 8 15 8Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Completed</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Counting completed</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblSCCompleted" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>--%>
                                <!--end::Item-->
                            </div>
                            <!--end::Items-->
                            <!--begin::Items-->
                            <div class="bg-body shadow-sm card-rounded mx-9 mb-9 px-6 py-9 position-relative z-index-1">
                                 <h3 class="m-0 text-black fw-bold fs-5" style="padding-bottom:5px; margin-top:-15px;">Checker</h3>
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/maps/map004.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M18.4 5.59998C21.9 9.09998 21.9 14.8 18.4 18.3C14.9 21.8 9.2 21.8 5.7 18.3L18.4 5.59998Z" fill="currentColor" />
                                                    <path d="M12 2C6.5 2 2 6.5 2 12C2 17.5 6.5 22 12 22C17.5 22 22 17.5 22 12C22 6.5 17.5 2 12 2ZM19.9 11H13V8.8999C14.9 8.6999 16.7 8.00005 18.1 6.80005C19.1 8.00005 19.7 9.4 19.9 11ZM11 19.8999C9.7 19.6999 8.39999 19.2 7.39999 18.5C8.49999 17.7 9.7 17.2001 11 17.1001V19.8999ZM5.89999 6.90002C7.39999 8.10002 9.2 8.8 11 9V11.1001H4.10001C4.30001 9.4001 4.89999 8.00002 5.89999 6.90002ZM7.39999 5.5C8.49999 4.7 9.7 4.19998 11 4.09998V7C9.7 6.8 8.39999 6.3 7.39999 5.5ZM13 17.1001C14.3 17.3001 15.6 17.8 16.6 18.5C15.5 19.3 14.3 19.7999 13 19.8999V17.1001ZM13 4.09998C14.3 4.29998 15.6 4.8 16.6 5.5C15.5 6.3 14.3 6.80002 13 6.90002V4.09998ZM4.10001 13H11V15.1001C9.1 15.3001 7.29999 16 5.89999 17.2C4.89999 16 4.30001 14.6 4.10001 13ZM18.1 17.1001C16.6 15.9001 14.8 15.2 13 15V12.8999H19.9C19.7 14.5999 19.1 16.0001 18.1 17.1001Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Pending</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Counting not started</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkcountingpending" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Parked</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Started then parked</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkcountingpark" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center mb-6">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/electronics/elc005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M15 19H7C5.9 19 5 18.1 5 17V7C5 5.9 5.9 5 7 5H15C16.1 5 17 5.9 17 7V17C17 18.1 16.1 19 15 19Z" fill="currentColor" />
                                                    <path d="M8.5 2H13.4C14 2 14.5 2.4 14.6 3L14.9 5H6.89999L7.2 3C7.4 2.4 7.9 2 8.5 2ZM7.3 21C7.4 21.6 7.9 22 8.5 22H13.4C14 22 14.5 21.6 14.6 21L14.9 19H6.89999L7.3 21ZM18.3 10.2C18.5 9.39995 18.5 8.49995 18.3 7.69995C18.2 7.29995 17.8 6.90002 17.3 6.90002H17V10.9H17.3C17.8 11 18.2 10.7 18.3 10.2Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Ongoing</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Counting ongoing</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkcountingongoing" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                                <!--begin::Item-->
                                <div class="d-flex align-items-center">
                                    <!--begin::Symbol-->
                                    <div class="symbol symbol-45px w-40px me-5">
                                        <span class="symbol-label bg-lighten">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen005.svg-->
                                            <span class="svg-icon svg-icon-1">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path opacity="0.3" d="M19 22H5C4.4 22 4 21.6 4 21V3C4 2.4 4.4 2 5 2H14L20 8V21C20 21.6 19.6 22 19 22ZM12.5 18C12.5 17.4 12.6 17.5 12 17.5H8.5C7.9 17.5 8 17.4 8 18C8 18.6 7.9 18.5 8.5 18.5L12 18C12.6 18 12.5 18.6 12.5 18ZM16.5 13C16.5 12.4 16.6 12.5 16 12.5H8.5C7.9 12.5 8 12.4 8 13C8 13.6 7.9 13.5 8.5 13.5H15.5C16.1 13.5 16.5 13.6 16.5 13ZM12.5 8C12.5 7.4 12.6 7.5 12 7.5H8C7.4 7.5 7.5 7.4 7.5 8C7.5 8.6 7.4 8.5 8 8.5H12C12.6 8.5 12.5 8.6 12.5 8Z" fill="currentColor" />
                                                    <rect x="7" y="17" width="6" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="12" width="10" height="2" rx="1" fill="currentColor" />
                                                    <rect x="7" y="7" width="6" height="2" rx="1" fill="currentColor" />
                                                    <path d="M15 8H20L14 2V7C14 7.6 14.4 8 15 8Z" fill="currentColor" />
                                                </svg>
                                            </span>
                                            <!--end::Svg Icon-->
                                        </span>
                                    </div>
                                    <!--end::Symbol-->
                                    <!--begin::Description-->
                                    <div class="d-flex align-items-center flex-wrap w-100">
                                        <!--begin::Title-->
                                        <div class="mb-1 pe-3 flex-grow-1">
                                            <a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Completed</a>
                                            <div class="text-gray-400 fw-semibold fs-7">Counting completed</div>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Label-->
                                        <div class="d-flex align-items-center">
                                            <div class="fw-bold fs-5 text-gray-800 pe-1">
                                                <asp:Label runat="server" ID="lblchkcountingcomplt" Text="0"></asp:Label>
                                            </div>
                                            <!--begin::Svg Icon | path: icons/duotune/arrows/arr065.svg-->

                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Label-->
                                    </div>
                                    <!--end::Description-->
                                </div>
                                <!--end::Item-->
                            </div>
                            <!--end::Items-->
                        </div>
                        <!--end::Body-->
                    </div>
                    <!--end::Mixed Widget 1-->
                        </asp:LinkButton>
                </div>
                <!--end::Col-->
            </div>
            <!--end::Row-->


        </div>




    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
