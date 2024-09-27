<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ViewAddEditRoute" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
  
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <br />
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">



                    <div class="kt-portlet__body">

                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                        <div class="col-lg-12 row"><b>Basic Info </b></div>
                        <br />
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                            <div class="col-lg-12 row">

                                <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">Route Code <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%"  AutoPostBack="true"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtcode" ErrorMessage="Please Enter  Code" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">Route Name <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtname" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtname" ErrorMessage="Please Enter   Name" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">Arabic Name <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtArabicname" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtArabicname" ErrorMessage="Please Enter Arabic Name" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                            </div>

                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                        <div class="col-lg-12 row" style="padding-top: 9px;">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Route Type <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlrotType" runat="server" Width="100%" DefaultMessage="Select Route Type" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="AR" Value="AR" />
                                            <telerik:DropDownListItem Text="MERCHANDISING" Value="MER" />
                                            <telerik:DropDownListItem Text="NORMAL" Value="NR" />
                                            <telerik:DropDownListItem Text="ORDER" Value="OR" />
                                            <telerik:DropDownListItem Text="SALES" Value="SL" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Route Password <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtpass" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtpass" ErrorMessage="<br/>Please Enter password" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Productive Modes <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlpromodes" runat="server" Width="100%" DefaultMessage="Select  Productive Modes" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="AR" Value="AR" />
                                            <telerik:DropDownListItem Text="MERCHANDISING" Value="MER" />
                                            <telerik:DropDownListItem Text="ORDER" Value="OR" />
                                            <telerik:DropDownListItem Text="SALES" Value="SL" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">User Name <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlname" runat="server" EmptyMessage="Select User Name" CausesValidation="false" Width="100%" Filter="Contains" Enabled="false"></telerik:RadComboBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlname" ErrorMessage="Please select User Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Device ID <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <%--<telerik:RadNumericTextBox ID="txtdevid" runat="server" CssClass="form-control" Width="90%"></telerik:RadNumericTextBox>--%>

                                    <telerik:RadTextBox ID="txtdeviceid" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtdeviceid" ErrorMessage="<br/>Please Enter Device Id" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Depot SubArea <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlDepot" runat="server" EmptyMessage="Select Depot SubArea" CausesValidation="false" Width="100%" Filter="Contains" Enabled="false"></telerik:RadComboBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlDepot" ErrorMessage="Please select Depot SubArea" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-12 row" style="padding-top: 9px;">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Status <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStats" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>


                            </div>

                        </div>

                        <br />

                        <div class="col-lg-12 row"><b>Settings </b></div>
                        <br />

                        <div class="col-lg-12 row">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Allow settlement Discrepancy<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlstlmnt" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" hidden="hidden">
                                <label class="control-label col-lg-12">Enforce Journey Plan <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlenforcejp" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="No" Value="N" Selected="true" />
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />

                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Enable Odometer<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlodometer" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Isunload<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlis" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select UnLoad">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Routine Check<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlRC" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Routine Check">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Enable loadIn Sign<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLIS" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Enable LoadIn Sign">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Enable Load Transfer Sign<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLTS" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Enable Load Transfer Sign">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Enable LoadOut Sign<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLOS" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Enable LoadOut Sign">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Load Request<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLR" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Load Request">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Load Transfer<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLT" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Load Transfer">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">LoadIn Edit<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLEdit" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select LoadIn Edit">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">LoadOut Edit<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLOEdit" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select LoadOut Edit">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">LoadOut Excess Allow<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLOExcess" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select LoadOut Excess Allow">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Payment Mode</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlpaymode" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Payment Mode" Enabled="false">
                                        <Items>

                                            <telerik:RadComboBoxItem Text="OP" Value="OP" />
                                            <telerik:RadComboBoxItem Text="POS" Value="POS" />
                                            <telerik:RadComboBoxItem Text="Hard Cash" Value="HC" />

                                        </Items>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlpaymode" ErrorMessage="Please Select Payment Mode" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Enable Suggested Load Req<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbsugloreq" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Please Select ">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Return Type<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbreturnType" runat="server" Width="100%" Enabled="false"
                                        DefaultMessage="Please Select ">
                                        <Items>
                                            <telerik:DropDownListItem Text="Normal" Value="NR"  />
                                            <telerik:DropDownListItem Text="Controlled" Value="CR" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Enable Load Rejection<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbLodRej" runat="server" Width="100%" Enabled="false"
                                        DefaultMessage="Please Select ">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y"  />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Enable Van to Van<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbVantoVan" runat="server" Width="100%" Enabled="false"
                                        DefaultMessage="Please Select ">
                                        <Items>
                                            <telerik:DropDownListItem Text="Yes" Value="Y" />
                                            <telerik:DropDownListItem Text="No" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

   
</asp:Content><asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
