<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerVisitDetailFromDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerVisitDetailFromDashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:radajaxpanel id="RadAjaxPanel1" runat="server" loadingpanelid="RadAjaxLoadingPanel1">
        <div class=" col-lg-12 row" style="padding-bottom: 10px">
            <div class="col-lg-3">
                <div class="col-lg-12">
                    <label class="control-label col-lg-12">Route </label>
                </div>
                <div class="col-lg-12">
                    <telerik:radcombobox id="ddlRoute" runat="server" filter="Contains" width="100%"
                        checkboxes="true" enablecheckallitemscheckbox="true" rendermode="Lightweight" autopostback="true" emptymessage="Select Route">
                    </telerik:radcombobox>
                </div>
            </div>
            <div class="col-lg-3">
                <label class="control-label col-lg-12">From Date</label>
                <div class="col-lg-12">
                    <telerik:raddatepicker rendermode="Lightweight" id="rdfromDate" dateinput-dateformat="dd-MMM-yyyy" runat="server" width="100%" autopostback="true" onselecteddatechanged="rdfromDate_SelectedDateChanged">
                    </telerik:raddatepicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-lg-3">
                <label class="control-label col-lg-12">To Date</label>
                <div class="col-lg-12">
                    <telerik:raddatepicker rendermode="Lightweight" id="rdendDate" dateinput-dateformat="dd-MMM-yyyy" runat="server" width="100%" autopostback="true" onselecteddatechanged="rdendDate_SelectedDateChanged">
                    </telerik:raddatepicker>
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
    </telerik:radajaxpanel>
    <telerik:radajaxloadingpanel runat="server" skin="Sunset" id="RadAjaxLoadingPanel1" enableembeddedskins="false"
        backcolor="Transparent"
        forecolor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:radajaxloadingpanel>
    <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../assets/media/icons/excel.png" Style="height: 50px;" ToolTip="Download" OnClick="ImageButton1_Click" AlternateText="Xlsx" />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:radajaxmanager id="RadAjaxManager1" runat="server">
    </telerik:radajaxmanager>
    <telerik:radajaxmanagerproxy id="AjaxManagerProxy1" runat="server">
        <ajaxsettings>
            <telerik:ajaxsetting ajaxcontrolid="Filter">
                <updatedcontrols>
                    <telerik:ajaxupdatedcontrol controlid="grvRpt" />
                    <telerik:ajaxupdatedcontrol controlid="RadGrid1" />
                    <telerik:ajaxupdatedcontrol controlid="RadGrid2" />
                </updatedcontrols>
            </telerik:ajaxsetting>
            <telerik:ajaxsetting ajaxcontrolid="Adj">
                <updatedcontrols>
                    <telerik:ajaxupdatedcontrol controlid="grvRpt" />
                </updatedcontrols>
            </telerik:ajaxsetting>
        </ajaxsettings>
    </telerik:radajaxmanagerproxy>





    <div class="card-body" style="background-color: white; padding: 20px;">




        <telerik:radskinmanager id="RadSkinManager1" runat="server" skin="Material" />

        <div class="col bg-light px-8 py-2 mx-2 rounded-2 mb-7" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.2);">
            <div class="card-header pt-2">
                <h3 class="kt-portlet__head-title">
                    <span style="color: midnightblue" class="card-label fw-bold fs-2x d-flex justify-content-center text-active-primary">
                        <asp:Label runat="server" ID="lblHeading" Text=""></asp:Label>
                    </span>
                </h3>

            </div>
        </div>

        <div class="col-lg-12 row">
            <div class="col-lg-6 mb-4">

                <div class="col-lg-6 py-6">
                    <h3>Visited Planned</h3>
                </div>
                <telerik:radgrid rendermode="Lightweight" runat="server" enablelinqexpressions="false" allowmultirowselection="false"
                    id="RadGrid1" gridlines="None"
                    showfooter="True" allowsorting="True"
                    onneeddatasource="RadGrid1_NeedDataSource"
                    onitemcommand="RadGrid1_ItemCommand"
                    allowfilteringbycolumn="true"
                    clientsettings-resizing-clipcellcontentonresize="true"
                    enableajaxskinrendering="true"
                    allowpaging="true" pagesize="5000" cellspacing="0" pagerstyle-alwaysvisible="true">
                    <clientsettings>
                        <scrolling allowscroll="True" usestaticheaders="True" savescrollposition="true" scrollheight="300px"></scrolling>
                    </clientsettings>
                    <mastertableview autogeneratecolumns="False" filteritemstyle-font-size="Medium" canretrievealldata="false"
                        showfooter="false"
                        enableheadercontextmenu="true">
                        <columns>
                            <telerik:gridboundcolumn datafield="rot_Code" allowfiltering="true" headerstyle-width="130px"
                                headerstyle-font-size="Smaller" headertext="Route Code" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="rot_Code">
                            </telerik:gridboundcolumn>

                            <telerik:gridboundcolumn datafield="rot_Name" allowfiltering="true" headerstyle-width="150px"
                                headerstyle-font-size="Smaller" headertext="Route" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="rot_Name" itemstyle-horizontalalign="Left">
                            </telerik:gridboundcolumn>
                            <telerik:gridboundcolumn datafield="cus_Code" allowfiltering="true" headerstyle-width="130px"
                                headerstyle-font-size="Smaller" headertext="Customer Code" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="cus_Code">
                            </telerik:gridboundcolumn>

                            <telerik:gridboundcolumn datafield="cus_Name" allowfiltering="true" headerstyle-width="150px"
                                headerstyle-font-size="Smaller" headertext="Customer" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="cus_Name" itemstyle-horizontalalign="Left">
                            </telerik:gridboundcolumn>

                        </columns>
                    </mastertableview>
                    <pagerstyle alwaysvisible="true" />
                    <groupingsettings casesensitive="false" />
                    <clientsettings allowdragtogroup="True" enablerowhoverstyle="true" allowcolumnsreorder="True">
                        <resizing allowcolumnresize="true"></resizing>
                        <selecting allowrowselect="True" enabledragtoselectrows="true"></selecting>
                    </clientsettings>
                </telerik:radgrid>
            </div>
            <div class="col-lg-6 mb-4">

                <asp:PlaceHolder runat="server" ID="pnlUnplanned" Visible="false">
                    <div class="col-lg-6 py-6">
                        <h3>Visited UnPlanned</h3>
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder runat="server" ID="pnlPending" Visible="false">
                    <div class="col-lg-6 py-6">
                        <h3>Pending Visits</h3>
                    </div>
                </asp:PlaceHolder>

                <telerik:radgrid rendermode="Lightweight" runat="server" enablelinqexpressions="false" allowmultirowselection="false"
                    id="RadGrid2" gridlines="None"
                    showfooter="True" allowsorting="True"
                    onneeddatasource="RadGrid2_NeedDataSource"
                    onitemcommand="RadGrid2_ItemCommand"
                    allowfilteringbycolumn="true"
                    clientsettings-resizing-clipcellcontentonresize="true"
                    enableajaxskinrendering="true"
                    allowpaging="true" pagesize="5000" cellspacing="0" pagerstyle-alwaysvisible="true">
                    <clientsettings>
                        <scrolling allowscroll="True" usestaticheaders="True" savescrollposition="true" scrollheight="300px"></scrolling>
                    </clientsettings>
                    <mastertableview autogeneratecolumns="False" filteritemstyle-font-size="Medium" canretrievealldata="false"
                        showfooter="false"
                        enableheadercontextmenu="true">
                        <columns>
                            <telerik:gridboundcolumn datafield="rot_Code" allowfiltering="true" headerstyle-width="130px"
                                headerstyle-font-size="Smaller" headertext="Route Code" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="rot_Code">
                            </telerik:gridboundcolumn>

                            <telerik:gridboundcolumn datafield="rot_Name" allowfiltering="true" headerstyle-width="150px"
                                headerstyle-font-size="Smaller" headertext="Route" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="rot_Name" itemstyle-horizontalalign="Left">
                            </telerik:gridboundcolumn>

                            <telerik:gridboundcolumn datafield="cus_Code" allowfiltering="true" headerstyle-width="130px"
                                headerstyle-font-size="Smaller" headertext="Customer Code" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="cus_Code">
                            </telerik:gridboundcolumn>

                            <telerik:gridboundcolumn datafield="cus_Name" allowfiltering="true" headerstyle-width="150px"
                                headerstyle-font-size="Smaller" headertext="Customer" filtercontrolwidth="100%"
                                currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                headerstyle-font-bold="true" uniquename="cus_Name" itemstyle-horizontalalign="Left">
                            </telerik:gridboundcolumn>

                        </columns>
                    </mastertableview>
                    <pagerstyle alwaysvisible="true" />
                    <groupingsettings casesensitive="false" />
                    <clientsettings allowdragtogroup="True" enablerowhoverstyle="true" allowcolumnsreorder="True">
                        <resizing allowcolumnresize="true"></resizing>
                        <selecting allowrowselect="True" enabledragtoselectrows="true"></selecting>
                    </clientsettings>
                </telerik:radgrid>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="row">
                <div class="col-lg-8 py-6">
                    <h3>Customer Visits</h3>
                </div>
                <div class="col-lg-3 py-6" style="font: 100;">
                    <b>
                        <asp:Label Text="Show Customers who are Not Exited" runat="server"></asp:Label></b>
                    <asp:CheckBox ID="Adj" runat="server" Height="15px" Width="15px" OnCheckedChanged="Adj_CheckedChanged" AutoPostBack="true" />
                </div>
                <div class="col-lg-1" style="top: 10px; text-align: center; padding-top: 5px; width: auto;">
                    <asp:ImageButton ID="Excel2" runat="server" ImageUrl="../assets/media/icons/excel.png" Style="height: 50px;" ToolTip="Download" OnClick="Excel2_Click" AlternateText="Xlsx" />
                </div>

            </div>
            <telerik:radgrid rendermode="Lightweight" runat="server" enablelinqexpressions="false" allowmultirowselection="false"
                id="grvRpt" gridlines="None"
                showfooter="True" allowsorting="True"
                onneeddatasource="grvRpt_NeedDataSource"
                onitemcommand="grvRpt_ItemCommand"
                allowfilteringbycolumn="true"
                clientsettings-resizing-clipcellcontentonresize="true"
                enableajaxskinrendering="true"
                allowpaging="true" pagesize="5000" cellspacing="0" pagerstyle-alwaysvisible="true">
                <clientsettings>
                    <scrolling allowscroll="True" usestaticheaders="True" savescrollposition="true" scrollheight="500px"></scrolling>
                </clientsettings>
                <mastertableview autogeneratecolumns="False" filteritemstyle-font-size="Medium" canretrievealldata="false"
                    showfooter="false" datakeynames="cse_ID"
                    enableheadercontextmenu="true">
                    <columns>

                        <telerik:gridboundcolumn datafield="rot_Code" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="Route Code" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="rot_Code">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="rot_Name" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Route" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="rot_Name" itemstyle-horizontalalign="Left">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="cus_Code" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="Customer Code" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cus_Code">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cus_Name" allowfiltering="true" headerstyle-width="180px"
                            headerstyle-font-size="Smaller" headertext="Customer" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cus_Name" itemstyle-horizontalalign="Left">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="CreatedDate" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Visited Date" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="CreatedDate">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cse_StartTime" allowfiltering="true" headerstyle-width="90px"
                            headerstyle-font-size="Smaller" headertext="Start Time" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cse_StartTime">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="cse_EndTime" allowfiltering="true" headerstyle-width="90px"
                            headerstyle-font-size="Smaller" headertext="End Time" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cse_EndTime">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="cse_StartStatus" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Start Status" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cse_StartStatus">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="cse_ExistStatus" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Exist Status" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cse_ExistStatus">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="cse_IsScheduled" allowfiltering="true" headerstyle-width="80px"
                            headerstyle-font-size="Smaller" headertext="Scheduled" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cse_IsScheduled">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="cse_IsProductive" allowfiltering="true" headerstyle-width="80px"
                            headerstyle-font-size="Smaller" headertext="Productive" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cse_IsProductive">
                        </telerik:gridboundcolumn>

                        <%--<telerik:GridBoundColumn DataField="cse_StartGeoCode" AllowFiltering="true" HeaderStyle-Width="150px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="Start GeoCode" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_StartGeoCode">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="cse_EndGeoCode" AllowFiltering="true" HeaderStyle-Width="150px"
                            HeaderStyle-Font-Size="Smaller" HeaderText="End GeoCode" FilterControlWidth="100%"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                            HeaderStyle-Font-Bold="true" UniqueName="cse_EndGeoCode">
                        </telerik:GridBoundColumn>--%>
                        <telerik:gridboundcolumn datafield="SyncedDatetime" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Synced Date&time" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="SyncedDatetime">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="CreationMode" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Creation Mode" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="CreationMode" display="false">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="Actions" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Transactions" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="Actions">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cse_SelectionType" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Selection Type" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cse_SelectionType">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="rsn_Name" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Unplanned Visit Reason" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="rsn_Name">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="noTransReasn" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="No Transaction Reason" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="noTransReasn" >
                        </telerik:gridboundcolumn>
                    </columns>
                </mastertableview>
                <pagerstyle alwaysvisible="true" />
                <groupingsettings casesensitive="false" />
                <clientsettings allowdragtogroup="True" enablerowhoverstyle="true" allowcolumnsreorder="True">
                    <resizing allowcolumnresize="true"></resizing>
                    <selecting allowrowselect="True" enabledragtoselectrows="true"></selecting>
                </clientsettings>
            </telerik:radgrid>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
