<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewProducts.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50px" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <!--begin::Form-->


                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        OnItemCommand="grvRpt_ItemCommand"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="prd_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="منظر" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="View">

                                                    <ItemTemplate>
                                                        <asp:LinkButton CommandName="Edit" ID="view" Visible="true" runat="server" Height="20px" Width="20px">
                                                   <svg xmlns="http://www.w3.org/2000/svg" width="22" height="15" viewBox="0 0 22 15">
                                                    <g id="Group_6028" data-name="Group 6028" transform="translate(-10731 2571)">
                                                        <path id="Path_1810" data-name="Path 1810" d="M12,4.5A11.827,11.827,0,0,0,1,12a11.817,11.817,0,0,0,22,0A11.827,11.827,0,0,0,12,4.5ZM12,17a5,5,0,1,1,5-5A5,5,0,0,1,12,17Z" transform="translate(10730 -2575.5)" fill="#d6d6da" />
                                                        <ellipse id="Ellipse_418" data-name="Ellipse 418" cx="3" cy="3.5" rx="3" ry="3.5" transform="translate(10739 -2567)" fill="#b5b5c3" />
                                                    </g>
                                                </svg>  
                                                        </asp:LinkButton>

                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText=" شفرة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="180px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText=" اسم" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="الاسم العربي" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_NameArabic">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="فئة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="cat_NameArabic" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="اسم التصنيف بالعربي" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_NameArabic">
                                                </telerik:GridBoundColumn>
                                                  <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تصنيف فرعي" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sct_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="اسم التصنيف الفرعي باللغة العربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_NameArabic">
                                                </telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="ماركة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="brd_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="اسم العلامة التجارية باللغة العربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="brd_NameArabic">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_ReturnDays" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="أيام العودة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_ReturnDays">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_ItemLongDesc" AllowFiltering="true" HeaderStyle-Width="200px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="الوصف الطويل للعنصر" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_ItemLongDesc">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="prd_ArabicItemLongDesc" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وصف مطول للمادة باللغة العربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_ArabicItemLongDesc">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="حالة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Status" Visible="true">
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
