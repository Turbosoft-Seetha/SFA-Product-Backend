<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OutOfStockItem.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OutOfStockItem" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">




    <script type="text/javascript">
        function showModal() {
            $('#kt_modal_1_3').modal('show');
        }

        function cancelModal(modalId) {
            $('#' + modalId).modal('hide');
        }
        function showModal1() {
            $('#kt_modal_1_4').modal('show');
        }
    </script>

    <%--  var imageUrl = '<%= ResolveUrl(imgInitial.ImageUrl) %>';
        document.getElementById('<%= imgInitial.ClientID %>').onclick = function () {
            openImageInNewTab(imageUrl);
            return false;
        };

        function openImageInNewTab(imageUrl) {
            if (imageUrl && imageUrl !== "") {
                window.open(imageUrl, "_blank");
            }
        }--%>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" ImageAlign="Right" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager2" runat="server">
</telerik:RadAjaxManager>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="lnkimg_Click1">
            <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="HiddenField2" />
                <telerik:AjaxUpdatedControl ControlID="pnlImg" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

</telerik:RadAjaxManagerProxy>
    <div class="card-body" style="background-color: white; padding: 20px;">


        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

                            <div class="card-body" style="background-color: white; padding-bottom: 10px;">

                                <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                    <Items>
                                        <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">
                                            <ContentTemplate>
                                                <div class="kt-portlet__body" style="background-color: white; display: grid; padding: 20px;">
                                                    <table>
                                                        <td style="width: 56%">
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblCustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Brand:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblBrand" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Location:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblLocation" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                            <div class="col-lg-12 mb-2" hidden="hidden">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Type:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblType" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                        </td>
                                                        <td style="width: 56%">
                                                            <div class="col-lg-12 mb-2" hidden="hidden">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Completed Date:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblCompletedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Date:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Time:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>
                                                            <%--  <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Initial Image:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <a href="#" id="imgInitialLink" onclick="openImageInNewTab('<%= ResolveUrl(imgInitial.ImageUrl) %>'); return false;">
                                                                    <asp:Image ID="imgInitial" runat="server" CssClass="img-fluid" width="20px" Height="20px" />
                                                                </a>
                                                                <asp:Label ID="lblNoImage" runat="server" CssClass="your-css-class" Text="No image" Visible="false" />
                                                            </label>
                                                        </div>

                                                        <script type="text/javascript">
                                                            function openImageInNewTab(imageUrl) {
                                                                if (imageUrl && imageUrl !== "") {
                                                                    window.open(imageUrl, "_blank");
                                                                }
                                                            }
                                                        </script>

                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Final Image:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                  <a href="#" id="imgFinalLink" onclick="openImageInNewTab('<%= ResolveUrl(imgFinal.ImageUrl) %>'); return false;">

                                                                <asp:Image ID="imgFinal" runat="server" CssClass="img-fluid" width="20px" Height="20px" />
                                                      </a>
                                                                <asp:Label ID="lblNoImage1" runat="server" CssClass="your-css-class" Text="No image" Visible="false" />
                                                            </label>
                                                        </div>

                                                          <script type="text/javascript">
                                                              function openImageInNewTab(imageUrl) {
                                                                  if (imageUrl && imageUrl !== "") {
                                                                      window.open(imageUrl, "_blank");
                                                                  }
                                                              }
                                                          </script>--%>



                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:LinkButton ID="lnkimg" CssClass="btn btn-sm fw-bold btn-success" runat="server" Text=" Initial Image" OnClick="lnkimg_Click1" CausesValidation="true" ValidationGroup="form"></asp:LinkButton>
                                                                </label>
                                                            </div>


                                                            <div class="col-lg-12 mb-2">
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-sm fw-bold btn-success" runat="server" Text=" Final Image" OnClick="LinkButton1_Click" CausesValidation="true" ValidationGroup="form"></asp:LinkButton>
                                                                </label>
                                                            </div>


                                                            <div class="col-lg-12 mb-2" hidden="hidden">
                                                                <label class="col-lg-2 col-form-label" style="display: contents;">Is Mandatory:</label>
                                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                    <asp:Label ID="lblMandatory" Font-Bold="true" runat="server"></asp:Label></label>
                                                            </div>

                                                          

                                                        </td>
                                                    </table>
                                                </div>
                                            </ContentTemplate>
                                        </telerik:RadPanelItem>
                                    </Items>
                                </telerik:RadPanelBar>
                            </div>
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                        <!--begin::Form-->



                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">

                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="osi_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Item Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Item " FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                </telerik:GridBoundColumn>

                                                <%--<telerik:GridBoundColumn DataField="prd_Desc" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Desc">
                                            </telerik:GridBoundColumn>--%>



                                                <telerik:GridBoundColumn DataField="cat_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Category Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Category" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sct_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Subcategory Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Subcategory" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="osi_Status" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="osi_Status">
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


