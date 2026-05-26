let destinations = [];

fetch("get_destinations.php")
  .then((status) => {
    if (!status.ok) {
      throw new Error("Network response was not ok");
    }
    return status.json();
  })
  .then((response) => {
    if (response.status !== "success") {
      throw new Error("API error: " + response.message);
    }
    return response.data;
  })
  .then((data) => {
    destinations = data;
    showDestinations(destinations);
  })
  .catch((error) => {
    console.error("Error fetching Destinations:", error);
  });

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
