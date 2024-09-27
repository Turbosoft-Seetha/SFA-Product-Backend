<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListTasks.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListTasks" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

    
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
      <asp:LinkButton ID="lnkAdd" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Add" 
          OnClick="lnkAdd_Click"></asp:LinkButton>
         </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>   
                            
                            

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                 
                   
                    <!--end: Search Form -->
                   


                     <!--begin::Form-->
                     <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">

                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">



                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                        <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
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
                                ShowFooter="false" 
                                EnableHeaderContextMenu="true" DataKeyNames="tsk_ID">
                                <Columns>
 <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="40px" EditFormColumnIndex="0" UniqueName="EditColumn">
 </telerik:GridButtonColumn>
                                      <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Customer" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
      <ItemTemplate>
          <asp:ImageButton CommandName="Customer" ID="RadImageButton4" Visible="true" AlternateText="Customer" runat="server"
              ImageUrl="../assets/media/svg/general/User.svg"></asp:ImageButton>
      </ItemTemplate>
  </telerik:GridTemplateColumn>

                                       <telerik:GridBoundColumn DataField="tsk_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                              HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                              CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                              HeaderStyle-Font-Bold="true" UniqueName="tsk_Code">
                                          </telerik:GridBoundColumn>


                                     <telerik:GridBoundColumn DataField="tsk_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Task" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="tsk_Name">
                                    </telerik:GridBoundColumn>
                                      <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                    </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="tsk_Desc" AllowFiltering="true" HeaderStyle-Width="120px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="tsk_Desc">
                                </telerik:GridBoundColumn>


                                      <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="80px" HeaderText="Reference Image" HeaderStyle-Font-Size="Smaller"
                                                        HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="pp" runat="server" NavigateUrl=' <%# "../" + Eval("tsk_ReferenceImage") %>' Target="_blank" >
                                                          <asp:Image  ID="itmImage" runat="server" ImageUrl=' <%# "../" + Eval("tsk_ReferenceImage") %>'  Height="20px" width="20px" />
                                                                </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                     <telerik:GridBoundColumn DataField="DueDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Due Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="DueDate">
                                    </telerik:GridBoundColumn>

                                    

                                </Columns>
                            </MasterTableView>
                            <PagerStyle AlwaysVisible="true" />
                            <GroupingSettings CaseSensitive="false" />
                            <ClientSettings  EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                <Resizing AllowColumnResize="true"></Resizing>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </telerik:RadAjaxPanel>
                                                   
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
    </div>
        </div>
</asp:Content>

