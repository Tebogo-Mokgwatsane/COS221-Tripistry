(function () {
// ============================================================
// agency.js — Agency dashboard logic
// ============================================================

const API_BASE = "http://localhost/COS221-Tripistry/api.php";

// ── Guard: agencies only ─────────────────────────────────────
const currentUser = JSON.parse(localStorage.getItem("user") || "{}");
if (!currentUser || currentUser.user_type !== "travel_agent") {
    alert("This page is for agencies only. Please log in.");
    window.location.href = "/COS221-Tripistry/login.html";
}

// Set username in navbar and header
const usernameEl = document.getElementById("username");
const agencyNameEl = document.getElementById("agency-name");
if (usernameEl)    usernameEl.textContent    = currentUser.username || "";
if (agencyNameEl)  agencyNameEl.textContent  = currentUser.username || "";

// ── Get API key from cookie ──────────────────────────────────
function getApiKey() {
    const match = document.cookie.match(/apiKey=([^;]+)/);
    return match ? match[1] : null;
}

// ── DOM refs ─────────────────────────────────────────────────
const loading          = document.getElementById("loading");
const packagesWrap     = document.getElementById("packages-table-wrap");
const tbody            = document.getElementById("packages-tbody");
const emptyState       = document.getElementById("empty-state");
const searchBar        = document.getElementById("search-bar");
const statusFilter     = document.getElementById("status-filter");
const createBtn        = document.getElementById("create-package-btn");

// Modal
const modalOverlay  = document.getElementById("modal-overlay");
const modalClose    = document.getElementById("modal-close");
const modalCancel   = document.getElementById("modal-cancel");
const modalSubmit   = document.getElementById("modal-submit");
const modalTitle    = document.getElementById("modal-title");
const modalError    = document.getElementById("modal-error");
const pkgTitle      = document.getElementById("pkg-title");
const pkgDest       = document.getElementById("pkg-dest");
const pkgPrice      = document.getElementById("pkg-price");
const pkgQuantity   = document.getElementById("pkg-quantity");
const pkgExpiry     = document.getElementById("pkg-expiry");
const pkgStatus     = document.getElementById("pkg-status");
const pkgDesc       = document.getElementById("pkg-desc");
const pkgIsGroup    = document.getElementById("pkg-is-group");
const groupFields   = document.getElementById("group-fields");
const pkgMinGroup   = document.getElementById("pkg-min-group");
const pkgMaxGroup   = document.getElementById("pkg-max-group");

// Delete modal
const deleteOverlay  = document.getElementById("delete-overlay");
const deleteCancel   = document.getElementById("delete-cancel");
const deleteConfirm  = document.getElementById("delete-confirm");
const deletePkgName  = document.getElementById("delete-pkg-name");

let allPackages    = [];
let editingPkgId   = null;
let deletingPkgId  = null;

// ── Toggle group fields ──────────────────────────────────────
pkgIsGroup.addEventListener("change", () => {
    groupFields.style.display = pkgIsGroup.checked ? "grid" : "none";
});

// ── Load destinations for select ─────────────────────────────
function loadDestinations() {
    fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type: "Destinations" })
    })
    .then(r => r.json())
    .then(data => {
        if (data.status !== "success") return;
        data.data.forEach(dest => {
            const opt = document.createElement("option");
            opt.value = dest.dest_id;
            opt.textContent = `${dest.city}, ${dest.country}`;
            pkgDest.appendChild(opt);
        });
    })
    .catch(err => console.error("Failed to load destinations:", err));
}
// ── Load agency packages ─────────────────────────────────────
function loadPackages() {
    const apiKey = getApiKey();
    if (!apiKey) {
        window.location.href = "/COS221-Tripistry/login.html";
        return;
    }

    loading.style.display  = "flex";
    packagesWrap.style.display = "none";
    emptyState.style.display   = "none";

    fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type: "GetAgencyPackages", api_key: apiKey })
    })
    .then(r => r.text())
    .then(text => {
        try {
            const data = JSON.parse(text);
            loading.style.display = "none";

            if (data.status !== "success") {
                emptyState.style.display = "flex";
                return;
            }

            allPackages = data.data || [];
            updateStats(allPackages);
            renderPackages(allPackages);
        } catch (e) {
            loading.style.display = "none";
            console.error("Response was not JSON:", text);
        }
    })
    .catch(err => {
        loading.style.display = "none";
        console.error(err);
    });
}

