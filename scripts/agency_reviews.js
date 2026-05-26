(function () {
const API_BASE = "http://localhost/COS221-Tripistry/api.php";

const currentUser = JSON.parse(localStorage.getItem("user") || "{}");
if (!currentUser || currentUser.user_type !== "travel_agent") {
    window.location.href = "/COS221-Tripistry/login.html";
}

function getApiKey() {
    const match = document.cookie.match(/apiKey=([^;]+)/);
    return match ? match[1] : null;
}

const loading       = document.getElementById("loading");
const reviewsGrid   = document.getElementById("reviews-grid");
const emptyState    = document.getElementById("empty-state");
const ratingFilter  = document.getElementById("rating-filter");
const packageFilter = document.getElementById("package-filter");

let allReviews = [];

function renderStars(rating) {
    let html = "";
    for (let i = 1; i <= 5; i++) {
        html += `<span class="${i <= rating ? 'star-filled' : 'star-empty'}">★</span>`;
    }
    return html;
}

function loadReviews() {
    const apiKey = getApiKey();
    if (!apiKey) { window.location.href = "/COS221-Tripistry/login.html"; return; }

    fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type: "GetAgencyReviews", api_key: apiKey })
    })
    .then(r => r.text())
    .then(text => {
        try {
            const data = JSON.parse(text);
            loading.style.display = "none";
            if (data.status !== "success") { emptyState.style.display = "flex"; return; }
            allReviews = data.data || [];
            updateStats(allReviews);
            populatePackageFilter(allReviews);
            renderRatingBars(allReviews);
            renderReviews(allReviews);
        } catch(e) {
            loading.style.display = "none";
            console.error("Not JSON:", text);
        }
    })
    .catch(err => { loading.style.display = "none"; console.error(err); });
}

function updateStats(reviews) {
    document.getElementById("stat-total").textContent = reviews.length;
    const avg = reviews.length
        ? (reviews.reduce((s, r) => s + r.rating, 0) / reviews.length).toFixed(1)
        : "—";
    document.getElementById("stat-avg").textContent   = avg === "—" ? "—" : avg + " ★";
    document.getElementById("stat-five").textContent  = reviews.filter(r => r.rating === 5).length;
    document.getElementById("stat-low").textContent   = reviews.filter(r => r.rating <= 2).length;
}

function populatePackageFilter(reviews) {
    const seen = new Set();
    reviews.forEach(r => {
        if (r.package_id && !seen.has(r.package_id)) {
            seen.add(r.package_id);
            const opt = document.createElement("option");
            opt.value = r.package_id;
            opt.textContent = r.package_title || `Package ${r.package_id}`;
            packageFilter.appendChild(opt);
        }
    });
}

function renderRatingBars(reviews) {
    const counts = { 5: 0, 4: 0, 3: 0, 2: 0, 1: 0 };
    reviews.forEach(r => { if (counts[r.rating] !== undefined) counts[r.rating]++; });
    const max = Math.max(...Object.values(counts), 1);

    const bars = document.createElement("div");
    bars.className = "rating-bars";
    bars.innerHTML = `<h3>Rating breakdown</h3>`;

    [5, 4, 3, 2, 1].forEach(star => {
        const pct = Math.round((counts[star] / max) * 100);
        const fillClass = star >= 4 ? "high" : star <= 2 ? "low" : "";
        bars.innerHTML += `
            <div class="rating-row">
                <span class="rating-row-label">${"★".repeat(star)}</span>
                <div class="rating-bar-bg">
                    <div class="rating-bar-fill ${fillClass}" style="width:${pct}%"></div>
                </div>
                <span class="rating-row-count">${counts[star]}</span>
            </div>
        `;
    });

    reviewsGrid.parentNode.insertBefore(bars, reviewsGrid);
}

function renderReviews(reviews) {
    const rating  = parseInt(ratingFilter.value) || 0;
    const pkgId   = parseInt(packageFilter.value) || 0;

    const filtered = reviews.filter(r => {
        const matchRating = !rating  || r.rating === rating;
        const matchPkg    = !pkgId   || r.package_id === pkgId;
        return matchRating && matchPkg;
    });

    reviewsGrid.innerHTML = "";

    if (filtered.length === 0) {
        emptyState.style.display = "flex";
        return;
    }

    emptyState.style.display = "none";

    filtered.forEach(r => {
        const card = document.createElement("div");
        card.className = "review-card";

        const initials = (r.reviewer_name || "?")
            .split(" ").map(w => w[0]).join("").toUpperCase().slice(0, 2);

        const date = new Date(r.review_date).toLocaleDateString("en-ZA", {
            year: "numeric", month: "short", day: "numeric"
        });

        card.innerHTML = `
            <div class="review-header">
                <div class="reviewer-info">
                    <div class="reviewer-avatar">${initials}</div>
                    <div>
                        <p class="reviewer-name">${r.reviewer_name || "Anonymous"}</p>
                        <p class="reviewer-pkg">${r.package_title || "General review"}</p>
                    </div>
                </div>
                <div class="stars-display">${renderStars(r.rating)}</div>
            </div>
            <p class="review-comment">${r.comment || "No comment provided."}</p>
            <p class="review-date">${date}</p>
        `;

        reviewsGrid.appendChild(card);
    });
}

ratingFilter.addEventListener("change",  () => renderReviews(allReviews));
packageFilter.addEventListener("change", () => renderReviews(allReviews));

loadReviews();
})();