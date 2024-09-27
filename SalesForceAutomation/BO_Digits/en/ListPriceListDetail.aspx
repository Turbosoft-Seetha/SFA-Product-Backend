<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListPriceListDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListPriceListDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function delConfim() {
            $('#modaldelConfirm').modal('show');
            $('#modalUpdateConfirm').modal('hide');

        }

        function successModal() {
            $('#modaldelConfirm').modal('hide');
            $('#modalUpdateConfirm').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }
            function successModal2() {
                $('#modaldelConfirm').modal('hide');
                $('#modalUpdateConfirm').modal('hide');
                $('#kt_modal_1_8').modal('show');
            }
        
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#modalUpdateConfirm').modal('hide');
            $('#kt_modal_1_9').modal('show');
        }
        function UpdateConfim() {
            $('#modalUpdateConfirm').modal('show');
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_9').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#modaldelConfirm').modal('hide');

        }
    </script>

</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

    <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

        <asp:LinkButton ID="lnkSubCat" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" OnClick="lnkSubCat_Click"></asp:LinkButton>
        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm fw-bold btn-secondary" Text="Delete" OnClick="lnkDelete_Click"></asp:LinkButton>
        <asp:LinkButton ID="lnlUpdate" runat="server" CssClass="btn btn-sm fw-bold btn-warning" Text="Update" OnClick="lnlUpdate_Click"></asp:LinkButton>

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">






                        <!--begin::Form-->
                        <div class="kt-form kt-form--label-right">
                            <div class="kt-portlet__body pb-0">
                                <div class="card-body" style="background-color: white; padding-bottom: 10px;">

                                    <div class="kt-portlet__head-actions" style="text-align-last: end;">
                                    </div>


                                    <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                        <Items>
                                            <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                                <ContentTemplate>
                                                    <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px;">
                                                        <table>
                                                            <td style="width: 56%">
                                                                <div class="col-lg-6 mb-2">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;">Special Price Name:</label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label>
                                                                    </label>
                                                                </div>
                                                               

                                                                <td>

                                                                    <div class="col-lg-12 mb-2">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Status:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblstatus" Font-Bold="true" runat="server"></asp:Label>
                                                                        </label>
                                                                    </div>



                                                                </td>
                                                        </table>


                                                    </div>

                                                </ContentTemplate>
                                            </telerik:RadPanelItem>
                                        </Items>
                                    </telerik:RadPanelBar>
                                </div>
                            </div>

                            <!--end: Search Form -->
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                <div class="kt-portlet__body">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
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
                                            ShowFooter="false" DataKeyNames="pld_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                </telerik:GridClientSelectColumn>

                                                 <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="10px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                                   </telerik:GridButtonColumn>

                                                  <telerik:GridBoundColumn DataField="prh_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Price Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prh_Code" Display="false">
                                                </telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="prh_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Price Name" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prh_Name" Display="false">
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

                                                <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Sub Category" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="uom_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="pru_Price" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Std Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_Price">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="pld_Price" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Spl Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pld_Price" Display="false">
                                                </telerik:GridBoundColumn>

                                                   <telerik:GridTemplateColumn HeaderStyle-Width="90px" AllowFiltering="false" HeaderText="Spl Price" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtSplPrice" Width="100%" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                                    </telerik:RadNumericTextBox>


                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="pld_ReturnPrice" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Rtn Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pld_ReturnPrice" Display="false">
                                                </telerik:GridBoundColumn>

                                                  <telerik:GridTemplateColumn HeaderStyle-Width="90px" AllowFiltering="false" HeaderText="Rtn Price" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtRtnPrice" Width="100%" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                                    </telerik:RadNumericTextBox>


                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="pld_VATPerc" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="VAT %" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pld_VATPerc" Display="false">
                                                </telerik:GridBoundColumn>
                                               
                                            </Columns>
                                        </MasterTableView>
                                        <PagerStyle AlwaysVisible="true" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
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
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--delete--%>
    <div class="modal fade modal-center" id="modaldelConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnDelete" runat="server" Text="Yes" OnClick="BtnDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Data Deleted Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="BtnDelConfrm" runat="server" OnClick="BtnDelConfrm_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade modal-center" id="modalUpdateConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to update..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="btnUpdate" runat="server" Text="Yes" OnClick="btnUpdate_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalUpdateConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Data Updated Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="BtnDelConfrm_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
