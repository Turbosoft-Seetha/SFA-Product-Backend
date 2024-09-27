<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerReAssignment.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerReAssignment" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">





    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

        <asp:LinkButton ID="lnkCancel" runat="server"
            Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" OnClick="lnkCancel_Click" />
        <asp:LinkButton ID="lnkSave" runat="server" ValidationGroup="form" OnClick="lnkSave_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


    <div class="card-body p-8" style="background-color: white;">
        <div class="kt-portlet__body">
            <div class="card-body" style="background-color: white; padding-bottom: 10px;">
                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="98%" ID="RadPanelBar0" runat="server">
                    <Items>
                        <telerik:RadPanelItem Font-Bold="true" Text="Note:" Expanded="false" ForeColor="Blue" BackColor="white">
                            <ContentTemplate>
                                <div class="kt-portlet__body" style="background-color: white; display: grid; padding: 15px;">
                                    <table>
                                        <td style="width: 100%">

                                            <div class="fs-6 text-dark-400 fw-bold pe-7">When you reassign certain customers from the "From Route" to the "To Route", several things will happen: </div>
                                            <div class="fs-6 text-gray-700 pe-7">
                                                1. The selected customers in the 'From Route' will be marked as inactive and their settings in 'From Route' will be saved under the 'To Route'.
                                            </div>
                                            <div class="fs-6 text-gray-700 pe-7">2. An entry containing the selected customers and their new route (i.e. 'To Route') will be added to the 'Customer Week Route'.</div>
                                            <div class="fs-6 text-gray-700 pe-7">
                                                3. If there was a customer item mapping in the 'From Route', a new entry will be created in the 'Customer Item Mapping' with the same values as before, 
                                            except for the route, which will be changed to the 'To Route'.
                                            </div>
                                            <div class="fs-6 text-gray-700 pe-7">
                                                4. The promotions currently assigned to the selected customers in the 'From Route' will be re-assigned to the 'To Route'.
                                            </div>
                                            <div class="fs-6 text-gray-700 pe-7">
                                                5.The Special Price assignments for the selected customers in the 'From Route' will be moved to the 'To Route'..
                                            </div>
                                        </td>
                                    </table>
                                </div>
                            </ContentTemplate>
                        </telerik:RadPanelItem>
                    </Items>
                </telerik:RadPanelBar>
            </div>
        </div>



        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

            <div class="col-lg-12 row">

                <div class="col-lg-4 form-group mb-4">
                    <label class="control-label col-lg-12">From Route <span class="required"></span></label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox ID="ddlFRoute" runat="server" EmptyMessage="Select Route" CausesValidation="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlFRoute_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                            ControlToValidate="ddlFRoute" ErrorMessage="Please Select From Route" ForeColor="Red" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                    </div>
                </div>

                <div class="col-lg-4 form-group mb-4">
                    <label class="control-label col-lg-12">To Route <span class="required"></span></label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox ID="ddlTRoute" runat="server" EmptyMessage="Select Route" CausesValidation="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlTRoute_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                            ControlToValidate="ddlTRoute" ErrorMessage="Please Select To Route" ForeColor="Red" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                    </div>
                </div>

                <div class="col-lg-12  mt-5">
                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                        ID="grvRpt" GridLines="None"
                        ShowFooter="True" AllowSorting="True"
                        OnNeedDataSource="grvRpt_NeedDataSource"
                        AllowFilteringByColumn="true"
                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                        EnableAjaxSkinRendering="true"
                         Skin="Material"
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
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CusStatus" AllowFiltering="true" HeaderStyle-Width="100px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Status" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="CusStatus">
                                </telerik:GridBoundColumn>
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

                                <telerik:GridBoundColumn DataField="rotStatus" AllowFiltering="true" HeaderStyle-Width="100px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route Cus Status" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="rotStatus">
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
        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
            BackColor="Transparent"
            ForeColor="Blue">
            <div class="col-lg-12 text-center mt-5">
                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
            </div>
        </telerik:RadAjaxLoadingPanel>
    </div>



    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
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
