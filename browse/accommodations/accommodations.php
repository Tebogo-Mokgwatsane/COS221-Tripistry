<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Accommodations</title>
    <link rel="stylesheet" href="accommodations.css">
    <link rel="stylesheet" href="../../css/navbar.css">
</head>
<body>
    <?php include("../navbar.php"); ?>
    
    <div class="container" style="margin-top: 140px;">
        <h2 class="accommodations-title">Accommodations</h2>
        <p class="accommodations-subtitle">Find Your Perfect Stay</p>
        <div class="filters">
            <div class="filter-group">
                <label  class="label">Price Per Night</label>
                <input type="range" id="max-price" min="0" max="5000" value="5000">
                <span id="max-price-value">R5000</span>
            </div>
            
            <div class="filter-group">
                <div class="type-filters">
                    <button class="type-btn active" data-type="all">All</button>
                    <button class="type-btn" data-type="Hotel">Hotel</button>
                    <button class="type-btn" data-type="Resort">Resort</button>
                    <button class="type-btn" data-type="Hostel">Hostel</button>
                </div>
            </div>
        </div>

        <div class="accommodation-grid" id="accommodations"></div>
    </div>
    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next</button>
    </div>
    <script src="accommodations.js"></script>
</body>
</html>