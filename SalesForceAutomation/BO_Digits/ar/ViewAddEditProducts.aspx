<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditProducts.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewAddEditProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
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
                                            <label class="control-label col-lg-12">شفرة <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtCode" runat="server" CssClass="form-control" Width="100%" OnTextChanged="txtCode_TextChanged" AutoPostBack="true" Enabled="false"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtCode" ErrorMessage="Please Enter Code" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                                <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-6">اسم المنتج <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtPName" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtPName" ErrorMessage="Please Enter Product Name" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-6">الاسم العربي <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtArabic" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtArabic" ErrorMessage="Please Enter Arabic Name" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">فئة <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlcatid" runat="server" EmptyMessage="Select Category" CausesValidation="false" Enabled="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlcatid_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                                    ControlToValidate="ddlcatid" ErrorMessage="Please Select Category" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>


                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">تصنيف فرعي<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlsubcatid" runat="server" EmptyMessage="Select Sub Category" Enabled="false" CausesValidation="false" Width="100%" Filter="Contains"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                                    ControlToValidate="ddlsubcatid" ErrorMessage="Please Select Sub Category" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">ماركة <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlbrdid" runat="server" EmptyMessage="Select Sub Brand" Enabled="false" CausesValidation="false" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlbrdid_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                                    ControlToValidate="ddlsubcatid" ErrorMessage="Please Select Brand" ForeColor="Red" Display="Dynamic"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">

                                        <div class="col-lg-4 form-group">

                                            <label class="control-label col-lg-12">أيام العودة <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtrtndys" runat="server" CssClass="form-control" Enabled="false" Width="100%" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtrtndys" ErrorMessage="Please Enter return days" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">وصف طويل للعنصر <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtitemlong" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtitemlong" ErrorMessage="Please Enter item long" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">الوصف الطويل للمادة العربية <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadTextBox ID="txtARitemlong" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" Display="Dynamic" ValidationGroup="form"
                                                    ControlToValidate="txtARitemlong" ErrorMessage="Please Enter Arabic item long" ForeColor="Red"
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">

                                        <div class="col-lg-4 form-group">
                                            <label class="control-label col-lg-12">حالة<span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlStat" runat="server" Width="100%" Enabled="false">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="نشيط" Value="Y" />
                                                        <telerik:DropDownListItem Text="غير نشط" Value="N" />
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
                                        <h3 class="kt-portlet__head-title">أضف وحدة القياس
                                        </h3>
                                    </div>



                                </div>
                                <!--End Uom header-->
                                <div class="kt-portlet__body">
                                    <div class="col-lg-12 row">

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">وحدة قياس <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadComboBox ID="ddlUom" runat="server" Width="100%" EmptyMessage="حدد وحدة القياس" Enabled="false"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="ddlUom" ErrorMessage="Please choose Uom" Display="Dynamic" ForeColor="Red"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">سعر البيع القياسي <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtStdPrice" NumberFormat-DecimalDigits="0" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="txtStdPrice" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Standard Selling Price"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">سعر الإرجاع <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtrtnPrice" NumberFormat-DecimalDigits="0" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ValidationGroup="frm"
                                                    ControlToValidate="txtrtnPrice" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Return Price"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">وحدة لكل حالة <span class="required"></span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadNumericTextBox ID="txtupc" runat="server" CssClass="form-control" RenderMode="Lightweight" Enabled="false" Width="100%" NumberFormat-AllowRounding="false" DecimalDigits="0"></telerik:RadNumericTextBox>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ValidationGroup="frm"
                                                    ControlToValidate="txtupc" ErrorMessage="Please Enter UPC" ForeColor="Red"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>


                                    </div>
                                    <div class="col-lg-12 row" style="padding-top: 10px;">

                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">تقصير<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlDefault" runat="server" Width="100%" DefaultMessage="الرجاء التحديد" Enabled="false">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="نعم" Value="Y" />
                                                        <telerik:DropDownListItem Text="لا" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddlDefault" ErrorMessage="Please select Default" ForeColor="Red" ValidationGroup="frm"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label class="control-label col-lg-12">تعليق المبيعات<span class="required"> </span></label>
                                            <div class="col-lg-12">
                                                <telerik:RadDropDownList ID="ddlsaleshold" runat="server" Width="100%" DefaultMessage="الرجاء التحديد" Enabled="false">
                                                    <Items>
                                                        <telerik:DropDownListItem Text="نعم" Value="Y" />
                                                        <telerik:DropDownListItem Text="لا" Value="N" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" Display="Dynamic"
                                                    ControlToValidate="ddlsaleshold" ErrorMessage="Please select Default" ForeColor="Red" ValidationGroup="frm"
                                                    SetFocusOnError="false"></asp:RequiredFieldValidator>

                                            </div>
                                        </div>

                                        <div class="col-lg-3 form-group" style="padding-top: 10px; padding-bottom: 20px;">
                                            <div class="col-lg-12">
                                               <%-- <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                                    <asp:LinkButton ID="BtnAdd" runat="server" ValidationGroup="frm" OnClick="BtnAdd_Click" Style="display: inline-grid;" UseSubmitBehavior="false" Text='<i class="icon-ok"></i> Add'
                                                        CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center mt-5">
                                                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--Uom Detail header-->
                                <div class="kt-portlet__head" style="padding-top: 10px; padding-bottom: 20px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">تعليق المبيعات
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

<%--                                                <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Delete">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Delete" ID="Delete" Visible="true" AlternateText="Delete" runat="server"
                                                            SetFocusOnError="false"
                                                            ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>

                                                <telerik:GridBoundColumn DataField="uom_Code" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="كود وحدة القياس" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Code">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="uom_Name" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وحدة قياس" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Name">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="uom_ArabicName" AllowFiltering="true" HeaderStyle-Width="140px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وحدة القياس باللغة العربية" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_ArabicName">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_Price" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="سعر البيع القياسي" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_Price">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_ReturnPrice" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="سعر الإرجاع" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_ReturnPrice">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_upc" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="وحدة لكل حالة" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_upc">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pru_IsDefault" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تقصير" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pru_IsDefault">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="isSalesHold" AllowFiltering="true" HeaderStyle-Width="90px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="تعليق المبيعات" FilterControlWidth="100%"
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
</asp:Content>

