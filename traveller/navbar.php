<nav>
        <div class="navbar">
            <div class="logo">
                <a href="/traveller/">
                    <div class="img-container">
                        <img src="../img/icons/compass.svg" alt="Compass Logo">
                    </div>
                </a>
                <p>Tripistry</p>
            </div>
            <div class="middle-section">
                <ul>
                    <li>
                        <a href="">Packages</a>
                    </li>
                    <li>
                        <a href="">Bookings</a>
                    </li>
                    <li>
                        <a href="">Favourites</a>
                    </li>
                    <li>
                        <a href="">Reviews</a>
                    </li>
                    <li class="explore-btn">
                        <button id="explore-btn">
                            Explore
                            <img src="../img/icons/chevron-down.svg" alt="Chevron Down">
                        </button>
                        <div id="dropdown">
                            <ul class="explore-dropdown">
                                <li>
                                    <a href="../browse/destinations/destinations.php">
                                        <img src="../img/icons/map-pin.svg" alt="Map Pin">
                                        Destinations
                                    </a>
                                </li>
                                <li>
                                    <a href="../browse/flights/flights.php">
                                        <img src="../img/icons/plane-black.svg" alt="Plane">
                                        Flights
                                    </a>
                                </li>
                                <li>
                                    <a href="../browse/accommodations/accommodations.php">
                                        <img src="../img/icons/bed.svg" alt="Bed icon">
                                        Accommodations
                                    </a>
                                </li>
                                <li>
                                    <a href="../browse/attractions/attractions.php">
                                        <img src="../img/icons/camera.svg" alt="Camera icon">
                                        Attractions
                                    </a>
                                </li>
                                <li>
                                    <a href="../browse/restaurants/restaurants.php">
                                        <img src="../img/icons/utensils-crossed.svg" alt="Utinsils icons">
                                        Restaurants
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="login-section" id="login-section">
                <div id="username-container">
                    <img src="../img/icons/user.svg" alt="User Icon">
                    <p class="sign-in-txt" id="username"></p>
                </div>
                <button href="signup.html" class="logout-btn" >
                    <img src="../img/icons/log-out.svg" alt="Logout icon" id="logout-img-default">
                    <img src="../img/icons/log-out-white.svg" alt="Logout icon" id="logout-img-hover">
                    <span>Logout</span>
                </button>
            </div>
        </div>
    </nav>

<script src="../scripts/navbar.js"></script>
<script src="../scripts/traveller.js"></script>