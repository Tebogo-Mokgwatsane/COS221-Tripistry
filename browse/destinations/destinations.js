let destinations = [];
let currentPage = 1;
const itemsPerPage = 12;
let searchQuery = "";

const showDestinations = (destinations) => {
  const destinationsContainer = document.getElementById("destinations");
  destinationsContainer.innerHTML = "";

  if (destinations.length === 0) {
    destinationsContainer.innerHTML = `<p style="color:#888;">No destinations found.</p>`;
    return;
  }

  destinations.forEach((destination) => {
    const destinationsDiv = document.createElement("div");
    destinationsDiv.classList.add("destination-item");
    destinationsDiv.innerHTML = `
      <div class="destination-info">
        <h1>${destination.city}</h1>
        <div class="destination-header">
          <img src="/COS221-Tripistry/img/icons/map-pin.svg" alt="map icon" class="icon">
          <span>${destination.country}</span>
        </div>
      <p>${destination.description}</p>
      </div>
      
    `;
    destinationsContainer.appendChild(destinationsDiv);
  });
};


const updatePaginationButtons = (current, total, allFiltered) => {
  document.getElementById("prevBtn").disabled = current === 1;
  document.getElementById("nextBtn").disabled =
    current === total || total === 0;
  document.getElementById("pageInfo").textContent =
    `Page ${current} of ${total || 1}`;
  document.getElementById("prevBtn").onclick = () => {
    if (currentPage > 1) {
      currentPage--;
      displayPage(allFiltered);
      window.scrollTo({ top: 0, behavior: "smooth" });
    }
  };
  document.getElementById("nextBtn").onclick = () => {
    if (currentPage < total) {
      currentPage++;
      displayPage(allFiltered);
      window.scrollTo({ top: 0, behavior: "smooth" });
    }
  };
};

const displayPage = (destinations) => {
  const totalPages = Math.ceil(destinations.length / itemsPerPage);
  const offset = (currentPage - 1) * itemsPerPage;
  const paginated = destinations.slice(offset, offset + itemsPerPage);

  showDestinations(paginated);
  updatePaginationButtons(currentPage, totalPages, destinations);
};


// Apply all filters
const applyFilters = () => {
  const searchBar = document.getElementById("search-bar");

  const filtered = destinations.filter((destination) => {
    const matchesSearch =
      destination.city.toLowerCase().includes(searchBar.value.toLowerCase()) ||
      destination.country.toLowerCase().includes(searchBar.value.toLowerCase()); 
    return matchesSearch;
  });

  currentPage = 1;
  displayPage(filtered);
};

const loadPage = () => {
  document.getElementById("destinations").innerHTML =
    `<p style="color:#888;">Loading destinations...</p>`;

  fetch("/COS221-Tripistry/api.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      type: "Destinations",
    }),
  })
    .then((res) => res.json())
    .then((data) => {

      if (data.status !== "success") throw new Error(data.message);
      destinations = data.data || [];
      applyFilters();
    })
    .catch((error) => {
      document.getElementById("destinations").innerHTML =
        `<p style="color:red;">Failedload destinations.</p>`;
      console.error("Error:", error);
    });
};

document.getElementById("search-bar").addEventListener("input", applyFilters);

loadPage();