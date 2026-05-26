<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Traveller Dashboard</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/packages.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
</head>
<body>
    <?php include("navbar.php"); ?>
    <div class="container packages">
        <div class="search-section">
            <h1>Welcome back, <span id="packages-username"></span>!</h1>
            <div class="search-container">
                <img src="../img/icons/search.svg" alt="Search icon">
                <input id="search-bar" type="text" placeholder="Search for a destination, package, or an agency">
            </div>
        </div>
        
        <div class="packages-section">
            <div class="filters">
                <div class="top">
                    <img src="../img/icons/sliders-horizontal.svg" alt="Sliders icon">
                    <p>Filters</p>
                </div>
                <div class="middle-filter">
                    <label class="label">MAX PRICE</label>
                    <input type="range" name="max-price" id="max-price">
                    <div>Up to <span id="max-selected-price"></span></div>
                </div>
                <div class="middle-filter">
                    <label class="label package-type">PACKAGE TYPE</label>
                    <div>
                        <button class="unchecked" id="group-btn">Group</button>
                        <button class="unchecked" id="solo-btn">Solo</button>
                    </div>
                </div>
                <div class="in-stock-only">
                    <input type="checkbox" name="in-stock-only" id="in-stock-only">
                    <label for="in-stock-only">In stock only</label>
                </div>
            </div>
            <div class="packages-cards" id="packages-cards">

            </div>
        </div>
    </div>
    <!-- <script src="../scripts/traveller.js"></script> -->
    <script src="../scripts/packages.js"></script>
</body>
</html>