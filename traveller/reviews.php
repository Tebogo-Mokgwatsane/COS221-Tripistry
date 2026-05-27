<?php
require_once '../auth.php';
requireRole('traveller');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - My Bookings & Reviews</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/reviews.css">
</head>
<body>
    <?php include("navbar.php"); ?>

    <div class="section reviews-page">
        <div class="page-header">
            <p class="r">MY BOOKINGS</p>
            <h1>Bookings & Reviews</h1>
            <p class="sub">Leave a review for any package you have travelled on.</p>
        </div>

        <div class="bookings-list" id="bookings-list">
            <div class="loading" id="loading">
                <div class="spinner"></div>
                <p>Loading your bookings...</p>
            </div>
        </div>

        <div class="empty-state" id="empty-state" style="display:none;">
            <div>
                <img src="../img/icons/earth.svg" alt="no bookings">
            </div>
            <h2>No bookings yet</h2>
            <p>Once you book a package it will appear here for you to review.</p>
            <a href="index.php" class="cta-btn">Browse Packages</a>
        </div>
    </div>

    <!-- Review Modal -->
    <div class="modal-overlay" id="modal-overlay" style="display:none;">
        <div class="modal">
            <button class="modal-close" id="modal-close">&times;</button>
            <h2>Leave a Review</h2>
            <p id="modal-package-name" class="modal-package-name"></p>

            <div class="star-picker">
                <label>YOUR RATING</label>
                <div class="stars" id="star-picker">
                    <span class="star" data-value="1">&#9733;</span>
                    <span class="star" data-value="2">&#9733;</span>
                    <span class="star" data-value="3">&#9733;</span>
                    <span class="star" data-value="4">&#9733;</span>
                    <span class="star" data-value="5">&#9733;</span>
                </div>
                <p class="rating-label" id="rating-label">Select a rating</p>
            </div>

            <div class="modal-field">
                <label class="label">YOUR REVIEW</label>
                <textarea
                    id="review-comment"
                    placeholder="Tell other travellers about your experience..."
                    rows="5"
                    maxlength="1000"
                ></textarea>
                <p class="char-count"><span id="char-count">0</span>/1000</p>
            </div>

            <p class="modal-error" id="modal-error"></p>

            <button class="submit-btn" id="submit-review">
                Submit Review
            </button>
        </div>
    </div>

    <footer>
        &copy; 2026 Tripistry. All rights reserved.
    </footer>

    <script src="../scripts/reviews.js"></script>
</body>
</html>