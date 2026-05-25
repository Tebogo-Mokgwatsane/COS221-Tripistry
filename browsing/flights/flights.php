
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flights</title>
    <link rel="stylesheet" href="flights.css">
    <link rel="stylesheet" href="../../css/navbar.css">

</head>
<body>
    <?php include ("../../navbar.php"); ?>
    <div class="flights-section">
        <div class="filters">
            <div class="top">
                    <img src="../../img/icons/sliders-horizontal.svg" alt="Sliders icon">
                    <p>Filters</p>
            </div>
            <div class="filter-group">
                <label class="label">Price</label>
                <input type="range" id="priceFilter" >
                <span id="priceDisplay"></span>
            </div>
            <div class="filter-group">
                <label>From: </label>
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
            <div class="filter-group">
                <label>Class:</label>
                <div>
                    <button class="unchecked" id="economy-btn">Economy</button>
                    <button class="unchecked" id="business-btn">Business</button>
                    <button class="unchecked" id="first-btn">First Class</button>
                </div> 
            </div>                
        </div>
        <div id="flights" class="flight-grid" ></div>
    </div>
    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next</button>
    </div>

    
<script src="flights.js"></script>
<script src="scripts/navbar.js"></script>
</body>

</html>



