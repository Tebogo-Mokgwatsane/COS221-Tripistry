<?php

$host = "sql103.infinityfree.com";
$dbname = "if0_41937671_XXX";//Since were hosting and testing on infinityfree.com
$user = "if0_41937671";

if (defined('USE_LOCAL_CONFIG') && USE_LOCAL_CONFIG) {
    // Path if api.php is running
    $pass = trim(file_get_contents("DatabasePassword"));
} else {
    // Default path for other files - adjustable directory
    $pass = trim(file_get_contents("../DatabasePassword"));
}

if (empty($pass)) {
    die("Error: Could not read database password file.");
}

$mysqli = new mysqli($host, $user, $pass, $dbname);

if ($mysqli->connect_error) {
    die("Database connection failed: " . $mysqli->connect_error);
}

$mysqli->set_charset("utf8mb4");
?>
