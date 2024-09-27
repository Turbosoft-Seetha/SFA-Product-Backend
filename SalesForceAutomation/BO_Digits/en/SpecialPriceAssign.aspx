<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SpecialPriceAssign.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SpecialPriceAssign" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal(a) {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function failedModal() {add
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function Delete() {
            $('#kt_modal_1_6').modal('show');
        }
        function DeleteSuccess() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }
        function DeleteFailed() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function failedModals() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_9').modal('show');


        }
        function failedModals2() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_10').modal('show');


        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <%-- <telerik:RadLabel ID="sp" runat="server" CssClass="kt-portlet__head-title" Font-Size="Small"></telerik:RadLabel>
    --%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-portlet__body pb-0">

                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar1" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px;">
                                                <table>
                                                    <td style="width: 56%">
                                                        <div class="col-lg-6 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Special Price Name:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                      
                                                        <td>

                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Status:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblstatus" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>



                                                        </td>
                                                </table>


                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>

                        </div>



                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                            <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">



                               

                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Payment Mode</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="RdPayMode" runat="server" DefaultMessage="Select Payment Mode" EmptyMessage="Select Payment Mode" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Hard Cash" Value="HC" />
                                                <telerik:RadComboBoxItem Text="Credit" Value="CR" />
                                                <telerik:RadComboBoxItem Text="POS" Value="POS" />
                                                <telerik:RadComboBoxItem Text="Online Payment" Value="OP" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ControlToValidate="RdPayMode" ErrorMessage="Please choose payment mode" ForeColor="Red" Display="Dynamic" ValidationGroup="form"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">From Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
                                        <%--                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>

                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">To Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                        <%--                                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>

                                <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 13px;">
                                    <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="Filter_Click" CausesValidation="true" ValidationGroup="form">
                                                    Search
                                    </asp:LinkButton>
                                </div>



                            </div>
                        </div>
                        <%-- strat form --%>
                        <asp:PlaceHolder ID="pnlGrid" runat="server" Visible="false">
                        <div class="col-lg-12 row">


                            <div class="col-lg-6">

                                <!--begin::Portlet-->
                                <div class="kt-portlet">

                                    <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                        <div class="col-lg-10">
                                            <h3 class="kt-portlet__head-title">Un Assigned Customer
                                            </h3>
                                        </div>
                                        <div class="col-lg-2" style="text-align-last: end;">
                                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                                <asp:LinkButton ID="lnkAddQuestion" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="lnkAddQuestion_Click">
                                                    Add
                                                </asp:LinkButton>
                                            </telerik:RadAjaxPanel>
                                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                                                BackColor="Transparent"
                                                ForeColor="Blue">
                                                <div class="col-lg-12 text-center">
                                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                </div>
                                            </telerik:RadAjaxLoadingPanel>
                                        </div>
                                    </div>

                                    <!--begin::Form-->
                                    <div class="kt-form kt-form--label-right">
                                        <div class="kt-portlet__body">
                                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                            <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="RadGrid1" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="RadGrid1_NeedDataSource"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="cus_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>

                                                        <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                        </telerik:GridClientSelectColumn>

                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
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

                                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                                BackColor="Transparent"
                                                ForeColor="Blue">
                                                <div class="col-lg-12 text-center">
                                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                </div>
                                            </telerik:RadAjaxLoadingPanel>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-lg-6">
                                <!--begin::Portlet-->
                                <div class="kt-portlet">
                                    <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                        <div class="col-lg-10">
                                            <h3 class="kt-portlet__head-title">Assigned Customer
                                            </h3>
                                        </div>
                                        <div class="col-lg-2">
                                            <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                                <asp:LinkButton ID="lnkRemove" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="Remove" OnClick="lnkRemove_Click"></asp:LinkButton>
                                            </telerik:RadAjaxPanel>

                                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
                                                BackColor="Transparent"
                                                ForeColor="Blue">
                                                <div class="col-lg-12 text-center">
                                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                </div>
                                            </telerik:RadAjaxLoadingPanel>
                                        </div>
                                    </div>
                                    <!--begin::Form-->
                                    <div class="kt-form kt-form--label-right">
                                        <div class="kt-portlet__body">
                                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                                            <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                    ID="grvRpt" GridLines="None"
                                                    ShowFooter="True" AllowSorting="True"
                                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                                    AllowFilteringByColumn="true"
                                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                    EnableAjaxSkinRendering="true"
                                                    AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                    </ClientSettings>
                                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                        ShowFooter="false" DataKeyNames="crp_ID"
                                                        EnableHeaderContextMenu="true">
                                                        <Columns>

                                                            <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                            </telerik:GridClientSelectColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="crp_PayMode" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="crp_PayMode">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="crp_StartDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="From Date" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="crp_StartDate">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="crp_EndDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="To Date" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="crp_EndDate">
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
                        </div>
                        <%-- End form --%>

                            </asp:PlaceHolder>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>



    <%-- modal start --%>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to add ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                    Add
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkDelete" runat="server" OnClick="lnkDelete_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                    Yes
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel10" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Customer has been deleted successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">No selection found..!</h5>
                </div>
                <div class="modal-body">
                    <p>Please make selection and try again.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
      <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_10" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">No selection found..!</h5>
                </div>
                <div class="modal-body">
                    <p>Please select atleast one Route and Payment mode .</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_10);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->


    <%-- modal end --%>
</asp:Content>
