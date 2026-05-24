<?php 
 include ("../../api.php");

 $api = new API();
 $flights = $api->getflights();

 header('Content-Type: application/json');
 echo json_encode($flights);

?>



