<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListAudit.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListAudit" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <%--<asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />


    <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="40" Width="33" ToolTip="Print"
        OnClick="btnPDF_Click" AlternateText="pdf" />--%>
       <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click1" AlternateText="xlsx" >

       </asp:ImageButton>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <%-- <div class="kt-portlet__head" style="padding-top: 20px;  padding-bottom: 20px;">

                      c
                        <%--<div class="kt-portlet__head-actions">

                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

                         </div>--%>
                        <%--</div>--%>



                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            <div class="kt-portlet__body">
                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                    <%--<div class=" col-lg-12 row" style="padding-bottom: 10px">
                                        <asp:PlaceHolder ID="plhFilter" runat="server">
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Region</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddlregion" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Depot</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                        RenderMode="Lightweight"
                                                        ID="ddldepot" runat="server" EmptyMessage="Select Depot"
                                                        OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Area</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddldpoArea" runat="server" EmptyMessage="Select Area"
                                                        OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Subarea</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                        </asp:PlaceHolder>
                                           <div class="col-lg-2" style="margin-left: 4px;">
                                    <label class="control-label col-lg-12">Route</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>
                                    </div>--%>

                                    <div class=" col-lg-12 row" style="padding-bottom: 10px">

                                        <div class="col-lg-2 ">
                                            <label class="control-label col-lg-12">From Date</label>
                                            <div class="col-lg-12">
                                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"
                                                    AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged1">
                                                </telerik:RadDatePicker>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">To Date</label>
                                            <div class="col-lg-12">
                                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"
                                                    AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged1">
                                                </telerik:RadDatePicker>
                                                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>


                                        <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px;">
                                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                            </asp:LinkButton>
                                        </div>
                                        <%--<div class="col-lg-2" style="text-align: center; padding-top: 15px;">
                                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" Visible="false">
                                                    Advanced Filter
                                            </asp:LinkButton>
                                        </div>--%>


                                    </div>
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
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>


                                               
                                                
                                                <telerik:GridBoundColumn DataField="LoginID" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Login ID" FilterControlWidth="90%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="LoginID" Display ="false">
                                                </telerik:GridBoundColumn>
                                            
                                                <telerik:GridBoundColumn DataField="LoginName" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Login Name" FilterControlWidth="90%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="LoginName">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Role" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Role" FilterControlWidth="90%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Role">
                                                </telerik:GridBoundColumn>
                                                
                                                <telerik:GridBoundColumn DataField="LoginTime" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Login Time" FilterControlWidth="90%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="LoginTime" >
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="LoginIP" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Login IP" FilterControlWidth="90%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="LoginIP">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="90%"
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
    </div>

</asp:Content>


