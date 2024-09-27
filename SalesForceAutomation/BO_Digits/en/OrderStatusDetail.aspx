<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OrderStatusDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OrderStatusDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
      <div class="card-body p-8" style="background-color:white;"> 

       <div class="kt-portlet__body pb-4">

                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid">
                                                <table>
                                                    <td >
                                                        <div class="col-lg-6 my-4 ms-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                         </td>
                                                    <td>
                                                        <div class="col-lg-12 my-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Customer:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblCustomer" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                       </td>
                                                    <td>

                                                        <div class="col-lg-12 my-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Date:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                         
                                                        

                                                    </td>
                                                   
                                                </table>


                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </div>

        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">
                         <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
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
                                ShowFooter="false" DataKeyNames="odd_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>

                                   
                                   <telerik:GridBoundColumn DataField="odd_TransType" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Transaction Type" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="odd_TransType">
                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="110px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Product" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="odd_HigherUOM" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherUOM">
                                                    </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="odd_HigherQty" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherQty">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="odd_HigherPrice" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher Price"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_HigherPrice">
                                                          <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>


                                                    <telerik:GridBoundColumn DataField="odd_LowerUOM" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerUOM">
                                                    </telerik:GridBoundColumn>

                                                    

                                                    <telerik:GridBoundColumn DataField="odd_LowerQty" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerQty">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                  
                                                    <telerik:GridBoundColumn DataField="odd_LowerPrice" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower Price"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_LowerPrice">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>



                                                    <telerik:GridBoundColumn DataField="odd_Price" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Price">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_Discount" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Discount"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_Discount">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_SubTotal" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Sub Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_SubTotal">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_VATAmount" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="VAT"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_VATAmount">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="odd_GrandTotal" AllowFiltering="true" HeaderStyle-Width="90px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Line Total"
                                                        HeaderStyle-Font-Bold="true" UniqueName="odd_GrandTotal">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </telerik:GridBoundColumn>
                                                 
                                     
                                   
                                   

                                      </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
