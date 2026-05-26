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
        <a href="index.html" class="back"><img src="../img/icons/arrow-left.svg" alt="Arrow left">Back to packages</a>
        <div class="package-img-container">
            <div class="package-overlay"></div>
            <div class="package-details">
                <div class="top-details">
                    <div class="in-stock package-sticker">
                        <img src="../img/icons/circle-check.svg" alt="Circle check">
                        <span>In Stock</span>
                    </div>
                    <div class="group-package package-sticker">
                        <img src="../img/icons/users-white.svg" alt="Users">
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
                            <polygon points="50,5 61,35 95,35 67,57 78,90 50,72 22,90 33,57 5,35 39,35" fill="orange" />
                        </svg>
                        <span>4.9</span>
                        <span class="reviews-count">(84 reviews)</span>
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
        </div>
        <div class=" wrapper trip-details">
            <div>
                <h2>About this trip</h2>
                <p class="trip-description">Lorem ipsum dolor sit amet consectetur, adipisicing elit. Incidunt ipsam
                    adipisci natus cumque excepturi ducimus. Libero vel ducimus minima itaque optio maiores officiis
                    voluptas iste, corrupti hic rem! Incidunt quod aliquam rem amet nemo labore quam repudiandae nostrum
                    necessitatibus beatae?</p>
                <h2 class="activities-title">Day-by-day activities</h2>
                <div class="timeline" id="timeline"></div>
                <h2 class="section-title">Flights</h2>
                <div class="flight-card">
                    <div class="flight-top">
                        <h2>South African Airways</h2>
                        <div class="flight-badge">Direct flight</div>
                    </div>
                    <div class="flight-route">
                        <div class="airport">
                            <div class="airport-code">JNB</div>
                        </div>
                        <div class="flight-line"></div>
                        <div class="airport">
                            <div class="airport-code">CPT</div>
                        </div>
                    </div>
                </div>
                <h2 class="section-title">Where you'll stay</h2>
                <div class="accommodation-card">
                    <div class="accommodation-img">
                        <img src="https://www.manhattanhotel.co.za/assets/img/customer/hotel.png" alt="Hotel">
                    </div>
                    <div class="accommodation-content">
                        <div class="accommodation-top">
                            <div>
                                <div class="accommodation-type">Hotel</div>
                                <div class="accommodation-name">The Bay Hotel</div>
                            </div>
                            <div class="accommodation-rating">★ 4.9</div>
                        </div>
                        <p class="accommodation-description">Five-star hotel at the V&A Waterfront with views of Table Mountain and luxury ocean-facing suites.</p>
                    </div>
                </div>
                <h2 class="section-title">Dining picks</h2>
                <div class="accommodation-card">
                    <div class="accommodation-img">
                        <img src="https://www.byblos.com/wp-content/uploads/Restaurant-IL-Giardino_Hotel-Byblos_Saint-Tropez-%C2%A9Stephan-Julliard-7-1600x1000.jpg" alt="accommodation">
                    </div>
                    <div class="accommodation-content">
                        <div class="accommodation-top">
                            <div>
                                <div class="accommodation-type">RESTAURANT</div>
                                <div class="accommodation-name">GOLD Restaurant</div>
                            </div>
                            <div class="accommodation-rating">★ 4.9</div>
                        </div>
                        <p class="accommodation-description">African dining experience with live entertainment and local dishes.</p>
                    </div>
                </div>
                <h2 class="section-title">Traveller reviews</h2>
                <div id="reviews-section">
                    <div class="review-card">
                        <div class="review-top">
                            <div class="avatar">LW</div>
                            <div>
                                <div class="review-name">Liam Walsh</div>
                                <div class="review-meta">
                                    <span class="review-stars">★★★★★</span> · 3 weeks ago
                                </div>
                            </div>
                        </div>
                        <div class="review-text">The Table Mountain experience was unforgettable. Everything from the hotel to the food felt premium. lorem ipsum dolor sit amet
                        </div>
                    </div>
                    <div class="review-card">
                        <div class="review-top">
                            <div class="avatar">LW</div>
                            <div>
                                <div class="review-name">Liam Walsh</div>
                                <div class="review-meta">
                                    <span class="review-stars">★★★★★</span> · 3 weeks ago
                                </div>
                            </div>
                        </div>
                        <div class="review-text">The Table Mountain experience was unforgettable. Everything from the hotel to the food felt premium.
                        </div>
                    </div>
                    <div class="review-card">
                        <div class="review-top">
                            <div class="avatar">LW</div>
                            <div>
                                <div class="review-name">Liam Walsh</div>
                                <div class="review-meta">
                                    <span class="review-stars">★★★★★</span> · 3 weeks ago
                                </div>
                            </div>
                        </div>
                        <div class="review-text">The Table Mountain experience was unforgettable. Everything from the hotel to the food felt premium.
                        </div>
                    </div>
                    <div class="review-card">
                        <div class="review-top">
                            <div class="avatar">LW</div>
                            <div>
                                <div class="review-name">Liam Walsh</div>
                                <div class="review-meta">
                                    <span class="review-stars">★★★★★</span> · 3 weeks ago
                                </div>
                            </div>
                        </div>
                        <div class="review-text">The Table Mountain experience was unforgettable. Everything from the hotel to the food felt premium.
                        </div>
                    </div>

                </div>
            </div>
            <div class="sidebar">
                <div class="sidebar-price">R4,999 <span>/ person</span></div>
                <button class="book-btn">Book trip</button>
                <button class="fav-btn">Add to favourites</button>
            </div>
        </div>




    </div>
</body>
<script src="../scripts/view.js"></script>

</html>