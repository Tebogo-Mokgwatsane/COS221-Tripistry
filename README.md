# Tripistry - Travel Package Platform

**COS 221 Practical Assignment 5 2026**  
**University of Pretoria**  
**Group Project**

# Project Overview

Tripistry is a comprehensive travel booking platform that connects travellers with verified travel agencies. It allows users to browse, compare, search and book travel packages while providing agencies with tools to manage their offerings.

The system enforces two distinct user roles:
- **Travellers** – Browse, book, review, and save packages
- **Travel Agencies** – Create, manage packages and group trips

# Features Implemented
## Traveller Features
- Browse destinations, flights, accommodations, attractions, and restaurants
- Real-time search across packages and destinations
- Advanced filtering (price, package type, availability)
- Book travel packages
- Save favourite packages
- Leave reviews and ratings regarding packages
- View booking history

## Agency Features
- Verified business registration system
- Create and manage travel packages
- Link packages with destinations, flights, accommodations, attractions, and restaurants
- View bookings and reviews

  ## Browsing Features
- Added Traveller Browsing for destinations, flights, accommodations, attractions, and restaurants
- Extra Features were made for the UI
- Filtering according to specific attributes
- Create and manage travel packages

## General
- Secure login with role-based access
- Responsive, modern UI
- Clean clear separation between Traveller and Agency interfaces

# Technologies Used

- **Backend**: PHP 8+
- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Database**: MariaDB (MySQL)
- **Version Control**: Git + GitHub
- **Styling**: Custom CSS

# Setup Instructions
## 1. Prerequisites
- XAMPP (Apache + MariaDB)
- PHP 8.2+
- Git

## 2. Installation
1. Clone or extract the project into:
C:\xampp\htdocs\Tripistry\

2. Import the database:
- Open phpMyAdmin
- Create database `tripistry`
- Import `tripistry_dump.sql`

3. Configure database connection:
- Copy `.env.example` to `.env`
- Update credentials in `.env`

4. Start XAMPP:
- Start **Apache**
- Start **MySQL**

5. Access the application:
- Open browser: `http://localhost/Tripistry/`

# Default Test Accounts
**Traveller:**
- Email: `katlego@mail.com`
- Password: `pass123`

**Agency:**
- Email: `info@sunwaytravels.co.za`
- Password: `agent123`

# Git Repository
**Repository**: https://github.com/Tebogo-Mokgwatsane/COS221-Tripistry/
**Branching Strategy**: Main + Feature branches

# Assumptions & Decisions
- Used separate tables for `traveller` and `travelagent` linked to `user`
- Implemented real-time search with debounced input
- Used SHA-256 for password hashing
- Added `businessregistration` table for agency verification

# Future Enhancements
- Recommendation engine
- Interactive map integration
- Payment gateway simulation
- Advanced group trip matching algorithm

**Submitted as part of COS221 Practical Assignment 5 2026**  

# Site Demo Link
**Link to our project**:https://tripistry.page.gd/
