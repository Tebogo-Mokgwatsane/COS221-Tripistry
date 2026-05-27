<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Flights</title>
    <link rel="stylesheet" href="../../css/navbar.css">
    <link rel="stylesheet" href="../../css/style.css">
    <link rel="stylesheet" href="flights.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <?php include("../navbar.php"); ?>

    <div class="container">
        <div class="flights-header">
            <p class="r">EXPLORE</p>
            <h2 class="flights-title">Flights</h2>
            <p class="flights-subtitle">Browse through available flights.</p>
        </div>

        <div class="flights-section">
            <div class="filters">
                <div class="top">
                    <img src="../../img/icons/sliders-horizontal.svg" alt="Sliders icon">
                    <p>Filters</p>
                </div>
                <div class="filter-group">
                    <label class="label">MAX PRICE</label>
                    <input type="range" id="priceFilter" class="pricefilter">
                    <span id="priceDisplay" class="pricedisplay">R0.00</span>
                </div>
                <div class="filter-group">
                    <label class="label">FROM</label>
                    <select id="fromFilter" class="dropdown">
                        <option value="">All Airports</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="label">TO</label>
                    <select id="toFilter" class="dropdown">
                        <option value="">All Airports</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="label">CLASS</label>
                    <div>
                        <button class="unchecked" id="economy-btn">Economy</button>
                        <button class="unchecked" id="business-btn">Business</button>
                        <button class="unchecked" id="first-btn">First Class</button>
                    </div>
                </div>
            </div>

            <div id="flights" class="flight-grid"></div>
        </div>
    </div>

    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">← Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next →</button>
    </div>

    <script src="flights.js"></script>
    <script src="../../scripts/navbar.js"></script>
</body>
</html>