let flights = [];

fetch('get_flights.php')
    .then( status => {
        if (!status.ok) {
            throw new Error('Network response was not ok');
        }
        return status.json();
    })
    .then(response => {
        if (response.status !== 'success') {
            throw new Error('API error: ' + response.message);
        }
        return response.data;
    })
    .then(data => {
        flights = data;
        showFlights(flights);
    })
    .catch(error => {
        console.error('Error fetching flights:', error);
    });
const showFlights = (flights) => {
    const flightsContainer = document.getElementById("flights");
    flightsContainer.innerHTML = "";

    flights.forEach(flight => {
        const flightDiv = document.createElement("div");
        flightDiv.classList.add("flight-item");
        flightDiv.innerHTML = `
            <h1>${flight.airline_name}</h1>
            <p>Price: $${Number(flight.Price).toFixed(2)}</p>
            <p> From: ${flight.departure_airport}</p>
            <p>To: ${flight.arrival_airport}</p>
            <p>Departure: ${flight.dept_date}</p>
            <p>Arrival: ${flight.arrival_datetime}</p>
            <p>Class: ${flight.classes}</p>
        `;
        flightsContainer.appendChild(flightDiv);
    });
}





