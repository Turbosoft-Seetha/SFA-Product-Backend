<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="ListDisplayAgreements.aspx.cs" Inherits="SalesForceAutomation.Admin.ListDisplayAgreements" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <%--<div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">--%>

                       
                        <%-- <div class="kt-portlet__head-actions">

                            <asp:ImageButton ID="" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

                        </div>--%>
                    <%--</div>--%>


                    <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
                        <div class="kt-portlet__head-label">
                            <h3 class="kt-portlet__head-title">Display Agreement
                            </h3>
                            <span class="kt-subheader__separator kt-hidden"></span>
                            <div class="kt-subheader__breadcrumbs" style="padding-left: 30px">
                             <a href="ListDisplayAgreements.aspx" class="kt-subheader__breadcrumbs">
                            <i class="flaticon2-shelter"></i> Display Agreement </a>
                        <span class="kt-subheader__breadcrumbs-separator"></span>

</div>
                        </div>
                        <div class="kt-portlet__head-actions">

                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" style="padding-right:25px" OnClick="imgExcel_Click" AlternateText="Xlsx" />


                            <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="assets/media/files/pdf.svg" Height="50" Width="30" ToolTip="Print"
                                OnClick="btnPDF_Click" AlternateText="pdf" />
                        </div>
                    </div>



                    <!--begin::Form-->


                    <!--end: Search Form -->
                    <%--<telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                        <div class="kt-portlet__body">--%>
                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                    <div class="kt-portlet__body">

                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <div class=" col-lg-12 row" style="display: -webkit-box; padding-bottom: 10px">

                                <div class="col-lg-3">

                                    <label class="control-label col-lg-12">Route </label>

                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlRoute" runat="server"  OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged" Filter="Contains"
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" AutoPostBack="true" EmptyMessage="Select Route" Width="100%">
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <label class="control-label col-lg-12">Customer </label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlCustomer" runat="server" Filter="Contains" 
                                            CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  RenderMode="Lightweight" EmptyMessage="Select Customer" Width="100%">
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12 ">From Date </label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdFromData" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <label class="control-label col-lg-12">To Date </label>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker ID="rdEndDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="100%" RenderMode="Lightweight"></telerik:RadDatePicker>
                                        <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="rdFromData" ControlToValidate="rdEndDate" Operator="GreaterThanEqual"
                                            ErrorMessage="To data must be greater" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                    </div>
                                </div>
                                <div class="col-lg-2" style="text-align: center; top: 19px;">
                                    <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="true" OnClick="lnkFilter_Click">
                                                    Apply Filter
                                    </asp:LinkButton>
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
                            AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="dag_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>
                                     
                                   

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Route Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Route" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Customer Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="170px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText=" Customer" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="dag_Number" AllowFiltering="true" HeaderStyle-Width="150px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Agreement Number" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_Number">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="agt_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="agt_Name">
                                            </telerik:GridBoundColumn>


                                
                                     <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                            </telerik:GridBoundColumn>

                             

                                     <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>


                                

                                   <%-- <telerik:GridBoundColumn DataField="act_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Category Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="act_Code">
                                    </telerik:GridBoundColumn>--%>

                                    <telerik:GridBoundColumn DataField="act_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Category " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="act_Name">
                                    </telerik:GridBoundColumn>

<%--                                    <telerik:GridBoundColumn DataField="asc_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="SubCat.Code" FilterControlWidth="40%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="asc_Code">
                                    </telerik:GridBoundColumn>--%>

                                    <telerik:GridBoundColumn DataField="asc_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="SubCategory" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="asc_Name">
                                    </telerik:GridBoundColumn>

                                   <%-- <telerik:GridBoundColumn DataField="brd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Brand Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Code">
                                    </telerik:GridBoundColumn>--%>

                                    <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Brand" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                    </telerik:GridBoundColumn>



                                   <%-- <telerik:GridBoundColumn DataField="apt_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Pay Terms Code" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="apt_Code">
                                    </telerik:GridBoundColumn>--%>



                                    <telerik:GridBoundColumn DataField="apt_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Pay Terms" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="apt_Name">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="ago_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Offer" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ago_Name">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="dag_StartDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Start Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_StartDate">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="dag_EndDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="End Date" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_EndDate">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="dag_MonthlyAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Monthly Amount" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_MonthlyAmount">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="dag_TotalAmount" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Total Amount" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_TotalAmount">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                        <ItemTemplate>

                                            <asp:HyperLink ID="dagImg" runat="server" NavigateUrl=' <%#  Eval("dag_Image") %>' Target="_blank">
                                                <asp:Image ID="dagImage" runat="server" ImageUrl=' <%#  Eval("dag_Image") %>' Height="65px" />
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                     <telerik:GridBoundColumn DataField="dag_Attachment" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Attachment" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_Attachment" Display="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn  AllowFiltering="false"
                                                HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Attachment"
                                                HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="pp" runat="server"
                                                        ImageUrl="assets/media/icons/svg/Files/File.svg" NavigateUrl='<%#Eval("dag_Attachment")%>' Height="50" Width="50" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>





                                   <%-- <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Attachment" UniqueName="Attachment" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                        <ItemTemplate>

                                            <asp:HyperLink ID="dagAttach" runat="server" NavigateUrl=' <%#  Eval("dag_Attachment") %>' Target="_blank">
                                                <asp:Image ID="dagAttchment" runat="server" ImageUrl=' <%#  Eval("dag_Attachment") %>' Height="65px" />
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>


                                    <telerik:GridBoundColumn DataField="dag_Remarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="dag_Remarks">
                                    </telerik:GridBoundColumn>
                                    <%-- <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
                                            </telerik:GridBoundColumn>--%>
                                </Columns>
                            </MasterTableView>
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
                            <img alt="Loading..." src="../Media/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
