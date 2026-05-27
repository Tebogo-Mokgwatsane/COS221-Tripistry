<?php
require_once '../auth.php';
requireRole('travel_agent');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tripistry - Agency Dashboard</title>
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
                <h1>Welcome back, <span id="agency-name"></span></h1>
                <p class="sub">Manage your packages and grow your business.</p>
            </div>
            <button class="create-btn" id="create-package-btn">
                <img src="/img/icons/plus.svg" alt="plus">
                Create Package
            </button>
        </div>

        <!-- Stats row -->
        <div class="stats-row">
            <div class="stat-card">
                <p class="stat-label">TOTAL PACKAGES</p>
                <p class="stat-value" id="stat-packages">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">TOTAL BOOKINGS</p>
                <p class="stat-value" id="stat-bookings">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">AVG RATING</p>
                <p class="stat-value" id="stat-rating">—</p>
            </div>
            <div class="stat-card">
                <p class="stat-label">TOTAL REVIEWS</p>
                <p class="stat-value" id="stat-reviews">—</p>
            </div>
        </div>

        <!-- Packages section -->
        <div class="section-header">
            <h2>My Packages</h2>
            <div class="filter-row">
                <div class="search-container">
                    <img src="../img/icons/search.svg" alt="Search">
                    <input type="text" id="search-bar" placeholder="Search packages...">
                </div>
                <select id="status-filter">
                    <option value="">All Statuses</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                    <option value="sold_out">Sold Out</option>
                </select>
            </div>
        </div>

        <!-- Loading -->
        <div class="loading" id="loading">
            <div class="spinner"></div>
            <p>Loading your packages...</p>
        </div>

        <!-- Packages table -->
        <div class="packages-table-wrap" id="packages-table-wrap" style="display:none;">
            <table class="packages-table">
                <thead>
                    <tr>
                        <th>Package</th>
                        <th>Destination</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Rating</th>
                        <th>Expires</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="packages-tbody"></tbody>
            </table>
        </div>

        <!-- Empty state -->
        <div class="empty-state" id="empty-state" style="display:none;">
            <div>
                <img src="../img/icons/badge-check.svg" alt="no packages">
            </div>
            <h2>No packages yet</h2>
            <p>Create your first travel package to get started.</p>
            <button class="create-btn" onclick="document.getElementById('create-package-btn').click()">
                <img src="../img/icons/plus.svg" alt="plus">
                Create Package
            </button>
        </div>

    </div>

    <!-- Create / Edit Package Modal -->
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
    <img id="pkg-image-preview" src="" alt="Preview" 
         style="display:none;margin-top:8px;width:100%;max-height:180px;object-fit:cover;border-radius:8px;">
    <p style="font-size:12px;color:gray;margin-top:4px;">JPG, PNG or WebP. Max 2MB.</p>
</div>
                <!-- Group Package -->
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
            <p style="color:gray; font-size:14px; margin-bottom:24px;">
                This will permanently delete the package and all associated data. This cannot be undone.
            </p>
            <div class="modal-actions">
                <button class="cancel-btn" id="delete-cancel">Cancel</button>
                <button class="delete-confirm-btn" id="delete-confirm">Delete</button>
            </div>
        </div>
    </div>

    <script src="../scripts/agency.js"></script>
<script>
document.getElementById("pkg-image").addEventListener("change", function () {
    const preview = document.getElementById("pkg-image-preview");
    const file = this.files[0];
    if (file) {
        preview.src = URL.createObjectURL(file);
        preview.style.display = "block";
    } else {
        preview.src = "";
        preview.style.display = "none";
    }
});
</script>
</body>
</html>