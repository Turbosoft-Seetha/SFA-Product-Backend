<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SalesDetails.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SalesDetails" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
      <script type="text/javascript">

          function EmailModal(a) {

              $('#kt_modal_1_4').modal('show');
              $('#msg').text(a);
          }

          function DateModal() {
              $('#kt_modal_1_1').modal('show');
          }

          function Success() {
              $('#modelemplty').modal('show');
              $('#msg1').text('Stamped copy not attached');
          }

          function showAR() {
              $('#ARCollections').modal('show');
          }
      </script>

</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">


   
     <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50"  ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />
  <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="33" ToolTip="PDF" OnClick="btnPDF_Click" AlternateText="pdf" />
               <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                   

      <asp:ImageButton ID="BtnEmail" runat="server" ImageUrl="../assets/media/icons/mail.png" Style="height: 35px; width: 34px;" ToolTip="Email" OnClick="BtnEmail_Click" AlternateText="Email" />
             
                     <asp:ImageButton ID="BtnAttachment" runat="server" ImageUrl="../assets/media/icons/attach.png" Style="height: 35px; width: 34px" ToolTip="Stamped Copy"
  OnClick="BtnAttachment_Click" AlternateText="Stamp Copy" />
                    <asp:Button ID="btnAR" runat="server" Text="AR Collections" OnClick="btnAR_Click" CssClass="btn btn-sm btn-secondary"  />
 
                  
            </telerik:RadAjaxPanel>

      <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>


    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div class="card-body" style="background-color:white; padding:20px;">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   


                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                      <div class="card-body" style="background-color:white; padding-bottom:10px;">
                               <div class="kt-portlet__head-actions" style="text-align-last: end;">

                          
                        </div>

                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="white">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color:white; display: grid;padding:20px;">
                                                <table>
                                                    <td style="width: 56%">
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-6 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblCustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>

                                                        <div class="col-lg-6 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Created Date:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblCreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Created By:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblCreatedBy" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>

                                                    </td>
                                                    <td>
                                                          <div class="col-lg-6 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Total:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblTotal" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>

                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Discount:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblDis" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-6 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">SubTotal:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblSub" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>

                                                        <div class="col-lg-6 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">VAT:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblvat" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Grand Total:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblGrand" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>

                                                    </td>
                                                </table>

                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </div>
                        <!--end: Search Form -->
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-portlet__body">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                     OnItemDataBound="grvRpt_ItemDataBound"
                                    OnPreRender="grvRpt_PreRender"
              
                                    AllowFilteringByColumn="false"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="sld_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Batch/Serial" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Batch" ID="Batch" Visible="true" AlternateText="Item" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridBoundColumn DataField="sld_TransType" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_TransType">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="false" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Code"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="false" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Product Name"
                                                HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="sld_HigherUOM" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_HigherUOM">
                                            </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="sld_HigherQty" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_HigherQty">
                                                 <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="sld_HigherPrice" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Higher Price"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_HigherPrice">
                                                 <ItemStyle HorizontalAlign="Right" />
                                                   <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="sld_LowerUOM" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_LowerUOM">
                                            </telerik:GridBoundColumn>
                                           
                                            <telerik:GridBoundColumn DataField="sld_LowerQty" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_LowerQty">
                                                <ItemStyle HorizontalAlign="Right" />
                                                  <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>
                                           
                                            <telerik:GridBoundColumn DataField="sld_LowerPrice" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Lower Price"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_LowerPrice">
                                                <ItemStyle HorizontalAlign="Right" />
                                                  <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="sld_LineTotal" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Total"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_LineTotal">
                                                <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sld_Discount" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Discount"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_Discount">
                                                <ItemStyle HorizontalAlign="Right" />
                                                 <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="ind_SubTotal_WDiscount" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="SubTotal" 
                                                HeaderStyle-Font-Bold="true" UniqueName="ind_SubTotal_WDiscount">
                                                 <ItemStyle HorizontalAlign="Right" />
                                                  <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="sld_LineVAT" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="VAT"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_LineVAT">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="sld_GrandTotal" AllowFiltering="false" HeaderStyle-Width="50px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Line Total"
                                                HeaderStyle-Font-Bold="true" UniqueName="sld_GrandTotal">
                                                 <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>


                                              <telerik:GridBoundColumn DataField="sld_ReturnType" AllowFiltering="false" HeaderStyle-Width="50px"
                                                  HeaderStyle-Font-Size="Smaller" HeaderText="Return Type"
                                                  HeaderStyle-Font-Bold="true" UniqueName="sld_ReturnType">
                                              </telerik:GridBoundColumn>

                                              <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="Return Image" UniqueName="RepImages" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                              <ItemTemplate>

                                                  <asp:HyperLink ID="img2" runat="server" NavigateUrl=' <%#"../"+  Eval("sld_rtnImg") %>' Target="_blank">
                                                      <asp:Image ID="RtnImage" runat="server" ImageUrl=' <%# "../"+ Eval("sld_rtnImg") %>' Height="20px" Width="20px" />
                                                  </asp:HyperLink>
                                              </ItemTemplate>
                                          </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="sld_RtnSale_ID" AllowFiltering="false" HeaderStyle-Width="50px"
                                                  HeaderStyle-Font-Size="Smaller" HeaderText="Return Invoice ID"
                                                  HeaderStyle-Font-Bold="true" UniqueName="sld_RtnSale_ID">
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


    <div class="modal fade" id="kt_modal_1_1" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Email ID</h5>
                </div>
                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-7 form-group">
                            <label class="control-label col-lg-12">Already Saved Email ID :</label>
                            <div class="col-lg-12 pt-3">
                                <asp:Label RenderMode="Lightweight" ID="lblEmailId" Font-Bold="true" runat="server" Width="100%" CausesValidation="false">
                                </asp:Label><br />
                                <br />
                            </div>
                        </div>
                      <%--  <div class="col-lg-5 form-group">
                            <label class="control-label col-lg-12">Documents<span class="required"></span></label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox RenderMode="Lightweight" ID="ddlDocuments" runat="server" Filter="Contains" DefaultMessage="Select" EmptyMessage="Select" Width="100%" CausesValidation="false">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="Invoice Only" Value="I" />
                                        <%--  <telerik:RadComboBoxItem Text="Related Delivery Note Only" Value="D" />--%>
                                       <%-- <telerik:RadComboBoxItem Text="Invoice and Delivery Note" Value="B" />
                                    </Items>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidato" runat="server" ValidationGroup="form"
                                    ControlToValidate="ddlDocuments" ErrorMessage="Please Select any Document" ForeColor="Red"
                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                            </div>
                        </div>--%>
                    </div>
                    <div class="col-lg-12 form-group">
                        <label class="control-label col-lg-12">Enter Email ID that you want to add   </label>
                        <div class="col-lg-12 mt-5">

                         <telerik:RadTextBox RenderMode="Lightweight" CssClass="form-control" ID="txtEmail" TextMode="MultiLine" runat="server" Width="100%" CausesValidation="false" Placeholder="Enter email id"></telerik:RadTextBox>

                            <br />
                            <br />
                           
                            <telerik:RadLabel RenderMode="Lightweight" ID="lblNote" runat="server" Font-Size="Small" ForeColor="Blue" Text="Note: Use ' ; ' to separate email addresses when entering multiple ones." Width="100%" CausesValidation="false">
                            </telerik:RadLabel>
                           
                          


                        </div>
                    </div>
                    <div class="col-lg-12 form-group">
                        <div class="col-lg-12">
                            <asp:Label RenderMode="Lightweight" ID="lblMessage" Font-Bold="true" runat="server" Font-Size="Medium" Width="100%">
                            </asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                         <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_1);">Dismiss</button>

                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel9">
                        <asp:LinkButton runat="server" ID="btnEmailSave" CssClass="btn btn-sm fw-bold btn-primary" OnClick="btnEmailSave_Click" ValidationGroup="form" CausesValidation="true">Send</asp:LinkButton>

                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
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

    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops...</h5>
                </div>
                <div class="modal-body">
                    <span id="msg"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_4);">Ok</button>
                </div>
            </div>
        </div>
    </div>


     <div class="modal fade" id="modelemplty" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops...</h5>
                </div>
                <div class="modal-body">
                    <span id="msg1"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modelemplty);">Ok</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ARCollections"  style="height:auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 600px">
                <div class="modal-header">
                    <h5 class="modal-title">AR Collections</h5>
                </div>
                <div class="modal-body">
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-12 form-group">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                            
                            <div class="col-lg-12 pt-3">

                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                    ID="RadGridSuccess" GridLines="None"
                                    AllowSorting="True"
                                    OnNeedDataSource="RadGridSuccess_NeedDataSource"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="200px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridBoundColumn DataField="ARNumber" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AR Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ARNumber">
                                            </telerik:GridBoundColumn>

                                               <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="collectedAmt" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Collected Amount" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="collectedAmt">
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
                             <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                 BackColor="Transparent"
                                 ForeColor="Blue">
                                 <div class="col-lg-12 text-center mt-5">
                                     <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                 </div>
                             </telerik:RadAjaxLoadingPanel>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
    <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
        <div style="display: flex; justify-content: left; align-items: flex-start; width: 100%;">
            <div>
                <span style="font-weight: bold;" text-align: left;>Total Invoice Amount:</span>
                <asp:Label ID="lblTotalInvoiceAmount" runat="server" Text="" Style="font-weight: bold;"></asp:Label>
            </div>
            <div style="margin-left: auto;"> 
                <span style="font-weight: bold; margin-left: 20px;" text-align: left;>Balance:</span>
                <asp:Label ID="lblBalanceAmount" runat="server" Text="" Style="font-weight: bold;"></asp:Label>
            </div>
        </div>
    </telerik:RadAjaxPanel>

    <div style="margin-top: 10px; text-align: right;">
        <button class="btn btn-secondary" onclick="cancelModal(ARCollections);">OK</button>
    </div>

    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
        BackColor="Transparent" ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</div>


            </div>

        </div>
    </div>
</asp:Content>
