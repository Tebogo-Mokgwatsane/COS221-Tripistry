let allRestaurants = [];

function loadRestaurants() {
    fetch('../../api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ type: "Restaurants" })
    })
    .then(res => res.text())
    .then(text => {
        console.log("Raw Response (Restaurants):", text);
        return JSON.parse(text);
    })
    .then(data => {
        if (data.status === "success") {
            allRestaurants = data.data || [];
            renderRestaurants(allRestaurants);
        }
    })
    .catch(err => console.error(err));
}

window.onload = loadRestaurants;

const maxFeeSlider = document.getElementById('max-fee');
const maxFeeValue = document.getElementById('max-fee-value');

maxFeeSlider.addEventListener('input', () => {
    maxFeeValue.textContent = `R${maxFeeSlider.value}`;
    filterRestaurants();
});

function filterRestaurants() {
    const maxFee = parseFloat(maxFeeSlider.value);
    const filtered = allRestaurants.filter(r => parseFloat(r.fee || 0) <= maxFee);
    renderRestaurants(filtered);
}

function renderRestaurants(list) {
    const container = document.getElementById("restaurants");
    container.innerHTML = "";

    if (list.length === 0) {
        container.innerHTML = "<p>No restaurants found.</p>";
        return;
    }

    list.forEach(r => {
        const div = document.createElement("div");
        div.className = "restaurant-item";
        div.innerHTML = `
            <img src="${r.img_url || 'https://via.placeholder.com/400x220'}" alt="${r.name}">
            <div class="restaurant-info">
                <h3>${r.name}</h3>
                <p class="location">${r.city || ''}, ${r.country || ''}</p>
                <span class="type">${r.type || 'Restaurant'}</span>
                <p class="rating">★ ${parseFloat(r.rating || 0).toFixed(1)}</p>
                <div class="price">R${parseFloat(r.fee || 0).toLocaleString()} <small>avg</small></div>
            </div>
        `;
        container.appendChild(div);
    });
}