// ============================================================
// reviews.js — MOCK VERSION (no login needed)
// Swap back to real version when ready to connect to API
// ============================================================

const bookingsList  = document.getElementById("bookings-list");
const emptyState    = document.getElementById("empty-state");
const loading       = document.getElementById("loading");
const modalOverlay  = document.getElementById("modal-overlay");
const modalClose    = document.getElementById("modal-close");
const modalPkgName  = document.getElementById("modal-package-name");
const reviewComment = document.getElementById("review-comment");
const charCount     = document.getElementById("char-count");
const ratingLabel   = document.getElementById("rating-label");
const submitBtn     = document.getElementById("submit-review");
const modalError    = document.getElementById("modal-error");
const stars         = document.querySelectorAll(".star");

let selectedRating  = 0;
let activePackageId = null;

// ── MOCK DATA ────────────────────────────────────────────────
const MOCK_BOOKINGS = [
    {
        booking_id:           1,
        package_id:           1,
        package_title:        "Cape Town Explorer",
        destination_city:     "Cape Town",
        destination_country:  "South Africa",
        agency_name:          "Sunway Travels",
        num_travellers:       1,
        total_price:          15999.00,
        booking_status:       "confirmed",
        booking_date:         "2026-05-13 00:08:15",
        already_reviewed:     false
    },
    {
        booking_id:           2,
        package_id:           2,
        package_title:        "Zanzibar Island Escape",
        destination_city:     "Zanzibar",
        destination_country:  "Tanzania",
        agency_name:          "Sunway Travels",
        num_travellers:       2,
        total_price:          57000.00,
        booking_status:       "pending",
        booking_date:         "2026-05-13 00:08:15",
        already_reviewed:     false
    },
    {
        booking_id:           3,
        package_id:           3,
        package_title:        "Nairobi Safari Adventure",
        destination_city:     "Nairobi",
        destination_country:  "Kenya",
        agency_name:          "Globe Hopper Tours",
        num_travellers:       6,
        total_price:          252000.00,
        booking_status:       "confirmed",
        booking_date:         "2026-05-13 00:08:15",
        already_reviewed:     true
    }
];

// ── Star rating labels ───────────────────────────────────────
const ratingLabels = { 1:"Poor", 2:"Fair", 3:"Good", 4:"Very Good", 5:"Excellent" };

// ── Star picker ──────────────────────────────────────────────
stars.forEach(star => {
    star.addEventListener("mouseover", () => {
        const val = parseInt(star.dataset.value);
        stars.forEach(s => s.classList.toggle("hovered", parseInt(s.dataset.value) <= val));
        ratingLabel.textContent = ratingLabels[val];
    });
    star.addEventListener("mouseleave", () => {
        stars.forEach(s => s.classList.remove("hovered"));
        ratingLabel.textContent = selectedRating ? ratingLabels[selectedRating] : "Select a rating";
    });
    star.addEventListener("click", () => {
        selectedRating = parseInt(star.dataset.value);
        stars.forEach(s => s.classList.toggle("selected", parseInt(s.dataset.value) <= selectedRating));
        ratingLabel.textContent = ratingLabels[selectedRating];
    });
});

// ── Char counter ─────────────────────────────────────────────
reviewComment.addEventListener("input", () => {
    charCount.textContent = reviewComment.value.length;
});

// ── Load mock bookings ───────────────────────────────────────
function loadBookings() {
    setTimeout(() => {
        loading.style.display = "none";

        if (MOCK_BOOKINGS.length === 0) {
            emptyState.style.display = "flex";
            return;
        }

        MOCK_BOOKINGS.forEach(booking => renderBookingCard(booking));

    }, 800); // fake loading delay
}

// ── Render booking card ──────────────────────────────────────
function renderBookingCard(booking) {
    const card = document.createElement("div");
    card.className = "booking-card";

    const statusClass = {
        confirmed: "status-confirmed",
        pending:   "status-pending",
        cancelled: "status-cancelled"
    }[booking.booking_status] || "";

    const date = new Date(booking.booking_date).toLocaleDateString("en-ZA", {
        year: "numeric", month: "long", day: "numeric"
    });

    card.innerHTML = `
        <div class="booking-left">
            <div class="booking-dest">
                <div><img src="img/icons/earth.svg" alt="dest"></div>
                <div>
                    <h3>${booking.package_title}</h3>
                    <p class="dest-text">${booking.destination_city}, ${booking.destination_country}</p>
                </div>
            </div>
            <div class="booking-meta">
                <span class="meta-item">${booking.num_travellers} traveller${booking.num_travellers > 1 ? "s" : ""}</span>
                <span class="meta-item">${booking.agency_name}</span>
                <span class="meta-item">Booked: ${date}</span>
            </div>
        </div>
        <div class="booking-right">
            <p class="booking-price">R${parseFloat(booking.total_price).toLocaleString("en-ZA")}</p>
            <span class="booking-status ${statusClass}">${booking.booking_status}</span>
            ${booking.booking_status === "confirmed"
                ? booking.already_reviewed
                    ? `<div class="reviewed-badge">&#10003; Reviewed</div>`
                    : `<button class="review-btn" data-id="${booking.package_id}" data-title="${booking.package_title}">
                           Leave a Review
                       </button>`
                : ""
            }
        </div>
    `;

    const reviewBtn = card.querySelector(".review-btn");
    if (reviewBtn) {
        reviewBtn.addEventListener("click", () => {
            openModal(booking.package_id, booking.package_title);
        });
    }

    bookingsList.appendChild(card);
}

// ── Open modal ───────────────────────────────────────────────
function openModal(packageId, packageTitle) {
    activePackageId = packageId;
    modalPkgName.textContent   = packageTitle;
    selectedRating             = 0;
    reviewComment.value        = "";
    charCount.textContent      = "0";
    modalError.textContent     = "";
    ratingLabel.textContent    = "Select a rating";
    stars.forEach(s => s.classList.remove("selected", "hovered"));
    modalOverlay.style.display = "flex";
}

// ── Close modal ──────────────────────────────────────────────
modalClose.addEventListener("click", () => {
    modalOverlay.style.display = "none";
    activePackageId = null;
});

modalOverlay.addEventListener("click", (e) => {
    if (e.target === modalOverlay) {
        modalOverlay.style.display = "none";
        activePackageId = null;
    }
});

// ── Submit review (mock) ─────────────────────────────────────
submitBtn.addEventListener("click", () => {
    modalError.textContent = "";

    if (!selectedRating) {
        modalError.textContent = "Please select a rating.";
        return;
    }

    // Simulate API call
    submitBtn.disabled = true;
    submitBtn.querySelector("p").textContent = "Submitting...";

    setTimeout(() => {
        submitBtn.disabled = false;
        submitBtn.querySelector("p").textContent = "Submit Review";
        modalOverlay.style.display = "none";

        // Replace the button with reviewed badge
        const btn = document.querySelector(`.review-btn[data-id="${activePackageId}"]`);
        if (btn) {
            const badge = document.createElement("div");
            badge.className = "reviewed-badge";
            badge.innerHTML = "&#10003; Reviewed";
            btn.replaceWith(badge);
        }

        alert("Review submitted! (mock — not saved to DB)");
        activePackageId = null;
    }, 1000);
});

// ── Init ─────────────────────────────────────────────────────
loadBookings();