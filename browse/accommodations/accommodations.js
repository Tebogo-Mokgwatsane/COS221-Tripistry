let allAccommodations = [];

function loadAccommodations() {
    fetch('../../api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            type: "Accommodations"
        })
    })
    //.then(res => res.json())
    .then(res => {//debugging
    return res.text().then(text => {
        try {
            return JSON.parse(text);
        } catch (err) {
            console.error("The raw server login response was:", text);
            throw new Error("Server did not return valid JSON");
        }
    });
    })
    .then(data => {
        if (data.status === "success") {
            allAccommodations = data.data || [];
            renderAccommodations(allAccommodations);
        }
    })
    .catch(err => console.error(err));
}

// Load on page load
window.onload = loadAccommodations;

// Filter functions
const maxPriceSlider = document.getElementById('max-price');
const maxPriceValue = document.getElementById('max-price-value');

maxPriceSlider.addEventListener('input', () => {
    maxPriceValue.textContent = `R${maxPriceSlider.value}`;
    filterAccommodations();
});

document.querySelectorAll('.type-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.type-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        filterAccommodations();
    });
});

function filterAccommodations() {
    const maxPrice = parseFloat(maxPriceSlider.value);
    const activeType = document.querySelector('.type-btn.active').dataset.type;

    const filtered = allAccommodations.filter(acc => {
        const priceMatch = parseFloat(acc.price_per_night) <= maxPrice;
        const typeMatch = (activeType === 'all' || acc.acc_type === activeType);
        return priceMatch && typeMatch;
    });

    renderAccommodations(filtered);
}

function renderAccommodations(list) {
    const container = document.getElementById("accommodations");
    container.innerHTML = "";

    if (list.length === 0) {
        container.innerHTML = "<p>No accommodations found.</p>";
        return;
    }

    list.forEach(acc => {
        const div = document.createElement("div");
        div.className = "accommodation-item";
        div.innerHTML = `
            <img src="${acc.img_url || 'https://via.placeholder.com/400x220'}" alt="${acc.acc_name}">
            <div class="accommodation-info">
                <h3>${acc.acc_name}</h3>
                <p class="location">${acc.city}, ${acc.country}</p>
                <span class="type">${acc.acc_type}</span>
                <p class="rating">★ ${parseFloat(acc.rating || 0).toFixed(1)}</p>
                <div class="price">
                    R${parseFloat(acc.price_per_night).toLocaleString()} <small>/night</small>
                </div>
            </div>
        `;
        container.appendChild(div);
    });
}