<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Attractions</title>
    <link rel="stylesheet" href="attractions.css">
    <link rel="stylesheet" href="../../css/navbar.css">
</head>
<body>
    <?php include("../../traveller/navbar.php"); ?>
    
    <div class="container" style="margin-top: 140px;">
        <h2 class="attractions-title">Attractions</h2>
        <p class="attractions-subtitle">Explore the Best Places to Visit</p>
        <div class="filters">
            <div class="filter-group">
                <label  class="label">Entry Fee</label>
                <input type="range" id="max-fee" min="0" max="1000" value="1000">
                <span id="max-fee-value">R1000</span>
            </div>
        </div>

        <div class="attraction-grid" id="attractions"></div>
    </div>
    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next</button>
    </div>

    <script src="attractions.js"></script>
</body>
</html>