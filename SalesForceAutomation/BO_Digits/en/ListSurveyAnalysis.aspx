﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListSurveyAnalysis.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListSurveyAnalysis" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download"
        OnClick="ImageButton4_Click" AlternateText="Xlsx" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:radajaxmanager id="RadAjaxManager1" runat="server">
    </telerik:radajaxmanager>
    <%--  <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="lnkFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>
    <div class="card-body" style="background-color: white; padding: 20px;">


        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">



                        <!--begin::Form-->
                        <div class="kt-form kt-form--label-right">
                            <div class="kt-portlet__body">


                                <telerik:radajaxpanel id="RadAjaxPanel2" runat="server" loadingpanelid="RadAjaxLoadingPanel2">
                                    <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                        <asp:PlaceHolder ID="plhFilter" runat="server">
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Region</label>
                                                <div class="col-lg-12">
                                                    <telerik:radcombobox filter="Contains" checkboxes="true" enablecheckallitemscheckbox="true" rendermode="Lightweight"
                                                        id="ddlregion" runat="server" emptymessage="Select Region" autopostback="true" onselectedindexchanged="ddlregion_SelectedIndexChanged">
                                                    </telerik:radcombobox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2" >
                                                <label class="control-label col-lg-12">Depot</label>
                                                <div class="col-lg-12">
                                                    <telerik:radcombobox skin="Material" filter="Contains" checkboxes="true" enablecheckallitemscheckbox="true"
                                                        rendermode="Lightweight"
                                                        id="ddldepot" runat="server" emptymessage="Select Depot"
                                                        onselectedindexchanged="ddldepot_SelectedIndexChanged" autopostback="true">
                                                    </telerik:radcombobox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Area</label>
                                                <div class="col-lg-12">
                                                    <telerik:radcombobox skin="Material" filter="Contains" checkboxes="true" enablecheckallitemscheckbox="true" rendermode="Lightweight"
                                                        id="ddldpoArea" runat="server" emptymessage="Select Area"
                                                        onselectedindexchanged="ddldpoArea_SelectedIndexChanged" autopostback="true">
                                                    </telerik:radcombobox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2" >
                                                <label class="control-label col-lg-12">Subarea</label>
                                                <div class="col-lg-12">
                                                    <telerik:radcombobox skin="Material" filter="Contains" checkboxes="true" enablecheckallitemscheckbox="true" rendermode="Lightweight"
                                                        id="ddldpoSubArea" runat="server" emptymessage="Select Subarea" onselectedindexchanged="ddldpoSubArea_SelectedIndexChanged" autopostback="true">
                                                    </telerik:radcombobox>

                                                </div>
                                            </div>
                                        </asp:PlaceHolder>
                                       

                                    </div>

                                    <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                          <div class="col-lg-2" >
                                            <label class="control-label col-lg-12">Route</label>
                                            <div class="col-lg-12">
                                                <telerik:radcombobox skin="Material" filter="Contains" checkboxes="true" enablecheckallitemscheckbox="true" rendermode="Lightweight" Width="100%"
                                                    id="rdRoute" runat="server" emptymessage="Select Route" onselectedindexchanged="rdRoute_SelectedIndexChanged" autopostback="true">
                                                </telerik:radcombobox>

                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Customer</label>
                                            <div class="col-lg-12">
                                                <telerik:radcombobox skin="Material" filter="Contains" checkboxes="true" enablecheckallitemscheckbox="true" rendermode="Lightweight" Width="100%"
                                                    id="rdCustomer" runat="server" emptymessage="Select Customer" onselectedindexchanged="rdCustomer_SelectedIndexChanged" autopostback="true">
                                                </telerik:radcombobox>

                                            </div>
                                        </div>


                                        <div class="col-lg-2 " >
                                            <label class="control-label col-lg-12">From Date</label>
                                            <div class="col-lg-12">
                                                <telerik:raddatepicker rendermode="Lightweight" id="rdfromDate" dateinput-dateformat="dd-MMM-yyyy" runat="server" Width="100%"
                                                    AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
                                                </telerik:raddatepicker>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-2" >
                                            <label class="control-label col-lg-12">To Date</label>
                                            <div class="col-lg-12">
                                                <telerik:raddatepicker rendermode="Lightweight" id="rdendDate" dateinput-dateformat="dd-MMM-yyyy" runat="server" Width="100%"
                                                    AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged">
                                                </telerik:raddatepicker>
                                                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                       
                                          <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Survey</label>
                                            <div class="col-lg-12">
                                                <telerik:radcombobox skin="Material" filter="Contains" rendermode="Lightweight" id="rdServey" runat="server" emptymessage="Select Survey"  Width="100%">
                                                </telerik:radcombobox>

                                            </div>
                                        </div>


                                        <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; width:auto;">
                                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                                                    Apply Filter
                                            </asp:LinkButton>
                                        </div>

                                           </div>
                                     <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                      

                                        <div class="col-lg-2" style="text-align: center; padding-top: 15px; width:auto; ">
                                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" Visible="false">
                                                    Advanced Filter
                                            </asp:LinkButton>
                                        </div>
                                         </div>


                                 




                                    <telerik:radskinmanager id="RadSkinManager1" runat="server" skin="Material" />
                                    <telerik:radgrid rendermode="Lightweight" runat="server" enablelinqexpressions="false" allowmultirowselection="false"
                                        id="grvRpt" gridlines="None"
                                        showfooter="True" allowsorting="True"
                                        onneeddatasource="grvRpt_NeedDataSource"
                                        OnItemDataBound="grvRpt_ItemDataBound"
                                        allowfilteringbycolumn="true"
                                        clientsettings-resizing-clipcellcontentonresize="true"
                                        enableajaxskinrendering="true"
                                        allowpaging="true" pagesize="50" cellspacing="0" pagerstyle-alwaysvisible="true">
                                        <clientsettings>
                                            <scrolling allowscroll="True" usestaticheaders="True" savescrollposition="true" scrollheight="500px"></scrolling>
                                        </clientsettings>
                                        <mastertableview autogeneratecolumns="False" filteritemstyle-font-size="XX-Small" canretrievealldata="false"
                                            showfooter="false" datakeynames="srh_ID"
                                            enableheadercontextmenu="true">
                                            <columns>
                                                
                                                   <telerik:gridboundcolumn datafield="cus_Code" allowfiltering="true" headerstyle-width="80px"
                                                    headerstyle-font-size="Smaller" headertext="Customer Code" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="cus_Code">
                                                </telerik:gridboundcolumn>

                                                <telerik:gridboundcolumn datafield="cus_Name" allowfiltering="true" headerstyle-width="100px"
                                                    headerstyle-font-size="Smaller" headertext="Customer" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="cus_Name">
                                                </telerik:gridboundcolumn>
                                                   <telerik:gridboundcolumn datafield="dph_Date" allowfiltering="true" headerstyle-width="100px"
                                                    headerstyle-font-size="Smaller" headertext="Trans Time" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="dph_Date">
                                                </telerik:gridboundcolumn>
                                                
                                                <telerik:gridboundcolumn datafield="srm_Name" allowfiltering="true" headerstyle-width="100px"
                                                    headerstyle-font-size="Smaller" headertext="Survey" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="srm_Name">
                                                </telerik:gridboundcolumn>
                                                <telerik:gridboundcolumn datafield="rot_Code" allowfiltering="true" headerstyle-width="60px"
                                                    headerstyle-font-size="Smaller" headertext="Route Code" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="rot_Code">
                                                </telerik:gridboundcolumn>
                                                <telerik:gridboundcolumn datafield="rot_Name" allowfiltering="true" headerstyle-width="60px"
                                                    headerstyle-font-size="Smaller" headertext="Route" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="rot_Name">
                                                </telerik:gridboundcolumn>

                                                <telerik:gridboundcolumn datafield="usr_Name" allowfiltering="true" headerstyle-width="80px"
                                                    headerstyle-font-size="Smaller" headertext="App User" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="usr_Name">
                                                </telerik:gridboundcolumn>

                                             


                                             

                                                <telerik:gridboundcolumn datafield="srd_Question" allowfiltering="true" headerstyle-width="120px"
                                                    headerstyle-font-size="Smaller" headertext="Question" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="srd_Question">
                                                </telerik:gridboundcolumn>

                                                <telerik:gridboundcolumn datafield="srd_Answer" allowfiltering="true" headerstyle-width="60px"
                                                    headerstyle-font-size="Smaller" headertext="Answer" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="srd_Answer" display="false">
                                                </telerik:gridboundcolumn>

                                                <telerik:gridtemplatecolumn headerstyle-width="150px" datafield="srd_Answer" headertext="Answer" filtercontrolwidth="100%" uniquename="Images" headerstyle-font-bold="true" allowfiltering="false">
                                                    <itemtemplate>
                                                    </itemtemplate>
                                                </telerik:gridtemplatecolumn>

                                                <telerik:gridboundcolumn datafield="qst_Name" allowfiltering="true" headerstyle-width="100px"
                                                    headerstyle-font-size="Smaller" headertext="Type" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="qst_Name">
                                                </telerik:gridboundcolumn>

                                                <telerik:gridboundcolumn datafield="srd_Remarks" allowfiltering="true" headerstyle-width="100px"
                                                    headerstyle-font-size="Smaller" headertext="Remarks" filtercontrolwidth="100%"
                                                    currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                                                    headerstyle-font-bold="true" uniquename="srd_Remarks">
                                                </telerik:gridboundcolumn>

                                            </columns>
                                        </mastertableview>
                                        <groupingsettings casesensitive="false" />
                                        <clientsettings allowdragtogroup="True" enablerowhoverstyle="true" allowcolumnsreorder="True">
                                            <resizing allowcolumnresize="true"></resizing>
                                            <selecting allowrowselect="True" enabledragtoselectrows="true"></selecting>
                                        </clientsettings>
                                    </telerik:radgrid>
                                </telerik:radajaxpanel>
                                <telerik:radajaxloadingpanel runat="server" skin="Sunset" id="RadAjaxLoadingPanel2" enableembeddedskins="false"
                                    backcolor="Transparent"
                                    forecolor="Blue">
                                    <div class="col-lg-12 text-center mt-5">
                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                    </div>

                                </telerik:radajaxloadingpanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
