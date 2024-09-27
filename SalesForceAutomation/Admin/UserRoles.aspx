<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="UserRoles.aspx.cs" Inherits="SalesForceAutomation.Admin.UserRoles" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function ErrorModal(res) {
            $('#spnMsg').text(res);
            $('#kt_modal_1_6').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <div class="kt-portlet__head" style="padding-top: 20px">

                        <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs">

                            <a href="Users.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i> Users </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link"> User Roles </a>
                            <%--<span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">Users </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Reviewer/Approver Assignment </a>--%>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                    </div>
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">User Roles
                            </h3>
                        </div>
                        <div class="kt-subheader__toolbar">
                            <asp:LinkButton ID="btnSave" runat="server" Width="100px" OnClick="btnSave_Click" Text='<i class="icon-ok"></i>Save' CssClass="btn btn-brand btn-elevate btn-icon-sm" />
                            <asp:LinkButton ID="btnCancel" Width="100px" runat="server"
                                Text="Cancel" CssClass="btn btn-brand btn-elevate btn-icon-sm"
                                CausesValidation="False" OnClick="btnCancel_Click" />
                        </div>
                    </div>
                    <div class="kt-portlet__body">

                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                            ID="grvRpt" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="grvRpt_NeedDataSource"
                            OnItemDataBound="grvRpt_ItemDataBound"
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="10" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="RoleId"
                                EnableHeaderContextMenu="true">
                                <Columns>

                                    <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="2px">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="RoleName" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Role Name" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="RoleName">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="IsRole" Display="false" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="IsRole" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="IsRole">
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

    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><span id="spnMsg"></span></h5>
                </div>
                <div class="modal-footer">

                    <asp:LinkButton ID="lnkClose" runat="server" OnClick="btnCancel_Click" CssClass="btn btn-secondary" Text="OK"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
