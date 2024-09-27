<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="DailyActivityDetails.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.DailyActivityDetails" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   

    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <div class="kt-portlet__head" style="border-bottom-style: ridge; border-bottom-width: thin;">

                            <div class="kt-portlet__head-actions col-lg-12 row">
                                <div class="col-lg-12 row" style="font-size: 15px; margin-bottom: 20px;">
                                    <div class="col-lg-4 " style="padding-left: 25px;">

                                        

                                        <asp:Label ID="lblCustomer" runat="server" Style="font-weight: 600; padding-top: 5px;"></asp:Label>

                                    </div>
                                



                                </div>

                            </div>
                        </div>
                        <%-- <telerik:RadAjaxLoadingPanel ID="radpanl1" runat="server" LoadingPanelID="RadAjaxLoadingPanel3"> --%>
                        <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                            <Items>
                                <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="">
                                    <ContentTemplate>

                                        <div class="col-lg-12 row mb-4 py-4 " style="border-bottom-style: ridge; border-bottom-width: thin;">

                                            <div class="col-sm-4">
                                                <span class="svg-icon svg-icon-2">
                                                   
                                                    <img src="../assets/media/svg/general/route.svg" />
                                                </span>
                                                <%--<img src="../assets/media/UDP/User.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>

                                            <div class="col-sm-4">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                            <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                            <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                            <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                        </g>
                                                    </svg>

                                                </span>
                                                <%--  <img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">Start Time:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>

                                           
                                            <div class="col-sm-4">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                            <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                            <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                            <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                        </g>
                                                    </svg>

                                                </span>
                                                <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">End Time:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>
                                        </div>


                                    </ContentTemplate>
                                </telerik:RadPanelItem>
                            </Items>
                        </telerik:RadPanelBar>
                        <%-- </telerik:RadAjaxLoadingPanel>
                        --%>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>

                        <div class="kt-portlet__body">
                            <div class="col-lg-12 row">

                                <div class="demo-container size-medium">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                        <telerik:RadWizard RenderMode="Lightweight" ID="RadWizard1" runat="server" Height="500px" >
                                           
                                            <WizardSteps>
                                                <telerik:RadWizardStep Title="Cash Invoices">
                                                    <div class="kt-portlet">
                                                       
                                                      
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="CashInvoiceGrid" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="CashInvoiceGrid_NeedDataSource"
                                                                 OnItemCommand="CashInvoiceGrid_ItemCommand"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="sal_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                         <telerik:GridTemplateColumn HeaderStyle-Width="5px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                             <ItemTemplate>
                                                                                 <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                                                     ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                                             </ItemTemplate>
                                                                         </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Number" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
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
                                                    </div>
                                                </telerik:RadWizardStep>
                                                        <telerik:RadWizardStep Title="Credit Invoices">
                                                    <div class="kt-portlet">
                                                       
                                                      
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="CreditInvoiceGrid" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="CreditInvoiceGrid_NeedDataSource"
                                                                OnItemCommand="CreditInvoiceGrid_ItemCommand"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="sal_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                         <telerik:GridTemplateColumn HeaderStyle-Width="5px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                             <ItemTemplate>
                                                                                 <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                                                     ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                                             </ItemTemplate>
                                                                         </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Number" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
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
                                                    </div>
                                                </telerik:RadWizardStep>

                                                                                              <telerik:RadWizardStep Title="Cash Returns">
                                                    <div class="kt-portlet">
                                                       
                                                      
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="CashReturnGrid" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="CashReturnGrid_NeedDataSource"
                                                                 OnItemCommand="CashReturnGrid_ItemCommand"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="sal_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                         <telerik:GridTemplateColumn HeaderStyle-Width="5px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                             <ItemTemplate>
                                                                                 <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                                                     ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                                             </ItemTemplate>
                                                                         </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Number" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
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
                                                    </div>
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="Credit Returns">
                                                    <div class="kt-portlet">
                                                       
                                                      
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="CreditReturnGrid" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="CreditReturnGrid_NeedDataSource"
                                                                OnItemCommand="CreditReturnGrid_ItemCommand"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="sal_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                         <telerik:GridTemplateColumn HeaderStyle-Width="5px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                             <ItemTemplate>
                                                                                 <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                                                     ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                                             </ItemTemplate>
                                                                         </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Number" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
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
                                                    </div>
                                                </telerik:RadWizardStep>
                                                                                                <telerik:RadWizardStep Title="Cash Collections">
                                                    <div class="kt-portlet">
                                                       
                                                      
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="CashCollectionGrid" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="CashCollectionGrid_NeedDataSource"
                                                                 OnItemCommand="CashCollectionGrid_ItemCommand"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="sal_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                         <telerik:GridTemplateColumn HeaderStyle-Width="5px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                             <ItemTemplate>
                                                                                 <asp:ImageButton CommandName="Detail" ID="RadImageButton2" CommandArgument='<%# Eval("arp_Type")%>' Visible="true" AlternateText="Detail" runat="server"
                                                                                     ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                                             </ItemTemplate>
                                                                         </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="AR Number" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Collected Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
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
                                                    </div>
                                                </telerik:RadWizardStep>

                                                                                                <telerik:RadWizardStep Title="Cheque/Online Collections">
                                                    <div class="kt-portlet">
                                                       
                                                      
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="ChequeCollectionGrid" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="ChequeCollectionGrid_NeedDataSource"
                                                                OnItemCommand="ChequeCollectionGrid_ItemCommand"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="sal_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                         <telerik:GridTemplateColumn HeaderStyle-Width="5px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                                             <ItemTemplate>
                                                                                 <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" CommandArgument='<%# Eval("arp_Type")%>' AlternateText="Detail" runat="server"
                                                                                     ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                                             </ItemTemplate>
                                                                         </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="AR Number" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Collected Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
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
                                                    </div>
                                                </telerik:RadWizardStep>

                                            </WizardSteps>
                                        </telerik:RadWizard>
                                    </telerik:RadAjaxPanel>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

   
</asp:Content>

