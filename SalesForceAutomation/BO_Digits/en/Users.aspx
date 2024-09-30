<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.Users" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        function Confim(res) {
            $('#modalConfirm').modal('show');
            $('#usrID').text(res);
        }
        function SuccessModal(res) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#usrIDs').text(res);
            x++;
        }
        function failedModal() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function FailureLicense(c) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_7').modal('show');
            $('#Failure').text(c);
        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
        <asp:LinkButton ID="lnkAddUser" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" OnClick="lnkAddUser_Click"></asp:LinkButton>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>   
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
<AjaxSettings>
    
    <telerik:AjaxSetting AjaxControlID="lnkALl">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
    <telerik:AjaxUpdatedControl ControlID="lnlActive" />
        <telerik:AjaxUpdatedControl ControlID="lnkInactive" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnlActive">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
        <telerik:AjaxUpdatedControl ControlID="lnkALl" />
        <telerik:AjaxUpdatedControl ControlID="lnkInactive" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnkInactive">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
        <telerik:AjaxUpdatedControl ControlID="lnkALl" />
        <telerik:AjaxUpdatedControl ControlID="lnlActive" />
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

                         <div class="row">
                         </div>
                        <div class="row pb-5" style="margin-right: auto;">
                            <ul class="nav" style="justify-content: flex-end;">

                                <li class="nav-item">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                        <asp:LinkButton ID="lnkALl" runat="server" CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkALl_Click"></asp:LinkButton>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center mt-5">
                                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
                                </li>
                                <li class="nav-item">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                        <asp:LinkButton ID="lnlActive" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnlActive_Click"></asp:LinkButton>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center mt-5">
                                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
                                </li>
                                <li class="nav-item">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">
                                        <asp:LinkButton ID="lnkInactive" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkInactive_Click"></asp:LinkButton>
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center mt-5">
                                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
                                </li>
                            </ul>
                        </div>

                        <div>
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <!--begin::Form-->
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
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="UserId"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="60px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                                </telerik:GridButtonColumn>

                                                <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Roles" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Roles" ID="RadImageButton1" Visible="true" AlternateText="Roles" runat="server"
                                                            ImageUrl="../assets/media/icons/duotune/General/gen003.svg"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Workflow" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Workflow" ID="RadImageButton2" Visible="true" AlternateText="Workflow" runat="server"
                                                            ImageUrl="../assets/media/icons/duotune/General/Workflow.svg"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="CC Settings" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="CCSettings" ID="CCSettings" Visible="true" AlternateText="CCSettings" runat="server"
                                                            ImageUrl="../assets/media/icons/settingssmall.png" Width="22px" Height="22px"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="FirstName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="First Name" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="FirstName">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="LastName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Last Name" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="LastName">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserName" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="User Name" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="UserName">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Email" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Email" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Email">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UserType" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Data Level Access" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="UserType">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MapsDirectionAccess" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Map Access" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="MapsDirectionAccess">
                                                </telerik:GridBoundColumn>
                                                
                                                <telerik:GridBoundColumn DataField="IsCustomerConnectUser" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Connect User" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="IsCustomerConnectUser">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Created" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Active" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Active">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn HeaderStyle-Width="150px" AllowFiltering="false" HeaderText="" UniqueName="Cnf" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkReset" runat="server" CssClass="btn btn-outline btn-outline-dashed btn-outline-info" Text="Reset Password" CommandName="Reset"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>





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
                    <h5 class="modal-title">Are you sure you want to reset password for <strong><span id="usrID"></span></strong>..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="lnkAdds" runat="server" Text="Yes" OnClick="lnkAdds_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal();">
                        Cancel
                    </button>
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
                    <span>Password has been updated successfully for <strong><span id="usrIDs"></span></strong></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelFailedModal();">
                        Ok
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->
    <!--begin::FailedModal License-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="Failure">Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_7);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal License-->

    <style type="text/css">
        .modal-center {
            position: absolute;
            top: 50% !important;
            transform: translate(0, -50%) !important;
            -ms-transform: translate(0, -50%) !important;
            -webkit-transform: translate(0, -50%) !important;
            margin: auto 5%;
        }
    </style>
</asp:Content>
