<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OrderOrQuatationCancel.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OrderOrQuatationCancel" %>
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
                            <telerik:DropDownListItem Text="Order" Value="O" Selected="true"/>
                            <telerik:DropDownListItem Text="Quotation" Value="Q" />

                        </Items>
                    </telerik:RadDropDownList>
                </div>
            </div>

             <asp:PlaceHolder ID="pnlord" runat="server" Visible="false">
            <div class="col-lg-3">
                <label class="control-label col-lg-12">Enter Order No:</label>
                <div class="col-lg-12">
                    <telerik:RadTextBox ID="txtordnum" runat="server" Width="100%" CssClass="form-control"></telerik:RadTextBox>                   
                </div>
            </div>
                 </asp:PlaceHolder>

             <asp:PlaceHolder ID="pnlquotation" runat="server" Visible="false">
            <div class="col-lg-3">
                <label class="control-label col-lg-12">Enter Quotation No:</label>
                <div class="col-lg-12">
                   <telerik:RadTextBox ID="txtquotanum" runat="server" Width="100%"  CssClass="form-control"></telerik:RadTextBox>                   
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
      ID="ordgrvRpt" GridLines="None"
      ShowFooter="True" AllowSorting="True"
      OnNeedDataSource="ordgrvRpt_NeedDataSource"
      OnItemCommand="ordgrvRpt_ItemCommand"
      OnItemDataBound="ordgrvRpt_ItemDataBound"
      AllowFilteringByColumn="true"
      ClientSettings-Resizing-ClipCellContentOnResize="true"
      EnableAjaxSkinRendering="true"
      AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
      <ClientSettings>
          <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
      </ClientSettings>
      <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Medium" CanRetrieveAllData="false"
          ShowFooter="false" DataKeyNames="ord_ID"
          EnableHeaderContextMenu="true">
          <Columns>


<%--              <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                  <ItemTemplate>
                      <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                          ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                  </ItemTemplate>
              </telerik:GridTemplateColumn>--%>

              <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="120px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="rotname">
              </telerik:GridBoundColumn>
              <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Order No" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="OrderID">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="150px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks" ItemStyle-HorizontalAlign="Left">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="Stag_Int_Status" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Integration Status" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="Stag_Int_Status">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                  HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="180px"
                  HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="cusname">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="rcs_cusType" AllowFiltering="true" HeaderStyle-Width="180px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Customer Type" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="rcs_cusType">
              </telerik:GridBoundColumn>
              <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
              </telerik:GridBoundColumn>



              <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Exp Delivery Date" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="usrName" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Created By" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="usrName">
              </telerik:GridBoundColumn>



              <telerik:GridBoundColumn DataField="ord_SubTotal_WODiscount" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText=" Total" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_SubTotal_WODiscount">
                  <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="ord_Discount" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Discount" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_Discount">
                  <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="ord_SubTotal" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="SubTotal" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_SubTotal">
                  <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
              </telerik:GridBoundColumn>


              <telerik:GridBoundColumn DataField="ord_VAT" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="VAT" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_VAT">
                  <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
              </telerik:GridBoundColumn>


              <telerik:GridBoundColumn DataField="ord_GrandTotal" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Grand Total" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_GrandTotal">
                  <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="ord_PayMode" AllowFiltering="true" HeaderStyle-Width="80px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_PayMode">
              </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="100px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="Void">
              </telerik:GridBoundColumn>




              <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="Signature" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                  <ItemTemplate>

                      <asp:HyperLink ID="img1" runat="server" NavigateUrl=' <%#"../" +  Eval("ord_Signature") %>' Target="_blank">
                          <asp:Image ID="ord_Signature" runat="server" ImageUrl=' <%# "../" + Eval("ord_Signature") %>' Height="20px" Width="20px" />
                      </asp:HyperLink>
                  </ItemTemplate>
              </telerik:GridTemplateColumn>

              <telerik:GridTemplateColumn AllowFiltering="false"
                  HeaderStyle-Width="80px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Attachment"
                  HeaderStyle-Font-Bold="true">
                  <ItemTemplate>
                      <asp:HyperLink ID="pp1" runat="server" NavigateUrl='<%# "../" + Eval("ord_Attachment")%>' Target="_blank">
                          <asp:Image ID="ordAttachment" runat="server" ImageUrl="../assets/media/svg/Files/File.svg" Height="25px" Width="25px" />
                      </asp:HyperLink>
                  </ItemTemplate>
              </telerik:GridTemplateColumn>


              <telerik:GridBoundColumn DataField="ord_LPO_Number" AllowFiltering="true" HeaderStyle-Width="200px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="LPO" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="ord_LPO_Number">
              </telerik:GridBoundColumn>

              <telerik:GridTemplateColumn AllowFiltering="false"
                  HeaderStyle-Width="80px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="LPO Attachment"
                  HeaderStyle-Font-Bold="true">
                  <ItemTemplate>
                      <asp:HyperLink ID="pp" runat="server" NavigateUrl='<%# "../" + Eval("ord_LPOAttachment")%>' Target="_blank">
                          <asp:Image ID="ord_LPOAttachment" runat="server" ImageUrl="../assets/media/svg/Files/File.svg" Height="25px" Width="25px" />
                      </asp:HyperLink>
                  </ItemTemplate>
              </telerik:GridTemplateColumn>



              <telerik:GridBoundColumn DataField="Stag_Int_Remarks" AllowFiltering="true" HeaderStyle-Width="200px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Integration Remarks" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="Stag_Int_Remarks">
              </telerik:GridBoundColumn>


              <telerik:GridBoundColumn DataField="Stag_Int_Time" AllowFiltering="true" HeaderStyle-Width="120px"
                  HeaderStyle-Font-Size="Smaller" HeaderText="Integration Time" FilterControlWidth="100%"
                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                  HeaderStyle-Font-Bold="true" UniqueName="Stag_Int_Time" ItemStyle-HorizontalAlign="Left">
              </telerik:GridBoundColumn>
               <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="120px"
     HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
     HeaderStyle-Font-Bold="true" UniqueName="Status" Display="false">
 </telerik:GridBoundColumn>

                  <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="Do void" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="DoVoidOrd">
    <ItemTemplate>
        <asp:LinkButton ID="DoVoidOrd" CommandName="DoVoidOrd" runat="server" Text="Cancel"
            CssClass="btn btn-sm btn-light-danger me-2 border-1" />
    </ItemTemplate>
