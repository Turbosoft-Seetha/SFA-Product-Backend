
<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="UserDailyProcess.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.UserDailyProcess" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function MerchModal() {
            $('#kt_modal_1_5').modal('show');
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">


                <!--end: Search Form -->

                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                <div class="card-body" style="background-color: white; padding: 20px;">

                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                         <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                    <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false" >
                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12">منطقة</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddlregion" runat="server" EmptyMessage="اختر المنطقة" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-3" >
                                        <label class="control-label col-lg-12">مستودع</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                RenderMode="Lightweight"
                                                ID="ddldepot" runat="server" EmptyMessage="حدد المستودع"
                                                OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-3" >
                                        <label class="control-label col-lg-12">منطقة</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldpoArea" runat="server" EmptyMessage="حدد المنطقة"
                                                OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                    <div class="col-lg-3" >
                                        <label class="control-label col-lg-12">المنطقة الفرعية</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="ddldpoSubArea" runat="server" EmptyMessage="حدد المنطقة الفرعية" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>
                                        </asp:PlaceHolder>
                                      </div>
                                <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                    <div class="col-lg-3">
                                        <label class="control-label col-lg-12">طريق</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="rdRoute" runat="server" EmptyMessage="حدد الطريق"  OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>

                                    <div class="col-lg-3 ">
                                        <label class="control-label col-lg-12">من التاريخ</label>
                                        <div class="col-lg-10">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="من تاريخ إلزامي" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-3 ">
                                        <label class="control-label col-lg-12">ان يذهب في موعد</label>
                                        <div class="col-lg-10">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                                            </telerik:RadDatePicker>
                                            <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="حتى تاريخه إلزامي" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-1" style="top: 10px; text-align: center; padding-top: 15px;width: auto;">
                                        <asp:LinkButton ID="Filter"  runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkFilter_Click">
                                                   تطبيق عامل التصفية
                                        </asp:LinkButton>
                                    </div>
                                    <div class="col-lg-2" style="text-align: center; padding-top: 15px;margin-left: -1px;width: auto;">
                                        <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click">
                                                   تصفية متقدم
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
                            AllowPaging="true" PageSize="10" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                ShowFooter="false" DataKeyNames="udp_ID"
                                EnableHeaderContextMenu="true">
                                <Columns>



                                    <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="التفاصيل"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="Detail" ID="Rad1" Visible="true" ToolTip="تفاصيل" CommandArgument='<%# Eval("rot_ID")%>' AlternateText="Detail" runat="server"
                                                ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="خريطة" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="map" ID="RadImageButton3" Visible="true" ToolTip="خريطة" Height="25px" AlternateText="Map" runat="server" 
                                                ImageUrl="../assets/media/UDP/tracking.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="70px" AllowFiltering="false" HeaderText="مستعمرة" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="Settlement" ID="RadImageButton2" Visible="true"  ToolTip="مستعمرة" AlternateText="Settlement" runat="server"
                                                ImageUrl="../assets/media/svg/general/settlement.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                      <telerik:GridTemplateColumn HeaderStyle-Width="45px" AllowFiltering="false" HeaderText="فان ستوك" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="VanStock" ID="btnVanstock" Visible="true"  ToolTip="فانستوك الحالي" CommandArgument='<%# Eval("rot_ID")%>' AlternateText="VanStock" runat="server" Height="30"
                                                ImageUrl="../assets/media/svg/general/vanstock.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="كود الطريق" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="110px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="طريق" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                    </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="rot_ArabicName" AllowFiltering="true" HeaderStyle-Width="110px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="الاسم العربي" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_ArabicName">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="مستخدم " FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                    </telerik:GridBoundColumn>

                                     <telerik:GridBoundColumn DataField="usr_ArabicName" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="مستخدم عربي" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="usr_ArabicName">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="udp_IsAppProcessComplete" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="عملية التطبيق" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_IsAppProcessComplete">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="udp_SettlementStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="مستعمرة" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_SettlementStatus">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="udp_StartTime" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="وقت البدء" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_StartTime">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="udp_LoadOutStatus" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_LoadOutStatus" Display="false">
                                    </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_EndDayStatus" Display="false">
                                    </telerik:GridBoundColumn>

                                    <%--<telerik:GridBoundColumn DataField="udp_StartTime" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartTime">
                                        </telerik:GridBoundColumn>--%>

                                    <%--<telerik:GridBoundColumn DataField="udp_StartDayStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Start Day Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartDayStatus">
                                        </telerik:GridBoundColumn>--%>

                                    <%-- <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End Day Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_EndDayStatus">
                                        </telerik:GridBoundColumn>--%>

                                    <%--<telerik:GridBoundColumn DataField="udp_TotalCashCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Cash Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalCashCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_TotalArCashCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total AR Cash Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalArCashCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_TotalAmountCollected" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Amount Collected" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_TotalAmountCollected" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>--%>

                                    <%--<telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>--%>

                                    <telerik:GridBoundColumn DataField="udp_EndTime" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="وقت النهاية" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_EndTime">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Duration" AllowFiltering="true" HeaderStyle-Width="130px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="مدة" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="Duration">
                                    </telerik:GridBoundColumn>

                                    <%--                                        <telerik:GridBoundColumn DataField="udp_StartOdoMeter" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Start<br>OdoMeter" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_StartOdoMeter" ItemStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="udp_EndOdoMeter" AllowFiltering="true" HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="End OdoMeter" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="udp_EndOdoMeter">
                                        </telerik:GridBoundColumn>--%>


                                    <telerik:GridBoundColumn DataField="udp_VersionNumber" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="إصدار" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="udp_VersionNumber">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="udp_LogFile" UniqueName="udp_LogFile" AllowFiltering="false"
                                        HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="ملف تسجيل"
                                        HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="pp" runat="server"
                                                ImageUrl="../assets/media/svg/files/File.svg" NavigateUrl='<%# Eval("udp_LogFile")%>' Height="50" Width="50" Target="_blank">
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <%-- <telerik:GridTemplateColumn DataField="udp_DataBase" UniqueName="udp_DataBase" AllowFiltering="false"
                                            HeaderStyle-Width="80px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="DataBase"
                                            HeaderStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="ps" runat="server"
                                                    ImageUrl="assets/media/icons/svg/Files/Pictures.svg" NavigateUrl='<%#Eval("udp_DataBase")%>' Height="50" Width="50" Target="_blank">
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>

                                    <telerik:GridBoundColumn DataField="rot_Type" AllowFiltering="true" HeaderStyle-Width="100px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="نوع الطريق" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="rot_Type" Display="false">
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

    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">!..طريق التجارة</h5>
                </div>
                <div class="modal-body">
                    <span>.إنه طريق تسويق وبالتالي لا يمكنه القيام بالتسوية</span>
                </div>
                <div class="modal-footer">
                      <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
