(function () {
// ============================================================
// agency_packages.js — Full package management
// ============================================================

const API_BASE = "http://localhost/COS221-Tripistry/api.php";

const currentUser = JSON.parse(localStorage.getItem("user") || "{}");
if (!currentUser || currentUser.user_type !== "travel_agent") {
    window.location.href = "/COS221-Tripistry/login.html";
}

function getApiKey() {
    const match = document.cookie.match(/apiKey=([^;]+)/);
    return match ? match[1] : null;
}

// ── DOM refs ──────────────────────────────────────────────────
const loading       = document.getElementById("loading");
const tableWrap     = document.getElementById("packages-table-wrap");
const tbody         = document.getElementById("packages-tbody");
const emptyState    = document.getElementById("empty-state");
const resultsCount  = document.getElementById("results-count");
const searchBar     = document.getElementById("search-bar");
const destFilter    = document.getElementById("dest-filter");
const statusFilter  = document.getElementById("status-filter");
const sortFilter    = document.getElementById("sort-filter");
const applyBtn      = document.getElementById("apply-btn");
const clearBtn      = document.getElementById("clear-btn");
const createBtn     = document.getElementById("create-package-btn");

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

let allPackages   = [];
let editingPkgId  = null;
let deletingPkgId = null;

// ── Group toggle ──────────────────────────────────────────────
pkgIsGroup.addEventListener("change", () => {
    groupFields.style.display = pkgIsGroup.checked ? "grid" : "none";
});

// ── Load destinations for select ─────────────────────────────
function loadDestinations() {
    fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type: "GetPackages" })
    })
    .then(r => r.json())
    .then(data => {
        if (data.status !== "success") return;
        const seen = new Set();
        data.data.forEach(pkg => {
            if (!seen.has(pkg.dest_id)) {
                seen.add(pkg.dest_id);
                // Dest filter dropdown
                const opt1 = document.createElement("option");
                opt1.value = pkg.dest_id;
                opt1.textContent = `${pkg.destination_city}, ${pkg.destination_country}`;
                destFilter.appendChild(opt1);
                // Modal dropdown
                const opt2 = document.createElement("option");
                opt2.value = pkg.dest_id;
                opt2.textContent = `${pkg.destination_city}, ${pkg.destination_country}`;
                pkgDest.appendChild(opt2);
            }
        });
    })
    .catch(err => console.error(err));
}

// ── Load agency packages ──────────────────────────────────────
function loadPackages() {
    const apiKey = getApiKey();
    if (!apiKey) { window.location.href = "/COS221-Tripistry/login.html"; return; }

    loading.style.display      = "flex";
    tableWrap.style.display    = "none";
    emptyState.style.display   = "none";
    resultsCount.textContent   = "";

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
            if (data.status !== "success") { emptyState.style.display = "flex"; return; }
            allPackages = data.data || [];
            applyFilters();
        } catch(e) {
            loading.style.display = "none";
            console.error("Not JSON:", text);
        }
    })
    .catch(err => { loading.style.display = "none"; console.error(err); });
}

// ── Apply filters + render ────────────────────────────────────
function applyFilters() {
    const search = searchBar.value.toLowerCase();
    const dest   = parseInt(destFilter.value)   || 0;
    const status = statusFilter.value;
    const sortVal = sortFilter.value.split("-");
    const sortBy  = sortVal[0];
    const order   = sortVal[1];

    let filtered = allPackages.filter(p => {
        const matchSearch = !search
            || p.title.toLowerCase().includes(search)
            || p.destination_city?.toLowerCase().includes(search);
        const matchDest   = !dest   || p.dest_id === dest;
        const matchStatus = !status || p.status === status;
        return matchSearch && matchDest && matchStatus;
    });

    // Sort
    filtered.sort((a, b) => {
        let va = a[sortBy], vb = b[sortBy];
        if (sortBy === "price" || sortBy === "avg_rating") {
            va = parseFloat(va) || 0;
            vb = parseFloat(vb) || 0;
        }
        if (order === "ASC") return va > vb ? 1 : -1;
        return va < vb ? 1 : -1;
    });

    resultsCount.textContent = `${filtered.length} package${filtered.length !== 1 ? "s" : ""} found`;
    renderPackages(filtered);
}

