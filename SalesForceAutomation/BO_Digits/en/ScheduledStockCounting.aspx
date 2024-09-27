<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ScheduledStockCounting.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ScheduledStockCounting" %>
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
      function CompareModel(a) {
          $('#CompareModel').modal('show');
          $('#nowrow').text(a);
      }
  </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">   
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
    <asp:LinkButton ID="btnProceed" Width="100px" runat="server" ValidationGroup="form" OnClick="btnProceed_Click" UseSubmitBehavior="false"
        Text='<i class="icon-ok"></i>Proceed' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
    <asp:LinkButton ID="btnCancel" Width="100px" runat="server"
        Text="Cancel"
        CausesValidation="False" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="btnCancel_Click" />
</telerik:RadAjaxPanel>
     <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <br />
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <%--<div class="kt-portlet__head" style="padding-top: 20px">

                       
                    </div>--%>


                        <div class="kt-portlet__body">
                             <telerik:RadAjaxPanel ID="cdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <div class="col-lg-12 row mb-4">

                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">Expected Date<span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="ddlExpDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlExpDate" ErrorMessage="Please Enter Expected Date" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                                        </div>
                                    </div>
                                 
                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">Warehouse</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlWarehouse" runat="server" Width="100%" EmptyMessage="Please Select" RenderMode="Lightweight" Filter="Contains"
                                                CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlWarehouse_SelectedIndexChanged"
                                                  CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                            </telerik:RadComboBox>
                                           
                                        </div>
                                    </div>
                                </div>
                           
                                <div class="kt-form kt-form--label-right">
                                    <div class="kt-portlet__body">
                                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                            ID="grvRpt" GridLines="None"
                                            ShowFooter="True" AllowSorting="True"
                                            OnNeedDataSource="grvRpt_NeedDataSource"
                                            OnItemDataBound="grvRpt_ItemDataBound"
                                            AllowFilteringByColumn="true"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            AllowPaging="true" PageSize="100" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                <Selecting AllowRowSelect="true" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="wim_prd_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridClientSelectColumn HeaderStyle-Width="30px" UniqueName="chkAll"></telerik:GridClientSelectColumn>

                                                    <telerik:GridBoundColumn DataField="wim_prd_ID" AllowFiltering="true" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="wim_prd_ID" Display="false">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>

                                                      <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="wim_war_ID" AllowFiltering="true" HeaderStyle-Width="50px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="warehouse ID" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="wim_war_ID" Display="false">
                                                    </telerik:GridBoundColumn>

                                                      <telerik:GridBoundColumn DataField="war_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Warehouse Code" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="war_Code">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="war_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Warehouse" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="war_Name">
                                                    </telerik:GridBoundColumn>
                                                                                                   


                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>

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
                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>
    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" ValidationGroup="form" CssClass="btn btn-sm fw-bold btn-primary" OnClick="save_Click" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
     <div class="modal fade" id="CompareModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Oops!</h5>
            </div>
            <div class="modal-body">
                <span id="nowrow">No items selected</span>
            </div>
            <div class="modal-footer">
                <asp:LinkButton ID="norowslected" runat="server" OnClick="norowslected_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
            </div>
        </div>
    </div>
</div>

    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
