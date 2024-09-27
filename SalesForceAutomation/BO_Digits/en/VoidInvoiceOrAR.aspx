<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="VoidInvoiceOrAR.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.VoidInvoiceOrAR" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
        <script type="text/javascript">        
            function successModal(a) {
                $('#kt_modal_1_6').modal('hide');
                $('#kt_modal_1_5').modal('hide');
                $('#kt_modal_1_4').modal('show');
                $('#kt_modal_1_8').modal('hide');
                $('#kt_modal_1_9').modal('hide');
                $('#success').text(a);
            }
            function successModal2(a) {
                $('#kt_modal_1_4').modal('hide');
                $('#kt_modal_1_6').modal('hide');
                $('#kt_modal_1_5').modal('show');
                $('#kt_modal_1_8').modal('hide');
                $('#kt_modal_1_9').modal('hide');
                $('#success2').text(a);
            }
            function failedModals() {
                $('#kt_modal_1_4').modal('hide');
                $('#kt_modal_1_5').modal('hide');
                $('#kt_modal_1_6').modal('show');
                $('#kt_modal_1_8').modal('hide');
                $('#kt_modal_1_9').modal('hide');
            }
            function InvModal() {
                $('#kt_modal_1_4').modal('hide');
                $('#kt_modal_1_5').modal('hide');
                $('#kt_modal_1_6').modal('hide');
                $('#kt_modal_1_8').modal('show');
                $('#kt_modal_1_9').modal('hide');
            }
            function ARModal() {
                $('#kt_modal_1_4').modal('hide');
                $('#kt_modal_1_5').modal('hide');
                $('#kt_modal_1_6').modal('hide');
                $('#kt_modal_1_8').modal('hide');
                $('#kt_modal_1_9').modal('show');
            }

        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     


                     
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
   <%-- <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="InvoiceGrid">
                <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="InvoiceGrid" />
                    <telerik:AjaxUpdatedControl ControlID="ARGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ARGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ARGrid" />
                     <telerik:AjaxUpdatedControl ControlID="InvoiceGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
          
            
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>

    <div class="card-body p-8" style="background-color:white;"> 

    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
        <div class =" col-lg-12 row " style="padding-bottom : 10px;">


            <div class="col-lg-3">
                <label class="control-label col-lg-12">Transaction Type</label>
                <div class="col-lg-12">
                    <telerik:RadDropDownList ID="ddlTransType" runat="server" Width="100%" Filter="Contains" DefaultMessage="Select Transaction Type"
                        EmptyMessage="Select" RenderMode="Lightweight" OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged" AutoPostBack="true">
                        <Items>
                            <telerik:DropDownListItem Text="Invoice" Value="I" Selected="true"/>
                            <telerik:DropDownListItem Text="AR" Value="A" />

                        </Items>
                    </telerik:RadDropDownList>
                </div>
            </div>

             <asp:PlaceHolder ID="pnlInvNo" runat="server" Visible="false">
            <div class="col-lg-3">
                <label class="control-label col-lg-12">Enter Invoice No:</label>
                <div class="col-lg-12">
                    <telerik:RadTextBox ID="txtInvoiceNo" runat="server" Width="100%" CssClass="form-control"></telerik:RadTextBox>                   
                </div>
            </div>
                 </asp:PlaceHolder>

             <asp:PlaceHolder ID="pnlARNo" runat="server" Visible="false">
            <div class="col-lg-3">
                <label class="control-label col-lg-12">Enter AR No:</label>
                <div class="col-lg-12">
                   <telerik:RadTextBox ID="txtARNo" runat="server" Width="100%"  CssClass="form-control"></telerik:RadTextBox>                   
                </div>
            </div>
                 </asp:PlaceHolder>

            <div class="col-lg-2" style="text-align: center; top: 19px; padding-top: 15px;">
                <asp:LinkButton ID="lnkGoBtn" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="true" OnClick="lnkGoBtn_Click">
                                                    GO
                </asp:LinkButton>
            </div>

        </div>
                      
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                            ID="InvoiceGrid" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="InvoiceGrid_NeedDataSource"
                            OnItemCommand="InvoiceGrid_ItemCommand"
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="10" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="sal_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>                                  

                            
                                      <telerik:GridBoundColumn DataField="Number" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Inv. Number" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Number">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>                                  
                                    
                                    
                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                    </telerik:GridBoundColumn>             
                                    
                                      <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                    </telerik:GridBoundColumn>
                                    
                                    
                                    <telerik:GridBoundColumn DataField="sal_SalesAmount" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Sales Amount" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="sal_SalesAmount">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="Do void" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Void_Click">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="VoidInv" CommandName="DoVoidInv" runat="server" Text="VOID"
                                            CssClass="btn btn-sm btn-light-danger me-2 border-1" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                   
                                </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>

<asp:HiddenField ID="hfSalID" runat="server" />
<asp:HiddenField ID="hfNumber" runat="server" />

        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                            ID="ARGrid" GridLines="None"
                            ShowFooter="True" AllowSorting="True"
                            OnNeedDataSource="ARGrid_NeedDataSource"
                            OnItemCommand="ARGrid_ItemCommand"
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="10" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="arh_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>                                    

                                      <telerik:GridBoundColumn DataField="arh_ARNumber" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="AR Number" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="arh_ARNumber">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>                                  
                                    
                                    
                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                    </telerik:GridBoundColumn>                                  
                                    
                                    
                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="arh_CollectedAmount" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Collected Amount" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="arh_CollectedAmount">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="Do void" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Void_Click">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="VoidAR" CommandName="DoVoidAR" runat="server" Text="VOID" CssClass="btn btn-sm btn-light-danger me-2 border-1" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>



                                </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>

<asp:HiddenField ID="hfArhID" runat="server" />
<asp:HiddenField ID="hfARNum" runat="server" />


         
         </telerik:RadAjaxPanel>

                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>

        </div>



      <div class="clearfix"></div>
     <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                        <asp:LinkButton ID="ok1" runat="server" OnClick="ok_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
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
    <!--end::SuccessModal-->
      <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success2"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="ok2" runat="server" OnClick="ok_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
    <!--end::SuccessModal-->
     <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>No such data found!</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">Ok</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Note</h5>
                </div>
                <div class="modal-body">
                    <span>This wont effect any app transactions or van stock. This is just a back office update. Thus it is ignored in settlement.</span>
                </div>
                <div class="modal-footer">
                     <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <asp:LinkButton ID="InvNoteOK" runat="server" OnClick="InvNoteOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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

       <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Note</h5>
                </div>
                <div class="modal-body">
                    <span>This wont effect any app transactions. This is just a back office update. Thus it is ignored in settlement.</span>
                </div>
                <div class="modal-footer">
                     <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">
                        <asp:LinkButton ID="ARNoteOk" runat="server" OnClick="ARNoteOk_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
