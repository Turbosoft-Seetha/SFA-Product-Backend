<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditSpecialPrice.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewAddEditSpecialPrice" %>
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
                        <div class="col-lg-12 row">
                            <asp:PlaceHolder runat="server" ID="divcode" >
                              <div class="col-lg-3 form-group" >
                                <label class="control-label col-lg-12">شفرة</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                 </div>
                            </div>
                            </asp:PlaceHolder>

                           <div class="col-lg-3 form-group" >
                                <label class="control-label col-lg-12">اسم</label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtname" runat="server" CssClass="form-control"  Width="100%" Enabled="false"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                        ControlToValidate="txtname" ErrorMessage="Please choose Price List Header Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                          <%--  <div class="col-lg-3 form-group" >
                                <label class="control-label col-lg-12">Payment Mode</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlPayMode" runat="server" DefaultMessage="Select Payment Mode" EmptyMessage="Select Payment Mode" Width="100%">
                                    <items>
                                            <telerik:DropDownListItem Text="Hard Cash" Value="HC" Selected="true" />
                                            <telerik:DropDownListItem Text="Credit" Value="CR" />
                                            <telerik:DropDownListItem Text="POS" Value="POS" />
                                            <telerik:DropDownListItem Text="Online Payment" Value="OP" />
                                     </items>
                                    </telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="ddlPayMode" ErrorMessage="Please choose payment mode" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>--%>

                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">حالة</label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%"  Enabled="false">
                                        <items>
                                            <telerik:DropDownListItem Text="نشيط" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="غير نشط" Value="N" />
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
             </div>
</asp:Content>
