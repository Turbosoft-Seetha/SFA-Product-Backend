<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteSalesDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteSalesDashboard" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <link href="../assets/style.bundle.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />

</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <asp:LinkButton ID="btnVanStock" runat="server" CssClass="btn btn-sm  btn-primary" CausesValidation="true" OnClick="btnVanStock_Click">
                                                    Current Van Stock
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
                    <div class="col-lg-12 row pt-8 mb-4">
                        

                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" Width="80%" ID="rdfromDate" AutoPostBack="true" runat="server" DateInput-DateFormat="dd-MM-yyyy" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                                              <div class="col-lg-3">
    <label class="control-label col-lg-12">Route Type</label>
    <div class="col-lg-12">
        <telerik:RadComboBox ID="ddlRotType" Width="80%" runat="server" EmptyMessage="Select Route Type" Filter="Contains" RenderMode="Lightweight" OnSelectedIndexChanged="ddlRotType_SelectedIndexChanged" AutoPostBack="true">
             <Items>
                <telerik:RadComboBoxItem Text="All" Value="AL" />
                <telerik:RadComboBoxItem Text="Sales" Value="SL" Selected="true"/>
                <telerik:RadComboBoxItem Text="Order" Value="OR"/>
                <telerik:RadComboBoxItem Text="AR" Value="AR"/>
                <telerik:RadComboBoxItem Text="Order & AR" Value="OA"/>
                <telerik:RadComboBoxItem Text="Delivery" Value="DL"/>
                <telerik:RadComboBoxItem Text="Merchandising" Value="MER"/>
                <telerik:RadComboBoxItem Text="Field Services" Value="FS"/>                                       
            </Items>
        </telerik:RadComboBox>
    </div>
