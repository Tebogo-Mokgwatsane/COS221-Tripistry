
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
    <div id="flights" class="flight-grid" >
    </div>
    </div>
<script src="flights.js"></script>
<script src="scripts/navbar.js"></script>
</body>

</html>



