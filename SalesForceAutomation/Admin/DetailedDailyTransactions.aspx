<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="DetailedDailyTransactions.aspx.cs" Inherits="SalesForceAutomation.Admin.DetailedDailyTransactions" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function redirect() {
            var url = new URL(window.location.href);
            var c = url.searchParams.get("id");
            window.location.href = "UserDailyProcessDetail.aspx?Id=" + c;
        }
      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <div class="kt-portlet__head" style="padding-top: 20px">

                        <span class="kt-subheader__separator kt-hidden"></span>
                        <div class="kt-subheader__breadcrumbs">


                            <a href="UserDailyProcess.aspx" class="kt-subheader__breadcrumbs">
                                <i class="flaticon2-shelter"></i>User Daily Process </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a href="javascript:redirect();" class="kt-subheader__breadcrumbs-link">User Daily Process Detail </a>
                            <span class="kt-subheader__breadcrumbs-separator">></span>
                            <a class="kt-subheader__breadcrumbs-link">Customer Operations </a>

                            <!-- <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">Active link</span> -->
                        </div>
                    </div>
                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Daily Transactions - <asp:Label ID="lblType" runat="server" Font-Bold="true" ForeColor="Blue"></asp:Label>
                            </h3>
                        </div>
                        <div class="kt-portlet__head-actions">
                            <div class="row">
                                
                                <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="ImageButton4_Click" AlternateText="Xlsx" />
                                <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn" BackColor="#E2E5EE" OnClick="lnkCancel_Click" Style="padding-top: 14px;">Cancel</asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body pb-0">


                             <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">
                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid;">
                                                <table>
                                                    <td style="width: 56%">

                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Route:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Version:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblVersion" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        
                                                    </td>
                                                    <td>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Start Time:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">End Time:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        
                                                    </td>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        
                            
                           <%-- <div class="col-lg-12 row" style="padding-bottom: 30px;">

                                <div class="col-lg-3" style="padding-top: 8px;">
                                    <div class="col-lg-12">
                                        <label class="control-label col-lg-12 pl-0">Select Customer </label>
                                    </div>
                                    <div class="col-lg-12">
                                       <%-- <telerik:RadComboBox Skin="Material" Filter="Contains" CloseDropDownOnBlur="true" RenderMode="Lightweight"
                                            ID="ddlCustomer" runat="server"
                                            EmptyMessage="Select Customer" Width="100%">
                                        </telerik:RadComboBox>--%>
                                       <%-- <telerik:RadComboBox ID="ddlCustomer" runat="server" Filter="Contains" 
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  RenderMode="Lightweight" EmptyMessage="Select Customer" Width="100%">
                                        </telerik:RadComboBox>
                                    </div>
                                </div>
                                
                                <div class="col-lg-2" style="text-align: center; top: 25px;">
                                    <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-brand btn-elevate btn-icon-sm" OnClick="lnkFilter_Click">
                                                    Filter
                                    </asp:LinkButton>
                                </div>
                                
                               
                            </div>--%>

                         </div>

                            
                            <!-- ---------------------------- -->
                           

                            <!-- ---------------------------- -->




                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <div class="kt-portlet__body">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    OnPreRender="grvRpt_PreRender"
                                    AllowFilteringByColumn="false"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="50" CellSpacing="0">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="true" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="id"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                               <telerik:GridTemplateColumn HeaderStyle-Width="60px" UniqueName="detail" AllowFiltering="false" HeaderText="" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" >
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="assets/media/icons/svg/General/Clipboard.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                         <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Attachment" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="salImg" runat="server" NavigateUrl=' <%#  Eval("image") %>' Target="_blank" Visible="true">
                                                        <asp:Image ID="salImage" runat="server" ImageUrl=' <%#  Eval("image") %>' Height="65px" Visible="true" />
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                             <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Reciept image" UniqueName="RecImages" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="salRecImg" runat="server" NavigateUrl=' <%#  Eval("Recimage") %>' Target="_blank" Visible="true">
                                                        <asp:Image ID="salRecImage" runat="server" ImageUrl=' <%#  Eval("Recimage") %>' Height="65px" Visible="true" />
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
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
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                            </div>

                        </telerik:RadAjaxLoadingPanel>
                    </div>

                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body pb-0">

                            <div class="col-lg-12 row" style="padding-bottom: 30px;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
