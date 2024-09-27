<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SpecialPriceAssignedCustomers.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SpecialPriceAssignedCustomers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

<asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download"
                                OnClick="ImageButton4_Click" AlternateText="Xlsx" />
</asp:Content>
    

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                       



                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                            <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">



                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12 w-100" >Special Price </label>
                                    <div class="col-lg-12">
                                         <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="rdsprice" runat="server" EmptyMessage="Select Special Price"  Width="150%">
                                            </telerik:RadComboBox>
                                      
                                    </div>
                                </div>

                              

                               

                              

                                <div class="col-lg-4" style="top: 10px; text-align: center; padding-top: 13px;">
                                    <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="Filter_Click" CausesValidation="true" ValidationGroup="form">
                                                    Apply Filter
                                    </asp:LinkButton>
                                </div>



                            </div>
                        </div>
                        <%-- strat form --%>
                        <div class="col-lg-12 row">


                            <div class="col-lg-12">

                                <!--begin::Portlet-->
                                <div class="kt-portlet">

                                    <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                        <div class="col-lg-10">
                                            <h3 class="kt-portlet__head-title"> Assigned Customer
                                            </h3>
                                        </div>
                                     
                                    </div>

                                    <!--begin::Form-->
                                    <div class="kt-form kt-form--label-right">
                                        <div class="kt-portlet__body">
                                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                            <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                ID="RadGrid1" GridLines="None"
                                                ShowFooter="True" AllowSorting="True"
                                                OnNeedDataSource="RadGrid1_NeedDataSource"
                                                AllowFilteringByColumn="true"
                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                EnableAjaxSkinRendering="true"
                                                AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                    ShowFooter="false" DataKeyNames="prh_ID"
                                                    EnableHeaderContextMenu="true">
                                                    <Columns>

                                                      

                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                        </telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                        </telerik:GridBoundColumn>
                                                          <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                        </telerik:GridBoundColumn>
                                                          <telerik:GridBoundColumn DataField="crp_StartDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="From Date" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="crp_StartDate">
                                                        </telerik:GridBoundColumn>
                                                          <telerik:GridBoundColumn DataField="crp_EndDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Date" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="crp_EndDate">
                                                        </telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="PayMode" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="PayMode" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="PayMode">
                                                        </telerik:GridBoundColumn>
                                                         <telerik:GridBoundColumn DataField="prh_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pricing Code" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_Code">
                                                        </telerik:GridBoundColumn> 
                                                        <telerik:GridBoundColumn DataField="prh_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pricing Name" FilterControlWidth="100%"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                            HeaderStyle-Font-Bold="true" UniqueName="prh_Name">
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

                                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                                BackColor="Transparent"
                                                ForeColor="Blue">
                                                <div class="col-lg-12 text-center">
                                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                </div>
                                            </telerik:RadAjaxLoadingPanel>
                                        </div>
                                    </div>

                                </div>
                            </div>
                           
                        </div>
                        <%-- End form --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
