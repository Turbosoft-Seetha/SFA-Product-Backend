<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="CustomerVisits.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.CustomerVisits" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <div class="col-lg-12 row">
        <div class="col-lg-4">
            <label class="control-label col-lg-12">تاريخ</label>
            <div class="col-lg-12">
                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="col-lg-4">
            <label class="control-label col-lg-12">طريق</label>
            <div class="col-lg-12">
                <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Filter="Contains" Width="100%" RenderMode="Lightweight"></telerik:RadComboBox>
                <asp:RequiredFieldValidator ID="dfs" runat="server" ControlToValidate="rdRoute" ForeColor="Red" ErrorMessage="<br/>Please Choose Route"
                    Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="col-lg-4" style="text-align: end; padding-top: 10px;">
            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="true" OnClick="lnkFilter_Click">
                                                   تطبيق عامل التصفية
            </asp:LinkButton>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

       

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        
          
        <div class="col-lg-12 row">

          
                              

            <div class="col-lg-4">

                <div class="card card-flush mb-5">



                    <div class=" card-header border-0 pt-5">
                        <div class="card-title align-items-start flex-column">

                            <span class="card-label fw-bold text-dark"> 
                                <asp:Label ID="lblCusCode" runat="server" Text="0"></asp:Label></span>
                            <span class=" text-text-grey fw-semibold fs-7"> 
                                <asp:Label ID="lblCusName" runat="server" Text="0"></asp:Label>
                            </span>

                        </div>

                        <div class="card-toolbar">
                            <span class="text-muted mt-1 fw-semibold fs-7" style="margin: auto;">
                                <asp:Label ID="lblCusVisitCount" runat="server" Text="0"></asp:Label></span> 
                        </div>

                    </div>

                    <div class="separator separator-lined my-5" style="margin-left: 30px; margin-right: 30px; border-width: 2px;">
                    </div>

                    <div class="card-body pt-1">
                     
                        
                        <div class="table-responsive pb-10" style="height: 630px;">

                            <!--begin::Table-->
                            <table id="sa" class=" table-row-dashed align-middle fs-6 gy-4 my-0 pb-3">

                                <tbody>
                                   
                                     <asp:Repeater runat="server" ID="rptCusVisit"  OnItemCommand="rptCusVisit_ItemCommand" >
                                                    <ItemTemplate>

                                   
                                     <asp:LinkButton ID="btncusvisit" runat="server" CommandName="itemClick"  CommandArgument='<%# Eval("cse_ID")%>' >
                                        <asp:Panel runat="server" ID="rowpanel"  style="padding:5px" >
                                    
                                            <div class="position-relative ps-0 pe-3 py-2" >
                                                <span class="mb-1 text-dark  fw-bold">
                                                     <asp:Label ID="lblVisitTime" Text='<%# Eval("CreatedDate") +"|"+ Eval("cse_StartTime")+"-"+Eval("cse_EndTime")%>' runat="server"></asp:Label></span><br />
                                                <span class="mb-4 text-dark fw-semibold"> <asp:Label ID="lblVisitNo" Text='<%#"يزور-"+ Eval("num_row")%>' runat="server"></asp:Label></span>
                                            </div>
                                              
                                        </asp:Panel>
                                         </asp:LinkButton>
   
                                    
                                    </itemTemplate>
                                         </asp:Repeater>

                                      
                                                       
                                </tbody>
                            </table>

                        </div>



                    </div>


                </div>

            </div>

            <div class="col-lg-8" >
                <div class="card card-flush mb-5">

                    <div class=" card-header border-0 pt-5">
                        <div class="card-title align-items-start flex-column">

                            <span class="card-label fw-bold text-dark"> 
                                <asp:Label ID="lblgridCusCode" runat="server" Text="0"></asp:Label></span>
                            <span class=" text-text-grey fw-semibold fs-7"> 
                                <asp:Label ID="lblGridCusName" runat="server" Text="0"></asp:Label>
                            </span>
                        </div>


                    </div>


                    <div class="card-body" style="background-color: white; padding: 20px;">

                        <div class="col-lg-12 row">


                            <div class="col-lg-12 row" style="padding-top: 10px;">
                                <div class="col-lg-4 form-group">

                                    <!--begin::Wrapper-->
                                    <div class="d-flex align-items-center me-3">
                                        <!--begin::Icon-->
                                        <img src="../assets/media/icons/date.png" class="me-3 w-25px" alt="" />
                                        <!--end::Icon-->
                                        <!--begin::Section-->
                                        <div class="flex-grow-1">
                                            <span class="fs-9 text-grey fw-semibold">تاريخ</span><br />
                                            <span class="mb-1  fs-7 text-dark  fw-bold">
                                                <asp:Label ID="lblDate" runat="server" Text="0"></asp:Label> </span>
                                        </div>
                                        <!--end::Section-->
                                    </div>
                                    <!--end::Wrapper-->



                                </div>

                                <div class="col-lg-4 form-group">

                                    <!--begin::Wrapper-->
                                    <div class="d-flex align-items-center me-3">
                                        <!--begin::Icon-->
                                        <img src="../assets/media/icons/startday.png" class="me-3 w-25px" alt="" />
                                        <!--end::Icon-->
                                        <!--begin::Section-->
                                        <div class="flex-grow-1">
                                            <span class="fs-9 text-grey fw-semibold">بداية العميل</span><br />
                                            <span class="mb-1  fs-7 text-dark  fw-bold"> 
                                                <asp:Label ID="lblCusStart" runat="server" Text="0"></asp:Label></span>
                                        </div>
                                        <!--end::Section-->
                                    </div>
                                    <!--end::Wrapper-->

                                </div>
                                <div class="col-lg-4 form-group">

                                    <!--begin::Wrapper-->
                                    <div class="d-flex align-items-center me-3">
                                        <!--begin::Icon-->
                                        <img src="../assets/media/icons/endday1.png" class="me-3 w-25px" alt="" />
                                        <!--end::Icon-->
                                        <!--begin::Section-->
                                        <div class="flex-grow-1">
                                            <span class="fs-9 text-grey fw-semibold">خروج العميل</span><br />
                                            <span class="mb-1  fs-7 text-dark  fw-bold">
                                                <asp:Label ID="lblCusExit" runat="server" Text="0"></asp:Label></span>
                                        </div>
                                        <!--end::Section-->
                                    </div>
                                    <!--end::Wrapper-->
                                </div>


                            </div>
                            <div class="col-lg-12 row" style="padding-top: 30px;">
                               
                                    <ul class="nav nav-pills nav-pills-custom mb-3" style="justify-content:space-around;">
                                        <li class="nav-item mb-3 me-3 me-lg-5">
                                            <!--begin::Link-->
                                            <a class="nav-link d-flex justify-content-between flex-column flex-center overflow-hidden active w-80px h-85px py-4" data-bs-toggle="pill" href="#kt_stats_widget_1_tab_1">
                                                <!--begin::Icon-->
                                                <div class="nav-icon">
                                                    <img alt="" src="../assets/media/dashboard/invoices.png" class="" />
                                                </div>
                                                <!--end::Icon-->
                                                <!--begin::Subtitle-->
                                                <span class="nav-text text-gray-700 fw-bold fs-9 lh-1">وظيفة المبيعات</span>
                                                <!--end::Subtitle-->
                                                <!--begin::Bullet-->
                                                <span class="bullet-custom position-absolute bottom-0 w-100 h-8px bg-primary"></span>
                                                <!--end::Bullet-->
                                            </a>
                                            <!--end::Link-->
                                        </li>
                                   
                                    <%--  <div class="col-lg-12">
                                    
                                </div>--%>
                              

                              
                                        <li class="nav-item mb-3 me-3 me-lg-5">
                                            <!--begin::Link-->
                                            <a class="nav-link d-flex justify-content-between flex-column flex-center overflow-hidden w-80px h-85px py-4" data-bs-toggle="pill" href="#kt_stats_widget_1_tab_2">
                                                <!--begin::Icon-->
                                                <div class="nav-icon">
                                                    <img alt="Logo" src="../assets/media/dashboard/orderreq2.png" class="theme-light-show" />
                                                    <%--<img alt="Logo" src="../assets/media/dashboard/orderreq2.png" class="theme-dark-show" />--%>
                                                </div>
                                                <!--end::Icon-->
                                                <!--begin::Subtitle-->
                                                <span class="nav-text text-gray-700 fw-bold fs-9 lh-1">طلب</span>
                                                <!--end::Subtitle-->
                                                <!--begin::Bullet-->
                                                <span class="bullet-custom position-absolute bottom-0 w-100 h-8px bg-primary"></span>
                                                <!--end::Bullet-->
                                            </a>
                                            <!--end::Link-->
                                        </li>
                              
                                        <li class="nav-item mb-3 me-3 me-lg-5">
                                            <!--begin::Link-->
                                            <a class="nav-link d-flex justify-content-between flex-column flex-center overflow-hidden w-80px h-85px py-4" data-bs-toggle="pill" href="#kt_stats_widget_1_tab_3">
                                                <!--begin::Icon-->
                                                <div class="nav-icon">
                                                    <img alt="Logo" src="../assets/media/dashboard/ar2.png" class="theme-light-show" />
                                                    <img alt="Logo" src="../assets/media/dashboard/ar2.png" class="theme-dark-show" />
                                                </div>
                                                <!--end::Icon-->
                                                <!--begin::Subtitle-->
                                                <span class="nav-text text-gray-700 fw-bold fs-9 lh-1">حسابات
