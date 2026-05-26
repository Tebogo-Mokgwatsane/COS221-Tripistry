<?php

    
header("Content-Type: application/json");
//define('USE_LOCAL_CONFIG', true);
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
            case "GetBookings":
                $this->getBookings($input);
                break;
            case "AddReview":
                $this->addReview($input);
                break;
            case "GetReviews":
                $this->getReviews($input);
                break;
            case "AddFavourite":
                $this->addFavourite($input);
                break;
            case "RemoveFavourite":
                $this->removeFavourite($input);
                break;
            case "GetFavourites":
                $this->getFavourites($input);
                break;
            default:
                $this->jsonResponse("error", "Unknown request type");
                break;
        }
    }

    private function jsonResponse($status, $message, $data = []) {
        echo json_encode([  
            "status" => $status,
            "message" => $message,
            "data" => $data
        ]);
        exit;
    }

    private function authenticate($apiKey) {
        if (empty($apiKey)) {
            $this->jsonResponse("error", "Missing API key. Please log in.");
        }
        $stmt = $this->mysqli->prepare(
            "SELECT user_id, user_type FROM user WHERE api_key = ?"
        );
        $stmt->bind_param("s", $apiKey);
        $stmt->execute();
        $result = $stmt->get_result();
        $user   = $result->fetch_assoc();
        $stmt->close();
 
        if (!$user) {
            $this->jsonResponse("error", "Invalid or expired session. Please log in again.");
        }
        return $user;
    }

    private function getTravellerId($userId){
        $stmt = $this->mysqli->prepare(
            "SELECT traveller_id FROM traveller WHERE traveller_id = ?"
        );
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();
        return $row ? $row['traveller_id'] :null;
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

        if ($data['user_type'] === 'agency') {
            if (empty($data['registration_num'])) {
                $this->jsonResponse("error", "Business registration number is required for agencies");
            }
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
        
        // Check if username already exists
        $stmt = $this->mysqli->prepare("SELECT user_id FROM user WHERE username = ?");
        $stmt->bind_param("s", $data['username']);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows > 0) {
            $stmt->close();
            $this->jsonResponse("error", "Username already taken");
        }
        $stmt->close();

        // Hash password
        //changed to SHA2 hashing for better security. 
        $hashed = hash('sha256', $data['password']);

        // Generate API key
        $apiKey = bin2hex(random_bytes(16));

        // Insert user
        $stmt = $this->mysqli->prepare("INSERT INTO user (username, email, password_hash, user_type, api_key)
                                     VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssss", $data['username'], $data['email'], $hashed, $data['user_type'], $apiKey);
        $success = $stmt->execute();
        $stmt->close();

        if ($success) {
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
        //changed to match database
        $stmt = $this->mysqli->prepare(
    "SELECT user_id, username, email, password_hash, api_key, user_type FROM user WHERE email = ?"
);
        $stmt->bind_param("s", $data['email']);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        $stmt->close();

        //Kat used SHA2 hashing in registration, so we need to hash the input password the same way for comparison.
        $sha2hash = hash('sha256', $data['password']);
        if (!$user || $sha2hash !== $user['password_hash']) {
            $this->jsonResponse("error", "Invalid Credentials");
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

    private function getBookings($data){
        $apiKey = $data['api_key'] ?? '';
        $user = $this->authenticate($apiKey);

        if($user['user_type'] !== 'traveller'){
            $this->jsonResponse("error", "Only travellers can view bookings");
        }

        $travellerId = $this->getTravellerId($user['user_id']);
        if(!$travellerId){
            $this->jsonResponse("error", "Traveller profile not found");
             
        }

        $stmt = $this->mysqli->prepare("
            SELECT
                b.booking_id,
                b.package_id,
                p.title            AS package_title,
                d.city             AS destination_city,
                d.country          AS destination_country,
                ta.agency_name,
                ta.agent_id,
                b.num_travellers,
                b.total_price,
                b.booking_status,
                b.booking_date,
                p.price            AS package_price,
                p.expiry_date,
                -- Check if traveller already reviewed this package
                EXISTS (
                    SELECT 1 FROM review r
                    WHERE r.traveller_id = ? AND r.package_id = b.package_id
                ) AS already_reviewed
            FROM booking b
            JOIN package     p  ON b.package_id = p.package_id
            JOIN destination d  ON p.dest_id    = d.dest_id
            JOIN travelagent ta ON p.agent_id   = ta.agent_id
            WHERE b.traveller_id = ?
            ORDER BY b.booking_date DESC
        ");

        $stmt->bind_param("ii", $travellerId, $travellerId);
        $stmt->execute();
        $result = $stmt->get_result();
        $booking =[];
        while($row = $result->fetch_assoc()){
            $row['already_reviewed'] = (bool)$row['already_reviewed'];
            $booking[]= $row;
        }

        $stmt->close();
        $this->jsonResponse("success", "Bookings retrieved", $booking);
    }

    private function addReview($data) {
        $apiKey = $data['api_key'] ?? '';
        $user   = $this->authenticate($apiKey);
 
        if ($user['user_type'] !== 'traveller') {
            $this->jsonResponse("error", "Only travellers can leave reviews");
        }
 
        $travellerId = $this->getTravellerId($user['user_id']);
        if (!$travellerId) {
            $this->jsonResponse("error", "Traveller profile not found");
        }
 
        $packageId = intval($data['package_id'] ?? 0);
        $rating    = intval($data['rating']     ?? 0);
        $comment   = trim($data['comment']      ?? '');
 
        if (!$packageId) {
            $this->jsonResponse("error", "Package ID is required");
        }
        if ($rating < 1 || $rating > 5) {
            $this->jsonResponse("error", "Rating must be between 1 and 5");
        }
 
        // Check traveller actually booked this package
        $stmt = $this->mysqli->prepare("
            SELECT booking_id FROM booking
            WHERE traveller_id = ? AND package_id = ?
            LIMIT 1
        ");
        $stmt->bind_param("ii", $travellerId, $packageId);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows === 0) {
            $stmt->close();
            $this->jsonResponse("error", "You can only review packages you have booked");
        }
        $stmt->close();
 
        // Check not already reviewed
        $stmt = $this->mysqli->prepare("
            SELECT review_id FROM review
            WHERE traveller_id = ? AND package_id = ?
            LIMIT 1
        ");
        $stmt->bind_param("ii", $travellerId, $packageId);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows > 0) {
            $stmt->close();
            $this->jsonResponse("error", "You have already reviewed this package");
        }
        $stmt->close();
 
        // Get the agent_id from the package
        $stmt = $this->mysqli->prepare("SELECT agent_id FROM package WHERE package_id = ?");
        $stmt->bind_param("i", $packageId);
        $stmt->execute();
        $result  = $stmt->get_result();
        $package = $result->fetch_assoc();
        $stmt->close();
 
        if (!$package) {
            $this->jsonResponse("error", "Package not found");
        }
 
        $agentId = $package['agent_id'];
 
        // Insert review
        $stmt = $this->mysqli->prepare("
            INSERT INTO review (traveller_id, agent_id, package_id, rating, comment)
            VALUES (?, ?, ?, ?, ?)
        ");
        $stmt->bind_param("iiiis", $travellerId, $agentId, $packageId, $rating, $comment);
        $success = $stmt->execute();
        $stmt->close();
 
        if ($success) {
            $this->jsonResponse("success", "Review submitted successfully!");
        } else {
            $this->jsonResponse("error", "Failed to submit review");
        }
    }

    private function getReviews($data) {
        $packageId = intval($data['package_id'] ?? 0);
 
        if (!$packageId) {
            $this->jsonResponse("error", "Package ID is required");
        }
 
        $stmt = $this->mysqli->prepare("
            SELECT
                r.review_id,
                r.rating,
                r.comment,
                r.review_date,
                CONCAT(t.first_name, ' ', t.last_name) AS reviewer_name
            FROM review r
            JOIN traveller t ON r.traveller_id = t.traveller_id
            WHERE r.package_id = ?
            ORDER BY r.review_date DESC
        ");
        $stmt->bind_param("i", $packageId);
        $stmt->execute();
        $result  = $stmt->get_result();
        $reviews = [];
        while ($row = $result->fetch_assoc()) {
            $reviews[] = $row;
        }
        $stmt->close();
 
        $this->jsonResponse("success", "Reviews retrieved", $reviews);
    }

    private function addFavourite($data) {
        $apiKey = $data['api_key'] ?? '';
        $user   = $this->authenticate($apiKey);
 
        if ($user['user_type'] !== 'traveller') {
            $this->jsonResponse("error", "Only travellers can save favourites");
        }
 
        $travellerId = $this->getTravellerId($user['user_id']);
        $packageId   = intval($data['package_id'] ?? 0);
 
        if (!$packageId) {
            $this->jsonResponse("error", "Package ID is required");
        }
 
        // Check not already favourited (INSERT IGNORE handles duplicates gracefully)
        $stmt = $this->mysqli->prepare(
            "INSERT IGNORE INTO favourite (traveller_id, package_id) VALUES (?, ?)"
        );
        $stmt->bind_param("ii", $travellerId, $packageId);
        $success = $stmt->execute();
        $stmt->close();
 
        if ($success) {
            $this->jsonResponse("success", "Package added to favourites");
        } else {
            $this->jsonResponse("error", "Failed to add to favourites");
        }
    }

    private function removeFavourite($data) {
        $apiKey = $data['api_key'] ?? '';
        $user   = $this->authenticate($apiKey);
 
        $travellerId = $this->getTravellerId($user['user_id']);
        $packageId   = intval($data['package_id'] ?? 0);
 
        if (!$packageId) {
            $this->jsonResponse("error", "Package ID is required");
        }
 
        $stmt = $this->mysqli->prepare(
            "DELETE FROM favourite WHERE traveller_id = ? AND package_id = ?"
        );
        $stmt->bind_param("ii", $travellerId, $packageId);
        $stmt->execute();
        $stmt->close();
 
        $this->jsonResponse("success", "Package removed from favourites");
    }

    private function getFavourites($data) {
        $apiKey = $data['api_key'] ?? '';
        $user   = $this->authenticate($apiKey);
 
        if ($user['user_type'] !== 'traveller') {
            $this->jsonResponse("error", "Only travellers can view favourites");
        }
 
        $travellerId = $this->getTravellerId($user['user_id']);
        if (!$travellerId) {
            $this->jsonResponse("error", "Traveller profile not found");
        }
 
        $stmt = $this->mysqli->prepare("
            SELECT
                p.package_id,
                p.title,
                p.description,
                p.price,
                p.expiry_date,
                p.status,
                d.city             AS destination_city,
                d.country          AS destination_country,
                ta.agency_name,
                f.added_at,
                COALESCE(ROUND(AVG(r.rating), 1), 0) AS avg_rating,
                COUNT(r.review_id)                    AS review_count
            FROM favourite f
            JOIN package     p  ON f.package_id = p.package_id
            JOIN destination d  ON p.dest_id    = d.dest_id
            JOIN travelagent ta ON p.agent_id   = ta.agent_id
            LEFT JOIN review r  ON p.package_id = r.package_id
            WHERE f.traveller_id = ?
            GROUP BY p.package_id, p.title, p.description, p.price,
                     p.expiry_date, p.status, d.city, d.country,
                     ta.agency_name, f.added_at
            ORDER BY f.added_at DESC
        ");
        $stmt->bind_param("i", $travellerId);
        $stmt->execute();
        $result     = $stmt->get_result();
        $favourites = [];
        while ($row = $result->fetch_assoc()) {
            $favourites[] = $row;
        }
        $stmt->close();
 
        $this->jsonResponse("success", "Favourites retrieved", $favourites);
    }
    
    // Additional methods for fetching data for browse
    public function getflights(){
        $stmt = $this->mysqli->query("SELECT flight_id, airline_name, Price, departure_airport, arrival_airport,
            DATE_FORMAT(dept_date,'%d %b %Y') as dept_date,
            DATE_FORMAT(dept_date,'%H %i') as dept_time,
            DATE_FORMAT(arrival_datetime,'%d %b %Y') as arrival_date,
            DATE_FORMAT(arrival_datetime,'%H %i') as arrival_time,
            classes,img_url FROM flight");
        $flights = [];
        while ($row = $stmt->fetch_assoc()) {
            $flights[] = $row;
        }
        return $flights;
    }

    public function getDestinations(){
        $stmt = $this->mysqli->query("SELECT dest_id, city, country, description, img_url FROM destination");
        $destinations = [];
        while ($row = $stmt->fetch_assoc()) {
            $destinations[] = $row;
        }
        return $destinations;
    }

    public function getAccommodations() {
        $result = $this->mysqli->query("SELECT a.*, aa.city, aa.country FROM accommodation a LEFT JOIN accommodationaddress aa ON a.acc_id = aa.acc_id ORDER BY a.price_per_night ASC");
        $accommodations = [];
        while ($row = $result->fetch_assoc()) {
            $accommodations[] = $row;
        }
        return $accommodations;
    }

    public function getAttractions() {
        $result = $this->mysqli->query("SELECT a.*, aa.city, aa.country FROM attraction a LEFT JOIN attractionaddress aa ON a.att_id = aa.att_id ORDER BY a.fee ASC");
        $attractions = [];
        while ($row = $result->fetch_assoc()) {
            $attractions[] = $row;
        }
        return $attractions;
    }

    public function getRestaurants() {
        $result = $this->mysqli->query("SELECT r.*, ra.city, ra.country FROM restaurant r LEFT JOIN restaurantaddress ra ON r.res_id = ra.res_id ORDER BY r.fee ASC");
        $restaurants = [];
        while ($row = $result->fetch_assoc()) {
            $restaurants[] = $row;
        }
        return $restaurants;
    }



     




}
// Run API
if (basename(__FILE__) === basename($_SERVER['SCRIPT_FILENAME'])) {
    $api = new API();
    $api->handleRequest();
}
?> 