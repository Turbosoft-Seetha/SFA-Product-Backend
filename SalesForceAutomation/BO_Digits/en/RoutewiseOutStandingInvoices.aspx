<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RoutewiseOutStandingInvoices.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RoutewiseOutStandingInvoices" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
        <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" style="height: 50px; " ToolTip="Download" 
                                OnClick="imgExcel_Click" AlternateText="Xlsx" />
                            <%--<asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" style=" height:40px; Width:33px;" ToolTip="Print"
                                OnClick="btnPDF_Click" AlternateText="pdf" />--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   


                   <%-- <div class="kt-portlet__head" style="padding-top: 8px; padding-bottom: 8px;">
                       

                     
                    </div>--%>



                    <!--begin::Form-->


                    <!--end: Search Form -->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                        <div class="card-body" style="background-color:white; padding:20px;">
                               
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">                               

                                 <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                        <asp:PlaceHolder ID="plhFilter" runat="server">
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Region</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddlregion" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2" style="margin-left: 32px;">
                                                <label class="control-label col-lg-12">Depot</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                        RenderMode="Lightweight"
                                                        ID="ddldepot" runat="server" EmptyMessage="Select Depot"
                                                        OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2" style="margin-left: 32px;">
                                                <label class="control-label col-lg-12">Area</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddldpoArea" runat="server" EmptyMessage="Select Area"
                                                        OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2" style="margin-left: 32px;">
                                                <label class="control-label col-lg-12">Subarea</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                        </asp:PlaceHolder>                                      


                                    </div>
                                     <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                           <div class="col-lg-2" style="margin-left: 4px;">
                                            <label class="control-label col-lg-12">Route</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                    ID="rdRoute" runat="server" EmptyMessage="Select Route" AutoPostBack="true" Width="100%">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>
                                             <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; margin-left: 17px;">
                                            <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                                                    Apply Filter
                                            </asp:LinkButton>
                                        </div>
                                        <div class="col-lg-2" style="text-align: center; padding-top: 15px; margin-left: 15px;">
                                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" Visible="false">
                                                    Advanced Filter
                                            </asp:LinkButton>
                                        </div>
                                         </div>
                                <%--</telerik:RadAjaxPanel>--%>



                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                     OnItemDataBound="grvRpt_ItemDataBound"
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Medium" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="oid_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" Display="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Route" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                            </telerik:GridBoundColumn>                                         
                                          

                                            <telerik:GridBoundColumn DataField="Date" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Date">
                                            </telerik:GridBoundColumn>

                                            
                                            <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Grand Total" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                            </telerik:GridBoundColumn>
                                            
                                                <telerik:GridBoundColumn DataField="InvoiceBalance" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Balance" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="InvoiceBalance">
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
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
