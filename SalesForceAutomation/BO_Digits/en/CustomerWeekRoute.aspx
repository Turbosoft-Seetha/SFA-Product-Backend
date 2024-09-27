<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CustomerWeekRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CustomerWeekRoute" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function CopyConfig() {

            $('#kt_modal_1_7').modal('show');
        }
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                          
                             <asp:LinkButton ID="lnkCopyConfig" runat="server" ValidationGroup="form" OnClick="lnkCopyConfig_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Copy Week Configuration'
                                CssClass="btn btn-sm btn-light-primary me-2 border-1" BackColor="white"  CausesValidation="true"/>
                            
                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlFromWeek">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlFromWeek" />
                    <telerik:AjaxUpdatedControl ControlID="ddlToWeek" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="ddlToWeek">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlFromWeek" />
                    <telerik:AjaxUpdatedControl ControlID="ddlToWeek" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>

     </telerik:RadAjaxManager>

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <telerik:RadAjaxPanel ID="pnl" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
            <div class="row">
                <div class="col-lg-12">
                    <div class="kt-portlet" style="background-color: white; padding: 20px;">

                        <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
                            <div class="kt-portlet__head-label" style="border-bottom-style: inset;">
                                <h3 class="kt-portlet__head-title">Route Customers - Weekly Plan</h3>
                                <h3 class="kt-portlet__head-title">
                                    <telerik:RadLabel ID="ltrlRoute" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                                    <telerik:RadLabel ID="ltrlweek" runat="server" CssClass="kt-portlet__head-title"></telerik:RadLabel>
                                </h3>
                            </div>
                        
                        </div>


                        <!--begin::Form-->


                        <div class="kt-form kt-form--label-right">

                            <div class="kt-portlet__body" style="padding-bottom:8px;">

                                <div class="col-lg-12 row">
                                    <div class="col-lg-4" style="padding-top: 8px;">
                                        <div class="col-lg-12">
                                            <label class="control-label col-lg-12 pl-0">Customer </label>
                                        </div>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox ID="ddlCustomer" runat="server" Filter="Contains" RenderMode="Lightweight" EmptyMessage="Select Customer" Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-2" style="padding-top: 8px;">
                                        <div class="col-lg-12">
                                            <label class="control-label col-lg-12 pl-0">Week </label>
                                        </div>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlWeek" EmptyMessage="Select Week" runat="server" Filter="Contains" RenderMode="Lightweight" Width="100%">
                                                <Items>

                                                    <telerik:DropDownListItem Text="Week 1" Value="1" />
                                                    <telerik:DropDownListItem Text="Week 2" Value="2" />
                                                    <telerik:DropDownListItem Text="Week 3" Value="3" />
                                                    <telerik:DropDownListItem Text="Week 4" Value="4" />


                                                </Items>
                                            </telerik:RadDropDownList>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 " style="padding-top: 15px">
                                        <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-sm btn-light-primary me-2">Apply Filter</asp:LinkButton>

                                    </div>
                                    <div class="col-lg-2 " style="padding-top: 15px">

                                        <asp:LinkButton ID="lnkSave" runat="server" OnClick="lnkSave_Click" Text="Update" CssClass="btn btn-sm fw-bold btn-primary "></asp:LinkButton>

                                    </div>
                                    <div class="col-lg-2 " style="padding-top: 15px">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel13">

                                            <asp:LinkButton ID="ViewMap" runat="server" CssClass="btn btn-sm btn-light-warning me-2 border-1" Text="View on Map" OnClick="ViewMap_Click"></asp:LinkButton>


                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel13" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center mt-5">
                                                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>

                                    </div>

                                </div>
                            </div>

                            <div class="kt-portlet__body">
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    OnItemDataBound="grvRpt_ItemDataBound"
                                    AllowFilteringByColumn="false"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="cwr_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>


                                            <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="EditColumn" Display="false">
                                            </telerik:GridButtonColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="200px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="WeekNum" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Week Number" FilterControlWidth="100%"
                                                CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="WeekNum">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="Sat" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Saturday" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Sat" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SatSeq" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Saturday Sequence" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="SatSeq" Display="false">
                                            </telerik:GridBoundColumn>




                                            <telerik:GridBoundColumn DataField="Sun" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Sunday" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Sun" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="SunSeq" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Sunday Sequence" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="SunSeq" Display="false">
                                            </telerik:GridBoundColumn>




                                            <telerik:GridBoundColumn DataField="Mon" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Monday" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Mon" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MonSeq" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Monday Sequence" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="MonSeq" Display="false">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="Tue" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Tuesday" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Tue" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="TueSeq" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Tuesday Sequence" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="TueSeq" Display="false">
                                            </telerik:GridBoundColumn>



                                            <telerik:GridBoundColumn DataField="Wed" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Wednsday" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Wed" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="WedSeq" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Wednsday Sequence" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="WedSeq" Display="false">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="Thu" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Thursday" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Thu" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ThuSeq" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Thursday Sequence" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ThuSeq" Display="false">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="Fri" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Friday" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="Fri" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="FriSeq" AllowFiltering="true" HeaderStyle-Width="70px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Friday Sequence" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="FriSeq" Display="false">
                                            </telerik:GridBoundColumn>







                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Saturday" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbsat" Width="40px" runat="server" Enabled="true"></asp:CheckBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Saturday Sequence" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>

                                                    <telerik:RadNumericTextBox ID="txtsatseq" NumberFormat-AllowRounding="false" Width="40px" runat="server" Enabled="true">
                                                    </telerik:RadNumericTextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>



                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Sunday" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbsun" Width="40px" runat="server" Enabled="true"></asp:CheckBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Sunday Sequence" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtsunseq" NumberFormat-AllowRounding="false" Width="40px" runat="server" Enabled="true">
                                                    </telerik:RadNumericTextBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>




                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Monday" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbmon" Width="40px" runat="server" Enabled="true"></asp:CheckBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Monday Sequence" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtmonseq" NumberFormat-AllowRounding="false" Width="40px" runat="server" Enabled="true">
                                                    </telerik:RadNumericTextBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>



                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Tuesday" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbtue" Width="40px" runat="server" Enabled="true"></asp:CheckBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Tuesday Sequence" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txttueseq" NumberFormat-AllowRounding="false"
                                                        Width="40px" runat="server" Enabled="true">
                                                    </telerik:RadNumericTextBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>



                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Wednesday" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbwed" Width="40px" runat="server" Enabled="true"></asp:CheckBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Wednesday Sequence" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtwedseq" NumberFormat-AllowRounding="false" Width="40px" runat="server" Enabled="true">
                                                    </telerik:RadNumericTextBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Thursday" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbthu" Width="40px" AlternateText="Thursday" runat="server" Enabled="true"></asp:CheckBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Thursday Sequence" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtthuseq" NumberFormat-AllowRounding="false" Width="40px" runat="server" Enabled="true">
                                                    </telerik:RadNumericTextBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Friday" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbfri" Width="40px" runat="server" Enabled="true"></asp:CheckBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" HeaderText="Friday Sequence" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtfriseq" NumberFormat-AllowRounding="false" Width="40px" runat="server" Enabled="true">
                                                    </telerik:RadNumericTextBox>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>




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
        </telerik:RadAjaxPanel>
        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
            BackColor="Transparent"
            ForeColor="Blue">
            <div class="col-lg-12 text-center">
                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
            </div>
        </telerik:RadAjaxLoadingPanel>
    </div>


    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-secondary">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
            <div class="modal fade" id="kt_modal_1_7" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Copy Week Configuration</h5>
                </div>
                                                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                     <div class="col-lg-6" style="padding-top: 8px;">
                         <div class="col-lg-12">
                             <label class="control-label col-lg-12 pl-0"> From Week </label>
                         </div>
                         <div class="col-lg-12">
                             <telerik:RadComboBox ID="ddlFromWeek" EmptyMessage="Select Week" runat="server" Filter="Contains" RenderMode="Lightweight" Width="100%" OnSelectedIndexChanged="ddlFromWeek_SelectedIndexChanged" AutoPostBack="true">
                                 <Items>

                                     <telerik:RadComboBoxItem Text="Week 1" Value="1" />
                                     <telerik:RadComboBoxItem Text="Week 2" Value="2" />
                                     <telerik:RadComboBoxItem Text="Week 3" Value="3" />
                                     <telerik:RadComboBoxItem Text="Week 4" Value="4" />


                                 </Items>
                             </telerik:RadComboBox>
                         </div>
                     </div>
                     <div class="col-lg-6" style="padding-top: 8px;">
                         <div class="col-lg-12">
                             <label class="control-label col-lg-12 pl-0">To Week </label>
                         </div>
                         <div class="col-lg-12">
                             <telerik:RadComboBox ID="ddlToWeek" EmptyMessage="Select Week" runat="server" Filter="Contains" RenderMode="Lightweight" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" AutoPostBack="true">
                                 <Items>

                                     <telerik:RadComboBoxItem Text="Week 1" Value="1" />
                                     <telerik:RadComboBoxItem Text="Week 2" Value="2" />
                                     <telerik:RadComboBoxItem Text="Week 3" Value="3" />
                                     <telerik:RadComboBoxItem Text="Week 4" Value="4" />


                                 </Items>
                             </telerik:RadComboBox>
                         </div>
                     </div>

                        </div>

                    <div class="col-lg-12 row pt-8">
                          <telerik:RadLabel RenderMode="Lightweight" ID="lblNote" runat="server" Font-Size="Small" ForeColor="Blue" Text="Note: This will be applied to all customers belongs to this route " Width="100%" CausesValidation="false" >
           </telerik:RadLabel><br />
                    </div>
                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        
                        <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="btn btn-sm fw-bold btn-success" ValidationGroup="frm" CausesValidation="true" OnClick="lnkSubmit_Click">
                                                    Submit
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <br />
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_7);">Cancel</button>
                </div>
            </div>
        </div>
    </div>



</asp:Content>
