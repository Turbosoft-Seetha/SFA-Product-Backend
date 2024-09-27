function initMap() {
    const directionsService = new google.maps.DirectionsService();
    const directionsRenderer = new google.maps.DirectionsRenderer();
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 6,
      center: { lat: 25.070572043757984, lng: 55.13914434840484 }
    });
    directionsRenderer.setMap(map);
    document.getElementById("submit").addEventListener("click", () => {
      calculateAndDisplayRoute(directionsService, directionsRenderer);
    });
  }
  
  function calculateAndDisplayRoute(directionsService, directionsRenderer) {
    const waypts = [];
    const checkboxArray = document.getElementById("waypoints");
  
    for (let i = 0; i < checkboxArray.length; i++) {
      if (checkboxArray.options[i].selected) {
        waypts.push({
          location: checkboxArray[i].value,
          stopover: true,
        });
      }
    }
    directionsService.route(
      {
        origin: document.getElementById("start").value,
        destination: document.getElementById("end").value,
        waypoints: waypts,
        optimizeWaypoints: true,
        travelMode: google.maps.TravelMode.DRIVING,
      },
      (response, status) => {
        if (status === "OK" && response) {
          directionsRenderer.setDirections(response);
          const route = response.routes[0];
          const summaryPanel = document.getElementById("directions-panel");
          summaryPanel.innerHTML = "";
  
          // For each route, display summary information.
          for (let i = 0; i < route.legs.length; i++) {
            const routeSegment = i + 1;
            summaryPanel.innerHTML +=
              "<b>Route Segment: " + routeSegment + "</b><br>";
            summaryPanel.innerHTML += route.legs[i].start_address + " to ";
            summaryPanel.innerHTML += route.legs[i].end_address + "<br>";
            summaryPanel.innerHTML += route.legs[i].distance.text + "<br><br>";
          }
        } else {
          window.alert("Directions request failed due to " + status);
        }
      }
    );
  }

// function initMap() {
//     const map = new google.maps.Map(document.getElementById("map"), {
//       zoom: 3,
//       center: { lat: 0, lng: -180 },
//       mapTypeId: google.maps.MapTypeId.ROADMAP,
//     });
//     const flightPlanCoordinates = [
//       { lat: 37.772, lng: -122.214 },
//       { lat: 21.291, lng: -157.821 },
//       { lat: -18.142, lng: 178.431 },
//       { lat: -27.467, lng: 153.027 },
//       { lat:  37.91569836485348, lng: 127.55665296744509 },
//       { lat: 37.772, lng: -122.214 },
//       { lat: -27.467, lng: 153.027 },
//     ];

//     var locations = [
//         ['Bondi Beachasdasdas ahsdhasd <br/>assadasd <br>asdasdasd', 37.772, -122.214 , "http://maps.google.com/mapfiles/ms/icons/red-dot.png"],
//         ['Coogee Beach', 21.291, -157.821 , "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"],
//         ['Cronulla Beach', -18.142, 178.431 , "http://maps.google.com/mapfiles/ms/icons/red-dot.png"],
//         ['Manly Beach', -33.80010128657071, 151.28747820854187, "http://maps.google.com/mapfiles/ms/icons/red-dot.png"],
//         ['Maroubra Beach', -33.950198, 151.259302, "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"]
//       ];

//     const flightPath = new google.maps.Polyline({
//       path: flightPlanCoordinates,
//       geodesic: true,
//       strokeColor: "#FF0000",
//       strokeOpacity: 1.0,
//       strokeWeight: 2,
//       polylineName: 5
//     });
//     flightPath.setMap(map);
//     var infowindow = new google.maps.InfoWindow();
    

//     var marker, i;

//     for (i = 0; i < locations.length; i++) {  
//       marker = new google.maps.Marker({
//         position: new google.maps.LatLng(locations[i][1], locations[i][2]),
//         map: map,
//         icon: { url: locations[i][3]  }
//         // 
//       });
      
//       google.maps.event.addListener(marker, 'click', (function(marker, i) {
//         return function() {
//           infowindow.setContent(locations[i][0]);
//           infowindow.open(map, marker);
//         }
//       })(marker, i));
//     }
    
//     // marker.setMap(map);

//   }