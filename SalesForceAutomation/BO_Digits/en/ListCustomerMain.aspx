<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListCustomerMain.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListCustomerMain" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
 <asp:LinkButton ID="lnkAdd" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="lnkAdd_Click">
                                                    Add
    </asp:LinkButton>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <!--begin::Portlet-->
            <div class="kt-portlet" style="background-color: white; padding: 20px;">



                <!--begin::Form-->
                <div class="kt-form kt-form--label-right">
                    <div class="kt-portlet__body">
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
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
                                ShowFooter="false" DataKeyNames="cum_ID"
                                EnableHeaderContextMenu="true">

                                <Columns>

                                    <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                    </telerik:GridButtonColumn>


                                    <telerik:GridBoundColumn DataField="cum_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cum_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cum_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Name" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cum_Name">
                                    </telerik:GridBoundColumn>


                                      <telerik:GridBoundColumn DataField="cum_NameArabic" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Arabic Name" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cum_NameArabic">
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

                                    <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Created Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Modified By" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Modified Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Status">
                                    </telerik:GridBoundColumn>

                                    


                                </Columns>
                            </MasterTableView>
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
