// ============================================================
// reviews.js — Booking history + review submission
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

// ── Guard: only travellers can access this page ──────────────
const user = JSON.parse(localStorage.getItem("user") || "{}");
if (!user || user.user_type !== "traveller") {
    window.location.href = "/login.html";
}

// ── Star rating labels ───────────────────────────────────────
const ratingLabels = {
    1: "Poor",
    2: "Fair",
    3: "Good",
    4: "Very Good",
    5: "Excellent"
};

// ── Render star rating (read-only) ──────────────────────────
function renderStars(rating, max = 5) {
    let html = "";
    for (let i = 1; i <= max; i++) {
        html += `<span class="star-display ${i <= rating ? 'filled' : ''}">&#9733;</span>`;
    }
    return html;
}

// ── Star picker interaction ──────────────────────────────────
stars.forEach(star => {
    star.addEventListener("mouseover", () => {
        const val = parseInt(star.dataset.value);
        stars.forEach(s => {
            s.classList.toggle("hovered", parseInt(s.dataset.value) <= val);
        });
        ratingLabel.textContent = ratingLabels[val];
    });

    star.addEventListener("mouseleave", () => {
        stars.forEach(s => s.classList.remove("hovered"));
        ratingLabel.textContent = selectedRating
            ? ratingLabels[selectedRating]
            : "Select a rating";
    });

    star.addEventListener("click", () => {
        selectedRating = parseInt(star.dataset.value);
        stars.forEach(s => {
            s.classList.toggle("selected", parseInt(s.dataset.value) <= selectedRating);
        });
        ratingLabel.textContent = ratingLabels[selectedRating];
    });
});

// ── Character counter for textarea ──────────────────────────
reviewComment.addEventListener("input", () => {
    charCount.textContent = reviewComment.value.length;
});

// ── Load bookings ────────────────────────────────────────────
function loadBookings() {
    const apiKey = user.apikey;
    if (!apiKey) {
        alert("Session expired. Please log in.");
        window.location.href = "/login.html";
        return;
    }

    fetch("/api.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type: "GetBookings", api_key: apiKey })
    })
    .then(res => res.json())
    .then(data => {
        loading.style.display = "none";

        if (data.status !== "success") {
            alert(data.message || "Failed to load bookings");
            return;
        }

        const bookings = data.data;

        if (!bookings || bookings.length === 0) {
            emptyState.style.display = "flex";
            return;
        }

        bookings.forEach(booking => renderBookingCard(booking));
    })
    .catch(err => {
        console.error(err);
        loading.style.display = "none";
        bookingsList.innerHTML = `<p class="error-msg">Failed to connect to server.</p>`;
    });
}

// ── Render one booking card ──────────────────────────────────
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
                <img src="img/icons/earth.svg" alt="destination" class="dest-icon">
                <div>
                    <h3>${booking.package_title}</h3>
                    <p class="dest-text">${booking.destination_city}, ${booking.destination_country}</p>
                </div>
            </div>
            <div class="booking-meta">
                <span class="meta-item">
                    <img src="img/icons/user.svg" alt="travellers">
                    ${booking.num_travellers} traveller${booking.num_travellers > 1 ? "s" : ""}
                </span>
                <span class="meta-item">
                    <img src="img/icons/compass.svg" alt="agency">
                    ${booking.agency_name}
                </span>
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

    // Attach click handler to the review button
    const reviewBtn = card.querySelector(".review-btn");
    if (reviewBtn) {
        reviewBtn.addEventListener("click", () => {
            openModal(booking.package_id, booking.package_title);
        });
    }

    bookingsList.appendChild(card);
}

// ── Open review modal ────────────────────────────────────────
function openModal(packageId, packageTitle) {
    activePackageId = packageId;
    modalPkgName.textContent = packageTitle;
    selectedRating  = 0;
    reviewComment.value = "";
    charCount.textContent = "0";
    modalError.textContent = "";
    ratingLabel.textContent = "Select a rating";
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

// ── Submit review ────────────────────────────────────────────
submitBtn.addEventListener("click", () => {
    modalError.textContent = "";

    if (!selectedRating) {
        modalError.textContent = "Please select a rating.";
        return;
    }

    const comment = reviewComment.value.trim();
    const apiKey  = getApiKey();

    submitBtn.disabled = true;
    submitBtn.querySelector("p").textContent = "Submitting...";

    fetch("api.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            type:       "AddReview",
            api_key:    apiKey,
            package_id: activePackageId,
            rating:     selectedRating,
            comment:    comment
        })
    })
    .then(res => res.json())
    .then(data => {
        submitBtn.disabled = false;
        submitBtn.querySelector("p").textContent = "Submit Review";

        if (data.status === "success") {
            modalOverlay.style.display = "none";
            // Replace the "Leave a Review" button with the reviewed badge
            const btn = document.querySelector(`.review-btn[data-id="${activePackageId}"]`);
            if (btn) {
                const badge = document.createElement("div");
                badge.className = "reviewed-badge";
                badge.innerHTML = "&#10003; Reviewed";
                btn.replaceWith(badge);
            }
            alert("Thank you! Your review has been submitted.");
            activePackageId = null;
        } else {
            modalError.textContent = data.message || "Failed to submit review.";
        }
    })
    .catch(err => {
        console.error(err);
        submitBtn.disabled = false;
        submitBtn.querySelector("p").textContent = "Submit Review";
        modalError.textContent = "Server error. Please try again.";
    });
});

// ── Init ─────────────────────────────────────────────────────
loadBookings();