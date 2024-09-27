<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="AddEditRouteCustomerPromotions.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.AddEditRouteCustomerPromotions" %>
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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="lnkAssign">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />

                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlPromo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />

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

                        <%-- <telerik:RadLabel runat="server" ID="labelqno" Text=""></telerik:RadLabel>--%>


                        <div class="kt-portlet__body">

                            <asp:Literal ID="ltrlMessage" runat="server"> </asp:Literal>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <div class="col-lg-12 row" style="margin-bottom: 20px;">

                                    <div class="col-lg-5 form-group">
                                        <label class="control-label col-lg-12">حدد الطريق <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlp" runat="server" Width="100%" Filter="Contains" RenderMode="Lightweight"
                                                EmptyMessage="حدد اسم الطريق" OnSelectedIndexChanged="ddlp_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>
                                            <br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="frm"
                                                ControlToValidate="ddlp" ErrorMessage="الرجاء تحديد اسم الطريق " ForeColor="Red"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 form-group" style="">
                                        <label class="control-label col-lg-12">حدد ترقية<span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlPromo" runat="server" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlPromo_SelectedIndexChanged" AutoPostBack="true" RenderMode="Lightweight"
                                                EmptyMessage="حدد اسم الترويج">
                                            </telerik:RadComboBox>
                                            <br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="frm"
                                                ControlToValidate="ddlPromo" ErrorMessage="  الرجاء تحديد اسم الترويج" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                    <div class="col-lg-2 form-group" style="padding-top: 17px;">

                                        <div class="col-lg-12">

                                            <asp:LinkButton ID="lnkPromo" Width="153px" Height="37px" runat="server" Text="تفاصيل الترويج" CssClass="badge badge-light-primary" Style="padding-top: 13px;" OnClick="lnkPromo_Click" CausesValidation="false"></asp:LinkButton>
                                        </div>

                                    </div>
                                </div>
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>

                            <div class="col-lg-12 row" style="margin-bottom: 20px;">
                                <div class="col-lg-5" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">تاريخ بدء الترويج </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdFromData" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" RenderMode="Lightweight" ValidationGroup="frm"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="frm"
                                            ControlToValidate="rdFromData" ErrorMessage="الرجاء التحديد من التاريخ" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                <div class="col-lg-5" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">تاريخ انتهاء العرض الترويجي </label>
                                    </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdEndDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" RenderMode="Lightweight" OnSelectedDateChanged="rdEndDate_SelectedDateChanged" AutoPostBack="true"></telerik:RadDatePicker>
                                        <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="rdFromData" ControlToValidate="rdEndDate" Operator="GreaterThanEqual"
                                            ErrorMessage="حتى الآن يجب أن يكون أكبر" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="frm"
                                            ControlToValidate="rdEndDate" ErrorMessage="الرجاء التحديد حتى الآن" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                                <div class="col-lg-2 form-group" style="padding-top: 25px;">

                                    <div class="col-lg-12">
                                        <asp:LinkButton ID="lnkAssign" runat="server" Text="البحث عن العملاء" OnClick="lnkAssign_Click" CausesValidation="false" CssClass="badge badge-light-primary" Width="153px" Height="37px" Style="padding-top: 13px;"></asp:LinkButton>

                                    </div>



                                </div>

                                <div class="col-lg-4 form-group" hidden="hidden">
                                    <label class="control-label col-lg-12">عميل <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlCus" runat="server" Width="100%" Filter="Contains" RenderMode="Lightweight"
                                            EmptyMessage="حدد اسم العميل">
                                        </telerik:RadComboBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="frm"
                                            ControlToValidate="ddlCus" ErrorMessage=" الرجاء تحديد اسم العميل" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                            </div>

                        </div>

                        <div class="kt-portlet__body">
                            <div class="col-lg-12 row">
                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet" style="background-color: white; padding: 20px;">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                            <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                                <div class="col-lg-10">
                                                    <h3 class="kt-portlet__head-title">العملاء غير المعينين
                                                    </h3>
                                                </div>
                                                <div class="col-lg-2">
                                                    <asp:LinkButton ID="lnkAddQuestion" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="lnkAddQuestion_Click" Style="background-color: #50cd89;" Text="يضيف">
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center mt-5">
                                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
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
                                                    AllowPaging="true" PageSize="200" CellSpacing="0">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                    </ClientSettings>
                                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                        ShowFooter="false" DataKeyNames="rcs_cus_ID"
                                                        EnableHeaderContextMenu="true">
                                                        <Columns>
                                                            <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                            </telerik:GridClientSelectColumn>
                                                            <telerik:GridBoundColumn DataField="rcs_cus_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_cus_ID" Display="false">
                                                            </telerik:GridBoundColumn>


                                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل بالعربية" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
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
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet" style="background-color: white; padding: 20px;">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                            <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                                <div class="col-lg-10">
                                                    <h3 class="kt-portlet__head-title">العملاء المعينون
                                                    </h3>
                                                </div>
                                                <div class="col-lg-2">
                                                    <asp:LinkButton ID="lnkRemove" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="يزيل" OnClick="lnkRemove_Click" Style="background-color: #d9214e;"></asp:LinkButton>
                                                </div>
                                            </div>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center mt-5">
                                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>
                                        <!--begin::Form-->
                                        <div class="kt-form kt-form--label-right">
                                            <div class="kt-portlet__body">
                                                <asp:Literal ID="Literal2" runat="server"></asp:Literal>
                                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                    ID="grvRpt" GridLines="None"
                                                    ShowFooter="True" AllowSorting="True"
                                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                                    AllowFilteringByColumn="true"
                                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                    EnableAjaxSkinRendering="true"
                                                    AllowPaging="true" PageSize="200" CellSpacing="0">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                    </ClientSettings>
                                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                        ShowFooter="false" DataKeyNames="rcp_ID"
                                                        EnableHeaderContextMenu="true">
                                                        <Columns>
                                                            <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                            </telerik:GridClientSelectColumn>
                                                            <telerik:GridBoundColumn DataField="rcp_cus_ID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="rcp_cus_ID" Display="false">
                                                            </telerik:GridBoundColumn>


                                                          <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم الزبون" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل بالعربية" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="prm_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="ترقية" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="prm_Name" Visible="false">
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="prm_ArabicName" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="الترويج باللغة العربية" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="prm_ArabicName" Visible="false">
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
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>
    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">هل أنت متأكد أنك تريد أن تضيف؟</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="LinkButton1_Click">
                                                    نعم
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">يلغي</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span>تم تحديث العميل بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">لم يتم العثور على اختيار ..!</h5>
                </div>
                <div class="modal-body">
                    <span>يرجى التحديد والمحاولة مرة أخرى.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">هل أنت متأكد أنك تريد حذف ؟</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="lnkDelete_Click">
                                                    نعم
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold  btn-secondary" onclick="cancelModal(kt_modal_1_6);">لا</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span>تم حذف العميل بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">الأسئلة المخصصة للمسح</h5>
                </div>
                <div class="modal-body">
                    <asp:Literal ID="ltTable" runat="server" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_8);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">أُووبس..!</h5>
                </div>
                <div class="modal-body">
                    <p>هناك شئ خاطئ، يرجى المحاولة فى وقت لاحق.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>