تحصيل المبالغ المستحقة القبض</span>
                                                <!--end::Subtitle-->
                                                <!--begin::Bullet-->
                                                <span class="bullet-custom position-absolute bottom-0 w-100 h-8px bg-primary"></span>
                                                <!--end::Bullet-->
                                            </a>
                                            <!--end::Link-->
                                        </li>
                                   
                               
                                        <li class="nav-item mb-3 me-3 me-lg-5">
                                            <!--begin::Link-->
                                            <a class="nav-link d-flex justify-content-between flex-column flex-center overflow-hidden w-80px h-85px py-4" data-bs-toggle="pill" href="#kt_stats_widget_1_tab_4">
                                                <!--begin::Icon-->
                                                <div class="nav-icon">
                                                    <img alt="Logo" src="../assets/media/dashboard/advance2.png" class="theme-light-show" />
                                                    <img alt="Logo" src="../assets/media/dashboard/advance2.png" class="theme-dark-show" />
                                                </div>
                                                <!--end::Icon-->
                                                <!--begin::Subtitle-->
                                                <span class="nav-text text-gray-700 fw-bold fs-9 lh-1">مجموعة مسبقة</span>
                                                <!--end::Subtitle-->
                                                <!--begin::Bullet-->
                                                <span class="bullet-custom position-absolute bottom-0 w-100 h-8px bg-primary"></span>
                                                <!--end::Bullet-->
                                            </a>
                                            <!--end::Link-->
                                        </li>
                                 
                              
                                        <li class="nav-item mb-3 me-3 me-lg-5">
                                           
                                            <!--begin::Link-->
                                            <a class="nav-link d-flex justify-content-between flex-column flex-center overflow-hidden w-80px h-85px py-4"  data-bs-toggle="pill" href="#kt_stats_widget_1_tab_5">
                                                <!--begin::Icon-->
                                                <div class="nav-icon">
                                                    <img alt="Logo" src="../assets/media/icons/merch2.png" class="theme-light-show" />
                                                    <img alt="Logo" src="../assets/media/icons/merch2.png" class="theme-dark-show" />
                                                </div>
                                                <!--end::Icon-->
                                                <!--begin::Subtitle-->
                                                <span class="nav-text text-gray-700 fw-bold fs-9 lh-1">تجارة</span>
                                                <!--end::Subtitle-->
                                                <!--begin::Bullet-->
                                                <span class="bullet-custom position-absolute bottom-0 w-100 h-8px bg-primary"></span>
                                                <!--end::Bullet-->
                                            </a>
                                            <!--end::Link-->
                                        </li>
                                 
                              
                                        <li class="nav-item mb-3 me-3 me-lg-5">
                                            <!--begin::Link-->
                                            <a class="nav-link d-flex justify-content-between flex-column flex-center overflow-hidden w-80px h-85px py-4" data-bs-toggle="pill" href="#kt_stats_widget_1_tab_6">
                                                <!--begin::Icon-->
                                                <div class="nav-icon">
                                                    <img alt="Logo" src="../assets/media/icons/others2.png" class="theme-light-show" />
                                                    <img alt="Logo" src="../assets/media/icons/others2.png" class="theme-dark-show" />
                                                </div>
                                                <!--end::Icon-->
                                                <!--begin::Subtitle-->
                                                <span class="nav-text text-gray-700 fw-bold fs-9 lh-1">تسويق الآخرين</span>
                                                <!--end::Subtitle-->
                                                <!--begin::Bullet-->
                                                <span class="bullet-custom position-absolute bottom-0 w-100 h-8px bg-primary"></span>
                                                <!--end::Bullet-->
                                            </a>
                                            <!--end::Link-->
                                        </li>
                                    </ul>

                               

                            </div>


                        </div>

                        <div class="tab-content">
                            <!--begin::Tap pane-->
                            <div class="tab-pane fade show active" id="kt_stats_widget_1_tab_1">
                                <!--begin::Table container-->
                                <div class="table-responsive">
                                   

                                  
                                            <!--begin::Portlet-->
                                           

                                                <!--end: Search Form -->
                                              
                                                  
                                                   
                                                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                            ID="grvRptSales" GridLines="None"
                                                            ShowFooter="True" AllowSorting="True"
                                                            OnNeedDataSource="grvRptSales_NeedDataSource"
                                                            AllowFilteringByColumn="true"
                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                            EnableAjaxSkinRendering="true"
                                                            AllowPaging="true" PageSize="10" CellSpacing="0">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="340px"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                ShowFooter="false" DataKeyNames="sal_ID"
                                                                EnableHeaderContextMenu="true">
                                                                <Columns>



                                         

                                            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="رقم الفاتورة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                            </telerik:GridBoundColumn>

                                            


                                            <telerik:GridBoundColumn DataField="sal_SalesAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="مبيعات" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sal_SalesAmount">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sal_GoodRtnAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="عودة جيدة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sal_GoodRtnAmount">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sal_BadRtnAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="عودة سيئة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sal_BadRtnAmount">
                                            </telerik:GridBoundColumn>

                                            <%-- <telerik:GridBoundColumn DataField="sal_FreeGoodAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Free Good Amount" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sal_FreeGoodAmount">
                                            </telerik:GridBoundColumn>--%>

                                          <%--  <telerik:GridBoundColumn DataField="sld_LineTotal" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Line Total" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_LineTotal">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sld_Discount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Discount" FilterControlWidth="40%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_Discount">
                                            </telerik:GridBoundColumn>--%>

                                            <telerik:GridBoundColumn DataField="sal_SubTotal" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="المجموع الفرعي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sal_SubTotal">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sal_VAT" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="ضريبة القيمة المضافة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sal_VAT">
                                            </telerik:GridBoundColumn>





                                         
                                            <telerik:GridBoundColumn DataField="Pay" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Pay">
                                            </telerik:GridBoundColumn>
                                           

                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="التوقيع" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>

                                                    <asp:HyperLink ID="img1" runat="server" NavigateUrl=' <%#"../" +  Eval("sal_Signature") %>' Target="_blank">
                                                        <asp:Image ID="salImage" runat="server" ImageUrl=' <%# "../" + Eval("sal_Signature") %>' Height="20px" width="20px"/>
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                           <%-- <telerik:GridBoundColumn DataField="sal_Remarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sal_Remarks">
                                            </telerik:GridBoundColumn>--%>
                                            <%-- <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
                                            </telerik:GridBoundColumn>--%>

                                            <%-- <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="Reciept Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>

                                                    <asp:HyperLink ID="img2" runat="server" NavigateUrl=' <%#"../"+  Eval("sal_RecieptImg") %>' Target="_blank">
                                                        <asp:Image ID="salRecieptImage" runat="server" ImageUrl=' <%# "../"+ Eval("sal_RecieptImg") %>' Height="20px" width="20px"/>
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <PagerStyle AlwaysVisible="true" />
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                <Resizing AllowColumnResize="true"></Resizing>
                                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                   
                                               
                                             
                                
                                </div>

                            </div>


                            <div class="tab-pane fade show" id="kt_stats_widget_1_tab_2">
                                <!--begin::Table container-->
                                <div class="table-responsive">


                                 

                                                <!--end: Search Form -->
                                               

                                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                            ID="grvRptOrder" GridLines="None"
                                                            ShowFooter="True" AllowSorting="True"
                                                            OnNeedDataSource="grvRptOrder_NeedDataSource"
                                                            AllowFilteringByColumn="true"
                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                            EnableAjaxSkinRendering="true"
                                                            AllowPaging="true" PageSize="10" CellSpacing="0">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="340px"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                ShowFooter="false" DataKeyNames="ord_ID"
                                                                EnableHeaderContextMenu="true">
                                                                <Columns>


