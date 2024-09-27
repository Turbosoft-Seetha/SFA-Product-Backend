<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="LoadOutDashboardDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.LoadOutDashboardDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <span class="fw-bolder"> تاريخ : </span> 
    <asp:Label runat="server" ID="lbldat"></asp:Label>
    <span class="mx-4 fw-bolder"> طريق :  </span>
    <asp:Label runat="server" ID="lblroute"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
      <div class="app-content flex-column-fluid">
          <div class="">
            <div class="col-lg-12 row">

                 <%-- card-1--%>
                <div class="col-lg-6 ">
                    
                    <div class="card card-flush mb-5">
                     
						   <!--begin::Row-->
                           <div class="col-lg-12 mb-5">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark"> عمليات نقل الحمولة</span>

                            </h3>
                            <!--end::Card title-->
                        </div>
                        <!--begin::Card toolbar-->
                        <div class="card-toolbar" style="padding-top: 8px; padding-left: 5%;">
                            <!--begin::Tabs-->
                            <ul class="nav" style="justify-content:space-around";>
                                <li class="nav-item">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_TotalPlanned">مخزون جيد 
                                      <span class="ms-10"><asp:Label runat="server" ID="lblLTGoodStock" Text="25">  </asp:Label> </span> 
                                        
                                    </a>
                                    
                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 ms-20" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Visited">مخزون سيء
                                        <span class="ms-10"><asp:Label runat="server" ID="lblLTBadStock" Text="20">  </asp:Label> </span></a>
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
                            <div class="tab-content" >
                                <!--begin::Tab pane-->
                                <div class="tab-pane active" id="kt_timeline_widget_1_TotalPlanned" role="tabpanel" aria-labelledby="day-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_1" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-1="all">

                                            <tbody>
                                                 <asp:Repeater runat="server" ID="rptLoadTransferGD">
                                                    <ItemTemplate>

                                                         <tr class="odd">
                                                    <td class="min-w-175px">
                                                     
                                                         <div class="position-relative ps-0 pe-3 py-0">
                                                             <a href="#" class="mb-1 text-dark text-hover-primary fw-bold"><asp:Label ID="lblLTNumber" Text='<%# Eval("lth_ID") %>' runat="server"></asp:Label></a>
                                                             <div class="fs-8 text-muted fw-bold"><asp:Label ID="lbldate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label></div>
                                                         </div>
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
                                <div class="tab-pane" id="kt_timeline_widget_1_Visited" role="tabpanel" aria-labelledby="week-tab" data-kt-timeline-widget-1-blockui="true">
                                    <div class="table-responsive pb-10" style="height:400px;">
                                        <!--begin::Timeline-->
                                        <table id="kt_widget_table_2" class="table table-row-dashed align-middle fs-6 gy-4 my-0 pb-3 dataTable no-footer" data-kt-table-widget-2="all">

                                            <tbody>

                                                 <asp:Repeater runat="server" ID="rptLoadTransferBD">
                                                    <ItemTemplate>

                                                       <tr class="even">
                                                         <td class="min-w-175px">
                                                             <div class="position-relative ps-0 pe-3 py-0">
                                                                 <a href="#" class="mb-1 text-dark text-hover-primary fw-bold"><asp:Label ID="lblbdnumber" Text='<%# Eval("lth_ID") %>' runat="server"></asp:Label></a>
                                                                 <div class="fs-8 text-muted fw-bold"><asp:Label ID="lblCreatedDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label></div>
                                                             </div>
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
                              
                            </div>
                            <!--end::Tab content-->
                        </div>
                        <!--end::Card body-->
                    </div>
                    <!--end::Timeline Widget 1-->
                </div>
                           <!--end::Row-->
							
                     
                              




                      </div>
                 </div>

                  <%-- card-2--%>
                <div class="col-lg-6">
                    
                    <div class="card card-flush">
                    
                         <!--begin::Row-->
                <div class="col-lg-12 mb-5">
                    <!--begin::Timeline Widget 1-->
                    <div class="card card-flush">
                        <!--begin::Card header-->
                        <div class="card-header pt-5">
                            <!--begin::Card title-->
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold text-dark"> تحميل</span>

                            </h3>
                            <!--end::Card title-->
                        </div>
                       
                        <!--begin::Card toolbar-->
                        <div class="card-toolbar" style="padding-top: 8px; padding-left: 5%;">
                            <!--begin::Tabs-->
                            <ul class="nav" style="justify-content:space-around";>
                                <li class="nav-item">

                                    <%-- <div style=" width: 8px; height: 8px; margin-top: 5px;background-color: lightgray;"></div>--%>
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 active" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Total">مخزون جيد
                                       <span class="ms-10"><asp:Label runat="server" ID="lblLOGoodStock" Text="25">  </asp:Label> </span></a>

                                </li>
                                <li class="nav-item" style="padding-left: 30px;">
                                    <a class="nav-link btn btn-sm btn-color-muted btn-active btn-active-light fs-4 fw-bold px-4 me-1 ms-20" data-kt-timeline-widget-1="tab" data-bs-toggle="tab" href="#kt_timeline_widget_1_Planned">مخزون سيء
                                        <span class="ms-10"><asp:Label runat="server" ID="lblLOBadStock" Text="20"> </asp:Label> </span></a>
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

                                                  <asp:Repeater runat="server" ID="rptLOGD">
                                                    <ItemTemplate>

                                                          <tr class="odd">
                                                                <td class="min-w-175px">
                                                                    <div class="position-relative ps-0 pe-3 py-0">
                                                                    <a href="#" class="mb-1 text-dark text-hover-primary fw-bold"> <asp:Label ID="lbllonumber" Text='<%# Eval("loh_ID") %>' runat="server"></asp:Label></a>
                                                                    <div class="fs-8 text-muted fw-bold"> <asp:Label ID="lblCus" Text='<%# Eval("ArabicCustomer") %>' runat="server"></asp:Label></div>
                                                                    </div>
                                                                 </td>                                                 
                                                           </tr>

                                                    </ItemTemplate>
                                                  </asp:Repeater>


                                            </tbody>
                                            <!--end::Table-->
                                        </table>

                                        <!--begin::Timeline-->
                                        <div hidden="hidden">
                                            <div id="kt_timeline_widget_1_2" class="vis-timeline-custom h-350px min-w-700px" data-kt-timeline-widget-1-image-root="assets/media/"></div>
                                        </div>

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

                                                 <asp:Repeater runat="server" ID="rptLOBD">
                                                    <ItemTemplate>

                                                       <tr class="even">
                                                            <td class="min-w-175px">
                                                               <div class="position-relative ps-0 pe-3 py-0">
                                                                <a href="#" class="mb-1 text-dark text-hover-primary fw-bold"> <asp:Label ID="lbllobdnum" Text='<%# Eval("loh_ID") %>' runat="server"></asp:Label></a>
                                                                <div class="fs-8 text-muted fw-bold"> <asp:Label ID="lblcus" Text='<%# Eval("ArabicCustomer") %>' runat="server"></asp:Label></div>
                                                                </div>
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
                               
                            </div>
                            <!--end::Tab content-->
                        </div>
                        <!--end::Card body-->



                    </div>
                    <!--end::Timeline Widget 1-->
                </div>
                <!--end::Row-->


                      </div>
                 </div>


            </div>
          </div>
      </div>
   
</asp:Content>
