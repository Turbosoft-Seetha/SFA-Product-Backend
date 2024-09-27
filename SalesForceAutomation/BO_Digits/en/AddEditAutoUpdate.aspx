<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" EnableEventValidation="true" CodeBehind="AddEditAutoUpdate.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditAutoUpdate" %>

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
        function Failure(b) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#failspan').text(b);
        }
        function Fail() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_6').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <asp:LinkButton ID="LinkButton2" Width="100px" runat="server"
        Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
        CausesValidation="False" OnClick="LinkButton2_Click" />
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="LinkButton1" Width="100px" runat="server" ValidationGroup="frm" OnClick="LinkButton1_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="false" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="lnkadd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <%--<telerik:AjaxUpdatedControl ControlID="pnls" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

                                <div class="col-lg-12 row">

                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">Code</label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                                ControlToValidate="txtcode" ErrorMessage="Please Enter Version code" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">Name</label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"
                                                ControlToValidate="txtName" ErrorMessage="Please Enter Version Name" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">Url</label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtURL" runat="server" TextMode="MultiLine" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ControlToValidate="txtURL" ErrorMessage="Please Enter url" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">Release Note</label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="txtReleaseNote" runat="server" TextMode="MultiLine" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ControlToValidate="txtReleaseNote" ErrorMessage="Please Enter " ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-12 row">

                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">Applicable to <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlroute" RenderMode="Lightweight" runat="server" Width="100%" DefaultMessage="Please Select" OnSelectedIndexChanged="ddlroute_SelectedIndexChanged2" AutoPostBack="true">
                                                <Items>
                                                    <telerik:DropDownListItem Text="All" Value="A" />
                                                    <telerik:DropDownListItem Text="Specific" Value="S" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </div>
                                    <div class="col-lg-3 form-group  ">
                                        <asp:Panel ID="typepanel" runat="server" Visible="false">
                                            <label class="control-label col-lg-12">Type <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddltype" RenderMode="Lightweight" runat="server" Width="100%" DefaultMessage="Please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Mandatory" Value="M" />
                                                        <telerik:DropDownListItem Text="Optional" Value="O" />
                                                        <telerik:DropDownListItem Text="Non Visible" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>

                                            </div>
                                        </asp:Panel>

                                    </div>

                                </div>



                                <%-- strat form --%>
                                <asp:Panel ID="gridpanel" runat="server" Visible="false">
                                    <div class="col-lg-12 row">


                                        <div class="col-lg-6">

                                            <!--begin::Portlet-->
                                            <div class="kt-portlet">

                                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                                    <div class="col-lg-10">
                                                        <h3 class="kt-portlet__head-title">Un Assigned Routes
                                                        </h3>
                                                    </div>
                                                    <div class="col-lg-2" style="text-align-last: end;">
                                                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                                            <asp:LinkButton ID="lnkadd" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="lnkadd_Click">
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
                                                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                ShowFooter="false" DataKeyNames="rot_ID"
                                                                EnableHeaderContextMenu="true">
                                                                <Columns>

                                                                    <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                                    </telerik:GridClientSelectColumn>

                                                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
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
                                                        <h3 class="kt-portlet__head-title">Assigned Routes
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
                                                                AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                                        </telerik:GridClientSelectColumn>

                                                                        <telerik:GridBoundColumn DataField="routecode" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="routecode">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="route" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="route">
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
                                </asp:Panel>
                                <%-- End form --%>
                            </telerik:RadAjaxPanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>


                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failspan"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>


                </div>
            </div>
        </div>
    </div>



    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>This version already exists....</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
