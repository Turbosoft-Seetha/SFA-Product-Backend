<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ServiceJobTransactions.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ServiceJobTransactions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <div class="card-body" style="background-color:white; padding:20px;">
 <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
    <div class="row">
        <div class="col-lg-12">
            <!--begin::Portlet-->
            <div class="kt-portlet">                
                      
                            <div class="col-sm-6" style="margin-bottom:10px;">
                             <h6 class="kt-portlet__head-title">Customer Operation- <asp:Label ID="lblType" runat="server" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </h6>
                             </div>
                           
                 
               

                <!--begin::Form-->
                <div class="kt-form kt-form--label-right">
                    <div class="kt-portlet__body pb-0" style="border-bottom-style:inset;border-bottom-width:thin; padding-top:10px; margin-bottom:10px;">


                         <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                            <Items>
                                <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">
                                    <ContentTemplate>
                                        <div class="kt-portlet__body" style= "display: grid;">
                                            <table>
                                                <td style="width: 56%; padding-left:40px;">
                                                  <div class="col-lg-12 mb-2 row">
                                                    <div class="col-lg-4">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Version:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblVersion" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                      <%-- <div class="col-lg-3">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Date:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblCreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>--%>
                                                   </div>
                                                </td>
                                               <%-- <td>
                                                    <div class="col-lg-12 mb-2">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">Start Time:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    <div class="col-lg-12 mb-2">
                                                        <label class="col-lg-2 col-form-label" style="display: contents;">End Time:</label>
                                                        <label class="col-lg-4 col-form-label" style="display: contents;">
                                                            <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                    </div>
                                                    
                                                </td>--%>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </telerik:RadPanelItem>
                            </Items>
                        </telerik:RadPanelBar>
                    
                      
                     </div>

                        
                        <!-- ---------------------------- -->
                       

                        <!-- ---------------------------- -->




                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <div class="kt-portlet__body">
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                              <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
     ID="grvRpt" GridLines="None"
     AllowSorting="True"
     OnNeedDataSource="grvRpt_NeedDataSource"
     AllowFilteringByColumn="true"
     ClientSettings-Resizing-ClipCellContentOnResize="true"
     EnableAjaxSkinRendering="true"
     AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
     <ClientSettings>
         <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
     </ClientSettings>
     <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
         ShowFooter="false" DataKeyNames="sjh_ID"
         EnableHeaderContextMenu="true">
         <Columns>




             <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Job ID" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
             </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="snr_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Request ID" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="snr_Code">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="snr_rot_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="snr_rot_ID">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="Customer" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Customer">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Date" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="Route" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Route" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Route">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="ScheduledDate">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Status">
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
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>

                    </telerik:RadAjaxLoadingPanel>
                </div>

                <div class="kt-form kt-form--label-right">
                    <div class="kt-portlet__body pb-0">

                        <div class="col-lg-12 row" style="padding-bottom: 30px;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
