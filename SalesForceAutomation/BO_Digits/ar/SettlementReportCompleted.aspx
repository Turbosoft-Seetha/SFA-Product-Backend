<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="SettlementReportCompleted.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.SettlementReportCompleted" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                         <div class="kt-portlet__head" style="border-bottom-style: ridge; border-bottom-width: thin;">

                         <div class="kt-portlet__head-actions col-lg-12 row">
                             <div class="col-lg-12 row" style="font-size: 15px; margin-bottom: 20px;">
                                  <div class="col-lg-4 " style=" padding-left: 25px;">
                                           
                                            <label  style="padding-top: 5px;">طريق : </label>
                                        
                                            <asp:Label ID="lblRoute" runat="server" style="font-weight: 600; padding-top: 5px;"></asp:Label>
                                       
                                    </div>
                                    <div class="col-lg-4 ">
                                        
                                            <label  style="padding-top: 5px;">رقم سري : </label>
                                       
                                        
                                            <asp:Label ID="lblProcessID" runat="server" style="font-weight: 600; padding-top: 5px;"></asp:Label>
                                        
                                    </div>
                                  
                                    <div class="col-lg-4 " style=" padding-left: 25px;">
                                        
                                            <label  style="padding-top: 5px;">تاريخ: </label>
                                        
                                        
                                            <asp:Label ID="lblDate" runat="server" style="font-weight: 600; padding-top: 5px;"></asp:Label>
                                       
                                    </div>
                                  

                                </div>
                           
                        </div>
                    </div>
                         <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="">
                                        <ContentTemplate>
                                              <div class="col-lg-12 row mb-2 pt-4">

                                                    <div class="col-sm-4">
                                                        <span class="svg-icon svg-icon-2">
                                                            <svg id="Group_1833" data-name="Group 1833" xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                              <path id="Path_1746" data-name="Path 1746" d="M0,0H17V17H0Z" fill="none" fill-rule="evenodd"/>
                                                              <path id="Path_1747" data-name="Path 1747" d="M10.833,8.667a2.833,2.833,0,1,1,2.833-2.833A2.833,2.833,0,0,1,10.833,8.667Z" transform="translate(-2.333 -0.875)" fill="#6092aa" opacity="0.3"/>
                                                              <path id="Path_1748" data-name="Path 1748" d="M3,18.1C3.275,14.719,6.019,13,9.363,13c3.391,0,6.178,1.624,6.385,5.1a.487.487,0,0,1-.532.567H3.515A.784.784,0,0,1,3,18.1Z" transform="translate(-0.875 -3.792)" fill="#6092aa"/>
                                                            </svg>

                                                        </span>
                                                        <%--<img src="../assets/media/UDP/User.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">مستخدم:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>

                                                    <div class="col-sm-4">
                                                        <span class="svg-icon svg-icon-2">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                              <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                                <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none"/>
                                                                <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3"/>
                                                                <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd"/>
                                                              </g>
                                                            </svg>

                                                        </span>
                                                      <%--  <img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">وقت البدء:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>

                                                    <div class="col-sm-4">
                                                        <span class="svg-icon svg-icon-2">
                                                           <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                              <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                                <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none"/>
                                                                <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3"/>
                                                                <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd"/>
                                                              </g>
                                                            </svg>

                                                        </span>
                                                        <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">اكتملت العملية:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblProcess" Font-Bold="true" runat="server">  </asp:Label></label>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 row mb-4 py-4 " style="border-bottom-style: ridge; border-bottom-width: thin;">

                                                    <div class="col-sm-4">
                                                        <span class="svg-icon svg-icon-2">
                                                           <svg id="Group_1825" data-name="Group 1825" xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                              <rect id="Rectangle_959" data-name="Rectangle 959" width="17" height="17" fill="none"/>
                                                              <path id="Path_1738" data-name="Path 1738" d="M15.11,13.72,11,9.61V3.742a.742.742,0,1,1,1.483,0V9l3.676,3.676,1.623-1.623a.371.371,0,0,1,.633.262v3.925a.371.371,0,0,1-.371.371H14.12a.371.371,0,0,1-.262-.633Z" transform="translate(-2.395 -1.255)" fill="#6092aa"/>
                                                              <path id="Path_1739" data-name="Path 1739" d="M6.155,16.116,7.639,17.6a.371.371,0,0,1-.262.633H3.4a.371.371,0,0,1-.371-.371V13.885a.371.371,0,0,1,.633-.262L5.1,15.063l2.246-1.9L8.306,14.3Z" transform="translate(-0.335 -3.882)" fill="#6092aa" opacity="0.3"/>
                                                            </svg>

                                                        </span>
                                                       <%-- <img src="../assets/media/UDP/version.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">إصدار:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblVersion" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
              
                                                    <div class="col-sm-4">
                                                        <span class="svg-icon svg-icon-2">
                                                           <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                              <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                                <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none"/>
                                                                <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3"/>
                                                                <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd"/>
                                                              </g>
                                                            </svg>

                                                        </span>
                                                        <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">وقت النهاية:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>

                                                    <div class="col-sm-4">
                                                        <span class="svg-icon svg-icon-2">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                              <g id="Group_1828" data-name="Group 1828" transform="translate(-0.305)">
                                                                <rect id="Rectangle_961" data-name="Rectangle 961" width="17" height="17" transform="translate(0.305)" fill="none"/>
                                                                <path id="Path_1742" data-name="Path 1742" d="M9.667,16.333a5.667,5.667,0,1,1,5.667-5.667A5.667,5.667,0,0,1,9.667,16.333Z" transform="translate(-1.167 -1.458)" fill="#6092aa" fill-rule="evenodd" opacity="0.3"/>
                                                                <path id="Path_1743" data-name="Path 1743" d="M11.833,4.169a5.744,5.744,0,0,0-1.417,0V3.417H9.708A.708.708,0,0,1,9.708,2h2.833a.708.708,0,1,1,0,1.417h-.708Z" transform="translate(-2.625 -0.583)" fill="#6092aa" fill-rule="evenodd"/>
                                                                <path id="Path_1744" data-name="Path 1744" d="M16.71,6.206l.585-.585a.708.708,0,1,1,1,1l-.554.554A5.7,5.7,0,0,0,16.71,6.206Z" transform="translate(-4.874 -1.579)" fill="#6092aa" fill-rule="evenodd"/>
                                                                <path id="Path_1745" data-name="Path 1745" d="M11.694,7.5h.052a.354.354,0,0,1,.353.327l.3,3.9a.354.354,0,0,1-.326.38h-.679a.354.354,0,0,1-.354-.354c0-.009,0-.018,0-.027l.3-3.9A.354.354,0,0,1,11.694,7.5Z" transform="translate(-3.22 -2.187)" fill="#6092aa" fill-rule="evenodd"/>
                                                              </g>
                                                            </svg>

                                                        </span>
                                                        <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">مدة:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblDuration" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>

                                                </div>
                                               
                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>

                     
                        <div class="kt-portlet__body">
                            <div class="col-lg-12 row">

                                <div class="demo-container size-medium">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                        <telerik:RadWizard RenderMode="Lightweight" ID="RadWizard1" runat="server" Height="700px" OnFinishButtonClick="RadWizard1_FinishButtonClick">
                                            <Localization Finish="Done" />
                                            <WizardSteps>
                                                <telerik:RadWizardStep Title="تقرير الطلبات" CssClass="loginStep">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title">تقرير الطلبات</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">إجمالي الطلبات :
                                                            <asp:Label ID="lblOrderCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">المبلغ الإجمالي:
                                                                <asp:Label ID="lblOrderAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvOrders" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvOrders_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="ord_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="طلب#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                         <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل باللغة العربية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="التاريخ والوقت" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="ord_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="ord_GrandTotal">
                                                                        </telerik:GridBoundColumn>
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
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="فواتير الائتمان">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title">فواتير الائتمان</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">إجمالي الائتمان :
                                                            <asp:Label ID="lblCreditCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">إجمالي مبلغ الائتمان :
                                                                <asp:Label ID="lblCreditAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvCredit" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvCredit_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="inv_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="فاتورة#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                         <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل باللغة العربية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="التاريخ والوقت" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="فارغ" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void">
                                                                        </telerik:GridBoundColumn>
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
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="الفواتير النقدية">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title">الفواتير النقدية</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">مجموع المبالغ النقدية   :
                                                            <asp:Label ID="lblCashCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">المبلغ النقدي الإجمالي:
                                                                <asp:Label ID="lblCashAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvCash" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvCash_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="inv_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="فاتورة#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="التاريخ والوقت" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="فارغ" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void">
                                                                        </telerik:GridBoundColumn>
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
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="تحصيل حسابات القبض">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title">تحصيل حسابات القبض</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">إجمالي حسابات القبض :
                                                            <asp:Label ID="lblARCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">إجمالي مبلغ الذمم المدينة :
                                                                <asp:Label ID="lblARAmount" runat="server"></asp:Label></span>
                                                            </div>
                                                        </div>

                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvAR" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvAR_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="arh_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="arh_ARNumber" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="حسابات الذمم المدينة#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="arh_ARNumber">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                          <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل باللغة العربية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="التاريخ والوقت" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="arh_PayType" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="arh_PayType">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="arh_CollectedAmount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="arh_CollectedAmount">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="فارغ" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void">
                                                                        </telerik:GridBoundColumn>
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
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="المجموعات المسبقة">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title">المجموعات المسبقة</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">مجموع مقدما :
                                                            <asp:Label ID="lblAdvanceCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">المبلغ الإجمالي مقدما:
                                                                <asp:Label ID="lblAdvanceAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvAdvance" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvAdvance_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="adp_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="adp_Number" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="يتقدم#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="adp_Number">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                         <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل باللغة العربية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="التاريخ والوقت" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="adp_PaymentMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="وضع الدفع" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="adp_PaymentMode">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="adp_Amount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="adp_Amount">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="فارغ" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void">
                                                                        </telerik:GridBoundColumn>
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
                                                </telerik:RadWizardStep>
                                                <%--<telerik:RadWizardStep Title="Debit Note">
                                            <div class="kt-portlet">
                                                <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom:15px;">
                                                    <div class="kt-portlet__head-label">
                                                        <h6 class="kt-portlet__head-title">Debit Note</h6>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 row" style="margin-top: -30px;  padding-top:20px; margin-bottom:20px;">
                                                    <div class="col-lg-6">
                                                        <span style="padding-top: 18px;">Total Debit Note Count :
                                                                <asp:Label ID="lblTotalDebitNoteCount" runat="server"></asp:Label></span>
                                                    </div>
                                                    <div class="col-lg-6" style="padding-left:165px;">
                                                        <span style="padding-top: 18px;">Total Debit Note Amount :
                                                                <asp:Label ID="lblTotalDebitNoteAmount" runat="server"></asp:Label></span>
                                                    </div>
                                                    
                                                </div>
                                                <div class="kt-portlet__body">
                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                        ID="grvDebitNote" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="grvDebitNote_NeedDataSource"
                                                        AllowFilteringByColumn="false"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="sdd_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="80%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_HigherUOM" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_HigherUOM">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_LowerUOM" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_LowerUOM">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_HigherQty" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_HigherQty">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_LowerQty" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_LowerQty">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_HigherPrice" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Higher Price" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_HigherPrice">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_LowerPrice" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Lower Price" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_LowerPrice">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_TotalQty" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Total Qty" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_TotalQty">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sdd_TotalPrice" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Total Price" FilterControlWidth="40%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="sdd_TotalPrice">
                                                                </telerik:GridBoundColumn>
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
                                        </telerik:RadWizardStep>--%>
                                                <telerik:RadWizardStep Title="قسط">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h3 class="kt-portlet__head-title">قسط</h3>
                                                            </div>
                                                        </div>
                                                        <div class="kt-portlet__body" style="padding-top: 0px;">
                                                            <div class="col-lg-12 row">
                                                                <div class="col-lg-12 row" style="border-bottom: 1px solid darkgrey; padding-bottom: 10px;">
                                                                    <div class="col-lg-5" style="border-left: 1px solid darkgrey;">
                                                                        <table class="col-lg-12">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th style="padding-bottom: 10px; color: green; font-weight: 400;">نقدي</th>
                                                                                    <th style="padding-bottom: 10px; color: green; font-weight: 400;">:</th>
                                                                                    <th style="padding-bottom: 10px; color: green; font-weight: 400;">
                                                                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                                        <asp:Label ID="lblPCash" runat="server"></asp:Label>
                                                                                    </th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">الفواتير النقدية</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                        <asp:Label ID="Label2" runat="server"></asp:Label>
                                                                                        <asp:Label ID="lblPCashInvoices" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">تحصيل المبالغ النقدية من حساب المدينين</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                        <asp:Label ID="Label3" runat="server"></asp:Label>
                                                                                        <asp:Label ID="lblPArCollectionCash" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">الدفع النقدي للتحصيل المسبق</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                        <asp:Label ID="Label4" runat="server"></asp:Label>
                                                                                        <asp:Label ID="lblPAdvanceCash" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="col-lg-7">
                                                                        <table class="col-lg-12">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th style="padding-bottom: 10px;">مجموع المبالغ النقدية</th>
                                                                                    <th></th>
                                                                                    <th></th>
                                                                                    <th style="padding-bottom: 10px;">تلقي النقدية</th>
                                                                                    <th style="padding-bottom: 10px;">التباين </th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">مال صعب</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                        <asp:Label ID="lblHardCash" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <telerik:RadAjaxPanel ID="rapHardCash" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                            <telerik:RadNumericTextBox ID="txtHardCash" runat="server" CssClass="form-control" Width="80%" EmptyMessage="0.00" Enabled="false"></telerik:RadNumericTextBox>
                                                                                        </telerik:RadAjaxPanel>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <asp:Label ID="lblHardCashVariance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">نقاط البيع</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                        <asp:Label ID="lblPOS" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <telerik:RadAjaxPanel ID="rapPos" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                            <telerik:RadNumericTextBox ID="txtPos" runat="server" CssClass="form-control" Width="80%" EmptyMessage="0.00" Enabled="false"></telerik:RadNumericTextBox>
                                                                                        </telerik:RadAjaxPanel>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <asp:Label ID="lblPOSVariance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">الدفع الالكتروني</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                        <asp:Label ID="lblOnlinePayment" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <telerik:RadAjaxPanel ID="rapOnlinePay" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                            <telerik:RadNumericTextBox ID="txtOnlinePayment" runat="server" CssClass="form-control" Width="80%" EmptyMessage="0.00" Enabled="false"></telerik:RadNumericTextBox>
                                                                                        </telerik:RadAjaxPanel>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <asp:Label ID="lblOnlinePaymentVariance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                                                    <div class="col-lg-6">
                                                                        <div class="col-lg-12 row" style="padding-left: 0px;">
                                                                            <div class="col-lg-5" style="padding-left: 0px; padding-right: 0px;">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">شيكات تحصيل الذمم المدينة</span>
                                                                            </div>
                                                                            <div class="col-lg-1">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
                                                                            </div>
                                                                            <div class="col-lg-6">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">
                                                                                    <asp:Label ID="Label5" runat="server"></asp:Label>
                                                                                    <asp:Label ID="lblARCollCheque" runat="server"></asp:Label></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <div class="col-lg-12 row" style="padding-left: 0px;">
                                                                            <div class="col-lg-6" style="padding-left: 0px; padding-right: 0px;">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">شيك التحصيل المسبق</span>
                                                                            </div>
                                                                            <div class="col-lg-1">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
                                                                            </div>
                                                                            <div class="col-lg-5">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">
                                                                                    <asp:Label ID="Label6" runat="server"></asp:Label>
                                                                                    <asp:Label ID="lblAdvCollCheque" runat="server"></asp:Label></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                                    ID="grvPayment" GridLines="None"
                                                                    ShowFooter="True" AllowSorting="True"
                                                                    OnNeedDataSource="grvPayment_NeedDataSource"
                                                                    AllowFilteringByColumn="false"
                                                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                    EnableAjaxSkinRendering="true"
                                                                    AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                    <ClientSettings>
                                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                    </ClientSettings>
                                                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                        ShowFooter="false" DataKeyNames="id"
                                                                        EnableHeaderContextMenu="true">
                                                                        <Columns>

                                                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="name" AllowFiltering="true" HeaderStyle-Width="30px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="name">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="type" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="يكتب" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="type">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="chequeNo" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="يفحص#" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="chequeNo">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="chequeDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="تحقق من التاريخ" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="chequeDate">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" HeaderText="صورة" HeaderStyle-Width="10px" HeaderStyle-Font-Size="Smaller"
                                                                                HeaderStyle-Font-Bold="true">
                                                                                <ItemTemplate>
                                                                                    <asp:HyperLink ID="Img" runat="server" NavigateUrl=' <%#  Eval("image") %>' Target="_blank">
                                                                                        <asp:Image ID="Image" runat="server" ImageUrl=' <%#  Eval("image") %>' Height="65px" />
                                                                                    </asp:HyperLink>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridBoundColumn DataField="amount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="amount">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="colID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="هوية" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="colID" Display="false">
                                                                            </telerik:GridBoundColumn>

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
                                                </telerik:RadWizardStep>
                                            </WizardSteps>
                                        </telerik:RadWizard>
                                    </telerik:RadAjaxPanel>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
