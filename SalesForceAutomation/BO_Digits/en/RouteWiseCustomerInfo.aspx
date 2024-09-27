<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteWiseCustomerInfo.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteWiseCustomerInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <asp:ImageButton ID="Excel" runat="server" ImageUrl="../assets/media/icons/excel.png" Style="height: 50px;" ToolTip="Download"
        OnClick="Excel_Click" AlternateText="Xlsx" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">



                    <%-- <div class="kt-portlet__head" style="padding-top: 8px; padding-bottom: 8px;">
                       

                     
                    </div>--%>



                    <!--begin::Form-->


                    <!--end: Search Form -->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                        <div class="card-body" style="background-color: white; padding: 20px;">

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


                                <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">


                                    <div class="col-lg-3 ">
                                        <label class="control-label col-lg-12">Route</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Width="100%" EnableCheckAllItemsCheckBox="true" CheckBoxes="true" RenderMode="Lightweight"></telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="dfs" runat="server" ControlToValidate="rdRoute" ForeColor="Red" ErrorMessage="<br/>Please Choose Route"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>












                                      <div class="col-lg-2" style="top: 10px; text-align: center; padding-top:15px;">
                                        <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filter_Click">
                                                    Apply Filter
                                        </asp:LinkButton>
                                    </div>

                                     <div class="col-lg-2" style="text-align: center; padding-top: 15px; width: auto;">
     <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" Visible="true">
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
                                        ShowFooter="false" DataKeyNames="rcs_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>




                                            <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Sales Man Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="csh_Code" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="HO Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="csh_Code">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="csh_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="HO Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="csh_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Address" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Address" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Address">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="CusType" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CusType">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_PaymentModes" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Payment Modes" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_PaymentModes">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Type" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Category Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Type">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="SpecialPrice" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Special Price" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="SpecialPrice">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Promotion" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Promotion" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Promotion">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="TotalCRlmt" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Total Credit Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="TotalCRlmt">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="UsedCRlimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Used Credit Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="UsedCRlimit">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="AvailabeCRlimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Available Credit Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="AvailabeCRlimit">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="UsedOrderCR" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Used Order Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="UsedOrderCR">
                                            </telerik:GridBoundColumn>





                                            <telerik:GridBoundColumn DataField="rcs_GraceAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Grace Amount" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_GraceAmount">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_GracePeriod" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Grace Period" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_GracePeriod">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_CreditDays" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Credit Days" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_CreditDays">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_IsCashPayEnable" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Cash Pay Enable" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsCashPayEnable">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="NoOfInvoice" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="No Of Invoice" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="NoOfInvoice">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_IsVAT" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="VAT Enable" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsVAT">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_IsHold" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Hold" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsHold">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_SelectionType" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Selection Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_SelectionType">
                                            </telerik:GridBoundColumn>




                                            <telerik:GridBoundColumn DataField="rcs_FencingRadius" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Fencing Radius" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_FencingRadius">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_OnCallFeatures" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="OnCall Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_OnCallFeatures">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="IsSalesOrder" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Sales Order" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsSalesOrder">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_IsSalesJob" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Sales Job" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsSalesJob">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="IsInvoicing_Sales" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Sales Invoicing" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_Sales">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="IsInvoicing_GR" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Good Return Invoicing" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_GR">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="IsInvoicing_BR" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Bad Return Invoicing" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_BR">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="IsInvoicing_FG" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Free of Cost Invoicing" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsInvoicing_FG">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="IsAR" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Account Receivables" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsAR">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="rcs_IsAdvPayment" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Advance Payment" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsAdvPayment">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="IsMerchandising" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Merchandising" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsMerchandising">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_VoidEnable" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Void Enable" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_VoidEnable">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_RoundAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Round Amount" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_RoundAmount">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_IsPrintOut" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Print Out" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsPrintOut">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="rcs_IsSignatureInvoice" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Signature Invoice" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsSignatureInvoice">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_IsSignatureAR" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Signature AR" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsSignatureAR">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rcs_IsRemarkInvoice" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Remarks" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsRemarkInvoice">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rcs_IsRemarkOrderReq" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Order Request Remarks" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsRemarkOrderReq">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rcs_IsOrderPromo" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Promotion in Order" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsOrderPromo">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rcs_IsFGExemption" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Free Good Exemption" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsFGExemption">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="rcs_ERPCusLocation" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="ERP Customer Location" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_ERPCusLocation">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Email" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Email" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Email">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="cus_Phone" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Phone" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Phone">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_RecaptureGeo" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Recapture Geocode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_RecaptureGeo">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Area" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Area" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Area">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Class" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Class" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Class">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_TRN" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="TRN" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_TRN">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="CusStatus" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CusStatus">
                                            </telerik:GridBoundColumn>





                                            <telerik:GridBoundColumn DataField="rotcusStatus" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Customer Setting" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rotcusStatus">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_MerchFeatures" AllowFiltering="true" HeaderStyle-Width="170px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Merchandising Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_MerchFeatures">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_MandFeatures" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Mandatory Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_MandFeatures">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_EnforceCustSelection" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Enforce Customer Selection" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnforceCustSelection">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_EnableOrderSign" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Enable Order Sign" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnableOrderSign">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_EnableSalesSign" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Enable Sales Sign" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnableSalesSign">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_InvoiceMode" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Invoice Mode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_InvoiceMode">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_IsAltInvReq" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Alternative Invoice Required" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsAltInvReq">
                                            </telerik:GridBoundColumn>




                                            <telerik:GridBoundColumn DataField="rcs_CusProfileSettings" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Profile Settings" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_CusProfileSettings">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_EnablePD" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Partial Delivery Settings" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnablePD">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_IsPriceChange" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Price Change" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsPriceChange">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_EnablePriceChange" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Price Change in Invoice" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnablePriceChange">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_EnableOrdPriceChange" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Price Change in Order" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnableOrdPriceChange">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="rcs_EInvoiceSend" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="E Invoice Send" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EInvoiceSend">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_EnableForecastSales" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Enable Forecast Sales" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnableForecastSales">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_EnableQuotation" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Enable Quotation" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnableQuotation">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="EnableSuggestedOrd" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Enable Suggested Order" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="EnableSuggestedOrd">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="IsActivityManagement" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Activity Management" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsActivityManagement">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="rcs_ActManageFeatures" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Activity Management Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_ActManageFeatures">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_AMMandFeatures" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Activity Management Mand.Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_AMMandFeatures">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="IsCustomerService" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Service" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="IsCustomerService">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_CusServiceFeatures" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Service Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_CusServiceFeatures">
                                            </telerik:GridBoundColumn>

                                           







                                            <telerik:GridBoundColumn DataField="rcs_CSMandFeatures" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Service Mand.Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_CSMandFeatures">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_FSFeatures" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Field Service Features" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_FSFeatures">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="MustSellItemCount" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Must Sell Item Count" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="MustSellItemCount">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="rcs_IsNegativeInvoiceAmt" AllowFiltering="true" HeaderStyle-Width="200px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Negative Invoice Amount" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_IsNegativeInvoiceAmt">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="EnableSuggestedLODReq" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Suggested Load Request" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="EnableSuggestedLODReq">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_GRSettings" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="GR Setting" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_GRSettings">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_BRSettings" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="BR Setting" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_BRSettings">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_MinInvoiceValue" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Min Invoice Value" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_MinInvoiceValue">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="rcs_EnableCusDocExpiryAlert" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Document Expiry Alert" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_EnableCusDocExpiryAlert">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="rcs_AlertDays" AllowFiltering="true" HeaderStyle-Width="200px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Alert Days" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_AlertDays">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_OrderMinValue" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Order Min Value" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_OrderMinValue">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_AR_HCRcpt_Img_Mand" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AR HC Receipt Img.Mandatory" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_AR_HCRcpt_Img_Mand">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_AR_POSRcpt_Img_Mand" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AR POS Receipt Img.Mandatory" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_AR_POSRcpt_Img_Mand">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_AR_OPRcpt_Img_Mand" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AR OP Receipt Img.Mandatory" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_AR_OPRcpt_Img_Mand">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="rcs_AR_CHRcpt_Img_Mand" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="AR Cheque Receipt Img.Mandatory" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_AR_CHRcpt_Img_Mand">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_INV_HCRcpt_Img_Mand" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Invoice HC Receipt Img.Mandatory" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_INV_HCRcpt_Img_Mand">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_INV_POSRcpt_Img_Mand" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Invoice POS Receipt Img.Mandatory" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_INV_POSRcpt_Img_Mand">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rcs_INV_OPRcpt_Img_Mand" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Invoice OP Receipt Img.Mandatory" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rcs_INV_OPRcpt_Img_Mand">
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


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>