// ── Render table ──────────────────────────────────────────────
function renderPackages(packages) {
    tbody.innerHTML = "";

    if (packages.length === 0) {
        tableWrap.style.display  = "none";
        emptyState.style.display = "flex";
        return;
    }

    tableWrap.style.display  = "block";
    emptyState.style.display = "none";

    packages.forEach(pkg => {
        const tr = document.createElement("tr");

        const statusClass = {
            active:   "b-active",
            inactive: "b-inactive",
            sold_out: "b-sold"
        }[pkg.status] || "";

        const expiry = new Date(pkg.expiry_date).toLocaleDateString("en-ZA", {
            year: "numeric", month: "short", day: "numeric"
        });

        const rating = parseFloat(pkg.avg_rating) > 0
            ? `★ ${parseFloat(pkg.avg_rating).toFixed(1)} (${pkg.review_count})`
            : "No reviews";

        const qtyClass = parseInt(pkg.quantity) === 0 ? "qty-low" : "qty-ok";

        tr.innerHTML = `
            <td>
                <div style="display:flex;align-items:center;gap:10px;">
                    <div class="pkg-icon-circle">
                        <img src="../img/icons/earth.svg" alt="">
                    </div>
                    <div>
                        <p class="pkg-title-cell">${pkg.title}</p>
                        ${pkg.is_group_package
                            ? `<span class="pkg-type-badge">Group Package</span>`
                            : ""}
                    </div>
                </div>
            </td>
            <td>
                <div class="pkg-location">
                    <img src="../img/icons/map-pin.svg" alt="">
                    ${pkg.destination_city}, ${pkg.destination_country}
                </div>
            </td>
            <td><span class="pkg-price">R${parseFloat(pkg.price).toLocaleString("en-ZA")}</span></td>
            <td><span class="${qtyClass}">${pkg.quantity}</span></td>
            <td><span class="status-badge ${statusClass}">${pkg.status.replace("_", " ")}</span></td>
            <td><span class="rating-cell">${rating}</span></td>
            <td style="font-weight:600;font-size:14px;">${pkg.booking_count || 0}</td>
            <td style="color:gray;font-size:12px;">${expiry}</td>
            <td>
                <div class="action-btns">
                    <button class="view-btn-sm" data-id="${pkg.package_id}">View</button>
                    <button class="edit-btn" data-id="${pkg.package_id}">Edit</button>
                    <button class="delete-btn" data-id="${pkg.package_id}" data-title="${pkg.title}">Delete</button>
                </div>
            </td>
        `;

        tr.querySelector(".edit-btn").addEventListener("click",   () => openEditModal(pkg));
        tr.querySelector(".delete-btn").addEventListener("click", () => openDeleteModal(pkg.package_id, pkg.title));
        tr.querySelector(".view-btn-sm").addEventListener("click", () => {
            window.location.href = `package.php?id=${pkg.package_id}`;
        });

        tbody.appendChild(tr);
    });
}

// ── Filter events ─────────────────────────────────────────────
applyBtn.addEventListener("click",       applyFilters);
clearBtn.addEventListener("click", () => {
    searchBar.value    = "";
    destFilter.value   = "";
    statusFilter.value = "";
    sortFilter.value   = "created_at-DESC";
    applyFilters();
});
searchBar.addEventListener("keydown", e => { if (e.key === "Enter") applyFilters(); });

// ── Open create modal ─────────────────────────────────────────
createBtn.addEventListener("click", () => {
    editingPkgId             = null;
    modalTitle.textContent   = "Create Package";
    modalSubmit.textContent  = "Create Package";
    pkgTitle.value    = "";
    pkgDest.value     = "";
    pkgPrice.value    = "";
    pkgQuantity.value = "";
    pkgExpiry.value   = "";
    pkgStatus.value   = "active";
    pkgDesc.value     = "";
    pkgIsGroup.checked         = false;
    groupFields.style.display  = "none";
    pkgMinGroup.value = "";
    pkgMaxGroup.value = "";
    modalError.textContent     = "";
    modalOverlay.style.display = "flex";
});

