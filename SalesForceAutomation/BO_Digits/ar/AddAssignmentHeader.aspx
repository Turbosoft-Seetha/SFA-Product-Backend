<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="AddAssignmentHeader.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.AddAssignmentHeader" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
      <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
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
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
      <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                   
                                 <asp:LinkButton ID="LinkCancel" runat="server" OnClick="LinkCancel_Click"
                                    Text="يلغي" CssClass="btn btn-sm fw-bold btn-secondary"
                                    CausesValidation="False" />
                               <asp:LinkButton ID="LinkSave" runat="server" ValidationGroup="form" OnClick="LinkSave_Click" 
                                   UseSubmitBehavior="false" Text='<i class="icon-ok"></i>يتابع'
                                    CssClass="btn btn-sm fw-bold btn-primary"  CausesValidation="true"/>
                              
                                  </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>   
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
<AjaxSettings>
    
    <telerik:AjaxSetting AjaxControlID="lnkAdd">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>

        <AjaxSettings>
    
    <telerik:AjaxSetting AjaxControlID="lnkDelete">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

     <div class="card-body" style="background-color:white; padding:20px;">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                 
                     <div class="kt-portlet__body">
                         <%--<div><b> Add Assignment Header </b></div> <br />
                           --%> 
                        <div class="col-lg-12 row">

                           
                            <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">اسم</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                                     ControlToValidate="txtName" ErrorMessage="الرجاء إدخال الاسم" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">حالة</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%" RenderMode="Lightweight">
                                        <items>
                                            <telerik:DropDownListItem Text="ممكن" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="عاجز" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                           

                        </div>                     
                    </div>
                 
                    
                      <%-- strat form --%>
                    <div class="col-lg-12 row pt-4">


                        <div class="col-lg-6">

                            <!--begin::Portlet-->
                            <div class="kt-portlet">

                                 <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                     <div class="col-lg-10">
                                        <h3 class="kt-portlet__head-title">المنتجات غير المعينة
                                        </h3>
                                    </div>
                                     <div class="col-lg-2" style=" text-align-last: end;">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                            <asp:LinkButton ID="lnkAdd" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="lnkAdd_Click">
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
                                         <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                       
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
                                                ShowFooter="false" DataKeyNames="prd_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                    </telerik:GridClientSelectColumn>

                                                     <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="prd_ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                                    </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="شفرة" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="غرض" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
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
                                <div class="col-lg-12 row"  style="padding-top: 20px; padding-bottom: 20px;">
                                     <div class="col-lg-10">
                                        <h3 class="kt-portlet__head-title">المنتجات المخصصة
                                        </h3>
                                    </div>
                                    <div class="col-lg-2">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="يزيل" OnClick="lnkDelete_Click"></asp:LinkButton>
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

                                                        <telerik:GridBoundColumn DataField="ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="ID" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="ID" Display="false">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="شفرة" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="Item" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="غرض" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="Item">
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
                    <%-- End form --%>
                   
                </div>
            </div>
        </div>
    </div>
 </div>

    
    <%-- modal start --%>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span id="success">تمت إضافة العنصر بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">هل أنت متأكد أنك تريد حذف ؟</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkRemove" runat="server" OnClick="lnkDelete_Click" CssClass="btn btn-sm fw-bold btn-primary">
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
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span>تم حذف العميل بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
     <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height:auto"  aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">لم يتم العثور على اختيار ..!</h5>
                </div>
                <div class="modal-body">
                    <p>يرجى التحديد والمحاولة مرة أخرى.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->


    <%-- modal end --%>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
