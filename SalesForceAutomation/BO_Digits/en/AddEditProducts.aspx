<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditProducts.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditProducts" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function UPC() {
            $('#UPCEXiST').modal('show');
        }
        function Succcess(ab) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#Success').text(ab);
        }
        function Confm() {
            $('#modalConfirm1').modal('show');
        }
        function Succces(cd) {
            $('#modalConfirm1').modal('hide');
            $('#kt_modal_1_8').modal('show');
            $('#Success1').text(cd);
        }
        function Fail() {
            $('#modalConfirm').modal('hide');
            $('#Failmsg').modal('show');

        }

        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function delConfim() {
            $('#modaldelConfirm').modal('show');

        }

        function successModal() {
            $('#modaldelConfirm').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }
        function failedModal(res) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('show');
            $('#failres').text(res);
        }

    </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="lnkCancel" runat="server"
            Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" OnClick="lnkCancel_Click" />
        <asp:LinkButton ID="lnkSave" runat="server" ValidationGroup="form" OnClick="lnkSave_Click" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

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
    <telerik:RadAjaxPanel ID="RadAjaxpanel3" runat="server" LoadingPanelID="LoadingPanel1">

        <div class="card-body" style="background-color: white; padding: 20px;">
            <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <!--begin::Portlet-->
                        <div class="kt-portlet">

                            <div class="kt-portlet__body">
                                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                    <label class="control-label"></label>
                                    <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                    <div class="col-lg-12 row">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Code <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtCode" runat="server" CssClass="form-control" Width="100%" OnTextChanged="txtCode_TextChanged" AutoPostBack="true"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtCode" ErrorMessage="Please Enter Code" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-6">Product Name <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtPName" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtPName" ErrorMessage="Please Enter Product Name" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-6">Arabic Name </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtArabic" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>

                                            </div>
                                        </div>



                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">
                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-6">Short Name </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtShortName" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Category <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlcatid" runat="server" EmptyMessage="Select Category" CausesValidation="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlcatid_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                                    ControlToValidate="ddlcatid" ErrorMessage="Please Select Category" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>


                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Sub category <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlsubcatid" runat="server" EmptyMessage="Select Sub Category" CausesValidation="false" Width="100%" Filter="Contains"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                                    ControlToValidate="ddlsubcatid" ErrorMessage="Please Select Sub Category" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>



                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Brand <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlbrdid" runat="server" EmptyMessage="Select Sub Brand" CausesValidation="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlbrdid_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                                    ControlToValidate="ddlsubcatid" ErrorMessage="Please Select Brand" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">

                                            <label class="control-label col-lg-12">Return Days </label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtrtndys" runat="server" CssClass="form-control" Width="100%" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Item long Description <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtitemlong" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtitemlong" ErrorMessage="Please Enter item long" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>



                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">
                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Arabic Item long Description </label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtARitemlong" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Sales Hold<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlSalHold" runat="server" Width="100%" DefaultMessage="Please select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlSalHold" ErrorMessage="Please select " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Return Hold<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlRtnHold" runat="server" Width="100%" DefaultMessage="Please select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlRtnHold" ErrorMessage="Please select " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">Order Hold<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlOrdHold" runat="server" Width="100%" DefaultMessage="Please select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlOrdHold" ErrorMessage="Please select " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 mt-1 form-group">
                                            <label class="control-label col-lg-12">Return Request Hold<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlrtnreqhold" runat="server" Width="100%" DefaultMessage="Please select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlrtnreqhold" ErrorMessage="Please select " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mt-1 form-group">
                                            <label class="control-label col-lg-12">Product Type</label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="prd_Type" runat="server" Width="100%" DefaultMessage="Select Product Type" OnSelectedIndexChanged="prd_Type_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="FIELD SERVICE" Value="FS" />
                                                        <telerik:DropDownListItem Text="NORMAL" Value="N" Selected="true" />

                                                    </Items>
                                                </telerik:RadDropDownList>

                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-lg-12 row">


                                        <asp:PlaceHolder runat="server" ID="IsPrdChargable" Visible="false">
                                            <div class="col-lg-4 mt-1 form-group">
                                                <label class="control-label col-lg-12">Is Chargable</label>
                                                <div class="col-lg-12">
                                                    <telerik:RadDropDownList ID="ddprdChargable" runat="server" Width="100%">
                                                        <Items>
                                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                        </Items>
                                                    </telerik:RadDropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" Display="Dynamic" ValidationGroup="form"
                                                        ControlToValidate="ddprdChargable" ErrorMessage="Please select Yes or No" ForeColor="Red"
                                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                        </asp:PlaceHolder>

                                        <div class="col-lg-4 mt-1 form-group">
                                            <label class="control-label col-lg-12">Enable Return Batch<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlEnableRb" runat="server" Width="100%" DefaultMessage="Please select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlEnableRb" ErrorMessage="Please select " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="col-lg-4 mt-1 form-group">
                                            <label class="control-label col-lg-12">Enable Batch<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlIsBatchItem" runat="server" Width="100%" DefaultMessage="Please select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlIsBatchItem" ErrorMessage="Please select " ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="col-lg-4 mt-1 form-group">
                                            <label class="control-label col-lg-12">Status<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlStat" runat="server" Width="100%" DefaultMessage="Please select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                                        <telerik:DropDownListItem Text="Inactive" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="ddlStat" ErrorMessage="Please select Status" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                    </div>


                                </telerik:RadAjaxPanel>
                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                                    BackColor="Transparent"
                                    ForeColor="Blue">
                                    <div class="col-lg-12 text-center mt-5">
                                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                    </div>
                                </telerik:RadAjaxLoadingPanel>
                            </div>
                            <asp:PlaceHolder ID="pnlUOM" runat="server" Visible="false">
                                <!--Uom header-->
                                <div class="kt-portlet__head " style="padding-top: 20px; padding-bottom: 10px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">Add UOM
                                        </h3>
                                    </div>



                                </div>
                                <!--End Uom header-->
                                <div class="kt-portlet__body">
                                    <div class="col-lg-12 row">

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">UOM <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlUom" runat="server" Width="100%" EmptyMessage="Select Uom"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="ddlUom" ErrorMessage="Please choose Uom" Display="Dynamic" ForeColor="Red"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Standard Selling Price <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtStdPrice" runat="server" CssClass="form-control" Width="100%">
                                                    <NumberFormat AllowRounding="true" DecimalDigits="3" />
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="txtStdPrice" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Standard Selling Price"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Return Price <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtrtnPrice" runat="server" CssClass="form-control" Width="100%">
                                                    <NumberFormat AllowRounding="true" DecimalDigits="3" />
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="txtrtnPrice" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Return Price"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">UPC <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtupc" runat="server" CssClass="form-control" Width="100%" NumberFormat-AllowRounding="false" DecimalDigits="0" OnTextChanged="txtupc_TextChanged" AutoPostBack="true"></telerik:RadNumericTextBox>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ValidationGroup="frm"
                                                    ControlToValidate="txtupc" ErrorMessage="Please Enter UPC" ForeColor="Red"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>


                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Default<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlDefault" runat="server" Width="100%" DefaultMessage="please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddlDefault" ErrorMessage="Please select Default" ForeColor="Red" ValidationGroup="frm"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">Disable UOM<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlsaleshold" runat="server" Width="100%" DefaultMessage="please Select">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Yes" Value="Y" />
                                                        <telerik:DropDownListItem Text="No" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddlsaleshold" ErrorMessage="Please select Default" ForeColor="Red" ValidationGroup="frm"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="col-lg-3 form-group" style="padding-top: 10px; padding-bottom: 20px;">
                                            <div class="col-lg-12">
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                                    <asp:LinkButton ID="BtnAdd" runat="server" ValidationGroup="frm" OnClick="BtnAdd_Click" Style="display: inline-grid;" UseSubmitBehavior="false" Text='<i class="icon-ok"></i> Add'
                                                        CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
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
                                <!--Uom Detail header-->
                                <div class="kt-portlet__head" style="padding-top: 10px; padding-bottom: 20px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">UOM Detail
                                        </h3>
                                    </div>
                                </div>
                                <!--End Uom Detail header-->
                                <!--Detail Body-->
                                <div class="kt-portlet__body">
                                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        OnItemCommand="grvRpt_ItemCommand"
                                        OnItemDataBound="grvRpt_ItemDataBound"
                                        OnPreRender="grvRpt_PreRender"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="pru_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>


                                                <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="Edit">
                                                </telerik:GridButtonColumn>

                                                <telerik:GridBoundColumn DataField="udp_EndDayStatus" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="udp_EndDayStatus" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="EndDayStatus" Display="false">
                                                </telerik:GridBoundColumn>

                                                <%--  <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Deletes">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Delete" ID="Delete" Visible="true" AlternateText="Delete" runat="server"
                                                            SetFocusOnError="false"
                                                            ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>

                                                <telerik:GridBoundColumn DataField="uom_Code" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UOM Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Code">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="uom_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Name">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_Price" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Standard Selling Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_Price">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_ReturnPrice" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Return Price" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_ReturnPrice">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_upc" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UPC" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_upc">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_IsDefault" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Default" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_IsDefault">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="isSalesHold" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Disable UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="isSalesHold">
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

                                </div>
                            </asp:PlaceHolder>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to update..??
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
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm1" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnConfim" runat="server" Text="Yes" OnClick="BtnConfim_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm1);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="Success1"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="Okbtn" runat="server" OnClick="Okbtn_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="Success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <%--delete--%>
    <div class="modal fade modal-center" id="modaldelConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="BtnConfrmDelete" runat="server" Text="Yes" OnClick="BtnConfrmDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>


    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>Data Deleted Successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    <!--begin::FailedModal-->
    <div class="modal fade" id="Failmsg" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>UOM Data not inserted.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(Failmsg);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
    <div class="modal fade" id="UPCEXiST" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>UPC Already Exist.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(UPCEXiST);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="kt_modal_1_2" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failres"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_2);">Ok</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
