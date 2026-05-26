<?php 
$host = 'localhost';
$dbname = 'tripinstry';
$user = 'root';
$pass = 'LemoZine@251203';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $stmt = $pdo->query("SELECT flight_id, airline_name, Price, departure_airport, arrival_airport,dept_date,arrival_datetime,classes,image_url FROM flight");
    $flights = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "Database error: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flights</title>
    <link rel="stylesheet" href="css/flightbrowsing.css">
    <link rel="stylesheet" href="css/navbar.css">
</head>
<body>
    <?php include("navbar.php"); ?>
    <div class="flight-grid">
        <?php foreach ($flights as $flight): ?>
            <div class="flight-item" style="background-image: url(<?php echo $flight['image_url']; ?>);">
        
                <h1><?php echo htmlspecialchars($flight['airline_name']); ?></h1>
                <p>Price: $<?php echo number_format($flight['Price'], 2); ?></p>
                <p>From: <?php echo htmlspecialchars($flight['departure_airport']); ?></p>
                <p>To: <?php echo htmlspecialchars($flight['arrival_airport']); ?></p>
                <p>Departure: <?php echo $flight['dept_date']; ?></p>
                <p>Arrival: <?php echo $flight['arrival_datetime']; ?></p>
                <p>Class: <?php echo htmlspecialchars($flight['classes']); ?></p>
            </div>
        <?php endforeach; ?>
    </div>
</body>
</html>

