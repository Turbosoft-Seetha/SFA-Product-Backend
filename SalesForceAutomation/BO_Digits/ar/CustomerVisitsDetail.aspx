<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="CustomerVisitsDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.CustomerVisitsDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <span class="fw-bolder"> تاريخ : </span> 
    <asp:Label runat="server" ID="lbldat" Text="21-Feb-2022 | 10.30"></asp:Label>
    <span class="mx-4 fw-bolder"> طريق :  </span>
    <asp:Label runat="server" ID="lblroute" Text="[R102]-Hatta"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


    
            <div class="col-xl-12 row">

                <!--begin::Row-->
                <div class="col-xl-6  mb-5 mb-xl-10">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush h-xl-100">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark">الزيارات المخططة</span>

                            </h3>
                            <!--end::Card title-->
                        </div>
                        <!--begin::Card toolbar-->
                        <div class="card-toolbar" style="padding-top: 25px; padding-left: 25px; padding-bottom: 10px;">
                            <!--begin::Tabs-->
                            <ul class="nav">
                                <li class="nav-item">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_TotalPlanned">إجمالي المخطط  
                                        <asp:Label ID="lblPlannedVisit" runat="server"></asp:Label>

                                    </a>

                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Visited">تمت زيارته  
                                <asp:Label ID="CusTotalVisits" runat="server"></asp:Label>
                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Pending">قيد الانتظار 
                                         <asp:Label ID="CusPending" runat="server"></asp:Label>
                                    </a>
                                </li>
                            </ul>
                            <!--end::Tabs-->
                        </div>
                        <!--end::Card toolbar-->

                        <!--end::Card header-->
                        <div class="separator separator-dashed my-5" style="margin-left: 30px; margin-right: 30px;"></div>
                        <!--begin::Card body-->
                        <div class="card-body pt-1">
                            <!--begin::Tab content-->
                            <div class="tab-content">
                                <!--begin::Tab pane-->
                                <div class="tab-pane active" id="kt_timeline_widget_1_TotalPlanned" role="tabpanel" aria-labelledby="day-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_1" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-1="all">

                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptTotalPlanned"  OnItemDataBound="rptTotalPlanned_ItemDataBound">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == "Pending" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCusName" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblCreatedDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == "Pending" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lblStatus" Text='<%# Eval("Status") %>'  runat="server" ></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lblVisits" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>

                                                            <td class="d-none">مكتمل</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton ID="ButtonTotalPlanned"  runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="ButtonTotalPlanned_Click" CommandName="TotalPlanned" CommandArgument='<%# Eval("rsc_ID")+";"+Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>

                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <!--begin::Timeline-->
                                        <%--<div hidden="hidden">
                                            <div id="kt_timeline_widget_1_1" class="vis-timeline-custom h-350px min-w-700px" data-kt-timeline-widget-1-image-root="assets/media/"></div>
                                        </div>--%>

                                        <!--end::Timeline-->
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_1_Visited" role="tabpanel" aria-labelledby="week-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive  pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_2" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-2="all">

                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptTotalVisited" >
                                                    <ItemTemplate>
                                                        <tr class="even">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == "Pending" ? "badge-warning" : "badge-primary" %>" ></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCus" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == "Pending" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lblStat" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lblVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">مكتمل</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton ID="btnTotalVisited" runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnTotalVisited_Click" CommandName="TotalVisited" CommandArgument='<%# Eval("rsc_ID")+";"+Eval("cus_ID")%>' >
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>

                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <div id=""></div>
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_1_Pending" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10 " style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_3" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-3="all">

                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptTotalPending" >
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == "Pending" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == "Pending" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">مكتمل</td>
                                                            <td class="text-end">
                                                                <%--<asp:LinkButton ID="btnTotalPending" runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnTotalPending_Click" CommandName="TotalPending" CommandArgument='<%# Eval("rsc_ID")+";"+Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                        --%>    </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>


                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                            </div>
                            <!--end::Tab content-->
                        </div>
                        <!--end::Card body-->
                    </div>
                    <!--end::Timeline Widget 1-->
                </div>
                <!--end::Row-->
                <!--begin::Row-->
                <div class="col-xl-6  mb-5 mb-xl-10">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush h-xl-100">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark">الزيارات الفعلية</span>

                            </h3>
                            <!--end::Card title-->
                        </div>
                        <!--begin::Card toolbar-->
                        <div class="card-toolbar" style="padding-top: 25px; padding-left: 25px; padding-bottom: 10px;">
                            <!--begin::Tabs-->
                            <ul class="nav">
                                <li class="nav-item">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Total">إجمالي الزيارة  
                                        <asp:Label ID="lblActualVisit" runat="server"></asp:Label>

                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Planned">مخطط 
                                 <asp:Label ID="lblPlanned" runat="server"></asp:Label>

                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Unplanned">غير مخطط له 
                                <asp:Label ID="lblUnplanned" runat="server"></asp:Label>

                                    </a>
                                </li>
                            </ul>
                            <!--end::Tabs-->
                        </div>
                        <!--end::Card toolbar-->

                        <!--end::Card header-->
                        <div class="separator separator-dashed my-5" style="margin-left: 30px; margin-right: 30px;"></div>
                        <!--begin::Card body-->
                        <div class="card-body pt-1">
                            <!--begin::Tab content-->
                            <div class="tab-content">
                                <!--begin::Tab pane-->
                                <div class="tab-pane active" id="kt_timeline_widget_1_Total" role="tabpanel" aria-labelledby="day-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_4" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-4="all">

                                            <tbody>


                                                <asp:Repeater runat="server" ID="rptActalVisit">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == " Unplanned" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == " Unplanned" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">مكتمل</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton ID="btnTotalActual" runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnTotalActual_Click" CommandArgument='<%# Eval("cse_cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <!--begin::Timeline-->
                                       <%-- <div hidden="hidden">
                                            <div id="kt_timeline_widget_1_1" class="vis-timeline-custom h-350px min-w-700px" data-kt-timeline-widget-1-image-root="assets/media/"></div>
                                        </div>--%>

                                        <!--end::Timeline-->
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_1_Planned" role="tabpanel" aria-labelledby="week-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_5" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-5="all">

                                            <tbody>

                                                <asp:Repeater runat="server" ID="rptActualvisitplanned">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 badge-primary" ></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge badge-light-primary" >
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">مكتمل</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton runat="server" ID="btnActualplanned" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnActualplanned_Click"  CommandArgument='<%#Eval("cse_cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <div id=""></div>
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_1_Unplanned" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10 vis-timeline-custom">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_6" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-6="all">

                                            <tbody>

                                                <asp:Repeater runat="server" ID="rptActualVisitUnplanned">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == "Unplanned" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == "Unplanned" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">Completed</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton runat="server" ID="btnActualUnplanned" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnActualUnplanned_Click" CommandArgument='<%#Eval("cse_cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>

                                            </tbody>
                                            <!--end::Table-->
                                        </table>


                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                            </div>
                            <!--end::Tab content-->
                        </div>
                        <!--end::Card body-->
                    </div>
                    <!--end::Timeline Widget 1-->
                </div>
                <!--end::Row-->
            </div>
            <div class="col-xl-12 row">

                <!--begin::Row-->
                <div class="col-xl-6  mb-5 mb-xl-10">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush h-xl-100">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark">زيارات مثمرة</span>

                            </h3>
                            <!--end::Card title-->
                        </div>
                        <!--begin::Card toolbar-->
                        <div class="card-toolbar" style="padding-top: 25px; padding-left: 25px; padding-bottom: 10px;">
                            <!--begin::Tabs-->
                            <ul class="nav">
                                <li class="nav-item">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_2_Total">إنتاجي   
                                         <asp:Label ID="lblTotalProductive" runat="server"></asp:Label>

                                    </a>

                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_2_Planned">مخطط  
                                         <asp:Label ID="lblProductivePlanned" runat="server"></asp:Label>

                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_2_Unplanned">غير مخطط له 
                                 <asp:Label ID="lblProductiveUnplanned" runat="server"></asp:Label>

                                    </a>
                                </li>
                            </ul>
                            <!--end::Tabs-->
                        </div>
                        <!--end::Card toolbar-->

                        <!--end::Card header-->
                        <div class="separator separator-dashed my-5" style="margin-left: 30px; margin-right: 30px;"></div>
                        <!--begin::Card body-->
                        <div class="card-body pt-1">
                            <!--begin::Tab content-->
                            <div class="tab-content">
                                <!--begin::Tab pane-->
                                <div class="tab-pane active" id="kt_timeline_widget_2_Total" role="tabpanel" aria-labelledby="day-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_7" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-7="all">

                                            <tbody>


                                                <asp:Repeater runat="server" ID="rptproductivedetail">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == " Unplanned" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == " Unplanned" ? "badge-light-warning" : "badge-light-primary" %>"> 
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">Completed</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton ID="btnTotalProd" runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnTotalProd_Click" CommandArgument='<%# Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>

                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <!--begin::Timeline-->
                                       

                                        <!--end::Timeline-->
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_2_Planned" role="tabpanel" aria-labelledby="week-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_8" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-8="all">

                                            <tbody>

                                                <asp:Repeater runat="server" ID="rptProductivePlanned">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == " Unplanned" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == " Unplanned" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">Completed</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton ID="btnPlannedProd" runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnPlannedProd_Click" CommandArgument='<%#Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton> 
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <div id=""></div>
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_2_Unplanned" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10 "style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_9" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-9="all">

                                            <tbody>

                                                <asp:Repeater runat="server" ID="rptProductiveUnPlanned">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == " Unplanned" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == " Unplanned" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">مكتمل</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton runat="server" ID="btnUnplannedprod" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnUnplannedprod_Click" CommandArgument='<%#Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>


                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                            </div>
                            <!--end::Tab content-->
                        </div>
                        <!--end::Card body-->
                    </div>
                    <!--end::Timeline Widget 1-->
                </div>
                <!--end::Row-->
                <!--begin::Row-->
                <div class="col-xl-6  mb-5 mb-xl-10">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush h-xl-100">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark">الزيارات غير المنتجة</span>

                            </h3>
                            <!--end::Card title-->
                        </div>
                        <!--begin::Card toolbar-->
                        <div class="card-toolbar" style="padding-top: 25px; padding-left: 14px; padding-bottom: 10px;">
                            <!--begin::Tabs-->
                            <ul class="nav">
                                <li class="nav-item">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_3_TotalPlanned">غير منتج 
                                    <asp:Label ID="lblTotalNonProductive" runat="server"></asp:Label>

                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_3_Visited">مخطط  
                                 <asp:Label ID="lblNonProductivePlanned" runat="server"></asp:Label>

                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_3_Pending">غير مخطط له  
                                <asp:Label ID="lblNonProductiveUnplanned" runat="server"></asp:Label>

                                    </a>
                                </li>
                            </ul>
                            <!--end::Tabs-->
                        </div>
                        <!--end::Card toolbar-->

                        <!--end::Card header-->
                        <div class="separator separator-dashed my-5" style="margin-left: 30px; margin-right: 30px;"></div>
                        <!--begin::Card body-->
                        <div class="card-body pt-1">
                            <!--begin::Tab content-->
                            <div class="tab-content">
                                <!--begin::Tab pane-->
                                <div class="tab-pane active" id="kt_timeline_widget_3_TotalPlanned" role="tabpanel" aria-labelledby="day-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_10" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-10="all">

                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptNonproductivedetail">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 <%# Eval("Status").ToString() == " Unplanned" ? "badge-warning" : "badge-primary" %>"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge <%# Eval("Status").ToString() == " Unplanned" ? "badge-light-warning" : "badge-light-primary" %>">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">Completed</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton ID="btnNonprodTotal" runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnNonprodTotal_Click" CommandArgument='<%#Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>

                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <!--begin::Timeline-->
                                        <div hidden="hidden">
                                            <div id="kt_timeline_widget_1_1" class="vis-timeline-custom h-350px min-w-700px" data-kt-timeline-widget-1-image-root="assets/media/"></div>
                                        </div>

                                        <!--end::Timeline-->
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_3_Visited" role="tabpanel" aria-labelledby="week-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_11" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-11="all">

                                            <tbody>

                                                <asp:Repeater runat="server" ID="rptNonproductivePlanned">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 badge-primary"></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge badge-light-primary">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">Completed</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton runat="server" ID="btnNonProdPlanned" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnNonProdPlanned_Click" CommandArgument='<%# Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <div id=""></div>
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_3_Pending" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10 " style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_12" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-12="all">

                                            <tbody>

                                                <asp:Repeater runat="server" ID="rptNonproductiveUnplanned">
                                                    <ItemTemplate>

                                                        <tr class="odd">
                                                            <td class="min-w-175px">
                                                                <div class="position-relative ps-6 pe-3 py-2">
                                                                    <div class="position-absolute start-0 top-0 w-4px h-100 rounded-2 badge-warning "></div>
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                        <asp:Label ID="lblCustomer" Text='<%# Eval("cus_NameArabic") %>' runat="server"></asp:Label>

                                                                    </a>
                                                                    <div class="fs-7 text-muted fw-bold">
                                                                        <asp:Label ID="lblcrtDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <!--begin::Icons-->

                                                                <!--end::Icons-->
                                                                <div class="fs-7 ">
                                                                    <span class="badge badge-light-warning">
                                                                        <asp:Label ID="lbStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="badge text-muted fw-bold">
                                                                    <asp:Label ID="lbVisi" Text='<%# Eval("visits") %>' runat="server"></asp:Label>&nbsp; الزيارات</span>
                                                            </td>


                                                            <td class="d-none">Completed</td>
                                                            <td class="text-end">
                                                                <asp:LinkButton ID="btnNonprodUnplanned" runat="server" class="btn btn-icon btn-sm btn-light btn-active-primary w-25px h-25px" OnClick="btnNonprodUnplanned_Click" CommandArgument='<%# Eval("cus_ID")%>'>
                                                                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr001.svg-->
                                                                    <span class="svg-icon">
                                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M14.4 11H3C2.4 11 2 11.4 2 12C2 12.6 2.4 13 3 13H14.4V11Z" fill="currentColor"></path>
                                                                            <path opacity="0.3" d="M14.4 20V4L21.7 11.3C22.1 11.7 22.1 12.3 21.7 12.7L14.4 20Z" fill="currentColor"></path>
                                                                        </svg>
                                                                    </span>
                                                                    <!--end::Svg Icon-->
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                            <!--end::Table-->
                                        </table>


                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                            </div>
                            <!--end::Tab content-->
                        </div>
                        <!--end::Card body-->
                    </div>
                    <!--end::Timeline Widget 1-->
                </div>
                <!--end::Row-->
            </div>
            <!--end::Content container-->
       

</asp:Content>