</telerik:GridTemplateColumn>


          </Columns>
      </MasterTableView>
      <PagerStyle AlwaysVisible="true" />
      <GroupingSettings CaseSensitive="false" />
      <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
          <Resizing AllowColumnResize="true"></Resizing>
          <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
      </ClientSettings>
  </telerik:RadGrid>

<asp:HiddenField ID="hfordID" runat="server" />
<asp:HiddenField ID="hfordNumber" runat="server" />

       <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
     ID="QuotationgrvRpt" GridLines="None"
     ShowFooter="True" AllowSorting="True"
     OnNeedDataSource="QuotationgrvRpt_NeedDataSource"
     OnItemCommand="QuotationgrvRpt_ItemCommand"
     OnItemDataBound="QuotationgrvRpt_ItemDataBound"
     AllowFilteringByColumn="true"
     ClientSettings-Resizing-ClipCellContentOnResize="true"
     EnableAjaxSkinRendering="true"
     AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
     <ClientSettings>
         <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
     </ClientSettings>
     <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Medium" CanRetrieveAllData="false"
         ShowFooter="false" DataKeyNames="ord_ID"
         EnableHeaderContextMenu="true">
         <Columns>


             <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                 <ItemTemplate>
                     <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                         ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                 </ItemTemplate>
             </telerik:GridTemplateColumn>

             <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="rotname">
             </telerik:GridBoundColumn>                                          

             <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                 HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="180px"
                 HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="cusname">
             </telerik:GridBoundColumn>

               <telerik:GridBoundColumn DataField="usrName" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Created By" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="usrName">
             </telerik:GridBoundColumn>

               <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Order No" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="OrderID">
             </telerik:GridBoundColumn>                                   
                                                    

             <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Exp Delivery Date" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery">
             </telerik:GridBoundColumn>

            
              <telerik:GridBoundColumn DataField="ord_SubTotal_WODiscount" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText=" Total" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ord_SubTotal_WODiscount">
                  <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>


             <telerik:GridBoundColumn DataField="ord_Discount" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Discount" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ord_Discount">
                 <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>
             
              <telerik:GridBoundColumn DataField="ord_SubTotal" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="SubTotal" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ord_SubTotal">
                  <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>


             <telerik:GridBoundColumn DataField="ord_VAT" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="VAT" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ord_VAT">
                 <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>


             <telerik:GridBoundColumn DataField="ord_GrandTotal" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Grand Total" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ord_GrandTotal">
                 <ItemStyle HorizontalAlign="Right" />
                  <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="ord_PayMode" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ord_PayMode">                                               
             </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="50px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Void" ItemStyle-HorizontalAlign="Left">
             </telerik:GridBoundColumn>                                          
            

              <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks" ItemStyle-HorizontalAlign="Left">
             </telerik:GridBoundColumn>

                           <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="120px"
    HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
    HeaderStyle-Font-Bold="true" UniqueName="Status" Display="false">
</telerik:GridBoundColumn>
                 <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="Do void" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="DoVoidQuota">
    <ItemTemplate>
        <asp:LinkButton ID="DoVoidQuota" CommandName="DoVoidQuota" runat="server" Text="Cancel"
            CssClass="btn btn-sm btn-light-danger me-2 border-1" />
    </ItemTemplate>
</telerik:GridTemplateColumn>


         </Columns>
     </MasterTableView>
     <PagerStyle AlwaysVisible="true" />
     <GroupingSettings CaseSensitive="false" />
     <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
         <Resizing AllowColumnResize="true"></Resizing>
         <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
     </ClientSettings>
 </telerik:RadGrid>

<asp:HiddenField ID="hfquoID" runat="server" />
<asp:HiddenField ID="hfquoNum" runat="server" />


         
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
                        <asp:LinkButton ID="OrdNoteOK" runat="server" OnClick="OrdNoteOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
                        <asp:LinkButton ID="QuotattionNoteOk" runat="server" OnClick="QuotattionNoteOk_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
