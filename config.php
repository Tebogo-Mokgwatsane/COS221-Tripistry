<?php

$envFile = __DIR__ . '/.env';

if (!file_exists($envFile)) {
    die("Error: .env file not found in " . __DIR__);
}

$lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
foreach ($lines as $line) {
    if (strpos($line, '=') !== false && strpos($line, '#') !== 0) {
        [$key, $value] = explode('=', $line, 2);
        $_ENV[trim($key)] = trim($value);
    }
}

$host = $_ENV['DB_HOST'] ?? '';
$dbname = $_ENV['DB_NAME'] ?? '';
$user = $_ENV['DB_USER'] ?? '';
$pass = $_ENV['DB_PASS'] ?? '';
$port = $_ENV['DB_PORT'] ?? '';

//$mysqli = new mysqli($host, $user, $pass, $dbname);
$mysqli = new mysqli($host, $user, $pass, $dbname, $port);

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error . " (Port: $port)");
}

$mysqli->set_charset("utf8mb4");
?>