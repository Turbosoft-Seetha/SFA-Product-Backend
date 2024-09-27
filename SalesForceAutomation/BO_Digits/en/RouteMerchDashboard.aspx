<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteMerchDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteMerchDashboard" %>
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
                <telerik:RadComboBoxItem Text="Sales" Value="SL"/>
                <telerik:RadComboBoxItem Text="Order" Value="OR"/>
                <telerik:RadComboBoxItem Text="AR" Value="AR"/>
                <telerik:RadComboBoxItem Text="Order & AR" Value="OA"/>
                <telerik:RadComboBoxItem Text="Delivery" Value="DL"/>
                <telerik:RadComboBoxItem Text="Merchandising" Value="MER" Selected="true"/>
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

                  <div class="col-xl-6">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                             <asp:LinkButton ID="btnOutOfStk" runat="server" OnClick="btnOutOfStk_Click">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Out Of Stock</span>
                            </h3>
                                 </asp:LinkButton>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <%--<div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalOutOfStock" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/items_oos.png" alt="OOS Items" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkOosItems" runat="server" OnClick="lnkOosItems_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblTotalOosItems" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">OOS Items</div>
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
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/customers_oos.png" alt="OOS Customers" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkOosCustomers" runat="server" OnClick="lnkOosCustomers_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblOosCustomers" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">OOS Customers</div>
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
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#E1AF36, #D27C25); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                             <asp:LinkButton ID="btnItmAvlbty" runat="server" OnClick="btnItmAvlbty_Click">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Item Availability</span>
                            </h3>

                            <!--end::Title-->
                                 </asp:LinkButton>
                            <!--begin::Toolbar-->
                            <%--<div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalItemAvailability" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/items_ia.png" alt="Not Available Items" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNotAvailableItem" runat="server" OnClick="lnkNotAvailableItem_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNotAvailableItems" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Not Available Items</div>
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
                                            <div class="symbol-label bg-white bg-opacity-1" style="width: 60px; height: 60px;">
                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                    <img src="../assets/media/dashboard/customers_ia.png" alt="Not Available Customers" width="34" height="34" />
                                                </span>
                                                <!--end::Svg Icon-->
                                            </div>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNotAvailableCustomers" runat="server" OnClick="lnkNotAvailableCustomers_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNotAvailableCustomers" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Not Available Customers</div>
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

                <div class="col-xl-12 row">
                        <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkSaleOrdiv" OnClick="lnkCustomerInventory_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/pricing.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Customer Inventory</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_lblCustomerInventory">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblCustomerInventory" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white;">
                            <asp:LinkButton runat="server" ID="lnkRotdeliv" OnClick="lnkItemPricing_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/orderreq2.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Item Pricing</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_lblItemPricing">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblItemPricing" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                  </div>

                <div class="col-xl-6" >
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#BCBF52, #B5A11F); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                             <asp:LinkButton ID="lbTasks" runat="server" OnClick="lbTasks_Click">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Tasks</span>
                            </h3>

                            <!--end::Title-->
                                 </asp:LinkButton>
                            <!--begin::Toolbar-->
                            <%--<div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalTasks" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkAssignedTask" runat="server" OnClick="lnkAssignedTask_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblAssignedTask" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Assigned Tasks</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCompletedTasks" runat="server" OnClick="lnkCompletedTasks_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCompletedTasks" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Completed Tasks</div>
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
                <div class="col-xl-6" >
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#F35D82, #CC4868); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                             <asp:LinkButton ID="lbSurvey" runat="server" OnClick="lbSurvey_Click">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Survey</span>
                            </h3>
                                 </asp:LinkButton>
                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <%--<div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalSurvey" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkAssignedSurveys" runat="server" OnClick="lnkAssignedSurveys_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblAssignedSurveys" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Assigned Surveys</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCompletedSurveys" runat="server" OnClick="lnkCompletedSurveys_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCompletedSurveys" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Completed Surveys</div>
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
                <div class="col-xl-6" style="margin-top: 0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#AB73C2, #814698); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                             <asp:LinkButton ID="lbDispAggr" runat="server" OnClick="lbDispAggr_Click">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Display Agreement</span>
                            </h3>
                                 </asp:LinkButton>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <%--<div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblTotalDispAgreement" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNewAgreements" runat="server" OnClick="lnkNewAgreements_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNewAgreements" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">New Agreements</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--end::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkApproved" runat="server" OnClick="lnkApproved_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblApproved" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Approved Agreements</div>
                                            </asp:LinkButton>
                                        </div>
                                        <!--end::Title-->
                                    </div>
                                </div>
                                <!--begin::Col-->
                                <div class="col-4">
                                    <div class="d-flex align-items-center ms-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkActiveAgreements" runat="server" OnClick="lnkActiveAgreements_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblActiveAgreements" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Active Agreements</div>
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

                <div class="col-xl-6" style="margin-top: 0px;">
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#47C581, #2DA566); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                             <asp:LinkButton ID="lbCustAct" runat="server" OnClick="lbCustAct_Click">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Customer Activities</span>
                            </h3>
                                 </asp:LinkButton>
                            <!--end::Title-->
                            <!--begin::Toolbar-->
                           <%-- <div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblCusActPerformed" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkOpenCusAct" runat="server" OnClick="lnkOpenCusAct_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblOpenCusAct" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Total</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkCompletedCusAct" runat="server" OnClick="lnkCompletedCusAct_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblCompletedCusAct" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Action Taken</div>
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

                <div class="col-xl-12 row">
                        <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="LinkButton2" OnClick="lnkCompetitorActivities_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/competitor.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Competitor Activities</span>
                                        </div>

                                        <span class="text-black fs-4 fw-bold py-1 me-12"><span id="MainContent_lblCustomerInventory">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblCompetitorActivities" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white;">
                            <asp:LinkButton runat="server" ID="LinkButton3" OnClick="lnkImageCapture_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/imagecapture.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Image Capture</span>
                                        </div>

                                        <span class="text-black fs-4 fw-bold py-1 me-12"><span id="MainContent_lblImageCapture">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblImageCapture" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                  </div>

                <div class="col-xl-6" >
                    <!--begin::Mixed Widget 14-->
                    <div class="card bgi-no-repeat card-xl-stretch mb-xl-25" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#03CDFD, #3483D9); background-size: 100%;">
                        <!--begin::Head-->
                        <div class="card-header pt-2" style="border-bottom: 0px;">
                            <!--begin::Title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Customer Requests</span>
                            </h3>

                            <!--end::Title-->
                            <!--begin::Toolbar-->
                            <%--<div class="card-toolbar">
                                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblReqPerformed" runat="server" Text="0"></asp:Label></span><br />
                                    <span class="" style="font-size: 12px;">Performed</span>
                                </p>
                            </div>--%>
                            <!--end::Toolbar-->
                        </div>
                        <!--end::Head-->
                        <!--begin::Body-->
                        <div class="card-body d-flex flex-column" style="padding-top: 5px;">
                            <!--begin::Row-->
                            <div class="row g-0">
                                <!--begin::Col-->
                                <div class="col-6">
                                    <div class="d-flex align-items-center me-2">
                                        <!--begin::Symbol-->
                                        <div class="symbol symbol-40px me-3">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                            <!--end::Svg Icon-->
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkNewRequest" runat="server" OnClick="lnkNewRequest_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblNewRequest" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">New Requests</div>
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
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                                        </div>
                                        <!--end::Symbol-->
                                        <!--begin::Title-->
                                        <div>
                                            <asp:LinkButton ID="lnkRepondedRequest" runat="server" OnClick="lnkRepondedRequest_Click">
                                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                                    <span class="" style="font-size: 17px;">
                                                        <asp:Label ID="lblRepondedRequest" runat="server" Text="0"></asp:Label>
                                                    </span>
                                                </div>
                                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Responded Requests</div>
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
                </div>

                <div class="col-xl-6">
                    <div class="col-lg-12">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkgnrlComp" OnClick="lnkgnrlComp_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/complaints.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">General Complaints</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_genComp">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblgeneralComplaints" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkPrdComp" OnClick="lnkPrdComp_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/complaints.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Product Complaints</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_prdcomp">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblprdComp" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <div class="col-xl-12 row">
                        <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkCreditNote" OnClick="lnkCreditNote_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/cnr.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Credit Note Request</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_lblCustomerInventory">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblCreditNote" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white;">
                            <asp:LinkButton runat="server" ID="lnkDisputeReqNote" OnClick="lnkDisputeReqNote_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/dr.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Dispute Note Request</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_DisputeReqNote">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblDisputeReqNote" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                  </div>

                <div class="col-xl-12 row">
                    <div class="col-lg-6">
                        <div class="card bgi-no-repeat card-lg-stretch mb-lg-8" style="background-color: white; ">
                            <asp:LinkButton runat="server" ID="lnkReturnRequest" OnClick="lnkReturnRequest_Click">
                                <div class=" card-xl-stretch m-4">

                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-0 col-md-12">
                                        <div class="symbol symbol-35px me-5">
                                            <img src="../assets/media/dashboard/srr.png" class="w-30px me-6" alt="" />
                                        </div>

                                        <div class="flex-grow-1 me-6">
                                            <span class="text-black fw-semibold fs-4 d-block">Return Request</span>
                                        </div>

                                        <span class="text-black fs-3 fw-bold py-1 me-12"><span id="MainContent_ReturnRequest">
                                           <%-- <asp:PlaceHolder ID="pnlorder" runat="server" Visible="false">--%>

                                            <asp:Label runat="server" ID="lblReturnRequest" Text="0"></asp:Label>
                                               <%-- </asp:PlaceHolder>--%>
                                        </span></span>

                                        <div class="symbol symbol-30px me-5">
                                            <img src="../assets/media/svg/general/arr023.svg" height="20" width="20">
                                        </div>


                                    </div>
                                </div>

                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
               
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
