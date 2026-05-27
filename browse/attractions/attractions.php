<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Attractions</title>
    <link rel="stylesheet" href="../../css/navbar.css">
    <link rel="stylesheet" href="../../css/style.css">
    <link rel="stylesheet" href="attractions.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <?php include("../navbar.php"); ?>

    <div class="container">
        <div class="page-header">
            <p class="r">EXPLORE</p>
            <h2 class="attractions-title">Attractions</h2>
            <p class="attractions-subtitle">Explore the best places to visit.</p>
        </div>

        <div class="filters">
            <div class="filter-group">
                <label class="label">MAX ENTRY FEE</label>
                <input type="range" id="max-fee" min="0" max="1000" value="1000">
                <span id="max-fee-value">R1000</span>
            </div>
        </div>

        <div class="attraction-grid" id="attractions"></div>
    </div>

    <div class="pagination-container">
        <button id="prevBtn" class="pagination-btn">← Previous</button>
        <span id="pageInfo" class="page-info">Page 1 of 1</span>
        <button id="nextBtn" class="pagination-btn">Next →</button>
    </div>

    <script src="attractions.js"></script>
</body>
</html>