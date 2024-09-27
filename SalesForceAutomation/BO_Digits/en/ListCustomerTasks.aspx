<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListCustomerTasks.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListCustomerTasks" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

     <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download"
                                OnClick="ImageButton4_Click" AlternateText="Xlsx" />
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
      <asp:LinkButton ID="lnkAdd" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" 
          OnClick="lnkAdd_Click"></asp:LinkButton>
         </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>   
                            
                            

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                 
                   
                    <!--end: Search Form -->
                   


                     <!--begin::Form-->
                     <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">

                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                                        <div class="col-lg-3" >
                                            
                                                <label class="control-label col-lg-12">Route </label>
                                           
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlRoute" runat="server" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" Filter="Contains"
                                                      CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route" Width="100%">
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-3" >
                                            
                                                <label class="control-label col-lg-12">Customer </label>
                                           
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlCustomer" runat="server" Filter="Contains" 
                                                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  RenderMode="Lightweight" EmptyMessage="Select Customer" Width="100%">
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-2" >
                                      
                                            <label class="control-label col-lg-12">From Date </label>
                                       
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker ID="rdFromData" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
                                        
                                            <label class="control-label col-lg-12">To Date </label>
                                      
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker ID="rdEndDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                            <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="rdFromData" ControlToValidate="rdEndDate" Operator="GreaterThanEqual"
                                                ErrorMessage="To data must be greater" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                        </div>
                                    </div>
                                         <div class="col-lg-2" style="text-align: center; top: 19px; padding-top:15px;">
                                    <asp:LinkButton ID="lnkFilter" runat="server" BackColor="#DAE9F8"  ForeColor="#009EF7"   CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
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
                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" 
                                EnableHeaderContextMenu="true">
                                <Columns>

                                   <%-- <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="5px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                    </telerik:GridButtonColumn>--%>






                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Task Name" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                    </telerik:GridBoundColumn>
                                      <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                    </telerik:GridBoundColumn>


                                      <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="80px" HeaderText="Reference Image" HeaderStyle-Font-Size="Smaller"
                                                        HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="pp" runat="server" NavigateUrl=' <%# "../" + Eval("cst_ReferenceImage") %>' Target="_blank" >
                                                          <asp:Image  ID="itmImage" runat="server" ImageUrl=' <%# "../" + Eval("cst_ReferenceImage") %>'  Height="20px" width="20px" />
                                                                </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                     <telerik:GridBoundColumn DataField="DueDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Due Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="DueDate">
                                    </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="dph_Time" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Trans Time" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="dph_Time">
                                        </telerik:GridBoundColumn>


                                     <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="80px" HeaderText="Captured Image" HeaderStyle-Font-Size="Smaller"
                                                        HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="pp" runat="server" NavigateUrl=' <%# "../"+ Eval("cst_CapturedImage") %>' Target="_blank" >
                                                          <asp:Image  ID="itmImage" runat="server" ImageUrl=' <%# "../"+ Eval("cst_CapturedImage") %>'  Height="20px" width="20px"/>
                                                                </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                 <%--   <telerik:GridBoundColumn DataField="cst_CapturedTime" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Captured Time" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cst_CapturedTime">
                                    </telerik:GridBoundColumn>--%>
                                   
                                      <%--<telerik:GridBoundColumn DataField="cst_Desc" AllowFiltering="true" HeaderStyle-Width="20px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cst_Desc">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="cst_UserRemarks" AllowFiltering="true" HeaderStyle-Width="20px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="User Remarks" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cst_UserRemarks">
                                    </telerik:GridBoundColumn>
                                    
                                    <telerik:GridBoundColumn DataField="cst_Status" AllowFiltering="true" HeaderStyle-Width="20px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cst_Status">
                                    </telerik:GridBoundColumn>--%>
                                </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
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

