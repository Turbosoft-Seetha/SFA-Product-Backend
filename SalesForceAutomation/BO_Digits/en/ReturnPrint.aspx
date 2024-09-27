<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ReturnPrint.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ReturnPrint" %>
<%@ Register assembly="Stimulsoft.Report.Web,Version=2024.1.3.0, Culture=neutral, PublicKeyToken=ebe6666cba19647a" namespace="Stimulsoft.Report.Web" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <cc1:StiWebViewer ID="StiWebViewer1" runat="server"
		OnGetReport="StiWebViewer1_GetReport">
	</cc1:StiWebViewer>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
