<?php

    
header("Content-Type: application/json");

define('USE_LOCAL_CONFIG', true);
//require_once 'Tripistry/config.php';
require_once 'config.php';
    
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
            $this->jsonResponse("error", "Missing 'type' parameter", [], 400);
        }

        $type = $input['type'];

        switch ($type) {
            case "Register":
                $this->registerUser($input);
                break;
            case "Login":
                $this->loginUser($input);
                break;
            case "Search":
                $this->searchPackages($input);
                break;
            default:
                $this->jsonResponse("error", "Unknown request type");
                break;
        }
    }

    private function jsonResponse($status, $message, $data = [], $code = 200) {
        if ($code===200 || $status === "success") {
            $status = "success";
        } else {
            $status = "error";
            $code = 400; // Default
        }
        http_response_code($code);
        echo json_encode([
            "status" => $status,
            "timestamp" => time(),
            "message" => $message,
            "data" => $data
        ]);
        exit;
    }

    // Registering user ====================
    private function registerUser($data) {
        if (empty($data['email']) || empty($data['password']) || empty($data['user_type'])) {
            $this->jsonResponse("error", "All fields are required");
        }

        if (empty($data['username'])) {
            $this->jsonResponse("error", "Username is required");
        }

        if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $this->jsonResponse("error", "Invalid email address");
        }

        $passRegex = "/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/";
        if (!preg_match($passRegex, $data['password'])) {
            $this->jsonResponse("error", "Password must be 8+ chars with upper, lower, number and symbol");
        }

        $userType = $data['user_type'];
        $username = $data['username'] ?? '';

        // Agency specific validation
        if ($userType === "agency" || $userType === "travel_agent") {
            if (empty($data['registration_num'])) {
                $this->jsonResponse("error", "Registration number is required for agencies");
            }

            // Check if registration number is valid in reg_numbers table
            $stmt = $this->mysqli->prepare("SELECT id FROM reg_numbers WHERE registration_num = ? AND status = 'valid'");
            $stmt->bind_param("s", $data['registration_num']);
            $stmt->execute();
            $stmt->store_result();

            if ($stmt->num_rows === 0) {
                $stmt->close();
                $this->jsonResponse("error", "Invalid or unlicensed registration number");
            }
            else //If valid, check if not taken
            {
                $stmt->close();
                $stmt = $this->mysqli->prepare("SELECT user_id FROM user WHERE registration_num = ?");
                $stmt->bind_param("s", $data['registration_num']);
                $stmt->execute();
                $stmt->store_result();
                if ($stmt->num_rows > 0) {
                    $stmt->close();
                    $this->jsonResponse("error", "Registration number already in use by another account");
                }
            }
            $stmt->close();
        }

        // Check if email exists
        $stmt = $this->mysqli->prepare("SELECT user_id FROM user WHERE email = ?");
        $stmt->bind_param("s", $data['email']);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows > 0) {
            $stmt->close();
            $this->jsonResponse("error", "Email already registered");
        }
        $stmt->close();
        
        // Check if username already exists (db has a constraint that doesnt allow dublicate usernames so for now This stops the error from the db being thrown)
        $stmt = $this->mysqli->prepare("SELECT user_id FROM user WHERE username = ?");
        $stmt->bind_param("s", $data['username']);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows > 0) {
            $stmt->close();
            $this->jsonResponse("error", "Username \"" . $data['username'] . "\" is already taken");
        }
        $stmt->close();

        // Hash password
        $hashed = password_hash($data['password'], PASSWORD_DEFAULT);

        // Generate API key
        $apiKey = bin2hex(random_bytes(16));

        $reg_num = isset($data['registration_num']) ? trim($data['registration_num']) : null;
        // Insert user
        $stmt = $this->mysqli->prepare("INSERT INTO user (username, email, password_hash, user_type, api_key, registration_num)
                                     VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssss", $username, $data['email'], $hashed, $userType, $apiKey, $reg_num);
        $success = $stmt->execute();
        $userId = $this->mysqli->insert_id;
        $stmt->close();

        // Insert into specific table
        if ($userType === "traveller") {
            $fname = $data['fname'] ?? '';
            $lname = $data['lname'] ?? '';
            $stmt = $this->mysqli->prepare("INSERT INTO traveller (traveller_id, first_name, last_name, type) 
                                            VALUES (?, ?, ?, 'Solo')");
            $stmt->bind_param("iss", $userId, $fname, $lname);
            $stmt->execute();
        } 
        else // Agency
        { 
            $agencyName = $data['agency_name'] ?? $username;
            $stmt = $this->mysqli->prepare("INSERT INTO travelagent (agent_id, agency_name) 
                                            VALUES (?, ?)");
            $stmt->bind_param("is", $userId, $agencyName);
            $stmt->execute();

            $stmt = $this->mysqli->prepare("UPDATE reg_numbers SET status = 'invalid' WHERE registration_num = ?");
            $stmt->bind_param("s", $reg_num);
            $success2 = $stmt->execute();
            $stmt->close();
        }

        if ($success || $success2) {
            $this->jsonResponse("success", "Registration Successful!");
        } else {
            $this->jsonResponse("error", "Failed to register user");
        }
    }

    // Logging in user ====================
    private function loginUser($data) {
        if (empty($data['email']) || empty($data['password'])) {
            $this->jsonResponse("error", "Email and password required");
        }

        $stmt = $this->mysqli->prepare("SELECT user_id, username, email, password_hash, user_type, registration_num, api_key FROM user WHERE email = ?");
        $stmt->bind_param("s", $data['email']);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        $stmt->close();

        if (!$user || !password_verify($data['password'], $user['password_hash'])) {
            $this->jsonResponse("error", "Invalid Credentials", [], 401);
        }

        session_start();
        $_SESSION['user_id'] = $user['user_id'];
        $_SESSION['username']   = $user['username'];

        //Return API key in response
        $this->jsonResponse("success", "Login successful", [
            "apikey" => $user['api_key'],
            "username"   => $user['username'],
            "user_type"   => $user['user_type']
        ]);
    }

    // Searching for packages ====================
    private function searchPackages($data) {
        if (empty($data['query'])) {
            $this->jsonResponse("error", "Search query is required", [], 400);//Debugg
        }

        $query = "%" . $data['query'] . "%";

        $stmt = $this->mysqli->prepare("
            SELECT DISTINCT p.title, p.package_id, p.description as package_description, p.price, p.quantity, 
                   d.description as destination_description, d.city, d.country,
                   a.name as attraction_name, a.description as attraction_description
            FROM package p
            LEFT JOIN destination d ON p.dest_id = d.dest_id
            LEFT JOIN attraction a ON p.dest_id = a.dest_id
            WHERE p.title LIKE ? 
                OR p.description LIKE ? 
                OR d.description LIKE ? 
                OR d.city LIKE ? 
                OR d.country LIKE ?
            ORDER BY p.price ASC
            LIMIT 20
        ");

        $stmt->bind_param("sssss", $query, $query, $query, $query, $query);
        $stmt->execute();
        $result = $stmt->get_result();
    
        $packages = [];
        while ($row = $result->fetch_assoc()) {
            $packages[] = $row;
        }
        $stmt->close();

        $this->jsonResponse("success", "Search completed", [
            "packages" => $packages,
            "count" => count($packages)
        ]);
    }
}
 
// Run API
$api = new API();
$api->handleRequest();
?> 