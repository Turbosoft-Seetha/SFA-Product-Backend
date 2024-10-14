<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ReportDownload.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ReportDownload" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {

            $('#modalConfirm').modal('show');
        }
        function FailureAlert(res) {
            $('#kt_modal_1_5').modal('show');
            $('#fail').text(res);
          
        }
        function closeModal() {
            $('#modalConfirm').modal('hide');
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col-lg-12">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 20px;">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

                        <div class=" col-lg-12 row mb-5">

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

                            </asp:PlaceHolder>
                        </div>
                        <div class="col-lg-12 row">

                            <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                <label class="control-label col-lg-12">Enter Route Code or Name to Populate Route <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="SearchTextBox" runat="server" CssClass="form-control" Width="100%" Enabled="true"></telerik:RadTextBox>



                                </div>
                            </div>
                            <div class="col-lg-4" style="padding-top: 15px; margin-left: 15px;">
                                <asp:LinkButton ID="lnkSearch" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" CausesValidation="false" OnClick="lnkSearch_Click">
                          Search
                                </asp:LinkButton>
                            </div>

                        </div>
                        <div class="col-lg-12 row" style="padding-top: 10px">

                            <div class="col-lg-3">
                                <div class="col-lg-12">
                                    <label class="control-label col-lg-12">Route </label>
                                </div>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains" Width="100%"
                                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route">
                                    </telerik:RadComboBox>
                                </div>
                            </div>

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%">
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" >
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                </div>
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
                </div>
            </div>
        </div>
    </div>


    <!--begin::Row-->
    <div class="row g-5 g-xl-8" style="margin-top: -30px;">
        <div class="col-lg-12">
            <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
        </div>
        <div class="col-xl-4">
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="lnkTotSalesByCatAndChannel" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkTotSalesByCatAndChannel_Click" BackColor="#3a5804">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                        
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">1</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Total Sales By Category <br/> & Channel</div>
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
           </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkSalesReportByItemRoute" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSalesReportByItemRoute_Click" BackColor="#5e841a">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">2</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Sales Report By Item By <br /> Route</div>
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkSalesByCustomer" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSalesByCustomer_Click" BackColor="#83ad38">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">3</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Sales Report By Customer By <br />Route </div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkRouteCustomerVisit" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkRouteCustomerVisit_Click" BackColor="#713141">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">4</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Daily Visit Status Report By <br />Route </div> 
                    <div class="fw-semibold text-white">Only considers from date</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lblDailyStockByRouteItem" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lblDailyStockByRouteItem_Click" BackColor="#bb1840">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <%--<span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">5</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Daily Stock Status Report By <br />Item By Route </div> 
                    <div class="fw-semibold text-white">Only considers from date</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>

        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkStockStatusByRoute" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkStockStatusByRoute_Click" BackColor="#e75a7d">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">6</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Stock Status Report By <br />Item By Route </div> 
                    <div class="fw-semibold text-white">Only considers from date</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMonthlySalesByCustomer" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMonthlySalesByCustomer_Click" BackColor="#d7a907">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">7</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Monthly Sales Summary By <br />Customer By Item </div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMntlySalRetCusByRot" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMntlySalRetCusByRot_Click" BackColor="#f6c003">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">8</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Monthly Sales & Return <br />Summary By Customer By Route </div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel9" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMntlySalRetItmByRot" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMntlySalRetItmByRot_Click" BackColor="#ecc127">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">9</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Monthly Sales Val & Return <br />Summary By Item By Route</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel10" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkMntlySalQtyRetItmByRot" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkMntlySalQtyRetItmByRot_Click" BackColor="#0f2661">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">10</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Monthly Sales Qty & Return <br />Summary By Item By Route</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel11" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkSalesReturnByHO" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSalesReturnByHO_Click" BackColor="#072674">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">11</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2"> Sales & Return Qty<br />Summary By HO</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>
        <div class="col-xl-4">
              <telerik:RadAjaxPanel ID="RadAjaxPanel12" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
            <!--begin::Statistics Widget 5-->
            <asp:LinkButton ID="lnkSalesReturnByArea" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="lnkSalesReturnByArea_Click" BackColor="#103185">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                    <%--<span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">12</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2"> Sales & Return Qty By<br />Subarea By Area</div> 
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
            </asp:LinkButton>
            <!--end::Statistics Widget 5-->
                  </telerik:RadAjaxPanel>
        </div>

          <div class="col-xl-4">
               <telerik:RadAjaxPanel ID="RadAjaxPanel13" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
      <!--begin::Statistics Widget 5-->
      <asp:LinkButton ID="GetInvoiceDetails" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="GetInvoiceDetails_Click1" BackColor="#8B4513">
          <!--begin::Body-->
          <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
              <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
              <%--<span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                  <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                      <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                      <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                  </svg>
              </span>--%>
               <h4 class="text-white fw-bold fs-1 mb-2">13</h4>
              <!--end::Svg Icon-->
              <%--<div>
                  <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
              </div>--%>
              <div class="text-white fw-bold fs-2 mb-2">Item Wise Sales & Quantity by Route</div> 
              <div class="fw-semibold text-white">Click here to download report</div>
          </div>
          <!--end::Body-->
      </asp:LinkButton>
      <!--end::Statistics Widget 5-->
                   </telerik:RadAjaxPanel>
  </div>

          <div class="col-xl-4">
             <telerik:RadAjaxPanel ID="RadAjaxPanel14" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                    <!--begin::Statistics Widget 5-->
                    <asp:LinkButton ID="getItemwiseSales" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="getItemwiseSales_Click" BackColor="#CD853F">
                        <!--begin::Body-->
                        <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                            <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                           <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                                <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                                    <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                                    <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                                </svg>
                            </span>--%>
                             <h4 class="text-white fw-bold fs-1 mb-2">14</h4>
                            <!--end::Svg Icon-->
                            <%--<div>
                                <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                            </div>--%>
                            <div class="text-white fw-bold fs-2 mb-2">Item Wise Sales <br />& Quantity</div> 
                            <div class="fw-semibold text-white">Click here to download report</div>
                        </div>
                        <!--end::Body-->
                    </asp:LinkButton>
                    <!--end::Statistics Widget 5-->
             </telerik:RadAjaxPanel>
         </div>

          <div class="col-xl-4">
            <telerik:RadAjaxPanel ID="RadAjaxPanel15" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="focussales" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="focussales_Click" BackColor="#3a5804">
                <!--begin::Body-->
                <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
                    <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
                   <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                        <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                            <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                            <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                        </svg>
                        
                    </span>--%>
                    <h4 class="text-white fw-bold fs-1 mb-2">15</h4>
                    <!--end::Svg Icon-->
                    <%--<div>
                        <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
                    </div>--%>
                    <div class="text-white fw-bold fs-2 mb-2">Focus-Sales <br />Export</div>
                    <div class="fw-semibold text-white">Click here to download report</div>
                </div>
                <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
           </telerik:RadAjaxPanel>
        </div>

        <div class="col-xl-4">
            <telerik:RadAjaxPanel ID="RadAjaxPanel16" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                <!--begin::Statistics Widget 5-->
                <asp:LinkButton ID="ItemWise" runat="server" CssClass="card hoverable card-xl-stretch mb-xl-8" OnClick="ItemWise_Click" BackColor="#ff9999">
        <!--begin::Body-->
        <div class="card-body" style="background-image: url('../assets/media/icons/Icon-feather-download.svg'); background-repeat: no-repeat; text-align: right;">
            <!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm002.svg-->
           <%-- <span class="svg-icon svg-icon-white svg-icon-3x ms-n1" style="margin-right: -10px;">
                <svg width="20" height="20" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M13.0021 10.9128V3.01281C13.0021 2.41281 13.5021 1.91281 14.1021 2.01281C16.1021 2.21281 17.9021 3.11284 19.3021 4.61284C20.7021 6.01284 21.6021 7.91285 21.9021 9.81285C22.0021 10.4129 21.5021 10.9128 20.9021 10.9128H13.0021Z" fill="currentColor" />
                    <path opacity="0.3" d="M11.0021 13.7128V4.91283C11.0021 4.31283 10.5021 3.81283 9.90208 3.91283C5.40208 4.51283 1.90209 8.41284 2.00209 13.1128C2.10209 18.0128 6.40208 22.0128 11.3021 21.9128C13.1021 21.8128 14.7021 21.3128 16.0021 20.4128C16.5021 20.1128 16.6021 19.3128 16.1021 18.9128L11.0021 13.7128Z" fill="currentColor" />
                    <path opacity="0.3" d="M21.9021 14.0128C21.7021 15.6128 21.1021 17.1128 20.1021 18.4128C19.7021 18.9128 19.0021 18.9128 18.6021 18.5128L13.0021 12.9128H20.9021C21.5021 12.9128 22.0021 13.4128 21.9021 14.0128Z" fill="currentColor" />
                </svg>
                
            </span>--%>
            <h4 class="text-white fw-bold fs-1 mb-2">16</h4>
            <!--end::Svg Icon-->
            <%--<div>
                <asp:Label ID="lblSchVisNoTrans" runat="server" CssClass="text-white fw-bold fs-2 mb-2 mt-5" Text="0"></asp:Label>
            </div>--%>
            <div class="text-white fw-bold fs-2 mb-2">Item-Wise Summary<br />Report</div>
            <div class="fw-semibold text-white">Click here to download report</div>
        </div>
        <!--end::Body-->
                </asp:LinkButton>
                <!--end::Statistics Widget 5-->
            </telerik:RadAjaxPanel>
        </div>

    </div>
    <!--end::Row-->

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to download..??
                    </h5>
                </div>
                <div class="modal-footer">

                    <asp:LinkButton ID="download" runat="server" Text="Yes" OnClick="download_Click" OnClientClick="cancelModal(modalConfirm);" CssClass="btn btn-sm fw-bold btn-primary"></asp:LinkButton>

                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="fail"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
