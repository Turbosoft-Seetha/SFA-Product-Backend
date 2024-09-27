<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RSServiceJobDetails.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RSServiceJobDetails" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

          <asp:LinkButton ID="btnInvoice" runat="server" ValidationGroup="form" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Invoice'
     CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true"  OnClick="btnInvoice_Click"   />
 <asp:LinkButton ID="btnRequireparts" runat="server" ValidationGroup="form" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Required Parts'
     CssClass="btn btn-sm fw-bold btn-success" CausesValidation="true"  OnClick="btnRequireparts_Click" />

     </telerik:RadAjaxPanel>
 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
 BackColor="Transparent"
 ForeColor="Blue">
     <div class="col-lg-12 text-center mt-5">
         <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
     </div>
 </telerik:RadAjaxLoadingPanel>
                        
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">




    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-form kt-form--label-right">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->
                                                <div class="col-3">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Service Job ID</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblJobID" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <div class="col-3">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Service Request ID</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblServicerqstID" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <!--end::Col-->
                                                <div class="col-3">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Date&Time</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>

                                                <div class="col-3">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Current Status</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>


                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>

                                <div class="col-lg-12 row ml-2" style="padding-left: 10px;">
                                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 10px;">
                                        <div class="kt-portlet__head-label">
                                            <h3 class="kt-portlet__head-title" style="font-size: 15px;">
                                                <span class="min-w-40px  fw-semibold text-gray-600 pt-5">Inspection Updates</span>
                                            </h3>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->
                                                <div class="col-6">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Working Status</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblWorkStatus" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <div class="col-6">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Service Type</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblServiceType" runat="server"></asp:Label>
                                                                </span>
                                                            </div>

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Comments :</span>

                                                            <%-- <div class="fs-7 fw-bold pt-1" style="color: black;">--%>

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">
                                                                <asp:Label ID="lblTypeComments" runat="server"></asp:Label>
                                                            </span>
                                                            <%-- </div>--%>
                                                        </div>


                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <!--end::Col-->


                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>
                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->

                                                <div class="col-6">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Warranty</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblWarranty" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>

                                                <div class="col-6">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Remarks</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblRemarks" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <!--end::Col-->


                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>


                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->

                                                <div class="col-12">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-6" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Attached Images of Job</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <div class="col-lg-12 ">
                                                                    <asp:HiddenField ID="HiddenField2" runat="server" />
                                                                    <asp:PlaceHolder ID="pnljob" runat="server"></asp:PlaceHolder>

                                                                </div>
                                                            </div>


                                                        </div>
                                                        <div class="col-6" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Signature</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <div class="col-lg-12 ">
                                                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                                                    <asp:PlaceHolder ID="pnlSign" runat="server"></asp:PlaceHolder>

                                                                </div>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <!--end::Col-->



                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>

                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <!--begin::Row-->
                                            <div class="row g">

                                                <!--begin::Col-->
                                                <div class="col-12">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-12" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Action Type</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <span class="" style="font-size: 14px;">
                                                                    <asp:Label ID="lblActionType" runat="server"></asp:Label>
                                                                </span>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <!--end::Col-->


                                            </div>
                                            <!--end::Row-->
                                        </div>

                                    </div>

                                </div>
                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <div class="row g">

                                                <div class="col-12">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-6" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Scheduled Date&Time</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <div class="col-lg-12 ">
                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblSchDT" runat="server"></asp:Label>
                                                                    </span>

                                                                </div>
                                                            </div>


                                                        </div>
                                                        <div class="col-6" style="padding-left: 10px;">

                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Duration</span>

                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">

                                                                <div class="col-lg-12 ">
                                                                    <span class="" style="font-size: 14px;">
                                                                        <asp:Label ID="lblDur" runat="server"></asp:Label>
                                                                    </span>

                                                                </div>
                                                            </div>


                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <!--end::Col-->



                                            </div>
                                            <!--end::Row-->
                                        </div>
                                    </div>

                                </div>

                                <div class="col-lg-12 row">
                                    <div class="col-lg-12 mb-4">
                                        <div class="card-body d-flex flex-column">
                                            <div class="row g">

                                                <div class="col-12">

                                                    <div class="d-flex align-items-center mb-2 me-2">
                                                        <!--begin::Symbol-->

                                                        <!--end::Symbol-->
                                                        <!--begin::Title-->
                                                        <div class="col-6" style="padding-left: 10px;">
                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Inventory Items</span>
                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">
                                                                <div class="col-lg-12">
                                                                    <span style="font-size: 14px;">
                                                                        <asp:Label ID="lblInvItems" runat="server"></asp:Label>
                                                                    </span>
                                                                    <asp:PlaceHolder ID="pnlInvItems" runat="server" Visible="false">
                                                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                                            ID="GridInvItems" GridLines="None"
                                                                            ShowFooter="True" AllowSorting="True"
                                                                            OnNeedDataSource="InvItems_NeedDataSource"
                                                                            AllowFilteringByColumn="true"
                                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                            EnableAjaxSkinRendering="true"
                                                                            AllowPaging="true" PageSize="5" CellSpacing="0">
                                                                            <ClientSettings>
                                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="300px"></Scrolling>
                                                                                <Selecting AllowRowSelect="true" />
                                                                            </ClientSettings>
                                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                                ShowFooter="false"
                                                                                EnableHeaderContextMenu="true">
                                                                                <Columns>

                                                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                            </MasterTableView>
                                                                        </telerik:RadGrid>
                                                                    </asp:PlaceHolder>

                                                                    <asp:Label ID="lblNoItems" runat="server" Visible="false">No Items</asp:Label>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-6" style="padding-left: 10px;">
                                                            <span class="min-w-50px fw-semibold text-gray-500 pt-5">Inventory Tools</span>
                                                            <div class="fs-7 fw-bold pt-1" style="color: black;">
                                                                <div class="col-lg-12">
                                                                    <span style="font-size: 14px;">
                                                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                    </span>
                                                                    <asp:PlaceHolder ID="pnlInvTools" runat="server" Visible="false">
                                                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                                            ID="GridInvTools" GridLines="None"
                                                                            ShowFooter="True" AllowSorting="True"
                                                                            OnNeedDataSource="InvTools_NeedDataSource"
                                                                            AllowFilteringByColumn="true"
                                                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                            EnableAjaxSkinRendering="true"
                                                                            AllowPaging="true" PageSize="5" CellSpacing="0">
                                                                            <ClientSettings>
                                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="300px"></Scrolling>
                                                                                <Selecting AllowRowSelect="true" />
                                                                            </ClientSettings>
                                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                                ShowFooter="false"
                                                                                EnableHeaderContextMenu="true">
                                                                                <Columns>

                                                                                    <telerik:GridBoundColumn DataField="fsa_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Tool Code" FilterControlWidth="100%"
                                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="fsa_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Tool" FilterControlWidth="100%"
                                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                            </MasterTableView>
                                                                        </telerik:RadGrid>
                                                                    </asp:PlaceHolder>

                                                                    <asp:Label ID="lblInvTool" runat="server" Visible="false">No Tools</asp:Label>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--end::Title-->

                                                    </div>

                                                </div>
                                                <!--end::Col-->



                                            </div>
                                            <!--end::Row-->
                                        </div>
                                    </div>

                                </div>


                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
    </div>




    <!--end::FailedModal-->
</asp:Content>



<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
