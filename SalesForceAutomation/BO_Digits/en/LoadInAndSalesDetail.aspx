<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="LoadInAndSalesDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.LoadInAndSalesDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <span class="fw-bolder"> Date : </span> 
    <asp:Label runat="server" ID="lbldat" Text="21-Feb-2022 | 10.30"></asp:Label>
    <span class="mx-4 fw-bolder"> Route :  </span>
    <asp:Label runat="server" ID="lblroute" Text="[R102]-Hatta"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


    
            <div class="col-xl-12 row">
                 
                <!--begin::Row-->
                <div class="col-xl-12  mb-5 mb-xl-10">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush h-xl-100">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark">Load In</span>

                            </h3>
                            <!--end::Card title-->
                            <div class="card-toolbar">
                                <!--begin::Menu-->
                                <h3 class="card-title align-items-start justify-content-end">
                                    <span class="card-label fw-bold text-dark"><asp:Label ID="lblLoadIn" runat="server"></asp:Label></span>
                                </h3>


                                <!--end::Menu-->
                            </div>
                        </div>
                        <!--begin::Card toolbar-->
                        <div class="card-toolbar" style="padding-top: 25px; padding-left: 19px; padding-bottom: 0px;">
                            <!--begin::Tabs-->
                            <ul class="nav">
                                <li class="nav-item">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_TotalPlanned">
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-success);"><asp:Label ID="lblLICompleted" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Completed</span>
                                        <!--end::Subtitle-->

                                    </a>

                                </li>
                                <li class="nav-item" style="padding-left:0px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Visited">
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-warning);"><asp:Label ID="lblLIPending" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Pending Approval</span>
                                        <!--end::Subtitle-->
                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left:0px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Pending">
                                        <!--begin::Icon-->
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-danger);"><asp:Label ID="lblLINotProcss" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Not Processed</span>
                                        <!--end::Subtitle-->
                                    </a>
                                </li>
                                 <li class="nav-item" style="padding-left:0px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Rejected">
                                        <!--begin::Icon-->
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-danger);"><asp:Label ID="lblLIRejected" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Rejected</span>
                                        <!--end::Subtitle-->
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
                                    <div class="table-responsive pb-10">
                                       <!--begin::Table-->
                                           <table class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-3="all"">
                                                                  
                                                                    <!--begin::Table head-->
                                                                    <thead hidden="hidden">
                                                                        <tr class="fs-7 fw-bold text-gray-500">
                                                                            <th class="p-0 min-w-150px d-block pt-3">EMAIL TITLE</th>
                                                                            <th class="text-end min-w-140px pt-3">STATUS</th>
                                                                            <th class="pe-0 text-end min-w-120px pt-3">CONVERSION</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <!--end::Table head-->
                                                                    <!--begin::Table body-->
                                                                    <tbody>
                                                                        <asp:Repeater runat="server" ID="rptLoadIn">
                                                                        <ItemTemplate>
                                                                        <tr>
                                                                            <td class="min-w-175px">
                                                                                <div >
                                                                                    
                                                                                    <a href="LoadInCompletedDetailPage.aspx?LIH=<%# Eval("lih_ID") %>" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                                        <asp:Label ID="lblCusName" Text='<%# Eval("lih_TransID") %>' runat="server"></asp:Label>

                                                                                    </a>
                                                                                    <div class="fs-7 text-muted fw-bold"><asp:Label ID="lblCreatedDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label></div>
                                                                                </div>
                                                                            </td>
                                                                            <td class="text-end">
                                                                               
                                                                                    <span class=" fs-7 fw-bold <%# Eval("Status").ToString() == "Pending" ? "badge-light-warning" : "badge-light-success" %>">   
                                                                                     <asp:Label ID="lblStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span></span><br />
                                                                                    
                                                                               
                                                                            </td>
                                                                            
                                                                        </tr>
                                                                      </ItemTemplate> 
                                                                       </asp:Repeater>
                                                                    </tbody>
                                                                    <!--end::Table body-->
                                                                </table>
                                       <!--end::Table-->
                                        <div hidden="hidden">
                                            <div id="kt_timeline_widget_1_1" class="vis-timeline-custom h-350px min-w-700px" data-kt-timeline-widget-1-image-root="assets/media/"></div>
                                        </div>

                                        <!--end::Timeline-->
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_1_Visited" role="tabpanel" aria-labelledby="week-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10">
                                         <!--begin::Table-->
                                           <table class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-3="all"">
                                                                  
                                                                    <!--begin::Table head-->
                                                                    <thead hidden="hidden">
                                                                        <tr class="fs-7 fw-bold text-gray-500">
                                                                            <th class="p-0 min-w-150px d-block pt-3">EMAIL TITLE</th>
                                                                            <th class="text-end min-w-140px pt-3">STATUS</th>
                                                                            <th class="pe-0 text-end min-w-120px pt-3">CONVERSION</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <!--end::Table head-->
                                                                    <!--begin::Table body-->
                                                                    <tbody>
                                                                       
                                                                       <asp:Repeater runat="server" ID="rptLoadInPending">
                                                                        <ItemTemplate>
                                                                        <tr>
                                                                            <td class="min-w-175px">
                                                                                <div >
                                                                                    
                                                                                    <a href="LoadInCompletedDetailPage.aspx?LIH=<%# Eval("lih_ID") %>" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                                        <asp:Label ID="lblCusName" Text='<%# Eval("lih_TransID") %>' runat="server"></asp:Label>

                                                                                    </a>
                                                                                    <div class="fs-7 text-muted fw-bold"><asp:Label ID="lblCreatedDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label></div>
                                                                                </div>
                                                                            </td>
                                                                            <td class="text-end">
                                                                               
                                                                                    <span class=" fs-7 fw-bold badge-light-warning" >   
                                                                                     <asp:Label ID="lblStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span></span><br />
                                                                                    
                                                                               
                                                                            </td>
                                                                            
                                                                        </tr>
                                                                      </ItemTemplate> 
                                                                       </asp:Repeater>
                                                                    </tbody>
                                                                    <!--end::Table body-->
                                                                </table>
                                       <!--end::Table-->
                                        <div hidden="hidden">
                                            <div id="" class="vis-timeline-custom h-350px min-w-700px" data-kt-timeline-widget-1-image-root="assets/media/"></div>
                                        </div>
                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_1_Pending" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                   
                                    <div class="table-responsive pb-10 vis-timeline-custom">
                                        <!--begin::Table-->
                                           <table class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-3="all"">
                                                                  
                                                                    <!--begin::Table head-->
                                                                    <thead hidden="hidden">
                                                                        <tr class="fs-7 fw-bold text-gray-500">
                                                                            <th class="p-0 min-w-150px d-block pt-3">EMAIL TITLE</th>
                                                                            <th class="text-end min-w-140px pt-3">STATUS</th>
                                                                            <th class="pe-0 text-end min-w-120px pt-3">CONVERSION</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <!--end::Table head-->
                                                                    <!--begin::Table body-->
                                                                    <tbody>
                                                                        <asp:Repeater runat="server" ID="rptLoadInNotProc">
                                                                        <ItemTemplate>
                                                                        <tr>
                                                                            <td class="min-w-175px">
                                                                                <div >
                                                                                    
                                                                                    <a href="LoadInCompletedDetailPage.aspx?LIH=<%# Eval("lih_ID") %>" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                                        <asp:Label ID="lblCusName" Text='<%# Eval("Trans") %>' runat="server"></asp:Label>

                                                                                    </a>
                                                                                    <div class="fs-7 text-muted fw-bold"><asp:Label ID="lblCreatedDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label></div>
                                                                                </div>
                                                                            </td>
                                                                            <td class="text-end">
                                                                               
                                                                                    <span class=" fs-7 fw-bold badge-light-danger" >   
                                                                                     <asp:Label ID="lblStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span></span><br />
                                                                                    
                                                                               
                                                                            </td>
                                                                            
                                                                        </tr>
                                                                      </ItemTemplate> 
                                                                       </asp:Repeater>
                                                                    </tbody>
                                                                    <!--end::Table body-->
                                                                </table>
                                       <!--end::Table-->
                                        

                                        <!--end::Timeline-->
                                    </div>
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane" id="kt_timeline_widget_1_Rejected" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                   
                                    <div class="table-responsive pb-10 vis-timeline-custom">
                                        <!--begin::Table-->
                                           <table class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-3="all"">
                                                                  
                                                                    <!--begin::Table head-->
                                                                    <thead hidden="hidden">
                                                                        <tr class="fs-7 fw-bold text-gray-500">
                                                                            <th class="p-0 min-w-150px d-block pt-3">EMAIL TITLE</th>
                                                                            <th class="text-end min-w-140px pt-3">STATUS</th>
                                                                            <th class="pe-0 text-end min-w-120px pt-3">CONVERSION</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <!--end::Table head-->
                                                                    <!--begin::Table body-->
                                                                    <tbody>
                                                                        <asp:Repeater runat="server" ID="rptLIRejected">
                                                                        <ItemTemplate>
                                                                        <tr>
                                                                            <td class="min-w-175px">
                                                                                <div >
                                                                                    
                                                                                    <a href="LoadInCompletedDetailPage.aspx?LIH=<%# Eval("lih_ID") %>" class="mb-1 text-dark text-hover-primary fw-bold">
                                                                                        <asp:Label ID="lblCusName" Text='<%# Eval("Trans") %>' runat="server"></asp:Label>

                                                                                    </a>
                                                                                    <div class="fs-7 text-muted fw-bold"><asp:Label ID="lblCreatedDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label></div>
                                                                                </div>
                                                                            </td>
                                                                            <td class="text-end">
                                                                               
                                                                                    <span class=" fs-7 fw-bold badge-light-danger" >   
                                                                                     <asp:Label ID="lblStatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span></span><br />
                                                                                    
                                                                               
                                                                            </td>
                                                                            
                                                                        </tr>
                                                                      </ItemTemplate> 
                                                                       </asp:Repeater>
                                                                    </tbody>
                                                                    <!--end::Table body-->
                                                                </table>
                                       <!--end::Table-->
                                        

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
              <%--  <div class="col-xl-6  mb-5 mb-xl-10">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush h-xl-100">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark">Sales</span>

                            </h3>
                             <div class="card-toolbar">
                                                <h3 class="card-title fw-bold text-dark mr-5">
                                                  <asp:Label ID="lblTotalInvoices" runat="server"></asp:Label> / <asp:Label ID="lblTotalInvAmt" runat="server"></asp:Label></h3>
                                            </div>
                            <!--end::Card title-->
                        </div>
                        <!--begin::Card toolbar-->
                     
                        <!--end::Card toolbar-->

                        <!--end::Card header-->
                        
                        <!--begin::Card body-->
                        <div class="card-body pt-1">
                             <div class="col-lg-12 mt-5 row" style="padding-left: 2%; padding-bottom: 0px; margin-left:2px;">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-1  " style="border-style: solid;border-color:#e4e6ef; border-width: 1px !important; height: 1%; flex: 0 0 auto; width: 45%; margin-bottom: 0.7rem !important; margin-right: 1.5rem;">
                                      
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success" style="width: 30px; height: 30px;">
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="20" width="20" />
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block" >Hard Cash</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArHcAmt"  runat="server"></asp:Label></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArHcCount"  runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-1  " style="border-style: solid;border-color:#e4e6ef; border-width: 1px !important; height: 1%; flex: 0 0 auto; width: 45%; margin-bottom: 0.7rem !important; margin-right: 1.5rem;">
                                        
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary" style="width: 30px; height: 30px;">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="20" width="20" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">POS</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArPosAmt"  runat="server"></asp:Label></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArPosCount"  runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                     <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-1  " style="border-style: solid;border-color:#e4e6ef; border-width: 1px !important; height: 1%; flex: 0 0 auto; width: 45%; margin-bottom: 0.7rem !important; margin-right: 1.5rem;">
                                      
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning" style="width: 30px; height: 30px;">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="20" width="20" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">Online Payment</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArOpAmt"  runat="server"></asp:Label></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArOpCount"  runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-1  " style="border-style: solid;border-color:#e4e6ef; border-width: 1px !important; height: 1%; flex: 0 0 auto; width: 45%; margin-bottom: 0.7rem !important; margin-right: 1.5rem;">
                                        
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary" style="width: 30px; height: 30px;">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/credit@2x.png" height="20" width="20" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">Credit</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArChequeAmt"  runat="server"></asp:Label></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArChequeCount"  runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->

                                </div>


                               <div class="card-toolbar" style="padding-top: 25px; padding-left: 25px; padding-bottom: 10px;">
                            <!--begin::Tabs-->
                            <ul class="nav">
                                <li class="nav-item">

                                     <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Sales">
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-primary);"><asp:Label ID="lblSalesCount" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Sales</span>
                                        <!--end::Subtitle-->

                                    </a>

                                </li>
                                <li class="nav-item" style="padding-left: 18px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_GoodReturn">
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-success);"><asp:Label ID="lblGRCount" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Good Return</span>
                                        <!--end::Subtitle-->
                                    </a>
                                </li>
                                <li class="nav-item" style="padding-left: 11px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_BADReturn">
                                        <!--begin::Icon-->
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-danger);"><asp:Label ID="lblBRCount" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Bad Return</span>
                                        <!--end::Subtitle-->
                                    </a>
                                </li>
                                 <li class="nav-item" style="padding-left: 0px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_FOC">
                                        <!--begin::Icon-->
                                        <div class="nav-icon">
                                            <span class=" fw-bold" style="color: var(--kt-warning);"><asp:Label ID="lblFCcount" runat="server"></asp:Label></span>
                                        </div>
                                        <!--end::Icon-->
                                        <!--begin::Subtitle-->
                                        <span class="nav-text text-gray-700 fw-bold fs-6 lh-1">Free of Cost</span>
                                        <!--end::Subtitle-->
                                    </a>
                                </li>
                            </ul>
                            <!--end::Tabs-->
                        </div>





















                            <!--begin::Tab content-->
                            <div class="tab-content">
                                <!--begin::Tab pane-->
                                 <div class="tab-pane active " id="kt_timeline_widget_1_Sales" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                 
                                
                                    
                           <!--end::Body-->
                        <!--begin::Card body-->
						  
                             
                              <div class="table-responsive">
                        <!--begin::Table-->
						<table class="table align-middle table-row-dashed fs-6 gy-3">
														
														<!--begin::Table body-->
														<tbody class="fw-bold text-gray-600">
															
															<asp:Repeater id="rptSalesDetail" runat="server">
                                                                <ItemTemplate>
															<tr>
                                                                
																<!--begin::Item-->
																<td colspan="3" >
                                                                    <a href="SalesInvoiceDetail.aspx?salID=<%# Eval("sal_ID") %>">
																	<span class="text-dark text-hover-primary"> <asp:Label ID="lblSalNum" Text='<%# Eval("sal_number") %>' runat="server"></asp:Label></span>

                                                                    </a>
                                                                   <p style="font-size: 11px; margin-bottom:auto;"> <asp:Label ID="lblcus" Text='<%# Eval("customer") %>' runat="server"></asp:Label> </p>
																
                                                                </td>
                                                                    <td class="text-end" style="font-size: 10px;"><asp:Label ID="lnlDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    <p style="font-size: 12px; margin-top:5px; margin-bottom:-4px;"> <asp:Label ID="lbltype" Text='<%# Eval("Pay") %>' runat="server"></asp:Label></p>
																</td>
																<!--end::Item-->
																
																
																
                                                               
																
															</tr>
															</ItemTemplate>
                                                            </asp:Repeater>

														</tbody>
														<!--end::Table body-->
													</table>
					    <!--end::Table-->
 
                             </div> 
                                  
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane " id="kt_timeline_widget_1_GoodReturn" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                 
                                
                                     
                           <!--end::Body-->
                        <!--begin::Card body-->
						  
                             
                              <div class="table-responsive">
                        <!--begin::Table-->
						<table class="table align-middle table-row-dashed fs-6 gy-3">
														
														<!--begin::Table body-->
														<tbody class="fw-bold text-gray-600">
															
															<asp:Repeater id="rptGRDetail" runat="server">
                                                                <ItemTemplate>
															<tr>
																<!--begin::Item-->
																<td colspan="3">
                                                                    <a href="SalesInvoiceDetail.aspx?salID=<%# Eval("sal_ID") %>">
																	<span class="text-dark text-hover-primary"> <asp:Label ID="lblSalNum" Text='<%# Eval("sal_number") %>' runat="server"></asp:Label>
