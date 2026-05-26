<nav>
    <div class="navbar">
        <div class="logo">
            <a href="/COS221-Tripistry/agency/">
                <div class="img-container">
                    <img src="../img/icons/compass.svg" alt="Compass Logo">
                </div>
            </a>
            <p>Tripistry</p>
        </div>
        <div class="middle-section">
            <ul>
                <li>
                    <a href="/COS221-Tripistry/agency/index.php" id="nav-dashboard">Dashboard</a>
                </li>
                <li>
                    <a href="/COS221-Tripistry/agency/agency_packages.php" id="nav-packages">Packages</a>
                </li>
                <li>
                    <a href="/COS221-Tripistry/agency/agency_bookings.php" id="nav-bookings">Bookings</a>
                </li>
                <li>
                    <a href="/COS221-Tripistry/agency/agency_reviews.php" id="nav-reviews">Reviews</a>
                </li>
            </ul>
        </div>
        <div class="login-section" id="login-section">
            <div id="username-container">
                <img src="../img/icons/user.svg" alt="User Icon">
                <p class="sign-in-txt" id="username"></p>
            </div>
            <button class="logout-btn" id="logout-btn">
                <img src="../img/icons/log-out.svg" alt="Logout icon" id="logout-img-default">
                <img src="../img/icons/log-out-white.svg" alt="Logout icon" id="logout-img-hover">
                <span>Logout</span>
            </button>
        </div>
    </div>
</nav>

<script>
(function() {
    // Set username from localStorage
    const user = JSON.parse(localStorage.getItem("user") || "{}");
    const usernameEl = document.getElementById("username");
    if (usernameEl && user.username) {
        usernameEl.textContent = user.username;
    }

    // Highlight active nav link
    const currentPath = window.location.pathname;
    document.querySelectorAll(".middle-section a").forEach(link => {
        if (link.href.includes(currentPath) && currentPath !== "/") {
            link.style.color = "rgb(0, 106, 255)";
            link.style.fontWeight = "700";
        }
    });

    // Logout
    const logoutBtn = document.getElementById("logout-btn");
    if (logoutBtn) {
        logoutBtn.addEventListener("click", () => {
            localStorage.removeItem("user");
            document.cookie = "apiKey=; path=/; max-age=0";
            window.location.href = "/COS221-Tripistry/login.html";
        });
    }
})();
</script>