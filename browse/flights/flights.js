fetch('flights.php')
.then(flights => {
    const cardsContainer = document.getElementById("flights");
    cartsContainer.innerHTML = "";

    flights.forEach(flight => {
        const flightDiv = document.createElement("div");
        flightCard.classList.add("flight-item");
        flightCard.innerHTML = `
            <h1>${flight.airline_name}</h1>
            <p>Price: $${Number(flight.Price).toFixed(2)}</p>
            <p>From: ${flight.departure_airport}</p>
            <p>To: ${flight.arrival_airport}</p>
            <p>Departure: ${flight.dept_date}</p>
            <p>Arrival: ${flight.arrival_datetime}</p>
            <p>Class: ${flight.classes}</p>
        `;
        cardsContainer.appendChild(flightCard);
    });
})
.catch(error => {
    console.error('Error fetching flights:', error);
});


