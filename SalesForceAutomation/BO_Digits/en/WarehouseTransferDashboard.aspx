<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="WarehouseTransferDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.WarehouseTransferDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <div class="col-lg-12 row" style="padding-top: 10px; padding-bottom: 10px;">
            <div class="col-lg-3">
                <div class="col-lg-12">
                    <label class="control-label col-lg-12">MR Location </label>
                </div>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="ddlMRLocation" runat="server" Filter="Contains" Width="100%"
                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select MR Location" OnSelectedIndexChanged="ddlMRLocation_SelectedIndexChanged">
                    </telerik:RadComboBox>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
    <div class="post d-flex flex-column-fluid" id="kt_postss">

        <div id="kt_content_containerss" class="container-xxl ps-0" style="margin-left: 0px; margin-right: 0px; max-width: none;">
            <div class="row col-lg-12 mb-0">
                <div class="col-lg-6 mb-0">
                    <div class="card">
                        <asp:LinkButton ID="lnkMRCreated" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lnkMRCreated_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">

                                <!--begin::Item-->
                                <div class="d-flex flex-stack">

                                    <div class="d-flex flex-column justify-content-start">

                                        <div class="fs-3 fw-bold " style="color: black">Material Request Created</div>

                                    </div>
                                    <div class=" " style="margin-right: -18rem;">
                                        <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                            <span class="" style="font-size: 17px;">
                                                <asp:Label ID="lblMRCreated" runat="server" Text="0"></asp:Label>

                                            </span>

                                        </p>

                                    </div>
                                    <div class="symbol symbol-25px ">
                                        <img src="../assets/media/svg/general/white-arrow.png">
                                    </div>

                                </div>
                                <!--end::Item-->

                            </div>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="m-4">

                <div class="row g-5 g-xl-8 mt-6 ps-5 card" style="background-color: #c0e2f4; background-image: linear-gradient(to right, #377fd6, #21aad6); background-size: 100%; height: 20rem; box-shadow: 0 0px 10px rgba(0, 0, 0, 0.1)">
                    <%--<asp:LinkButton ID="lblPicking" runat="server" OnClick="lblPicking_Click">--%>

                    <div class="col-xl row mt-2 mb-0">

                        <div class="card-header border-0 pt-0 p-0">
                            <h3 class="card-title align-items-start flex-column">
                                <a href="WarehousePickingHeader.aspx?mode=DB" class="card-label fw-bold fs-3 mb-4 ps-3 text-white">WT-Picking</a>

                                <%--  <span class="card-label fw-bold fs-3 mb-4 ps-3 text-white">WT-Picking</span>--%>
                            </h3>
                        </div>

                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                                <%--   <asp:LinkButton ID="lblPicking" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lblPicking_Click">--%>
                                <div class="card-body" style="padding: 1rem 2rem;">

                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="symbol symbol-30px me-3">
                                            <div class="symbol-label bg-light">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path opacity="0.3" d="M22 8H8L12 4H19C19.6 4 20.2 4.39999 20.5 4.89999L22 8ZM3.5 19.1C3.8 19.7 4.4 20 5 20H12L16 16H2L3.5 19.1ZM19.1 20.5C19.7 20.2 20 19.6 20 19V12L16 8V22L19.1 20.5ZM4.9 3.5C4.3 3.8 4 4.4 4 5V12L8 16V2L4.9 3.5Z" fill="currentColor"></path>
                                                        <path d="M22 8L20 12L16 8H22ZM8 16L4 12L2 16H8ZM16 16L12 20L16 22V16ZM8 8L12 4L8 2V8Z" fill="currentColor"></path>
                                                    </svg>
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column justify-content-start">

                                            <div class="fs-6 fw-semibold " style="color: black">Picking Pending</div>

                                        </div>
                                        <div class="">
                                            <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblPickpending" runat="server" Text="0"></asp:Label>

                                                </span>

                                            </p>

                                        </div>

                                    </div>
                                    <!--end::Item-->

                                </div>
                                <%--   </asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                                <%--  <asp:LinkButton ID="lnkPickComplete" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                <div class="card-body" style="padding: 1rem 2rem;">

                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="symbol symbol-30px me-3">
                                            <div class="symbol-label bg-light">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M8 22C7.4 22 7 21.6 7 21V9C7 8.4 7.4 8 8 8C8.6 8 9 8.4 9 9V21C9 21.6 8.6 22 8 22Z" fill="currentColor"></path>
                                                        <path opacity="0.3" d="M4 15C3.4 15 3 14.6 3 14V6C3 5.4 3.4 5 4 5C4.6 5 5 5.4 5 6V14C5 14.6 4.6 15 4 15ZM13 19V3C13 2.4 12.6 2 12 2C11.4 2 11 2.4 11 3V19C11 19.6 11.4 20 12 20C12.6 20 13 19.6 13 19ZM17 16V5C17 4.4 16.6 4 16 4C15.4 4 15 4.4 15 5V16C15 16.6 15.4 17 16 17C16.6 17 17 16.6 17 16ZM21 18V10C21 9.4 20.6 9 20 9C19.4 9 19 9.4 19 10V18C19 18.6 19.4 19 20 19C20.6 19 21 18.6 21 18Z" fill="currentColor"></path>
                                                    </svg>
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column">

                                            <div class="fs-6 fw-semibold pt-2" style="color: black">Picking Ongoing</div>
                                        </div>
                                        <div class="">
                                            <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblPickOngoing" runat="server" Text="0"></asp:Label>
                                                </span>


                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->

                                </div>
                                <%--</asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                                <%-- <asp:LinkButton ID="lnkPickOngoing" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                <div class="card-body" style="padding: 1rem 2rem;">

                                    <!--begin::Item-->
                                    <div class="d-flex flex-stack">
                                        <div class="symbol symbol-30px me-3">
                                            <div class="symbol-label bg-light">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path opacity="0.3" d="M11.425 7.325C12.925 5.825 15.225 5.825 16.725 7.325C18.225 8.825 18.225 11.125 16.725 12.625C15.225 14.125 12.925 14.125 11.425 12.625C9.92501 11.225 9.92501 8.825 11.425 7.325ZM8.42501 4.325C5.32501 7.425 5.32501 12.525 8.42501 15.625C11.525 18.725 16.625 18.725 19.725 15.625C22.825 12.525 22.825 7.425 19.725 4.325C16.525 1.225 11.525 1.225 8.42501 4.325Z" fill="currentColor"></path>
                                                        <path d="M11.325 17.525C10.025 18.025 8.425 17.725 7.325 16.725C5.825 15.225 5.825 12.925 7.325 11.425C8.825 9.92498 11.125 9.92498 12.625 11.425C13.225 12.025 13.625 12.925 13.725 13.725C14.825 13.825 15.925 13.525 16.725 12.625C17.125 12.225 17.425 11.825 17.525 11.325C17.125 10.225 16.525 9.22498 15.625 8.42498C12.525 5.32498 7.425 5.32498 4.325 8.42498C1.225 11.525 1.225 16.625 4.325 19.725C7.425 22.825 12.525 22.825 15.625 19.725C16.325 19.025 16.925 18.225 17.225 17.325C15.425 18.125 13.225 18.225 11.325 17.525Z" fill="currentColor"></path>
                                                    </svg>
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column">

                                            <div class="fs-6 fw-semibold pt-2" style="color: black">Picking Parked</div>
                                        </div>
                                        <div class="">
                                            <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                <span class="" style="font-size: 17px;">
                                                    <asp:Label ID="lblPickParked" runat="server" Text="0"></asp:Label>
                                                </span>

                                            </p>
                                        </div>
                                    </div>
                                    <!--end::Item-->

                                </div>
                                <%-- </asp:LinkButton>--%>
                            </div>
                        </div>



                    </div>

                    <div class="col-xl row mt-2 mb-8">

                        <div class="card-header border-0 pt-0 p-0">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-4 ps-3 text-white">WT-Picking Checking</span>
                            </h3>
                        </div>

                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                                <%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path opacity="0.3" d="M22 8H8L12 4H19C19.6 4 20.2 4.39999 20.5 4.89999L22 8ZM3.5 19.1C3.8 19.7 4.4 20 5 20H12L16 16H2L3.5 19.1ZM19.1 20.5C19.7 20.2 20 19.6 20 19V12L16 8V22L19.1 20.5ZM4.9 3.5C4.3 3.8 4 4.4 4 5V12L8 16V2L4.9 3.5Z" fill="currentColor"></path>
                                                            <path d="M22 8L20 12L16 8H22ZM8 16L4 12L2 16H8ZM16 16L12 20L16 22V16ZM8 8L12 4L8 2V8Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column justify-content-start">

                                                <div class="fs-6 fw-semibold " style="color: black">Checking Pending</div>

                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblpickcheckpending" runat="server" Text="0"></asp:Label>

                                                    </span>

                                                </p>

                                            </div>

                                        </div>
                                        <!--end::Item-->

                                    </div>
                               <%-- </asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                              <%--  <asp:LinkButton ID="LinkButton2" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M8 22C7.4 22 7 21.6 7 21V9C7 8.4 7.4 8 8 8C8.6 8 9 8.4 9 9V21C9 21.6 8.6 22 8 22Z" fill="currentColor"></path>
                                                            <path opacity="0.3" d="M4 15C3.4 15 3 14.6 3 14V6C3 5.4 3.4 5 4 5C4.6 5 5 5.4 5 6V14C5 14.6 4.6 15 4 15ZM13 19V3C13 2.4 12.6 2 12 2C11.4 2 11 2.4 11 3V19C11 19.6 11.4 20 12 20C12.6 20 13 19.6 13 19ZM17 16V5C17 4.4 16.6 4 16 4C15.4 4 15 4.4 15 5V16C15 16.6 15.4 17 16 17C16.6 17 17 16.6 17 16ZM21 18V10C21 9.4 20.6 9 20 9C19.4 9 19 9.4 19 10V18C19 18.6 19.4 19 20 19C20.6 19 21 18.6 21 18Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">

                                                <div class="fs-6 fw-semibold pt-2" style="color: black">Checking Ongoing</div>
                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblpickcheckOngoing" runat="server" Text="0"></asp:Label>
                                                    </span>


                                                </p>
                                            </div>
                                        </div>
                                        <!--end::Item-->

                                    </div>
                               <%-- </asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                                <%--<asp:LinkButton ID="LinkButton3" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path opacity="0.3" d="M11.425 7.325C12.925 5.825 15.225 5.825 16.725 7.325C18.225 8.825 18.225 11.125 16.725 12.625C15.225 14.125 12.925 14.125 11.425 12.625C9.92501 11.225 9.92501 8.825 11.425 7.325ZM8.42501 4.325C5.32501 7.425 5.32501 12.525 8.42501 15.625C11.525 18.725 16.625 18.725 19.725 15.625C22.825 12.525 22.825 7.425 19.725 4.325C16.525 1.225 11.525 1.225 8.42501 4.325Z" fill="currentColor"></path>
                                                            <path d="M11.325 17.525C10.025 18.025 8.425 17.725 7.325 16.725C5.825 15.225 5.825 12.925 7.325 11.425C8.825 9.92498 11.125 9.92498 12.625 11.425C13.225 12.025 13.625 12.925 13.725 13.725C14.825 13.825 15.925 13.525 16.725 12.625C17.125 12.225 17.425 11.825 17.525 11.325C17.125 10.225 16.525 9.22498 15.625 8.42498C12.525 5.32498 7.425 5.32498 4.325 8.42498C1.225 11.525 1.225 16.625 4.325 19.725C7.425 22.825 12.525 22.825 15.625 19.725C16.325 19.025 16.925 18.225 17.225 17.325C15.425 18.125 13.225 18.225 11.325 17.525Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">

                                                <div class="fs-6 fw-semibold pt-2" style="color: black">Checking Parked</div>
                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblpickcheckpark" runat="server" Text="0"></asp:Label>
                                                    </span>


                                                </p>
                                            </div>
                                        </div>
                                        <!--end::Item-->

                                    </div>
                             <%--   </asp:LinkButton>--%>
                            </div>
                        </div>



                    </div>


                    <%--</asp:LinkButton>--%>
                </div>

            </div>

            <div class="row col-lg-12 mb-0 pt-3">
                <div class="col-lg-6 mb-0">
                    <div class="card">
                        <asp:LinkButton ID="lblTransferOut" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lblTransferOut_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">

                                <!--begin::Item-->
                                <div class="d-flex flex-stack">

                                    <div class="d-flex flex-column justify-content-start">

                                        <div class="fs-3 fw-bold " style="color: black">Transfer Out Pending</div>

                                    </div>
                                    <div class=" " style="margin-right: -20rem;">
                                        <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                            <span class="" style="font-size: 17px;">
                                                <asp:Label ID="lblTransOutPending" runat="server" Text="0"></asp:Label>

                                            </span>

                                        </p>

                                    </div>
                                    <div class="symbol symbol-25px ">
                                        <img src="../assets/media/svg/general/white-arrow.png">
                                    </div>

                                </div>
                                <!--end::Item-->

                            </div>
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="col-lg-6 mb-0">
                    <div class="card">
                        <asp:LinkButton ID="lblTransferIn" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lblTransferIn_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">

                                <!--begin::Item-->
                                <div class="d-flex flex-stack">

                                    <div class="d-flex flex-column justify-content-start">

                                        <div class="fs-3 fw-bold " style="color: black">Transfer In Pending</div>

                                    </div>
                                    <div class=" " style="margin-right: -20rem;">
                                        <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                            <span class="" style="font-size: 17px;">
                                                <asp:Label ID="lblTransInPending" runat="server" Text="0"></asp:Label>

                                            </span>

                                        </p>

                                    </div>
                                    <div class="symbol symbol-25px ">
                                        <img src="../assets/media/svg/general/white-arrow.png">
                                    </div>

                                </div>
                                <!--end::Item-->

                            </div>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="m-4">

                <div class="row g-5 g-xl-8 mt-6 ps-5 card" style="background-color: #ea6b1e; background-image: linear-gradient(to right,#ea6b1e, #fc8603); background-size: 100%; height: 20rem; box-shadow: 0 0px 10px rgba(0, 0, 0, 0.1)">

                    <div class="col-xl row mt-2 mb-0">
                        <%-- <asp:LinkButton ID="" runat="server" OnClick="lblWTReceiving_Click">--%>
                        <div class="card-header border-0 pt-0 p-0">
                            <h3 class="card-title align-items-start flex-column">
                                <a href="WarehouseReceivingHeader.aspx?mode=DB" class="card-label fw-bold fs-3 mb-4 ps-3 text-white">WT-Receiving</a>

                                <%-- <span class="card-label fw-bold fs-3 mb-4 ps-3 text-white">WT-Receiving</span>--%>
                            </h3>
                        </div>

                        <div class="col-lg-4 mb-0">
                            <div class="card">
                               <%-- <asp:LinkButton ID="lblWTReceiving" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lblWTReceiving_Click">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path opacity="0.3" d="M22 8H8L12 4H19C19.6 4 20.2 4.39999 20.5 4.89999L22 8ZM3.5 19.1C3.8 19.7 4.4 20 5 20H12L16 16H2L3.5 19.1ZM19.1 20.5C19.7 20.2 20 19.6 20 19V12L16 8V22L19.1 20.5ZM4.9 3.5C4.3 3.8 4 4.4 4 5V12L8 16V2L4.9 3.5Z" fill="currentColor"></path>
                                                            <path d="M22 8L20 12L16 8H22ZM8 16L4 12L2 16H8ZM16 16L12 20L16 22V16ZM8 8L12 4L8 2V8Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column justify-content-start">

                                                <div class="fs-6 fw-semibold " style="color: black">Receiving Pending</div>

                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblrcvpending" runat="server" Text="0"></asp:Label>

                                                    </span>

                                                </p>

                                            </div>

                                        </div>
                                        <!--end::Item-->

                                    </div>
                               <%-- </asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card">
                               <%-- <asp:LinkButton ID="LinkButton5" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M8 22C7.4 22 7 21.6 7 21V9C7 8.4 7.4 8 8 8C8.6 8 9 8.4 9 9V21C9 21.6 8.6 22 8 22Z" fill="currentColor"></path>
                                                            <path opacity="0.3" d="M4 15C3.4 15 3 14.6 3 14V6C3 5.4 3.4 5 4 5C4.6 5 5 5.4 5 6V14C5 14.6 4.6 15 4 15ZM13 19V3C13 2.4 12.6 2 12 2C11.4 2 11 2.4 11 3V19C11 19.6 11.4 20 12 20C12.6 20 13 19.6 13 19ZM17 16V5C17 4.4 16.6 4 16 4C15.4 4 15 4.4 15 5V16C15 16.6 15.4 17 16 17C16.6 17 17 16.6 17 16ZM21 18V10C21 9.4 20.6 9 20 9C19.4 9 19 9.4 19 10V18C19 18.6 19.4 19 20 19C20.6 19 21 18.6 21 18Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">

                                                <div class="fs-6 fw-semibold pt-2" style="color: black">Receiving Ongoing</div>
                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblrcvOngoing" runat="server" Text="0"></asp:Label>
                                                    </span>


                                                </p>
                                            </div>
                                        </div>
                                        <!--end::Item-->

                                    </div>
                               <%-- </asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card">
                              <%--  <asp:LinkButton ID="LinkButton6" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path opacity="0.3" d="M11.425 7.325C12.925 5.825 15.225 5.825 16.725 7.325C18.225 8.825 18.225 11.125 16.725 12.625C15.225 14.125 12.925 14.125 11.425 12.625C9.92501 11.225 9.92501 8.825 11.425 7.325ZM8.42501 4.325C5.32501 7.425 5.32501 12.525 8.42501 15.625C11.525 18.725 16.625 18.725 19.725 15.625C22.825 12.525 22.825 7.425 19.725 4.325C16.525 1.225 11.525 1.225 8.42501 4.325Z" fill="currentColor"></path>
                                                            <path d="M11.325 17.525C10.025 18.025 8.425 17.725 7.325 16.725C5.825 15.225 5.825 12.925 7.325 11.425C8.825 9.92498 11.125 9.92498 12.625 11.425C13.225 12.025 13.625 12.925 13.725 13.725C14.825 13.825 15.925 13.525 16.725 12.625C17.125 12.225 17.425 11.825 17.525 11.325C17.125 10.225 16.525 9.22498 15.625 8.42498C12.525 5.32498 7.425 5.32498 4.325 8.42498C1.225 11.525 1.225 16.625 4.325 19.725C7.425 22.825 12.525 22.825 15.625 19.725C16.325 19.025 16.925 18.225 17.225 17.325C15.425 18.125 13.225 18.225 11.325 17.525Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">

                                                <div class="fs-6 fw-semibold pt-2" style="color: black">Receiving Parked</div>
                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblrcvparked" runat="server" Text="0"></asp:Label>
                                                    </span>


                                                </p>
                                            </div>
                                        </div>
                                        <!--end::Item-->

                                    </div>
                              <%--  </asp:LinkButton>--%>
                            </div>
                        </div>

                        <%--</asp:LinkButton>--%>
                    </div>

                    <div class="col-xl row mt-2 mb-8">

                        <div class="card-header border-0 pt-0 p-0">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-4 ps-3 text-white">WT-Receiving Checking</span>
                            </h3>
                        </div>

                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                               <%-- <asp:LinkButton ID="LinkButton7" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path opacity="0.3" d="M22 8H8L12 4H19C19.6 4 20.2 4.39999 20.5 4.89999L22 8ZM3.5 19.1C3.8 19.7 4.4 20 5 20H12L16 16H2L3.5 19.1ZM19.1 20.5C19.7 20.2 20 19.6 20 19V12L16 8V22L19.1 20.5ZM4.9 3.5C4.3 3.8 4 4.4 4 5V12L8 16V2L4.9 3.5Z" fill="currentColor"></path>
                                                            <path d="M22 8L20 12L16 8H22ZM8 16L4 12L2 16H8ZM16 16L12 20L16 22V16ZM8 8L12 4L8 2V8Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column justify-content-start">

                                                <div class="fs-6 fw-semibold " style="color: black">Checking Pending</div>

                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblrcvcheckpending" runat="server" Text="0"></asp:Label>

                                                    </span>

                                                </p>

                                            </div>

                                        </div>
                                        <!--end::Item-->

                                    </div>
                               <%-- </asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                              <%--  <asp:LinkButton ID="LinkButton8" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M8 22C7.4 22 7 21.6 7 21V9C7 8.4 7.4 8 8 8C8.6 8 9 8.4 9 9V21C9 21.6 8.6 22 8 22Z" fill="currentColor"></path>
                                                            <path opacity="0.3" d="M4 15C3.4 15 3 14.6 3 14V6C3 5.4 3.4 5 4 5C4.6 5 5 5.4 5 6V14C5 14.6 4.6 15 4 15ZM13 19V3C13 2.4 12.6 2 12 2C11.4 2 11 2.4 11 3V19C11 19.6 11.4 20 12 20C12.6 20 13 19.6 13 19ZM17 16V5C17 4.4 16.6 4 16 4C15.4 4 15 4.4 15 5V16C15 16.6 15.4 17 16 17C16.6 17 17 16.6 17 16ZM21 18V10C21 9.4 20.6 9 20 9C19.4 9 19 9.4 19 10V18C19 18.6 19.4 19 20 19C20.6 19 21 18.6 21 18Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">

                                                <div class="fs-6 fw-semibold pt-2" style="color: black">Checking Ongoing</div>
                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblrcvcheckongoing" runat="server" Text="0"></asp:Label>
                                                    </span>


                                                </p>
                                            </div>
                                        </div>
                                        <!--end::Item-->

                                    </div>
                              <%--  </asp:LinkButton>--%>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-0">
                            <div class="card" style="background-color: #f5f5f5;">
                              <%--  <asp:LinkButton ID="LinkButton9" CssClass="fs-5 text-dark text-hover-primary fw-bold" runat="server">--%>
                                    <div class="card-body" style="padding: 1rem 2rem;">

                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="symbol symbol-30px me-3">
                                                <div class="symbol-label bg-light">
                                                    <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                    <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path opacity="0.3" d="M11.425 7.325C12.925 5.825 15.225 5.825 16.725 7.325C18.225 8.825 18.225 11.125 16.725 12.625C15.225 14.125 12.925 14.125 11.425 12.625C9.92501 11.225 9.92501 8.825 11.425 7.325ZM8.42501 4.325C5.32501 7.425 5.32501 12.525 8.42501 15.625C11.525 18.725 16.625 18.725 19.725 15.625C22.825 12.525 22.825 7.425 19.725 4.325C16.525 1.225 11.525 1.225 8.42501 4.325Z" fill="currentColor"></path>
                                                            <path d="M11.325 17.525C10.025 18.025 8.425 17.725 7.325 16.725C5.825 15.225 5.825 12.925 7.325 11.425C8.825 9.92498 11.125 9.92498 12.625 11.425C13.225 12.025 13.625 12.925 13.725 13.725C14.825 13.825 15.925 13.525 16.725 12.625C17.125 12.225 17.425 11.825 17.525 11.325C17.125 10.225 16.525 9.22498 15.625 8.42498C12.525 5.32498 7.425 5.32498 4.325 8.42498C1.225 11.525 1.225 16.625 4.325 19.725C7.425 22.825 12.525 22.825 15.625 19.725C16.325 19.025 16.925 18.225 17.225 17.325C15.425 18.125 13.225 18.225 11.325 17.525Z" fill="currentColor"></path>
                                                        </svg>
                                                    </span>
                                                    <!--end::Svg Icon-->
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column">

                                                <div class="fs-6 fw-semibold pt-2" style="color: black">Checking Parked</div>
                                            </div>
                                            <div class="">
                                                <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important">

                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblrcvcheckparked" runat="server" Text="0"></asp:Label>
                                                    </span>


                                                </p>
                                            </div>
                                        </div>
                                        <!--end::Item-->

                                    </div>
                               <%-- </asp:LinkButton>--%>
                            </div>
                        </div>



                    </div>





                </div>

            </div>
            <div class="row col-lg-12 mb-0">
                <div class="col-lg-6 mb-0">
                    <div class="card">
                        <asp:LinkButton ID="lblrcvchkcomplete" runat="server" CssClass="fs-5 text-dark text-hover-primary fw-bold" OnClick="lblrcvchkcomplete_Click">
                            <div class="card-body" style="padding: 1rem 2rem;">

                                <!--begin::Item-->
                                <div class="d-flex flex-stack">

                                    <div class="d-flex flex-column justify-content-start">

                                        <div class="fs-3 fw-bold " style="color: black">Receiving Checking Completed</div>

                                    </div>
                                    <div class=" " style="margin-right: -13rem;">
                                        <p class="d-flex justify-content-end" style="color: black; margin-bottom: 0.5rem !important; display: contents;">

                                            <span class="" style="font-size: 17px;">
                                                <asp:Label ID="lblrcvchkcompleted" runat="server" Text="0"></asp:Label>

                                            </span>

                                        </p>

                                    </div>
                                    <div class="symbol symbol-25px ">
                                        <img src="../assets/media/svg/general/white-arrow.png">
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
