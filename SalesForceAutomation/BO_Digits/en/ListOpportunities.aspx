<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListOpportunities.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListOpportunities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
  <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50px" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

                         
                            <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="40" width="33"  ToolTip="Print" 
                                OnClick="btnPDF_Click" AlternateText="pdf" Visible="false"/>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="card-body" style="background-color:white; padding:20px;">

     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   





                    <!--begin::Form-->


                    <!--end: Search Form -->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                        <div class="kt-portlet__body">

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
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" Width="100%"
                                                    ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>

                                        
                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">Opportunity</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" Width="100%"
                                                ID="rdCustomer" runat="server" EmptyMessage="Select Opportunity"  OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>


                                        <div class="col-lg-2 " style="margin-left: 32px;">
                                            <label class="control-label col-lg-12">From Date</label>
                                            <div class="col-lg-12">
                                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"
                                                    AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
                                                </telerik:RadDatePicker>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-2" style="margin-left: 32px;">
                                            <label class="control-label col-lg-12">To Date</label>
                                            <div class="col-lg-12">
                                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"
                                                    AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged">
                                                </telerik:RadDatePicker>
                                                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
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
                                    AllowFilteringByColumn="true"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="opt_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                              
                                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Document" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Document" ID="RadImageButton2" Visible="true" AlternateText="Document" runat="server"
                                                        ImageUrl="../assets/media/svg/General/Clipboard.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                             <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="140px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Route " FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="usr_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Code">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="opt_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Opportunity Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="opt_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Opportunity" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_Name">
                                            </telerik:GridBoundColumn>

                                            

                                              <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>
                                            
                                             <telerik:GridBoundColumn DataField="opt_Address" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Address" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_Address">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="opt_Email" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Email" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_Email">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="opt_Phone" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Phone" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_Phone">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="opt_WhatsappNum" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Whatsapp Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_WhatsappNum">
                                            </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="opt_GeoCode" AllowFiltering="true" HeaderStyle-Width="160px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="GeoCodes" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_GeoCode" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="GeoCode" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Map" ID="RadImageButton3" Visible="true" AlternateText="Map" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Compass.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                             
                                          <%--  <telerik:GridBoundColumn DataField="opt_ShortName" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Short Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="opt_ShortName" >
                                            </telerik:GridBoundColumn>
                                            

                                            <telerik:GridBoundColumn DataField="csh_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Header" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="csh_Name">
                                            </telerik:GridBoundColumn>--%>

                                            <telerik:GridBoundColumn DataField="cls_Name" AllowFiltering="true" HeaderStyle-Width="140px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Category" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cls_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="are_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Area" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="are_Name">
                                            </telerik:GridBoundColumn>

                                           

                                           


                                        </Columns>
                                    </MasterTableView>
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
