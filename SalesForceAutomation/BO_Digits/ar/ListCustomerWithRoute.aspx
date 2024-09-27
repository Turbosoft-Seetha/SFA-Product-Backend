<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ListCustomerWithRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ListCustomerWithRoute" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <asp:ImageButton ID="Excel" runat="server" ImageUrl="../assets/media/icons/excel.png" Style="height: 50px;" ToolTip="تحميل"
        OnClick="Excel_Click" AlternateText="Xlsx" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="padding: 20px; background-color: white;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <div class=" col-lg-12 row" style="padding-bottom: 10px">
                            <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false">
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">منطقة</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="ddlregion" runat="server" EmptyMessage="اختر المنطقة" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">مستودع</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                            RenderMode="Lightweight"
                                            ID="ddldepot" runat="server" EmptyMessage="حدد المستودع"
                                            OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">منطقة</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="ddldpoArea" runat="server" EmptyMessage="حدد المنطقة"
                                            OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">المنطقة الفرعية</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="ddldpoSubArea" runat="server" EmptyMessage="حدد المنطقة الفرعية" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                            </asp:PlaceHolder>
                        </div>
                        <div class=" col-lg-12 row" style="padding-bottom: 10px">

                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">طريق</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox Skin="Material" Filter="Contains" RenderMode="Lightweight"
                                        ID="rdRoute" runat="server" EmptyMessage="حدد الطريق">
                                    </telerik:RadComboBox>

                                </div>
                            </div>

                            <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px;">
                                <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                                                   تطبيق عامل التصفية
                                </asp:LinkButton>
                            </div>
                            <div class="col-lg-2" style="text-align: center; padding-top: 15px; margin-left: -1px; width: auto;">
                                <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click">
                                                    تصفية متقدم
                                </asp:LinkButton>
                            </div>

                        </div>
                        <!--end: Search Form -->
                        
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-portlet__body" style="margin-top: 20px;">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="60" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="cus_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            

                                            <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="كود الطريق" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" طريق" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="rot_ArabicName" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" اسم المسار العربي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_ArabicName">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" عميل" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="الاسم عربي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_ShortName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم قصير" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_ShortName">
                                            </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="cus_ShortNameArabic" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="الاسم المختصر باللغة العربية" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_ShortNameArabic">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Type" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="يكتب" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Type">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Address" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="عنوان" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Address">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_AddressArabic" AllowFiltering="true" HeaderStyle-Width="140px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="العنوان عربي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_AddressArabic">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Email" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="بريد إلكتروني" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Email">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Phone" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="هاتف" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Phone">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_WhatsappNumber" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="واتس اب لا" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_WhatsappNumber">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_ContactPerson" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="الشخص الذي يمكن الاتصال به" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_ContactPerson">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_ContactPerson_ar" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="مسؤول الاتصال عربي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_ContactPerson_ar">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_GeoCode" AllowFiltering="true" HeaderStyle-Width="160px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="GeoCode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_GeoCode" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="الرمز الجغرافي" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Map" ID="RadImageButton3" Visible="true" AlternateText="Map" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Compass.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="cus_RecaptureGeo" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="استعادة الرمز الجغرافي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_RecaptureGeo">
                                            </telerik:GridBoundColumn>
                                            <%--<telerik:GridBoundColumn DataField="cus_TotalCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Total Cr.Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_TotalCreditLimit">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_UsedCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Used Cr.Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_UsedCreditLimit">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_CreditDays" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Credit Days" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_CreditDays">
                                            </telerik:GridBoundColumn>--%>
                                            <telerik:GridBoundColumn DataField="cus_IsVATEnabled" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" تمكين ضريبة القيمة المضافة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_IsVATEnabled">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="are_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="منطقة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_are_Name">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="are_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="المنطقة العربية" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="are_NameArabic">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cls_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="فصل" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cls_Name">
                                            </telerik:GridBoundColumn>
                                              <telerik:GridBoundColumn DataField="cls_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="كلاس عربي" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cls_NameArabic">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="حالة" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
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
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                    </div>
                </div>
            </div>
    </div>
    </div>
</asp:Content>
