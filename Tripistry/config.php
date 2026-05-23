<?php
$mysqli = new mysqli('127.0.0.1', 'root', '', 'tripistry', 3306);
$mysqli->set_charset("utf8mb4");

if ($mysqli->connect_error) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database connection failed: " . $mysqli->connect_error
    ]);
    exit;
}