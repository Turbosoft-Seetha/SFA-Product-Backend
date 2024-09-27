<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="SettlementReport.aspx.cs" Inherits="SalesForceAutomation.Admin.SettlementReport" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <link rel="stylesheet" href="assets/settlement-styles.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="demo-container size-medium">
        <telerik:RadWizard RenderMode="Lightweight" ID="RadWizard1" runat="server" Height="350px">
            <WizardSteps>
                <telerik:RadWizardStep Title="Orders Report" CssClass="loginStep">
                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserNameTextBox" Text="User name:"></asp:Label>
                    <telerik:RadTextBox RenderMode="Lightweight" ID="UserNameTextBox" runat="server" ></telerik:RadTextBox>
                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox" Text="Password:"></asp:Label>
                    <telerik:RadTextBox RenderMode="Lightweight" ID="PasswordTextBox" runat="server" ></telerik:RadTextBox>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep Title="Credit Invoices">
                    <label>Please select a data base file:</label>
                    <telerik:RadAsyncUpload RenderMode="Lightweight" ID="DataBaseUpload" runat="server"  AllowedFileExtensions=".mdf"></telerik:RadAsyncUpload>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep Title="Cash Invoices">
                    <label>Number of visiting users:</label>
                    <telerik:RadComboBox RenderMode="Lightweight" ID="UsersNumber" runat="server"  Width="300px">
                        <Items>
                            <telerik:RadComboBoxItem Text="50-100 Users" Value="50" />
                            <telerik:RadComboBoxItem Text="500-1000 Users" Value="500" />
                            <telerik:RadComboBoxItem Text="Above 2000" Value="2000" />
                        </Items>
                    </telerik:RadComboBox>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep Title="AR Collections">
                    <asp:Label ID="Label1" runat="server" AssociatedControlID="UserNameTextBox" Text="User name:"></asp:Label>
                    <telerik:RadTextBox RenderMode="Lightweight" ID="RadTextBox1" runat="server" ></telerik:RadTextBox>
                    <asp:Label ID="Label2" runat="server" AssociatedControlID="PasswordTextBox" Text="Password:"></asp:Label>
                    <telerik:RadTextBox RenderMode="Lightweight" ID="RadTextBox2" runat="server" ></telerik:RadTextBox>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep Title="Advance Collections">
                    <label>Please select a data base file:</label>
                    <telerik:RadAsyncUpload RenderMode="Lightweight" ID="RadAsyncUpload1" runat="server"  AllowedFileExtensions=".mdf"></telerik:RadAsyncUpload>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep Title="Payment">
                    <label>Number of visiting users:</label>
                    <telerik:RadComboBox RenderMode="Lightweight" ID="RadComboBox1" runat="server"  Width="300px">
                        <Items>
                            <telerik:RadComboBoxItem Text="50-100 Users" Value="50" />
                            <telerik:RadComboBoxItem Text="500-1000 Users" Value="500" />
                            <telerik:RadComboBoxItem Text="Above 2000" Value="2000" />
                        </Items>
                    </telerik:RadComboBox>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>
    
</asp:Content>


