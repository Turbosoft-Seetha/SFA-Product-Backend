<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AssetTrackingDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AssetTrackingDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div>

                        <div class="col-lg-12 row" style="padding-top: 10px;">

                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MM-yyyy" AutoPostBack="true">
                                    </telerik:RadDatePicker>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                    --%>
                                </div>
                            </div>

                            <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                </asp:LinkButton>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="post d-flex flex-column-fluid" id="kt_post">
                <div id="kt_content_container" class="container-xxl" style="margin-left: 0px; margin-right: 0px; max-width: none;">


                    <div class="row g-5 g-xl-8 ">
                        <!--begin::Col-->
                        <div class="col-xl-12">
                            <!--begin::Mixed Widget 2-->
                            <div class="card card-xl-stretch mb-xl-8">

                                <!--begin::Body-->
                                <div class="card-body p-0">
                                    <!--begin::Chart-->
                                    <div class="card-header rounded bgi-no-repeat bgi-size-cover bgi-position-y-top bgi-position-x-center align-items-start h-250px" style="background-image: url('../assets/media/svg/shapes/top-green.png')" data-theme="light">
                                        <h3 class="card-title align-items-start flex-column text-white pt-10">
                                            <span class="fw-bold fs-2x mb-3">Asset Tracking</span>
                                            <div class="fs-3 text-white">
                                                <span class="opacity-80">View All 
                                            <span class="position-relative d-inline-block">
                                                <asp:LinkButton ID="lnkAssetTypes" runat="server" Text="Assets >" OnClick="lnkAssetTypes_Click" CssClass="link-white opacity-75-hover fw-bold d-block mb-1"></asp:LinkButton>
                                                <span class="position-absolute opacity-50 bottom-0 start-0 border-2 border-body border-bottom w-100"></span>
                                                <!--end::Separator-->
                                            </span>
                                                </span>
                                            </div>
                                            <div class="fs-3 text-white" style="padding-top: 10px;">
                                                <span class="opacity-80">All Assets    
                                                    <asp:Label ID="lblAllAssetCount" runat="server" Text="0" class="ms-18 fs-1"></asp:Label></span>
                                            </div>
                                            <div class="fs-7 text-white" style="padding-top: 10px;">
                                                <span class="opacity-80">Not Assigned    
                                                    <asp:Label ID="lblNotAssigned" runat="server" Text="0" class="ms-20 fs-3"></asp:Label></span>
                                            </div>
                                        </h3>
                                    </div>
                                </div>
                                <!--end::Chart-->
                                <!--begin::Stats-->
                                <div class="card-p mt-n20 position-relative">
                                    <!--begin::Row-->
                                    <div class="row g-0">
                                        <!--begin::Col-->
                                        <div class="col bg-light px-4 py-6 rounded-2 me-7 mb-7">
                                            <!--begin::Svg Icon | path: icons/duotune/general/gen032.svg-->
                                            <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                                <asp:LinkButton ID="lnkTotalAsset" runat="server" OnClick="lnkTotalAsset_Click" CssClass="text-700 fw-semibold" Style="font-size: 26px;">
                                                    <asp:Label ID="lblTotalAsset" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                            </span>
                                            <!--end::Svg Icon-->
                                            <a href="#" class="text-gray-700 fw-semibold fs-4">Assigned</a><br />
                                            <span class="text-gray-700 fw-semibold fs-8">Customers  - 
                                                <asp:Label ID="lblTotalAssetCustomer" runat="server" Text="0" class=" fs-4 "></asp:Label>
                                            </span>
                                        </div>
                                        <!--end::Col-->
                                        <!--begin::Col-->
                                        <div class="col bg-light px-4 py-6 rounded-2 mb-7 me-7">
                                            <!--begin::Svg Icon | path: icons/duotune/finance/fin006.svg-->
                                            <span class="svg-icon svg-icon-3x d-block text-700 fw-semibold text-gray-700" style="margin-top: 10px; margin-bottom: 0.5rem; font-size: 26px;">
                                                <%--<asp:LinkButton ID="lnkVisited" runat="server" OnClick="lnkVisited_Click" CssClass="text-700 fw-semibold" Style="font-size: 20px;">--%>
                                                <asp:Label ID="lblVisited" runat="server"></asp:Label>
                                                <%--</asp:LinkButton>--%>
                                            </span>
                                            <!--end::Svg Icon-->
                                            <a href="#" class="text-gray-700 fw-semibold fs-4">Visited</a><br />
                                            <span class="text-gray-700 fw-semibold fs-8">Customers - 
                                                <asp:Label ID="lblVisitedCustomer" runat="server" Text="0" class=" fs-4 "></asp:Label>
                                            </span>
                                        </div>
                                        <!--end::Col-->
                                        <!--begin::Col-->
                                        <div class="col bg-light px-4 py-6 rounded-2 mb-7 me-7">
                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                            <span class="svg-icon svg-icon-3x d-block" style="margin-top: 10px; margin-bottom: 0.5rem;">
                                                <asp:LinkButton ID="lnkTracked" runat="server" OnClick="lnkTracked_Click" CssClass="text-700 fw-semibold" Style="font-size: 26px;">
                                                    <asp:Label ID="lblTracked" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                            </span>
                                            <!--end::Svg Icon-->
                                            <a href="#" class="text-gray-700 fw-semibold fs-4 mt-2">Tracked</a><br />
                                            <span class="text-gray-700 fw-semibold fs-8">Removal Req -
        <asp:Label ID="lblTrackedRemovalReq" runat="server" Text="0" class=" fs-4 "></asp:Label>
                                            </span>

                                        </div>
                                        <!--end::Col-->
                                        <!--begin::Col-->
                                        <div class="col bg-light px-4 py-6 rounded-2 mb-7">
                                            <!--begin::Svg Icon | path: icons/duotune/communication/com010.svg-->
                                            <span class="svg-icon svg-icon-3x d-block text-700 text-gray-700 fw-semibold" style="margin-top: 10px; margin-bottom: 0.5rem; font-size: 26px;">
                                                <asp:Label ID="lblNotTracked" runat="server"></asp:Label>
                                            </span>
                                            <!--end::Svg Icon-->
                                            <a href="#" class="text-gray-700 fw-semibold fs-4 mt-2">Not Tracked</a><br />
                                            <span class="text-gray-700 fw-semibold fs-8">Removal Req -
        <asp:Label ID="lblNotTrackedRemovalReq" runat="server" Text="0" class=" fs-4"></asp:Label>
                                            </span>
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
                    <div class="row col-xl-12">
                        <div class="col-xl-6">
                            <!--begin::List widget 21-->
                            <div class="card card-flush" style="height: 125%; background-color: #D6ECD6; padding-bottom: 5px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">
                                <asp:LinkButton ID="lnkAssetAddingRequest" runat="server" OnClick="lnkAssetAddingRequest_Click" CssClass="btn btn-sm ">

                                    <!--begin::Header-->
                                    <div class="card-header border-0 pt-2">


                                        <!--begin::Toolbar-->
                                        <div class="card-toolbar">
                                            <img src="../assets/media/dashboard/add.svg" height="40" width="40" />
                                        </div>
                                        <!--end::Toolbar-->
                                        <h3 class="card-title align-items-start flex-column ">

                                            <span class="text-gray-700 mt-1 fw-semibold fs-3 ">Asset Adding Request</span>
                                        </h3>
                                        <h3 class="card-title align-items-start flex-column ">
                                            <span class="card-label fw-bold  fs-3">
                                                <asp:Label ID="lblAssetAddingRequest" runat="server" Text="0" Style="font-size: 30px;" class="text-gray-700"></asp:Label>
                                            </span>
                                        </h3>
                                    </div>
                                </asp:LinkButton>

                                <!--end::Header-->
                            </div>
                            <!--end::List widget 21-->





                        </div>

                        <div class="col-xl-6">
                            <!--begin::List widget 21-->
                            <div class="card card-flush" style="height: 125%; background-color: #F6DFDF; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); padding-bottom: 5px;">
                                <asp:LinkButton ID="lnkAssetRemovalRequest" runat="server" OnClick="lnkAssetRemovalRequest_Click" CssClass="btn btn-sm ">

                                    <!--begin::Header-->
                                    <div class="card-header border-0 pt-2 ">
                                        <!--begin::Toolbar-->
                                        <div class="card-toolbar">
                                            <img src="../assets/media/dashboard/remove.svg" height="40" width="40" />


                                        </div>
                                        <!--end::Toolbar-->

                                        <h3 class="card-title align-items-start flex-column me-5">
                                            <span class="text-gray-700 mt-1 fw-semibold fs-3">Asset Removal Requests</span>
                                        </h3>
                                        <h3 class="card-title align-items-start flex-column me-5">
                                            <span class="card-label fw-bold text-dark fs-2">
                                                <asp:Label ID="lblAssetRemovalRequest" runat="server" Text="0" Style="font-size: 30px;" class="text-gray-700"></asp:Label></span>
                                        </h3>

                                    </div>
                                </asp:LinkButton>

                                <!--end::Header-->
                            </div>
                            <!--end::List widget 21-->



                        </div>
                    </div>

                </div>
            </div>


            <!--end::Col-->



        </div>
    </div>



    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript" src="../assets/Chart.js"></script>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
