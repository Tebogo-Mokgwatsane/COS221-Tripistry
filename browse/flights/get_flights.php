<?php 
 include ("../../api.php");

 $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
 $itemsPerPage = 20; // flights per page
 $offset = ($page - 1) * $itemsPerPage;

 $api = new API();
 $data = $api->getflights();

 $total = count($data);
 $totalPages = ceil($total / $itemsPerPage);
 $paginatedData = array_slice($data, $offset, $itemsPerPage);

 header('Content-Type: application/json');
 echo json_encode(['status' => 'success',
    'message' => 'Flights retrieved successfully',
    'data' => $paginatedData, 
    'currentPage' => $page,
   'totalPages' => $totalPages 
 ]);

?>