<%--    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-body">


                    <div class="col-12" style="padding-left: 10px;">

                        <span class="min-w-50px fw-semibold text-gray-500 pt-5">Attached Images</span>

                        <div class="fs-7 fw-bold pt-1" style="color: black;">

                            <div class="col-lg-12 ">
    <asp:HiddenField ID="HiddenField1" runat="server" />
      <asp:PlaceHolder ID="pnlimg" runat="server">

      </asp:PlaceHolder>
  
</div>
                        </div>


                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal('kt_modal_1_3');">Cancel</button>
                </div>
            </div>
        </div>
    </div>--%>

     <div class="clearfix"></div>
 <div class="modal fade modal-center" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="Confirm">Initial Attachments
                 </h5>
             </div>
                                                             <div class="modal-body">

                 <span></span>
                 <div class="col-lg-12 row" style="padding-top: 10px;">
                            <div class="col-12" style="padding-left: 10px;">

<span class="min-w-50px fw-semibold text-gray-500 pt-5">Attached Images</span>

              <div class="fs-7 fw-bold pt-1" style="color: black;">

                   <div class="col-lg-12 ">
                     <asp:HiddenField ID="HiddenField2" runat="server" />
                       <asp:PlaceHolder ID="pnlImg" runat="server">

                       </asp:PlaceHolder>

                     
                   
                 </div>
                  <div class="mt-3">
                    <span class="min-w-50px fw-semibold text-gray-500 pt-5">Remarks : </span>

                        <asp:Label ID="lblRemarks" runat="server" CssClass="fs-7 fw-bold pt-1" style="color: black;" />
                      </div>
              </div>


          </div>
              

                     </div>
                         
             </div>

             <div class="modal-footer">
                
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">Cancel</button>
             </div>
         </div>
     </div>
 </div>

    <div class="modal fade modal-center" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="Confm">Final Attachments
                 </h5>
             </div>
                                                             <div class="modal-body">

                 <span></span>
                 <div class="col-lg-12 row" style="padding-top: 10px;">
                            <div class="col-12" style="padding-left: 10px;">

<span class="min-w-50px fw-semibold text-gray-500 pt-5">Attached Images</span>

              <div class="fs-7 fw-bold pt-1" style="color: black;">

                   <div class="col-lg-12 ">
                     <asp:HiddenField ID="HiddenField1" runat="server" />
                       <asp:PlaceHolder ID="pnlImg1" runat="server">

                       </asp:PlaceHolder>
                   
                 </div>
                   <div class="mt-3">
                    <span class="min-w-50px fw-semibold text-gray-500 pt-5">Remarks : </span>

                        <asp:Label ID="FinalR" runat="server" CssClass="fs-7 fw-bold pt-1" style="color: black;" />
                      </div>
              </div>


          </div>
              

                     </div>
                         
             </div>

             <div class="modal-footer">
                
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_4);">Cancel</button>
             </div>
         </div>
     </div>
 </div>
</asp:Content>

