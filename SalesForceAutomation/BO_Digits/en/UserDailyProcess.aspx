<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="UserDailyProcess.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.UserDailyProcess" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function MerchModal() {
            $('#kt_modal_1_9').modal('show');
        }
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function Failure(b) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#Failure').text(b);
        }
    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">


   
     
    
        <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
        
            
            <asp:LinkButton ID="lnkPrevious"  runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkPrevious_Click">
            <asp:Image ID="Image2" runat="server" ImageUrl="../assets/media/icons/arr002.svg" Height="20" />
            </asp:LinkButton>
     
        <asp:LinkButton ID="lnkTodayDate"  runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkTodayDate_Click">
                                                    Today
                                        </asp:LinkButton>

            <asp:LinkButton ID="lnkNextDay"  runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkNextDay_Click">
            <asp:Image ID="Image1" runat="server" ImageUrl="../assets/media/icons/arr001.svg" Height="20" />
            </asp:LinkButton>
     
      </telerik:RadAjaxPanel>

      <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>


    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="lnkFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UserDailyProcessRprts" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="lblNotCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="lnkTotCount">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="lnkCompleted">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="lnkNotCompleted">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="lnkPrevious">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdfromDate" />
                </UpdatedControls>
                 <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdendDate" />
                </UpdatedControls>
                 <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UserDailyProcessRprts" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="lblNotCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkNextDay">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdfromDate" />
                </UpdatedControls>
                 <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdendDate" />
                </UpdatedControls>
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UserDailyProcessRprts" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="lblNotCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkTodayDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdfromDate" />
                </UpdatedControls>
                 <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdendDate" />
                </UpdatedControls>
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UserDailyProcessRprts" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalCount" />
                    <telerik:AjaxUpdatedControl ControlID="lblCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="lblNotCompleted" />
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            

             <%--<telerik:AjaxSetting AjaxControlID="Endday">
                 <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="modalConfirm" />
                      <telerik:AjaxUpdatedControl ControlID="ddlRot" />
                     <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                 </UpdatedControls>
             </telerik:AjaxSetting>--%>

        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>

    <script type="text/javascript" src="../assets/Chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">


                <!--end: Search Form -->

                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                <div class="card-body" style="background-color: white; padding: 20px;">
                   

                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                         <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                    <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false" >
                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">Region</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddlregion" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
                                        <label class="control-label col-lg-12">Depot</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                RenderMode="Lightweight"
                                                ID="ddldepot" runat="server" EmptyMessage="Select Depot"
                                                OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
                                        <label class="control-label col-lg-12">Area</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldpoArea" runat="server" EmptyMessage="Select Area"
                                                OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
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
                            <div class="col-lg-3">
                                <label class="control-label col-lg-12">Route Type</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlRotType" runat="server" Width="80%" EmptyMessage="Select Route Type" Filter="Contains" RenderMode="Lightweight" OnSelectedIndexChanged="ddlRotType_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <label class="control-label col-lg-12">Route</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                        ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true" Width="100%">
                                    </telerik:RadComboBox>

                                </div>
                            </div>

                                    <div class="col-lg-2 ">
                                        <label class="control-label col-lg-12">From Date</label>
                                        <div class="col-lg-10">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 ">
                                        <label class="control-label col-lg-12">To Date</label>
                                        <div class="col-lg-10">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px;">
                                        <asp:LinkButton ID="Filter"  runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                        </asp:LinkButton>
                                    </div>
                                    <%--<div class="col-lg-2" style="text-align: center; padding-top: 15px;">
                                        <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click">
                                                    Advanced Filter
                                        </asp:LinkButton>
                                    </div>--%>
                                     <div class="col-lg-1" style="top: 10px; text-align: center; padding-top: 15px; width: auto;">
       <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

     <asp:LinkButton ID="EndDay" runat="server" CssClass="btn btn-sm btn-danger me-2" BackColor="#f8d8de" ForeColor="#f90f56" CausesValidation="false" OnClick="EndDay_Click">
                                Pending EndDay
     </asp:LinkButton>
  </telerik:RadAjaxPanel>
  <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
      BackColor="Transparent"
      ForeColor="Blue">
      <div class="col-lg-12 text-center mt-5">
          <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
      </div>
  </telerik:RadAjaxLoadingPanel>
 </div>


                                </div>
                         <div class="col-lg-12 row mb-4">
            <div class="col-lg-4" style="background-color: #d6d6f3;border-radius: 25px;">
                 <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                     <asp:LinkButton runat="server" ID="lnkTotCount" OnClick="lnkTotCount_Click">
                    <div class="col-lg-12 m-2" style="display: flex;">
   
                            <div class="col-lg-6" style="display:inline-flex;justify-content:center">

                                <small style="font-family: 'Segoe UI';color:black; font-size:x-large;">Total</small>
                            </div>

                            <div class="col-lg-6" style="display:inline-flex;justify-content:center">

                                <asp:Label ID="lblTotalCount" runat="server" Style="font-family: 'Segoe UI';color:black;" Font-Size="X-Large" Font-Bold="true" Text="0"></asp:Label>

                            </div>
   
                    </div>
                          </asp:LinkButton>
                         </telerik:RadAjaxPanel>
                
            </div>
            <div class="col-lg-4" style="background-color: #c0f0b0; border-radius: 25px;">
                 <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                     <asp:LinkButton runat="server" ID="lnkCompleted" OnClick="lnkCompleted_Click">
                    <div class="col-lg-12 m-2" style="display: flex;">
   
                            <div class="col-lg-6" style="display:inline-flex;justify-content:center">

                                <small style="font-family: 'Segoe UI';color:black;font-size:x-large;">Completed</small>
                            </div>

                            <div class="col-lg-6" style="display:inline-flex;justify-content:center">

                                <asp:Label ID="lblCompleted" runat="server" Style="font-family: 'Segoe UI';color:black;" Font-Size="X-Large" Font-Bold="true" Text="0"></asp:Label>

                            </div>
   
                    </div>
                          </asp:LinkButton>
                         </telerik:RadAjaxPanel>
            </div>
            <div class="col-lg-4" style="background-color: #f1d3d2; border-radius: 25px;">

                 <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                     <asp:LinkButton runat="server" ID="lnkNotCompleted" OnClick="lnkNotCompleted_Click">
                    <div class="col-lg-12 m-2" style="display: flex;">
   
                        <div class="col-lg-6" style="display:inline-flex;justify-content:center">

                            <small style="font-family: 'Segoe UI'; color:black; font-size:x-large;">Not Completed</small>
                        </div>
                        <div class="col-lg-6" style="display:inline-flex;justify-content:center">

                            <asp:Label ID="lblNotCompleted" runat="server" Style="font-family: 'Segoe UI';color:black;" Font-Size="X-Large" Font-Bold="true" Text="0"></asp:Label>

                        </div>
  
                </div>
                       </asp:LinkButton>
                     </telerik:RadAjaxPanel>
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
                            AllowPaging="true" PageSize="10" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="udp_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>



                                    <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="Detail" ID="Rad1" Visible="true" ToolTip="Details" CommandArgument='<%# Eval("rot_ID")%>' AlternateText="Detail" runat="server"
                                                ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Map" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="map" ID="RadImageButton3" Visible="true" height="25" ToolTip="Map" AlternateText="Map" runat="server" 
                                                ImageUrl="../assets/media/UDP/tracking.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="Settlement" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="Settlement" ID="RadImageButton2" Visible="true"  ToolTip="Settlement" AlternateText="Settlement" runat="server"
                                                ImageUrl="../assets/media/svg/general/settlement.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                      <telerik:GridTemplateColumn HeaderStyle-Width="45px" AllowFiltering="false" HeaderText="Van Stock" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="VanStock" ID="btnVanstock" Visible="true"  ToolTip="Current VanStock" CommandArgument='<%# Eval("rot_ID")%>' AlternateText="VanStock" runat="server" Height="30"
                                                ImageUrl="../assets/media/svg/general/vanstock.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="110px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>      
                                    
                                     <telerik:GridBoundColumn DataField="Type" AllowFiltering="true" HeaderStyle-Width="110px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Type" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Type">
                                    </telerik:GridBoundColumn>      

                                    <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="User " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Helper1" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Helper-1 " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Helper1">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Helper2" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Helper-2 " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Helper2">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="veh_Number" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Vehicle No" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="veh_Number">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="udp_IsAppProcessComplete" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="App Process" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_IsAppProcessComplete">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsSettlementInitiated" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Settlement Initiation" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="IsSettlementInitiated">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="udp_SettlementStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Settlement" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_SettlementStatus">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="udp_StartTime" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Start Time" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_StartTime">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="udp_LoadOutStatus" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_LoadOutStatus" Display="false">
                                    </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_EndDayStatus" Display="false">
                                    </telerik:GridBoundColumn>

                                    <%--<telerik:GridBoundColumn DataField="udp_StartTime" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartTime">
                                        </telerik:GridBoundColumn>--%>

                                    <%--<telerik:GridBoundColumn DataField="udp_StartDayStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Start Day Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartDayStatus">
                                        </telerik:GridBoundColumn>--%>

                                    <%-- <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Day Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_EndDayStatus">
                                        </telerik:GridBoundColumn>--%>

                                    <%--<telerik:GridBoundColumn DataField="udp_TotalCashCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Cash Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalCashCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_TotalArCashCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total AR Cash Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalArCashCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_TotalAmountCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Amount Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalAmountCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>--%>

                                    <%--<telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>--%>

                                    <telerik:GridBoundColumn DataField="udp_EndTime" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="End Time" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_EndTime">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Duration" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Duration" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Duration">
                                    </telerik:GridBoundColumn>

                                    <%--                                        <telerik:GridBoundColumn DataField="udp_StartOdoMeter" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Start<br>OdoMeter" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartOdoMeter" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_EndOdoMeter" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End OdoMeter" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_EndOdoMeter">
                                        </telerik:GridBoundColumn>--%>


                                    <telerik:GridBoundColumn DataField="udp_VersionNumber" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Version" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_VersionNumber">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="udp_LogFile" UniqueName="udp_LogFile" AllowFiltering="false"
                                        HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Log File"
                                        HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="pp" runat="server"
                                                ImageUrl="../assets/media/svg/files/File.svg" NavigateUrl='<%# Eval("udp_LogFile")%>' Height="50" Width="50" Target="_blank">
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                     <telerik:GridTemplateColumn DataField="udp_DataBase" UniqueName="udp_DataBase" AllowFiltering="false"
                                            HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="DataBase"
                                            HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="ps" runat="server"
                                                    ImageUrl="../assets/media/icons/svg/Files/database.png" NavigateUrl='<%#Eval("udp_DataBase")%>' Height="50" Width="50" Target="_blank">
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="rot_Type" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Route Type" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Type" Display="false">
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
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>

                </div>

            </div>
        </div>
    </div>
         <div class="clearfix"></div>
 <!--begin::UpdateModal-->
 <div class="modal fade" id="modalConfirm" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content mt-8" style="width: 900px;">
              <div class="modal-header">
                 <h5 class="modal-title">EndDay Pending</h5>
             </div>
             <div class="modal-body pb-0">
                 <span></span>
               
                     <div class="col-lg-12 pt-4 mb-2">
                          <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                     <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                         ID="RadGrid1" GridLines="None"
                         ShowFooter="True" AllowSorting="True"
                         OnNeedDataSource="RadGrid1_NeedDataSource"
                         AllowFilteringByColumn="true"
                         ClientSettings-Resizing-ClipCellContentOnResize="true"
                         EnableAjaxSkinRendering="true"
                         AllowPaging="true" PageSize="50" CellSpacing="0">
                         <ClientSettings>
                             <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="310px"></Scrolling>
                         </ClientSettings>
                         <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                             ShowFooter="false" DataKeyNames="udp_ID"
                             EnableHeaderContextMenu="true">
                             <Columns>

                                  <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll"></telerik:GridClientSelectColumn>

                                  <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                     HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                     HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                 </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route Name" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                     HeaderStyle-Font-Size="Smaller" HeaderText="Pending On" FilterControlWidth="100%"
                                     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                     HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
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
                         </telerik:RadAjaxPanel>
                         <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                             BackColor="Transparent"
                             ForeColor="Blue">
                             <div class="col-lg-12 text-center mt-5">
                                 <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                             </div>
                         </telerik:RadAjaxLoadingPanel>
                 </div>
                
             </div>

             <div class="modal-footer pt-0">
                  
                     <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">

                         <asp:LinkButton ID="lnkEndday" runat="server" CssClass="btn btn-sm fw-bold btn-primary" ValidationGroup="frm" CausesValidation="true" OnClick="lnkEndday_Click">
                                                   EndDay
                         </asp:LinkButton>
                     </telerik:RadAjaxPanel>
                     <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                         BackColor="Transparent"
                         ForeColor="Blue">
                         <div class="col-lg-12 text-center mt-5">
                             <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                         </div>
                     </telerik:RadAjaxLoadingPanel>
                     <br />
                     <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
              
             </div>
         </div>
     </div>
 </div>
 <!--end::UpdateModal-->

 <!--begin::SuccessModal-->
 <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title">Success</h5>
             </div>
             <div class="modal-body">
                 <span id="success"></span>
             </div>
             <div class="modal-footer">
                 <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary" CausesValidation="false">OK</asp:LinkButton>
             </div>
         </div>
     </div>
 </div>
 <!--end::SuccessModal-->

 <!--begin::FailedModal-->
 <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title">Oops..!</h5>
             </div>
             <div class="modal-body">
                 <span id="Failure"></span>
             </div>
             <div class="modal-footer">
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>


             </div>
         </div>
     </div>
 </div>

 <!--end::FailedModal-->


    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Merchandising Route..!</h5>
                </div>
                <div class="modal-body">
                    <span>It is a merchandising route and hence can not do settlement.</span>
                </div>
                <div class="modal-footer">
                      <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">Ok</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