<%--                                                                     <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rotname">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="usrName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Created By" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usrName">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="130px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
                                            </telerik:GridBoundColumn>--%>

<%--                                            <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cusname">
                                            </telerik:GridBoundColumn>--%>

                                              <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="رقم الأمر" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                            </telerik:GridBoundColumn>

                                          

                                            






                                         <%--   <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Exp Delivery Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery">
                                            </telerik:GridBoundColumn>--%>

                                           
                                             <telerik:GridBoundColumn DataField="odd_Price" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" مجموع" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="odd_Price">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="ord_Discount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="تخفيض" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_Discount">
                                            </telerik:GridBoundColumn>
                                            
                                             <telerik:GridBoundColumn DataField="ord_SubTotal" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="المجموع الفرعي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_SubTotal">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="ord_VAT" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="ضريبة القيمة المضافة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_VAT">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="ord_GrandTotal" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="المجموع الكلي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_GrandTotal">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="ord_PayMode" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_PayMode">
                                            </telerik:GridBoundColumn>
                                             <%--<telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Void" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="VoidUser" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="VoidUser" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="VoidMode" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Mode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="VoidMode" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="VoidTime" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Time" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="VoidTime" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="VoidPlatform" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Platform" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="VoidPlatform" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>--%>






                                         
                                                                </Columns>
                                                            </MasterTableView>
                                                            <PagerStyle AlwaysVisible="true" />
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                <Resizing AllowColumnResize="true"></Resizing>
                                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                  
                                               
                                      
                                           
                                </div>

                            </div>
                            <div class="tab-pane fade show " id="kt_stats_widget_1_tab_3">
                                <!--begin::Table container-->
                                <div class="table-responsive">


                                    

                                                <!--end: Search Form -->
                                            
                                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                            ID="grvRptAR" GridLines="None"
                                                            ShowFooter="True" AllowSorting="True"
                                                            OnNeedDataSource="grvRptAR_NeedDataSource"
                                                            AllowFilteringByColumn="true"
                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                            EnableAjaxSkinRendering="true"
                                                            AllowPaging="true" PageSize="10" CellSpacing="0">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="340px"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                ShowFooter="false" DataKeyNames="arh_ID"
                                                                EnableHeaderContextMenu="true">
                                                                <Columns>



                                             <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="arh_ARNumber" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="رقم حساب المدينين" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="arh_ARNumber">
                                            </telerik:GridBoundColumn>

                                           

                                         






                                            <telerik:GridBoundColumn DataField="arh_CollectedAmount" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="مبلغ التحصيل" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="arh_CollectedAmount" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>


                                               <telerik:GridBoundColumn DataField="arh_BalanceAmount" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="الرصيد <br> المبلغ" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="arh_BalanceAmount" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>

                                         
                                            <%--<telerik:GridBoundColumn DataField="arp_Type" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Payment<br>Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="arp_Type" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>--%>

                                             <telerik:GridBoundColumn DataField="Pay" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="طريقة الدفع" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Pay" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>






                                             <telerik:GridTemplateColumn UniqueName="Image" AllowFiltering="false"
                                                HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="التوقيع"
                                                HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="img2" ImageHeight="20px" ImageWidth="20px" runat="server"
                                                        ImageUrl='<%#"../" + Eval("arh_Signature")%>' NavigateUrl='<%#"../" + Eval("arh_Signature")%>' Height="20px" width="20px" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                      
                                                                </Columns>
                                                            </MasterTableView>
                                                            <PagerStyle AlwaysVisible="true" />
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                <Resizing AllowColumnResize="true"></Resizing>
                                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                  
                                              
                                      
                                           
                                </div>

                            </div>


                            <div class="tab-pane fade show " id="kt_stats_widget_1_tab_4">
                                <!--begin::Table container-->
                                <div class="table-responsive">


                                    

                                                <!--end: Search Form -->
                                            
                                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                            ID="grvRptAdvance" GridLines="None"
                                                            ShowFooter="True" AllowSorting="True"
                                                            OnNeedDataSource="grvRptAdvance_NeedDataSource"
                                                            AllowFilteringByColumn="true"
                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                            EnableAjaxSkinRendering="true"
                                                            AllowPaging="true" PageSize="10" CellSpacing="0">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="340px"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                ShowFooter="false" DataKeyNames="adp_ID"
                                                                EnableHeaderContextMenu="true">
                                                                <Columns>


                                             <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="adp_Number" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="رقم الدفعة المقدمة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="adp_Number">
                                            </telerik:GridBoundColumn>

                                           
                                             <telerik:GridBoundColumn DataField="adp_Amount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="مقدار" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="adp_Amount" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>



                                             <telerik:GridBoundColumn DataField="Pay" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Pay" ItemStyle-HorizontalAlign="Left">
                                            </telerik:GridBoundColumn>




                                              <telerik:GridTemplateColumn UniqueName="Signature" AllowFiltering="false"
                                                HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="التوقيع"
                                                HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="img1" ImageHeight="20px" ImageWidth="20px" runat="server"
                                                        ImageUrl='<%# "../" +Eval("adp_Signature")%>' NavigateUrl='<%#"../" + Eval("adp_Signature")%>' Height="20px" width="20px" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                                                </Columns>
                                                            </MasterTableView>
                                                            <PagerStyle AlwaysVisible="true" />
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                <Resizing AllowColumnResize="true"></Resizing>
                                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                  
                                               
                                           
                                </div>

                            </div>












                        </div>
                    </div>




                </div>



            

        </div>
              
            
    </div>
            
        </div>


</asp:Content>
