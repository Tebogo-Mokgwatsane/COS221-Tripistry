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
        if (empty($data['name']) || empty($data['surname']) || empty($data['email']) || empty($data['password']) || empty($data['user_type'])) {
            $this->jsonResponse("error", "All fields are required");
        }

        if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $this->jsonResponse("error", "Invalid email address");
        }

        $passRegex = "/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/";
        if (!preg_match($passRegex, $data['password'])) {
            $this->jsonResponse("error", "Password must be 8+ chars with upper, lower, number and symbol");
        }

        // Check if email exists
        $stmt = $this->mysqli->prepare("SELECT user_id FROM user WHERE email = ? OR username = ?");
        $stmt->bind_param("ss", $data['email'], $data['username']);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows > 0) {
            $stmt->close();
            $stmt->bind_param("s", $data['email']);
            $stmt->execute();
            $stmt->store_result();
            if ($stmt->num_rows > 0) {
                $stmt->close();
                $this->jsonResponse("error", "Email already registered");
            }
            else {
                $stmt->close();
                $this->jsonResponse("error", "Username already taken");
            }
        }
        $stmt->close();

        // Hash password with salt
        $salt = bin2hex(random_bytes(16));
        $hashed = password_hash($data['password'] . $salt, PASSWORD_DEFAULT);//Hashed password with salt so id need to recover the specific salt back to verify password OR hash without salt

        // Generate API key
        $apiKey = bin2hex(random_bytes(16));

        // Insert user
        /*$stmt = $this->mysqli->prepare("INSERT INTO user (username, email, password_hash, salt, user_type, api_key) 
                                     VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssss", $data['username'], $data['email'], $hashed, $salt, $data['user_type'], $apiKey);*/ //Would like to modify user table to include salt and api_key columns
        $stmt = $this->mysqli->prepare("INSERT INTO user (username, email, password_hash, user_type) 
                                     VALUES (?, ?, ?, ?,)");
        $stmt->bind_param("sssss", $data['username'], $data['email'], $hashed, $data['user_type']);
        $success = $stmt->execute();
        $stmt->close();

        if ($success) {
            header("Content-Type: text/html; charset=utf-8");
            echo "<script>
                prompt('🧳Registration Successful!\\n);
                window.location.href = 'Tripistry/login.php';
            </script>";
            exit;
        } else {
            $this->jsonResponse("error", "Failed to register user");
        }
    }

    // Logging in user ====================
    private function loginUser($data) {
        if (empty($data['username']) || empty($data['password'])) {
            $this->jsonResponse("error", "Username and password required");
        }

        //$stmt = $this->mysqli->prepare("SELECT user_id, email, password_hash, salt, api_key FROM user WHERE username = ?"); //Would like to modify user table to include salt and api_key columns
        $stmt = $this->mysqli->prepare("SELECT user_id, email, password_hash FROM user WHERE username = ?");
        $stmt->bind_param("s", $data['username']);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        $stmt->close();

        if (!$user || !password_verify($data['password'] . $user['salt'], $user['password_hash'])) {//if salt is added OR we can hash the password without salt
            if (!$user){
                $this->jsonResponse("error", "Invalid username");
            }
            else {
                $this->jsonResponse("error", "Invalid password");
            }
        }

        session_start();
        $_SESSION['user_id'] = $user['user_id'];
        $_SESSION['username']   = $user['username'];

        //Return API key if added on user table in response
        $this->jsonResponse("success", "Login successful", [
            "apikey" => $user['api_key'],
            "username"   => $user['username']
        ]);
    }}
 
// Run API
$api = new API();
$api->handleRequest();
?>  