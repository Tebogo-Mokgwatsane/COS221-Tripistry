const params = new URLSearchParams(window.location.search);
const id = params.get("package_id");

if (!id) window.location.href = "index.php";

async function loadPackage() {
    try {
        const res = await fetch('/COS221-Tripistry/api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ type: "GetPackage", package_id: id })
        });

        const data = await res.json();
        if (data.status !== "success") {
            document.querySelector(".package-page").innerHTML = `<p>Package not found.</p>`;
            return;
        }

        const p = data.data;
        renderHero(p);
        renderActivities(p.activities);
        renderFlights(p.flights);
        renderRestaurants(p.restaurants);
        renderReviews(p.reviews);
        renderSidebar(p);

    } catch (err) {
        console.error("Failed to load package:", err);
    }
}

// ── Hero section ─────────────────────────────────────────────
function renderHero(p) {
    const imgContainer = document.querySelector(".package-img-container");
    if (p.img_url) {
        imgContainer.style.cssText += `
            background-image: url('/COS221-Tripistry/${p.img_url}');
            background-size: cover;
            background-position: center;
        `;
    }

    document.querySelector(".package-details h1").textContent = p.title;
    document.querySelector(".location span").textContent = p.location;

    const expiry = new Date(p.expiry_date).toLocaleDateString("en-ZA", {
        year: "numeric", month: "long", day: "numeric"
    });
    document.querySelector(".expires span").textContent = `Expires ${expiry}`;

    // In stock sticker
    const inStockEl = document.querySelector(".in-stock");
    inStockEl.querySelector("span").textContent = p.stock_text;
    inStockEl.style.display = p.in_stock ? "flex" : "none";

    // Group package sticker
    const groupEl = document.querySelector(".group-package");
    groupEl.style.display = p.is_group_package ? "flex" : "none";

    // Description
    document.querySelector(".trip-description").textContent =
        p.description || "No description available.";
}

// ── Activities timeline ───────────────────────────────────────
function renderActivities(activities) {
    const timeline = document.getElementById("timeline");
    timeline.innerHTML = "";

    if (!activities || activities.length === 0) {
        timeline.innerHTML = `<p style="color:gray;font-size:14px;">No activities listed.</p>`;
        return;
    }

    // Group flat array by day_number
    const days = {};
    activities.forEach(a => {
        if (!days[a.day_number]) days[a.day_number] = [];
        days[a.day_number].push(a);
    });

    Object.keys(days).sort((a, b) => a - b).forEach(dayNum => {
        const list = days[dayNum];
        const card = document.createElement("div");
        card.className = "day-card";

        card.innerHTML = `
            <div class="day-number">${dayNum}</div>
            <div class="day-label">Day ${dayNum}</div>
            <div class="activities-count">${list.length} activit${list.length === 1 ? "y" : "ies"}</div>
            ${list.map(a => `
                <div class="day-activity">
                    <div class="activity-time">${a.activity_time || ""}</div>
                    <div class="divider"></div>
                    <div class="activity-content">
                        <h2>${a.activity_name}</h2>
                        <p>${a.description || ""}</p>
                    </div>
                </div>
            `).join("")}
        `;
        timeline.appendChild(card);
    });
}

// ── Flights ───────────────────────────────────────────────────
function renderFlights(flights) {
    const section = document.querySelector(".flight-card");
    if (!section) return;

    if (!flights || flights.length === 0) {
        section.innerHTML = `<p style="color:gray;font-size:14px;">No flights included.</p>`;
        return;
    }

    section.innerHTML = flights.map(f => `
        <div class="flight-top">
            <h2>${f.airline_name}</h2>
            <div class="flight-badge">${f.class || "Economy"}</div>
        </div>
        <div class="flight-route">
            <div class="airport">
                <div class="airport-code">${f.departure_airport}</div>
                <div style="font-size:12px;color:gray;">${f.departure_datetime || ""}</div>
            </div>
            <div class="flight-line"></div>
            <div class="airport">
                <div class="airport-code">${f.arrival_airport}</div>
                <div style="font-size:12px;color:gray;">${f.arrival_datetime || ""}</div>
            </div>
        </div>
    `).join("<hr style='margin:16px 0;border:none;border-top:1px solid #eee;'>");
}

