<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddTargetDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddTargetDetail" %>

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
        function failedModal() {
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>

             <telerik:AjaxSetting AjaxControlID="Filter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />

                </UpdatedControls>
            </telerik:AjaxSetting>


            <%-- <telerik:AjaxSetting AjaxControlID="addbutton">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="RadAjaxpanel" />
    <telerik:AjaxUpdatedControl ControlID="RadAjaxpanel1" />

     </UpdatedControls>
    </telerik:AjaxSetting>--%>

            <%-- <telerik:AjaxSetting AjaxControlID="removebutton">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="RadAjaxpanel" />
    <telerik:AjaxUpdatedControl ControlID="RadAjaxpanel1" />

     </UpdatedControls>
    </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">


                    <div class="kt-portlet__head" style="padding-top: 8px;">
                        <div class="kt-portlet__head-label" style="border-bottom-style: inset;">
                            <h3 class="kt-portlet__head-title">

                                <telerik:RadLabel ID="lbltarget" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                            </h3>

                        </div>

                    </div>
                    <div style="padding-top: 10px; border-bottom-style: inset; padding-bottom: 10px;">
                         <telerik:RadAjaxPanel  runat="server" ID="catRadAjaxPanel" LoadingPanelID="RadAjaxLoadingPanel2">

                        <div class="col-lg-12 row">
                           
                                <div class="col-lg-3 ">
                                    <label class="control-label col-lg-12"><b>Category </b></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlcatid" runat="server" DefaultMessage="Select Category" CausesValidation="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlcatid_SelectedIndexChanged"
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" RenderMode="Lightweight" Skin="Material">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlcatid" ErrorMessage="Please Select Category" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>


                                <div class="col-lg-3 ">
                                    <label class="control-label col-lg-12"><b>Sub category </b></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlsubcatid" runat="server" DefaultMessage="Select Sub Category" CausesValidation="false" Width="100%" Filter="Contains" RenderMode="Lightweight" Skin="Material"
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true" OnSelectedIndexChanged="ddlsubcatid_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlsubcatid" ErrorMessage="Please Select Sub Category" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                             <div class="col-lg-3 ">
                                    <label class="control-label col-lg-12"><b>Brand </b></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlBrand" runat="server" DefaultMessage="Select Sub Category" CausesValidation="false" Width="100%" Filter="Contains" RenderMode="Lightweight" Skin="Material"
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlBrand" ErrorMessage="Please Select Brand" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                <div class="col-lg-3 form-group">
                                    <div class="col-lg-12">
                                        <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click" >
                                                    Apply Filter
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            
                        </div>
                                  </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    </div>


                    <div class="col-lg-12 row">
                        <div class="col-lg-6">

                            <!--begin::Portlet-->
                            <div class="kt-portlet">

                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="col-lg-10">
                                        <h3 class="kt-portlet__head-title">Unassigned Products
                                        </h3>
                                    </div>
                                    <div class="col-lg-2" style="text-align-last: end;">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                            <asp:LinkButton ID="lnkAdd" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="lnkAdd_Click1">
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
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="RadGrid1" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="RadGrid1_NeedDataSource"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="prd_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Category" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="Category">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="SubCategory" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="SubCategory" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="SubCategory">
                                                        </telerik:GridBoundColumn>
                                                          <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product ID" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" Display="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_ID">
                                                        </telerik:GridBoundColumn>

                                                    </Columns>
                                                </MasterTableView>
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
                                        <h3 class="kt-portlet__head-title">Assigned Products
                                        </h3>
                                    </div>
                                    <div class="col-lg-2" style="text-align-last: end;">
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


                                        <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="grvRpt" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="grvRpt_NeedDataSource"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="tpd_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Category" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="Category">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="SubCategory" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="SubCategory" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="SubCategory">
                                                        </telerik:GridBoundColumn>

                                                          <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:ImageButton CommandName="Delete" ID="RadImageButton3" Visible="true" AlternateText="Delete" runat="server"
                                                                    ImageUrl="assets/media/icons/svg/General/Trash.svg"></asp:ImageButton>
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
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
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
                </div>
            </div>
        </div>
    </div>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to add ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton2Add" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="LinkButton2Add_Click">
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
                    <span>Product has been Added successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton3Sok" runat="server" OnClick="LinkButton3Sok_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
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
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel10">
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="lnkDelete_Click">
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">No</button>
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
                    <span>Product has been deleted successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton4Dok" runat="server" OnClick="LinkButton4Dok_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

    <%-- modal end --%>
</asp:Content>
