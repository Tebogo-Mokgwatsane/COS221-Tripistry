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
    <?php include("../../traveller/navbar.php"); ?>
    
    <div class="container" style="margin-top: 100px;">
        <h1>Best Restaurants to Visit 🍽️</h1>
        
        <div class="filters">
            <div class="filter-group">
                <label>MAX AVG FEE</label>
                <input type="range" id="max-fee" min="0" max="1000" value="1000">
                <span id="max-fee-value">R1000</span>
            </div>
        </div>

        <div class="restaurant-grid" id="restaurants"></div>
    </div>

    <script src="restaurants.js"></script>
</body>
</html>