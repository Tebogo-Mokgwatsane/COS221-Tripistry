let allAccommodations = [];
let currentPage = 1;
const itemsPerPage = 20;

function loadAccommodations() {
  fetch("../../api.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ type: "Accommodations" }),
  })
    .then((res) => res.text())
    .then((text) => {
      console.log("Raw Response (Accommodations):", text);
      return JSON.parse(text);
    })
    .then((data) => {
      if (data.status === "success") {
        allAccommodations = data.data || [];
        setupPriceSlider(allAccommodations);
        filterAccommodations();
      }
    })
    .catch((err) => console.error(err));
}

window.onload = loadAccommodations;

const maxPriceSlider = document.getElementById("max-price");
const maxPriceValue = document.getElementById("max-price-value");

function setupPriceSlider(accommodations) {
  const prices = accommodations.map((a) => parseFloat(a.price_per_night || 0));
  const maxPrice = Math.ceil(Math.max(...prices) / 1000) * 1000;
  maxPriceSlider.min = 0;
  maxPriceSlider.max = maxPrice;
  maxPriceSlider.value = maxPrice;
  maxPriceValue.textContent = `R${maxPrice.toLocaleString()}`;
}

maxPriceSlider.addEventListener("input", () => {
  maxPriceValue.textContent = `R${parseFloat(maxPriceSlider.value).toLocaleString()}`;
  currentPage = 1;
  filterAccommodations();
});

document.querySelectorAll(".type-btn").forEach((btn) => {
  btn.addEventListener("click", () => {
    document
      .querySelectorAll(".type-btn")
      .forEach((b) => b.classList.remove("active"));
    btn.classList.add("active");
    currentPage = 1;
    filterAccommodations();
  });
});

function filterAccommodations() {
  const maxPrice = parseFloat(maxPriceSlider.value);
  const activeType = document.querySelector(".type-btn.active").dataset.type;

  const filtered = allAccommodations.filter((acc) => {
    const priceMatch = parseFloat(acc.price_per_night) <= maxPrice;
    const typeMatch = activeType === "all" || acc.acc_type === activeType;
    return priceMatch && typeMatch;
  });

  currentPage = 1;
  displayPage(filtered);
}

function displayPage(accommodations) {
  const totalPages = Math.ceil(accommodations.length / itemsPerPage);
  const offset = (currentPage - 1) * itemsPerPage;
  const paginated = accommodations.slice(offset, offset + itemsPerPage);

  renderAccommodations(paginated);
  updatePaginationButtons(currentPage, totalPages, accommodations);
}

function updatePaginationButtons(current, total, allFiltered) {
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
}

function renderAccommodations(list) {
  const container = document.getElementById("accommodations");
  container.innerHTML = "";

  if (list.length === 0) {
    container.innerHTML = "<p>No accommodations found.</p>";
    return;
  }

  list.forEach((acc) => {
    const div = document.createElement("div");
    div.className = "accommodation-item";
    div.innerHTML = `
      <img src="${acc.img_url || "https://via.placeholder.com/400x220"}" alt="${acc.acc_name}">
      <div class="accommodation-info">
        <h3>${acc.acc_name}</h3>
        <p class="location">${acc.city}, ${acc.country}</p>
        <span class="type">${acc.acc_type}</span>
        <p class="rating">★ ${parseFloat(acc.rating || 0).toFixed(1)}</p>
        <div class="price">R${parseFloat(acc.price_per_night).toLocaleString()} <small>/night</small></div>
      </div>
    `;
    container.appendChild(div);
  });
}
