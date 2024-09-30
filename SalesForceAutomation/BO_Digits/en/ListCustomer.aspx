<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListCustomer.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListCustomer" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
     

     <asp:ImageButton ID="Excel" runat="server" ImageUrl="../assets/media/icons/excel.png" style="height: 50px; " ToolTip="Download" 
                                OnClick="Excel_Click" AlternateText="Xlsx" />
       <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">     
           <asp:LinkButton ID="lnkSettings" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Bulk Update" OnClick="lnkSettings_Click"></asp:LinkButton>
     <asp:LinkButton ID="lnkSubCat" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" OnClick="lnkSubCat_Click"></asp:LinkButton>
                 <asp:LinkButton ID="lnkReset" runat="server" CssClass="btn btn-sm fw-bold btn-secondary" Text="Reset" OnClick="lnkReset_Click" CausesValidation="False"></asp:LinkButton>

      </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>        
   </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
  </telerik:RadAjaxManager>
  <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
      <AjaxSettings>

          <telerik:AjaxSetting AjaxControlID="lnkReset">
              <UpdatedControls>
                  <telerik:AjaxUpdatedControl ControlID="grvRpt" />
          
              </UpdatedControls>
          </telerik:AjaxSetting>
  

      </AjaxSettings>
  </telerik:RadAjaxManagerProxy>

    <div class="card-body" style="padding: 20px; background-color: white;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <!--end: Search Form -->
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-portlet__body" style="margin-top:20px;">
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
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="cus_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                            </telerik:GridButtonColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="Location" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Location">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Location" ID="Location" Visible="true" AlternateText="Location" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Compass.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Asset" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Asset" Visible="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Asset" ID="Asset" Visible="false" AlternateText="Asset" runat="server"
                                                        ImageUrl="../assets/media/svg/general/assets.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="Documents" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Documents">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Documents" ID="Documents" Visible="true" AlternateText="Documents" runat="server"
                                                        ImageUrl="../assets/media/svg/files/File.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="Route" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Documents">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Route" ID="Route" Visible="true" AlternateText="Route" runat="server" Width="20px"
                                                        ImageUrl="../assets/media/svg/general/Group 2096.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="Special Price" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="SpecialPrice">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="SpecialPrice" ID="SpecialPrice" Visible="true" AlternateText="SpecialPrice" runat="server"
                                                        ImageUrl="../assets/media/svg/general/pricing.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="Promotion" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Promotion">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Promotion" ID="Promotion" Visible="true" AlternateText="Promotion" runat="server"
                                                        ImageUrl="../assets/media/svg/general/promotion.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>                                           
                                                                         
                                            <telerik:GridBoundColumn DataField="csh_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="HO Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="csh_Code">
                                            </telerik:GridBoundColumn>    

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="200px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Name Arabic" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="com_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Company Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="com_Code">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="com_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" Company Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="com_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_ShortName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Short Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_ShortName" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Type" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Type">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Address" AllowFiltering="true" HeaderStyle-Width="200px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Address" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Address">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_AddressArabic" AllowFiltering="true" HeaderStyle-Width="140px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Address Arabic" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_AddressArabic" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Email" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Email" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Email">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_Phone" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Phone" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Phone">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_WhatsappNumber" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Whatsapp No" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_WhatsappNumber">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_ContactPerson" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Contact Person" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_ContactPerson">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_ContactPerson_ar" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Contact Person Arabic" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_ContactPerson_ar" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_GeoCode" AllowFiltering="true" HeaderStyle-Width="160px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="GeoCode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_GeoCode" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="GeoCode" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Map" ID="RadImageButton3" Visible="true" AlternateText="Map" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Compass.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                              <telerik:GridBoundColumn DataField="cus_RecaptureGeo" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Recapture GeoCode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_RecaptureGeo">
                                            </telerik:GridBoundColumn>
                                            <%--<telerik:GridBoundColumn DataField="cus_TotalCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Total Cr.Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_TotalCreditLimit">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_UsedCreditLimit" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Used Cr.Limit" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_UsedCreditLimit">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cus_CreditDays" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Credit Days" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_CreditDays">
                                            </telerik:GridBoundColumn>--%>
                                            <telerik:GridBoundColumn DataField="cus_IsVATEnabled" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText=" VAT Enabled" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_IsVATEnabled">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="are_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Area" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_are_Name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="cls_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Class" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cls_Name">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="cus_AltHOCode" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Alternative HOCode" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_AltHOCode">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="TRN_Number" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="TRN Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="TRN_Number">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Modified By" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                    </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Modified Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
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
                            </div>
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
    </div>
</asp:Content>
