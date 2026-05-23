<?php

// $host = "sql103.infinityfree.com";
// $dbname = "if0_41937671_tripistry";//Since were hosting and testing on infinityfree.com
// $user = "if0_41937671";

// if (defined('USE_LOCAL_CONFIG') && USE_LOCAL_CONFIG) {
    // Path if api.php is running
    // $pass = trim(file_get_contents("DatabasePassword"));
// } else {
    // Default path for other files - adjustable directory
    // $pass = trim(file_get_contents("../DatabasePassword"));
// }

// if (empty($pass)) {
    // die("Error: Could not read database password file.");
// }

// $mysqli = new mysqli($host, $user, $pass, $dbname);

// if ($mysqli->connect_error) {
    // die("Database connection failed: " . $mysqli->connect_error);
// }

// $mysqli->set_charset("utf8mb4");

$env = parse_ini_file(__DIR__ . '/.env');

// Store each value as an environment variable
foreach ($env as $key => $value) {
    putenv("$key=$value");
}

class Database {
        private static $instance = null;
        private $conn;
        
        private $host = "wheatley.cs.up.ac.za";
        private $username = "u24589137";
        private $password = "SEERBV4HOYEHJICMVJ5NZE6RLDODGYL5";
        private $db_name = "u24589137_abc_flights";

        private function __construct(){
            $this->conn = mysqli_connect($this->host, $this->username, $this->password, $this->db_name);
            if (!$this->conn){
                die("Connection failed: " .mysqli_connect_error());
            }
        }

        public static function getInstance(){
            if (self::$instance === null){
                self::$instance= new Database();
            }
            return self::$instance;
        }

        public function getConnection(){
            return $this->conn;
        }
    }


?>
