<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="PlanogramTransactions.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.PlanogramTransactions" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function failedModal(b) {
            $('#kt_modal_1_5').modal('show');
            $('#failtext').text(b);
        }
        function Delete() {
            $('#kt_modal_1_7').modal('show');
        }
        function deleteSucces(c) {
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_8').modal('show');
            $('#delsuccess').text(c);

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body p-8" style="background-color: white;">
        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

            <%-- Filter starts --%>

            <div class="col-lg-12 row mb-4">
                <div class="col-lg-2">
                    <label class="control-label col-lg-12">From Date</label>
                    <div class="col-lg-12">
                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" OnSelectedDateChanged="rdfromDate_SelectedDateChanged1" AutoPostBack="true">
                        </telerik:RadDatePicker>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="col-lg-2">
                    <label class="control-label col-lg-12">To Date</label>
                    <div class="col-lg-12">
                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" OnSelectedDateChanged="rdendDate_SelectedDateChanged1" AutoPostBack="true">
                        </telerik:RadDatePicker>
                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Route</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Filter="Contains" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true"></telerik:RadComboBox>

                    </div>
                </div>
                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Customer</label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox ID="rdCustomer" runat="server" EmptyMessage="Select Customer" Filter="Contains" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                            OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged1" AutoPostBack="true">
                        </telerik:RadComboBox>

                    </div>

                </div>






                <div class="col-lg-2 pt-5 mt-2" style="text-align: center;">
                    <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkFilter_Click1">
                                                    Apply Filter
                    </asp:LinkButton>
                </div>

            </div>

            <%-- Filter ends --%>

            <%-- Grid starts --%>
            <div class="kt-form kt-form--label-right">
                <div class="kt-portlet__body">
                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                        ID="grvRpt" GridLines="None"
                        ShowFooter="True" AllowSorting="True"
                        OnNeedDataSource="grvRpt_NeedDataSource"
                        AllowFilteringByColumn="true"
                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                        EnableAjaxSkinRendering="true"
                        AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                        </ClientSettings>
                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                            ShowFooter="false" DataKeyNames="plt_ID"
                            EnableHeaderContextMenu="true">
                            <Columns>

                              <%--  <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" >
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="Detail" ID="Detail" Visible="true" AlternateText="Detail" runat="server"
                                            ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>




                                <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="plg_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Planogram Code" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="plg_Code">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="plg_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Planogram" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="plg_Name">
                                </telerik:GridBoundColumn>
                               <%-- <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="50px" HeaderText="Image" HeaderStyle-Font-Size="Smaller"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="img" runat="server" NavigateUrl=' <%#  Eval("plt_Image") %>' Target="_blank">
                                            <asp:Image ID="itmImage" runat="server" ImageUrl=' <%#  Eval("plt_Image") %>' Height="20px" Width="20px" />
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>

                                <telerik:GridBoundColumn DataField="plg_Remarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="plg_Remarks">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
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

            <%-- Grid ends --%>

            <%-- Dispatch button starts --%>

            <div class="col-lg-12 pt-4" style="display: flex; justify-content: flex-end;">


                <div class="col-lg-1 pt-4">
                </div>

                <div class="col-lg-2 ps-12">
                </div>
                <div class="col-lg-2">
                </div>

            </div>

            <%-- Dispatch button ends --%>
        </telerik:RadAjaxPanel>
        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
            BackColor="Transparent"
            ForeColor="Blue">
            <div class="col-lg-12 text-center mt-5">
                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
            </div>
        </telerik:RadAjaxLoadingPanel>
    </div>


    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" style="height: auto;" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click1" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click1" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failtext"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <!--begin::DeleteValidationModal-->


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_8" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="delsuccess"></span>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
