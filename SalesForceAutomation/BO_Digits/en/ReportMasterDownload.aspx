<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ReportMasterDownload.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ReportMasterDownload" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<%--    <span style="padding-bottom: 20px;">"please select Atmost 10 Customers For Your Better Perfomance"</span>--%>
    <div class="kt-portlet__body">
                         <div class="card-body" style="background-color:white; padding-bottom:10px;">
                        <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="50%" ID="RadPanelBar0" runat="server">
                            <Items>
                                <telerik:RadPanelItem Font-Bold="true" Text="Note:" Expanded="false" ForeColor="Blue" BackColor="white">
                                    <ContentTemplate>
                                        <div class="kt-portlet__body" style="background-color: white; display: grid;padding:15px;">
                                            <table>
                                                <td style="width: 100%">
                                                   
										<div class="fs-6 text-dark-400 fw-bold pe-7">please select Atmost 10 Customers For Your Better Perfomance </div>
										</td>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </telerik:RadPanelItem>
                            </Items>
                        </telerik:RadPanelBar>
                             </div>
                    </div>




    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

        <div class=" col-lg-12 row mt-5">

            <asp:PlaceHolder ID="lnkFilter" runat="server" Visible="false">
                <div class="col-lg-2 ">
                    <label class="control-label col-lg-12 ">Region</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                            ID="region" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="region_SelectedIndexChanged">
                        </telerik:RadComboBox>

                    </div>
                </div>
                <div class="col-lg-2">
                    <label class="control-label col-lg-12 ">Depot</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                            RenderMode="Lightweight"
                            ID="depot" runat="server" EmptyMessage="Select Depot"
                            OnSelectedIndexChanged="depot_SelectedIndexChanged" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>
                </div>
                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Area</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                            ID="dpoArea" runat="server" EmptyMessage="Select Area"
                            OnSelectedIndexChanged="dpoArea_SelectedIndexChanged" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>
                </div>
                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Subarea</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                            ID="dpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="dpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>
                </div>
                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Route</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                            ID="ddlroute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="ddlroute_SelectedIndexChanged" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>
                </div>
            </asp:PlaceHolder>
       </div>

       <div class="col-lg-12 row">
 <label class="control-label">Customer</label>

            <div class="col-lg-4">
                <telerik:RadComboBox Skin="Material" Filter="Contains" RenderMode="Lightweight"
                    ID="rdCustomer" runat="server" EmptyMessage="Select Customer" OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" CheckBoxes="true" AutoPostBack="true" Width="100%">
                </telerik:RadComboBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                    ControlToValidate="rdCustomer" ErrorMessage="Please Select Customer" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="col-lg-2">

                <asp:LinkButton ID="lnkAdvanceFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvanceFilter_Click">
                        Advanced Filter
                </asp:LinkButton>
            </div>
        </div>
    </telerik:RadAjaxPanel>
 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
    <div class="row g-5 g-xl-8">
        <div class="col-lg-12">
            <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
        </div>

        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkItemPriceUOM" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkItemPriceUOM_Click" BackColor="#E65B7C">
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
                    <div class="text-white fw-bold fs-2 mb-2">Item Price By<br /> UOM</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>

        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkSpecialPrice" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSpecialPrice_Click" BackColor="#429FD6">
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
                    <div class="text-white fw-bold fs-2 mb-2">Special Price Items With <br /> Customer By UOM</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>

        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkOutstandingInvoice" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkOutstandingInvoice_Click" BackColor="#5FB886">
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
                    <div class="text-white fw-bold fs-2 mb-2">Outstanding Invoice By <br /> Customer (Branch/HO)</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>

        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkTotalOutstandingInvoice" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkTotalOutstandingInvoice_Click" BackColor="#DEB832">
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
                    <div class="text-white fw-bold fs-2 mb-2">Total Outstanding Invoice </div> 
                    <div  class="text-white fw-bold fs-2 mb-2">By Customer (Branch/HO)</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" ValidationGroup="form" OnClick="LinkButton1_Click" BackColor="#BC8F8F">
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
                    <div class="text-white fw-bold fs-2 mb-2">Special Pricing</div> 
                    <div class="fw-semibold text-white">Click here to download </div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="CustomerItems" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" ValidationGroup="form" OnClick="CustomerItems_Click" BackColor="#800080">
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
                    <div class="text-white fw-bold fs-2 mb-2">Customer Items <br> standard price</div> 
                    <div class="fw-semibold text-white">Click here to download </div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
        </div>
        <div class="col-xl-4">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="CusWithoutSplPrice" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" ValidationGroup="form" OnClick="CusWithoutSplPrice_Click" BackColor="#8B4513">
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
                    <div class="text-white fw-bold fs-2 mb-2">Customer Items <br> Without Special Price</div> 
                    <div class="fw-semibold text-white">Click here to download </div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
