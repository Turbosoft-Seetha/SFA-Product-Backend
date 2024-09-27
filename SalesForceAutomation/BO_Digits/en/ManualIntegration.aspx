<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ManualIntegration.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ManualIntegration" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_8').modal('show');
            $('#delsuccess').text(a);
        }
        function failedModals() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_9').modal('show');
            ('#response').text(a);

        }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

      <script>
         

          function copyPassword() {
              var passwordElement = document.getElementById("delsuccess");
              var range = document.createRange();
              range.selectNode(passwordElement);
              window.getSelection().removeAllRanges(); // Clear current selection
              window.getSelection().addRange(range); // Select the text
              document.execCommand("copy"); // Copy selected text to clipboard
              window.getSelection().removeAllRanges(); // Clear the selection after copying
              alert("Content copied!");
          }
      </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                        ID="grvRpt" GridLines="None"
                        ShowFooter="True" AllowSorting="True"
                        OnNeedDataSource="grvRpt_NeedDataSource"
                        OnItemCommand="grvRpt_ItemCommand"
                        AllowFilteringByColumn="true"
                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                        EnableAjaxSkinRendering="true"
                        AllowPaging="true" PageSize="50" CellSpacing="0">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
                        </ClientSettings>
                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                            ShowFooter="false" DataKeyNames="iws_ID"
                            EnableHeaderContextMenu="true">
                            <Columns>

                                <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="pdfClick">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="ERP" CommandName="ERPCall" runat="server" Text="RUN"
                                            CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="ERP_Click" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="iws_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Webservice Name" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="iws_Name">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="iws_URL" AllowFiltering="true" HeaderStyle-Width="400px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="URL" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="iws_URL">
                                </telerik:GridBoundColumn>

                                <%--<telerik:GridBoundColumn DataField="web_Description" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="web_Description">
                                </telerik:GridBoundColumn>--%>

                                <telerik:GridBoundColumn DataField="iws_Method" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Method" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="iws_Method">
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
                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                    BackColor="Transparent"
                    ForeColor="Blue">
                    <div class="col-lg-12 text-center mt-5">
                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                    </div>
                </telerik:RadAjaxLoadingPanel>
            </div>
        </div>
    </div>
    <div class="modal fade modal-center" id="modalConfirm" style="height: auto;" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to Run..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="Run" runat="server" Text="Yes" OnClick="Run_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_8" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Response</h5>

                      <div class="ml-auto">
<%--                    <input type="text" id="txtNewPassword" class="form-control" readonly />--%>
                  <button class="btn btn-outline-secondary" type="button" id="btnCopyPassword" onclick="copyPassword()">
    <i class="bi bi-clipboard " style="color: gray;"></i> <!-- Font Awesome icon for copy -->
</button>
                </div>
                </div>
                <div class="modal-body">
                    <span id="delsuccess"> Content to be copied</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lnkOK" runat="server" OnClick="lnkOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <div class="clearfix"></div>
    <div class="modal fade" id="kt_modal_1_9" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <p>Something Went Wrong.</p>
                    <span id="response"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
