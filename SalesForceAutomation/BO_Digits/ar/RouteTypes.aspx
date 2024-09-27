<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="RouteTypes.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.RouteTypes" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="lnkVanSales">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkDelivery">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkOrder">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkAr">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkMerchandising">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="col-lg-12">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">

                    <div class="col-lg-12 row">

                        <div class="col-lg-3">
                            <label class="control-label col-lg-12">تاريخ</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="من تاريخ إلزامي" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-2" style="text-align: center; padding-top: 10px; padding-left: 10px; top: 19px;">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="lnkFilter_Click" AutoPostBack="true">
                                                   تطبيق عامل التصفية
                            </asp:LinkButton>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <div class="col-xl-12">
                            <div class="card" style="background-color: #f1faff;">
                                <asp:LinkButton ID="lnkVanSales" runat="server" OnClick="lnkVanSales_Click">
                                    <div class="card-body" style="padding: 1rem 2rem;">
                                        <div class="py-2">
                                            <div class="col-lg-12 row">
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px solid;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblVanTotal" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">طرق مبيعات فان</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblVanStart" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تبدأ اليوم</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblVanLin" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تحميل في</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblVanLout" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تحميل</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblVanSettle" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">مستعمرة</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblVanEnd" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">يوم الانتهاء</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12" style="padding-top: 10px;">
                    <div class="kt-portlet">
                        <div class="col-xl-12">
                            <div class="card" style="background-color: #f1f3ff;">
                                <asp:LinkButton ID="lnkDelivery" runat="server" OnClick="lnkDelivery_Click">
                                    <div class="card-body" style="padding: 1rem 2rem;">
                                        <div class="py-2">
                                            <div class="col-lg-12 row">
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px solid;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblDeliveryTotal" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">طرق التسليم</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblDeliveryStart" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تبدأ اليوم</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblDeliveryLin" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تحميل في</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblDeliveryLout" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تحميل</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblDeliverySettle" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">مستعمرة</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblDeliveryEnd" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">يوم الانتهاء</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12" style="padding-top: 10px;">
                    <div class="kt-portlet">
                        <div class="col-xl-12">
                            <div class="card" style="background-color: #fcf1ff;">
                                <asp:LinkButton ID="lnkOrder" runat="server" OnClick="lnkOrder_Click">
                                    <div class="card-body" style="padding: 1rem 2rem;">
                                        <div class="py-2">
                                            <div class="col-lg-12 row">
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px solid;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblOrderTotal" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">طرق الطلب</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblOrderStart" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تبدأ اليوم</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500; color: lightgray;">0</span><br />
                                                                <span style="font-weight: 500; color: lightgray;">تحميل في</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500; color: lightgray;">0</span><br />
                                                                <span style="font-weight: 500; color: lightgray;">تحميل</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblOrderSettle" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">مستعمرة</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblOrderEnd" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">يوم الانتهاء</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12" style="padding-top: 10px;">
                    <div class="kt-portlet">
                        <div class="col-xl-12">
                            <div class="card" style="background-color: #fff8f0;">
                                <asp:LinkButton ID="lnkAr" runat="server" OnClick="lnkAr_Click">
                                    <div class="card-body" style="padding: 1rem 2rem;">
                                        <div class="py-2">
                                            <div class="col-lg-12 row">
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px solid;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblArTotal" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">حسابات
طريق القبض</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblArStart" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تبدأ اليوم</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500; color: lightgray;">0</span><br />
                                                                <span style="font-weight: 500; color: lightgray;">تحميل في</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500; color: lightgray;">0</span><br />
                                                                <span style="font-weight: 500; color: lightgray;">تحميل</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblArSettle" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">مستعمرة</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblArEnd" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">يوم الانتهاء</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12" style="padding-top: 10px;">
                    <div class="kt-portlet">
                        <div class="col-xl-12">
                            <div class="card" style="background-color: #f3fde5;">
                                <asp:LinkButton ID="lnkMerchandising" runat="server" OnClick="lnkMerchandising_Click">
                                    <div class="card-body" style="padding: 1rem 2rem;">
                                        <div class="py-2">
                                            <div class="col-lg-12 row">
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px solid;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblMerchTotal" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تجارة</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblMerchStart" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">تبدأ اليوم</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500; color: lightgray;">0</span><br />
                                                                <span style="font-weight: 500; color: lightgray;">تحميل في</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500; color: lightgray;">0</span><br />
                                                                <span style="font-weight: 500; color: lightgray;">تحميل</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="border-right: 1px dashed; text-align: center;">
                                                                <span style="font-weight: 500; color: lightgray;">0</span><br />
                                                                <span style="font-weight: 500; color: lightgray;">مستعمرة</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                                <div class="col-lg-2">
                                                    <!--begin::Item-->
                                                    <div class="d-flex flex-stack">
                                                        <div class="col-lg-12 row">
                                                            <div class="col-lg-12" style="text-align: center;">
                                                                <span style="font-weight: 500;">
                                                                    <asp:Label ID="lblMerchEnd" runat="server"></asp:Label></span><br />
                                                                <span style="font-weight: 500;">يوم الانتهاء</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--end::Item-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
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
                <div class="col-lg-12" style="padding-top: 10px;">
                    <div class="kt-portlet">
                        <div class="col-xl-12">
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        OnItemCommand="grvRpt_ItemCommand"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="udp_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                            ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كود الطريق" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="طريق" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                </telerik:GridBoundColumn>

                                                 <telerik:GridBoundColumn DataField="rot_ArabicName" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="اسم المسار بالعربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_ArabicName">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="startTime" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تبدأ اليوم" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="startTime">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="loadInTime" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تحميل في" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="loadInTime">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="LoadOutTime" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تحميل" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="LoadOutTime">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="settlementTime" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="مستعمرة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="settlementTime">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="endTime" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="يوم الانتهاء" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="endTime">
                                                </telerik:GridBoundColumn>

                                            </Columns>
                                        </MasterTableView>
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
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