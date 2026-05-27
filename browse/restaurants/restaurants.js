let allRestaurants = [];
let currentPage = 1;
const itemsPerPage = 12;

function loadRestaurants() {
  fetch("../../api.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ type: "Restaurants" }),
  })
    .then((res) => res.text())
    .then((text) => {
      console.log("Raw Response (Restaurants):", text);
      return JSON.parse(text);
    })
    .then((data) => {
      if (data.status === "success") {
        allRestaurants = data.data || [];
        setupFeeSlider(allRestaurants);
        filterRestaurants();
      }
    })
    .catch((err) => console.error(err));
}

window.onload = loadRestaurants;

const maxFeeSlider = document.getElementById("max-fee");
const maxFeeValue = document.getElementById("max-fee-value");

function setupFeeSlider(restaurants) {
  const fees = restaurants.map((r) => parseFloat(r.fee || 0));
  const maxFee = Math.ceil(Math.max(...fees) / 1000) * 1000;
  maxFeeSlider.min = 0;
  maxFeeSlider.max = maxFee;
  maxFeeSlider.value = maxFee;
  maxFeeValue.textContent = `R${maxFee.toLocaleString()}`;
}

maxFeeSlider.addEventListener("input", () => {
  maxFeeValue.textContent = `R${parseFloat(maxFeeSlider.value).toLocaleString()}`;
  currentPage = 1;
  filterRestaurants();
});

function filterRestaurants() {
  const maxFee = parseFloat(maxFeeSlider.value);
  const filtered = allRestaurants.filter(
    (r) => parseFloat(r.fee || 0) <= maxFee,
  );
  currentPage = 1;
  displayPage(filtered);
}

function displayPage(restaurants) {
  const totalPages = Math.ceil(restaurants.length / itemsPerPage);
  const offset = (currentPage - 1) * itemsPerPage;
  const paginated = restaurants.slice(offset, offset + itemsPerPage);

  renderRestaurants(paginated);
  updatePaginationButtons(currentPage, totalPages, restaurants);
}

function updatePaginationButtons(current, total, allFiltered) {
  document.getElementById("prevBtn").disabled = current === 1;
  document.getElementById("nextBtn").disabled = current === total || total === 0;
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
}

function renderRestaurants(list) {
  const container = document.getElementById("restaurants");
  container.innerHTML = "";

  if (list.length === 0) {
    container.innerHTML = "<p>No restaurants found.</p>";
    return;
  }

  list.forEach((r) => {
    const div = document.createElement("div");
    div.className = "restaurant-item";
    const feeDisplay =
      parseFloat(r.fee || 0) === 0
        ? `<span class="free">Free</span>`
        : `R${parseFloat(r.fee).toLocaleString()}`;
    div.innerHTML = `
            
            <div class="restaurant-info">
                <h3>${r.name}</h3>
                <p class="location">${r.city || ""}, ${r.country || ""}</p>
                <span class="type">${r.type || "Restaurant"}</span>
                <p class="rating">★ ${parseFloat(r.rating || 0).toFixed(1)}</p>
                <div class="price">${feeDisplay} <small>avg</small></div>
            </div>
        `;
    container.appendChild(div);
  });
}