<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="PendingOrders.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.PendingOrders" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
     <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../assets/media/icons/excel.png" style="height: 50px; " ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />


          <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="../assets/media/icons/file.png" style=" height:40px; Width:33px;" ToolTip="Print"
              OnClick="ImageButton2_Click" AlternateText="pdf" Visible="false" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">


                   



                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        <div class="card-body" style="background-color:white; padding:20px;">
                              
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">                              
                                
                               
                                <!--begin::Form-->
                                <!--end: Search Form -->

                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
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
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Medium" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="ord_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" Visible="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Order No" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                            </telerik:GridBoundColumn>

                                          

                                            <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rotname" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rotname">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="130px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Codde">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cusname" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cusname">
                                            </telerik:GridBoundColumn>                                          


                                            <telerik:GridBoundColumn DataField="Exp.Delivery" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Exp Delivery Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Exp.Delivery" Display="false">
                                            </telerik:GridBoundColumn>

                                           
                                             <telerik:GridBoundColumn DataField="ord_SubTotal_WODiscount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Total" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_SubTotal_WODiscount" Display="false">
                                                 <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="ord_Discount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Discount" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_Discount" Display="false">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>
                                            
                                             <telerik:GridBoundColumn DataField="ord_SubTotal" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="SubTotal" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_SubTotal" Display="false">
                                                 <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="ord_VAT" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="VAT" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_VAT" Display="false">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="ord_GrandTotal" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Grand Total" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_GrandTotal">
                                                <ItemStyle HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="ord_PayMode" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_PayMode" Display="false">
                                            </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Void" Display="false">
                                            </telerik:GridBoundColumn>
                                           
                                           

                                             <telerik:GridBoundColumn DataField="ord_OrderRemarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ord_OrderRemarks" ItemStyle-HorizontalAlign="Left" Display="false">
                                            </telerik:GridBoundColumn>

                                            
                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="Signature" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false" Display="false">
                                                <ItemTemplate>

                                                    <asp:HyperLink ID="img1" runat="server" NavigateUrl=' <%#"../" +  Eval("ord_Signature") %>' Target="_blank">
                                                        <asp:Image ID="ord_Signature" runat="server" ImageUrl=' <%# "../" + Eval("ord_Signature") %>' Height="20px" Width="20px" />
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                             <telerik:GridTemplateColumn  AllowFiltering="false"
                                                HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Attachment"
                                                HeaderStyle-Font-Bold="true" Display="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="pp1" runat="server"
                                                        ImageUrl="../assets/media/svg/Files/File.svg" NavigateUrl='<%# "../" + Eval("ord_Attachment")%>' Height="20px" Width="20px" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>   
                                            
                                            <telerik:GridTemplateColumn  AllowFiltering="false"
                                                HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="LPO Attachment"
                                                HeaderStyle-Font-Bold="true" Display="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="pp" runat="server"
                                                        ImageUrl="../assets/media/svg/Files/File.svg" NavigateUrl='<%# "../" + Eval("ord_LPOAttachment")%>' Height="20px" Width="20px" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>   
                                             <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>
                                            
                                            <telerik:GridBoundColumn DataField="usrName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Created By" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usrName">
                                            </telerik:GridBoundColumn>
                                             
                                         
                                             <telerik:GridBoundColumn DataField="Stag_Int_Remarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Int. Remarks" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Stag_Int_Remarks">
                                            </telerik:GridBoundColumn>
                                           
                                                  <telerik:GridBoundColumn DataField="Stag_Int_Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Int. Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Stag_Int_Status">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="Stag_Int_Time" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Int. Time" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Stag_Int_Time" ItemStyle-HorizontalAlign="Left" Display="false">
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
                            </telerik:RadAjaxPanel>
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


</asp:Content>