// ── Open edit modal ───────────────────────────────────────────
function openEditModal(pkg) {
    editingPkgId             = pkg.package_id;
    modalTitle.textContent   = "Edit Package";
    modalSubmit.textContent  = "Save Changes";
    pkgTitle.value    = pkg.title;
    pkgDest.value     = pkg.dest_id;
    pkgPrice.value    = pkg.price;
    pkgQuantity.value = pkg.quantity;
    pkgExpiry.value   = (pkg.expiry_date || "").split("T")[0];
    pkgStatus.value   = pkg.status;
    pkgDesc.value     = pkg.description || "";
    pkgIsGroup.checked         = pkg.is_group_package;
    groupFields.style.display  = pkg.is_group_package ? "grid" : "none";
    pkgMinGroup.value = pkg.min_group_size || "";
    pkgMaxGroup.value = pkg.max_group_size || "";
    modalError.textContent     = "";
    modalOverlay.style.display = "flex";
}

// ── Close modal ───────────────────────────────────────────────
function closeModal() {
    modalOverlay.style.display = "none";
    editingPkgId = null;
}

modalClose.addEventListener("click",  closeModal);
modalCancel.addEventListener("click", closeModal);
modalOverlay.addEventListener("click", e => { if (e.target === modalOverlay) closeModal(); });

// ── Submit create / edit ──────────────────────────────────────
modalSubmit.addEventListener("click", () => {
    modalError.textContent = "";

    if (!pkgTitle.value.trim())            { modalError.textContent = "Title is required.";       return; }
    if (!pkgDest.value)                    { modalError.textContent = "Destination is required."; return; }
    if (!pkgPrice.value || pkgPrice.value <= 0) { modalError.textContent = "Valid price is required."; return; }
    if (!pkgExpiry.value)                  { modalError.textContent = "Expiry date is required."; return; }

    const payload = {
        type:           editingPkgId ? "UpdatePackage" : "CreatePackage",
        api_key:        getApiKey(),
        title:          pkgTitle.value.trim(),
        dest_id:        parseInt(pkgDest.value),
        price:          parseFloat(pkgPrice.value),
        quantity:       parseInt(pkgQuantity.value) || 0,
        expiry_date:    pkgExpiry.value,
        status:         pkgStatus.value,
        description:    pkgDesc.value.trim(),
        is_group:       pkgIsGroup.checked,
        min_group_size: pkgIsGroup.checked ? parseInt(pkgMinGroup.value) : null,
        max_group_size: pkgIsGroup.checked ? parseInt(pkgMaxGroup.value) : null,
    };

    if (editingPkgId) payload.package_id = editingPkgId;

    modalSubmit.disabled    = true;
    modalSubmit.textContent = "Saving...";

    fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
    })
    .then(r => r.json())
    .then(data => {
        modalSubmit.disabled    = false;
        modalSubmit.textContent = editingPkgId ? "Save Changes" : "Create Package";

        if (data.status === "success") {
            closeModal();
            loadPackages();
        } else {
            modalError.textContent = data.message || "Failed to save package.";
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
    deletePkgName.textContent  = title;
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

// ── Extra styles for this page ────────────────────────────────
const style = document.createElement("style");
style.textContent = `
.filter-bar{background:white;border:1px solid #ccc;border-radius:20px;padding:16px 20px;margin-bottom:16px;display:flex;gap:10px;align-items:center;flex-wrap:wrap;}
.results-count{font-size:14px;color:gray;margin-bottom:12px;}
.pkg-icon-circle{width:38px;height:38px;border-radius:10px;background:rgb(0,106,255);display:flex;align-items:center;justify-content:center;flex-shrink:0;}
.pkg-icon-circle img{width:20px;filter:invert(1);}
.qty-low{color:rgb(217,52,52);font-weight:700;}
.qty-ok{color:#374151;}
.view-btn-sm{padding:5px 10px;background:transparent;color:gray;border:1px solid #ccc;border-radius:20px;font-size:11px;cursor:pointer;}
.view-btn-sm:hover{background:rgb(244,244,252);}
.b-inactive{background:rgba(0,0,0,.06);color:gray;}
`;
document.head.appendChild(style);

// ── Init ──────────────────────────────────────────────────────
loadDestinations();
loadPackages();

})();