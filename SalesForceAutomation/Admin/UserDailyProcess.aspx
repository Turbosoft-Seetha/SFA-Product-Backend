<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="UserDailyProcess.aspx.cs" Inherits="SalesForceAutomation.Admin.UserDailyProcess" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">



                    <div class="kt-portlet__head" style="padding-top: 8px; padding-bottom: 8px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Route wise Detail
                            </h3>

                            <a href="UserDailyProcess.aspx" class="kt-subheader__breadcrumbs" style="padding-left: 10px;">
                                <i class="flaticon2-shelter" style="padding-right: 10px;"></i>Route wise Detail</a>
                            <span class="kt-subheader__breadcrumbs-separator"></span>

                        </div>

                        <%-- <div class="kt-portlet__head-actions">

                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Style="height: 60px; padding-top: 10px; padding-left: 20px;" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />


                            <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="assets/media/icons/file.png" Style="height: 40px; width: 50px; padding-left: 20px;" ToolTip="Print"
                                OnClick="btnPDF_Click" AlternateText="pdf" />
                        </div>--%>
                    </div>


                    <!--end: Search Form -->

                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <div class="col-lg-12 row" style="padding-bottom: 30px;">
                             <div class="col-lg-3" style="padding-top: 8px;">
                                <div class="col-lg-12">
                                    <label class="control-label col-lg-12 pl-0">Route </label>
                                </div>
                                <div class="col-lg-12">
                                      <telerik:RadComboBox ID="ddlEmployee" runat="server"  OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" Filter="Contains"
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route" Width="100%">
                                        </telerik:RadComboBox>
                                </div>
                            </div>
                            <div class="col-lg-3 ">
                                <label class="control-label col-lg-6">From Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="fromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="fromDate"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-3 ">
                                <label class="control-label col-lg-6">To Date</label>
                                <div class="col-lg-12">
                                    <telerik:RadDatePicker RenderMode="Lightweight" ID="toDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                    </telerik:RadDatePicker>
                                    <asp:CompareValidator ID="dd" runat="server" ControlToValidate="toDate" ControlToCompare="fromDate" ErrorMessage="End date must be greater"
                                        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="toDate"></asp:RequiredFieldValidator>
                                </div>
                            </div>


                           <%-- <div class="col-lg-2" style="text-align: center; top: 25px;">
                                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" OnClick="lnkFilter_Click" AutoPostBack="true" Text="Filter"></asp:LinkButton>
                            </div>--%>
                             <div class="col-lg-2" style="top: 10px; text-align: center;">
                                        <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="false" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                        </asp:LinkButton>
                                    </div>
                        </div>

                        
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="udp_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>

                                        

                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="Rad1" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="assets/media/icons/svg/General/details.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="map" ID="RadImageButton3" Visible="true" AlternateText="Map" runat="server" Height="35"
                                                    ImageUrl="../assets/media/icons/svg/General/map.PNG"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Settlement" ID="RadImageButton2" Visible="true" AlternateText="Settlement" runat="server"
                                                    ImageUrl="assets/media/icons/svg/General/settlement.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="User " FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="udp_SettlementStatus" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Settlement" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_SettlementStatus">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_StartTime" AllowFiltering="true" HeaderStyle-Width="130px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Start Time" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartTime">
                                        </telerik:GridBoundColumn>

                                        <%--<telerik:GridBoundColumn DataField="udp_StartTime" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartTime">
                                        </telerik:GridBoundColumn>--%>

                                        <%--<telerik:GridBoundColumn DataField="udp_StartDayStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Start Day Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartDayStatus">
                                        </telerik:GridBoundColumn>--%>

                                       



                                        <%-- <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Day Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_EndDayStatus">
                                        </telerik:GridBoundColumn>--%>

                                        <%--<telerik:GridBoundColumn DataField="udp_TotalCashCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Cash Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalCashCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_TotalArCashCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total AR Cash Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalArCashCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_TotalAmountCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Amount Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalAmountCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>--%>

                                        <%--<telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>--%>

                                        <telerik:GridBoundColumn DataField="udp_EndTime" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Time" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_EndTime">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="Duration" AllowFiltering="true" HeaderStyle-Width="130px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Duration" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Duration">
                                        </telerik:GridBoundColumn>

<%--                                        <telerik:GridBoundColumn DataField="udp_StartOdoMeter" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Start<br>OdoMeter" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartOdoMeter" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_EndOdoMeter" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End OdoMeter" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_EndOdoMeter">
                                        </telerik:GridBoundColumn>--%>


                                        <telerik:GridBoundColumn DataField="udp_VersionNumber" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Version" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_VersionNumber">
                                        </telerik:GridBoundColumn>





                                        <telerik:GridTemplateColumn DataField="udp_LogFile" UniqueName="udp_LogFile" AllowFiltering="false"
                                            HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Log File"
                                            HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="pp" runat="server"
                                                    ImageUrl="assets/media/icons/svg/Files/File.svg" NavigateUrl='<%#Eval("udp_LogFile")%>' Height="50" Width="50" Target="_blank">
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <%-- <telerik:GridTemplateColumn DataField="udp_DataBase" UniqueName="udp_DataBase" AllowFiltering="false"
                                            HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="DataBase"
                                            HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="ps" runat="server"
                                                    ImageUrl="assets/media/icons/svg/Files/Pictures.svg" NavigateUrl='<%#Eval("udp_DataBase")%>' Height="50" Width="50" Target="_blank">
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
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
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
