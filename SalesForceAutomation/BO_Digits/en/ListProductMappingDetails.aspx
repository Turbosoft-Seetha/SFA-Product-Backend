<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListProductMappingDetails.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListProductMappingDetails" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
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
        function Question() {
            $('#kt_modal_1_8').modal('show');
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_9').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="ddlRoute">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel6" />
                    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel4" />

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


                    <h6 class="kt-portlet__head-label">Product Mapping Detail 
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>

                    </h6>



                    <div class="col-lg-12 row">
                        <div class="col-lg-12">

                            <!--begin::Portlet-->
                            <div class="kt-portlet" style="background-color: white; padding: 20px;">

                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="col-lg-6">
                                        <h3 class="kt-portlet__head-title">Un Assigned Products
                                        </h3>
                                    </div>
                                    <div class="col-lg-2" style="padding-left: 30px; margin-right: -60px;">
                                        <label class="control-label col-lg-6 fw-bold">Is must cell</label>
                                        <div class="col-lg-6 ">
                                            <asp:DropDownList ID="ddlIsMustSell" runat="server">
                                                <asp:ListItem Text="No" Value="N" Selected="true" />
                                                <asp:ListItem Text="Yes" Value="Y" />

                                            </asp:DropDownList>

                                        </div>
                                    </div>
                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-6 fw-bold">VAT %</label>
                                        <div class="col-lg-4">
                                            <!-- Reduced width from col-lg-6 to col-lg-4 -->
                                            <asp:TextBox
                                                RenderMode="Lightweight" ID="txtvat" runat="server" EmptyMessage="Please Select" >
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-2" style="padding-top: 7px; padding-left: 20px;">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                            <asp:LinkButton ID="lnkAddQuestion" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClientClick="Confim();" Style="background-color: #50cd89;">
                                                    Add
                                            </asp:LinkButton>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center">
                                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
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
                                                AllowPaging="true" PageSize="1000" CellSpacing="0">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="prd_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                                        </telerik:GridBoundColumn>



                                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Cus Item Code" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                            <ItemTemplate>
                                                                <telerik:RadTextBox ID="txtcusitmcode" Width="100%" runat="server" Enabled="true">
                                                                </telerik:RadTextBox>


                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="pmg_Name">
                                                        </telerik:GridBoundColumn>


                                                        <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Subcategory" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="VAT Percent" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" Display="false">
                                                            <ItemTemplate>
                                                                <telerik:RadNumericTextBox ID="pmd_VATPerc" Width="100%" runat="server" Enabled="true" Value="5">
                                                                </telerik:RadNumericTextBox>


                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Is Must Sell" UniqueName="pmd_IsMustSell" HeaderStyle-Width="80px" Display="false">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlIsMustSell" runat="server">
                                                                    <asp:ListItem Text="No" Value="N" Selected="true" />
                                                                    <asp:ListItem Text="Yes" Value="Y" />

                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:DropDownList ID="ddlIsMustSellEdit" runat="server" CssClass="ddlMustSell">
                                                                    <asp:ListItem Text="Yes" Value="Y" />
                                                                    <asp:ListItem Text="No" Value="N" />
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="rfvIsMustSell" runat="server" ControlToValidate="ddlIsMustSellEdit"
                                                                    InitialValue="" ErrorMessage="Please select a value for Is Must Sell" Display="Dynamic" ForeColor="Red" />
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>


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

                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center">
                                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-12">
                            <!--begin::Portlet-->
                            <div class="kt-portlet" style="background-color: white; padding: 20px;">
                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="col-lg-10">
                                        <h3 class="kt-portlet__head-title">Assigned Products
                                        </h3>
                                    </div>
                                    <div class="col-lg-2">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                            <asp:LinkButton ID="lnkRemove" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="Remove" OnClientClick="Delete()" Style="background-color: #d9214e;"></asp:LinkButton>
                                        </telerik:RadAjaxPanel>

                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center">
                                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                    </div>
                                </div>
                                <!--begin::Form-->
                                <div class="kt-form kt-form--label-right">
                                    <div class="kt-portlet__body">
                                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                                        <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="grvRpt" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="grvRpt_NeedDataSource"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="1000" CellSpacing="0">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="prd_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                                        </telerik:GridBoundColumn>



                                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="pmd_CusItmCode" AllowFiltering="true" HeaderStyle-Width="100px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Cus Item Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="pmd_CusItmCode">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="pmg_Name">
                                                        </telerik:GridBoundColumn>


                                                        <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="sct_NameArabic" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Subcategory" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="sct_NameArabic">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="pmd_VATPerc" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="VAT Percent" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="pmd_VATPerc">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="pmd_IsMustSell" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Is Must sell" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="pmd_IsMustSell">
                                                        </telerik:GridBoundColumn>


                                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:ImageButton CommandName="Delete" ID="RadImageButton3" Visible="true" AlternateText="Delete" runat="server"
                                                                    ImageUrl="assets/media/icons/svg/General/Trash.svg"></asp:ImageButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

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
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
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
            </div>
        </div>
    </div>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title">Are you sure you want to add ?</h5>


                </div>

                <div class="modal-footer">

                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="LinkButton1_Click">
                                                    Add
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Product  has been updated successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="lnkDelete_Click">
                                                    Yes
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">No</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Product has been deleted successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Questions assigned for survey</h5>
                </div>
                <div class="modal-body">
                    <asp:Literal ID="ltTable" runat="server" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_8);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
</asp:Content>
