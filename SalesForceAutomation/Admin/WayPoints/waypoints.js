function initMapX(checkboxArray, CheckboxName, CheckboxDt, Checkboxtp) {

    alert('sad')
    const directionsService = new google.maps.DirectionsService();
    const directionsRenderer = new google.maps.DirectionsRenderer();
    const map = new google.maps.Map(document.getElementById("map"), {
        zoom: 6,
        center: { lat: 24.988841736100394, lng: 55.193270228191224 },
    });
    directionsRenderer.setMap(map);

    calculateAndDisplayRoute(directionsService, directionsRenderer, checkboxArray, CheckboxName, CheckboxDt, Checkboxtp);
}

function calculateAndDisplayRoute(directionsService, directionsRenderer, checkboxArray, CheckboxName, CheckboxDt, Checkboxtp) {
    const waypts = [];

    for (let i = 0; i < checkboxArray.length; i++) {
        waypts.push({
            location: checkboxArray[i],
            stopover: true,
        });
    }

    directionsService
        .route({
            origin: checkboxArray[0],
            destination: checkboxArray[checkboxArray.length - 1],
            waypoints: waypts,
            optimizeWaypoints: true,
            travelMode: google.maps.TravelMode.DRIVING,
        })
        .then((response) => {
            directionsRenderer.setDirections(response);
            const route = response.routes[0];
            const summaryPanel = document.getElementById("directions-panel");
            document.getElementById("directions-panel").innerHTML = "";
            summaryPanel.innerHTML = "";

            summaryPanel.innerHTML +=
                "<b>Trip Started From: " + CheckboxName[0] + " at " + CheckboxDt[0] + " <br> GeoLocation:" + route.legs[0].start_address + "</b><br><br>";


            // For each route, display summary information.
            for (let i = 1; i < route.legs.length; i++) {

                const routeSegment = i;

                if (Checkboxtp[i] == "4") {
                    summaryPanel.innerHTML +=
                        "<b>Trip Ended at: " + CheckboxDt[i] + " <br> GeoLocation:" + route.legs[i].end_address + "</b><br>";
                } else if (Checkboxtp[i] == "2") {
                    summaryPanel.innerHTML +=
                        "<b>Customer Visit: " + routeSegment + "</b><br>";
                    summaryPanel.innerHTML += "Customer Name :  " + CheckboxName[i] + " at " + CheckboxDt[0] + " <br>";
                    summaryPanel.innerHTML += route.legs[i].start_address + " <b>to </b>";
                    summaryPanel.innerHTML += route.legs[i].end_address + "<br>";
                    summaryPanel.innerHTML += route.legs[i].distance.text + "<br><br>";
                } else if (Checkboxtp[i] == "2") {
                    summaryPanel.innerHTML +=
                        "<b>Current Location at : " + CheckboxName[i] + " at " + CheckboxDt[i] + " <br> GeoLocation:" + route.legs[i].end_address + "</b><br>";
                }
            }
        })
        .catch((e) => window.alert("System Cannot find the actual geocodes"));
}