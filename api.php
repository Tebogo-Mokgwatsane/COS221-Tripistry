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
            case "Booking":
                $this->handleBooking();
                break;
            case "Payment":
                $this->handlePayment();
                break;
            default:
                $this->jsonResponse("error", "Unknown request type");
                break;
        }
    }

    private function success($data = []) 
    {
        http_response_code(200);
        echo json_encode([
            "status" => "success",
            "timestamp" =>(int)(microtime(true) * 1000),
            "data" => $data
        ]);
        exit;
    }
    private function error($message, $code=400)
    {
        http_response_code($code);
        echo json_encode([
            "status" => "error",
            "timestamp" =>(int)(microtime(true) * 1000),
            "message" => $message
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
        $hashed = password_hash($data['password'], PASSWORD_DEFAULT);

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

        $stmt = $this->mysqli->prepare("SELECT user_id, email, password_hash, api_key FROM user WHERE email = ?");
        $stmt->bind_param("s", $data['email']);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        $stmt->close();

        if (!$user || !password_verify($data['password'], $user['password_hash'])) {
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
    //booking
    private function handleBooking()
        {
            //first check if packages are still available
            if(!isset($this->data["Quantity"]))
            {
                $this->error("Missing number of packages to be booked",400);
                return;
            }
            if(!isset($this->data["Email"]))
            {
                $this->error("Missing Email",400);
                return;
            }
            if(!isset($this->data["package_id"]))
            {
                $this->error("Missing Package_id",400);
                return;
            }
            $Quantity=(int)$this->data["Quantity"];
            if($Quantity<=0)
            {
                $this->error("invalid number of packages to be booked",400);
                return;
            }
            $pack_id=(int)$this->data["package_id"];
            $email=$this->data["Email"];
            $sql="SELECT user_id,user_type FROM user WHERE email=?";
            $stmt=$this->connect->prepare($sql);
            if(!$stmt)
            {
                $this->error('Failed to prepare statement',500);
                return;
            }
            $stmt->bind_param("s",$email);
            $stmt->execute();
            $result=$stmt->get_result();
            if($result->num_rows===0) 
            {
                $stmt->close();
                $this->error('Invalid email',401);
                return;
            } 
            $results=$result->fetch_assoc();
            $stmt->close();
            if($results["user_type"]!="traveller")
            {
                $this->error('only traveller can book package',403);
                return;
            }
            $id=$results["user_id"];
            //done with validations//chack if enough packages exists
            $sql="SELECT quantity FROM package where package_id=?";
            $stmt=$this->connect->prepare($sql);
            $stmt->bind_param("i",$pack_id);
            $stmt->execute();
            $result=$stmt->get_result();
            if($result->num_rows===0) 
            {
                $stmt->close();
                $this->error('Invalid package_id',401);
                return;
            } 
            $r=$result->fetch_assoc();
            $stmt->close();
            if($r["quantity"]< $Quantity)
            {
                $this->error("Sorry, only $Quantity package(s) are available.",409);
                return;
            }
            //time to book//lets get price first
            $price=100;
            $sql="SELECT price FROM package where package_id=?";
            $stmt=$this->connect->prepare($sql);
            $stmt->bind_param("i",$pack_id);
            if($stmt->execute())
            {
                $result=$stmt->get_result();
                $price=$result->fetch_assoc()["price"];
                $stmt->close();
            }
            else
            {
                $stmt->close();
                $this->error('Invalid package_id',401);
                return;
            }
            $price=$price*$Quantity;
            $sql="INSERT INTO booking (traveller_id,package_id,num_travellers,total_price) VALUES (?,?,?,?)";
            $stmt=$this->connect->prepare($sql);
            $stmt->bind_param("iiii",$id,$pack_id,$Quantity,$price);
            if($stmt->execute())
            {
                $stmt->close();
                $this->success(
                [
                    "total price"=>$price,
                    "Message"=>"Booking is Sucessfull"
                ]);
                return;
            }
            $stmt->close();
            $this->sendRequest('Failed to Book Package',500);
            return;
        }
        //handling payment
        private function handlePayment()
        {
            if(!isset($this->data["Method"]))
            {
                $this->error("Method is not set",400);
                return;
            }
            if(!isset($this->data["Booking_id"]))
            {
                $this->error("Missing booking id",400);
                return;
            }
            if(!isset($this->data["amount"]))
            {
                $this->error("Missing amount",400);
                return;
            }
            if(!isset($this->data["Reference"]))
            {
                $this->error("Missing reference",400);
                return;
            }
            $Booking_id=(int)$this->data["Booking_id"];
            if($Booking_id<=0)
            {
                $this->error("Booking id can't be zero or negative",400);
                return;
            }
            $Method=$this->data["Method"];
            $allowedmethod=["Credit Card","Debit Card","Cash","EFT","Paypal"];
            if(!in_array($Method,$allowedmethod))
            {
                $this->error("Payment method is not allowed",400);
                return;
            }
            $amount=(double)$this->data["amount"];
            if($amount<=0)
            {
                $this->error("Enter correct amount",400);
                return;
            }
            $reference=$this->data["Reference"];

            //check if pacakge has already been purchased
            $sql="SELECT * FROM payment WHERE booking_id=?";
            $stmt=$this->connect->prepare($sql);
            $stmt->bind_param("i",$Booking_id);
            $stmt->execute();
            $result=$stmt->get_result();
            if($result->num_rows!==0)
            {
                $stmt->close();
                $this->error("Package is Already purchased",400);
                return;
            }
            $stmt->close();
            //check if the amount entered matches the amount in the booking id
            $sql="SELECT total_price FROM booking where booking_id=?";
            $stmt=$this->connect->prepare($sql);
            if(!$stmt)
            {
                $this->error('Failed to prepare statement',500);
                return;
            }
            $stmt->bind_param("i",$Booking_id);
            if($stmt->execute())
            $result=$stmt->get_result();
            if($result->num_rows===0)
            {
                $stmt->close();
                $this->error('Invalid booking_id',401);
                return;
            }
            $price=$result->fetch_assoc()["total_price"];
            $stmt->close();
            if($amount!=$price)
            {
                $this->error("Amount entered is less than checkout price",400);
                return;
            }
            //make payment
            $status="";
            if($Method=="cash")
            {
                $status="pending";
            }
            else 
            {
                $status="completed";
            }
            $sql="INSERT INTO payment (booking_id,payment_method,status,reference,amount) Values(?,?,?,?,?)";
            $stmt=$this->connect->prepare($sql);
            $stmt->bind_param("isssd",$Booking_id,$Method,$status,$reference,$amount);
            if($stmt->execute())
            {
                $stmt->close();
                $sqs="UPDATE booking SET booking_status='confirmed' WHERE booking_id=?";
                $st=$this->connect->prepare($sqs);
                $st->bind_param("i",$Booking_id);
                if($st->execute())
                {
                    $st->close();
                    $this->success();
                    return;
                }
                $st->close();
                return;
            }
            $stmt->close();
            $this->error('Failed to Transfer',500);
            return;
        }
    
}
 
// Run API
$api = new API();
$api->handleRequest();
?> 