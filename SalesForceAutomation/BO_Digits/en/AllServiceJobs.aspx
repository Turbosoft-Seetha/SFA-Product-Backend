﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AllServiceJobs.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AllServiceJobs" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    
   </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    

    <div class="card-body" style="background-color:white; padding:20px;">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">                  
                        
                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">

                        <div class="kt-portlet__body">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px">
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
        <div class="col-lg-2">
            <label class="control-label col-lg-12">Assigned Route</label>
            <div class="col-lg-12">
                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" Width="100%"
                    ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" AutoPostBack="true">
                </telerik:RadComboBox>

            </div>
        </div>



        <div class="col-lg-2">
            <label class="control-label col-lg-12">Customer</label>
            <div class="col-lg-12">
                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" Width="100%"
                    ID="rdCustomer" runat="server" EmptyMessage="Select Customer" OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" AutoPostBack="true">
                </telerik:RadComboBox>

            </div>
        </div>
         <div class="col-lg-2 ">
     <label class="control-label col-lg-12">From Date</label>
     <div class="col-lg-12">
         <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"  Width="100%" AutoPostBack="true" OnSelectedDateChanged="rdfromDate_SelectedDateChanged">
         </telerik:RadDatePicker>
     </div>
 </div>

 <div class="col-lg-2">
     <label class="control-label col-lg-12">To Date</label>
     <div class="col-lg-12">
         <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"  Width="100%" AutoPostBack="true" OnSelectedDateChanged="rdendDate_SelectedDateChanged">
         </telerik:RadDatePicker>
         <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
             Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
     </div>
 </div>

        <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px; ">
            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkFilter_Click">
                            Apply Filter
            </asp:LinkButton>
        </div>
        <div class="col-lg-2" style="text-align: center; padding-top: 15px;">
            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" CausesValidation="false" OnClick="lnkAdvFilter_Click" Visible="false">
                            Advanced Filter
            </asp:LinkButton>
        </div>


    </div>
</div>

                        
                                                  <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />                         
   <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
    ID="RadGridServiceJob" GridLines="None"
     AllowSorting="True"
    OnNeedDataSource="RadGridServiceJob_NeedDataSource"
      OnItemCommand="RadGridServiceJob_ItemCommand"
       OnItemDataBound="RadGridServiceJob_ItemDataBound"
    AllowFilteringByColumn="true"
 ClientSettings-Resizing-ClipCellContentOnResize="true"
 EnableAjaxSkinRendering="true"
 AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
 <ClientSettings>
     <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
 </ClientSettings>
 <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
     ShowFooter="false" DataKeyNames="sjh_ID"
     EnableHeaderContextMenu="true">
     <Columns>
         
          <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
     <ItemTemplate>
         <asp:ImageButton CommandName="Detail" ID="RadDetail" Visible="true" AlternateText="Detail" runat="server"
             ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
     </ItemTemplate>
 </telerik:GridTemplateColumn>
                  <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="RequiredParts" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
    <ItemTemplate>
        <asp:ImageButton CommandName="ReqParts" ID="RadReqParts" Visible="true" AlternateText="Detail" runat="server"
            ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
    </ItemTemplate>
</telerik:GridTemplateColumn>
         
         <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Invoice" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
    <ItemTemplate>
        <asp:ImageButton CommandName="Invoice" ID="RadInvoice" Visible="true" AlternateText="Invoice" runat="server"
            ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
    </ItemTemplate>
</telerik:GridTemplateColumn>
        

                            
              <telerik:GridBoundColumn DataField="sjh_Number" AllowFiltering="true" HeaderStyle-Width="100px"
      HeaderStyle-Font-Size="Smaller" HeaderText="Job ID" FilterControlWidth="100%"
      CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
      HeaderStyle-Font-Bold="true" UniqueName="sjh_Number">
  </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="snr_Code" AllowFiltering="true" HeaderStyle-Width="100px"
    HeaderStyle-Font-Size="Smaller" HeaderText="Request ID" FilterControlWidth="100%"
    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
    HeaderStyle-Font-Bold="true" UniqueName="snr_Code">
</telerik:GridBoundColumn>

           <telerik:GridBoundColumn DataField="snr_rot_ID" AllowFiltering="true" HeaderStyle-Width="100px"
    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
    HeaderStyle-Font-Bold="true" UniqueName="snr_rot_ID">
</telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="Customer" AllowFiltering="true" HeaderStyle-Width="100px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="Customer">
            </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Date" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
            </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="Route" AllowFiltering="true" HeaderStyle-Width="100px"
                 HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Route" FilterControlWidth="100%"
                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                 HeaderStyle-Font-Bold="true" UniqueName="Route">
             </telerik:GridBoundColumn>

            <telerik:GridBoundColumn DataField="ScheduledDate" AllowFiltering="true" HeaderStyle-Width="80px"
                HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled Date" FilterControlWidth="100%"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                HeaderStyle-Font-Bold="true" UniqueName="ScheduledDate">
            </telerik:GridBoundColumn>

             <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
     HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
     HeaderStyle-Font-Bold="true" UniqueName="Status">
 </telerik:GridBoundColumn>

          <telerik:GridBoundColumn DataField="inv_ID" AllowFiltering="true" HeaderStyle-Width="80px"
     HeaderStyle-Font-Size="Smaller" HeaderText="inv_ID" FilterControlWidth="100%"
     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
     HeaderStyle-Font-Bold="true" UniqueName="inv_ID" Display="false">
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
                         <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
        </div>
    </div>
    </div>

     <!--begin::QuestionModal-->
    <!--end::QuestionModal-->
</asp:Content>