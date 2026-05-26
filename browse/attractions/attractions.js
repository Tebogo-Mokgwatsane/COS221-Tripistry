let allAttractions = [];
let currentPage = 1;
const itemsPerPage = 12;

function loadAttractions() {
  fetch("../../api.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ type: "Attractions" }),
  })
    .then((res) => res.text())
    .then((text) => {
      console.log("Raw Response (Attractions):", text);
      return JSON.parse(text);
    })
    .then((data) => {
      if (data.status === "success") {
        allAttractions = data.data || [];
        setupFeeSlider(allAttractions);
        filterAttractions();
      }
    })
    .catch((err) => console.error(err));
}

window.onload = loadAttractions;

const maxFeeSlider = document.getElementById("max-fee");
const maxFeeValue = document.getElementById("max-fee-value");

// Set slider max based on actual data
function setupFeeSlider(attractions) {
  const fees = attractions.map((a) => parseFloat(a.fee || 0));
  const maxFee = Math.ceil(Math.max(...fees) / 1000) * 1000;
  maxFeeSlider.min = 0;
  maxFeeSlider.max = maxFee;
  maxFeeSlider.value = maxFee;
  maxFeeValue.textContent = `R${maxFee.toLocaleString()}`;
}

maxFeeSlider.addEventListener("input", () => {
  maxFeeValue.textContent = `R${parseFloat(maxFeeSlider.value).toLocaleString()}`;
  currentPage = 1;
  filterAttractions();
});

function filterAttractions() {
  const maxFee = parseFloat(maxFeeSlider.value);
  const filtered = allAttractions.filter(
    (attr) => parseFloat(attr.fee || 0) <= maxFee,
  );
  currentPage = 1;
  displayPage(filtered);
}

function displayPage(attractions) {
  const totalPages = Math.ceil(attractions.length / itemsPerPage);
  const offset = (currentPage - 1) * itemsPerPage;
  const paginated = attractions.slice(offset, offset + itemsPerPage);

  renderAttractions(paginated);
  updatePaginationButtons(currentPage, totalPages, attractions);
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

function renderAttractions(list) {
  const container = document.getElementById("attractions");
  container.innerHTML = "";

  if (list.length === 0) {
    container.innerHTML = "<p>No attractions found.</p>";
    return;
  }

  list.forEach((attr) => {
    const div = document.createElement("div");
    div.className = "attraction-item";
    const feeDisplay =
      parseFloat(attr.fee || 0) === 0
        ? `<span class="free">Free</span>`
        : `R${parseFloat(attr.fee).toLocaleString()}`;
    div.innerHTML = `
            <img src="${attr.img_url || "https://via.placeholder.com/400x220"}" alt="${attr.name}">
            <div class="attraction-info">
                <h3>${attr.name}</h3>
                <p class="location">${attr.city || ""}, ${attr.country || ""}</p>
                <span class="category">${attr.category || "Attraction"}</span>
                <p class="rating">★ ${parseFloat(attr.rating || 0).toFixed(1)}</p>
                <div class="price">${feeDisplay} <small>entry</small></div>
            </div>
        `;
    container.appendChild(div);
  });
}
