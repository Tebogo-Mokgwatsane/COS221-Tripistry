<?php 
 include ("../../api.php");

 $api = new API();
 $data = $api->getflights();

 header('Content-Type: application/json');
 echo json_encode(['status' => 'success',
    'message' => 'Flights retrieved successfully',
    'data' => $data 
 ]);

?>