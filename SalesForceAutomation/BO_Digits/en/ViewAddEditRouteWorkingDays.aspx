<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditRouteWorkingDays.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ViewAddEditRouteWorkingDays" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color:white; padding:20px;">
                    
                   
                    <div class="kt-portlet__body">
                        <div class="col-lg-12 row">


                             <div class="col-lg-4 form-group">
                                    
                                        <label class="control-label col-lg-12 ">Month </label>
                                 
                                    <div class="col-lg-12">
                                        <telerik:RadMonthYearPicker ID="radmonth" DateInput-DateFormat="yyyy-MMM" runat="server" MinDate="2022-01-01"
                                            Width="100%">
                                        </telerik:RadMonthYearPicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                        ControlToValidate="radmonth" ErrorMessage="Please Choose Date" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                            
                           <div class="col-lg-4 form-group" >
                                <label class="control-label col-lg-12">Working Days</label>
                                <div class="col-lg-12">
                                    <telerik:RadNumericTextBox ID="txtworkdays" runat="server" CssClass="form-control" NumberFormat-AllowRounding="false" DecimalDigits="0"  Width="100%"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtworkdays" ErrorMessage="Please Enter Working Days" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                           
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">Status</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%">
                                        <items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                        </div>

                       

                    </div>
                </div>
            </div>
        </div>
    </div>

   
    
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
