<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="LoadIn.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.LoadIn" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(ab) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#Success').text(ab);
        }
        function Confm() {
            $('#modalConfirm1').modal('show');
        }
        function Succces(cd) {
            $('#modalConfirm1').modal('hide');
            $('#kt_modal_1_8').modal('show');
            $('#Success1').text(cd);
        }

        //function Failure() {
        //    $('#modalConfirm').modal('hide');
        //    $('#kt_modal_1_5').modal('show');
        //}
        function delConfim() {
            $('#modaldelConfirm').modal('show');

        }

        function successModal() {
            $('#modaldelConfirm').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }


        function Failure(b) {
            $('#kt_modal_1_5').modal('show');
            $('#failure').text(b);
        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

              <%--<telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">--%>
                 
                   <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png"  ToolTip="تحميل" OnClick="imgExcel_Click" AlternateText="Xlsx" />
                     
                    <asp:LinkButton ID="lnkcancel" runat="server" CssClass="btn btn-sm fw-bold btn-secondary"   Text="منتهي" OnClick="lnkcancel_Click"></asp:LinkButton>
                          
              <%--                
               </telerik:RadAjaxPanel>
               <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                BackColor="Transparent"
                ForeColor="Blue">
                <div class="col-lg-12 text-center mt-5">
                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                </div>
                </telerik:RadAjaxLoadingPanel> --%>
    
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
         <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid" >
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    
                    
                   
                    <!--begin::Forkt-->
                     <div class="kt-portlet__body">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">

                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                             <h4 class="mb-4"> رقم المعاملة :    <telerik:RadLabel runat="server" ID="labelTno" Text=""></telerik:RadLabel>  </h4>  

                            <div class="col-lg-12 row">

                                   <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">تاريخ  <span class="required"> </span></label>
                                 <div class="col-lg-10">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdDate" Width="120%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ErrorMessage="التاريخ إلزامي" ForeColor="Red" ControlToValidate="rdDate"></asp:RequiredFieldValidator>
                                        </div>
                            </div>
                                 
                                  <div class="col-lg-6 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">طريق  <span class="required"> </span></label>
                                <div class="col-lg-12">

                                    <telerik:RadComboBox ID="ddlp" runat="server" Width="100%" EmptyMessage="حدد الطريق" RenderMode="Lightweight" OnSelectedIndexChanged="ddlp_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="frm"
                                        ControlToValidate="ddlp" ErrorMessage="الرجاء اختيار الطريق" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                               

                            </div>
                        
                   <!-- ------------------------------------->

                   
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                            <div class="col-lg-12 row">

                                 <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">منتج <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlProduct" runat="server" Width="100%" EmptyMessage="حدد المنتج" Filter="Contains" AutoPostBack="true" RenderMode="Lightweight" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlProduct" ErrorMessage="الرجاء اختيار المنتج" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                              

                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">وحدة قياس أعلى <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlHUom" runat="server" AutoPostBack="true" EmptyMessage="حدد وحدة قياس أعلى" Width="100%" Filter="Contains"
                                            RenderMode="Lightweight" OnSelectedIndexChanged="ddlHUom_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlHUom" ErrorMessage="الرجاء اختيار وحدة قياس أعلى" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>


                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">كمية أعلى <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtHQty" NumberFormat-DecimalDigits="0" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight" OnTextChanged="txtHQty_TextChanged" AutoPostBack="true"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtHQty" ErrorMessage="الرجاء إدخال كمية أعلى" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                         <div class="danger"><asp:Literal ID="qt" runat="server" Visible="false"></asp:Literal> </div>
                                   
                                    </div>
                                </div>

                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">وحدة القياس السفلية <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlLUom" runat="server" AutoPostBack="true" EmptyMessage="حدد وحدة القياس السفلية" Filter="Contains" Width="100%" RenderMode="Lightweight" OnSelectedIndexChanged="ddlLUom_SelectedIndexChanged"></telerik:RadComboBox>
                                       <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                            ControlToValidate="ddlLUom" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">كمية أقل <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtLQty" NumberFormat-DecimalDigits="0" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadNumericTextBox>
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtLQty" ErrorMessage="Please Enter Lower Qty" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                         <div class="danger"><asp:Literal ID="lq" runat="server" Visible="false"></asp:Literal> </div>
                                
                                    </div>
                                </div>

                                 <div class="col-lg-2" style="text-align: center; padding-top: 20px;">
                                        <asp:LinkButton ID="AddItem" runat="server" CssClass="btn btn-sm btn-primary me-2" ValidationGroup="form" OnClick="AddItem_Click" CausesValidation="true"  BackColor="#DAE9F8" ForeColor="#009EF7">
                                                    يضيف
                                        </asp:LinkButton>
                                    </div>

                            </div>
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                        <!--end::Form-->
                    </div>
                    <asp:PlaceHolder ID="pnls" runat="server" Visible="true">
                        <!--Detail header-->
                        <div class=" col-lg-12 row" style="padding-top: 30px; padding-bottom: 20px;">
                                <div class="kt-portlet__head-label col-lg-10">
                                <h3 class="kt-portlet__head-title">تفاصيل
                                </h3>
                            </div>
                             <div class="col-lg-2" style="padding-left: 60px;">
                                        <asp:LinkButton ID="lnkupdate" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkupdate_Click">
                                                    تحديث 
                                        </asp:LinkButton>
                                    </div>
                        </div>
                        <!--End Detail header-->
                        <!--Detail Body-->
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                <div class="col-lg-12 row">

                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        OnItemCommand="grvRpt_ItemCommand"
                                        OnItemDataBound="grvRpt_ItemDataBound"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="lid_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                 <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="يمسح" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Delete" ID="Deletebtn" Visible="true" AlternateText="Delete" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                                   <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="رمز الصنف" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                </telerik:GridBoundColumn>

                                            <%--    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="غرض" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>--%>

                                                 <telerik:GridBoundColumn DataField="prd_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="اسم المنتج بالعربية" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_NameArabic">
                                            </telerik:GridBoundColumn>

                                                
                                              <%--  <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="ماركة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                                </telerik:GridBoundColumn>--%>
                                                 <telerik:GridBoundColumn DataField="brd_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="العلامة التجارية باللغة العربية" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="brd_NameArabic">
                                            </telerik:GridBoundColumn>

                                               <%-- <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="فئة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                </telerik:GridBoundColumn>--%>
                                                  <telerik:GridBoundColumn DataField="cat_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="التصنيف باللغة العربية" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cat_NameArabic">
                                            </telerik:GridBoundColumn>

                                               <%-- <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تصنيف فرعي" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                                </telerik:GridBoundColumn>--%>

                                                  <telerik:GridBoundColumn DataField="sct_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="التصنيف الفرعي باللغة العربية" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sct_NameArabic">
                                            </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="lid_HigherUom" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وحدة قياس أعلى" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_HigherUom">
                                                </telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="lid_HigherQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كمية أعلى" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_HigherQty" Display="false">
                                                </telerik:GridBoundColumn>

                                                 <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="كمية أعلى" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>

                                                            <telerik:RadNumericTextBox ID="txtHQTY" NumberFormat-AllowRounding="false" Width="100%" runat="server" Enabled="true">
                                                            </telerik:RadNumericTextBox>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>



                                                <telerik:GridBoundColumn DataField="lid_LowerUom" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وحدة القياس السفلية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_LowerUom">
                                                </telerik:GridBoundColumn>




                                              
                                                <telerik:GridBoundColumn DataField="lid_LowerQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كمية أقل" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_LowerQty" Display="false">
                                                </telerik:GridBoundColumn>

                                                 <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="كمية أقل" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>

                                                            <telerik:RadNumericTextBox ID="txtLQTY" NumberFormat-AllowRounding="false" Width="100%" runat="server" Enabled="true">
                                                            </telerik:RadNumericTextBox>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="user" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Order" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="user" Visible="false">
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
                                <!--End Detail Body-->
                                <!--Delete Anser-->

                                <!--end::Portlet-->
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>
    </div>
             </div>
  

     <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">أُووبس..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failure"></span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">يلغي</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->

      <%--delete--%>
    <div class="modal fade modal-center" id="modaldelConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">هل أنت متأكد أنك تريد حذف..؟؟
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnConfrmDelete" runat="server" Text="نعم" OnClick="BtnConfrmDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm);">يلغي</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">نجاح</h5>
                </div>
                <div class="modal-body">
                    <span>تم حذف البيانات بنجاح.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="delOk" runat="server" OnClick="delOk_Click" CssClass="btn btn-sm fw-bold btn-secondary">نعم</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

</asp:Content>