<?php
// ============================================================
// auth.php — Role-based access control guard
// Include at the top of every protected page
//
// Usage:
//   require_once '../auth.php';
//   requireRole('traveller');   // only travellers
//   requireRole('travel_agent'); // only agencies
// ============================================================

require_once __DIR__ . '/config.php';

function requireRole(string $requiredRole): void {
    global $mysqli;

    // 1. Get API key from cookie
    $apiKey = $_COOKIE['apiKey'] ?? '';

    if (empty($apiKey)) {
        redirectToLogin("No session found. Please log in.");
    }

    // 2. Look up user by api_key in database
    $stmt = $mysqli->prepare(
        "SELECT user_id, username, user_type FROM `user` WHERE api_key = ?"
    );
    $stmt->bind_param("s", $apiKey);
    $stmt->execute();
    $result = $stmt->get_result();
    $user   = $result->fetch_assoc();
    $stmt->close();

    if (!$user) {
        redirectToLogin("Invalid session. Please log in again.");
    }

    // 3. Check role matches
    if ($user['user_type'] !== $requiredRole) {
        redirectWrongRole($user['user_type']);
    }

    // 4. Make user available to the page
    $GLOBALS['authUser'] = $user;
}

function redirectToLogin(string $message = ""): void {
    $base = '/COS221-Tripistry';
    if ($message) {
        header("Location: {$base}/Tripistry/login.html?error=" . urlencode($message));
    } else {
        header("Location: {$base}/Tripistry/login.html");
    }
    exit;
}

function redirectWrongRole(string $actualRole): void {
    $base = '/COS221-Tripistry';
    if ($actualRole === 'traveller') {
        // Agency tried to access traveller page — send to agency dashboard
        header("Location: {$base}/agency/index.php?error=access_denied");
    } else {
        // Traveller tried to access agency page — send to traveller dashboard
        header("Location: {$base}/traveller/index.php?error=access_denied");
    }
    exit;
}