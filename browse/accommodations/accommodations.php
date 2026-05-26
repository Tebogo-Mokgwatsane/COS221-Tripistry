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
    <?php include("../../traveller/navbar.php"); ?>
    
    <div class="container" style="margin-top: 100px;">
        <h1>Find Your Perfect Stay 🏨</h1>
        
        <div class="filters">
            <div class="filter-group">
                <label>MAX PRICE PER NIGHT</label>
                <input type="range" id="max-price" min="0" max="5000" value="5000">
                <span id="max-price-value">R5000</span>
            </div>
            
            <div class="filter-group">
                <label>ACCOMMODATION TYPE</label>
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
    <script src="accommodations.js"></script>
</body>
</html>