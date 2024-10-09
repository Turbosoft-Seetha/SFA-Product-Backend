<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AssignPagesAlongRoles.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AssignPagesAlongRoles" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <div class="kt-portlet__body">
                            <label class="control-label"></label>
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="row" style="margin-bottom: 20px;">
                                <div class="col-lg-6">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">All Pages</h3>
                                    </div>

                                    <asp:UpdatePanel ID="pnlNavigation" runat="server" ChildrenAsTriggers="true">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td style="vertical-align: top;">
                                                        <telerik:RadTreeView ID="treeSecurity" RenderMode="Lightweight" runat="server" OnNodeClick="treeSecurity_NodeClick"
                                                            BorderStyle="Solid" BorderWidth="1px" EnableDragAndDrop="false" Font-Size="Medium"
                                                            EnableDragAndDropBetweenNodes="false" Width="400px">
                                                        </telerik:RadTreeView>
                                                    </td>
                                                    <td style="vertical-align: top;">
                                                        <asp:CheckBoxList ID="chkRoles" runat="server" CssClass="border form-control" Style="border-color: #000204 !important" OnSelectedIndexChanged="chkRoles_SelectedIndexChanged" AutoPostBack="True" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-lg-6">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">Assigned Pages</h3>
                                    </div>

                                    <asp:UpdatePanel ID="pnlAssigned" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <telerik:RadTreeView ID="treeAssigned" RenderMode="Lightweight" runat="server"
                                                OnNodeClick="treeAssigned_NodeClick"
                                                BorderStyle="Solid" BorderWidth="1px" EnableDragAndDrop="false"
                                                Font-Size="Medium" EnableDragAndDropBetweenNodes="false" Width="400px">
                                            </telerik:RadTreeView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>


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
    <a href="javascript:;" class="page-quick-sidebar-toggler">
        <i class="icon-login"></i>
    </a>
</asp:Content>
