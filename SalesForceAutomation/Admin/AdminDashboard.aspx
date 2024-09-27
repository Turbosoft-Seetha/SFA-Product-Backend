<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="SalesForceAutomation.Admin.AdminDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <link href="assets/style.bundle.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.js"></script>
    <script type="text/javascript" src="assets/Chart.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">

                <div class="" style="background-color: #f2f3f8;">
                    <div class="col-lg-12 row ml-3" style="width: 96%">

                        <div class="kt-portlet__body mb-3 col-lg-12 row" style="padding-left: 0px; padding-top: 0px; padding-bottom: 5px;">
                            <div class="col-lg-12 row">
                                <div class="col-lg-2" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">Date </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdFromData" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"></telerik:RadDatePicker>
                                    </div>
                                </div>


                                <div class="col-lg-2" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">Route </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Filter="Contains"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="dfs" runat="server" ControlToValidate="rdRoute" ForeColor="Red" ErrorMessage="<br/>Please Choose Route"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-3 text-center" style="margin-top: 20px">
                                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                        <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-primary align-self-center">Apply Filter</asp:LinkButton>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center mt-5">
                                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
                                </div>
                            </div>

                        </div>

                        <div class="m-grid__item m-grid__item--fluid col-lg-12 pl-0 pr-0">
                            <div class="row">

                                <%--CUSTOMER VISITS--%>
                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Customer Visits
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="col-lg-12 row" style="padding: 25px">
                                            <div class="col-lg-6">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="CusTotalVisits" width="200" height="300"></canvas>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="CusTotalSchedule" width="200" height="300"></canvas>
                                                </div>
                                            </div>



                                        </div>
                                    </div>
                                </div>



                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Productive Visits
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-portlet__body">
                                            <div class="col-lg-12">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="prdVisits" width="200" height="137"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Target & Goals - DAILY
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="col-lg-12 row " style="padding: 25px">
                                            <div class="col-lg-6">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="DailyQty" width="200" height="300"></canvas>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="DailyAmt" width="200" height="300"></canvas>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Target & Goals - Monthly
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="col-lg-12 row " style="padding: 25px">

                                            <div class="col-lg-6">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="MonthlyQty" width="200" height="300"></canvas>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="MonthlyAmt" width="200" height="300"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Load-In Report
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-portlet__body">
                                            <div class="col-lg-12">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="LoadRprts" width="200" height="137"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Sales Report
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-portlet__body">
                                            <div class="col-lg-12">
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px;">
                                                    <canvas id="salesReport" width="200" height="137"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%--AR COLLECTION--%>
                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">AR Collection
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-portlet__body">
                                            <div class="col-lg-12 row" style="border-style: groove; border-radius: 10px;">
                                                <div class="col-lg-6">
                                                    <canvas id="ARcollection" width="200" height="300"></canvas>
                                                </div>

                                                <div class="col-lg-6" style="margin-top: 15%">

                                                    <div class="col-lg-12">
                                                        <div class="col-lg-12">
                                                            <small>Total Collection</small>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <asp:Label ID="lblTotalAR" runat="server" Font-Size="X-Large" Font-Bold="true" Text="15/4564.00"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                                        <div class="col-lg-3">
                                                            <img src="../Media/chq.png" height="20" />
                                                        </div>
                                                        <div class="col-lg-3">

                                                            <small>Cheque</small>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <asp:Label ID="lblChequeAR" runat="server" Font-Size="Large" Font-Bold="true" Text="15/4564.00"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                                        <div class="col-lg-3">
                                                            <img src="../Media/csh.png" height="20" />
                                                        </div>
                                                        <div class="col-lg-3">

                                                            <small>Cash</small>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <asp:Label ID="lblCashAr" runat="server" Font-Size="Large" Font-Bold="true" Text="15/4564.00"></asp:Label>
                                                        </div>
                                                    </div>


                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%--ADVANCE PAYMENT--%>
                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Advance Collection
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-portlet__body">
                                            <div class="col-lg-12 row" style="border-style: groove; border-radius: 10px;">
                                                <div class="col-lg-6">
                                                    <canvas id="APCollection" width="200" height="300"></canvas>
                                                </div>

                                                <div class="col-lg-6" style="margin-top: 7%">

                                                    <div class="col-lg-12" style="margin-top: 15%">
                                                        <div class="col-lg-12">
                                                            <small>Total Collection</small>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <asp:Label ID="lblAPTotal" runat="server" Font-Size="X-Large" Font-Bold="true"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                                        <div class="col-lg-3">
                                                            <img src="../Media/chq.png" height="20" />
                                                        </div>
                                                        <div class="col-lg-3">

                                                            <small>Cheque</small>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <asp:Label ID="lblAPCheque" runat="server" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                                        <div class="col-lg-3">
                                                            <img src="../Media/csh.png" height="20" />
                                                        </div>
                                                        <div class="col-lg-3">

                                                            <small>Cash</small>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <asp:Label ID="lblAPCash" runat="server" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                        </div>
                                                    </div>


                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <%--TIME DURATION--%>
                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">

                                        <!--begin::Form-->
                                        <div class="kt-portlet__body">
                                            <div class="col-lg-12" style="margin-top: 1%">
                                                <div class="col-lg-12 row">
                                                    <h4>Orders</h4>
                                                </div>
                                                <div class="col-lg-12" style="border-style: groove; border-radius: 10px; display: flex; padding: 15px; border-width: 2px; margin-top: 2%">
                                                    <div class="col-lg-1">
                                                        <img src="../Media/orders.png" height="30" />
                                                    </div>
                                                    <div class="col-lg-10" style="padding-top: 5px">
                                                        <small style="font-weight: bold">Total Orders</small>
                                                    </div>
                                                    <div class="col-lg-1">
                                                        <asp:Label ID="lblTotOrdCount" ForeColor="Black" runat="server" Font-Size="X-Large" Font-Bold="true"></asp:Label>
                                                    </div>

                                                </div>


                                            </div>

                                            <div class="col-lg-12" style="margin-top: 5%">
                                                <div class="col-lg-12 row">
                                                    <h4>Time Duration</h4>
                                                </div>
                                                <div style="border-style: groove; border-radius: 20px; border-width: 2px;">

                                                    <div class="col-lg-12" style="border-bottom-style: groove; display: flex; padding: 15px; border-width: 2px;">


                                                        <div class="col-lg-9" style="padding-top: 5px">
                                                            <small style="font-weight: bold">Total Working Hours</small>
                                                        </div>

                                                        <div class="col-lg-3 text-right">
                                                            <asp:Label ID="lblHours" runat="server" ForeColor="Black" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                        </div>



                                                    </div>

                                                    <div class="col-lg-12" style="display: flex; padding-top: 10px">
                                                        <div class="col-lg-4">
                                                            <div class="col-lg-12">
                                                                <small style="font-weight: bold">Start Day</small>
                                                            </div>
                                                            <div class="col-lg-12" style="margin-top: 2%">

                                                                <asp:Label ID="lblStartTime" runat="server" ForeColor="Black" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-4" style="padding-top: 5px">
                                                            <div class="col-lg-12 text-right">
                                                                <small style="font-weight: bold">Spend with Customer</small>
                                                            </div>
                                                            <div class="col-lg-12 text-right " style="margin-top: 2%">
                                                                <asp:Label ID="lblSpendWithCus" runat="server" ForeColor="Black" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-4" style="padding-top: 5px">
                                                            <div class="col-lg-12 text-right">
                                                                <small style="font-weight: bold">End Day</small>
                                                            </div>
                                                            <div class="col-lg-12 text-right " style="margin-top: 2%">
                                                                <asp:Label ID="lblEndTime" runat="server" ForeColor="Black" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>

                                            </div>


                                            <div class="col-lg-12" style="margin-top: 7%">
                                                <div class="col-lg-12 row">
                                                    <h4>Settlement Report</h4>
                                                </div>
                                                <div style="border-style: groove; border-radius: 20px; border-width: 2px;">

                                                    <div class="col-lg-12" style="border-bottom-style: groove; display: flex; padding: 15px; border-width: 2px;">


                                                        <div class="col-lg-9" style="padding-top: 5px">
                                                            <small style="font-weight: bold">Total Invoices</small>
                                                        </div>

                                                        <div class="col-lg-3 text-right">
                                                            <asp:Label ID="lblTotInvs" runat="server" ForeColor="Black" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                        </div>



                                                    </div>

                                                    <div class="col-lg-12" style="display: flex; padding-top: 10px">
                                                        <div class="col-lg-8">
                                                            <div class="col-lg-12">
                                                                <small style="font-weight: bold">Cash Invoices</small>
                                                            </div>
                                                            <div class="col-lg-12" style="margin-top: 2%">

                                                                <asp:Label ID="lblCashInvs" runat="server" ForeColor="Black" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-4" style="padding-top: 5px">
                                                            <div class="col-lg-12 text-right">
                                                                <small style="font-weight: bold">Credit Invoices</small>
                                                            </div>
                                                            <div class="col-lg-12 text-right" style="margin-top: 2%">
                                                                <asp:Label ID="lblCrInvs" runat="server" ForeColor="Black" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>



                                            <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px; border-style: groove; border-radius: 14px; margin-top: 7%; margin-left: 2%; margin-right: 2%;">
                                                <div class="kt-portlet__head-label">
                                                    <h3 class="kt-portlet__head-title" style="font-weight: 800; color: black">Track the user
                                                    </h3>
                                                </div>
                                                <div class="kt-portlet__head-actions">
                                                    <telerik:RadAjaxPanel ID="maps" runat="server">
                                                        <asp:ImageButton ID="map" Visible="true" AlternateText="Map" runat="server" Height="35" OnClick="map_Click"
                                                            ImageUrl="assets/media/icons/svg/General/map.png"></asp:ImageButton>
                                                    </telerik:RadAjaxPanel>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet" style="min-height: 486px">
                                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title">Collection Report
                                                </h3>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-portlet__body">
                                            <div class="col-lg-12">
                                                <div style="border-style: groove; border-radius: 20px; border-width: 2px;">

                                                    <div class="col-lg-12" style="border-bottom-style: groove; display: flex; padding: 15px; border-width: 2px;">


                                                        <div class="col-lg-9" style="padding-top: 5px">
                                                            <small style="font-weight: bold">Total Cash</small>
                                                        </div>

                                                        <div class="col-lg-3 text-right">
                                                            <asp:Label ID="lblTotalCash" runat="server" ForeColor="Black" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                        </div>



                                                    </div>

                                                    <div class="col-lg-12" style="display: flex; padding-top: 10px; padding-bottom: 10px">
                                                        <div class="col-lg-4">
                                                            <div class="col-lg-12">
                                                                <small style="font-weight: bold">AR Cash</small>
                                                            </div>
                                                            <div class="col-lg-12" style="margin-top: 2%">

                                                                <asp:Label ID="lblARCash" runat="server" ForeColor="Black" Font-Bold="true" Font-Size="Medium"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <div class="col-lg-12">
                                                                <small style="font-weight: bold">Advance Cash</small>
                                                            </div>
                                                            <div class="col-lg-12" style="margin-top: 2%">

                                                                <asp:Label ID="lblAdvanceCash" runat="server" ForeColor="Black" Font-Bold="true" Font-Size="Medium"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <div class="col-lg-12 text-right">
                                                                <small style="font-weight: bold">Cash Invoices</small>
                                                            </div>
                                                            <div class="col-lg-12 text-right " style="margin-top: 2%">
                                                                <asp:Label ID="lblCashInnvoice" runat="server" ForeColor="Black" Font-Bold="true" Font-Size="Medium"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>

                                                <div style="border-style: groove; border-radius: 20px; border-width: 2px; margin-top: 25px;">

                                                    <div class="col-lg-12" style="border-bottom-style: groove; display: flex; padding: 15px; border-width: 2px;">


                                                        <div class="col-lg-9" style="padding-top: 5px">
                                                            <small style="font-weight: bold">Total Cheque</small>
                                                        </div>

                                                        <div class="col-lg-3 text-right">
                                                            <asp:Label ID="lblTotalCheque" runat="server" ForeColor="Black" Font-Size="Large" Font-Bold="true"></asp:Label>
                                                        </div>



                                                    </div>

                                                    <div class="col-lg-12" style="border-bottom-style: groove; display: flex; padding-top: 10px; padding-bottom: 10px; border-width: 2px;">
                                                        <div class="col-lg-6">
                                                            <div class="col-lg-12">
                                                                <small style="font-weight: bold">AR Cheque</small>
                                                            </div>
                                                            <div class="col-lg-12" style="margin-top: 2%">

                                                                <asp:Label ID="lblARCheque" runat="server" ForeColor="Black" Font-Bold="true" Font-Size="Medium"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 text-right">
                                                            <div class="col-lg-12">
                                                                <small style="font-weight: bold">Advance Cheque</small>
                                                            </div>
                                                            <div class="col-lg-12" style="margin-top: 2%">

                                                                <asp:Label ID="lblAdvanceCheque" runat="server" ForeColor="Black" Font-Bold="true" Font-Size="Medium"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="card card-flush h-xl-100" style="border-radius: 20px;">
                                                        <div class="card-body">
                                                            <div class="hover-scroll-overlay-y pe-6 me-n6" style="height: 13rem">
                                                                <asp:Repeater runat="server" ID="rptCheque">
                                                                    <ItemTemplate>
                                                                        <div class="rounded border-gray-300 border-1 border-gray-300 border-dashed px-7 py-3 mb-6">
                                                                            <div class="d-flex flex-stack mb-3">
                                                                                <span class="text-black-400 fw-bolder">
                                                                                    <asp:Label ID="lblChqNo" Text='<%# Eval("ChequeNo") %>' runat="server"></asp:Label></span>
                                                                                <span class="badge text-gray-400 fw-bolder">
                                                                                    <asp:Label ID="lblBnkName" Text='<%# Eval("BankName") %>' runat="server"></asp:Label></span>
                                                                            </div>
                                                                            <div class="d-flex flex-stack">
                                                                                <span class="text-black-400 fw-bolder">
                                                                                    <asp:Label ID="lblDate" Text='<%# Eval("ChequeDate") %>' runat="server"></asp:Label></span>

                                                                                <span class="badge badge-light-success">
                                                                                    <asp:Label ID="lblType" Text='<%# Eval("Type") %>' runat="server"></asp:Label>
                                                                                    -
                                                                            <asp:Label ID="lblAmount" Text='<%# Eval("Amount") %>' runat="server"></asp:Label></span>
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
                                    </div>

                                </div>
                                <%--TOTAL ORDERS SECTION--%>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
