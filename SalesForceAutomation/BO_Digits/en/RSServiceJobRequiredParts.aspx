<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RSServiceJobRequiredParts.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RSServiceJobRequiredParts" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    
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
                                                 <div class="kt-portlet__body pb-0">

                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="True" BackColor="#F2F6F9">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid">
                                                <table>
                                                    <td style="padding:5px;">
                                                        <div class="col-lg-6 mb-2 ms-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Service Job ID:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblJobID" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                    
                                                           <div class="col-lg-6 mb-2 ms-4">
                                                           <label class="col-lg-2 col-form-label" style="display: contents;">Remarks:</label>
                                                           <label class="col-lg-4 col-form-label" style="display: contents;">
                                                               <asp:Label ID="lblRemarks" Font-Bold="true" runat="server"></asp:Label></label>
                                                       </div>

                                                    </td>
                                                    <td>

                                                        <div class="col-lg-6 mb-2 ms-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;"> Service Request ID:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblReqID" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>

                                                        
                                                    </td>

                                                    
                                                </table>


                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </div>

                        <div class="kt-portlet__body">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                               
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="60" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="srp_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                         
                                         <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                         </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                                 HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                 HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                             </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="srp_UOM" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="UOM" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="srp_UOM">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="srp_Qty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Quantity" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="srp_Qty"><ItemStyle HorizontalAlign="Right" /><HeaderStyle HorizontalAlign="Right" />
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
            </div>
        </div>
    </div>
    </div>

     <!--begin::QuestionModal-->
    <!--end::QuestionModal-->
</asp:Content>

