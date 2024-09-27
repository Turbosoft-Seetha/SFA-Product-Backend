<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RouteMap.aspx.cs" Inherits="SalesForceAutomation.Admin.RouteMap" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

       <script src="WayPoints/waypoints.js"></script>

      <script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAo68pO8GJWfgkQtcr6UyogsUcMCETbBTI&libraries=&v=weekly" async></script>
    <script>

        function PlotMap(geoCodes, cusNames, DtFormat, types) {
            alert('sad');
            const checkboxArray = geoCodes.split('-');
            const CheckboxName = cusNames.split('{0}');
            const CheckboxDt = DtFormat.split('{0}');
            const Checkboxtp = types.split('{0}');
            initMapX(checkboxArray, CheckboxName, CheckboxDt, Checkboxtp);
        }

    </script>
   
</head>
<body>

  

     <div id="map" style="height: 800px; width: inherit"></div>


   
    

</body>
</html>
