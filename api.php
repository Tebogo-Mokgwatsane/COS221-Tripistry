<?php


header("Content-Type: application/json");

require_once __DIR__ . '/config.php';

class API
{
    private $mysqli; // mysqli connection

    public function __construct()
    {
        global $mysqli;
        $this->mysqli = $mysqli;

    }

    public function handleRequest()
    {
        $input = [];

        if (strpos($_SERVER['CONTENT_TYPE'] ?? '', 'application/json') !== false) {
            $input = json_decode(file_get_contents("php://input"), true) ?? [];
        } else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $input = $_POST;
        }

        if (!isset($input['type']) || empty($input['type'])) {
            $this->error("Missing 'type' parameter", 400);
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
            case "Search":
                $this->searchPackages($input);
                break;
            case "Accommodations":       
                $this->getAccommodations();
                break;
            case "Attractions":          
                $this->getAttractions();
                break;
            case "Restaurants":          
                $this->getRestaurants();
                break;
            case "Flights":          
                $this->getFlights();
                break;
            case "Destinations":          
                $this->getDestinations();
                break;
            case "Booking":
                $this->handleBooking($input);
                break;
            case "Payment":
                $this->handlePayment($input);
                break;
            case "CheckBooking":
                $this->checkBooking($input);
                break;
            case "Packageinfo":
                $this->packageInfo($input);
                break;
            case "Packages":
                $this->packages($input);
                break;
            case "GetPackage":
                $this->packageReturnAll($input);
                break;
            default:
                $this->error("Unknown request type");
                break;
        }
    }

    private function success($data)
    {
        http_response_code(200);
        echo json_encode([
            "status" => "success",
            "timestamp" => time(),
            "data" => $data
        ]);
        exit;
    }

    private function error($message, $code = 400)
    {
        http_response_code($code);
        echo json_encode([
            "status" => "error",
            "timestamp" => time(),
            "data" => $message
        ]);
        exit;
        $this->error("Request failed", $data, $code);
    }

    private function authenticate($apiKey)
    {
        if (empty($apiKey)) {
            $this->error("Missing API key. Please log in.");
        }
        $stmt = $this->mysqli->prepare(
            "SELECT user_id, user_type FROM user WHERE api_key = ?"
        );
        $stmt->bind_param("s", $apiKey);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        $stmt->close();

        if (!$user) {
            $this->error("Invalid or expired session. Please log in again.");
        }
        return $user;
    }

    private function getTravellerId($userId)
    {
        $stmt = $this->mysqli->prepare(
            "SELECT traveller_id FROM traveller WHERE traveller_id = ?"
        );
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();
        return $row ? $row['traveller_id'] : null;
    }

    // Registering user ====================
    private function registerUser($data)
    {
        if (empty($data['email']) || empty($data['password']) || empty($data['user_type'])) {
            $this->error("All fields are required", 400);
        }

        if (empty($data['username'])) {
            $this->error("Username is required", 400);
        }

        if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $this->error("Invalid email address", 400);
        }

        $passRegex = "/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/";
        if (!preg_match($passRegex, $data['password'])) {
            $this->error("Password must be 8+ chars with upper, lower, number and symbol");
        }

        $userType = $data['user_type'];
        $username = $data['username'] ?? '';

        // Agency specific validation
        if ($userType === "agency" || $userType === "travel_agent") {
            if (empty($data['registration_num'])) {
                $this->error("Registration number is required for agencies", 400);
            }

            // Check if registration number is valid in reg_numbers table
            $stmt = $this->mysqli->prepare("SELECT reg_id FROM businessregistration WHERE reg_number = ? AND status = 'valid'");
            $stmt->bind_param("s", $data['registration_num']);
            $stmt->execute();
            $stmt->store_result();

            if ($stmt->num_rows === 0) {
                $stmt->close();
                $this->error("Invalid or unlicensed registration number", 400);
            } else //If valid, check if not taken
            {
                $stmt->close();
                $stmt = $this->mysqli->prepare("SELECT reg_id FROM businessregistration WHERE (used_by IS NOT NULL AND reg_number = ?) OR (reg_number = ? AND status = 'taken')");
                $stmt->bind_param("ss", $data['registration_num'], $data['registration_num']);
                $stmt->execute();
                $stmt->store_result();
                if ($stmt->num_rows > 0) {
                    $stmt->close();
                    $this->error("Registration number already in use by another account", 409);
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
            $this->error("Email already registered", 409);
        }
        $stmt->close();

        // Hash password
        //changed to SHA2 hashing for better security. 
        $hashed = hash('sha256', $data['password']);

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
        } else // Agency
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
            $this->success([
                "apikey" => $apiKey,
                "username" => $username,
                "user_type" => $userType,
                "email" => $data['email']
            ]);
        } else {
            $this->error("Failed to register user", 500);
        }
    }

    private function loginUser($data)
    {
        if (empty($data['email']) || empty($data['password'])) {
            $this->error("Email and password required", 400);
        }

        $stmt = $this->mysqli->prepare("
        SELECT user_id, username, email, password_hash, user_type, api_key
        FROM user
        WHERE email = ?
    ");

        $stmt->bind_param("s", $data['email']);
        $stmt->execute();

        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        $stmt->close();

        $hashedPassword = hash('sha256', $data['password']);

        if (!$user || $hashedPassword !== $user['password_hash']) {
            $this->error("Invalid Credentials", 401);
        }

        session_start();

        $_SESSION['user_id'] = $user['user_id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['user_type'] = $user['user_type'];

        $this->success([
            "apikey" => $user['api_key'],
            "username" => $user['username'],
            "user_type" => $user['user_type'],
            "email" => $user['email']
        ]);
    }

    // Searching for packages ====================
    private function searchPackages($data)
    {

        $query = empty($data['query']) ? "%" : "%" . $data['query'] . "%";

        $stmt = $this->mysqli->prepare("
        SELECT 
    a.agency_name AS agency,
    p.package_id,
    p.description,
    p.price,
    p.quantity,
    p.title,
    p.img_url AS image_url,
    ROUND(AVG(r.rating),1) AS rating,
    (p.quantity > 0) AS in_stock,
    CONCAT(d.city, ', ', d.country) AS location,
    g.min_group_size,
    g.max_group_size,
    CASE
        WHEN g.package_id IS NOT NULL THEN 'group'
        ELSE 'solo'
    END AS package_type,
    act.activities

FROM package p
LEFT JOIN travelagent a ON p.agent_id = a.agent_id
LEFT JOIN destination d ON d.dest_id = p.dest_id
LEFT JOIN review r ON r.package_id = p.package_id
LEFT JOIN grouppackage g ON g.package_id = p.package_id

LEFT JOIN (
    SELECT 
        x.package_id,
        JSON_ARRAYAGG(
            JSON_OBJECT(
                'day', x.day_number,
                'activities', x.day_activities
            )
        ) AS activities
    FROM (
        SELECT
            pa.package_id,
            pa.day_number,
            JSON_ARRAYAGG(
                JSON_OBJECT(
                    'activity', pa.activity_name,
                    'time', pa.activity_time,
                    'description', pa.description
                )
                ORDER BY pa.activity_time
            ) AS day_activities
        FROM packageactivity pa
        GROUP BY pa.package_id, pa.day_number
    ) x
    GROUP BY x.package_id
) act ON act.package_id = p.package_id

WHERE 
    p.title LIKE ? 
    OR p.description LIKE ? 
    OR d.city LIKE ? 
    OR d.country LIKE ?
    OR a.agency_name LIKE ?

GROUP BY 
    p.package_id,
    a.agency_name,
    d.city,
    d.country,
    p.title,
    p.price,
    p.quantity,
    g.min_group_size,
    g.max_group_size,
    g.package_id,
    act.activities

ORDER BY p.price ASC
LIMIT 30;
        ");

        $stmt->bind_param("sssss", $query, $query, $query, $query, $query);
        $stmt->execute();
        $result = $stmt->get_result();

        $packages = [];
        while ($row = $result->fetch_assoc()) {

            if ($row['activities']) {
                $row['activities'] = json_decode($row['activities'], true);
            } else {
                $row['activities'] = [];
            }

            $packages[] = $row;
        }
        $stmt->close();

        $this->success($packages);
    }

    private function getBookings($data)
    {
        $apiKey = $data['api_key'] ?? '';
        $user = $this->authenticate($apiKey);

        if ($user['user_type'] !== 'traveller') {
            $this->error("Only travellers can view bookings");
        }

        $travellerId = $this->getTravellerId($user['user_id']);
        if (!$travellerId) {
            $this->error("Traveller profile not found");

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
        $booking = [];
        while ($row = $result->fetch_assoc()) {
            $row['already_reviewed'] = (bool) $row['already_reviewed'];
            $booking[] = $row;
        }

        $stmt->close();
        $this->success($booking);
    }
    private function jsonResponse($status, $message, $data = []) {
        echo json_encode([  
            "status" => $status,
            "message" => $message,
            "data" => $data
        ]);
        exit;
    }


    private function addReview($data)
    {
        $apiKey = $data['api_key'] ?? '';
        $user = $this->authenticate($apiKey);

        if ($user['user_type'] !== 'traveller') {
            $this->error("Only travellers can leave reviews");
        }

        $travellerId = $this->getTravellerId($user['user_id']);
        if (!$travellerId) {
            $this->error("Traveller profile not found");
        }

        $packageId = intval($data['package_id'] ?? 0);
        $rating = intval($data['rating'] ?? 0);
        $comment = trim($data['comment'] ?? '');

        if (!$packageId) {
            $this->error("Package ID is required");
        }
        if ($rating < 1 || $rating > 5) {
            $this->error("Rating must be between 1 and 5");
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
            $this->error("You can only review packages you have booked");
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
            $this->error("You have already reviewed this package");
        }
        $stmt->close();

        // Get the agent_id from the package
        $stmt = $this->mysqli->prepare("SELECT agent_id FROM package WHERE package_id = ?");
        $stmt->bind_param("i", $packageId);
        $stmt->execute();
        $result = $stmt->get_result();
        $package = $result->fetch_assoc();
        $stmt->close();

        if (!$package) {
            $this->error("Package not found");
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
            $this->success("Review submitted successfully!");
        } else {
            $this->error("Failed to submit review");
        }
    }

    private function packageReturnAll($input)
    {
        if (!isset($input["package_id"]) || empty($input["package_id"])) {
            $this->error("Missing package_id", 400);
            return;
        }

        $package_id = (int) $input["package_id"];
        if ($package_id <= 0) {
            $this->error("Invalid package_id", 400);
            return;
        }
        $sql = "
            SELECT 
                p.package_id,
                p.title,
                p.description,
                p.price,
                p.quantity,
                p.status,
                p.img_url,
                p.expiry_date,
                d.dest_id,
                d.city,
                d.country,
                d.description AS destination_description,
                d.img_url AS destination_img_url,
                gp.package_id AS group_package_id,
                gp.min_group_size,
                gp.max_group_size,
                gp.status AS group_status
            FROM package p
            INNER JOIN destination d 
                ON p.dest_id = d.dest_id
            LEFT JOIN grouppackage gp 
                ON p.package_id = gp.package_id
            WHERE p.package_id = ?
            LIMIT 1
        ";

        $stmt = $this->mysqli->prepare($sql);

        if (!$stmt) {
            $this->error("Failed to prepare package query: " . $this->mysqli->error, 500);
            return;
        }

        $stmt->bind_param("i", $package_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            $stmt->close();
            $this->error("Package not found", 404);
            return;
        }

        $package = $result->fetch_assoc();
        $stmt->close();
        $activities = [];

        $sql = "
            SELECT 
                day_number,
                activity_name,
                activity_time,
                description
            FROM packageactivity
            WHERE package_id = ?
            ORDER BY day_number ASC, activity_time ASC
        ";

        $stmt = $this->mysqli->prepare($sql);

        if ($stmt) {
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $activities[] = [
                    "day_number" => (int) $row["day_number"],
                    "activity_name" => $row["activity_name"],
                    "activity_time" => $row["activity_time"],
                    "description" => $row["description"]
                ];
            }

            $stmt->close();
        }
        $restaurants = [];

        $sql = "
            SELECT 
                r.res_id,
                r.name,
                r.type,
                r.fee,
                r.description,
                r.rating,
                r.img_url
            FROM packagerestaurant pr
            INNER JOIN restaurant r 
                ON pr.res_id = r.res_id
            WHERE pr.package_id = ?
            ORDER BY r.rating DESC
        ";

        $stmt = $this->mysqli->prepare($sql);

        if ($stmt) {
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $restaurants[] = [
                    "res_id" => (int) $row["res_id"],
                    "name" => $row["name"],
                    "type" => $row["type"],
                    "details" => $row["description"],
                    "rating" => $row["rating"] !== null ? (float) $row["rating"] : null,
                    "fee" => $row["fee"] !== null ? (float) $row["fee"] : 0,
                    "img_url" => $row["img_url"]
                ];
            }

            $stmt->close();
        }
        $flights = [];

        $sql = "
            SELECT 
                f.flight_id,
                f.airline_name,
                f.departure_airport,
                f.arrival_airport,
                f.dept_date,
                f.arrival_datetime,
                f.classes,
                f.price,
                f.img_url
            FROM packageflight pf
            INNER JOIN flight f 
                ON pf.flight_id = f.flight_id
            WHERE pf.package_id = ?
            ORDER BY f.dept_date ASC
        ";

        $stmt = $this->mysqli->prepare($sql);

        if ($stmt) {
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $flights[] = [
                    "flight_id" => (int) $row["flight_id"],
                    "airline_name" => $row["airline_name"],
                    "departure_airport" => $row["departure_airport"],
                    "arrival_airport" => $row["arrival_airport"],
                    "departure_datetime" => $row["dept_date"],
                    "arrival_datetime" => $row["arrival_datetime"],
                    "class" => $row["classes"],
                    "price" => (float) $row["price"],
                    "img_url" => $row["img_url"]
                ];
            }

            $stmt->close();
        }
        $reviews = [];

        $sql = "
            SELECT 
                r.review_id,
                r.rating,
                r.comment,
                r.review_date,
                t.first_name,
                t.last_name,
                u.username
            FROM review r
            INNER JOIN traveller t 
                ON r.traveller_id = t.traveller_id
            INNER JOIN user u 
                ON t.traveller_id = u.user_id
            WHERE r.package_id = ?
            ORDER BY r.review_date DESC
        ";

        $stmt = $this->mysqli->prepare($sql);
        if ($stmt) {
            $stmt->bind_param("i", $package_id);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $reviews[] = [
                    "review_id" => (int) $row["review_id"],
                    "rating" => (int) $row["rating"],
                    "comment" => $row["comment"],
                    "review_date" => $row["review_date"],
                    "traveller_name" => trim($row["first_name"] . " " . $row["last_name"]),
                    "username" => $row["username"]
                ];
            }

            $stmt->close();
        }
        $response = [
            "package_id" => (int) $package["package_id"],
            "title" => $package["title"],
            "img_url" => $package["img_url"],
            "location" => $package["city"] . ", " . $package["country"],
            "city" => $package["city"],
            "country" => $package["country"],

            "package_type" => $package["group_package_id"] !== null ? "Group" : "Solo",
            "is_group_package" => $package["group_package_id"] !== null,

            "in_stock" => ((int) $package["quantity"] > 0 && $package["status"] === "active"),
            "stock_text" => ((int) $package["quantity"] > 0 && $package["status"] === "active") ? "In stock" : "Out of stock",

            "description" => $package["description"],
            "destination_description" => $package["destination_description"],
            "price" => (float) $package["price"],
            "quantity" => (int) $package["quantity"],
            "status" => $package["status"],
            "expiry_date" => $package["expiry_date"],

            "group_details" => $package["group_package_id"] !== null ? [
                "min_group_size" => (int) $package["min_group_size"],
                "max_group_size" => (int) $package["max_group_size"],
                "group_status" => $package["group_status"]
            ] : null,

            "activities" => $activities,
            "restaurants" => $restaurants,
            "flights" => $flights,
            "reviews" => $reviews
        ];

        $this->success($response);
        return;
    }

    private function getReviews($data)
    {
        $packageId = intval($data['package_id'] ?? 0);

        if (!$packageId) {
            $this->error("Package ID is required");
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
        $result = $stmt->get_result();
        $reviews = [];
        while ($row = $result->fetch_assoc()) {
            $reviews[] = $row;
        }
        $stmt->close();

        $this->success($reviews);
    }

    private function addFavourite($data)
    {
        $apiKey = $data['api_key'] ?? '';
        $user = $this->authenticate($apiKey);

        if ($user['user_type'] !== 'traveller') {
            $this->error("Only travellers can save favourites");
        }

        $travellerId = $this->getTravellerId($user['user_id']);
        $packageId = intval($data['package_id'] ?? 0);

        if (!$packageId) {
            $this->error("Package ID is required");
        }

        // Check not already favourited (INSERT IGNORE handles duplicates gracefully)
        $stmt = $this->mysqli->prepare(
            "INSERT IGNORE INTO favourite (traveller_id, package_id) VALUES (?, ?)"
        );
        $stmt->bind_param("ii", $travellerId, $packageId);
        $success = $stmt->execute();
        $stmt->close();

        if ($success) {
            $this->success("Package added to favourites");
        } else {
            $this->error("Failed to add to favourites");
        }
    }

    private function removeFavourite($data)
    {
        $apiKey = $data['api_key'] ?? '';
        $user = $this->authenticate($apiKey);

        $travellerId = $this->getTravellerId($user['user_id']);
        $packageId = intval($data['package_id'] ?? 0);

        if (!$packageId) {
            $this->error("Package ID is required");
        }

        $stmt = $this->mysqli->prepare(
            "DELETE FROM favourite WHERE traveller_id = ? AND package_id = ?"
        );
        $stmt->bind_param("ii", $travellerId, $packageId);
        $stmt->execute();
        $stmt->close();

        $this->success("Package removed from favourites");
    }

    private function getFavourites($data)
    {
        $apiKey = $data['api_key'] ?? '';
        $user = $this->authenticate($apiKey);

        if ($user['user_type'] !== 'traveller') {
            $this->error("Only travellers can view favourites");
        }

        $travellerId = $this->getTravellerId($user['user_id']);
        if (!$travellerId) {
            $this->error("Traveller profile not found");
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
        $result = $stmt->get_result();
        $favourites = [];
        while ($row = $result->fetch_assoc()) {
            $favourites[] = $row;
        }
        $stmt->close();

        $this->success($favourites);
    }




    //booking
    private function handleBooking($input)
    {
        // Validate inputs
        if (!isset($input["Quantity"])) {
            $this->error("Missing number of packages to be booked", 400);
            return;
        }

        if (!isset($input["Email"])) {
            $this->error("Missing Email", 400);
            return;
        }

        if (!isset($input["package_id"])) {
            $this->error("Missing Package_id", 400);
            return;
        }

        $Quantity = (int) $input["Quantity"];
        $pack_id = (int) $input["package_id"];
        $email = $input["Email"];

        if ($Quantity <= 0) {
            $this->error("Invalid number of packages to be booked", 400);
            return;
        }

        if ($pack_id <= 0) {
            $this->error("Invalid package_id", 400);
            return;
        }

        // Get user details
        $sql = "SELECT user_id, user_type FROM user WHERE email = ?";
        $stmt = $this->mysqli->prepare($sql);

        if (!$stmt) {
            $this->error("Failed to prepare user statement", 500);
            return;
        }

        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            $stmt->close();
            $this->error("Invalid email", 401);
            return;
        }

        $user = $result->fetch_assoc();
        $stmt->close();

        if ($user["user_type"] !== "traveller") {
            $this->error("Only travellers can book packages", 403);
            return;
        }

        $traveller_id = (int) $user["user_id"];

        // Prevent duplicate active booking for the same package
        $sql = "SELECT booking_id 
                    FROM booking 
                    WHERE traveller_id = ? 
                    AND package_id = ? 
                    AND booking_status='pending'";

        $stmt = $this->mysqli->prepare($sql);

        if (!$stmt) {
            $this->error("Failed to prepare duplicate booking check", 500);
            return;
        }

        $stmt->bind_param("ii", $traveller_id, $pack_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $stmt->close();
            $this->error("You have already booked this package.", 409);
            return;
        }

        $stmt->close();

        // Get package quantity and price
        $sql = "SELECT quantity, price FROM package WHERE package_id = ?";
        $stmt = $this->mysqli->prepare($sql);

        if (!$stmt) {
            $this->error("Failed to prepare package statement", 500);
            return;
        }

        $stmt->bind_param("i", $pack_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            $stmt->close();
            $this->error("Invalid package_id", 401);
            return;
        }

        $package = $result->fetch_assoc();
        $stmt->close();

        if ((int) $package["quantity"] < $Quantity) {
            $this->error("Sorry, only " . $package["quantity"] . " package(s) are available.", 409);
            return;
        }

        $price = (float) $package["price"];
        $total_price = $price * $Quantity;

        // Insert booking
        $sql = "INSERT INTO booking 
                    (traveller_id, package_id, num_travellers, total_price, booking_status) 
                    VALUES (?, ?, ?, ?, 'pending')";

        $stmt = $this->mysqli->prepare($sql);

        if (!$stmt) {
            $this->error("Failed to prepare booking statement", 500);
            return;
        }

        $stmt->bind_param("iiid", $traveller_id, $pack_id, $Quantity, $total_price);

        if (!$stmt->execute()) {
            $stmt->close();
            $this->error("Failed to book package", 500);
            return;
        }

        $booking_id = $this->mysqli->insert_id;
        $stmt->close();

        $this->success([
            "total_price" => $total_price,
            "Message" => "Booking is Successful",
            "Booking_id" => $booking_id
        ]);
        return;
    }
    //handling payment
    private function handlePayment($input)
    {
        if (!isset($input["Method"])) {
            $this->error("Method is not set", 400);
            return;
        }
        if (!isset($input["Quantity"])) {
            $this->error("Quantity missing", 400);
            return;
        }
        if (!isset($input["Booking_id"])) {
            $this->error("Missing booking id", 400);
            return;
        }
        if (!isset($input["amount"])) {
            $this->error("Missing amount", 400);
            return;
        }
        if (!isset($input["Reference"])) {
            $this->error("Missing reference", 400);
            return;
        }
        $Booking_id = (int) $input["Booking_id"];
        $Quantity = (int) $input["Quantity"];
        if ($Booking_id <= 0) {
            $this->error("Booking id can't be zero or negative", 400);
            return;
        }
        $Method = $input["Method"];
        $allowedmethod = ["Credit Card", "Debit Card", "Cash", "EFT", "Paypal"];
        if (!in_array($Method, $allowedmethod)) {
            $this->error("Payment method is not allowed", 400);
            return;
        }
        $amount = (double) $input["amount"];
        if ($amount <= 0) {
            $this->error("Enter correct amount", 400);
            return;
        }
        $reference = $input["Reference"];
        //check if pacakge has already been purchased
        $sql = "SELECT * FROM payment WHERE booking_id=?";
        $stmt = $this->mysqli->prepare($sql);
        $stmt->bind_param("i", $Booking_id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows !== 0) {
            $stmt->close();
            $this->error("Package is Already purchased", 400);
            return;
        }
        $stmt->close();
        //check if the amount entered matches the amount in the booking id
        $sql = "SELECT total_price,package_id FROM booking where booking_id=?";
        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->error('Failed to prepare statement', 500);
            return;
        }
        $stmt->bind_param("i", $Booking_id);
        if ($stmt->execute())
            $result = $stmt->get_result();
        if ($result->num_rows === 0) {
            $stmt->close();
            $this->error('Invalid booking_id', 401);
            return;
        }
        $row = $result->fetch_assoc();
        $price = $row["total_price"];
        $pack_id = $row["package_id"];
        $stmt->close();
        if ($amount != $price) {
            $this->error("Amount entered is less than checkout price", 400);
            return;
        }
        //make payment
        $status = "";
        if ($Method == "cash") {
            $status = "pending";
        } else {
            $status = "completed";
        }
        $sql = "INSERT INTO payment (booking_id,payment_method,status,reference,amount) Values(?,?,?,?,?)";
        $stmt = $this->mysqli->prepare($sql);
        $stmt->bind_param("isssd", $Booking_id, $Method, $status, $reference, $amount);
        if ($stmt->execute()) {
            $stmt->close();
            $sqs = "UPDATE booking SET booking_status='confirmed' WHERE booking_id=?";
            $st = $this->mysqli->prepare($sqs);
            $st->bind_param("i", $Booking_id);
            if ($st->execute()) {
                $st->close();
            } else {
                $st->close();
                $this->error("Failed to update booking status", 500);
                return;
            }
            $sql = "UPDATE package set quantity=quantity-? WHERE package_id=?";
            $stmt = $this->mysqli->prepare($sql);
            $stmt->bind_param("ii", $Quantity, $pack_id);
            if ($stmt->execute()) {
                $stmt->close();
                $this->success([]);
                return;
            }
            $stmt->close();
            $this->error("Failed to update package", 500);
            return;
        }
        $stmt->close();
        $this->error('Failed to Transfer', 500);

    }
    private function checkBooking($input)
    {
        if (!isset($input["package_id"])) {
            $this->error("Missing Package_id", 400);
            return;
        }
        if (!isset($input["Quantity"])) {
            $this->error("Missing number of packages to be booked", 400);
            return;
        }
        $pack_id = (int) $input["package_id"];
        $Quantity = (int) $input["Quantity"];
        if ($Quantity <= 0) {
            $this->error("invalid number of packages to be booked", 400);
            return;
        }
        $sql = "SELECT quantity FROM package where package_id=?";
        $stmt = $this->mysqli->prepare($sql);
        $stmt->bind_param("i", $pack_id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows === 0) {
            $stmt->close();
            $this->error('Invalid package_id', 401);
            return;
        }
        $r = $result->fetch_assoc();
        $stmt->close();
        if ($r["quantity"] < $Quantity) {
            $this->error("Sorry, only $Quantity package(s) are available.", 409);
            return;
        }
        $price = 100;
        $sql = "SELECT price FROM package where package_id=?";
        $stmt = $this->mysqli->prepare($sql);
        $stmt->bind_param("i", $pack_id);
        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $price = $result->fetch_assoc()["price"];
            $stmt->close();
        } else {
            $stmt->close();
            $this->error('Invalid package_id', 401);
            return;
        }
        $price = $price * $Quantity;
        $this->success(["total_price" => $price]);
    }
    private function packageInfo($Input)
    {
        if (!isset($Input["package_id"])) {
            $this->error("Missing Package_id");
            return;
        }
        $package = (int) $Input["package_id"];
        $sql = "SELECT * FROM package where package_id=?";
        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->error("Failed to prepare statement", 500);
            return;
        }
        $stmt->bind_param("i", $package);
        if ($stmt->execute()) {

            $result = $stmt->get_result();
            if ($result->num_rows === 0) {
                $this->error("Invalid Pacakge_id");
                return;
            }
            $packageinfo = $result->fetch_assoc();
            $stmt->close();
            $this->success($packageinfo);
            return;
        }
        $stmt->close();
        $this->error("Failed to pullpackage info");
        return;
    }
    private function packages($input)
    {
        $sql = "SELECT p.*, a.agency_name,d.city FROM package p left join travelagent a ON a.agent_id=p.agent_id INNER JOIN destination d ON d.dest_id=p.dest_id";
        $stmt = $this->mysqli->prepare($sql);
        if (!$stmt) {
            $this->error("failed to prepare a statement", 500);
            return;
        }
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows === 0) {
            $this->error("failed to pull pacakges", 500);
            return;
        }
        $packges = [];
        while ($row = $result->fetch_assoc()) {
            $packages[] =
                [
                    "package_id" => (int) $row["package_id"],
                    "in_stock" => ((int) $row["quantity"] > 0) ? "In stock" : "Out of stock",
                    "agency" => strtoupper($row["agency_name"]),
                    "location" => strtoupper($row["city"]),
                    "title" => $row["title"],
                    "description" => $row["description"],
                    "price" => (float) $row["price"]
                ];
        }
        $stmt->close();
        $this->success($packages);
        return;
    }

    // Additional methods for fetching data for browse
    private function getflights(){
        $stmt = $this->mysqli->query("SELECT flight_id, airline_name, Price, departure_airport, arrival_airport,
            DATE_FORMAT(dept_date,'%d %b %Y') as dept_date,
            DATE_FORMAT(dept_date,'%H %i') as dept_time,
            DATE_FORMAT(arrival_datetime,'%d %b %Y') as arrival_date,
            DATE_FORMAT(arrival_datetime,'%H %i') as arrival_time,
            classes,img_url FROM flight ORDER BY Price ASC;");
        $this->jsonResponse("success", "Flights retrieved", $stmt->fetch_all(MYSQLI_ASSOC));
    }

    private function getDestinations(){
        $stmt = $this->mysqli->query("SELECT dest_id, city, country, description, img_url FROM destination ORDER BY city ASC");
        $this->jsonResponse("success", "Destinations retrieved", $stmt->fetch_all(MYSQLI_ASSOC));
    }

    private function getAccommodations() {
        $result = $this->mysqli->query("SELECT a.*, aa.city, aa.country FROM accommodation a LEFT JOIN accommodationaddress aa ON a.acc_id = aa.acc_id ORDER BY a.price_per_night ASC");
        $this->jsonResponse("success", "Accommodations retrieved", $result->fetch_all(MYSQLI_ASSOC));
    }

    private function getAttractions() {
        $result = $this->mysqli->query("SELECT a.*, aa.city, aa.country FROM attraction a LEFT JOIN attractionaddress aa ON a.att_id = aa.att_id ORDER BY a.fee ASC");
        $this->jsonResponse("success", "Attractions retrieved", $result->fetch_all(MYSQLI_ASSOC));
    }

    private function getRestaurants() {
        $result = $this->mysqli->query("SELECT r.*, ra.city, ra.country FROM restaurant r LEFT JOIN restaurantaddress ra ON r.res_id = ra.res_id ORDER BY r.fee ASC");
        $this->jsonResponse("success", "Restaurants retrieved", $result->fetch_all(MYSQLI_ASSOC));
    }

}
// Run API
$api = new API();
$api->handleRequest();
?>