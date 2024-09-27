<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="CustomerTask.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.CustomerTask" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

     <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download"
                                OnClick="ImageButton4_Click" AlternateText="Xlsx" />
     
                            
                            

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
                            <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                                        <div class="col-lg-3" >
                                            
                                                <label class="control-label col-lg-12">طريق </label>
                                           
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlRoute" runat="server" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" Filter="Contains"
                                                      CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="حدد الطريق" Width="100%">
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-3" >
                                            
                                                <label class="control-label col-lg-12">عميل </label>
                                           
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlCustomer" runat="server" Filter="Contains" 
                                                        CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  RenderMode="Lightweight" EmptyMessage="حدد العميل" Width="100%">
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-2" >
                                      
                                            <label class="control-label col-lg-12">من التاريخ </label>
                                       
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker ID="rdFromData" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                        </div>
                                    </div>
                                    <div class="col-lg-2" >
                                        
                                            <label class="control-label col-lg-12">حتي اليوم </label>
                                      
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker ID="rdEndDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                            <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="rdFromData" ControlToValidate="rdEndDate" Operator="GreaterThanEqual"
                                                ErrorMessage="يجب أن تكون البيانات أكبر" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                        </div>
                                    </div>
                                         <div class="col-lg-2" style="text-align: center; top: 19px; padding-top:15px;">
                                    <asp:LinkButton ID="lnkFilter" runat="server" BackColor="#DAE9F8"  ForeColor="#009EF7"   CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    تطبيق عامل التصفية
                                    </asp:LinkButton>
                                </div>
                                    </div>



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
                                ShowFooter="false" 
                                EnableHeaderContextMenu="true">
                                <Columns>

                                   <%-- <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="5px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                    </telerik:GridButtonColumn>--%>






                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="كود الطريق" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="rot_ArabicName" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="طريق" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_ArabicName">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="كود العميل" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="عميل" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="cst_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="اسم المهمة" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cst_Name">
                                    </telerik:GridBoundColumn>
                                      <telerik:GridBoundColumn DataField="brd_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="ماركة" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_NameArabic">
                                    </telerik:GridBoundColumn>


                                     <%-- <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="120px" HeaderText="Reference Image" HeaderStyle-Font-Size="Smaller"
                                                        HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="pp" runat="server" NavigateUrl=' <%#  Eval("cst_ReferenceImage") %>' Target="_blank" >
                                                          <asp:Image  ID="itmImage" runat="server" ImageUrl=' <%#  Eval("cst_ReferenceImage") %>'  Height="55px"  />
                                                                </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>--%>

                                     <telerik:GridBoundColumn DataField="DueDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ الاستحقاق" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="DueDate">
                                    </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="dph_Time" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="وقت المعاملة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="dph_Time">
                                        </telerik:GridBoundColumn>


                                     <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="120px" HeaderText="الصورة الملتقطة" HeaderStyle-Font-Size="Smaller"
                                                        HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="ppp" runat="server" NavigateUrl=' <%# "../" + Eval("cst_CapturedImage") %>' Target="_blank" >
                                                          <asp:Image  ID="itmImagee" runat="server" ImageUrl=' <%# "../"+ Eval("cst_CapturedImage") %>'  Height="55px"  />
                                                                </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                
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


