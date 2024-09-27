<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="AddEditRouteMonthlyTarget.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.AddEditRouteMonthlyTarget" %>
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
        function Fail() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('show');
        }
        function RequiredModal() {

            $('#kt_modal_1_0').modal('show');
        }
        function failedModals(a) {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_9').modal('show');
            $('#failure').text(a);
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




                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                            
                                <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 20px">



                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">طريق <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlrot" runat="server" EmptyMessage="حدد الطريق" CausesValidation="true" RenderMode="Lightweight" Width="100%" Filter="Contains"></telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlrot" ErrorMessage="الرجاء تحديد المسار" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>


                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">شهر <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadMonthYearPicker ID="radmonth" runat="server" CausesValidation="true" DateInput-DateFormat="yyyy-MMM" RenderMode="Lightweight" Width="100%" Filter="Contains" OnSelectedDateChanged="radmonth_SelectedDateChanged" AutoPostBack="true"></telerik:RadMonthYearPicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlrot" ErrorMessage="يرجى تحديد الشهر" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>


                                        <%-- <div class="col-lg-12">
                                        <telerik:RadMonthYearPicker ID="radmonth" DateInput-DateFormat="yyyy-MM-dd" runat="server"   
                                            Width="100%" OnSelectedDateChanged="radmonth_SelectedDateChanged" AutoPostBack="true">
                                        </telerik:RadMonthYearPicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"  ErrorMessage="Month is mandatory" ForeColor="Red" ControlToValidate="radmonth">
                                    </asp:RequiredFieldValidator><br />
                                    </div>--%>
                                    </div>





                                    <div class="col-lg-3 form-group">
                                        <label class="control-label col-lg-12">أيام العمل</label>
                                        <div class="col-lg-12">
                                            <telerik:RadNumericTextBox ID="txtworkdays" runat="server" RenderMode="Lightweight" CausesValidation="false" Enabled="false" Width="100%" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                        </div>
                                    </div>


                                    <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 13px;">
                                        <asp:LinkButton ID="ViewPackageFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ValidationGroup="form" ForeColor="#009EF7" OnClick="ViewPackageFilter_Click" CausesValidation="true">
                                                    مشاهدة الحزم
                                        </asp:LinkButton>
                                    </div>



                                </div>
                            
                        </div>
                        <%-- strat form --%>
                        <div class="col-lg-12 row">


                            <div class="col-lg-6">

                                <!--begin::Portlet-->
                                <div class="kt-portlet">
                                    <asp:PlaceHolder ID="UnassignedPackage" runat="server" Visible="false">

                                        <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="col-lg-10">
                                                <h3 class="kt-portlet__head-title">الحزم غير المعينة
                                                </h3>
                                            </div>
                                            <div class="col-lg-2" style="text-align-last: end;">
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                                    <asp:LinkButton ID="lnkAddQuestion" runat="server" CssClass="btn btn-sm fw-bold btn-success" CausesValidation="true" ValidationGroup="form" OnClick="lnkAddQuestion_Click">
                                                   يضيف
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
                                                        ShowFooter="false" DataKeyNames="tph_ID"
                                                        EnableHeaderContextMenu="true">
                                                        <Columns>

                                                            <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                            </telerik:GridClientSelectColumn>

                                                            <telerik:GridBoundColumn DataField="tph_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                HeaderStyle-Font-Size="Smaller" HeaderText="طَرد" FilterControlWidth="100%"
                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                HeaderStyle-Font-Bold="true" UniqueName="tph_Name">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="كمية" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                <ItemTemplate>
                                                                    <telerik:RadNumericTextBox ID="txtAmount" Width="100px" runat="server" Enabled="true">
                                                                    </telerik:RadNumericTextBox>


                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="كمية" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                <ItemTemplate>
                                                                    <telerik:RadNumericTextBox ID="txtQty" NumberFormat-AllowRounding="false" Width="100px" runat="server" Enabled="true">
                                                                    </telerik:RadNumericTextBox>

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

                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center">
                                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>

                                            </div>
                                        </div>
                                    </asp:PlaceHolder>

                                </div>
                            </div>
                            <div class="col-lg-6">
                                <!--begin::Portlet-->
                                <div class="kt-portlet">
                                    <asp:PlaceHolder ID="AssignedPackage" runat="server" Visible="false">
                                        <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="col-lg-10">
                                                <h3 class="kt-portlet__head-title">الحزم المخصصة
                                                </h3>
                                            </div>
                                            <div class="col-lg-2">
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                                    <asp:LinkButton ID="lnkRemove" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="يزيل" OnClick="lnkRemove_Click"></asp:LinkButton>
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
                                                            ShowFooter="false" DataKeyNames="utp_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                                </telerik:GridClientSelectColumn>

                                                                <telerik:GridBoundColumn DataField="tph_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="طَرد" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="tph_Name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="trp_Amount" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="trp_Amount">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="rtp_Quantity" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كمية" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rtp_Quantity">
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
                                    </asp:PlaceHolder>
                                </div>
                            </div>
                        </div>
                        <%-- End form --%>
                    </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
    </div>
    <div class="clearfix"></div>



    <%-- modal start --%>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">هل أنت متأكد أنك تريد أن تضيف؟</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                    يضيف
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
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
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
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
                    <h5 class="modal-title">أُووبس..!</h5>
                </div>
                <div class="modal-body">
                    <span>هناك شئ خاطئ، يرجى المحاولة فى وقت لاحق.</span>
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
                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkDelete" runat="server" OnClick="lnkDelete_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                    نعم
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel10" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">يلغي</button>
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
                    <span>تم حذف حزمة الطريق بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">لم يتم العثور على اختيار ..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failure"></span>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">نعم</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_0" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">اوووه ..!</h5>
                </div>
                <div class="modal-body">
                    <p>يجب إدخال الكمية والمبلغ لجميع العناصر المحددة.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_0);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <div class="modal fade" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">أُووبس..!</h5>
                </div>
                <div class="modal-body">
                    <span>تم تعيين هذا الشهر بالفعل لهذا المسار..جرب مسارًا آخر</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_2);">نعم</button>
                </div>
            </div>
        </div>
    </div>




    <%-- modal end --%>
</asp:Content>

