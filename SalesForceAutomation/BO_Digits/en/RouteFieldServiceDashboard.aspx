<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteFieldServiceDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteFieldServiceDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <link href="../assets/style.bundle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">
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
                                        ID="ddldpoArea" runat="server" EmptyMessage="Select Area" OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged1" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">Subarea</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                        ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged1" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" AutoPostBack="true" DateInput-DateFormat="dd-MM-yyyy" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">Route</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Filter="Contains" RenderMode="Lightweight" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                            </div>
                        </div>

                        

                        <div class="col-lg-1" style="text-align: center; padding-top: 10px; width: auto; padding-left: 0px;">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2 myLink" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="true" OnClick="lnkFilter_Click">
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

    <div class="post d-flex flex-column-fluid" id="kt_post">
        <div id="kt_content_container" class="col-lg-12">
            <div class="col-xl-12">
                <asp:PlaceHolder runat="server" ID="pnlstartmessage">
                <div class="card col-xl-12">
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2">
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Please Select One Route to Continue.</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </asp:PlaceHolder>
            </div>
            <div class="row g-5 g-xl-8" style="margin-top: 0px;">
                <asp:PlaceHolder runat="server" ID="pnlVisit">
                <div class="col-xl-6 row">
                    <div class="col-xl-6" style="margin-top: 0px;">
                        <asp:LinkButton ID="PlannedVisits" runat="server" OnClick="PlannedVisits_Click" CausesValidation="true">
                            <!--begin::Charts Widget 3-->
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5">
                                    <h6 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Planned Service Job</span>
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
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Actual Service Job</span>
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
                </asp:PlaceHolder>
                <asp:PlaceHolder runat="server" ID="pnlSale">
                <div class="col-xl-6 row px-6">
                        <div class="card card-xl-stretch mb-5 mb-xl-8">
                                        <!--begin::Header-->
                                        <div class="card-header border-0 pt-5">
                                            <asp:LinkButton ID="LinkInvAmount" Style="font-family: 'Segoe UI';" runat="server" OnClick="salessummary_Click">
                                            <h3 class="card-title fw-bold text-dark" style="font-family: 'Segoe UI';">
                                                Total Invoice Amount</h3></asp:LinkButton>
                                            <div class="card-toolbar">
                                                <h3 class="card-title fw-bold text-dark mr-5" style="font-family: 'Segoe UI';">
                                                    <asp:Label ID="lblTotalInvAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h3>
                                            </div>
                                        </div>
                                        <!--end::Header-->
                                        <!--begin::Body-->
                                        <div class="col-lg-12 row pt-15" style="padding-left: 5%">
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
                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Hard Cash</span>
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

                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">POS</span>
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <!--end::Lable-->
                                            </div>

                                            <div class="d-flex align-items-center border-1 rounded p-2 mb-3  col-lg-6 pt-5" style="border-width: 2px !important;">
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

                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Online Payment</span>
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <!--end::Lable-->
                                            </div>
                                            <!--end::Item-->
                                            <!--begin::Item-->

                                            <div class="d-flex align-items-center border-1 rounded p-2 mb-3 col-lg-6 pt-5" style="border-width: 2px !important;">
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

                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Credit</span>
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                                </div>
                                                <!--end::Title-->
                                                <!--begin::Lable-->
                                                <!--end::Lable-->
                                            </div>

                                        </div>
                                        <!--end::Body-->
                                    </div>
                    </div>
                </asp:PlaceHolder>
                 <asp:PlaceHolder runat="server" ID="pnlload">  
                <div class="col-xl-6 row">
                    <div class="col-xl-12">
                        <!--begin::Charts Widget 3-->
                        <asp:LinkButton ID="LoadIn" runat="server" OnClick="LoadIn_Click">
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5 my-1">

                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Load In</span>
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
                                    <div class="col-xl-6 pt-5">

                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-3">
                                                <img src="../assets/media/dashboard/KPI/Pills/Rectangle -1.png" height="20" />
                                            </div>
                                            <div class="col-lg-6">

                                                <small style="font-family: 'Segoe UI';">LI Completed</small>
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

                                                <small style="font-family: 'Segoe UI';">LI Pending Approval</small>
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

                                                <small style="font-family: 'Segoe UI';">LI Not Processed</small>
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

                                                <small style="font-family: 'Segoe UI';">LI Rejected</small>
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
                </div>
                <div class="col-xl-6 row">
                    <div class="col-xl-12 row" style="margin-top: 0px;">
                        <asp:LinkButton runat="server" ID="lnkLT" Style="font-family: 'Segoe UI';" OnClick="lnkLT_Click" CausesValidation="true">
                         <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center" style="padding-left: 10px;">
                                 Load Transfer </h3></asp:LinkButton>
                            <div class="col-xl-6">
                                <div class="card card-xl-stretch my-5">
                                    <div class="d-flex align-items-center rounded p-2 my-10">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5 mx-2">
                                            <img src="../assets/media/dashboard/KPI/gs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2 ">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Good Stock</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lblLTGoodStock" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card card-xl-stretch my-5">
                                    <div class="d-flex align-items-center rounded p-2 my-10">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5 mx-2">
                                            <img src="../assets/media/dashboard/KPI/bs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Bad Stock</h6>
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

                        
                        
                    <div class="col-xl-12 row mb-10" style="margin-top: 0px;">
                        <asp:LinkButton runat="server" ID="Lnlvantovan" Style="font-family: 'Segoe UI';" onclick="Lnlvantovan_Click" CausesValidation="true">
                            <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="padding-left: 5px;">  Van to Van Transfer </h3></asp:LinkButton>
                            <div class="col-xl-6" >
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2 my-10">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5 mx-2">
                                            <img src="../assets/media/dashboard/KPI/gs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Transfer In</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lbltrnIn" Style="font-family: 'Segoe UI';" runat="server">0</asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2 my-10">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5 mx-2">
                                            <img src="../assets/media/dashboard/KPI/bs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Transfer Out</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lbltrnOut" Style="font-family: 'Segoe UI';" runat="server">0</asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                <div class="col-lg-12 row">
                     <div class="col-lg-6">
                         <asp:LinkButton runat="server" ID="LnkInventoryRec" Style="font-family: 'Segoe UI';" OnClick="LnkInventoryRec_Click"  CausesValidation="true">
                            <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center" style="padding-left: 5px;"> Inventory Reconfirmation </h3></asp:LinkButton>
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8 py-3" >
                            <div class=" card-xl-stretch m-3">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/KPI/irc.png" height="24" width="24" />
                                            <%--<img src="../assets/media/dashboard/orderreq2.png" class="w-30px me-6" alt="">--%>
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Inventory  Reconfirmation Transaction</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12">
                                           <asp:Label ID="lblreconfirmation" Style="font-family: 'Segoe UI';" runat="server">0</asp:Label>
                                        </span>


                                    </div>
                                </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                                <asp:LinkButton runat="server" ID="LinkLO" OnClick="lnkLT_Click" CausesValidation="true">
                        <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center " style="padding-left: 10px;">Load Out</h3></asp:LinkButton>
                        <div class="col-xl-12 row" style="margin-top: 0px;">
                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5">
                                            <img src="../assets/media/dashboard/KPI/gs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Good Stock</h6>
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
                                                <span class="svg-icon svg-icon-1 me-3 my-2">
                                                    <asp:PlaceHolder ID="pnlGDEndGreen" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="pnlGDEndRed" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2 pt-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">End Stk</h6>
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
                                                <div class="flex-grow-1 me-2 pt-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">Offload</h6>
                                                </div>
                                                <!--end::Title-->

                                            </div>
                                        </div>
                                        <div class="col-xl-3">
                                            <div class="d-flex align-items-center rounded p-2">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                                <span class="svg-icon svg-icon-1 me-3 my-2">
                                                    <asp:PlaceHolder ID="pnlGDAdjGreen" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/check-mark@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                    <asp:PlaceHolder ID="pnlGDAdjRed" runat="server" Visible="false">
                                                        <img src="../assets/media/dashboard/KPI/exclamation@2x.png" height="14" width="14" />
                                                    </asp:PlaceHolder>
                                                </span>
                                                <!--end::Svg Icon-->
                                                <!--begin::Title-->
                                                <div class="flex-grow-1 me-2 pt-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">Adj</h6>
                                                </div>
                                                <!--end::Title-->

                                            </div>
                                        </div>
                                    </div>

                                </div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <span class="svg-icon svg-icon-1 me-5">
                                            <img src="../assets/media/dashboard/KPI/bs@2x.png" height="24" width="24" />
                                        </span>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2 pt-2">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Bad Stock</h6>
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
                                                <div class="flex-grow-1 me-2 pt-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">Offload</h6>
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
                                                <div class="flex-grow-1 me-2 pt-2">
                                                    <h6 href="#" class="fw-bold text-grey-200 text-hover-primary fs-9" style="font-family: 'Segoe UI';">Adj</h6>
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
                </div>
                     </asp:PlaceHolder>
                <asp:PlaceHolder runat="server" ID="pnlAssetTrackingandServiceReq">
                <div class="col-xl-12 row">
                    <asp:LinkButton ID="AssetTrack" runat="server" OnClick="AssetTrack_Click">
                        <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="padding-left: 0px;"> Asset Tracking</h3></asp:LinkButton>
                        <div class="col-xl-4">
                                <div class="card">
                                    <div class="d-flex align-items-center rounded p-2 py-5">
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2 mx-5 ">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Visited</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lblAssetVisited" Style="font-family: 'Segoe UI';" runat="server">0</asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4">
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2 py-5">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2 mx-5">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Tracked</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lblAssetTracked" Style="font-family: 'Segoe UI';" runat="server">0</asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-xl-4" >
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2 py-5">
                                        
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2 mx-5">
                                            <h6 href="#" class="fw-bold text-grey-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Not Tracked</h6>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <h6 class="fw-bold py-1">
                                            <asp:Label ID="lblAssetNotTracked" Style="font-family: 'Segoe UI';" runat="server">0</asp:Label></h6>
                                        <!--end::Lable-->
                                    </div>
                                </div>
                            </div>
                    </div>
                    
                <div class="col-xl-12 row">
                        <div class="col-xl-6 pt-10 pb-10">
                            <asp:LinkButton ID="LinkButton3" runat="server" OnClick="lnkAssetAddingRequest_Click">
                             <div class="card card-flush" style="height: 150%; background-color: #D6ECD6;">
                                    <div class="card-header border-0 ">

                                        <h3 class="card-title align-items-start flex-column ">
                                            <span class="card-label fw-bold  fs-3">
                                                <asp:Label ID="lblAssetAddingRequest" runat="server" Text="0" style=" font-size: 20px;"  class="text-gray-700" ></asp:Label>
                                            </span>
                                            <span class="text-gray-700 mt-1 fw-semibold fs-4 ">Asset Adding Request</span>
                                        </h3>
                                        <!--begin::Toolbar-->
                                        <div class="card-toolbar">
                                            <img src="../assets/media/dashboard/add.svg" height="40" width="40" />
                                        </div>
                                        <!--end::Toolbar-->

                                    </div>
                            </div>
                           </asp:LinkButton>
                        </div>
                        <div class="col-xl-6 pt-10 pb-10">
                            <asp:LinkButton ID="LinkButton4" runat="server" OnClick="lnkAssetRemovalRequest_Click">
                            <div class="card card-flush" style="height: 150%; background-color: #F6DFDF;" >

                                <!--begin::Header-->
                                <div class="card-header border-0 ">
                                    <h3 class="card-title align-items-start flex-column me-5">
                                        <span class="card-label fw-bold text-dark fs-2">
                                            <asp:Label ID="lblAssetRemovalRequest" runat="server" Text="0" style=" font-size: 20px;"  class="text-gray-700"></asp:Label></span>
                                        <span class="text-gray-700 mt-1 fw-semibold fs-4">Asset Removal Requests</span>
                                    </h3>
                                    <!--begin::Toolbar-->
                                    <div class="card-toolbar">
                                    <img src="../assets/media/dashboard/remove.svg" height="40" width="40" />


                                    </div>
                                    <!--end::Toolbar-->
                                </div>
                            </div>
                                </asp:LinkButton>
                        </div>
                    </div>
                    </asp:PlaceHolder>
                <asp:PlaceHolder runat="server" ID="pnlServiceRequest">
                <div class="col-xl-12 row">
                        <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="padding-left: 25px;"> Service Requests</h3>
                        <div class="col-lg-6">
                            <asp:LinkButton ID="LinkButton2" runat="server" OnClick="lnkServiceRequest_Click">
                        <div class="card bgi-no-repeat  mb-lg-8" style="background-color:white;  background-size: 100% 100%; border-radius: 12px;">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                       

                                        <div class="flex-grow-1 me-6">
                                            <span  class="text-gray-700  ms-4 fw-semibold fs-4 d-block" style="font-weight: bold;">Open Service Requests</span>
                                        </div>

                                        <span class="text-white fs-4 fw-bold py-1 me-12"><span id="MainContent_lblSalesOrd">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label class ="text-gray-700" runat="server" ID="lblOpenServiceReqCount" Text="0"  style="font-size: 20px;"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>


                                    </div>
                                </div>
                        </div>
                           </asp:LinkButton>
                    </div>
                    <div class="col-lg-6 ">
                        <asp:LinkButton ID="lnkServiceRequest" runat="server" OnClick="lnkServiceRequest_Click">
                        <div class="card bgi-no-repeat  mb-lg-8" style="background-color:white; background-size: 100% 100%; border-radius: 12px;">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-gray-700  ms-4 fw-semibold fs-4 d-block" style="font-weight: bold;">Completed Service Request</span>
                                        </div>

                                        <span class="text-white fs-4 fw-bold py-1 me-12">
                                            <span id="MainContent_lblrotDeliverys">
                                            <asp:Label class ="text-gray-700" runat="server" ID="lblCompReqCount" Text="0"  style="font-size: 20px;"></asp:Label>
                                        </span></span>

                                    </div>
                                </div>
                        
                        </div>
                            </asp:LinkButton>
                    </div>
                    </div>
                    </asp:PlaceHolder>
                <asp:PlaceHolder runat="server" ID="pnlTimeline">
                <!--Begin:TimeLine-->
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-body" style="padding: 1rem 2rem;">
                            <div class="py-2">
                                <div class="col-lg-12 row">

                                    <div class="col-lg-3">
                                        <!--begin::Item-->
                                        <div class="d-flex flex-stack">
                                            <div class="col-lg-12 row" style="border-right: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">Start Day</span>
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
                                            <div class="col-lg-12 row" style="border-right: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">Load Out</span>
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
                                            <div class="col-lg-12 row" style="border-right: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">App Process</span>
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
                                            <div class="col-lg-12 row" style="border-right: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">Settlement</span>
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
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">End Day</span>
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
                                            <div class="col-lg-12 row" style="border-right: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">Spend With Customer</span>
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
                                            <div class="col-lg-12 row" style="border-right: 1px solid;">
                                                <div class="col-lg-12">
                                                    <span style="font-weight: 500; font-family: 'Segoe UI';">Total Time Duration</span>
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
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="d-flex flex-stack" OnClick="lnkTimeline_Click">
                                            <div class="col-lg-12" style="text-align: right;">
                                                <div class="d-flex justify-content-end">
                                                    <div class="d-flex">
                                                        <img src="../assets/media/dashboard/timeline.png" class="w-40px me-6" alt="" />
                                                        <div class="d-flex flex-column" style="padding-top: 8px;">
                                                            <div class="fs-6 fw-semibold" style="color: black; font-family :'Segoe UI';">View Timeline</div>
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
                </asp:PlaceHolder>

                <asp:PlaceHolder runat="server" ID="pnlSettlement">
                <!--Begin:Settlement-->
                <div class="col-xl-12 row" style="margin-top: 30px;">
                    <h1 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="font-family: 'Segoe UI';">Settlement Details</h1>
                    <div class="col-xl-8 row">
                        <div class="col-xl-4">
                            <!--begin::List Widget 1-->
                            <div class="card card-xl-stretch mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5" style="border-bottom: 1px solid;">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="text-muted mt-1 fw-semibold fs-7" style="font-family: 'Segoe UI';">Total Cash</span>
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
                                            <a href="#" class="text-muted fw-bold" style="font-family: 'Segoe UI';">Hard Cash</a>
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
                                            <a href="#" class="text-muted fw-bold" style="font-family: 'Segoe UI';">Online Payment</a>
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
                                            <a href="#" class="text-muted fw-bold" style="font-family: 'Segoe UI';">POS</a>
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
                                        <span class="mt-1 fw-semibold fs-7" style="color: white; font-family: 'Segoe UI';">Total Collected</span>
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
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">Hard Cash</a>
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
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">Online Payment</a>
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
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">POS</a>
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
                                        <span class="mt-1 fw-semibold fs-7" style="color: white; font-family: 'Segoe UI';">Total Varience</span>
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
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">Hard Cash</a>
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
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">Online Payment</a>
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
                                            <a href="#" class="fw-bold" style="color: white; font-family: 'Segoe UI';">POS</a>
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
                                    <small style="font-weight: bold; font-family: 'Segoe UI';">Total Cheque</small>
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
                                                            <asp:Label ID="lblBnkName" Style="font-family: 'Segoe UI';" Text='<%# Eval("BankName") %>' runat="server"></asp:Label></span>
                                                    </div>
                                                    <div class="d-flex flex-stack">
                                                        <span class="text-black-400">
                                                            <asp:Label ID="lblDate" Style="font-family: 'Segoe UI';" Text='<%# Eval("ChequeDate") %>' runat="server"></asp:Label></span>

                                                        <span class="badge badge-light-success">
                                                            <asp:Label ID="lblType" Style="font-family: 'Segoe UI';" Text='<%# Eval("Type") %>' runat="server"></asp:Label>
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
                </asp:PlaceHolder>
            </div>
        </div>
    </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript" src="../assets/Chart.js"></script>


</asp:Content>
