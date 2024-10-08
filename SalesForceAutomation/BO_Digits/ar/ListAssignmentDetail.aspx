﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ListAssignmentDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ListAssignmentDetail" %>
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
         function Failure() {
             $('#modalConfirm').modal('hide');
             $('#kt_modal_1_5').modal('show');
        }
        function Confims() {
            $('#modalConfirms').modal('show');
         }
         function Delete() {
             $('#kt_modal').modal('show');
         }
        function Succcesss(a) {
            $('#modalConfirms').modal('hide');
            $('#kt_modal_1_6').modal('show');
            $('#successs').text(a);
        }
        function Failures() {
            $('#modalConfirms').modal('hide');
            $('#kt_modal').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }
       
        function delsuccessModal() {
            $('#delmodalConfirm').modal('hide');
            $('#kt_modal').modal('hide');
            $('#kt_modal_1_8').modal('show');
         }
         function failedModal() {
             
             $('#kt_modal_1_9').modal('show');
         }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                   
                                 <asp:LinkButton ID="LinkCancel" runat="server" OnClick="LinkCancel_Click"
                                    Text="يلغي" CssClass="btn btn-sm fw-bold btn-secondary"
                                    CausesValidation="False" />
                               <%--<asp:LinkButton ID="LinkSave" runat="server" ValidationGroup="form" OnClick="LinkSave_Click" 
                                   UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
                                    CssClass="btn btn-sm fw-bold btn-primary"  CausesValidation="true"/>
                              --%>
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
  
       <div class="card-body" style="background-color:white; padding:20px;">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                 
                     <div class="kt-portlet__body">
                        
                           <div> <h3 class="kt-portlet__head-title">رأس الواجب </h3> </div> <br />
 
                        <div class="col-lg-12 row">

                            <asp:PlaceHolder runat="server" ID="Num">
                           <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">شفرة</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtNumber" runat="server" CssClass="form-control"  Width="100%" Enabled="false"></telerik:RadTextBox>
                                   
                                </div>
                            </div>
                            </asp:PlaceHolder>

                            <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">اسم</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight" Enabled="false"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                                     ControlToValidate="txtName" ErrorMessage="الرجاء إدخال الاسم" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">حالة</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%" RenderMode="Lightweight" Enabled="false">
                                        <items>
                                            <telerik:DropDownListItem Text="ممكن" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="عاجز" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                           

                        </div>                     
                    </div>
                    <asp:PlaceHolder runat="server" ID="product">
                     <div class="kt-portlet__body">
                         <div><b> أضف المنتجات</b></div> <br />
                          <div class="col-lg-12 row">                                                  

                            <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">منتج</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlProduct" runat="server" Width="100%" RenderMode="Lightweight" Filter="Contains" EmptyMessage="حدد المنتج" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                     ControlToValidate="ddlProduct" ErrorMessage="الرجاء تحديد المنتج" ForeColor="Red" Display="Dynamic" ValidationGroup="frm"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                           <%-- <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Status</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStat" runat="server" Width="100%" RenderMode="Lightweight">
                                        <items>
                                            <telerik:DropDownListItem Text="Enabled" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Disabled" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>--%>

                            <div class="col-lg-4 form-group" style="padding-top: 20px; padding-bottom: 20px;">
                                <div class="col-lg-12">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                <asp:LinkButton ID="BtnAdd" runat="server" ValidationGroup="frm" UseSubmitBehavior="false" OnClick="BtnAdd_Click" Text='<i class="icon-ok"></i> يضيف'
                                    CssClass="btn btn-sm fw-bold btn-success" style="display:inline-grid;" CausesValidation="true"/>

                                
                                </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
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
                    </asp:PlaceHolder>
                    <!--end: Search Form -->
                    <div class="kt-portlet__body">

                         <div class="col-lg-12 row"  style="padding-top: 20px; padding-bottom: 20px;">
                                     <div class="col-lg-10">
                                        <h3 class="kt-portlet__head-title">تفاصيل الواجب
                                        </h3>
                                    </div>
                                    <div class="col-lg-2" style="text-align:end">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                            <asp:LinkButton ID="BtnDelete" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="إزالة المنتج"   OnClick="BtnDelete_Click"></asp:LinkButton>
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


                        <%-- <div><b> Assignment Detail </b></div> <br />--%>
                       
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">
                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false"  AllowMultiRowSelection="true"
                            ID="grvRpt" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="grvRpt_NeedDataSource"
                           
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                <Selecting AllowRowSelect="True" />
                               
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="asd_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>

                                   <%-- <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                    </telerik:GridButtonColumn>--%>

                                     

                                    <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn"  HeaderStyle-Width="30px">
                                                        </telerik:GridClientSelectColumn>

                                 

                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="منتج" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="فئة" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="تصنيف فرعي" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="ماركة" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
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
 </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">هل أنت متأكد أنك تريد الحفظ .. ؟؟
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                    <asp:LinkButton ID="lnkAdd" runat="server" Text="نعم" OnClick="lnkAdd_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                        </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">يلغي</button>
                </div>
            </div>
        </div>
    </div>
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
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    <!--begin::FailedModal-->
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
    <!--end::FailedModal-->

    <div class="modal fade modal-center" id="modalConfirms" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirms">هل أنت متأكد أنك تريد الحفظ .. ؟؟
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                    <asp:LinkButton ID="LinkButton1" runat="server" Text="نعم" OnClick="LinkButton1_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                        </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirms);">يلغي</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span id="successs"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">أُووبس..!</h5>
                </div>
                <div class="modal-body">
                    <span>هناك شئ خاطئ، يرجى المحاولة فى وقت لاحق.</span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_7);">نعم</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

      <%--delete--%>
  
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span>تم حذف البيانات بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="deleteOk" runat="server" OnClick="deleteOk_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

     <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <!--end::SuccessModal-->
     <div class="modal fade" id="kt_modal" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">هل أنت متأكد أنك تريد حذف ؟</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="linkdelete" runat="server" OnClick="linkdelete_Click" CssClass="btn btn-sm fw-bold btn-primary">
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
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal);">يلغي</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->
</asp:Content>
