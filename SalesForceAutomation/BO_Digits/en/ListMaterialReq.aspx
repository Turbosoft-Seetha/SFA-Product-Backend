<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListMaterialReq.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListMaterialReq" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

      <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
    
      <asp:LinkButton ID="lnkAddMR" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="lnkAddMR_Click">
                                                    Add
                            </asp:LinkButton>
     </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

     <div class="card-body p-8" style="background-color:white;">
           <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
           
                         <%-- Filter starts --%>
               <asp:PlaceHolder ID="pnlFilter" runat="server" Visible="true" >
                   <div class="col-lg-12 row mb-4">
                         <div class="col-lg-2">
            <label class="control-label col-lg-12">From Date</label>
            <div class="col-lg-12">
                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="col-lg-2">
            <label class="control-label col-lg-12">To Date</label>
            <div class="col-lg-12">
                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged">
                </telerik:RadDatePicker>
                <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                    Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
            </div>
        </div>
                       
                        <div class="col-lg-2">
                           <label class="control-label col-lg-12">Status</label>
                           <div class="col-lg-12">
                               <telerik:RadComboBox ID="rdStatus" runat="server" EmptyMessage="Select Status" Filter="Contains" Width="100%" RenderMode="Lightweight" AutoPostBack="true">
                                   <Items>
                                   
                                       <telerik:RadComboBoxItem Text="Pending" Value="P"/>
                                           <telerik:RadComboBoxItem Text="Approved" Value="A" />
                                        <telerik:RadComboBoxItem Text="Approved" Value="AH" />
                                         <telerik:RadComboBoxItem Text="Rejected" Value="R" />
                                   </Items>
                               </telerik:RadComboBox>
                           </div>
                       </div>
  
 
    <div class="col-lg-2 pt-5 mt-2" style="text-align: center; ">
        <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkFilter_Click">
                                            Apply Filter
        </asp:LinkButton>
    </div>

</div>
               </asp:PlaceHolder>

                         

                         <%-- Filter ends --%>

                         <%-- Grid starts --%>
                <div class="kt-form kt-form--label-right">
                            <div class="kt-portlet__body">
                           <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                           <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"                              
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="mrh_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        
                                         <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Detail">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="Detail" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                       
                                         <telerik:GridBoundColumn DataField="mrh_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="mrh_ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_ID" Display="false">
                                        </telerik:GridBoundColumn>
                                       
                                        <telerik:GridBoundColumn DataField="mrh_Number" AllowFiltering="true" HeaderStyle-Width="200px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Request ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_Number">
                                        </telerik:GridBoundColumn>
                                        
                                         <telerik:GridBoundColumn DataField="mrh_str_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="mrh_str_ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_str_ID" Display="false">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="str_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Receiving Location" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="str_Name">
                                         </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="mrh_war_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="mrh_war_ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_war_ID" Display="false">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="war_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Picking Location" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="war_Name">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="mrh_ExpDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Exp. Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_ExpDate">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="mrh_Status" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_Status">
                                        </telerik:GridBoundColumn>

                                       

                                        <telerik:GridBoundColumn DataField="mrh_IntegrationStatus" AllowFiltering="true" HeaderStyle-Width="200px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Integration Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_IntegrationStatus" Display="false">
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

                         <%-- Grid ends --%>

                         <%-- Dispatch button starts --%>
                
                           <div class="col-lg-12 pt-4" style="display:flex;justify-content:flex-end;">

                          
                            <div class="col-lg-1 pt-4">
                 </div>
                           
           <div class="col-lg-2 ps-12">
                                </div>
                     <div class="col-lg-2">
                          </div>      
                           
               </div>

                         <%-- Dispatch button ends --%>

           </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
     </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
