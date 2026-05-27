// ============================================================
// favourites.js — Load and manage favourite packages
// ============================================================

const packagesGrid = document.getElementById("packages-grid");
const emptyState   = document.getElementById("empty-state");
const loading      = document.getElementById("loading");

// ── Guard: travellers only ───────────────────────────────────
//const user = JSON.parse(localStorage.getItem("user") || "{}");
if (!user || user.user_type !== "traveller") {
    alert("This page is for travellers only. Please log in.");
    window.location.href = "../login.html";
}

// ── Get API key from cookie ──────────────────────────────────
function getApiKey() {
    const match = document.cookie.match(/apiKey=([^;]+)/);
    return match ? match[1] : null;
}

// ── Render star display ──────────────────────────────────────
function renderStars(rating) {
    let html = "";
    for (let i = 1; i <= 5; i++) {
        html += `<span class="star-display ${i <= Math.round(rating) ? "filled" : ""}">&#9733;</span>`;
    }
    return html;
}

// ── Load favourites from API ─────────────────────────────────
function loadFavourites() {
    const apiKey = getApiKey();
    if (!apiKey) {
        alert("Session expired. Please log in.");
        window.location.href = "../login.html";
        return;
    }

    fetch("/COS221-Tripistry/api.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type: "GetFavourites", api_key: apiKey })
    })
    .then(res => res.json())
    .then(data => {
        loading.style.display = "none";

        if (data.status !== "success") {
            alert(data.message || "Failed to load favourites");
            return;
        }

        const favourites = data.data;

        if (!favourites || favourites.length === 0) {
            emptyState.style.display = "flex";
            return;
        }

        favourites.forEach(pkg => renderPackageCard(pkg));
    })
    .catch(err => {
        console.error(err);
        loading.style.display = "none";
        packagesGrid.innerHTML = `<p class="error-msg">Failed to connect to server.</p>`;
    });
}

// ── Render one package card ──────────────────────────────────
function renderPackageCard(pkg) {
    const card = document.createElement("div");
    card.className = "package-card";
    card.id = `pkg-${pkg.package_id}`;

    const expiry = new Date(pkg.expiry_date).toLocaleDateString("en-ZA", {
        year: "numeric", month: "short", day: "numeric"
    });

    const statusClass = pkg.status === "active" ? "status-active" : "status-inactive";

    card.innerHTML = `
        <div class="card-top">
            <div class="card-dest">
                <p class="city">${pkg.destination_city}</p>
                <p class="country">${pkg.destination_country}</p>
            </div>
            <button class="heart-btn active" data-id="${pkg.package_id}" title="Remove from favourites">
                &#10084;
            </button>
        </div>
        <div class="card-body">
            <h3 class="pkg-title">${pkg.title}</h3>
            <p class="agency-name">${pkg.agency_name}</p>
            <p class="pkg-desc">${pkg.description || ""}</p>
            <div class="pkg-rating">
                <div class="stars">${renderStars(pkg.avg_rating)}</div>
                <span class="review-count">${pkg.review_count} review${pkg.review_count !== 1 ? "s" : ""}</span>
            </div>
        </div>
        <div class="card-footer">
            <div class="price-block">
                <p class="price-label">FROM</p>
                <p class="price">R${parseFloat(pkg.price).toLocaleString("en-ZA")}</p>
            </div>
            <div class="card-actions">
                <span class="pkg-status ${statusClass}">${pkg.status}</span>
                <a href="/COS221-Tripistry/traveller/package.php?package_id=${pkg.package_id}" class="view-btn">View Package</a>
            </div>
        </div>
        <p class="saved-date">Saved ${new Date(pkg.added_at).toLocaleDateString("en-ZA")}</p>
    `;

    // Heart button — remove from favourites
    const heartBtn = card.querySelector(".heart-btn");
    heartBtn.addEventListener("click", () => removeFavourite(pkg.package_id, card));

    packagesGrid.appendChild(card);
}

// ── Remove a favourite ───────────────────────────────────────
function removeFavourite(packageId, cardElement) {
    const apiKey = getApiKey();

    // Optimistic UI — dim the card immediately
    cardElement.style.opacity = "0.4";
    cardElement.style.pointerEvents = "none";

    fetch("/COS221-Tripistry/api.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            type:       "RemoveFavourite",
            api_key:    apiKey,
            package_id: packageId
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {
            // Animate out then remove
            cardElement.style.transition = "opacity 0.3s, transform 0.3s";
            cardElement.style.transform  = "scale(0.95)";
            cardElement.style.opacity    = "0";
            setTimeout(() => {
                cardElement.remove();
                // Show empty state if no cards left
                if (packagesGrid.children.length === 0) {
                    emptyState.style.display = "flex";
                }
            }, 300);
        } else {
            // Restore card on failure
            cardElement.style.opacity = "1";
            cardElement.style.pointerEvents = "auto";
            alert(data.message || "Failed to remove from favourites");
        }
    })
    .catch(err => {
        console.error(err);
        cardElement.style.opacity = "1";
        cardElement.style.pointerEvents = "auto";
        alert("Server error. Please try again.");
    });
}

// ── Init ─────────────────────────────────────────────────────
loadFavourites();