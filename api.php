<?php

header("Content-Type: application/json");
define('USE_LOCAL_CONFIG', true);
require_once 'Tripistry/config.php';

class API {
    private $mysqli; // mysqli connection

    public function __construct() {
        global $mysqli;
        $this->mysqli = $mysqli;
    }

    public function handleRequest() {
        $input = [];

        if (strpos($_SERVER['CONTENT_TYPE'] ?? '', 'application/json') !== false) {
            $input = json_decode(file_get_contents("php://input"), true) ?? [];
        } else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $input = $_POST;
        }

        if (!isset($input['type']) || empty($input['type'])) {
            $this->jsonResponse("error", "Missing 'type' parameter");
        }

        $type = $input['type'];

        switch ($type) {
            case "Register":
                $this->registerUser($input);
                break;
            case "Login":
                $this->loginUser($input);
                break;
            default:
                $this->jsonResponse("error", "Unknown request type");
                break;
        }
    }

    // Registering user ====================
    private function registerUser($data) {

    }

    // Logging in user ====================
    private function loginUser($data) {

    }
}

// Run API
$api = new API();
$api->handleRequest();
?>  