// ── Update stats ─────────────────────────────────────────────
function updateStats(packages) {
    document.getElementById("stat-packages").textContent = packages.length;

    const totalBookings = packages.reduce((s, p) => s + (parseInt(p.booking_count) || 0), 0);
    document.getElementById("stat-bookings").textContent = totalBookings;

    const rated  = packages.filter(p => parseFloat(p.avg_rating) > 0);
    const avgRating = rated.length
        ? (rated.reduce((s, p) => s + parseFloat(p.avg_rating), 0) / rated.length).toFixed(1)
        : "—";
    document.getElementById("stat-rating").textContent = avgRating === "—" ? "—" : `${avgRating} ★`;

    const totalReviews = packages.reduce((s, p) => s + (parseInt(p.review_count) || 0), 0);
    document.getElementById("stat-reviews").textContent = totalReviews;
}

// ── Render packages table ─────────────────────────────────────
function renderPackages(packages) {
    const search = searchBar.value.toLowerCase();
    const status = statusFilter.value;

    const filtered = packages.filter(p => {
        const matchSearch = !search
            || p.title.toLowerCase().includes(search)
            || p.destination_city.toLowerCase().includes(search);
        const matchStatus = !status || p.status === status;
        return matchSearch && matchStatus;
    });

    tbody.innerHTML = "";

    if (filtered.length === 0) {
        packagesWrap.style.display = "none";
        emptyState.style.display   = "flex";
        return;
    }

    packagesWrap.style.display = "block";
    emptyState.style.display   = "none";

    filtered.forEach(pkg => {
        const tr = document.createElement("tr");

        const expiry = new Date(pkg.expiry_date).toLocaleDateString("en-ZA", {
            year: "numeric", month: "short", day: "numeric"
        });

        const statusClass = {
            active:   "status-active",
            inactive: "status-inactive",
            sold_out: "status-sold_out"
        }[pkg.status] || "";

        const rating = parseFloat(pkg.avg_rating) > 0
            ? `★ ${parseFloat(pkg.avg_rating).toFixed(1)} (${pkg.review_count})`
            : "No reviews";

        tr.innerHTML = `
            <td>
                <p class="pkg-title-cell">${pkg.title}</p>
                ${pkg.is_group_package
                    ? `<span class="pkg-type-badge">Group</span>`
                    : ""
                }
            </td>
            <td>
                <div class="pkg-location">
                    <img src="../img/icons/map-pin.svg" alt="location">
                    ${pkg.destination_city}, ${pkg.destination_country}
                </div>
            </td>
            <td><span class="pkg-price">R${parseFloat(pkg.price).toLocaleString("en-ZA")}</span></td>
            <td>${pkg.quantity}</td>
            <td><span class="status-badge ${statusClass}">${pkg.status.replace("_", " ")}</span></td>
            <td><span class="rating-cell">${rating}</span></td>
            <td>${expiry}</td>
            <td>
                <div class="action-btns">
                    <button class="edit-btn" data-id="${pkg.package_id}">Edit</button>
                    <button class="delete-btn" data-id="${pkg.package_id}" data-title="${pkg.title}">Delete</button>
                </div>
            </td>
        `;

        tr.querySelector(".edit-btn").addEventListener("click",   () => openEditModal(pkg));
        tr.querySelector(".delete-btn").addEventListener("click", () => openDeleteModal(pkg.package_id, pkg.title));

        tbody.appendChild(tr);
    });
}

// ── Filter events ─────────────────────────────────────────────
searchBar.addEventListener("input",    () => renderPackages(allPackages));
statusFilter.addEventListener("change", () => renderPackages(allPackages));

// ── Open create modal ─────────────────────────────────────────
createBtn.addEventListener("click", () => {
    editingPkgId = null;
    modalTitle.textContent       = "Create Package";
    modalSubmit.textContent      = "Create Package";
    pkgTitle.value    = "";
    pkgDest.value     = "";
    pkgPrice.value    = "";
    pkgQuantity.value = "";
    pkgExpiry.value   = "";
    pkgStatus.value   = "active";
    pkgDesc.value     = "";
    pkgIsGroup.checked = false;
    groupFields.style.display = "none";
    pkgMinGroup.value = "";
    pkgMaxGroup.value = "";
    modalError.textContent = "";
    modalOverlay.style.display = "flex";
});

// ── Open edit modal ───────────────────────────────────────────
function openEditModal(pkg) {
    editingPkgId = pkg.package_id;
    modalTitle.textContent  = "Edit Package";
    modalSubmit.textContent = "Save Changes";
    pkgTitle.value    = pkg.title;
    pkgDest.value     = pkg.dest_id;
    pkgPrice.value    = pkg.price;
    pkgQuantity.value = pkg.quantity;
    pkgExpiry.value   = pkg.expiry_date?.split("T")[0] || pkg.expiry_date;
    pkgStatus.value   = pkg.status;
    pkgDesc.value     = pkg.description || "";
    pkgIsGroup.checked = pkg.is_group_package;
    groupFields.style.display = pkg.is_group_package ? "grid" : "none";
    pkgMinGroup.value = pkg.min_group_size || "";
    pkgMaxGroup.value = pkg.max_group_size || "";
    modalError.textContent = "";
    modalOverlay.style.display = "flex";
}

