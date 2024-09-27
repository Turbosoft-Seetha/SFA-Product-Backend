<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ListCompetitorActivities.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ListCompetitorActivities" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
</asp:Content>

<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">

    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download"
                                OnClick="ImageButton4_Click" AlternateText="Xlsx" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
</telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
<AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="lnkFilter">
        <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="grvRpt" />
        
        </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
        </telerik:RadAjaxManagerProxy>
    <div class="card-body" style="background-color:white; padding:20px;">



    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                   
                   
                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">

                            
                             <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                    <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12">طريق</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="rdRoute" runat="server" EmptyMessage="حدد الطريق" Width="100%" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12">عميل</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="rdCustomer" runat="server" EmptyMessage="حدد العميل"  Width="100%" >
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>

                                    <div class="col-lg-2 ">
                                        <label class="control-label col-lg-12">من التاريخ</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="من تاريخ إلزامي" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 ">
                                        <label class="control-label col-lg-12">حتي اليوم</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" Width="100%" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="يجب أن يكون تاريخ الانتهاء أكبر"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="حتى تاريخه إلزامي" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>




                                    <div class="col-lg-2" style="text-align: right; top: 10px; text-align: center; padding-top:15px;">
                                        <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8"  ForeColor="#009EF7"  CausesValidation="false" OnClick="Filter_Click">
                                                   تطبيق عامل التصفية
                                        </asp:LinkButton>
                                    </div>



                                </div>
                               
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="cma_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="cus_NameArabic" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="عميل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cus_NameArabic">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="com_Name" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="منافس" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="com_Name">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="dph_Date" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="dph_Date">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="dph_Time" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="زمن" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="dph_Time">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="usr_ArabicName" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="مستخدم التطبيق" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="usr_ArabicName">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="cpt_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="يكتب" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cpt_Name">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="brd_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="كود الماركة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="brd_Code">
                                        </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="brd_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="ماركة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="brd_NameArabic">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="cma_StartDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ البدء" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cma_StartDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cma_EndDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="تاريخ الانتهاء" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cma_EndDate">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cma_Desc" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="وصف" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cma_Desc">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cma_SpaceVisiblity" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="رؤية الفضاء" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cma_SpaceVisiblity">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridTemplateColumn HeaderStyle-Width="50px" HeaderText="صورة" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                        <ItemTemplate>

                                            <asp:HyperLink ID="Img" runat="server" NavigateUrl=' <%#"../"+  Eval("cmi_Image") %>' Target="_blank">
                                                <asp:Image ID="Image" runat="server" ImageUrl=' <%# "../"+ Eval("cmi_Image") %>' Height="20px" width="20px"/>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="cma_Remarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="ملاحظات" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="cma_Remarks">
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
        </div>

</asp:Content>