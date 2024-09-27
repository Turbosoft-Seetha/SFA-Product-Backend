<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RevertLoadIn.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RevertLoadIn" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

    <script type="text/javascript">

        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Reject() {
            $('#kt_modal_1_2').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function failedModal(b) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#failtext').text(b);
        }
        function failedModals() {

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

 <telerik:RadAjaxPanel ID="rvt" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                      <asp:linkbutton  ID="btnRevert" Visible="true" CssClass="btn btn-sm btn-light-primary me-2"  runat="server" onClick="btnRevert_Click" style="background-color: red !important; color: white !important;" > Revert

                            <%--<asp:linkbutton  ID="Linkbutton2" Visible="true" CssClass="btn btn-sm btn-light-primary btn-light-red me-2"  runat="server" onClick="btnRevert_Click" > Revert--%>
</asp:linkbutton>
    
         
  
             </telerik:RadAjaxPanel>
  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
      BackColor="Transparent"
      ForeColor="Blue">
      <div class="col-lg-12 text-center mt-5">
          <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
      </div>
  </telerik:RadAjaxLoadingPanel>




</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">

                    
                        
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                               <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                <div class="kt-portlet__body">
                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                                <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                   
                                     <div class="col-lg-12 ">

                                     <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                    <div class="col-lg-4 form-group" style="padding-top: 10px;">
                                        <label class="control-label col-lg-12">Enter Customer to Populate Load in Number <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadTextBox ID="LoadTxtBOX" runat="server" CssClass="form-control" Width="100%" Enabled="true">

                                            </telerik:RadTextBox>



                                        </div>
                                    </div>
                                    <div class="col-lg-2" style="text-align: center; padding-top: 15px;  width: auto;">
                                        <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkFilter_Click">
                                                    Search
                                        </asp:LinkButton>
                                    </div>

                                                     <div class="col-lg-4">
                                            <label class="control-label col-lg-12">Load in Number</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains"  RenderMode="Lightweight" Width="100%"
                                                    ID="rdLoadinNum" runat="server" EmptyMessage="Select Load in Number" >
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>

                                                  <div class="col-lg-2" style="padding-top: 15px;">
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" CausesValidation="false" OnClick="LinkButton1_Click">
                                                    Filter
                                        </asp:LinkButton>
                                    </div>

                                     </div>

                                </div>
                              
                                </div>
                             

                                <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="True"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    OnItemDataBound="grvRpt_ItemDataBound"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true" ScrollHeight="500px">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="lih_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                             <telerik:GridClientSelectColumn HeaderStyle-Width="30px" UniqueName="chkAll"></telerik:GridClientSelectColumn>

                                            <%--<telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>
                                            <telerik:GridBoundColumn DataField="lih_TransID" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="TransID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="lih_TransID">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                            </telerik:GridBoundColumn>
                                           <%-- <telerik:GridBoundColumn DataField="emp_Name" AllowFiltering="true" HeaderStyle-Width="110px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Inventory Controller" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="emp_Name">
                                            </telerik:GridBoundColumn>--%>
                                            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                          

                                            <telerik:GridBoundColumn DataField="lrh_Number" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Request Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="lrh_Number">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
                                            </telerik:GridBoundColumn>

                                            <%--<telerik:GridBoundColumn DataField="lih_Rejection_Reason" AllowFiltering="true" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Rejection Reason" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="lih_Rejection_Reason">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="Signature" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>

                                                    <asp:HyperLink ID="img1" runat="server" NavigateUrl=' <%#"../" +  Eval("lih_Signature") %>' Target="_blank">
                                                        <asp:Image ID="lihImage" runat="server" ImageUrl=' <%# "../" + Eval("lih_Signature") %>' Height="20px" Width="20px" />
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>

                                        </Columns>
                                    </MasterTableView>
                                    <PagerStyle AlwaysVisible="true" />
                                    <GroupingSettings CaseSensitive="false" />
                                    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                        <Resizing AllowColumnResize="true"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                    </ClientSettings>
                                </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                      </div>
                            </telerik:RadAjaxPanel>

                 
                            <%--<telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>--%>
                        </div>
                    
                </div>



                </div>
            </div>
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




                                <div class="modal fade" id="kt_modal_1_5" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                   <div class="modal-dialog" role="document">
                                         <div class="modal-content">
                                              <div class="modal-header">
                                                <h5 class="modal-title">Oops..!</h5>
                                              </div>
                                          <div class="modal-body">
                                            <span id="failtext"></span>
                                          </div>
                                     <div class="modal-footer">
                                              <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                                         </div>
                                  </div>
                            </div>
                          </div>
                                    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="Confirm">Are you sure you want Revert Load in??
                                                    </h5>
                                                </div>
                                                <div class="modal-footer">
                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                                                    </telerik:RadAjaxPanel>
                                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                        <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
