<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddTaskCustomerRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddTaskCustomerRoute" %>
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
        function failedModals() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_9').modal('show');
         }
         function Customer() {
             $('#kt_modal_1_10').modal('show');
         }

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>   
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
<AjaxSettings>
    
    <telerik:AjaxSetting AjaxControlID="ddlRoute">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel6" />
    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel4" />

     </UpdatedControls>
    </telerik:AjaxSetting>

     <telerik:AjaxSetting AjaxControlID="ddlmdr">
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

    <div class="card-body" style="background-color:white; padding:20px;">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <h6 class="kt-portlet__head-title">Task Name : 
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            </h6>
                       

                    <div class="kt-portlet__head">
                        <div class="col-lg-12 row">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4" Width="60%">
                                <div class="col-lg-12 row">
                                    <div class="col-lg-3" style="padding-top: 8px;">
                                        <div class="col-lg-12">
                                            <label class="control-label col-lg-12 pl-0">Route </label>
                                        </div>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlRoute" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select Route"
                                                OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" AutoPostBack="true" RenderMode="Auto">
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>

                              <%--  <div class="col-lg-6" style="padding-top: 8px;">
                                     <label class="control-label col-lg-12 pl-0">Route </label>
                                    <telerik:RadDropDownList ID="ddlmdr" runat="server" Width="100%"
                                                             EmptyMessage="Please Select">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>--%>

                                      <div class="col-lg-3" style="padding-top: 8px;">
                                        <div class="col-lg-12">
                                            <label class="control-label col-lg-12 pl-0">Is Mandatory</label>
                                        </div>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlmdr" runat="server" Width="100%"
                                                             EmptyMessage="Please Select" DefaultMessage="Please Select" RenderMode="Auto">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                        </div>
                                    </div>
                                                            <div class="col-lg-3"  style="padding-top: 8px;">
                                            <div class="col-lg-12">
                                    <label class="control-label col-lg-12">Start Date</label>
                                                </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Start Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-3"  style="padding-top: 8px;">
                                      <div class="col-lg-12">
                                    <label class="control-label col-lg-12">End Date</label>
                                          </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="End Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                    </div>
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
                            
                        </div>
                    </div>
                    <div class="col-lg-12 row" style="margin-top:20px;">
                    <div class="col-lg-6">

                        <!--begin::Portlet-->
                        <div class="kt-portlet">

                            <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                <div class="col-lg-10">
                                    <h3 class="kt-portlet__head-title">Unassigned Customers
                                    </h3>
                                </div>
                                <div class="col-lg-2">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                    <asp:LinkButton ID="lnkAddQuestion" runat="server" CssClass="btn btn-sm fw-bold btn-success"  OnClick="lnkAddQuestion_Click" Style="align-content:flex-end;">
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
                                                ShowFooter="false" DataKeyNames="rcs_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                    </telerik:GridClientSelectColumn>

                                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="rot_ID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" Display="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="rot_ID">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="cus_ID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" Display="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_ID">
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
                                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
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
                                    <h3 class="kt-portlet__head-title">Assigned Customers
                                    </h3>
                                </div>
                                <div class="col-lg-2">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                        <asp:LinkButton ID="lnkRemove" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="Remove"  OnClick="lnkRemove_Click" style="background-color: red;border-color: red;"></asp:LinkButton>
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
                                                ShowFooter="false" DataKeyNames="cst_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn" HeaderStyle-Width="30px">
                                                    </telerik:GridClientSelectColumn>

                                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                    </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="cst_StartDate" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Start Date" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" 
                                                        HeaderStyle-Font-Bold="true" UniqueName="cst_StartDate">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="cst_EndDate" AllowFiltering="true" HeaderStyle-Width="60px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="End Date" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" 
                                                        HeaderStyle-Font-Bold="true" UniqueName="cst_EndDate">
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Customer Task has been inserted successfully.</span>
                </div>
                <div class="modal-footer">
                     <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                      </telerik:RadAjaxPanel>
  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Customer Task has been deleted successfully.</span>
                </div>
                <div class="modal-footer">
                     <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel9">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                 </telerik:RadAjaxPanel>
  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
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
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_10" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">All Customers assigned for survey</h5>
                </div>
                <div class="modal-body">
                    <asp:Literal ID="ltCustomerTable" runat="server" />
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_10);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->
</asp:Content>
