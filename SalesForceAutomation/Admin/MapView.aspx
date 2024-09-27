<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SalesForceAutomation.Master" AutoEventWireup="true" CodeBehind="MapView.aspx.cs" Inherits="SalesForceAutomation.Admin.MapView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">

      <script src="WayPoints/waypoints.js"></script>

      <%--<script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAo68pO8GJWfgkQtcr6UyogsUcMCETbBTI&callback=PlotMap&libraries=&v=weekly" async></script>--%>
 
    <script>

        function PlotMap(geoCodes, cusNames, DtFormat, types) {

            const checkboxArray = geoCodes.split('-');
            const CheckboxName = cusNames.split('{0}');
            const CheckboxDt = DtFormat.split('{0}');
            const Checkboxtp = types.split('{0}');
            //const checkboxArray = ["25.2768536,55.3482438" ];
            //alert(checkboxArray)
            //$('#MapAlert').modal('show');
            initMapX(checkboxArray, CheckboxName, CheckboxDt, Checkboxtp);
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="map" style="height: 800px; width: inherit"></div>




</asp:Content>
