<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ReportDownload.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ReportDownload" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div class="col-lg-12 row" style="padding-bottom: 10px">

                         <div class="col-lg-3" >
                            <div class="col-lg-12">
                                <label class="control-label col-lg-12">طريق </label>
                            </div>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains"
                                    CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="حدد الطريق" >
                                </telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">من التاريخ</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="من تاريخ إلزامي" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">ان يذهب في موعد</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="حتى تاريخه إلزامي" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <!--begin::Row-->
    <div class="row g-5 g-xl-8">
        <div class="col-lg-12">
            <asp:Label ID="lblMessage" runat="server"  Font-Bold="true" ForeColor="Red"></asp:Label>
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkTotSalesByCatAndChannel" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkTotSalesByCatAndChannel_Click" BackColor="#3a5804">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">إجمالي المبيعات حسب الفئة والقناة</div>
                    <div class="fw-semibold text-white">انقر هنا لتنزيل التقرير</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkSalesReportByItemRoute" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSalesReportByItemRoute_Click" BackColor="#5e841a">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">تقرير المبيعات حسب البند <br /> طريق</div>
                    <div class="fw-semibold text-white">انقر هنا لتنزيل التقرير</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>

        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkSalesByCustomer" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSalesByCustomer_Click"BackColor="#83ad38">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">تقرير المبيعات من قبل العميل <br />طريق </div> 
                    <div class="fw-semibold text-white">انقر هنا لتنزيل التقرير</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkRouteCustomerVisit" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkRouteCustomerVisit_Click" BackColor="#713141">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">تقرير حالة الزيارة اليومية بقلم <br />طريق </div> 
                    <div class="fw-semibold text-white">يعتبر فقط من التاريخ
</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lblDailyStockByRouteItem" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lblDailyStockByRouteItem_Click" BackColor="#bb1840">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">تقرير حالة المخزون اليومي بقلم <br />عنصر طريق </div> 
                    <div class="fw-semibold text-white">يعتبر فقط من التاريخ
</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkStockStatusByRoute" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkStockStatusByRoute_Click" BackColor="#e75a7d">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">تقرير حالة المخزون بواسطة<br />عنصر طريق</div> 
                    <div class="fw-semibold text-white">يعتبر فقط من التاريخ</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMonthlySalesByCustomer" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMonthlySalesByCustomer_Click" BackColor="#d7a907">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">ملخص المبيعات الشهرية بقلم<br />العميل حسب الصنف</div> 
                    <div class="fw-semibold text-white">انقر هنا لتنزيل التقرير</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>

         <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMntlySalRetCusByRot" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMntlySalRetCusByRot_Click" BackColor="#f6c003">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">المبيعات والعوائد الشهرية <br />ملخص بواسطة العميل حسب الطريق </div> 
                    <div class="fw-semibold text-white">انقر هنا لتنزيل التقرير</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMntlySalRetItmByRot" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMntlySalRetItmByRot_Click" BackColor="#ecc127">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">قيمة المبيعات الشهرية والعائد <br />ملخص حسب العنصر حسب التوجيه</div> 
                    <div class="fw-semibold text-white">انقر هنا لتنزيل التقرير</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMntlySalQtyRetItmByRot" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMntlySalQtyRetItmByRot_Click" BackColor="#0f2661">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">كمية المبيعات الشهرية والإرجاع <br />ملخص حسب العنصر حسب التوجيه</div> 
                    <div class="fw-semibold text-white">انقر هنا لتنزيل التقرير</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>

    </div>
    <!--end::Row-->


</asp:Content>