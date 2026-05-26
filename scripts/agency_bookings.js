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

const loading      = document.getElementById("loading");
const tableWrap    = document.getElementById("bookings-table-wrap");
const tbody        = document.getElementById("bookings-tbody");
const emptyState   = document.getElementById("empty-state");
const searchBar    = document.getElementById("search-bar");
const statusFilter = document.getElementById("status-filter");

let allBookings = [];

function loadBookings() {
    const apiKey = getApiKey();
    if (!apiKey) { window.location.href = "/COS221-Tripistry/login.html"; return; }

    fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type: "GetAgencyBookings", api_key: apiKey })
    })
    .then(r => r.text())
    .then(text => {
        try {
            const data = JSON.parse(text);
            loading.style.display = "none";
            if (data.status !== "success") { emptyState.style.display = "flex"; return; }
            allBookings = data.data || [];
            updateStats(allBookings);
            renderBookings(allBookings);
        } catch(e) {
            loading.style.display = "none";
            console.error("Not JSON:", text);
        }
    })
    .catch(err => { loading.style.display = "none"; console.error(err); });
}

function updateStats(bookings) {
    document.getElementById("stat-total").textContent     = bookings.length;
    document.getElementById("stat-confirmed").textContent = bookings.filter(b => b.booking_status === "confirmed").length;
    document.getElementById("stat-pending").textContent   = bookings.filter(b => b.booking_status === "pending").length;
    const revenue = bookings
        .filter(b => b.booking_status === "confirmed")
        .reduce((s, b) => s + parseFloat(b.total_price), 0);
    document.getElementById("stat-revenue").textContent   = "R" + revenue.toLocaleString("en-ZA");
}

function renderBookings(bookings) {
    const search = searchBar.value.toLowerCase();
    const status = statusFilter.value;

    const filtered = bookings.filter(b => {
        const matchSearch = !search
            || b.traveller_name?.toLowerCase().includes(search)
            || b.package_title?.toLowerCase().includes(search);
        const matchStatus = !status || b.booking_status === status;
        return matchSearch && matchStatus;
    });

    tbody.innerHTML = "";

    if (filtered.length === 0) {
        tableWrap.style.display = "none";
        emptyState.style.display = "flex";
        return;
    }

    tableWrap.style.display = "block";
    emptyState.style.display = "none";

    filtered.forEach(b => {
        const tr = document.createElement("tr");

        const statusClass = {
            confirmed: "b-active",
            pending:   "status-pending-badge",
            cancelled: "b-sold"
        }[b.booking_status] || "";

        const date = new Date(b.booking_date).toLocaleDateString("en-ZA", {
            year: "numeric", month: "short", day: "numeric"
        });

        const initials = (b.traveller_name || "?")
            .split(" ").map(w => w[0]).join("").toUpperCase().slice(0, 2);

        tr.innerHTML = `
            <td>
                <div style="display:flex;align-items:center;gap:10px;">
                    <div class="reviewer-avatar" style="width:32px;height:32px;font-size:12px;">${initials}</div>
                    <div>
                        <p class="traveller-cell">${b.traveller_name || "Unknown"}</p>
                        <p class="traveller-sub">${b.traveller_email || ""}</p>
                    </div>
                </div>
            </td>
            <td style="font-size:14px;font-weight:600;">${b.package_title}</td>
            <td>
                <div style="display:flex;align-items:center;gap:4px;color:rgb(0,106,255);font-size:13px;">
                    <img src="../img/icons/map-pin.svg" alt="" style="width:14px;">
                    ${b.destination_city}, ${b.destination_country}
                </div>
            </td>
            <td style="font-size:14px;">${b.num_travellers}</td>
            <td style="font-weight:bold;font-size:14px;">R${parseFloat(b.total_price).toLocaleString("en-ZA")}</td>
            <td><span class="badge ${statusClass}">${b.booking_status}</span></td>
            <td style="color:gray;font-size:13px;">${date}</td>
        `;

        tbody.appendChild(tr);
    });
}

searchBar.addEventListener("input",     () => renderBookings(allBookings));
statusFilter.addEventListener("change", () => renderBookings(allBookings));

// Add missing badge style
const style = document.createElement("style");
style.textContent = `.status-pending-badge{background:rgba(255,149,0,.15);color:rgb(255,149,0);display:inline-flex;align-items:center;padding:3px 10px;border-radius:25px;font-size:11px;font-weight:700;}`;
document.head.appendChild(style);

loadBookings();
})();