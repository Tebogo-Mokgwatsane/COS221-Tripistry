

<?php
require_once '../auth.php';
requireRole('travel_agent');
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - My Packages</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/agency.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
</head>
<body>
    <?php include("agency_navbar.php"); ?>

    <div class="container agency-dashboard">

        <!-- Header -->
        <div class="dashboard-header">
            <div>
                <h1>My Packages</h1>
                <p class="sub">Create, edit and manage your travel packages.</p>
            </div>
            <button class="create-btn" id="create-package-btn">
                <img src="../img/icons/plus.svg" alt="plus">
                Create Package
            </button>
        </div>

        <!-- Filter bar -->
        <div class="filter-bar">
            <div class="search-container">
                <img src="../img/icons/search.svg" alt="Search">
                <input type="text" id="search-bar" placeholder="Search packages, destinations...">
            </div>
            <select id="dest-filter">
                <option value="">All Destinations</option>
            </select>
            <select id="status-filter">
                <option value="">All Statuses</option>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
                <option value="sold_out">Sold Out</option>
            </select>
            <select id="sort-filter">
                <option value="created_at-DESC">Newest First</option>
                <option value="price-ASC">Price: Low to High</option>
                <option value="price-DESC">Price: High to Low</option>
                <option value="avg_rating-DESC">Top Rated</option>
            </select>
            <button class="create-btn" id="apply-btn" style="padding:9px 16px;">Apply</button>
            <button class="cancel-btn" id="clear-btn">Clear</button>
        </div>

        <!-- Results count -->
        <p class="results-count" id="results-count"></p>

        <!-- Loading -->
        <div class="loading" id="loading">
            <div class="spinner"></div>
            <p>Loading your packages...</p>
        </div>

        <!-- Table -->
        <div class="packages-table-wrap" id="packages-table-wrap" style="display:none;">
            <table class="packages-table">
                <thead>
                    <tr>
                        <th>Package</th>
                        <th>Destination</th>
                        <th>Price</th>
                        <th>Qty Left</th>
                        <th>Status</th>
                        <th>Rating</th>
                        <th>Bookings</th>
                        <th>Expires</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="packages-tbody"></tbody>
            </table>
        </div>

        <!-- Empty state -->
        <div class="empty-state" id="empty-state" style="display:none;">
            <div><img src="../img/icons/earth.svg" alt="no packages"></div>
            <h2>No packages found</h2>
            <p>Try adjusting your filters or create your first package.</p>
            <button class="create-btn" onclick="document.getElementById('create-package-btn').click()">
                <img src="../img/icons/plus.svg" alt="plus">
                Create Package
            </button>
        </div>

    </div>

    <!-- Create / Edit Modal -->
    <div class="modal-overlay" id="modal-overlay" style="display:none;">
        <div class="modal">
            <button class="modal-close" id="modal-close">&times;</button>
            <h2 id="modal-title">Create Package</h2>

            <div class="modal-grid">
                
                <div class="modal-field full">
                    <label class="label">PACKAGE TITLE</label>
                    <input type="text" id="pkg-title" placeholder="e.g. Cape Town Explorer">
                </div>
                <div class="modal-field">
                    <label class="label">DESTINATION</label>
                    <select id="pkg-dest">
                        <option value="">Select destination...</option>
                    </select>
                </div>
                
                <div class="modal-field">
                    <label class="label">PRICE (R)</label>
                    <input type="number" id="pkg-price" placeholder="e.g. 15999" min="0">
                </div>
                <div class="modal-field">
                    <label class="label">QUANTITY</label>
                    <input type="number" id="pkg-quantity" placeholder="e.g. 20" min="0">
                </div>
                <div class="modal-field">
                    <label class="label">EXPIRY DATE</label>
                    <input type="date" id="pkg-expiry">
                </div>
                <div class="modal-field">
                    <label class="label">STATUS</label>
                    <select id="pkg-status">
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                        <option value="sold_out">Sold Out</option>
                    </select>
                </div>
                <div class="modal-field full">
                    <label class="label">DESCRIPTION</label>
                    <textarea id="pkg-desc" placeholder="Describe your package..." rows="4"></textarea>
                </div>
                <div class="modal-field full">
    <label class="label">PACKAGE IMAGE</label>
    <input type="file" id="pkg-image" accept="image/*">
    <p style="font-size:12px;color:gray;margin-top:4px;">JPG, PNG or WebP. Max 2MB.</p>
</div>
                <div class="modal-field full">
                    <div class="toggle-row">
                        <label class="label">GROUP PACKAGE</label>
                        <label class="toggle">
                            <input type="checkbox" id="pkg-is-group">
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                </div>
                <div class="group-fields" id="group-fields" style="display:none;">
                    <div class="modal-field">
                        <label class="label">MIN GROUP SIZE</label>
                        <input type="number" id="pkg-min-group" placeholder="e.g. 4" min="2">
                    </div>
                    <div class="modal-field">
                        <label class="label">MAX GROUP SIZE</label>
                        <input type="number" id="pkg-max-group" placeholder="e.g. 12">
                    </div>
                </div>
            </div>

            <p class="modal-error" id="modal-error"></p>

            <div class="modal-actions">
                <button class="cancel-btn" id="modal-cancel">Cancel</button>
                <button class="submit-btn" id="modal-submit">Create Package</button>
            </div>
        </div>
    </div>

    <!-- Delete Confirm Modal -->
    <div class="modal-overlay" id="delete-overlay" style="display:none;">
        <div class="modal modal-sm">
            <h2>Delete Package?</h2>
            <p class="modal-package-name" id="delete-pkg-name"></p>
            <p style="color:gray;font-size:14px;margin-bottom:24px;">
                This will permanently delete the package. This cannot be undone.
            </p>
            <div class="modal-actions">
                <button class="cancel-btn" id="delete-cancel">Cancel</button>
                <button class="delete-confirm-btn" id="delete-confirm">Delete</button>
            </div>
        </div>
    </div>

    <script src="../scripts/agency_packages.js"></script>
</body>
</html>