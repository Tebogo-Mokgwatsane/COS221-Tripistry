<?php 
 include ("../../api.php");

 $api = new API();
 $data = $api->getDestinations();

 header('Content-Type: application/json');
 echo json_encode(['status' => 'success',
  'message' => 'Destinations retrieved successfully',
  'data' => $data
]);

?>