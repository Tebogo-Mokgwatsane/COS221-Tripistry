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
        flightDiv.classList.add("flight");
        flightDiv.innerHTML = `
        <div class="flight-item" >
            <img class="flight-image" src="${flight.img_url}" alt="${flight.airline_name}">
            <div class="flight-info">
                <h1>${flight.airline_name}</h1>
                <p class="price">Price: R${Number(flight.Price).toFixed(2)}</p>
                <p> <span>From: ${flight.departure_airport}</span></p>
                <p>To: ${flight.arrival_airport}</p>
                <p>Departure: ${flight.dept_date}</p>
                <p>Arrival: ${flight.arrival_date}</p>
                <p>Class: ${flight.classes}</p>
            </div>
        </div>
        `;
        flightsContainer.appendChild(flightDiv);
    });
}





