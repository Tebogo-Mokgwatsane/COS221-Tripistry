
let flights = [];
let selectedClasses = [];
let currentPage = 1;
const itemsPerPage = 18;

const loadPage = () => {
  document.getElementById("flights").innerHTML =
    `<p style="color:#888;">Loading flights...</p>`;

  fetch("/api.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      type: "Flights",
    }),
  })
    .then((res) => res.json())
    .then((data) => {
      if (data.status !== "success") throw new Error(data.message);
      flights = data.data || [];
      populateFilters(flights);
      setupPriceFilter(flights);
      applyFilters();
    })
    .catch((error) => {
      document.getElementById("flights").innerHTML =
        `<p style="color:red;">Failedload flights.</p>`;
      console.error("Error:", error);
    });
};

// Populate From and To dropdowns dynamically
const populateFilters = (flights) => {
  const departures = [...new Set(flights.map((f) => f.departure_airport)),].sort();
  const arrivals = [...new Set(flights.map((f) => f.arrival_airport))].sort();

  const fromSelect = document.getElementById("fromFilter");
  const toSelect = document.getElementById("toFilter");

  fromSelect.innerHTML = '<option value="">All Airports</option>';
  arrivals.innerHTML = '<option value="">All Airports</option>';

  departures.forEach((airport) => {
    fromSelect.innerHTML += `<option value="${airport}">${airport}</option>`;
  });

  arrivals.forEach((airport) => {
    toSelect.innerHTML += `<option value="${airport}">${airport}</option>`;
  });
};

// Set price range based on actual data
const setupPriceFilter = (flights) => {
  const prices = flights.map((f) => Number(f.Price));
  let maxPrice = Math.max(...prices);
  maxPrice = Math.ceil(maxPrice / 1000) * 1000; // Round up to nearest thousand

  priceFilter.min = 0;
  priceFilter.max = maxPrice;
  priceFilter.value = maxPrice;
  document.getElementById("priceDisplay").textContent =
    `R${maxPrice.toFixed(2)}`;
  priceFilter.oninput = () => {
    document.getElementById("priceDisplay").textContent = `R${Number(priceFilter.value).toFixed(2)}`;
  
    applyFilters();
  };
};

// Class toggle buttons
document.getElementById("economy-btn").addEventListener("click", () => toggleClass("Economy", "economy-btn"));
document.getElementById("business-btn").addEventListener("click", () => toggleClass("Business", "business-btn"));
document.getElementById("first-btn").addEventListener("click", () => toggleClass("First Class", "first-btn"));

const toggleClass = (className, btnId) => {
  const btn = document.getElementById(btnId);
  if (selectedClasses.includes(className)) {
    selectedClasses = selectedClasses.filter((c) => c !== className);
    btn.classList.remove("checked");
    btn.classList.add("unchecked");
  } else {
    selectedClasses.push(className);
    btn.classList.remove("unchecked");
    btn.classList.add("checked");
  }
  applyFilters();
};

// Apply all filters
const applyFilters = () => {
  const maxPrice = document.getElementById("priceFilter").value;
  const from = document.getElementById("fromFilter").value;
  const to = document.getElementById("toFilter").value;

  const filtered = flights.filter((flight) => {
    const matchesPrice = Number(flight.Price) <= Number(maxPrice);
    const matchesFrom = from === "" || flight.departure_airport === from;
    const matchesTo = to === "" || flight.arrival_airport === to;
    const flightClasses = flight.classes.split(",").map((c) => c.trim());
    const matchesClass =
      selectedClasses.length === 0 ||
      selectedClasses.some((selected) => flightClasses.includes(selected));
    return matchesPrice && matchesFrom && matchesTo && matchesClass;
  });

  currentPage = 1;
  displayPage(filtered);

};

const displayPage = (flights) => {
  const totalPages = Math.ceil(flights.length / itemsPerPage);
  const offset = (currentPage - 1) * itemsPerPage;
  const paginated = flights.slice(offset, offset + itemsPerPage);

  showFlights(paginated);
  updatePaginationButtons(currentPage, totalPages, flights);
};

const updatePaginationButtons = (current, total, allFilteredFlights) => {
  document.getElementById("prevBtn").disabled = current === 1;
  document.getElementById("nextBtn").disabled = current === total;
  document.getElementById("pageInfo").textContent = `Page ${current} of ${total}`;document.getElementById("prevBtn").onclick = () => {
    currentPage--;
    displayPage(allFilteredFlights);
  };
  document.getElementById("nextBtn").onclick = () => {
    currentPage++;
    displayPage(allFilteredFlights);
  };
};

loadPage();

document.getElementById("fromFilter").addEventListener("change", applyFilters);
document.getElementById("toFilter").addEventListener("change", applyFilters);

const showFlights = (flights) => {
  const flightsContainer = document.getElementById("flights");
  flightsContainer.innerHTML = "";

  if (flights.length === 0) {
    flightsContainer.innerHTML = `<p style="color:#888;">No flights found.</p>`;
    return;
  }

  flights.forEach((flight) => {
    const flightDiv = document.createElement("div");
    flightDiv.classList.add("flight-item");
    flightDiv.innerHTML = `
      <img class="flight-image" src="${flight.img_url}" alt="${flight.airline_name}">
      <div class="flight-info">
        <h3>${flight.airline_name}</h3>
        <p class="price">Price: R${Number(flight.Price).toFixed(2)}</p>
        <p><span>From: ${flight.departure_airport}</span></p>
        <p>To: ${flight.arrival_airport}</p>
        <p>Departure: ${flight.dept_date}</p>
        <p>Arrival: ${flight.arrival_date}</p>
        <p>Class: ${flight.classes}</p>
      </div>
    `;
    flightsContainer.appendChild(flightDiv);
  });
};


