<?php 
 include ("../../../api.php");

 $api = new API();
 $flights = $api->getflights();

 header('Content-Type: application/json');
 echo json_encode($flights);


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flights</title>
    <link rel="stylesheet" href="flights.css">
    <link rel="stylesheet" href="../../css/navbar.css">

</head>
<body>
    <?php include ("../../../navbar.php"); ?>
    <div class="flight-grid" id="flights">
    </div>

</body>
<script src="flights.js"></script>
</html>



