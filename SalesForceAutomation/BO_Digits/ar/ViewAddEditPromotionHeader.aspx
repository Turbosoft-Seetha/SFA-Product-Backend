<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditPromotionHeader.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewAddEditPromotionHeader" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color:white; padding:20px;">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">

                    <div class="kt-portlet__body">
                         <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                              
                        <div class="col-lg-12 row">

                            <asp:PlaceHolder runat="server" ID="Num">
                             <div class="col-lg-4 form-group" style="padding-top:9px;">
                                <label class="control-label col-lg-12">رقم</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtNumber" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                </div>
                            </div>
                           </asp:PlaceHolder>

                            <div class="col-lg-4 form-group" style="padding-top:9px;">
                                <label class="control-label col-lg-12">اسم</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                        ControlToValidate="txtName" ErrorMessage="Please Enter Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                             

                            <div class="col-lg-4 form-group" style="padding-top:9px;">
                                <label class="control-label col-lg-12">نوع الترويج</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Enabled="false" Filter="Contains" EmptyMessage="Select Type" CausesValidation="false"
                                           >
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="ddlType" ErrorMessage="Please Select Type" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top:9px;">
                                <label class="control-label col-lg-12">مؤهل</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlQualificaiton" runat="server" Width="100%" Enabled="false" Filter="Contains" EmptyMessage="Select Qualificaiton"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="ddlQualificaiton" ErrorMessage="Please Select Qualificaiton" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                             
                            <asp:PlaceHolder runat="server" ID="asg">                            
                            <div class="col-lg-4 form-group" style="padding-top:9px;">
                                <label class="control-label col-lg-12">تكليف</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlAssignment" runat="server" Width="100%" Enabled="false" Filter="Contains" EmptyMessage="Select Assignment"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="ddlAssignment" ErrorMessage="Please Select Assignment" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                            </asp:PlaceHolder>

                            <div class="col-lg-4 form-group" style="padding-top:9px;" hidden="hidden">
                                <label class="control-label col-lg-12">كرر المدى</label>
                                <div class="col-lg-12">
                                    <%-- <telerik:RadNumericTextBox ID="txtRepeatRngs" runat="server" CssClass="form-control"  Width="100%"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                        ControlToValidate="txtRepeatRngs" ErrorMessage="Please Enter Repeat Range" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                    <telerik:RadDropDownList ID="ddlrange" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="0" Value="0" Selected="true" />
                                            <telerik:DropDownListItem Text="1" Value="1" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" style="padding-top:9px;">
                                <label class="control-label col-lg-12">حالة</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="ممكن" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="عاجز" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
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
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
   
</asp:Content>