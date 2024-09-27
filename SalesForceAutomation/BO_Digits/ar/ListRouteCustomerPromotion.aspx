<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ListRouteCustomerPromotion.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ListRouteCustomerPromotion" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Delete() {
            $('#modalConfirm').modal('hide');
            $('#modalSuccess').modal('show');
        }
        function Failed() {
            $('#modalConfirm').modal('hide');
            $('#modalFailed').modal('show');
        }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
             <asp:LinkButton ID="CusPromo" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="تعيين مجمع" OnClick="CusPromo_Click"></asp:LinkButton>
               
             <asp:LinkButton ID="lnkSubCat" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="يضيف" OnClick="lnkSubCat_Click"></asp:LinkButton>
                            
      </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color:white; padding:20px;">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   
                    <!--end: Search Form -->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                    <div class="kt-portlet__body">

                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                        <div class="col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                            <div class="col-lg-3">
                                <label class="control-label" style="padding-left:15px;">طريق <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlp" runat="server" CausesValidation="false" Width="100%" Filter="Contains" RenderMode="Lightweight"
                                        EmptyMessage="حدد الطريق" OnSelectedIndexChanged="ddlp_SelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <label class="control-label" style="padding-left:15px;">عميل <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlCus" runat="server" CausesValidation="false" Width="100%" Filter="Contains" RenderMode="Lightweight"
                                        EmptyMessage="حدد العميل" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                    </telerik:RadComboBox>
                                    <br />
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <label class="control-label" style="padding-left:15px;">ترقية <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlPromo" runat="server" CausesValidation="false" Width="100%" Filter="Contains"  RenderMode="Lightweight"
                                        EmptyMessage="حدد ترقية">
                                    </telerik:RadComboBox>
                                </div>
                            </div>

                            <div class="col-lg-3" style="padding-top:10px; margin-bottom:40px;">
                                <div class="col-lg-8">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm btn-primary me-2" Text="تطبيق عامل التصفية" OnClick="LinkButton1_Click" BackColor="#DAE9F8" ForeColor="#009EF7"></asp:LinkButton>
                                </div>
                            </div>

                        </div>

                    </div>

                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">
                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
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
                                ShowFooter="false" DataKeyNames="rcp_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="كود الطريق" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="طريق" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="rot_ArabicName" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="اسم المسار باللغة العربية" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_ArabicName">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="عميل" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="اسم العميل بالعربية" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="prm_Number" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="رقم الترويج" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prm_Number">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="prm_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="ترقية" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prm_Name">
                                    </telerik:GridBoundColumn>
                                    
                                    <telerik:GridBoundColumn DataField="prm_ArabicName" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="الترويج باللغة العربية" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prm_ArabicName">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rcp_FromDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="من التاريخ" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rcp_FromDate">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rcp_EndDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ الانتهاء" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rcp_EndDate">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
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
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                </div>
            </div>
        </div>
    </div>
    </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">هل أنت متأكد أنك تريد حذف..؟؟
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="lnkDelete" runat="server" Text="نعم" OnClick="lnkDelete_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">
                        يلغي
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="modalSuccess" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span>تم حذف ترويج المسار للعميل بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="modalFailed" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">فشل</h5>
                </div>
                <div class="modal-body">
                    <span><strong>هناك شئ خاطئ، يرجى المحاولة فى وقت لاحق.</strong></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalFailed);">رفض</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
