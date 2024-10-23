<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="OverrideOnlineApproval.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.OverrideOnlineApproval" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        function Confim(res) {
            $('#modalConfirm').modal('show');
            $('#usrID').text(res);
        }
        function SuccessModal() {
            $('#modalConfirm').modal('hide');
            $('#modalConfirm2').modal('hide');
            $('#modalConfirm3').modal('hide');
            $('#kt_modal_1_4').modal('show');

            x++;
        }
        function failedModal() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function ConfimReject(res) {
            $('#modalRejConfirm').modal('show');
            $('#usrID').text(res);
        }
        function SuccessModalReject() {
            $('#modalRejConfirm').modal('hide');
            $('#modalConfirm2').modal('hide');
            $('#modalConfirm3').modal('hide');
            $('#kt_modal_1_4Rej').modal('show');

            x++;
        }
        function Confim2(a) {
            $('#modalConfirm2').modal('show');
            $('#confirm2').text(a);
        }
        function Confim3(a) {
            $('#modalConfirm3').modal('show');
            $('#confirm3').text(a);
        }
        function showDetailsModal(details) {
            document.getElementById('detailsContent').innerHTML = details;
            $('#modalConfirm2').modal('show');
        }


        function showDetailsModalRej(details) {
            document.getElementById('detailsContentRej').innerHTML = details;
            $('#modalConfirm3').modal('show');
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="kt-portlet">
                        <div class="kt-portlet__body">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class=" col-lg-12 row" style="padding-bottom: 10px">
                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">From Date</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"
                                                AutoPostBack="true">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">To Date</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%"
                                                AutoPostBack="true">
                                            </telerik:RadDatePicker>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12">Route</label>
                                        <div class="col-lg-12">
                                            <telerik:RadComboBox Skin="Material" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight" Width="100%"
                                                ID="rdRoute" runat="server" EmptyMessage="Select Route">
                                            </telerik:RadComboBox>

                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12 ">Type</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlType" RenderMode="Lightweight" runat="server" Width="100%" DefaultMessage="Select Type">
                                                <Items>
                                                    <telerik:DropDownListItem Text="All" Value="A" Selected="true" />
                                                    <telerik:DropDownListItem Text="Geo Fencing" Value="GF" />
                                                    <telerik:DropDownListItem Text="Barcode Scanning" Value="BS" />
                                                    <telerik:DropDownListItem Text="Manual Selection" Value="MS" />
                                                    <telerik:DropDownListItem Text="Credit Limit Amount" Value="CL" />
                                                    <telerik:DropDownListItem Text="Credit Days" Value="CD" />
                                                    <telerik:DropDownListItem Text="Void" Value="VO" />
                                                    <telerik:DropDownListItem Text="Unschedule" Value="UN" />

                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlStatus" ErrorMessage="<br/>Please Select Status" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <label class="control-label col-lg-12 ">Status</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddlStatus" RenderMode="Lightweight" runat="server" Width="100%" DefaultMessage="Select Status">
                                                <Items>
                                                    <telerik:DropDownListItem Text="All" Value="AL"  />
                                                    <telerik:DropDownListItem Text="Pending" Value="P" Selected="true"/>
                                                    <telerik:DropDownListItem Text="Approved" Value="A" />
                                                    <telerik:DropDownListItem Text="Rejected" Value="R" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                                ControlToValidate="ddlStatus" ErrorMessage="<br/>Please Select Status" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>

                                    <div class="col-lg-2" style="top: 10px; text-align: center; padding-top: 15px;">
                                        <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="lnkFilter_Click">
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
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="ooa_ID"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Approve" UniqueName="CnfApprove" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkApprove" runat="server" Text="Approve" CommandName="Approve"
                                                        Style="color: #90EE90; border: 2px dashed #90EE90; padding: 5px 10px; background-color: transparent; font-weight: bold; border-radius: 10px;">
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" HeaderText="Reject" UniqueName="CnfReject" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkReject" runat="server" Text="Reject" CommandName="Reject"
                                                        Style="color: #FFB6C1; border: 2px dashed #FFB6C1; padding: 5px 10px; background-color: transparent; font-weight: bold; border-radius: 10px;">
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="250px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ooa_Type" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ooa_Type">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ooa_TransID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Transaction ID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ooa_TransID">
                                            </telerik:GridBoundColumn>


                                            <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ooa_ApprovalStatus" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ooa_ApprovalStatus">
                                            </telerik:GridBoundColumn>                                          


                                            <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Approved By" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Approved Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
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

    <div class="clearfix"></div>  

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Approved Successfully </span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4Rej" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Rejected Successfully </span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelFailedModal();">
                        Ok
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <div class="modal fade modal-center" id="modalConfirm2" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirm2"></h5>
                </div>

                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-12 form-group">
                            <div class="col-lg-12">

                                <div id="detailsContent" class="col-lg-12"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm2);">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade modal-center" id="modalConfirm3" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirm3"></h5>
                </div>

                <div class="modal-body">
                    <span></span>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-12 form-group">
                            <div class="col-lg-12">

                                <div id="detailsContentRej" class="col-lg-12"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                        <asp:LinkButton ID="RejectSave" runat="server" Text="Yes" OnClick="RejectSave_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm3);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <style type="text/css">
        .modal-center {
            position: absolute;
            top: 50% !important;
            transform: translate(0, -50%) !important;
            -ms-transform: translate(0, -50%) !important;
            -webkit-transform: translate(0, -50%) !important;
            margin: auto 5%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