</span></a>
                                                                   <p style="font-size: 11px; margin-bottom:auto;"> <asp:Label ID="lblcus" Text='<%# Eval("customer") %>' runat="server"></asp:Label> </p>
																</td>
																<!--end::Item-->
																
																<!--begin::Status-->
																
																<!--end::Status-->
                                                                <!--begin::Date added-->
																<td class="text-end" style="font-size: 10px;"><asp:Label ID="lnlDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    <p style="font-size: 12px; margin-top:5px; margin-bottom:-4px;"> <asp:Label ID="lbltype" Text='<%# Eval("Pay") %>' runat="server"></asp:Label></p>
																</td>
																<!--end::Date added-->
																
															</tr>
															</ItemTemplate>
                                                            </asp:Repeater>

														</tbody>
														<!--end::Table body-->
													</table>
					    <!--end::Table-->
 
                             </div> 
                                
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane " id="kt_timeline_widget_1_BADReturn" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                 
                                
                                    
                           <!--end::Body-->
                        <!--begin::Card body-->
						  
                             
                              <div class="table-responsive">
                        <!--begin::Table-->
						<table class="table align-middle table-row-dashed fs-6 gy-3">
														
														<!--begin::Table body-->
														<tbody class="fw-bold text-gray-600">
															
															<asp:Repeater id="rptBRDetail" runat="server">
                                                                <ItemTemplate>
															<tr>
																<!--begin::Item-->
																<td colspan="3">
                                                                    <a href="SalesInvoiceDetail.aspx?salID=<%# Eval("sal_ID") %>">
																	<span class="text-dark text-hover-primary"> <asp:Label ID="lblSalNum" Text='<%# Eval("sal_number") %>' runat="server"></asp:Label>
