<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Agency Bookings</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/agency.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
</head>
<body>
    <?php include("agency_navbar.php"); ?>

    <div class="container agency-dashboard">

        <div class="dashboard-header">
            <div>
                <h1>Bookings</h1>
                <p class="sub">All bookings made for your travel packages.</p>
            </div>
            <div class="filter-row">
                <div class="search-container">
                    <img src="../img/icons/search.svg" alt="Search">
                    <input type="text" id="search-bar" placeholder="Search traveller or package...">
                </div>
                <select id="status-filter">
                    <option value="">All Statuses</option>
                    <option value="confirmed">Confirmed</option>
                    <option value="pending">Pending</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-card">
                <p class="stat-label">TOTAL BOOKINGS</p>
                <p class="stat-value" id="stat-total">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">CONFIRMED</p>
                <p class="stat-value" id="stat-confirmed" style="color:rgb(4,171,98)">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">PENDING</p>
                <p class="stat-value" id="stat-pending" style="color:rgb(255,149,0)">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">TOTAL REVENUE</p>
                <p class="stat-value" id="stat-revenue">—</p>
            </div>
        </div>

        <!-- Loading -->
        <div class="loading" id="loading">
            <div class="spinner"></div>
            <p>Loading bookings...</p>
        </div>

        <!-- Table -->
        <div class="packages-table-wrap" id="bookings-table-wrap" style="display:none;">
            <table class="packages-table">
                <thead>
                    <tr>
                        <th>Traveller</th>
                        <th>Package</th>
                        <th>Destination</th>
                        <th>Travellers</th>
                        <th>Total Paid</th>
                        <th>Status</th>
                        <th>Booked On</th>
                    </tr>
                </thead>
                <tbody id="bookings-tbody"></tbody>
            </table>
        </div>

        <!-- Empty state -->
        <div class="empty-state" id="empty-state" style="display:none;">
            <div><img src="../img/icons/earth.svg" alt="no bookings"></div>
            <h2>No bookings yet</h2>
            <p>Bookings will appear here once travellers book your packages.</p>
        </div>

    </div>

    <script src="../scripts/agency_bookings.js"></script>
</body>
</html>