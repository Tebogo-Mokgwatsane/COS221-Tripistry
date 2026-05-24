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
            case "Accommodations":
                $this->getAccommodations($input);
                break;
            default:
                $this->jsonResponse("error", "Unknown request type");
                break;
        }
    }

    private function success($data){
        $this->jsonResponse("success", "Request successful", $data);
    } 

    private function error($data, $code = 400){
        $this->jsonResponse("error", "Request failed", $data, $code);
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
            $this->jsonResponse("error", "All fields are required", [], 400);
        }

        if (empty($data['username'])) {
            $this->jsonResponse("error", "Username is required", [], 400);
        }

        if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $this->jsonResponse("error", "Invalid email address", [], 400);
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
                $this->jsonResponse("error", "Registration number is required for agencies", [], 400);
            }

            // Check if registration number is valid in reg_numbers table
            $stmt = $this->mysqli->prepare("SELECT reg_id FROM businessregistration WHERE reg_number = ? AND status = 'valid'");
            $stmt->bind_param("s", $data['registration_num']);
            $stmt->execute();
            $stmt->store_result();

            if ($stmt->num_rows === 0) {
                $stmt->close();
                $this->jsonResponse("error", "Invalid or unlicensed registration number", [], 400);
            }
            else //If valid, check if not taken
            {
                $stmt->close();
                $stmt = $this->mysqli->prepare("SELECT reg_id FROM businessregistration WHERE (used_by IS NOT NULL AND reg_number = ?) OR (reg_number = ? AND status = 'taken')");
                $stmt->bind_param("ss", $data['registration_num'], $data['registration_num']);
                $stmt->execute();
                $stmt->store_result();
                if ($stmt->num_rows > 0) {
                    $stmt->close();
                    $this->jsonResponse("error", "Registration number already in use by another account", [], 409);
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
            $this->jsonResponse("error", "Email already registered", [], 409);
        }
        $stmt->close();
        
        /*// Check if username already exists (db has a constraint that doesnt allow dublicate usernames so for now This stops the error from the db being thrown)
        $stmt = $this->mysqli->prepare("SELECT user_id FROM user WHERE username = ?");
        $stmt->bind_param("s", $data['username']);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows > 0) {
            $stmt->close();
            $this->jsonResponse("error", "Username \"" . $data['username'] . "\" is already taken", [], 409);
        }
        $stmt->close();*/

        // Hash password
        $hashed = password_hash($data['password'], PASSWORD_DEFAULT);

        // Generate API key
        $apiKey = bin2hex(random_bytes(16));

        $reg_num = isset($data['registration_num']) ? trim($data['registration_num']) : null;
        // Insert user
        $stmt = $this->mysqli->prepare("INSERT INTO user (username, email, password_hash, user_type, api_key)
                                     VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssss", $username, $data['email'], $hashed, $userType, $apiKey);
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
            $stmt = $this->mysqli->prepare("INSERT INTO travelagent (agent_id, agency_name, registration_number) 
                                            VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $userId, $agencyName, $reg_num);
            $stmt->execute();

            $stmt = $this->mysqli->prepare("UPDATE businessregistration SET status = 'taken' WHERE reg_number = ?");
            $stmt->bind_param("s", $reg_num);
            $success2 = $stmt->execute();
            $stmt->close();
        }

        if ($success || $success2) {
            $this->jsonResponse("success", "Registration Successful!", [
                "apikey" => $apiKey,
                "username" => $username,
                "user_type" => $userType
            ], 201);
        } else {
            $this->jsonResponse("error", "Failed to register user", [], 500);
        }
    }

    // Logging in user ====================
    private function loginUser($data) {
        if (empty($data['email']) || empty($data['password'])) {
            $this->jsonResponse("error", "Email and password required", [], 400);
        }

        $stmt = $this->mysqli->prepare("SELECT user_id, username, email, password_hash, user_type, api_key FROM user WHERE email = ?");
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
        ], 200);
    }

    // Searching for packages ====================
    private function searchPackages($data) {
        if (empty($data['query'])) {
            $this->jsonResponse("error", "Search query is required", [], 400);//Debugg
        }

        $query = "%" . $data['query'] . "%";

        $stmt = $this->mysqli->prepare("
        SELECT 
            p.package_id as id,
            p.title,
            p.description,
            p.price,
            p.quantity,
            'https://via.placeholder.com/300x200' as image_url,
            (p.quantity > 0) as in_stock,
            4.8 as rating,
            ta.agency_name as agency,
            CONCAT(d.city, ', ', d.country) as location,
            'Group' as package_type,
            '5 nights' as nights
        FROM package p
        LEFT JOIN destination d ON p.dest_id = d.dest_id
        LEFT JOIN travelagent ta ON p.agent_id = ta.agent_id
        WHERE p.title LIKE ? 
           OR p.description LIKE ? 
           OR d.city LIKE ? 
           OR d.country LIKE ?
           OR ta.agency_name LIKE ?
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
            "packages" => $packages
        ]);
    }

    // Get Accommodations ====================
    public function getAccommodations() {
        $result = $this->mysqli->query("
            SELECT 
                a.acc_id,
                a.acc_name,
                a.acc_type,
                a.rating,
                a.price_per_night,
                a.description,
                a.img_url,
                aa.city,
                aa.country
            FROM accommodation a
            LEFT JOIN accommodationaddress aa ON a.acc_id = aa.acc_id
            ORDER BY a.price_per_night ASC
        ");

        $accommodations = [];
        while ($row = $result->fetch_assoc()) {
            $accommodations[] = $row;
        }
        $this->jsonResponse("success", "Accommodations retrieved", $accommodations);
    }
}
 
// Run API
$api = new API();
$api->handleRequest();
?> 