<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripinstry - Destinations</title>
    <link rel="stylesheet" href="destinations.css">
    <link rel="stylesheet" href="../../css/navbar.css">

</head>
<body>
    <?php include ("../../traveller/navbar.php"); ?>
    <div class="destinations-header">
        <h2 class="destinations-title">Destinations</h2>
        <p class="destinations-subtitle">Browse through your favourite Destinations</p>
    </div>
    <div class="search-container">
            <img src="../../img/icons/search.svg" alt="Search icon">
            <input id="search-bar" type="text" placeholder="Search for a city or country">
    </div>
    
    <div id="destinations" class="destinations-grid" ></div>

    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next</button>
    </div>

</body>
<script src="destinations.js"></script>
<script src="../../scripts/navbar.js"></script>
</html>