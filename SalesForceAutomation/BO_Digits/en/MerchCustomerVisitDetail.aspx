<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="MerchCustomerVisitDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.MerchCustomerVisitDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <div class=" col-lg-12 row" style="padding-bottom: 10px">
            <div class="col-lg-3">
                <div class="col-lg-12">
                    <label class="control-label col-lg-12">Route </label>
                </div>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="ddlRoute" runat="server" Filter="Contains" Width="100%"
                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route">
                    </telerik:RadComboBox>
                </div>
            </div>
            <div class="col-lg-3">
                <label class="control-label col-lg-12">From Date</label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-lg-3">
                <label class="control-label col-lg-12">To Date</label>
                <div class="col-lg-12">
                    <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                    </telerik:RadDatePicker>
                    <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                        Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                </div>
            </div>


            <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
                <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
          Apply Filter
                </asp:LinkButton>
            </div>
            
        </div>
    </telerik:RadAjaxPanel>

    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>


      
          <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../assets/media/icons/excel.png" style="height: 50px; " ToolTip="Download" OnClick="ImageButton1_Click" AlternateText="Xlsx" />
            </div>
     

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Filter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="Adj">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        

    </telerik:RadAjaxManagerProxy>





    <div class="card-body" style="background-color: white; padding: 20px;">




        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />

              <div class="col-lg-12">
            <div class="row">
                <div class="col-lg-9 py-6">
                    <h3>Customer Visits</h3>
                </div>
                

            </div>
            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                ID="grvRpt" GridLines="None"
                ShowFooter="True" AllowSorting="True"
                OnNeedDataSource="grvRpt_NeedDataSource"
                AllowFilteringByColumn="true"
                ClientSettings-Resizing-ClipCellContentOnResize="true"
                EnableAjaxSkinRendering="true"
                AllowPaging="true" PageSize="5000" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                <ClientSettings>
                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                </ClientSettings>
                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Medium" CanRetrieveAllData="false"
                    ShowFooter="false" DataKeyNames="cse_ID"
                    EnableHeaderContextMenu="true">
                    <Columns>

                        <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name" ItemStyle-HorizontalAlign="Left">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name" ItemStyle-HorizontalAlign="Left">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Visited Date" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="cse_StartTime" AllowFiltering="true" HeaderStyle-Width="90px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Start Time" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_StartTime">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_EndTime" AllowFiltering="true" HeaderStyle-Width="90px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="End Time" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_EndTime">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_StartStatus" AllowFiltering="true" HeaderStyle-Width="120px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Start Status" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_StartStatus">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_ExistStatus" AllowFiltering="true" HeaderStyle-Width="120px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Exist Status" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_ExistStatus">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_IsScheduled" AllowFiltering="true" HeaderStyle-Width="80px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_IsScheduled">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_IsProductive" AllowFiltering="true" HeaderStyle-Width="80px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Productive" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_IsProductive">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="cse_StartGeoCode" AllowFiltering="true" HeaderStyle-Width="150px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Start GeoCode" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_StartGeoCode">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_EndGeoCode" AllowFiltering="true" HeaderStyle-Width="150px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="End GeoCode" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_EndGeoCode">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SyncedDatetime" AllowFiltering="true" HeaderStyle-Width="150px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Synced Date&time" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="SyncedDatetime">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CreationMode" AllowFiltering="true" HeaderStyle-Width="120px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Creation Mode" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="CreationMode" Display="false">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="cse_SelectionType" AllowFiltering="true" HeaderStyle-Width="120px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Selection Type" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_SelectionType">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_Geolocaccuracy" AllowFiltering="true" HeaderStyle-Width="120px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Currency" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_Geolocaccuracy" Display="false">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="IsOutsideFence" AllowFiltering="true" HeaderStyle-Width="120px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Outside Fence" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="IsOutsideFence" Display="false">
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>