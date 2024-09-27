<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewCustomerRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewCustomerRoute" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color:white; padding:20px;" >
                   
                    <div class="kt-portlet__head" style="padding-top: 5px; padding-bottom: 8px;">
                        <div class="kt-portlet__head-label" style="border-bottom-style:inset">
                            <h3 class="kt-portlet__head-title">
                            
                            <telerik:RadLabel id="cusroute" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                            </h3>
                           
                        </div>
                      
                    </div>

                    <!--begin::Form-->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">
                            
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false" 
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="rcs_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>

                                        

                                       

                                         <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="190px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود الطريق" FilterControlWidth="100%" visible="true"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code" >
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="cus_ID" AllowFiltering="true" HeaderStyle-Width="190px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="عميل" FilterControlWidth="100%" Display="false"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_ID">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cus_code" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_code" >
                                        </telerik:GridBoundColumn>
                                       
                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="190px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="عميل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="190px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل بالعربية" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_cusType" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="نوع العميل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_cusType" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_PaymentModes" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="طرق الدفع" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_PaymentModes" Visible="true">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="rcs_CustCategoryType" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="نوع فئة العميل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_CustCategoryType" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_TotalCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="إجمالي حد الائتمان" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_TotalCreditLimit" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_UsedCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="حد الائتمان المستخدم" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_UsedCreditLimit" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_AvailableCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="حد الائتمان المتاح" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_AvailableCreditLimit" Visible="true">
                                        </telerik:GridBoundColumn>
                                        
                                        <telerik:GridBoundColumn DataField="rcs_UsedOrderCredit" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="رصيد الأمر المستخدم" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_UsedOrderCredit" Visible="true">
                                        </telerik:GridBoundColumn>
                                        
                                        <telerik:GridBoundColumn DataField="rcs_UsedInvoiceCredit" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="ائتمان الفاتورة المستخدمة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_UsedInvoiceCredit" Display="false">
                                        </telerik:GridBoundColumn>
                                        
                                         <telerik:GridBoundColumn DataField="rcs_PDC_Amount" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="PDC Amount" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_PDC_Amount" Display="false">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_CreditDays" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="أيام الائتمان" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_CreditDays" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_PaymentTerms" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="السماح بالنقد لعملاء الائتمان" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_PaymentTerms" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_NoOfInvoice" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="عدد الفواتير" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_NoOfInvoice" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_IsVAT" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="ضريبة القيمة المضافة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsVAT" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_IsHold" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="يمسك" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsHold" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_SelectionType" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="نوع الاختيار" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_SelectionType" Visible="true">
                                        </telerik:GridBoundColumn>
                                        
                                        <telerik:GridBoundColumn DataField="rcs_FencingRadius" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="نصف قطر المبارزة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_FencingRadius" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_OnCallFeatures" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="على ميزات الاتصال" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_OnCallFeatures" Visible="true">
                                        </telerik:GridBoundColumn>
                                        
                                        <telerik:GridBoundColumn DataField="IsSalesOrder" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="طلب المبيعات" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsSalesOrder" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_IsSalesJob" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="وظيفة المبيعات" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsSalesJob">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="IsInvoicing_Sales" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="فواتير المبيعات" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_Sales" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="IsInvoicing_GR" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="فواتير عائد جيد" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_GR" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="IsInvoicing_BR" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="فواتير مرتجعة سيئة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_BR" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="IsInvoicing_FG" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="خالية من فواتير التكلفة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_FG" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="IsAR" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="الحسابات المستحقة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsAR" Visible="true">
                                        </telerik:GridBoundColumn>
	
                                        <telerik:GridBoundColumn DataField="rcs_IsAdvPayment" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="دفعه مقدمه" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsAdvPayment" Visible="true">
                                        </telerik:GridBoundColumn>
                                        
                                        <telerik:GridBoundColumn DataField="IsMerchandising" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="تجارة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsMerchandising" Visible="true">
                                        </telerik:GridBoundColumn>                                         
                                        
                                        <telerik:GridBoundColumn DataField="rcs_VoidEnable" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="تمكين باطل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_VoidEnable" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_RoundAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="المبلغ المستدير" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_RoundAmount" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_IsPrintOut" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="اطبع" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsPrintOut" Visible="true">
                                        </telerik:GridBoundColumn>
                                       
                                        <telerik:GridBoundColumn DataField="rcs_IsSignatureInvoice" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="فاتورة التوقيع" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsSignatureInvoice" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_IsSignatureAR" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="توقيع حسابات القبض" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsSignatureAR" Visible="true">
                                        </telerik:GridBoundColumn>
                                       
                                        <telerik:GridBoundColumn DataField="rcs_IsRemarkInvoice" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="ملاحظات الفاتورةملاحظات الفاتورة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsRemarkInvoice" Visible="true">
                                        </telerik:GridBoundColumn>
                                       
                                        <telerik:GridBoundColumn DataField="rcs_IsRemarkOrderReq" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="ملاحظات طلب الطلب" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsRemarkOrderReq" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_IsOrderPromo" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="الترقية بالترتيب" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsOrderPromo" Visible="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rcs_IsFGExemption" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="إعفاء جيد مجاني" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_IsFGExemption" Visible="true">
                                        </telerik:GridBoundColumn>
                                         
                                          <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="حالة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status" Visible="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rcs_MerchFeatures" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="ميزات التجارة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_MerchFeatures" Visible="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rcs_MandFeatures" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="الميزات الإلزامية" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_MandFeatures" Visible="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rcs_EnforceCustSelection" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="فرض اختيار العميل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rcs_EnforceCustSelection" Visible="true">
                                        </telerik:GridBoundColumn>
                                         
                                    </Columns>
                                </MasterTableView>
                                <PagerStyle AlwaysVisible="true" />
                                <GroupingSettings CaseSensitive="false" />
                                <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                    <Resizing AllowColumnResize="true"></Resizing>
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                        
                    </div>
                  </telerik:RadAjaxPanel>
                     <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
