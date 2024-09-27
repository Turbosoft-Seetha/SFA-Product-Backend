function initMapX(checkboxArray, start , end) {
    const directionsService = new google.maps.DirectionsService();
    const directionsRenderer = new google.maps.DirectionsRenderer();
    const map = new google.maps.Map(document.getElementById("map"), {
        zoom: 6,
        center: { lat: 24.988841736100394, lng: 55.193270228191224 },
    });
    directionsRenderer.setMap(map);
   
    calculateAndDisplayRoute(directionsService, directionsRenderer, checkboxArray, start , end);
}

function calculateAndDisplayRoute(directionsService, directionsRenderer, checkboxArray , start, end) {
    const waypts = [];
    
    for (let i = 0; i < checkboxArray.length; i++) {
        waypts.push({
            location: checkboxArray[i],
            stopover: true,
        });
    }
    
    directionsService
        .route({
            origin: start,
            destination: end,
            waypoints: waypts,
            optimizeWaypoints: true,
            travelMode: google.maps.TravelMode.DRIVING,
        })
        .then((response) => {
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
        })
        .catch((e) => window.alert("System Cannot find the actual geocodes" ));
}