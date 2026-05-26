<<<<<<< Updated upstream
=======
<?php
require_once '../Tripistry/auth.php';
requireRole('travel_agent');
?>
>>>>>>> Stashed changes
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
                <h1>Reviews</h1>
                <p class="sub">What travellers are saying about your packages.</p>
            </div>
            <div class="filter-row">
                <select id="rating-filter">
                    <option value="">All Ratings</option>
                    <option value="5">★★★★★ 5 stars</option>
                    <option value="4">★★★★ 4 stars</option>
                    <option value="3">★★★ 3 stars</option>
                    <option value="2">★★ 2 stars</option>
                    <option value="1">★ 1 star</option>
                </select>
                <select id="package-filter">
                    <option value="">All Packages</option>
                </select>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-card">
                <p class="stat-label">TOTAL REVIEWS</p>
                <p class="stat-value" id="stat-total">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">AVG RATING</p>
                <p class="stat-value" id="stat-avg">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">5 STAR REVIEWS</p>
                <p class="stat-value" id="stat-five" style="color:rgb(4,171,98)">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">1-2 STAR REVIEWS</p>
                <p class="stat-value" id="stat-low" style="color:rgb(217,52,52)">—</p>
            </div>
        </div>

        <!-- Loading -->
        <div class="loading" id="loading">
            <div class="spinner"></div>
            <p>Loading reviews...</p>
        </div>

        <!-- Reviews grid -->
        <div class="reviews-grid" id="reviews-grid"></div>

        <!-- Empty state -->
        <div class="empty-state" id="empty-state" style="display:none;">
            <div><img src="../img/icons/badge-check.svg" alt="no reviews"></div>
            <h2>No reviews yet</h2>
            <p>Reviews from travellers will appear here after they complete their trips.</p>
        </div>

    </div>

    <script src="../scripts/agency_reviews.js"></script>
</body>
</html>