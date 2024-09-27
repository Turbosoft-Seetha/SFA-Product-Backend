<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OutstandingDashboard.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OutstandingDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript" src="../assets/Chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <div class="container">
    <div class="row">
        <div class="col-lg-3">
            <label class="control-label">Status</label>
            <div>
                <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Material" RenderMode="Lightweight">
                    <Items>
                        <telerik:RadComboBoxItem Text="All Invoices" Value="A" Selected="true" />
                        <telerik:RadComboBoxItem Text="Due" Value="D" />
                        <telerik:RadComboBoxItem Text="OverDue" Value="O" />
                    </Items>
                </telerik:RadComboBox>
            </div>
        </div>

        <div class="col-lg-3">
            <label class="control-label">Route</label>
            <div>
                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                    ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                </telerik:RadComboBox>
            </div>
        </div>

        <div class="col-lg-3">
            <label class="control-label">Customers</label>
            <div>
                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                    ID="rdCustomer" runat="server" EmptyMessage="Select Customer" AutoPostBack="true">
                </telerik:RadComboBox>
            </div>
        </div>

        <div class="col-lg-3 d-flex align-items-end">
            <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                Apply Filter
            </asp:LinkButton>

            <!-- Excel icon -->
            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Style="height: 50px; width: 50px; margin-left: 5px;" ToolTip="Download Excel" OnClick="imgExcel_Click" AlternateText="Excel" />
        </div>
    </div>
</div>


 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="col-lg-12 row">
                <div class="col-lg-7 row">
                    <!--begin::Charts Widget 3-->

                    <div class="card custom-small-card" style="background-color: white; ">
                        <!--begin::Header-->
                        <div class="card-header border-0 pt-5">

                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label fw-bold fs-3 mb-1" style="font-family: 'Segoe UI';">Total Outstanding</span>
                            </h3>
                            <div class="card-toolbar">
                                <h6 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">
                                        <asp:Label ID="lbltotcount" Text="0" runat="server" Font-Bold="true" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                </h6>
                                <h6 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">
                                        <asp:Label ID="Label1" Text="/" runat="server" Font-Bold="true" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                </h6>
                                <h6 class="card-title align-items-start flex-column">
                                    <span class="card-label fw-bold fs-3 mb-1">
                                        <asp:Label ID="lbltotamnt" Text="0" runat="server" Font-Bold="true" Style="font-family: 'Segoe UI';"></asp:Label></span>
                                </h6>
                            </div>


                        </div>
                        <!--end::Header-->
                        <div class="col-xl-12 row">
                            <div class="col-xl-6">
                                <!--begin::Body-->
                                <div class="card-body">
                                    <div class="chartBox" style="height:150px;width:150px;">
                                        <!--begin::Chart-->
                                        <canvas id="OutstandingRprts"></canvas>
                                        <!--end::Chart-->
                                    </div>
                                </div>
                                <!--end::Body-->
                            </div>
                            <div class="col-xl-6" style="padding-top: 4rem;">

                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-3">
                                      <img src="../assets/media/dashboard/KPI/Pills/Rectangle -1.png" height="20" />
                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">Due</small>
                                    </div>

                                    <div class="col-lg-6">

                                        <asp:Label ID="lblDueCount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="10"></asp:Label>

                                        <asp:Label ID="Label3" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="/"></asp:Label>

                                        <asp:Label ID="lblDueAmount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="200"></asp:Label>


                                    </div>
                                </div>

                                <div class="col-lg-12" style="display: flex; margin-top: 5%">
                                    <div class="col-lg-3">
                                        <img src="../assets/media/dashboard/KPI/Pills/li_completed.png" height="20" />
                                    </div>
                                    <div class="col-lg-4">

                                        <small style="font-family: 'Segoe UI';">Over Due </small>
                                    </div>
                                    <div class="col-lg-6 ">

                                        <asp:Label ID="lblOvrDueCount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="10"></asp:Label>

                                        <asp:Label ID="Label5" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="/"></asp:Label>

                                        <asp:Label ID="lblOvrDueAmount" runat="server" Style="font-family: 'Segoe UI';" Font-Size="medium" Font-Bold="true" Text="200"></asp:Label>


                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>
                     
                    <!--end::Charts Widget 3-->
                </div>
            </div>            

                 </div>
             <div class="col-lg-12 row" style="padding: 10px; background-color: white; margin-top: 20px">
               
                  <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
 <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
     ID="grvRpt" GridLines="None"
     ShowFooter="True" AllowSorting="True"
     OnNeedDataSource="grvRpt_NeedDataSource"
     OnItemCommand="grvRpt_ItemCommand"
     AllowFilteringByColumn="true"
     ClientSettings-Resizing-ClipCellContentOnResize="true"
     EnableAjaxSkinRendering="true"
     AllowPaging="true" PageSize="50" CellSpacing="0">
     <ClientSettings>
         <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="400px" ></Scrolling>
     </ClientSettings>
     <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
         ShowFooter="false" DataKeyNames="oid_ID"
         EnableHeaderContextMenu="true">
         <Columns>
              

                    <telerik:GridBoundColumn DataField="InvoiceID" AllowFiltering="true" HeaderStyle-Width="130px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Invoice ID" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="InvoiceID">
             </telerik:GridBoundColumn>

              <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                    HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                    HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
             </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="csh_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="HO Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="csh_Code">
             </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="csh_Name" AllowFiltering="true" HeaderStyle-Width="200px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="HO Name" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="csh_Name">
             </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Outlet Code" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
             </telerik:GridBoundColumn>
               <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="200px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Outlet Name" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
            </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="cus_CreditDays" AllowFiltering="true" HeaderStyle-Width="120px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Credit Days" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="cus_CreditDays">
            </telerik:GridBoundColumn>
               <telerik:GridBoundColumn DataField="InvoicedOn" AllowFiltering="true" HeaderStyle-Width="130px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Invoiced On" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="InvoicedOn">
             </telerik:GridBoundColumn>
             <telerik:GridBoundColumn DataField="InvoiceAmount" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Amount" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="InvoiceAmount">
                 <ItemStyle HorizontalAlign="Right" />
                 <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>
            
               <telerik:GridBoundColumn DataField="AmountPaid" AllowFiltering="true" HeaderStyle-Width="120px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Amount Paid" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="AmountPaid">
                   <ItemStyle HorizontalAlign="Right" />
                 <HeaderStyle HorizontalAlign="Right" />
             </telerik:GridBoundColumn>
             
                <telerik:GridBoundColumn DataField="InvoiceBalance" AllowFiltering="true" HeaderStyle-Width="120px"
              HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Balance" FilterControlWidth="100%"
              CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
              HeaderStyle-Font-Bold="true" UniqueName="InvoiceBalance">
                  <ItemStyle HorizontalAlign="Right" />
                 <HeaderStyle HorizontalAlign="Right" />
          </telerik:GridBoundColumn>

          <%--  <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="130px"
              HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
              CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
              HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
          </telerik:GridBoundColumn>--%>


              <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Status">
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
    <style>
    .custom-canvas {
        width: 130px;
        height: 130px;
    }
</style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
