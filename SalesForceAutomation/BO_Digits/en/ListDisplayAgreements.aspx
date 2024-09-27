<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListDisplayAgreements.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListDisplayAgreements" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <div class="row pb-5" style="margin-right: auto;">
                                <ul class="nav" style="justify-content: flex-end;">

                                    <li class="nav-item">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">
                                       <asp:LinkButton ID="lnkALl" runat="server"  CssClass="btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkALl_Click"  ></asp:LinkButton>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                                    </li>
                                    <li class="nav-item">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                       <asp:LinkButton ID="lnkPending" runat="server"  CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1"  OnClick="lnkPending_Click"></asp:LinkButton>
                                         </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                                    </li>
                                    <li class="nav-item">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                        <asp:LinkButton ID="lnkapproved" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkapproved_Click" ></asp:LinkButton>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                                    </li>
                                     <li class="nav-item">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                        <asp:LinkButton ID="lnkrejejected" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" OnClick="lnkrejejected_Click" ></asp:LinkButton>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                                    </li>
                                     <li class="nav-item">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel9" runat="server" LoadingPanelID="RadAjaxLoadingPanel9">
                                        <asp:LinkButton ID="lnkExpired" runat="server" CssClass="nav-link btn btn-sm btn-color-muted btn-active btn-active-light-primary fw-bolder px-4 me-1" onclick="lnkExpired_Click" ></asp:LinkButton>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel10" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                                    </li>
                                </ul>
                            </div>
  <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download"  OnClick="imgExcel_Click" AlternateText="Xlsx" />


   <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="40" Width="33" ToolTip="Print"
                                OnClick="btnPDF_Click" AlternateText="pdf" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>   
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">


    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnkALl">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
        <telerik:AjaxUpdatedControl ControlID="lnkPending" />
        <telerik:AjaxUpdatedControl ControlID="lnkapproved" />
        <telerik:AjaxUpdatedControl ControlID="lnkrejejected" />
        <telerik:AjaxUpdatedControl ControlID="lnkExpired" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
        
    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnkPending">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
        <telerik:AjaxUpdatedControl ControlID="lnkALl" />
        <telerik:AjaxUpdatedControl ControlID="lnkapproved" />
        <telerik:AjaxUpdatedControl ControlID="lnkrejejected" />
        <telerik:AjaxUpdatedControl ControlID="lnkExpired" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>

    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnkapproved">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
        <telerik:AjaxUpdatedControl ControlID="lnkALl" />
        <telerik:AjaxUpdatedControl ControlID="lnkPending" />
        <telerik:AjaxUpdatedControl ControlID="lnkrejejected" />
        <telerik:AjaxUpdatedControl ControlID="lnkExpired" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnkrejejected">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
             <telerik:AjaxUpdatedControl ControlID="lnkALl" />
        <telerik:AjaxUpdatedControl ControlID="lnkPending" />
        <telerik:AjaxUpdatedControl ControlID="lnkapproved" />
        <telerik:AjaxUpdatedControl ControlID="lnkExpired" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnkExpired">
    <UpdatedControls>
    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
            <telerik:AjaxUpdatedControl ControlID="lnkALl" />
        <telerik:AjaxUpdatedControl ControlID="lnkPending" />
        <telerik:AjaxUpdatedControl ControlID="lnkapproved" />
        <telerik:AjaxUpdatedControl ControlID="lnkrejejected" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="chkDate">
    <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="grvRpt" />
    <telerik:AjaxUpdatedControl ControlID="lnkrejejected" />
         <telerik:AjaxUpdatedControl ControlID="lnkExpired" />
        <telerik:AjaxUpdatedControl ControlID="lnkPending" />
        <telerik:AjaxUpdatedControl ControlID="lnkapproved" />
        <telerik:AjaxUpdatedControl ControlID="lnkALl" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>
        <AjaxSettings>
    <telerik:AjaxSetting AjaxControlID="lnkFilter">
    <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="lnkrejejected" />
         <telerik:AjaxUpdatedControl ControlID="lnkExpired" />
        <telerik:AjaxUpdatedControl ControlID="lnkPending" />
        <telerik:AjaxUpdatedControl ControlID="lnkapproved" />
        <telerik:AjaxUpdatedControl ControlID="lnkALl" />
     </UpdatedControls>
    </telerik:AjaxSetting>
    </AjaxSettings>

  
    </telerik:RadAjaxManagerProxy>
     <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   

                   


                    <!--begin::Form-->


                    <!--end: Search Form -->
                    <%--<telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                        <div class="kt-portlet__body">--%>
                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <div class="col-lg-12 row">
                                <div class="col-lg-6">
                                <asp:CheckBox ID="chkDate" runat="server" Text="Consider Date"  AutoPostBack="true" OnCheckedChanged="chkDate_CheckedChanged" />
                                </div>
    
                           </div>
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                           
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
                               


                            </div>

                            <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">From Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"  Width="100%"
                                            AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">To Date</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"  Width="100%"
                                            AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged">
                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                 <div class="col-lg-2">
                                    <label class="control-label col-lg-12">Route</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"  Width="100%"
                                            ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>

                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">Customer</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"  Width="100%"
                                            ID="rdCustomer" runat="server" EmptyMessage="Select Customer" OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>


                                 


                                <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; ">
                                    <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkFilter_Click">
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
                            OnItemDataBound="grvRpt_ItemDataBound"
                            AllowFilteringByColumn="true"
                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                            EnableAjaxSkinRendering="true"
                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="dag_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>
                                     
                                   

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

                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="dag_Number" AllowFiltering="true" HeaderStyle-Width="150px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Agreement Number" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_Number">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="agt_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="agt_Name">
                                            </telerik:GridBoundColumn>


                                
                                     <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                            </telerik:GridBoundColumn>

                             

                                     <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>


                                

                                  
                                    <telerik:GridBoundColumn DataField="act_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Category " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="act_Name">
                                    </telerik:GridBoundColumn>



                                    <telerik:GridBoundColumn DataField="asc_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="SubCategory" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="asc_Name">
                                    </telerik:GridBoundColumn>

                                   <%-- <telerik:GridBoundColumn DataField="brd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Brand Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Code">
                                    </telerik:GridBoundColumn>--%>

                                    <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                    </telerik:GridBoundColumn>



                                   <%-- <telerik:GridBoundColumn DataField="apt_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Pay Terms Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="apt_Code">
                                    </telerik:GridBoundColumn>--%>



                                    <telerik:GridBoundColumn DataField="apt_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Pay Terms" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="apt_Name">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="ago_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Offer" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ago_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="dag_StartDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Start Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_StartDate">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="dag_EndDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="End Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_EndDate">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="dag_MonthlyAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Monthly Amount" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_MonthlyAmount"><ItemStyle HorizontalAlign="Right" /><HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="dag_TotalAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Amount" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_TotalAmount"><ItemStyle HorizontalAlign="Right" /><HeaderStyle HorizontalAlign="Right" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="50px" HeaderText="Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                        <ItemTemplate>

                                            <asp:HyperLink ID="dagImg" runat="server" NavigateUrl=' <%#"../" +  Eval("dag_Image") %>' Target="_blank">
                                                <asp:Image ID="dagImage" runat="server" ImageUrl=' <%# "../" +  Eval("dag_Image") %>' Height="20px" width="20px" />
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                     <telerik:GridBoundColumn DataField="dag_Attachment" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Attachment" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_Attachment" Display="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn  AllowFiltering="false"
                                                HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Attachment"
                                                HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="pp" runat="server"
                                                        ImageUrl="../assets/media/svg/Files/File.svg" NavigateUrl='<%# "../" + Eval("dag_Attachment")%>' Height="50" Width="50" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>





                                   <%-- <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Attachment" UniqueName="Attachment" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                        <ItemTemplate>

                                            <asp:HyperLink ID="dagAttach" runat="server" NavigateUrl=' <%#  Eval("dag_Attachment") %>' Target="_blank">
                                                <asp:Image ID="dagAttchment" runat="server" ImageUrl=' <%#  Eval("dag_Attachment") %>' Height="65px" />
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>

                                    <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Status">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="dag_Remarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_Remarks">
                                    </telerik:GridBoundColumn>
                                    <%-- <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
                                            </telerik:GridBoundColumn>--%>
                                </Columns>
                            </MasterTableView>
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>
                        
                    
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
         </div>
</asp:Content>