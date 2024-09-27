<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListCustomerActivityAnalysis.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListCustomerActivityAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download"
        OnClick="ImageButton4_Click" AlternateText="Xlsx" />
    <telerik:radajaxpanel id="RadAjaxPanel2" runat="server" loadingpanelid="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="lnkAdd" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" OnClick="lnkAdd_Click"></asp:LinkButton>
    </telerik:radajaxpanel>
    <telerik:radajaxloadingpanel runat="server" skin="Sunset" id="RadAjaxLoadingPanel1" enableembeddedskins="false"
        backcolor="Transparent"
        forecolor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:radajaxloadingpanel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body row p-8" style="background-color: white;">

        <!--begin::Portlet-->

        <!--begin::Form-->
        <telerik:radajaxpanel id="RadAjaxPanel1" runat="server" loadingpanelid="RadAjaxLoadingPanel2">

            <div class="col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px;">

                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Route</label>
                    <div class="col-lg-12">
                        <telerik:radcombobox skin="Material" filter="Contains" checkboxes="true" enablecheckallitemscheckbox="true" rendermode="Lightweight"
                            id="rdRoute" runat="server" emptymessage="Select Route" width="100%" onselectedindexchanged="rdRoute_SelectedIndexChanged" autopostback="true">
                        </telerik:radcombobox>

                    </div>
                </div>

                <div class="col-lg-2">
                    <div class="col-lg-12">
                        <label class="control-label col-lg-12 pl-0">Customer </label>
                    </div>
                    <div class="col-lg-12">
                        <telerik:radcombobox id="rdCustomer" runat="server" filter="Contains" rendermode="Lightweight" checkboxes="true" enablecheckallitemscheckbox="true" emptymessage="Select Customer" width="100%">
                        </telerik:radcombobox>
                    </div>
                </div>
                 <div class="col-lg-2">
                    <div class="col-lg-12">
                        <label class="control-label col-lg-12 pl-0">Activity </label>
                    </div>
                    <div class="col-lg-12">
                        <telerik:radcombobox id="ddlActivity" runat="server" filter="Contains" rendermode="Lightweight" checkboxes="true" enablecheckallitemscheckbox="true" emptymessage="Select Customer Activity" width="100%">
                        </telerik:radcombobox>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="col-lg-12">
                        <label class="control-label col-lg-6">From Date</label>
                    </div>
                    <div class="col-lg-12">
                        <telerik:raddatepicker rendermode="Lightweight" id="rdFromDate" dateinput-dateformat="dd-MMM-yyyy" runat="server" width="100%" AutoPostBack="true" OnSelectedDateChanged="rdFromDate_SelectedDateChanged">
                        </telerik:raddatepicker>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdFromDate"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="col-lg-12">
                        <label class="control-label col-lg-6">To Date</label>
                    </div>
                    <div class="col-lg-12">
                        <telerik:raddatepicker rendermode="Lightweight" id="rdEndDate" dateinput-dateformat="dd-MMM-yyyy" runat="server" width="100%" AutoPostBack="true" OnSelectedDateChanged="rdEndDate_SelectedDateChanged">
                        </telerik:raddatepicker>
                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdEndDate" ControlToCompare="rdFromDate" ErrorMessage="End date must be greater"
                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual">
                        </asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdEndDate"></asp:RequiredFieldValidator>
                    </div>
                </div>

               

                <div class="col-lg-2" style="text-align: right; top: 10px; text-align: center; padding-top: 15px;">
                    <asp:LinkButton ID="lnkfilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="true" OnClick="lnkfilter_Click">
                                                    Apply Filter
                    </asp:LinkButton>
                </div>


            </div>

            <telerik:radskinmanager id="RadSkinManager1" runat="server" skin="Material" />
            <telerik:radgrid rendermode="Lightweight" runat="server" enablelinqexpressions="false" allowmultirowselection="true"
                id="grvRpt" gridlines="None"
                showfooter="True" allowsorting="True"
                onneeddatasource="grvRpt_NeedDataSource"
                OnItemDataBound="grvRpt_ItemDataBound"
                allowfilteringbycolumn="true"
                clientsettings-resizing-clipcellcontentonresize="true"
                enableajaxskinrendering="true"
                allowpaging="true" pagesize="10" cellspacing="0">
                <clientsettings>
                    <scrolling allowscroll="True" usestaticheaders="True" savescrollposition="true" scrollheight="500"></scrolling>
                </clientsettings>
                <mastertableview autogeneratecolumns="False" filteritemstyle-font-size="XX-Small" canretrievealldata="false"
                    showfooter="false" datakeynames="cah_ID"
                    enableheadercontextmenu="true">
                    <columns>

                        <telerik:gridboundcolumn datafield="rot_Code" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Route Code" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="rot_Code">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="rot_Name" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Route" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="rot_Name">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cus_Code" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Customer Code" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cus_Code">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cus_Name" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Customer" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cus_Name">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cah_Code" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Code" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cah_Code">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cah_Name" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Name" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cah_Name">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cah_Description" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Description" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cah_Description">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="TransDate" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Trans Date" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="TransDate">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cah_StartDate" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="StartDate" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cah_StartDate">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cah_EndDate" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="EndDate" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cah_EndDate">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="Status" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="Status" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="Status" display="false">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cad_Code" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="Code1" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_Code">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cad_Name" allowfiltering="true" headerstyle-width="150px"
                            headerstyle-font-size="Smaller" headertext="Name1" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_Name">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cad_Description" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="Description1" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_Description">
                        </telerik:gridboundcolumn>

                        <telerik:gridboundcolumn datafield="cad_Type" allowfiltering="true" headerstyle-width="100px"
                            headerstyle-font-size="Smaller" headertext="Type" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_Type">
                        </telerik:gridboundcolumn>
                        
                        <telerik:gridboundcolumn datafield="cad_DueDate" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="DueDate" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_DueDate">
                        </telerik:gridboundcolumn>

                      <%--  <telerik:gridboundcolumn datafield="cad_ReferenceImage" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Reference Image" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_ReferenceImage" display="false">
                        </telerik:gridboundcolumn>--%>

                        <telerik:gridtemplatecolumn headerstyle-width="100px" headertext="Reference Image" uniquename="Images" headerstyle-font-bold="true" allowfiltering="false">
                            <itemtemplate>
                                <asp:HyperLink ID="salImg" runat="server" NavigateUrl=' <%#  Eval("cad_ReferenceImage") %>' Target="_blank" Visible="true">
                                    <asp:Image ID="salImage" runat="server" ImageUrl=' <%#  Eval("cad_ReferenceImage") %>' Height="20px" Width="20px" Visible="true" />
                                </asp:HyperLink>
                            </itemtemplate>
                        </telerik:gridtemplatecolumn>

                        <telerik:gridboundcolumn datafield="cad_Remarks" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="Merchandiser Remarks" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_Remarks">
                        </telerik:gridboundcolumn>

                       <telerik:gridtemplatecolumn headerstyle-width="150px" headertext="CaptureImage" uniquename="CaptureImage" headerstyle-font-bold="true" allowfiltering="false">
                            <itemtemplate>
                                <%--<telerik:RadImageGallery RenderMode="Lightweight" ID="rdImages" runat="server" DisplayAreaMode="ToolTip"  Visible="false" DataImageField="odi_Image"   Width="300px" Height="60px"  LoopItems="false">
                                                        <ImageAreaSettings Height="100px" Width="100px"  />
                                                </telerik:RadImageGallery>--%>
                            </itemtemplate>
                        </telerik:gridtemplatecolumn>

                        <telerik:gridboundcolumn datafield="cai_CaptureImage" allowfiltering="true" headerstyle-width="100px" display="false"
                            headerstyle-font-size="Smaller" headertext="CaptureImage" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cai_CaptureImage">
                        </telerik:gridboundcolumn>
                        <telerik:gridboundcolumn datafield="cad_SortOrder" allowfiltering="true" headerstyle-width="120px"
                            headerstyle-font-size="Smaller" headertext="SortOrder" filtercontrolwidth="100%"
                            currentfilterfunction="Contains" autopostbackonfilter="true" showfiltericon="false"
                            headerstyle-font-bold="true" uniquename="cad_SortOrder">
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

        </telerik:radajaxpanel>
        <telerik:radajaxloadingpanel runat="server" skin="Sunset" id="RadAjaxLoadingPanel2" enableembeddedskins="false"
            backcolor="Transparent"
            forecolor="Blue">
            <div class="col-lg-12 text-center mt-5">
                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
            </div>

        </telerik:radajaxloadingpanel>


    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
