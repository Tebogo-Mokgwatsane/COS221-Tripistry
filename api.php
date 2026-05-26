<?php

header("Content-Type: application/json");
//define('USE_LOCAL_CONFIG', true);
require_once 'Tripistry/config.php';

class API {
    private $mysqli; // mysqli connection
    private $columnCache = [];

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

            // Public package list, used by agency pages to populate destination dropdowns
            case "GetPackages":
                $this->getPackages($input);
                break;

            // Agency bookings
            case "GetAgencyBookings":
                $this->getAgencyBookings($input);
                break;

            // Agency reviews
            case "GetAgencyReviews":
                $this->getAgencyReviews($input);
                break;

            // Agency package management
            case "GetAgencyPackages":
                $this->getAgencyPackages($input);
                break;
            case "CreatePackage":
            case "createPackage":
                $this->createPackage($input);
                break;
            case "UpdatePackage":
            case "Update":
            case "updatePackage":
            case "Updatepackage":
                $this->updatePackage($input);
                break;
            case "DeletePackage":
            case "Delete":
            case "delete":
            case "deletePackage":
            case "deletepackage":
                $this->deletePackage($input);
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

        // Username is allowed to repeat. Only email and api_key must be unique.

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

    // ============================================================
    // Public package list
    // ============================================================
    private function getPackages($data) {
        $imgSelect = $this->columnExists('package', 'img_url') ? "p.img_url" : "NULL AS img_url";
        $groupSelect = $this->getGroupPackageSelect();

        $sql = "
            SELECT
                p.package_id,
                p.agent_id,
                p.dest_id,
                p.title,
                p.description,
                p.price,
                p.expiry_date,
                p.quantity,
                p.status,
                p.created_at,
                $imgSelect,
                $groupSelect,
                d.city    AS destination_city,
                d.country AS destination_country,
                ta.agency_name,
                COALESCE(rv.avg_rating, 0)   AS avg_rating,
                COALESCE(rv.review_count, 0) AS review_count,
                COALESCE(bk.booking_count, 0) AS booking_count
            FROM `package` p
            JOIN destination d
                ON p.dest_id = d.dest_id
            JOIN travelagent ta
                ON p.agent_id = ta.agent_id
            LEFT JOIN (
                SELECT package_id, ROUND(AVG(rating), 1) AS avg_rating, COUNT(*) AS review_count
                FROM review
                GROUP BY package_id
            ) rv ON rv.package_id = p.package_id
            LEFT JOIN (
                SELECT package_id, COUNT(*) AS booking_count
                FROM booking
                GROUP BY package_id
            ) bk ON bk.package_id = p.package_id
            ORDER BY p.created_at DESC
        ";

        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare package list query: " . $this->mysqli->error);
        }

        $stmt->execute();
        $result = $stmt->get_result();
        $packages = [];
        while ($row = $result->fetch_assoc()) {
            $packages[] = $this->normalisePackageRow($row);
        }
        $stmt->close();