// ── Restaurants ───────────────────────────────────────────────
function renderRestaurants(restaurants) {
    const heading = document.querySelector(".section-title:last-of-type");
    const card = document.querySelector(".accommodation-card:last-of-type");
    if (!card) return;

    if (!restaurants || restaurants.length === 0) {
        card.innerHTML = `<p style="color:gray;font-size:14px;padding:16px;">No dining picks listed.</p>`;
        return;
    }

    // Replace the single hardcoded card with all restaurants
    const container = card.parentNode;
    card.remove();

    restaurants.forEach(r => {
        const el = document.createElement("div");
        el.className = "accommodation-card";
        el.innerHTML = `
            <div class="accommodation-img">
                <img src="${r.img_url ? '/COS221-Tripistry/' + r.img_url : 'https://placehold.co/120x100?text=Food'}"
                     alt="${r.name}"
                     onerror="this.src='https://placehold.co/120x100?text=Food'">
            </div>
            <div class="accommodation-content">
                <div class="accommodation-top">
                    <div>
                        <div class="accommodation-type">${r.type || "RESTAURANT"}</div>
                        <div class="accommodation-name">${r.name}</div>
                    </div>
                    <div class="accommodation-rating">★ ${r.rating || "N/A"}</div>
                </div>
                <p class="accommodation-description">${r.details || ""}</p>
            </div>
        `;
        container.appendChild(el);
    });
}

// ── Reviews ───────────────────────────────────────────────────
function renderReviews(reviews) {
    const section = document.getElementById("reviews-section");
    if (!section) return;
    section.innerHTML = "";

    if (!reviews || reviews.length === 0) {
        section.innerHTML = `<p style="color:gray;font-size:14px;">No reviews yet.</p>`;
        return;
    }

    reviews.forEach(r => {
        const initials = (r.traveller_name || "?")
            .split(" ").map(w => w[0]).join("").toUpperCase().slice(0, 2);

        const stars = "★".repeat(r.rating) + "☆".repeat(5 - r.rating);
        const date = new Date(r.review_date).toLocaleDateString("en-ZA", {
            year: "numeric", month: "short", day: "numeric"
        });

        const card = document.createElement("div");
        card.className = "review-card";
        card.innerHTML = `
            <div class="review-top">
                <div class="avatar">${initials}</div>
                <div>
                    <div class="review-name">${r.traveller_name || "Anonymous"}</div>
                    <div class="review-meta">
                        <span class="review-stars">${stars}</span> · ${date}
                    </div>
                </div>
            </div>
            <div class="review-text">${r.comment || "No comment provided."}</div>
        `;
        section.appendChild(card);
    });
}

// ── Sidebar ───────────────────────────────────────────────────
function renderSidebar(p) {
    const priceEl = document.querySelector(".sidebar-price");
    if (priceEl) {
        priceEl.innerHTML = `R${parseFloat(p.price).toLocaleString("en-ZA")} <span>/ person</span>`;
    }
}

// ── Book & Favourite buttons ──────────────────────────────────
const bookBtn = document.querySelector(".book-btn");
if (bookBtn) {
    bookBtn.addEventListener("click", () => {
        window.location.href = `/COS221-Tripistry/traveller/booking.php?package_id=${id}`;
    });
}

const favBtn = document.querySelector(".fav-btn");
if (favBtn) {
    favBtn.addEventListener("click", () => {
        const apiKey = document.cookie.match(/apiKey=([^;]+)/)?.[1];
        if (!apiKey) { 
            window.location.href = "/COS221-Tripistry/login.html"; 
            return; 
        }

        favBtn.textContent = "Saving...";
        favBtn.disabled = true;

        fetch("/COS221-Tripistry/api.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ 
                type:       "AddFavourite", 
                api_key:    apiKey, 
                package_id: id 
            })
        })
        .then(r => r.json())
        .then(data => {
            if (data.status === "success") {
                favBtn.textContent = "♥ Saved to Favourites";
                favBtn.style.color = "pink";
            } else {
                favBtn.textContent = "Add to favourites";
                favBtn.disabled = false;
                alert(data.data || data.message || "Could not save.");
            }
        })
        .catch(() => {
            favBtn.textContent = "Add to favourites";
            favBtn.disabled = false;
            alert("Server error. Please try again.");
        });
    });
}
loadPackage();