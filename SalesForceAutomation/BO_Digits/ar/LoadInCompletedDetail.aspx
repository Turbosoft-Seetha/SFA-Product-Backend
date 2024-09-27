<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="LoadInCompletedDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.LoadInCompletedDetail" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
       <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color:white;  padding:20px;">
                     <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                      <div class="kt-portlet__head-actions" >
                         <div class="col-lg-6 row" style="text-align: center; padding-top: 20px; padding-bottom: 10px; ">
                         <div class="col-lg-5" style="font:"> <b><asp:Label Text="إظهار العناصر المعدلة فقط" runat="server"></asp:Label></b> </div>
                             <div class="col-lg-1" style="padding-left:0px;"> <asp:CheckBox ID="Adj" runat="server" Height="15px" Width="15px" OnCheckedChanged="Adj_CheckedChanged"  AutoPostBack="true"/>  </div>      
                            <%-- <asp:LinkButton ID="Adjusted" runat="server" CssClass="btn btn-sm btn-primary me-2" CausesValidation="false" OnClick="Adjusted_Click" BackColor="#DAE9F8" ForeColor="#009EF7">
                                                    Show Adjusted Items
                             </asp:LinkButton>--%>
                              
                                        
                                     
                       </div>
                   
                     </div>
                      <div class="kt-portlet__body pb-0">

                            <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">

                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style="background-color: #F9FAFC; display: grid">
                                                <table>
                                                    <td style="width: 56%" >
                                                        <tr>
                                                            <div class="col-lg-12 mb-2 row" style="padding-left: 11px; padding-top: 8px;">
                                                        <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">طريق:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRot" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">مستخدم:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                          <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">تاريخ:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                         <div class="col-lg-3 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">حالة:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblstatus" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        </div>
                                                        </tr>
                                                        
                                                        
                                                    </td>
                                                    
                                                </table>


                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </div>
                 
                    <!--begin::Form-->
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
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true" ScrollHeight="500px">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="lid_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                                  <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="رمز الصنف" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>

                                                 <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="غرض " FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                </telerik:GridBoundColumn>

                                               <telerik:GridBoundColumn DataField="prd_NameArabic" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="اسم العنصر بالعربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_NameArabic">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="brd_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="ماركة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="brd_Name">
                                                </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="brd_NameArabic" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="اسم العلامة التجارية باللغة العربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="brd_NameArabic">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cat_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="فئة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_Name">
                                                </telerik:GridBoundColumn>
                                              <telerik:GridBoundColumn DataField="cat_NameArabic" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="التصنيف باللغة العربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cat_NameArabic">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="sct_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تصنيف فرعي" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_Name">
                                                </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="sct_NameArabic" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="القسم الفرعي باللغة العربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sct_NameArabic">
                                                </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="lid_OpenHigherUom" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="افتح واجهة القياس العليا" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_OpenHigherUom" >
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="lid_OpenHigherQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="افتح كمية أكبر" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_OpenHigherQty">
                                        </telerik:GridBoundColumn>

                                       
                                        <telerik:GridBoundColumn DataField="lid_OpenLowerUom" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="افتح واجهة القياس السفلية" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_OpenLowerUom" >
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="lid_OpenLowerQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="افتح كمية أقل" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_OpenLowerQty">
                                        </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="lid_HigherUom" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وحدة قياس أعلى جديدة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_HigherUom">
                                                </telerik:GridBoundColumn>
                                        

                                               
                                               <telerik:GridBoundColumn DataField="lid_HigherQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كمية جديدة أعلى" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_HigherQty">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="lid_LowerUom" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وحدة قياس سفلية جديدة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_LowerUom">
                                                </telerik:GridBoundColumn>




                                               

                                                <telerik:GridBoundColumn DataField="lid_LowerQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كمية أقل طازجة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_LowerQty">
                                                </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="lid_AdjHigherUom" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="وحدة قياس أعلى معدلة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_AdjHigherUom" >
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="lid_AdjHigherQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="كمية أعلى معدلة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_AdjHigherQty">
                                        </telerik:GridBoundColumn>

                                       
                                        <telerik:GridBoundColumn DataField="lid_AdjLowerUom" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="وحدة القياس السفلية المعدلة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_AdjLowerUom" >
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="lid_AdjLowerQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="كمية أقل معدلة" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_AdjLowerQty">
                                        </telerik:GridBoundColumn>

                                               <telerik:GridBoundColumn DataField="lid_FinalHigherUom" AllowFiltering="true" HeaderStyle-Width="110px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="وحدة قياس أعلى نهائية" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_FinalHigherUom" >
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="lid_FinalHigherQty" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="الكمية الأعلى النهائية" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_FinalHigherQty">
                                        </telerik:GridBoundColumn>

                                       
                                        <telerik:GridBoundColumn DataField="lid_FinalLowerUom" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="وحدة القياس السفلية النهائية" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_FinalLowerUom" >
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="lid_FinalLowerQty" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="الكمية المنخفضة النهائية" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="lid_FinalLowerQty">
                                        </telerik:GridBoundColumn>


                                         <telerik:GridBoundColumn DataField="user" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Order" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="user" Visible="false">
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
                         </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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

</asp:Content>