</span></a>
                                                                   <p style="font-size: 11px; margin-bottom:auto;"> <asp:Label ID="lblcus" Text='<%# Eval("customer") %>' runat="server"></asp:Label> </p>
																</td>
																<!--end::Item-->
																
																<!--begin::Status-->
																
																<!--end::Status-->
                                                                <!--begin::Date added-->
																<td class="text-end" style="font-size: 10px;"><asp:Label ID="lnlDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    <p style="font-size: 12px; margin-top:5px; margin-bottom:-4px;"> <asp:Label ID="lbltype" Text='<%# Eval("Pay") %>' runat="server"></asp:Label></p>
																</td>
																<!--end::Date added-->
																
															</tr>
															</ItemTemplate>
                                                            </asp:Repeater>

														</tbody>
														<!--end::Table body-->
													</table>
					    <!--end::Table-->
 
                             </div> 
                                
                                </div>
                                <!--end::Tab pane-->
                                <!--begin::Tab pane-->
                                <div class="tab-pane " id="kt_timeline_widget_1_FOC" role="tabpanel" aria-labelledby="month-tab" data-kt-timeline-widget-1-blockui="true">
                                 
                                
                                    
                           <!--end::Body-->
                        <!--begin::Card body-->
						  
                             
                              <div class="table-responsive">
                        <!--begin::Table-->
						<table class="table align-middle table-row-dashed fs-6 gy-3">
														
														<!--begin::Table body-->
														<tbody class="fw-bold text-gray-600">
															
															<asp:Repeater id="rptFOCDetail" runat="server">
                                                                <ItemTemplate>
															<tr>
																<!--begin::Item-->
																<td colspan="3">
                                                                    <a href="SalesInvoiceDetail.aspx?salID=<%# Eval("sal_ID") %>">
																	<span class="text-dark text-hover-primary"> <asp:Label ID="lblSalNum" Text='<%# Eval("sal_number") %>' runat="server"></asp:Label>
</span></a>
                                                                   <p style="font-size: 11px; margin-bottom:auto;"> <asp:Label ID="lblcus" Text='<%# Eval("customer") %>' runat="server"></asp:Label> </p>
																</td>
																<!--end::Item-->
																
																<!--begin::Status-->
																
																<!--end::Status-->
                                                                <!--begin::Date added-->
																<td class="text-end" style="font-size: 10px;"><asp:Label ID="lnlDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    <p style="font-size: 12px; margin-top:5px; margin-bottom:-4px;"> <asp:Label ID="lbltype" Text='<%# Eval("Pay") %>' runat="server"></asp:Label></p>
																</td>
																<!--end::Date added-->
																
															</tr>
															</ItemTemplate>
                                                            </asp:Repeater>

														</tbody>
														<!--end::Table body-->
													</table>
					    <!--end::Table-->
 
                             </div> 
                                
                                </div>
                                <!--end::Tab pane-->
                            </div>
                            <!--end::Tab content-->
                        </div>
                        <!--end::Card body-->
                    </div>
                    <!--end::Timeline Widget 1-->
                </div>--%>
                <!--end::Row-->
            </div>
           
            <!--end::Content container-->
       


</asp:Content>


