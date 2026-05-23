<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Traveller Dashboard</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <?php include("navbar.php"); ?>
    <div class="container" style="margin-top: 100px; padding: 20px;">
        <h1>Welcome back, Traveller! 👋</h1>
        <search>
            <input type="text" id="search-input" placeholder="Search destinations or packages...">
            <button onclick="handleSearch()">Search</button>
        </search>
        <p>Start exploring amazing trips from trusted agencies.</p>

        <div style="margin: 40px 0;">
            <h2>Browse Trips</h2>
            <p>Coming soon - Search and compare travel packages...</p>
        </div>

        <div style="margin: 40px 0;">
            <h2>My Bookings</h2>
            <p>You have no upcoming trips yet.</p>
        </div>
    </div>
</body>
</html>