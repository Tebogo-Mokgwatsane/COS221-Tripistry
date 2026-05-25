let destinations = [];

const loadPage = (page = 1) => {
  fetch(`get_destinations.php?page=${page}`)
    .then((status) => status.json())
    .then((response) => {
      if (response.status !== "success") throw new Error(response.message);
      destinations = response.data;
      showDestinations(destinations);
      updatePaginationButtons(response.currentPage, response.totalPages);
    })
    .catch((error) => console.error("Error:", error));
};

const showDestinations = (destinations) => {
  const DestinationContainer = document.getElementById("destinations");
  DestinationContainer.innerHTML = "";

  destinations.forEach((destination) => {
    const destinationDiv = document.createElement("div");
    destinationDiv.classList.add("destination");
    destinationDiv.innerHTML = `
        <div class="destination-item" >
            <img class="destination-image" src="${destination.img_url}" alt="${destination.city}">
            <div class="destination-info">
                <h1>${destination.city}</h1>
                <p> <span>From: ${destination.departure_airport}</span></p>
                <p>Country: ${destination.country}</p>
                <p>Description: ${destination.description}</p>
            </div>
        </div>
        `;
    DestinationContainer.appendChild(destinationDiv);

  });
};

 const updatePaginationButtons = (current, total) => {
   document.getElementById("prevBtn").disabled = current === 1;
   document.getElementById("nextBtn").disabled = current === total;
   document.getElementById("pageInfo").textContent =
     `Page ${current} of ${total}`;

   document.getElementById("prevBtn").onclick = () => loadPage(current - 1);
   document.getElementById("nextBtn").onclick = () => loadPage(current + 1);
 };

 loadPage(1);
