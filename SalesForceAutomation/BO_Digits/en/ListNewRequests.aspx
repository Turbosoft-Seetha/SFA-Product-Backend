<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListNewRequests.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListNewRequests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
      <div class="card-body row p-8" style="background-color:white;">
          
                <!--begin::Portlet-->
               
                    <!--begin::Form-->
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

                         <div class="col-lg-12 row" style="display: -webkit-box;padding-bottom:10px;">

                                   <div class="col-lg-3">
                                        <label class="control-label col-lg-12">Route</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                ID="rdRoute" runat="server" EmptyMessage="Select Route" Width="100%" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>

                                 <div class="col-lg-3" >
                                            <div class="col-lg-12">
                                                <label class="control-label col-lg-12 pl-0">Customer </label>
                                            </div>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="rdCustomer" runat="server" Filter="Contains" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" EmptyMessage="Select Customer" Width="100%">
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>
                                <div class="col-lg-2">
                                    <div class="col-lg-12">
                                    <label class="control-label col-lg-6">From Date</label>
                                        </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdFromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdFromDate"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <div class="col-lg-12">
                                    <label class="control-label col-lg-6">To Date</label>
                                        </div>
                                    <div class="col-lg-12">
                                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdEndDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                                        </telerik:RadDatePicker>
                                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdEndDate" ControlToCompare="rdFromDate" ErrorMessage="End date must be greater"
                                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual">
                                        </asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdEndDate"></asp:RequiredFieldValidator>
                                    </div>
                                </div>


                                <div class="col-lg-2"  style="text-align: right; top: 10px; text-align: center; padding-top:15px;">
                                    <asp:LinkButton ID="lnkfilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8"  ForeColor="#009EF7" CausesValidation="true" OnClick="lnkfilter_Click">
                                                    Apply Filter
                                    </asp:LinkButton>
                                </div>


                            </div>

                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
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
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="req_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                             <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                            </telerik:GridButtonColumn>

                                             <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                      

                                             <telerik:GridBoundColumn DataField="req_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Request Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="req_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="req_Description" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="req_Description">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="CreatedDate" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            
                                            <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Responded Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="req_RequestType" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Request Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="req_RequestType">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="req_ResponseType" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Response Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="req_ResponseType">
                                            </telerik:GridBoundColumn>
                                            
                                             <telerik:GridBoundColumn DataField="req_Remarks" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="req_Remarks">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridTemplateColumn HeaderStyle-Width="150px" HeaderText="Reference Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <%--<telerik:RadImageGallery RenderMode="Lightweight" ID="rdImages" runat="server" DisplayAreaMode="ToolTip"  Visible="false" DataImageField="odi_Image"   Width="300px" Height="60px"  LoopItems="false">
                                                        <ImageAreaSettings Height="100px" Width="100px"  />
                                                </telerik:RadImageGallery>--%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="rei_Image" AllowFiltering="true" HeaderStyle-Width="100px" Display="false"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rei_Image">
                                            </telerik:GridBoundColumn>

                                            
                                             <telerik:GridTemplateColumn HeaderStyle-Width="150px" HeaderText="Response Image" UniqueName="Image" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <%--<telerik:RadImageGallery RenderMode="Lightweight" ID="rdImages" runat="server" DisplayAreaMode="ToolTip"  Visible="false" DataImageField="odi_Image"   Width="300px" Height="60px"  LoopItems="false">
                                                        <ImageAreaSettings Height="100px" Width="100px"  />
                                                </telerik:RadImageGallery>--%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="req_ResponseImage" AllowFiltering="true" HeaderStyle-Width="100px" Display="false"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="req_ResponseImage">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Status">
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
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>

                    </telerik:RadAjaxLoadingPanel>
                
           
        </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
