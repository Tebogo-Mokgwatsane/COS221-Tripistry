let flights = [];

const loadPage = (page = 1) => {
  fetch(`get_flights.php?page=${page}`)
    .then((status) => status.json())
    .then((response) => {
      if (response.status !== "success") throw new Error(response.message);
      flights = response.data;
      showFlights(flights);
      updatePaginationButtons(response.currentPage, response.totalPages);
    })
    .catch((error) => console.error("Error:", error));
};

const showFlights = (flights) => {
    const flightsContainer = document.getElementById("flights");
    flightsContainer.innerHTML = "";

    flights.forEach(flight => {
        const flightDiv = document.createElement("div");
        flightDiv.classList.add("flight-item");
        flightDiv.innerHTML = `
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
        `;
        flightsContainer.appendChild(flightDiv);
    });
}

 const updatePaginationButtons = (current, total) => {
  document.getElementById("prevBtn").disabled = current === 1;
  document.getElementById("nextBtn").disabled = current === total;
  document.getElementById("pageInfo").textContent =
    `Page ${current} of ${total}`;

  document.getElementById("prevBtn").onclick = () => loadPage(current - 1);
  document.getElementById("nextBtn").onclick = () => loadPage(current + 1);
 };

loadPage(1);





