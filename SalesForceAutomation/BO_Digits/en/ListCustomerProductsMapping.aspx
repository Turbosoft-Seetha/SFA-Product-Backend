<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListCustomerProductsMapping.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListCustomerProductsMapping" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function cusroute() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("Id");
            var R = url.searchParams.get("RID");
            window.location.href = "ListCustomerRoute.aspx?Id=" + R;
        }
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
        }
        function failedModal(res) {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#failres').text(res);
        }
        function Delete() {
            $('#kt_modal_1_7').modal('show');
        }
        function deleteSucces() {
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_8').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

     <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
           <asp:Label class="control-label" Font-Bold="true" runat="server">Change Product Group </asp:Label>
         <telerik:RadDropDownList Skin="Material" Filter="Contains" CloseDropDownOnBlur="true" RenderMode="Lightweight" OnSelectedIndexChanged="rdPromapping_SelectedIndexChanged" AutoPostBack="true"
                                                    ID="rdPromapping" runat="server"
                                                    DefaultMessage="Select Product Group" ValidationGroup="frm" CausesValidation="true" >
                                                </telerik:RadDropDownList>

        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" ValidationGroup="frm"  OnClick="LinkButton2_Click">
                                                    Change Mapping
    </asp:LinkButton>
          <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-secondary" CausesValidation="false" OnClick="lnkCancel_Click">
                                                    Back
    </asp:LinkButton><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="frm"
            ControlToValidate="rdPromapping" ErrorMessage="Please Select Product Group" ForeColor="Red" Display="Dynamic" style="margin-left:130px;" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
    </telerik:RadAjaxPanel>
                                   
                                           
                                           
                                              
                                          
                               
    
   
         
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">



                    <!--begin::Form-->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <div class="kt-form kt-form--label-right" style="padding-bottom: 10px;">

                            <div class="kt-portlet__body pb-0">

                                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" Expanded="false">
                                    <Items>
                                        <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                            <ContentTemplate>
                                                <div class="kt-portlet__body" style="background-color: white; display: grid; padding-left: 20px">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <div class="col-lg-6 mb-2">
                                                                    <label class="col-lg-2 col-form-label" style="display: contents;"></label>
                                                                    <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                        <asp:Label ID="Progrp" Font-Bold="true" runat="server"></asp:Label></label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div class="col-lg-12 row">
                                                                    <div class="col-lg-6">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="cusroute" Font-Bold="true" runat="server"></asp:Label></label>

                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Created Date:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>

                                                                    </div>


                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div class="col-lg-12 row">
                                                                    <div class="col-lg-6">

                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="custname" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Created By:</label>
                                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                            <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                                    </div>
                                                                </div>


                                                            </td>
                                                        </tr>


                                                    </table>


                                                </div>

                                            </ContentTemplate>
                                        </telerik:RadPanelItem>
                                    </Items>
                                </telerik:RadPanelBar>
                            </div>


                            <div class="kt-portlet__body">

                                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                               

                            </div>
                        </div>

                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                            ID="grvRpt" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="grvRpt_NeedDataSource"
                            OnItemCommand="grvRpt_ItemCommand"
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

                                    <%-- <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px"
                                             EditFormColumnIndex="0" UniqueName="EditColumn">
                                        </telerik:GridButtonColumn>--%>


                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code" Visible="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name" Visible="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="pmd_CusItmCode" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer ItmCode" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pmd_CusItmCode" Visible="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="pmd_VATPerc" AllowFiltering="true" HeaderStyle-Width="30px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="VAT %" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="pmd_VATPerc" Visible="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Category" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cat_Name" Visible="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Subcategory" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="sct_Name" Visible="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Brand" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Name" Visible="true">
                                    </telerik:GridBoundColumn>





                                </Columns>
                            </MasterTableView>
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </telerik:RadAjaxPanel>
                </div>

            </div>

            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                BackColor="Transparent"
                ForeColor="Blue">
                <div class="col-lg-12 text-center mt-5">
                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                </div>
            </telerik:RadAjaxLoadingPanel>
        </div>
    </div>



    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to save ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="LinkButton1_Click">
                                                    Yes
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:700px;">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Product Group has been updated successfully.</span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        
                        <asp:LinkButton ID="Proceedmap" runat="server" Text="Proceed with Special Price Mapping" OnClick="Proceedmap_Click" CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="false" />                         
                        <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Proceed without Special Price Mapping</asp:LinkButton>
                        <asp:LinkButton ID="lnkGotoCus" runat="server" OnClick="lnkGotoCus_Click" CssClass="btn btn-sm fw-bold btn-warning">Go to Customer</asp:LinkButton>

                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                   <%-- <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_4);">Cancel</button>--%>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failres"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" data-dismiss="modal">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::SuccessModal-->
    <%-- <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Data Deleted Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>--%>
    <!--end::SuccessModal-->
</asp:Content>