        $this->jsonResponse("success", "Packages retrieved", $packages);
    }

    // ============================================================
    // Agency helpers
    // ============================================================
    private function requireAgency($data) {
        $apiKey = $data['api_key'] ?? '';
        $user = $this->authenticate($apiKey);

        if ($user['user_type'] !== 'travel_agent') {
            $this->jsonResponse("error", "Only travel agents can access this function");
        }

        $stmt = $this->mysqli->prepare("
            SELECT agent_id
            FROM travelagent
            WHERE agent_id = ?
            LIMIT 1
        ");
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare agency lookup: " . $this->mysqli->error);
        }

        $stmt->bind_param("i", $user['user_id']);
        $stmt->execute();
        $result = $stmt->get_result();
        $agent = $result->fetch_assoc();
        $stmt->close();

        if (!$agent) {
            $this->jsonResponse("error", "Agency profile not found. Please make sure this user exists in the travelagent table.");
        }

        return (int)$agent['agent_id'];
    }

    private function columnExists($table, $column) {
        $key = $table . "." . $column;
        if (isset($this->columnCache[$key])) {
            return $this->columnCache[$key];
        }

        $stmt = $this->mysqli->prepare("
            SELECT COUNT(*) AS cnt
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = DATABASE()
              AND TABLE_NAME = ?
              AND COLUMN_NAME = ?
        ");
        if (!$stmt) {
            return false;
        }

        $stmt->bind_param("ss", $table, $column);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();

        $this->columnCache[$key] = ((int)($row['cnt'] ?? 0)) > 0;
        return $this->columnCache[$key];
    }

    private function getGroupPackageSelect() {
        $parts = [];

        if ($this->columnExists('package', 'is_group_package')) {
            $parts[] = "p.is_group_package AS is_group_package";
        } elseif ($this->columnExists('package', 'is_group')) {
            $parts[] = "p.is_group AS is_group_package";
        } else {
            $parts[] = "0 AS is_group_package";
        }

        if ($this->columnExists('package', 'min_group_size')) {
            $parts[] = "p.min_group_size";
        } else {
            $parts[] = "NULL AS min_group_size";
        }

        if ($this->columnExists('package', 'max_group_size')) {
            $parts[] = "p.max_group_size";
        } else {
            $parts[] = "NULL AS max_group_size";
        }

        return implode(",\n                ", $parts);
    }

    private function normalisePackageRow($row) {
        $row['package_id'] = (int)$row['package_id'];
        $row['agent_id'] = (int)$row['agent_id'];
        $row['dest_id'] = (int)$row['dest_id'];
        $row['price'] = (float)$row['price'];
        $row['quantity'] = (int)$row['quantity'];
        $row['avg_rating'] = (float)$row['avg_rating'];
        $row['review_count'] = (int)$row['review_count'];
        $row['booking_count'] = (int)$row['booking_count'];
        $row['is_group_package'] = ((int)($row['is_group_package'] ?? 0)) === 1;
        if (isset($row['min_group_size'])) {
            $row['min_group_size'] = $row['min_group_size'] === null ? null : (int)$row['min_group_size'];
        }
        if (isset($row['max_group_size'])) {
            $row['max_group_size'] = $row['max_group_size'] === null ? null : (int)$row['max_group_size'];
        }
        return $row;
    }

    private function bindDynamic($stmt, $types, &$params) {
        $refs = [];
        $refs[] = $types;
        foreach ($params as $key => $value) {
            $refs[] = &$params[$key];
        }
        return call_user_func_array([$stmt, 'bind_param'], $refs);
    }

    private function validatePackageInput($data, $isUpdate = false) {
        $title = trim($data['title'] ?? '');
        $destId = (int)($data['dest_id'] ?? 0);
        $price = (float)($data['price'] ?? 0);
        $quantity = (int)($data['quantity'] ?? 0);
        $expiryDate = trim($data['expiry_date'] ?? '');
        $status = trim($data['status'] ?? 'active');
        $description = trim($data['description'] ?? '');

        $allowedStatuses = ['active', 'inactive', 'sold_out'];

        if ($title === '') {
            $this->jsonResponse("error", "Package title is required");
        }

        if ($destId <= 0) {
            $this->jsonResponse("error", "Destination is required");
        }

        if ($price <= 0) {
            $this->jsonResponse("error", "Price must be greater than 0");
        }

        if ($quantity < 0) {
            $this->jsonResponse("error", "Quantity cannot be negative");
        }

        if ($expiryDate === '' || !preg_match('/^\d{4}-\d{2}-\d{2}$/', $expiryDate)) {
            $this->jsonResponse("error", "Expiry date must be in YYYY-MM-DD format");
        }

        if (!in_array($status, $allowedStatuses, true)) {
            $this->jsonResponse("error", "Invalid package status");
        }

        $stmt = $this->mysqli->prepare("SELECT dest_id FROM destination WHERE dest_id = ? LIMIT 1");
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare destination validation: " . $this->mysqli->error);
        }
        $stmt->bind_param("i", $destId);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows === 0) {
            $stmt->close();
            $this->jsonResponse("error", "Destination not found");
        }
        $stmt->close();

        $isGroup = !empty($data['is_group']) ? 1 : 0;
        $minGroup = null;
        $maxGroup = null;

        if ($isGroup) {
            $minGroup = isset($data['min_group_size']) && $data['min_group_size'] !== null ? (int)$data['min_group_size'] : null;
            $maxGroup = isset($data['max_group_size']) && $data['max_group_size'] !== null ? (int)$data['max_group_size'] : null;

            if ($minGroup !== null && $minGroup < 1) {
                $this->jsonResponse("error", "Minimum group size must be at least 1");
            }

            if ($maxGroup !== null && $maxGroup < 1) {
                $this->jsonResponse("error", "Maximum group size must be at least 1");
            }

            if ($minGroup !== null && $maxGroup !== null && $maxGroup < $minGroup) {
                $this->jsonResponse("error", "Maximum group size cannot be less than minimum group size");
            }
        }

        return [
            'title' => $title,
            'dest_id' => $destId,
            'price' => $price,
            'quantity' => $quantity,
            'expiry_date' => $expiryDate,
            'status' => $status,
            'description' => $description,
            'img_url' => trim($data['img_url'] ?? ''),
            'is_group' => $isGroup,
            'min_group_size' => $minGroup,
            'max_group_size' => $maxGroup
        ];
    }

    // ============================================================
    // Agency: packages
    // ============================================================
    private function getAgencyPackages($data) {
        $agentId = $this->requireAgency($data);

        $imgSelect = $this->columnExists('package', 'img_url') ? "p.img_url" : "NULL AS img_url";
        $groupSelect = $this->getGroupPackageSelect();

        $sql = "
            SELECT
                p.package_id,
                p.agent_id,
                p.dest_id,
                p.title,
                p.description,
                p.price,
                p.expiry_date,
                p.quantity,
                p.status,
                p.created_at,
                $imgSelect,
                $groupSelect,
                d.city    AS destination_city,
                d.country AS destination_country,
                COALESCE(rv.avg_rating, 0)    AS avg_rating,
                COALESCE(rv.review_count, 0)  AS review_count,
                COALESCE(bk.booking_count, 0) AS booking_count
            FROM `package` p
            JOIN destination d
                ON p.dest_id = d.dest_id
            LEFT JOIN (
                SELECT package_id, ROUND(AVG(rating), 1) AS avg_rating, COUNT(*) AS review_count
                FROM review
                GROUP BY package_id
            ) rv ON rv.package_id = p.package_id
            LEFT JOIN (
                SELECT package_id, COUNT(*) AS booking_count
                FROM booking
                GROUP BY package_id
            ) bk ON bk.package_id = p.package_id
            WHERE p.agent_id = ?
            ORDER BY p.created_at DESC
        ";

        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare agency package query: " . $this->mysqli->error);
        }

        $stmt->bind_param("i", $agentId);
        $stmt->execute();
        $result = $stmt->get_result();

        $packages = [];
        while ($row = $result->fetch_assoc()) {
            $packages[] = $this->normalisePackageRow($row);
        }
        $stmt->close();

        $this->jsonResponse("success", "Agency packages retrieved", $packages);
    }

    private function createPackage($data) {
        $agentId = $this->requireAgency($data);
        $pkg = $this->validatePackageInput($data, false);

        $columns = ['agent_id', 'dest_id', 'title', 'description', 'price', 'expiry_date', 'quantity', 'status'];
        $placeholders = ['?', '?', '?', '?', '?', '?', '?', '?'];
        $types = "iissdsis";
        $params = [
            $agentId,
            $pkg['dest_id'],
            $pkg['title'],
            $pkg['description'],
            $pkg['price'],
            $pkg['expiry_date'],
            $pkg['quantity'],
            $pkg['status']
        ];

        if ($this->columnExists('package', 'img_url')) {
            $columns[] = 'img_url';
            $placeholders[] = '?';
            $types .= 's';
            $params[] = $pkg['img_url'] !== '' ? $pkg['img_url'] : null;
        }

        if ($this->columnExists('package', 'is_group_package')) {
            $columns[] = 'is_group_package';
            $placeholders[] = '?';
            $types .= 'i';
            $params[] = $pkg['is_group'];
        } elseif ($this->columnExists('package', 'is_group')) {
            $columns[] = 'is_group';
            $placeholders[] = '?';
            $types .= 'i';
            $params[] = $pkg['is_group'];
        }

        if ($this->columnExists('package', 'min_group_size')) {
            $columns[] = 'min_group_size';
            $placeholders[] = '?';
            $types .= 'i';
            $params[] = $pkg['min_group_size'];
        }

        if ($this->columnExists('package', 'max_group_size')) {
            $columns[] = 'max_group_size';
            $placeholders[] = '?';
            $types .= 'i';
            $params[] = $pkg['max_group_size'];
        }

        $colSql = "`" . implode("`, `", $columns) . "`";
        $sql = "INSERT INTO `package` ($colSql) VALUES (" . implode(", ", $placeholders) . ")";

        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare package creation: " . $this->mysqli->error);
        }

        $this->bindDynamic($stmt, $types, $params);

        if (!$stmt->execute()) {
            $error = $stmt->error;
            $stmt->close();
            $this->jsonResponse("error", "Failed to create package: " . $error);
        }

        $newId = $stmt->insert_id;
        $stmt->close();

        $this->jsonResponse("success", "Package created successfully", ["package_id" => $newId]);
    }

    private function updatePackage($data) {
        $agentId = $this->requireAgency($data);
        $packageId = (int)($data['package_id'] ?? 0);

        if ($packageId <= 0) {
            $this->jsonResponse("error", "Package ID is required");
        }

        $pkg = $this->validatePackageInput($data, true);

        $set = [
            "dest_id = ?",
            "title = ?",
            "description = ?",
            "price = ?",
            "expiry_date = ?",
            "quantity = ?",
            "status = ?"
        ];

        $types = "issdsis";
        $params = [
            $pkg['dest_id'],
            $pkg['title'],
            $pkg['description'],
            $pkg['price'],
            $pkg['expiry_date'],
            $pkg['quantity'],
            $pkg['status']
        ];

        if ($this->columnExists('package', 'img_url') && array_key_exists('img_url', $data)) {
            $set[] = "img_url = ?";
            $types .= 's';
            $params[] = $pkg['img_url'] !== '' ? $pkg['img_url'] : null;
        }

        if ($this->columnExists('package', 'is_group_package')) {
            $set[] = "is_group_package = ?";
            $types .= 'i';
            $params[] = $pkg['is_group'];
        } elseif ($this->columnExists('package', 'is_group')) {
            $set[] = "is_group = ?";
            $types .= 'i';
            $params[] = $pkg['is_group'];
        }

        if ($this->columnExists('package', 'min_group_size')) {
            $set[] = "min_group_size = ?";
            $types .= 'i';
            $params[] = $pkg['min_group_size'];
        }

        if ($this->columnExists('package', 'max_group_size')) {
            $set[] = "max_group_size = ?";
            $types .= 'i';
            $params[] = $pkg['max_group_size'];
        }

        $types .= "ii";
        $params[] = $packageId;
        $params[] = $agentId;

        $sql = "UPDATE `package` SET " . implode(", ", $set) . " WHERE package_id = ? AND agent_id = ?";
        $stmt = $this->mysqli->prepare($sql);

        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare package update: " . $this->mysqli->error);
        }

        $this->bindDynamic($stmt, $types, $params);

        if (!$stmt->execute()) {
            $error = $stmt->error;
            $stmt->close();
            $this->jsonResponse("error", "Failed to update package: " . $error);
        }

        $affectedRows = $stmt->affected_rows;
        $stmt->close();

        if ($affectedRows === 0) {
            $this->jsonResponse("error", "Package not found for this agency, or no changes were made");
        }

        $this->jsonResponse("success", "Package updated successfully");
    }

    private function deletePackage($data) {
        $agentId = $this->requireAgency($data);
        $packageId = (int)($data['package_id'] ?? 0);

        if ($packageId <= 0) {
            $this->jsonResponse("error", "Package ID is required");
        }

        // Make sure the package belongs to this agency.
        $stmt = $this->mysqli->prepare("SELECT package_id FROM `package` WHERE package_id = ? AND agent_id = ? LIMIT 1");
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare package ownership check: " . $this->mysqli->error);
        }
        $stmt->bind_param("ii", $packageId, $agentId);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows === 0) {
            $stmt->close();
            $this->jsonResponse("error", "Package not found for this agency");
        }
        $stmt->close();

        // Do not hard-delete packages that already have bookings because that would break traveller booking history.
        $stmt = $this->mysqli->prepare("SELECT COUNT(*) AS cnt FROM booking WHERE package_id = ?");
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare booking check: " . $this->mysqli->error);
        }
        $stmt->bind_param("i", $packageId);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();

        if (((int)($row['cnt'] ?? 0)) > 0) {
            $this->jsonResponse("error", "This package has bookings. Set it to inactive instead of deleting it.");
        }

        $stmt = $this->mysqli->prepare("DELETE FROM `package` WHERE package_id = ? AND agent_id = ?");
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare package deletion: " . $this->mysqli->error);
        }

        $stmt->bind_param("ii", $packageId, $agentId);
        if (!$stmt->execute()) {
            $error = $stmt->error;
            $stmt->close();
            $this->jsonResponse("error", "Failed to delete package: " . $error);
        }

        $stmt->close();
        $this->jsonResponse("success", "Package deleted successfully");
    }

    // ============================================================
    // Agency: bookings
    // ============================================================
    private function getAgencyBookings($data) {
        $agentId = $this->requireAgency($data);

        $sql = "
            SELECT
                b.booking_id,
                b.package_id,
                p.title AS package_title,
                d.city AS destination_city,
                d.country AS destination_country,
                CONCAT(t.first_name, ' ', t.last_name) AS traveller_name,
                u.email AS traveller_email,
                b.num_travellers,
                b.total_price,
                b.booking_status,
                b.booking_date
            FROM booking b
            JOIN `package` p
                ON b.package_id = p.package_id
            JOIN destination d
                ON p.dest_id = d.dest_id
            JOIN traveller t
                ON b.traveller_id = t.traveller_id
            JOIN user u
                ON t.traveller_id = u.user_id
            WHERE p.agent_id = ?
            ORDER BY b.booking_date DESC
        ";

        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare agency booking query: " . $this->mysqli->error);
        }

        $stmt->bind_param("i", $agentId);
        $stmt->execute();
        $result = $stmt->get_result();

        $bookings = [];
        while ($row = $result->fetch_assoc()) {
            $row['booking_id'] = (int)$row['booking_id'];
            $row['package_id'] = (int)$row['package_id'];
            $row['num_travellers'] = (int)$row['num_travellers'];
            $row['total_price'] = (float)$row['total_price'];
            $bookings[] = $row;
        }
        $stmt->close();

        $this->jsonResponse("success", "Agency bookings retrieved", $bookings);
    }

    // ============================================================
    // Agency: reviews
    // ============================================================
    private function getAgencyReviews($data) {
        $agentId = $this->requireAgency($data);

        $sql = "
            SELECT
                r.review_id,
                r.package_id,
                p.title AS package_title,
                r.rating,
                r.comment,
                r.review_date,
                CONCAT(t.first_name, ' ', t.last_name) AS reviewer_name,
                u.email AS reviewer_email,
                d.city AS destination_city,
                d.country AS destination_country
            FROM review r
            JOIN traveller t
                ON r.traveller_id = t.traveller_id
            JOIN user u
                ON t.traveller_id = u.user_id
            LEFT JOIN `package` p
                ON r.package_id = p.package_id
            LEFT JOIN destination d
                ON p.dest_id = d.dest_id
            WHERE r.agent_id = ?
            ORDER BY r.review_date DESC
        ";

        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->jsonResponse("error", "Failed to prepare agency review query: " . $this->mysqli->error);
        }

        $stmt->bind_param("i", $agentId);
        $stmt->execute();
        $result = $stmt->get_result();

        $reviews = [];
        while ($row = $result->fetch_assoc()) {
            $row['review_id'] = (int)$row['review_id'];
            $row['package_id'] = $row['package_id'] === null ? null : (int)$row['package_id'];
            $row['rating'] = (int)$row['rating'];
            $reviews[] = $row;
        }
        $stmt->close();

        $this->jsonResponse("success", "Agency reviews retrieved", $reviews);
    }


    }
 
// Run API
$api = new API();
$api->handleRequest();
?> 