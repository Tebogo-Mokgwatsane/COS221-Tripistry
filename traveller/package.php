<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/style.css">    
    <link rel="stylesheet" href="../css/package.css">    

</head>
<body>
    <?php include("navbar.php"); ?>
    <div class="container package-page">
        <a href="/traveller/" class="back"><img src="../img/icons/arrow-left.svg" alt="Arrow left">Back to packages</a>
        <div class="package-img-container">
            <div class="package-overlay" ></div>
            <div class="package-details">
                <div class="top-details">
                    <div class="in-stock package-sticker">
                        <img src="../img/icons/circle-check.svg" alt="Circle check">
                        <span>In Stock</span>
                    </div>
                    <div class="group-package package-sticker">
                        <img src="../img/icons/users.svg" alt="Users">
                        <span>Group Package</span>
                    </div>
                    <div class="location package-sticker">
                        <img src="../img/icons/map-pin-white.svg" alt="Map pin">
                        <span>Cape Town, South Africa</span>
                    </div>
                </div>
                <h1>Table Mountain Adventure</h1>
                <div class="bottom-details">
                    <div class="package-rating package-sticker">
                        <svg width="15" height="15" viewBox="0 0 100 100">
                            <polygon points="50,5 61,35 95,35 67,57 78,90 50,72 22,90 33,57 5,35 39,35" fill="orange"/>
                        </svg> 
                        <span>4.9</span>
                        <span>(84 reviews)</span>
                    </div>
                    <div class="duration package-sticker">
                        <img src="../img/icons/clock-white.svg" alt="Clock">
                        <span> 7 nights</span>
                    </div>
                    <div class="expires package-sticker">
                        <img src="../img/icons/calendar.svg" alt="Calendar">
                        <span> Expires May 31, 2026</span>
                    </div>
                </div>
            </div>
            <div class="package-price">
                <span>R4,999</span> / person
            </div>
        </div>
    </div>
</body>
<script src="../scripts/view.js"></script>
</html>