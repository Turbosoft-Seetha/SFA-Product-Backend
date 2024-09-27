<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteNotificationDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteNotificationDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
      <div class="card-body p-8" style="background-color:white;"> 
    
           <div class="kt-form kt-form--label-right">
     <div class="card-body" style="background-color:white; padding-bottom:10px;">
           


         <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
             <Items>
                 <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="white">

                     <ContentTemplate>
                         <div class="kt-portlet__body" style="background-color: white; display: grid;padding-left:20px;">
                            <table>
                                 <td>                                    
                                      <div class="col-lg-12 mb-2 mt-3">
                                         <label class="col-lg-2 col-form-label" style="display: contents;">Mode:</label>
                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                             <asp:Label ID="Mode" Font-Bold="true" runat="server"></asp:Label></label>
                                      </div>
                                 </td>
                                 <td >
                                     <asp:PlaceHolder ID="pnlUser" runat="server">
                                     <div class="col-lg-12 mb-2 mt-3">
                                         <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                             <asp:Label ID="User" Font-Bold="true" runat="server"></asp:Label></label>
                                     </div> 
                                         </asp:PlaceHolder>
                                 </td>
                                 <td>
                                    <div class="col-lg-12 mb-2 mt-3">
                                         <label class="col-lg-2 col-form-label" style="display: contents;">Created Date:</label>
                                         <label class="col-lg-4 col-form-label" style="display: contents;">
                                             <asp:Label ID="CreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
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


                          <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                          <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                              ID="grvRpt" GridLines="None"
                              ShowFooter="True" AllowSorting="True"
                              OnNeedDataSource="grvRpt_NeedDataSource"                           
                              AllowFilteringByColumn="true"
                              ClientSettings-Resizing-ClipCellContentOnResize="true"
                              EnableAjaxSkinRendering="true"
                              AllowPaging="true" PageSize="50" CellSpacing="0">
                              <ClientSettings>
                                  <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
                              </ClientSettings>
                              <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                  ShowFooter="false" DataKeyNames="rnd_ID"
                                  EnableHeaderContextMenu="true">
                                  <Columns>
                                     
                                       <telerik:GridBoundColumn DataField="ord_ERP_OrderNo" AllowFiltering="true" HeaderStyle-Width="150px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="ERP OrderNo" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="ord_ERP_OrderNo" Display="false">
                                      </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                      </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Product Name" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                      </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="prd_Desc" AllowFiltering="true" HeaderStyle-Width="250px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Product Description" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="prd_Desc">
                                      </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="CreatedDate" Display="false">
                                      </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="rnd_UOM" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="UOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rnd_UOM">
                                        </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="rnd_OrdQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="System Qty" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="rnd_OrdQty">
                                      </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="rnd_AdjQty" AllowFiltering="true" HeaderStyle-Width="150px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Adjusted Qty" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="rnd_AdjQty">
                                      </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rnd_PickedQty" AllowFiltering="true" HeaderStyle-Width="150px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Final Qty" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="rnd_PickedQty" >
                                      </telerik:GridBoundColumn>

                                       <telerik:GridBoundColumn DataField="rsn_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                          HeaderStyle-Font-Size="Smaller" HeaderText="Reason" FilterControlWidth="100%"
                                          CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                          HeaderStyle-Font-Bold="true" UniqueName="rsn_Name" Display="false">
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
