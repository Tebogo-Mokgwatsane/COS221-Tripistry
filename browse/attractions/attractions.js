let allAttractions = [];

function loadAttractions() {
    fetch('../../api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ type: "Attractions" })
    })
    .then(res => res.text())
    .then(text => {
        console.log("Raw Response (Attractions):", text);
        return JSON.parse(text);
    })
    .then(data => {
        if (data.status === "success") {
            allAttractions = data.data || [];
            renderAttractions(allAttractions);
        }
    })
    .catch(err => console.error(err));
}

window.onload = loadAttractions;

const maxFeeSlider = document.getElementById('max-fee');
const maxFeeValue = document.getElementById('max-fee-value');

maxFeeSlider.addEventListener('input', () => {
    maxFeeValue.textContent = `R${maxFeeSlider.value}`;
    filterAttractions();
});

function filterAttractions() {
    const maxFee = parseFloat(maxFeeSlider.value);
    const filtered = allAttractions.filter(attr => parseFloat(attr.fee || 0) <= maxFee);
    renderAttractions(filtered);
}

function renderAttractions(list) {
    const container = document.getElementById("attractions");
    container.innerHTML = "";

    if (list.length === 0) {
        container.innerHTML = "<p>No attractions found.</p>";
        return;
    }

    list.forEach(attr => {
        const div = document.createElement("div");
        div.className = "attraction-item";
        div.innerHTML = `
            <img src="${attr.img_url || 'https://via.placeholder.com/400x220'}" alt="${attr.name}">
            <div class="attraction-info">
                <h3>${attr.name}</h3>
                <p class="location">${attr.city || ''}, ${attr.country || ''}</p>
                <span class="category">${attr.category || 'Attraction'}</span>
                <p class="rating">★ ${parseFloat(attr.rating || 0).toFixed(1)}</p>
                <div class="price">R${parseFloat(attr.fee || 0).toLocaleString()} <small>entry</small></div>
            </div>
        `;
        container.appendChild(div);
    });
}