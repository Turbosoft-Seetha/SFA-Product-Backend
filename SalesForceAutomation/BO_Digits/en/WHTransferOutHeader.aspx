<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="WHTransferOutHeader.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.WHTransferOutHeader" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../assets/media/icons/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />


    <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="40" Width="33" ToolTip="Print"
        OnClick="btnPDF_Click" AlternateText="pdf" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">

        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <%-- <div class="kt-portlet__head" style="padding-top: 20px;  padding-bottom: 20px;">

                      c
                        <%--<div class="kt-portlet__head-actions">

                            <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="../Media/excel.png" Height="50" ToolTip="Download" OnClick="imgExcel_Click" AlternateText="Xlsx" />

                         </div>--%>
                        <%--</div>--%>



                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            <div class="kt-portlet__body">
                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                    <asp:PlaceHolder ID="plhFilter" runat="server">
                                    <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                        
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Region</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddlregion" runat="server" EmptyMessage="Select Region" AutoPostBack="true" OnSelectedIndexChanged="ddlregion_SelectedIndexChanged">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Depot</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                        RenderMode="Lightweight"
                                                        ID="ddldepot" runat="server" EmptyMessage="Select Depot"
                                                        OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true" >
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Area</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddldpoArea" runat="server" EmptyMessage="Select Area"
                                                        OnSelectedIndexChanged="ddldpoArea_SelectedIndexChanged" AutoPostBack="true" >
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <label class="control-label col-lg-12">Subarea</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                                        ID="ddldpoSubArea" runat="server" EmptyMessage="Select Subarea" OnSelectedIndexChanged="ddldpoSubArea_SelectedIndexChanged" AutoPostBack="true">
                                                    </telerik:RadComboBox>

                                                </div>
                                            </div>
                                          </div>
                                        </asp:PlaceHolder>
                                        <%--   <div class="col-lg-2" style="margin-left: 4px;">
                                    <label class="control-label col-lg-12">Route</label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                            ID="rdRoute" runat="server" EmptyMessage="Select Route" OnSelectedIndexChanged="rdRoute_SelectedIndexChanged" AutoPostBack="true">
                                        </telerik:RadComboBox>

                                    </div>
                                </div>--%>
                                  
                                    <asp:PlaceHolder runat="server" ID="pnlfilter" Visible="true">
                                    <div class=" col-lg-12 row" style="padding-bottom: 10px">

                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Requested Location</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Width="100%"
                                                    RenderMode="Lightweight" ID="rdReqLoc" runat="server" EmptyMessage="Select Location" AutoPostBack="true"
                                                    OnSelectedIndexChanged="rdReqLoc_SelectedIndexChanged">
                                                </telerik:RadComboBox>


                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Picked Location</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Width="100%"
                                                    RenderMode="Lightweight" ID="rdPickLoc" runat="server" EmptyMessage="Select Location">
                                                </telerik:RadComboBox>

                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <label class="control-label col-lg-12">Status</label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="rdStatus" runat="server" EmptyMessage="Select Status" Filter="Contains" Width="100%" RenderMode="Lightweight" AutoPostBack="true">
                                                    <Items>

                                                        <telerik:RadComboBoxItem Text="Pending" Value="N" />
                                                        <telerik:RadComboBoxItem Text="Approved" Value="A" />
                                                        <telerik:RadComboBoxItem Text="Rejected" Value="R" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px;">
                                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkDOwnload_Click">
                                                    Apply Filter
                                            </asp:LinkButton>
                                        </div>
                                        <div class="col-lg-2" style="text-align: center; padding-top: 15px;">
                                            <asp:LinkButton ID="lnkAdvFilter" runat="server" CssClass="btn btn-sm btn-light-primary me-2 border-1" OnClick="lnkAdvFilter_Click" Visible="false">
                                                    Advanced Filter
                                            </asp:LinkButton>
                                        </div>


                                    </div>
                                        </asp:PlaceHolder>
                                    <!--end: Search Form -->

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
                                            ShowFooter="false" DataKeyNames="wtt_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>


                                                <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Item" ID="RadImageButton2" Visible="true" AlternateText="Item" runat="server"
                                                            ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="mrh_Number" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="MR Number" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="mrh_Number">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="wph_Number" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Pick Number" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="wph_Number">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="wtt_number" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="TO Number" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="wtt_number">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="usr_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="User Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="usr_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="usr_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="User" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="usr_Name">
                                                </telerik:GridBoundColumn>



                                                <telerik:GridBoundColumn DataField="war_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Receive.Loc Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="war_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="war_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Receive.Loc" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="war_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="str_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Pic.Loc Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="str_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="str_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Pic.Loc" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="str_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Date" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ExpDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Exp. Date" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="ExpDate">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Currentlevel" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Current Level" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Currentlevel" Display="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Status">
                                                </telerik:GridBoundColumn>



                                            </Columns>
                                        </MasterTableView>
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                            <Resizing AllowColumnResize="true"></Resizing>
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                        </ClientSettings>
                                    </telerik:RadGrid>

                                </telerik:RadAjaxPanel>
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
    </div>

</asp:Content>