</div>
                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">Route</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="rdRoute" runat="server" Width="80%" EmptyMessage="Select Route" Filter="Contains" RenderMode="Lightweight" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">                                
                                </telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-2" style="text-align: center; padding-top: 10px; padding-left: 0px;">
                            <asp:LinkButton ID="lnkFilter" runat="server" Width="80%" CssClass="btn btn-sm btn-primary me-2 myLink" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="true" OnClick="lnkFilter_Click">
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

        <div id="kt_content_container" class="col-lg-12 row">

            <div class="col-xl-12">
                <asp:PlaceHolder runat="server" ID="pnlstartmessage" Visible="true">
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
                <%-- Planned and Actual Visit starts --%>
               
                <div class="col-xl-6 row">
                    <div class="col-xl-6" style="margin-top: 0px;">
                        <asp:LinkButton ID="PlannedVisits" runat="server" OnClick="PlannedVisits_Click" CausesValidation="true">
                            <!--begin::Charts Widget 3-->
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5">
                                    <h6 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Planned Visits</span>
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
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Actual Visits</span>
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
                   
                <%-- Planned and Actual Visit Ends --%>

                <%-- Productive and Non-Productive  Starts --%>

                <div class="col-xl-6" style="margin-top: 0px;">
                    <div class="col-xl-12">
                        <asp:LinkButton ID="Productivevisits" runat="server" OnClick="Productivevisits_Click" CausesValidation="true">
                            <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-color: #6397b2; background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                                <div class="col-xl-12 row pt-9">
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600; font-family: 'Segoe UI';">Productive
                                        <br />
                                            Visits</h6>
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
                                        <h6 style="color: white; font-weight: 600; font-family: 'Segoe UI';">Non Productive
                                        <br />
                                            Visits</h6>
                                    </div>
                                </div>
                                <div class="col-xl-12 row py-10">
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblProductivePlanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="btn btn-primary" style="width: 100%; font-family: 'Segoe UI';background-color:#0AC4FF";">Planned</div>
                                    </div>
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblNonProductivePlanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                </div>
                                <div class="col-xl-12 row pt-5 pb-14">
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblProductiveUnplanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="btn btn-warning" style="width: 100%; font-family: 'Segoe UI'; background-color:#EEA74E";>Unplanned</div>
                                    </div>
                                    <div class="col-xl-3" style="text-align: center;">
                                        <h6 style="color: white; font-weight: 600;">
                                            <asp:Label ID="lblNonProductiveUnplanned" runat="server" Style="font-family: 'Segoe UI';"></asp:Label></h6>
                                    </div>
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>


                </div>

                <%-- Productive and Non-Productive  Ends --%>
               </asp:PlaceHolder>

               
                <%-- Target and Deliveries  Strats --%>

            <%--    <div class="col-xl-12 row">--%>
                     <asp:PlaceHolder runat="server" ID="pnlTarget">
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <div class="card card-xl-stretch mb-xl-2">
                            <!--begin::Header-->
                            <div class="card-header border-0 pt-5">
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">
                                        <asp:LinkButton ID="lnkTarget" runat="server" OnClick="lnkTarget_Click" CausesValidation="true" Style="font-family: 'Segoe UI';">
                                                  Target
                                        </asp:LinkButton></span>
                                </h3>



                                <div class="card-toolbar">

                                    <div class="w3-row">
                                        <a href="javascript:void(1)" onclick="openPerforming(event, 'Route');" >
                                            <div class="w3-third tablinks w3-bottombar  w3-padding" style="width: 65px; font-family: 'Segoe UI';" hidden="hidden"></div>
                                        </a>
                                        <a href="javascript:void(1)" onclick="openPerforming(event, 'Customer');" id="defaultOpenPerforming">
                                            <div class="w3-third tablinks w3-bottombar w3-hover-light-grey w3-padding" style="width: 84px; font-family: 'Segoe UI';">Monthly</div>
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
                     </asp:PlaceHolder>

                <asp:PlaceHolder runat="server" ID="pnlOutstanding">
                <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <asp:LinkButton ID="lnkOutstanding" runat="server" OnClick="lnkOutstanding_Click">
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5">

                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Outstanding</span>
                                    </h3>
                                    <div class="card-toolbar">
                                        <h6 class="card-title align-items-start flex-column">
                                            <span class="card-label fw-bold fs-3 mb-1">
                                                <asp:Label ID="lblOutstanding" runat="server" Style="font-family: 'Segoe UI';"></asp:Label>/
                                                <asp:Label ID="lblOutstandingAmt" runat="server" Style="font-family: 'Segoe UI';" Text="0.00"></asp:Label>
                                            </span>
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
                                                <canvas id="OutstandingRprts"></canvas>
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
                                            <div class="col-lg-3">

                                                <small style="font-family: 'Segoe UI';">Due</small>
                                            </div>
                                            <div class="col-lg-6 d-flex justify-content-end">
                                                <asp:Label ID="lblDue" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                                 <span class="card-label fw-bold fs-3 px-2">/</span>
                                                 <asp:Label ID="lblDueAmt" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0.00"></asp:Label>
                                            </div>
                                        </div>
                                      
                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-3">
                                                <img src="../assets/media/dashboard/KPI/Pills/li_completed.png" height="20" />
                                            </div>
                                            <div class="col-lg-3">

                                                <small style="font-family: 'Segoe UI';">OverDue</small>
                                            </div>
                                            <div class="col-lg-6 d-flex justify-content-end">
                                                <asp:Label ID="lblOverdue" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                                <span class="card-label fw-bold fs-3 px-2">/</span>
                                                 <asp:Label ID="lblOverdueAmt" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0.00"></asp:Label>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                            </div>
                        </asp:LinkButton>
                        <!--end::Charts Widget 3-->
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder runat="server" ID="pnlSale">
                <%-- Sales and Invoices  Satrts --%>

                <div class="col-xl-12 mt-4">

                    <!--begin::Charts Widget 3-->

                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                        <div class="col-xl-12 row">
                            <asp:PlaceHolder ID="pnlsalechart" runat="server">
                            <div class="col-xl-6">
                                <asp:LinkButton ID="salessummary" runat="server" OnClick="salessummary_Click">
          
                    <div class="card-header border-0 pt-5">
                     <h3 class="card-title align-items-start flex-column">
                         <span class="card-label fw-bold fs-3 mb-1" style="font-family:'Segoe UI';"></span>Sales Summary
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
                                </asp:PlaceHolder>

                            <div class="col-xl-6 row">
                              <asp:PlaceHolder ID="pnlInvoices" runat="server">


                                <div class="col-xl-12">
                                    <!--begin::List Widget 6-->
                                    <div class="card card-xl-stretch mb-5 mb-xl-8 mt-5">
                                        <!--begin::Header-->
                                        <div class="card-header border-0" style="min-height: 45px !important">
                                            <h3 class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">
                                                <asp:LinkButton ID="LinkInv" runat="server" OnClick="salessummary_Click"> Invoices</asp:LinkButton></h3>
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
                                                    <a href="#" class="fw-bold text-dark-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Sales</a>

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
                                                    <a href="#" class="fw-bold text-dark-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Good Return</a>
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
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Bad Return</a>

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
                                                    <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6" style="font-family: 'Segoe UI';">Free Of Cost</a>
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
                                  </asp:PlaceHolder>
                                <div class="col-xl-12">
                                    <!--begin::List Widget 6-->
                                    <div class="card card-xl-stretch mb-5 mb-xl-8">
                                        <!--begin::Header-->
                                        <div class="card-header border-0">
                                            <h3 class="card-title fw-bold text-dark" style="font-family: 'Segoe UI';">
                                                <asp:LinkButton ID="LinkInvAmount" Style="font-family: 'Segoe UI';" runat="server" OnClick="salessummary_Click">Total Invoice Amount</asp:LinkButton></h3>
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

                                                    <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Online Payment</span>
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
                                    <!--end::List Widget 6-->
                                </div>


                            </div>

                        </div>

                    </div>

                    <!--end::Charts Widget 3-->
                </div>

                <%-- Sales and Invoices  Ends --%>
                </asp:PlaceHolder>
                
                <asp:PlaceHolder runat="server" ID="pnlAR">
                    <div class="col-xl-6">
                        <!--begin::Charts Widget 3-->
                        <asp:LinkButton ID="LinkButton4" runat="server" OnClick="inkAR_Click">
                            <div class="card card-xl-stretch mb-5 mb-xl-8">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-5">

                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Total AR Collection</span>
                                    </h3>
                                    <div class="card-toolbar">
                                        <h6 class="card-title align-items-start flex-column">
                                            <span class="card-label fw-bold fs-3 mb-1">
                                                <asp:Label ID="lblARCount" runat="server" Style="font-family: 'Segoe UI';"></asp:Label>
                                                /<asp:Label ID="lblARAmount" runat="server" Style="font-family: 'Segoe UI';"></asp:Label>
                                            </span>
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
                                                <canvas id="TotalARCollectionRprts"></canvas>
                                                <!--end::Chart-->
                                            </div>
                                        </div>
                                        <!--end::Body-->
                                    </div>
                                    <div class="col-xl-6" style="padding-top: 4rem;">

                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-2">
                                                <img src="../assets/media/dashboard/KPI/Pills/Rectangle -1.png" height="20" />
                                            </div>
                                            <div class="col-lg-4">

                                                <small style="font-family: 'Segoe UI';">Hard Cash</small>
                                            </div>
                                            <div class="col-lg-6">
                                                <asp:Label ID="lblHCCount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                                / <asp:Label ID="lblHCAmount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0.00"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-2">
                                                <img src="../assets/media/dashboard/KPI/Pills/Rectangle 517.png" height="20" />
                                            </div>
                                            <div class="col-lg-4">

                                                <small style="font-family: 'Segoe UI';">Online Payment</small>
                                            </div>
                                            <div class="col-lg-6">
                                                <asp:Label ID="lblOPCount" Style="font-family: 'Segoe UI';" runat="server" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                                 / <asp:Label ID="lblOPAmount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0.00"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-2">
                                                <img src="../assets/media/dashboard/KPI/Pills/notprocessed.png" height="20"  />
                                            </div>
                                            <div class="col-lg-4">

                                                <small style="font-family: 'Segoe UI';">POS</small>
                                            </div>
                                            <div class="col-lg-6">
                                                <asp:Label ID="lblPOSCount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                                 / <asp:Label ID="lblPOSAmount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0.00"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                            <div class="col-lg-2">
                                                <img src="../assets/media/dashboard/KPI/Pills/li_completed.png" height="20" />
                                            </div>
                                            <div class="col-lg-4">

                                                <small style="font-family: 'Segoe UI';">Cheque</small>
                                            </div>
                                            <div class="col-lg-6">
                                                <asp:Label ID="lblChequeCount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0"></asp:Label>
                                                 / <asp:Label ID="lblChequeAmount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="Large" Font-Bold="true" Text="0.00"></asp:Label>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                            </div>
                        </asp:LinkButton>
                        <!--end::Charts Widget 3-->
                    </div>
                    <!--End:Total AR Collection Chart-->
               

                <%-- Outstanding and AR  Ends --%>
                 </asp:PlaceHolder>
                     <asp:PlaceHolder runat="server" ID="pnlAdv">
                    <div class="col-xl-6 row mt-8">
                        <div class="col-xl-12" style="display: none;">
                            <!--begin::List Widget 6-->
                            <div class="card card-xl-stretch mb-5 mb-xl-8 py-10">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-2">
                                    <h3 class="card-label fw-bold fs-3 mb-1 ">
                                        <asp:LinkButton ID="inkAR" runat="server" Style="font-family: 'Segoe UI';" OnClick="inkAR_Click" CausesValidation="true">AR Collection</asp:LinkButton></h3>
                                    <div class="card-toolbar">
                                        <h3 class="card-label fw-bold fs-3 mb-1">
                                            <asp:Label ID="lblTotalArAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h3>
                                    </div>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="col-lg-12 row pt-8 mb-12" style="padding-left: 5%">
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
                                            <span class="fw-bold">
                                                <asp:Label ID="lblArPosCount" Style="font-family: 'Segoe UI';" runat="server"></asp:Label>/<asp:Label ID="lblArPosAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></span>

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">POS</span>
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

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Online Payment</span>
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

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Cheque</span>
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
                            <div class="card card-xl-stretch mb-5 mb-xl-8 py-7">
                                <!--begin::Header-->
                                <div class="card-header border-0 pt-8" style="min-height: 45px !important">
                                    <h3 class="card-label fw-bold fs-3 mb-1">
                                        <asp:LinkButton ID="LinkAP" runat="server" Style="font-family: 'Segoe UI';" OnClick="inkAR_Click" CausesValidation="true">Advance Collection</asp:LinkButton></h3>
                                    <div class="card-toolbar">
                                        <h3 class="card-label fw-bold fs-3 mb-1">
                                            <asp:Label ID="lblTotalAdvAmt" Style="font-family: 'Segoe UI';" runat="server"></asp:Label></h3>
                                    </div>
                                </div>
                                <!--end::Header-->
                                <!--begin::Body-->
                                <div class="col-lg-12 row pt-8 mb-12" style="padding-left: 5%">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-12  col-lg-6 pt-8" style="border-width: 2px !important;">
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

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Hard Cash</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-12 col-lg-6 pt-8" style="border-width: 2px !important;">
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

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">POS</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-12  col-lg-6" style="border-width: 2px !important;">
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

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Online Payment</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                    <!--begin::Item-->

                                    <div class="d-flex align-items-center border-1 rounded p-2 mb-12 col-lg-6" style="border-width: 2px !important;">
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

                                            <span class="text-muted fw-semibold d-block" style="font-family: 'Segoe UI';">Cheque</span>
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
                         <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center" style="padding-left: 10px;">
                                <asp:LinkButton runat="server" ID="lnkLT" Style="font-family: 'Segoe UI';" OnClick="lnkLT_Click" CausesValidation="true"> Load Transfer </asp:LinkButton></h3>
                            <div class="col-xl-6">
                                <div class="card card-xl-stretch my-5">
                                    <div class="d-flex align-items-center rounded p-2 my-3">
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
                                    <div class="d-flex align-items-center rounded p-2 my-3">
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
                            <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-5" style="padding-left: 5px;"> 
                        <asp:LinkButton runat="server" ID="Lnlvantovan" Style="font-family: 'Segoe UI';" onclick="Lnlvantovan_Click" CausesValidation="true"> Van to Van Transfer </asp:LinkButton></h3>
                            <div class="col-xl-6" >
                                <div class="card card-xl-stretch">
                                    <div class="d-flex align-items-center rounded p-2 my-4">
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
                                    <div class="d-flex align-items-center rounded p-2 my-4">
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
                            <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center" style="padding-left: 5px;">Inventory Reconfirmation</h3></asp:LinkButton>
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8 py-6" >
                            <div class=" card-xl-stretch m-3">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/KPI/irc.png" height="24" width="24" />
                                            <%--<img src="../assets/media/dashboard/orderreq2.png" class="w-30px me-6" alt="">--%>
                                        </div>

                                        <div class="flex-grow-1 me-6">

                                             <asp:LinkButton runat="server" ID="LinkButton2" Style="font-family: 'Segoe UI'; font-size: large;" OnClick="LnkInventoryRec_Click"  CausesValidation="true">
                                                 Inventory  Reconfirmation Transaction</asp:LinkButton>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12">
                                           <asp:Label ID="lblreconfirmation" Style="font-family: 'Segoe UI';" runat="server">0</asp:Label>
                                        </span>


                                    </div>
                                </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h3 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center " style="padding-left: 10px;">Load Out</h3>
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
                                             <asp:LinkButton runat="server" ID="lnkGoodStock" OnClick="LnkGoodStock_Click" CssClass="fw-bold text-grey-800 text-hover-primary fs-6" Style="font-family: 'Segoe UI';">
                                Good Stock
                            </asp:LinkButton>
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
                                        <div class="flex-grow-1 me-2">
                                            <asp:LinkButton runat="server" ID="lnkBadStock" OnClick="lnkBadStock_Click" CssClass="fw-bold text-grey-800 text-hover-primary fs-6" Style="font-family: 'Segoe UI';">
                                Bad Stock
                            </asp:LinkButton>
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
                </div>

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
                <div class="col-xl-12 pt-8">
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
                                <div class="card-header border-0 pt-5 mb-1" style="border-bottom: 1px solid;">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="text-muted mt-1 fw-semibold fs-7 pb-1" style="font-family: 'Segoe UI';">Total Cash</span>
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
                                            <span class="text-muted fw-bold" style="font-family: 'Segoe UI';">Hard Cash</span>
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
                                            <span class="text-muted fw-bold" style="font-family: 'Segoe UI';">Online Payment</span>
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
                                            <span class="text-muted fw-bold" style="font-family: 'Segoe UI';">POS</span>
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
                                <div class="card-header border-0 pt-5 mb-1" style="border-bottom: 1px solid;">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="mt-1 fw-semibold fs-7 pb-1" style="color: white; font-family: 'Segoe UI';">Total Collected</span>
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
                                            <span class="fw-bold" style="color: white; font-family: 'Segoe UI';">Hard Cash</span>
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
                                            <span class="fw-bold" style="color: white; font-family: 'Segoe UI';">Online Payment</span>
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
                                            <span class="fw-bold" style="color: white; font-family: 'Segoe UI';">POS</span>
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
                                <div class="card-header border-0 pt-5 mb-1" style="border-bottom: 1px solid;">
                                    <h3 class="card-title align-items-start flex-column">
                                        <span class="mt-1 fw-semibold fs-7 pb-1" style="color: white; font-family: 'Segoe UI';">Total Varience</span>
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
                                            <span class="fw-bold" style="color: white; font-family: 'Segoe UI';">Hard Cash</span>
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
                                            <span class="fw-bold" style="color: white; font-family: 'Segoe UI';">Online Payment</span>
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
                                            <span class="fw-bold" style="color: white; font-family: 'Segoe UI';">POS</span>
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

                                <div class="col-lg-7 text-right d-flex justify-content-end">
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