// ── Close modal ───────────────────────────────────────────────
function closeModal() {
    modalOverlay.style.display = "none";
    editingPkgId = null;
}

modalClose.addEventListener("click",  closeModal);
modalCancel.addEventListener("click", closeModal);
modalOverlay.addEventListener("click", e => {
    if (e.target === modalOverlay) closeModal();
});

// ── Submit create / edit ──────────────────────────────────────
modalSubmit.addEventListener("click",  () => {
    modalError.textContent = "";

    if (!pkgTitle.value.trim())  { modalError.textContent = "Title is required.";       return; }
    if (!pkgDest.value)          { modalError.textContent = "Destination is required."; return; }
    if (!pkgPrice.value || pkgPrice.value <= 0) { modalError.textContent = "Valid price is required."; return; }
    if (!pkgExpiry.value)        { modalError.textContent = "Expiry date is required."; return; }

    // Build FormData instead of JSON so image can be included
    const formData = new FormData();
    formData.append("type",        editingPkgId ? "UpdatePackage" : "CreatePackage");
    formData.append("api_key",     getApiKey());
    formData.append("title",       pkgTitle.value.trim());
    formData.append("dest_id",     pkgDest.value);
    formData.append("price",       pkgPrice.value);
    formData.append("quantity",    pkgQuantity.value || 0);
    formData.append("expiry_date", pkgExpiry.value);
    formData.append("status",      pkgStatus.value);
    formData.append("description", pkgDesc.value.trim());
    formData.append("is_group",    pkgIsGroup.checked ? "1" : "0");

    if (pkgIsGroup.checked) {
        formData.append("min_group_size", pkgMinGroup.value);
        formData.append("max_group_size", pkgMaxGroup.value);
    }

    if (editingPkgId) {
        formData.append("package_id", editingPkgId);
    }

    const imageFile = document.getElementById("pkg-image").files[0];
    if (imageFile) {
        formData.append("image", imageFile);
    }

    modalSubmit.disabled    = true;
    modalSubmit.textContent = "Saving...";

    

    // No Content-Type header — browser sets it automatically for FormData
    fetch(API_BASE, {
        method: "POST",
        body: formData
    })
    .then(r => r.json())
    .then(data => {
        modalSubmit.disabled    = false;
        modalSubmit.textContent = editingPkgId ? "Save Changes" : "Create Package";

        if (data.status === "success") {
            closeModal();
            loadPackages();
        } else {
            modalError.textContent = data.data || data.message || "Failed to save package.";
        }
    })
    .catch(err => {
        console.error(err);
        modalSubmit.disabled    = false;
        modalSubmit.textContent = editingPkgId ? "Save Changes" : "Create Package";
        modalError.textContent  = "Server error. Please try again.";
    });
});

// ── Delete modal ──────────────────────────────────────────────
 function openDeleteModal(pkgId, title) {
    deletingPkgId = pkgId;
    deletePkgName.textContent = title;
    deleteOverlay.style.display = "flex";
}

deleteCancel.addEventListener("click", () => {
    deleteOverlay.style.display = "none";
    deletingPkgId = null;
});

deleteOverlay.addEventListener("click", e => {
    if (e.target === deleteOverlay) {
        deleteOverlay.style.display = "none";
        deletingPkgId = null;
    }
});

deleteConfirm.addEventListener("click", () => {
    if (!deletingPkgId) return;

    deleteConfirm.disabled    = true;
    deleteConfirm.textContent = "Deleting...";

    

    fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            type:       "DeletePackage",
            api_key:    getApiKey(),
            package_id: deletingPkgId
        })
    })
    .then(r => r.json())
    .then(data => {
        deleteConfirm.disabled    = false;
        deleteConfirm.textContent = "Delete";

        if (data.status === "success") {
            deleteOverlay.style.display = "none";
            deletingPkgId = null;
            loadPackages();
        } else {
            alert(data.message || "Failed to delete package.");
        }
    })
    .catch(err => {
        console.error(err);
        deleteConfirm.disabled    = false;
        deleteConfirm.textContent = "Delete";
        alert("Server error. Please try again.");
    });
});

// ── Logout ────────────────────────────────────────────────────
const logoutBtn = document.getElementById("logout-btn");
if (logoutBtn) {
    logoutBtn.addEventListener("click", () => {
        localStorage.removeItem("user");
        document.cookie = "apiKey=; path=/; max-age=0";
        window.location.href = "/COS221-Tripistry/login.html";
    });
}

// ── Init ──────────────────────────────────────────────────────
loadDestinations();
loadPackages();

})();