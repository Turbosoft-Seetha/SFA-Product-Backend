<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="LoadIn.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.LoadIn" %>
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


        function Failure(b)
        {           
            $('#kt_modal_1_5').modal('show');
            $('#failure').text(b);
        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

              <%--<telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">--%>
                 
                   <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png"  ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />
                     
                    <asp:LinkButton ID="lnkcancel" runat="server" CssClass="btn btn-sm fw-bold btn-secondary"   Text="Done" OnClick="lnkcancel_Click"></asp:LinkButton>
                          
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

                             <h4 class="mb-4"> Transaction ID :    <telerik:RadLabel runat="server" ID="labelTno" Text=""></telerik:RadLabel>  </h4>  

                            <div class="col-lg-12 row">

                                   <div class="col-lg-4 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Date  <span class="required"> </span></label>
                                 <div class="col-lg-10">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdDate" Width="120%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ErrorMessage="Date is mandatory" ForeColor="Red" ControlToValidate="rdDate"></asp:RequiredFieldValidator>
                                        </div>
                            </div>
                                 
                                  <div class="col-lg-6 form-group" style="padding-bottom: 15px;">
                                <label class="control-label col-lg-12">Route  <span class="required"> </span></label>
                                <div class="col-lg-12">

                                    <telerik:RadComboBox ID="ddlp" runat="server" Width="100%" EmptyMessage="Select Route" RenderMode="Lightweight" OnSelectedIndexChanged="ddlp_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="frm"
                                        ControlToValidate="ddlp" ErrorMessage="Please choose Route" Display="Dynamic" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                               

                            </div>
                        
                   <!-- ------------------------------------->

                   
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                            <div class="col-lg-12 row">

                                 <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">Product <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlProduct" runat="server" Width="100%" EmptyMessage="Select Product" Filter="Contains" AutoPostBack="true" RenderMode="Lightweight" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlProduct" ErrorMessage="Please choose Product" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                              

                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">Higher UOM  <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlHUom" runat="server" AutoPostBack="true" EmptyMessage="Select Higher UOM" Width="100%" Filter="Contains"
                                            RenderMode="Lightweight" OnSelectedIndexChanged="ddlHUom_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlHUom" ErrorMessage="Please choose Higher UOM" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>


                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">Higher Qty <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtHQty" NumberFormat-DecimalDigits="0" runat="server"  EmptyMessage="Type here" Width="100%" RenderMode="Lightweight" OnTextChanged="txtHQty_TextChanged" AutoPostBack="true"></telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtHQty" ErrorMessage="Please Enter Higher Qty" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                         <div class="danger"><asp:Literal ID="qt" runat="server" Visible="false"></asp:Literal> </div>
                                   
                                    </div>
                                </div>

                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">Lower UOM <span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlLUom" runat="server" AutoPostBack="true" EmptyMessage="Select Lower UOM" Filter="Contains" Width="100%" RenderMode="Lightweight" OnSelectedIndexChanged="ddlLUom_SelectedIndexChanged"></telerik:RadComboBox>
                                       <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                            ControlToValidate="ddlLUom" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                                <div class="col-lg-2 form-group">
                                    <label class="control-label col-lg-12">Lower Qty <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadNumericTextBox ID="txtLQty" NumberFormat-DecimalDigits="0" runat="server"  EmptyMessage="Type here" Width="100%" RenderMode="Lightweight"></telerik:RadNumericTextBox>
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtLQty" ErrorMessage="Please Enter Lower Qty" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                         <div class="danger"><asp:Literal ID="lq" runat="server" Visible="false"></asp:Literal> </div>
                                
                                    </div>
                                </div>

                                 <div class="col-lg-2" style="text-align: center; padding-top: 20px;">
                                        <asp:LinkButton ID="AddItem" runat="server" CssClass="btn btn-sm btn-primary me-2" ValidationGroup="form" OnClick="AddItem_Click" CausesValidation="true"  BackColor="#DAE9F8" ForeColor="#009EF7">
                                                    ADD 
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
                                    
                                        <h3 class="kt-portlet__head-title">Details</h3>

                                    </div>
                                    <div class="col-lg-2" style="padding-left: 60px;">
                                        <asp:LinkButton ID="lnkupdate" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkupdate_Click">
                                                    Update 
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
                                        AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="lid_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                 <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Delete" ID="Deletebtn" Visible="true" AlternateText="Delete" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                                 <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Item" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                </telerik:GridBoundColumn>
                                                
                                                <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Sub Category" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="lid_HigherUom" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_HigherUom">
                                                </telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="lid_HigherQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qtys" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="lid_HigherQty" Display="false">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Higher Qty" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                        <ItemStyle HorizontalAlign="Right" /><HeaderStyle HorizontalAlign="Right" />

                                                        <ItemTemplate>

                                                            <telerik:RadNumericTextBox ID="txtHQTY" NumberFormat-AllowRounding="false" Width="100%" runat="server" Enabled="true" RenderMode="Lightweight" Style="text-align: right;">
                                                            </telerik:RadNumericTextBox>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                <telerik:GridBoundColumn DataField="lid_LowerUom" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_LowerUom">
                                                </telerik:GridBoundColumn>


                                                 <telerik:GridBoundColumn DataField="lid_LowerQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qtys" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="lid_LowerQty" Display="false">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Lower Qty" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                        <ItemStyle HorizontalAlign="Right" /><HeaderStyle HorizontalAlign="Right" />

                                                        <ItemTemplate>

                                                            <telerik:RadNumericTextBox ID="txtLQTY" NumberFormat-AllowRounding="false" Width="100%" runat="server" RenderMode="Lightweight" Enabled="true" Style="text-align: right;">
                                                            </telerik:RadNumericTextBox>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                <%--<telerik:GridBoundColumn DataField="user" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Order" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="user" Visible="false">
                                                </telerik:GridBoundColumn>--%>

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
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failure"></span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Cancel</button>
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
                    <h5 class="modal-title">Are you sure you want to delete..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnConfrmDelete" runat="server" Text="Yes" OnClick="BtnConfrmDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Data Deleted Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="delOk" runat="server" OnClick="delOk_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

</asp:Content>
