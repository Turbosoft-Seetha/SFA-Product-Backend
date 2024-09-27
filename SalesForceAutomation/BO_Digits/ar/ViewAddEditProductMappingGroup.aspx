<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditProductMappingGroup.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewAddEditProductMappingGroup" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Actions" runat="server">
                        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
      <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color:white; padding:20px;">
                    <%--<div class="kt-portlet__head" style="padding-top: 20px">

                        <span class="kt-subheader__separator kt-hidden"></span>
                        
                    </div>--%>
                  <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                    <div class="kt-portlet__body">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"  >
                        <label class="control-label"></label>
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                        <div class="col-lg-12 row">

                             <div class="col-lg-4 form-group">

                                <label class="control-label col-lg-12">شفرة <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtCode" runat="server" CssClass="form-control" width="100%" Enabled="false" ></telerik:RadTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtCode" ErrorMessage="Please Enter Code" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                            <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>

                                </div>
                            </div>
                           
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-6">اسم <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" width="100%" Enabled="false"></telerik:RadTextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="txtName" ErrorMessage="Please fill this field" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                </div>
                            </div>
                           

                             
                            
                            <div class="col-lg-4 form-group">
                                  <label class="control-label col-lg-12">حالة<span class="required"> </span></label>
                                  <div class="col-lg-12">
                                  <telerik:RadDropDownList ID="ddlStat" runat="server" Width="100%" Enabled="false" >
                                  <items>
                                  <telerik:DropDownListItem Text="نشيط" Value="Y"  />
                                  <telerik:DropDownListItem Text="غير نشط" Value="N" />
                                  </items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="form"
                                        ControlToValidate="ddlStat" ErrorMessage="Please select Status" ForeColor="Red"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 </div>
                             </div>




                        </div>
                        </telerik:RadAjaxPanel>
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
    
   
</asp:Content>
