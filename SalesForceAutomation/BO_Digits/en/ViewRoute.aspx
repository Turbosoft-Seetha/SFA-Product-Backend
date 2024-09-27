<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ViewRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ViewRoute" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">


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
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="rot_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="70px"  AllowFiltering="false" HeaderText="View" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="View">
                                            <ItemTemplate>
                                                <asp:LinkButton CommandName="Edits" ID="view" Visible="true"  runat="server" Height="20px" Width="20px">
                                                   <svg xmlns="http://www.w3.org/2000/svg" width="22" height="15" viewBox="0 0 22 15">
                                                    <g id="Group_6028" data-name="Group 6028" transform="translate(-10731 2571)">
                                                        <path id="Path_1810" data-name="Path 1810" d="M12,4.5A11.827,11.827,0,0,0,1,12a11.817,11.817,0,0,0,22,0A11.827,11.827,0,0,0,12,4.5ZM12,17a5,5,0,1,1,5-5A5,5,0,0,1,12,17Z" transform="translate(10730 -2575.5)" fill="#d6d6da" />
                                                        <ellipse id="Ellipse_418" data-name="Ellipse 418" cx="3" cy="3.5" rx="3" ry="3.5" transform="translate(10739 -2567)" fill="#b5b5c3" />
                                                    </g>
                                                </svg>  
                                                </asp:LinkButton>
                                                
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Customer" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="CusAssigned">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="CusAssigned" ID="CusAssigned" Visible="true" AlternateText="Assigned" runat="server"
                                                    ImageUrl="../assets/media/svg/general/Customer.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Journey Plan" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="CusWeek">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="CusWeek" ID="CusWeek" Visible="true" AlternateText="Assigned" runat="server"
                                                    ImageUrl="../assets/media/svg/general/JourneyPlan.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Products" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="ProAssigned">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="ProAssigned" ID="ProAssigned" Visible="true" AlternateText="Assigned" runat="server"
                                                    ImageUrl="../assets/media/svg/general/Products.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Working Days" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="ProAssigned">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="WorkingDays" ID="WorkindDays" Visible="true" AlternateText="WorkingDays" runat="server"
                                                    ImageUrl="../assets/media/svg/general/workingdays.svg"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Route " FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_ArabicName" AllowFiltering="true" HeaderStyle-Width="130px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Arabic Name " FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_ArabicName">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="User " FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_Type" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Route Type" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Type">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_Pass" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Pass" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Pass">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_ProductiveModes" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Productive Modes" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_ProductiveModes">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_DeviceID" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Device ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_DeviceID">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="dsa_Name" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Depot SubArea" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="dsa_Name">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_IsUnload" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Unload" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_IsUnload">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_AllowSetlmntDiscrepancy" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Allow Settlement" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_AllowSetlmntDiscrepancy">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="EnforceJP" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Enforce Journey Plan" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="EnforceJP" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_EnableOdometer" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Enable Odometer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_EnableOdometer">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="IsRoutineCheck" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Routine Check" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="IsRoutineCheck">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="EnableloadinSign" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Enable LoadIn Sign" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="EnableloadinSign">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="EnableloadTransferSign" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Enable Load Transfer Sign" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="EnableloadTransferSign">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="EnableLoadOutSign" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Enable LoadOut Sign" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="EnableLoadOutSign">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="EnableSuggestedLODReq" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Enable Suggested LoadReq" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="EnableSuggestedLODReq">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_isLoadReq" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Load Request" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_isLoadReq">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_isLoadTransfer" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Load Transfer" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_isLoadTransfer">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_isLoadInEdit" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="LoadIn Edit" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_isLoadInEdit">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="rot_isLoadOutEdit" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="LoadOut Edit" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_isLoadOutEdit">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="isLoadOutExcessAllow" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="LoadOut Excess Allow" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="isLoadOutExcessAllow">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="rot_Settlement" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Payment Mode" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Settlement">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Modified By" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                    </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Modified Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
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


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
