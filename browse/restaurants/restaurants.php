<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Restaurants</title>
    <link rel="stylesheet" href="restaurants.css">
    <link rel="stylesheet" href="../../css/navbar.css">
</head>
<body>
    <?php include("../navbar.php"); ?>
    
    <div class="container" style="margin-top: 140px;">
        <h2 class="restaurants-title">Restaurants</h2>
        <p class="restaurants-subtitle">Discover the Best Places to Eat</p>
        <div class="filters">
            <div class="filter-group">
                <label class="label">Average Price</label>
                <input type="range" id="max-fee" min="0" max="1000" value="1000">
                <span id="max-fee-value">R1000</span>
            </div>
        </div>

        <div class="restaurant-grid" id="restaurants"></div>
    </div>
    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next</button>
    </div>

    <script src="restaurants.js"></script>
</body>
</html>