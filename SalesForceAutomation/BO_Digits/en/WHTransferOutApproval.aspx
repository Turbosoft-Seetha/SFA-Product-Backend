<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="WHTransferOutApproval.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.WHTransferOutApproval" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

    <script type="text/javascript">

        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm11').modal('hide');
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#kt_modal_1_2').modal('hide');
            $('#success').text(a);
        }
        function RequiredModal() {

            $('#kt_modal_1_0').modal('show');
        }
        function failedModal(b) {
            $('#kt_modal_1_5').modal('show');
            $('#failtext').text(b);
        }
        function failedModals() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_2').modal('show');
            $('#kt_modal_1_9').modal('show');


        }
        function Confimmodel() {
            $('#modalConfirm11').modal('show');
        }

        function Reject() {
            $('#kt_modal_1_2').modal('show');
        }
        function cancelModal() {
            $('#kt_modal_1_2').modal('hide');
        }

    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

        <asp:LinkButton ID="lnkApprove" Width="100px" runat="server" ValidationGroup="form" OnClick="lnkApprove_Click" UseSubmitBehavior="false" Text="Approve"
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
        <asp:LinkButton ID="lnkReject" Width="100px" runat="server"
            Text="Reject" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" OnClick="lnkReject_Click" />


        <%--                            <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="40" Width="33" ToolTip="Print"
                                OnClick="btnPDF_Click" AlternateText="pdf" />
    <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />--%>
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
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <%-- <div class="kt-portlet__head" style="padding-top: 20px;  padding-bottom: 20px;">

                      c
                        <%--<div class="kt-portlet__head-actions">

                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

                         </div>--%>
                        <%--</div>--%>



                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            <div class="kt-portlet__body">
                                <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                    <asp:PlaceHolder ID="plhFilter" runat="server">
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Region</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                    ID="ddlregion" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Depot</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                    RenderMode="Lightweight"
                                                    ID="ddldepot" runat="server" EmptyMessage="Select Depot"
                                                    OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Area</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                    ID="ddldpoArea" runat="server" EmptyMessage="Select Area"
                                                    OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Subarea</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                    ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>
                                    </asp:PlaceHolder>
                                    <%--   <div class="col-lg-2" style="margin-left: 4px;">
                                    <label class="control-label col-lg-12">Route</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>--%>
                                </div>
                                <asp:PlaceHolder runat="server" ID="pnlfilter">
                                    <div class=" col-lg-12 row" style="padding-bottom: 10px">

                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Receiving Location</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Width="100%"
                                                    RenderMode="Lightweight" ID="rdReqLoc" runat="server" EmptyMessage="Select Location" AutoPostBack="true"
                                                    OnSelectedIndexChanged="rdReqLoc_SelectedIndexChanged">
                                                </telerik:RadComboBox>


                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Picking Location</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Width="100%"
                                                    RenderMode="Lightweight" ID="rdPickLoc" runat="server" EmptyMessage="Select Location">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>


                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12 ">Status </label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlStatus" RenderMode="Lightweight" runat="server" Width="100%" DefaultMessage="Select Route Type">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Approved" Value="A" />
                                                        <telerik:DropDownListItem Text="Pending" Value="N,P" Selected="true" />

                                                        <%--                                             <telerik:DropDownListItem Text="Reject" Value="R" />--%>
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ValidationGroup="form"
                                                    ControlToValidate="ddlStatus" ErrorMessage="<br/>Please Select Status" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>


                                        <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px;">
                                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkDOwnload_Click">
                                                    Apply Filter
                                            </asp:LinkButton>
                                        </div>
                                        <div class="col-lg-2" style="text-align: center; padding-top: 15px;">
                                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" Visible="false">
                                                    Advanced Filter
                                            </asp:LinkButton>
                                        </div>


                                    </div>
                                </asp:PlaceHolder>
                                <!--end: Search Form -->

                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="wtt_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Select" HeaderStyle-Font-Size="Smaller"
                                                HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Item" ID="RadImageButton2" Visible="true" AlternateText="Item" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridBoundColumn DataField="wtt_number" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="TO Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="wtt_number">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="war_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Pic.Loc Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="war_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="war_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Picking Loc" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="war_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="str_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Receiving.Loc Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="str_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="str_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Receiving.Loc" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="str_Name">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="usr_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ExpDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Exp. Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ExpDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Currentlevel" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Current Level" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Currentlevel" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Approved By" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Approved Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
                                            </telerik:GridBoundColumn>

                                        </Columns>
                                    </MasterTableView>
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
                                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>

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
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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

    <div class="modal fade modal-center" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Reject">Are you sure you want to Reject..??
                    </h5>
                </div>

                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-6 form-group">
                            <label class="control-label col-lg-12">Response Remark</label>
                            <div class="col-lg-12">
                                <telerik:RadTextBox ID="txtRejRem" runat="server" Width="100%" Filter="Contains" RenderMode="Lightweight" CausesValidation="false"></telerik:RadTextBox>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                        <asp:LinkButton ID="btnRejectSave" runat="server" Text="Yes" OnClick="btnRejectSave_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_2);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>



