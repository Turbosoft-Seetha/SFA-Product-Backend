<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="RouteDashboards.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.RouteDashboards" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <link href="../assets/style.bundle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="kt-portlet">
            <div class="kt-portlet__head" style="padding: 0px; border-bottom: 0px;">
                <div class="kt-portlet__head-label row" style="padding-bottom: 10px">
                    <div class="col-lg-12 row">
                        <div class="col-lg-2" style="width: 150px;">
                            <label class="control-label col-lg-12">Depot</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddldepot" runat="server" EmptyMessage="Select Depot" Width="100%" OnSelectedIndexChanged="ddldepot_SelectedIndexChanged" AutoPostBack="true">
                                </telerik:RadComboBox>

                            </div>
                        </div>
                        <div class="col-lg-2" style="width: 150px;">
                            <label class="control-label col-lg-12">Area</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddlDpoArea" runat="server" EmptyMessage="Select Area" Width="100%" OnSelectedIndexChanged="ddlDpoArea_SelectedIndexChanged">
                                </telerik:RadComboBox>

                            </div>
                        </div>
                        <div class="col-lg-2" style="width: 150px;">
                            <label class="control-label col-lg-12">Subarea</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" RenderMode="Lightweight"
                                    ID="ddlDpoSubArea" runat="server" EmptyMessage="Select Subarea" Width="100%" OnSelectedIndexChanged="ddlDpoSubArea_SelectedIndexChanged">
                                </telerik:RadComboBox>

                            </div>
                        </div>
                        <div class="col-lg-2" style="width: 140px;">
                            <label class="control-label col-lg-12">Route</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="ddlRoute" runat="server" EmptyMessage="Select Route" Filter="Contains" Width="100%" RenderMode="Lightweight" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged"></telerik:RadComboBox>
                            </div>
                        </div>

                        <div class="col-lg-2" style="width: 130px;">
                            <label class="control-label col-lg-12">Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" runat="server" DateInput-DateFormat="dd-MM-yyyy" Width="100%">
                                </telerik:RadDatePicker>
                            </div>
                        </div>



                        <div class="col-lg-2" style="text-align: center; padding-top: 10px; top: 19px; padding-left: 0px;">
                            <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2 myLink" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkFilter_Click">
                                                    Apply Filter
                            </asp:LinkButton>
                        </div>
                        <div class="col-lg-2" style="padding-top: 10px; justify-content: flex-end; margin-left: -36px; width: 165px; padding-left: 10px;">
                            <asp:LinkButton ID="btnVanStock" runat="server" CssClass="btn btn-sm  btn-primary" OnClick="btnVanStock_Click">
                                                    Current Van Stock
                            </asp:LinkButton>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
