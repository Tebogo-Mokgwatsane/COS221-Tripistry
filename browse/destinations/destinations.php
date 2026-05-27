<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Destinations</title>
    <link rel="stylesheet" href="../../css/navbar.css">
    <link rel="stylesheet" href="../../css/style.css">
    <link rel="stylesheet" href="destinations.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <?php include("../navbar.php"); ?>

    <div class="container">
        <div class="page-header">
            <p class="r">EXPLORE</p>
            <h2 class="destinations-title">Destinations</h2>
            <p class="destinations-subtitle">Browse through your favourite destinations.</p>
        </div>

        <div class="search-container">
            <img src="../../img/icons/search.svg" alt="Search icon">
            <input id="search-bar" type="text" placeholder="Search for a city or country...">
        </div>

        <div id="destinations" class="destinations-grid"></div>
    </div>

    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">← Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next →</button>
    </div>

    <script src="destinations.js"></script>
    <script src="../../scripts/navbar.js"></script>
</body>
</html>