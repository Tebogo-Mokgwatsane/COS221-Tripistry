<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Destinations</title>
    <link rel="stylesheet" href="destinations.css">
    <link rel="stylesheet" href="../../css/navbar.css">

</head>
<body>
    <?php include ("../../navbar.php"); ?>
    <div class="filter-container">
        <div class="filter-group">
            <label>Airline:</label>
            <select id="airlineFilter">
                <option value="">All Airlines</option>
            </select>
        </div>
        <div class="filter-group">
            <label>Price Range:</label>
            <input type="range" id="priceFilter" min="0" max="5000" value="5000">
            <span id="priceDisplay">$5000</span>
        </div>
        <div class="filter-group">
            <label>From:</label>
            <select id="fromFilter">
                <option value="">All Airports</option>
            </select>
        </div>
        <div class="filter-group">
            <label>To:</label>
            <select id="toFilter">
                <option value="">All Airports</option>
            </select>
        </div>
    </div>
    
    <div id="destinations" class="destinations-grid" ></div>
    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next</button>
    </div>
<script src="destinations.js"></script>
<script src="scripts/navbar.js"></script>
</body>

</html>