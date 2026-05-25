/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: tripistry
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `accommodation`
--

DROP TABLE IF EXISTS `accommodation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `accommodation` (
  `acc_id` int(11) NOT NULL AUTO_INCREMENT,
  `dest_id` int(11) NOT NULL,
  `acc_name` varchar(100) NOT NULL,
  `acc_type` enum('Hotel','Hostel','B&B','Self-Catering','Resort','Guesthouse') NOT NULL,
  `rating` decimal(2,1) DEFAULT NULL CHECK (`rating` between 0.0 and 5.0),
  `price_per_night` decimal(10,2) NOT NULL CHECK (`price_per_night` >= 0),
  `description` text DEFAULT NULL,
  `img_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`acc_id`),
  KEY `dest_id` (`dest_id`),
  CONSTRAINT `1` FOREIGN KEY (`dest_id`) REFERENCES `destination` (`dest_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accommodation`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `accommodation` WRITE;
/*!40000 ALTER TABLE `accommodation` DISABLE KEYS */;
INSERT INTO `accommodation` VALUES
(1,1,'The Table Bay Hotel','Hotel',5.0,3500.00,'Five-star hotel at the V&A Waterfront with views of Table Mountain.',NULL),
(2,1,'Long Street Backpackers','Hostel',3.5,350.00,'Budget-friendly hostel in the heart of Cape Town.',NULL),
(3,2,'Zanzibar Beach Resort','Resort',4.5,2800.00,'Beachfront resort on the turquoise shores of Zanzibar.',NULL),
(4,4,'Nairobi Serena Hotel','Hotel',4.5,4200.00,'Luxury hotel in the heart of Nairobi near Uhuru Park.',NULL);
/*!40000 ALTER TABLE `accommodation` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `accommodationaddress`
--

DROP TABLE IF EXISTS `accommodationaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `accommodationaddress` (
  `acc_id` int(11) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`acc_id`,`city`,`street`),
  CONSTRAINT `1` FOREIGN KEY (`acc_id`) REFERENCES `accommodation` (`acc_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accommodationaddress`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `accommodationaddress` WRITE;
/*!40000 ALTER TABLE `accommodationaddress` DISABLE KEYS */;
INSERT INTO `accommodationaddress` VALUES
(1,'Quay 6, V&A Waterfront','Cape Town','South Africa','8001'),
(2,'209 Long Street','Cape Town','South Africa','8001'),
(3,'Kiwengwa Beach','Zanzibar','Tanzania',NULL),
(4,'Kenyatta Avenue','Nairobi','Kenya','00100');
/*!40000 ALTER TABLE `accommodationaddress` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `attraction`
--

DROP TABLE IF EXISTS `attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attraction` (
  `att_id` int(11) NOT NULL AUTO_INCREMENT,
  `dest_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `fee` decimal(10,2) DEFAULT 0.00 CHECK (`fee` >= 0),
  `description` text DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL CHECK (`rating` between 0.0 and 5.0),
  `opening_time` time DEFAULT NULL,
  `closing_time` time DEFAULT NULL,
  `img_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`att_id`),
  KEY `dest_id` (`dest_id`),
  CONSTRAINT `1` FOREIGN KEY (`dest_id`) REFERENCES `destination` (`dest_id`) ON UPDATE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`closing_time` > `opening_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attraction`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `attraction` WRITE;
/*!40000 ALTER TABLE `attraction` DISABLE KEYS */;
INSERT INTO `attraction` VALUES
(1,1,'Table Mountain Aerial Cableway','Nature',390.00,'Iconic cable car ride to the top of Table Mountain.',4.9,'08:00:00','18:00:00',NULL),
(2,1,'Robben Island','Cultural',450.00,'Historic island and UNESCO World Heritage Site.',4.7,'09:00:00','17:00:00',NULL),
(3,2,'Stone Town Tour','Cultural',80.00,'Guided walking tour through Zanzibar\'s historic Stone Town.',4.6,'08:00:00','20:00:00',NULL),
(4,4,'Nairobi National Park','Wildlife',600.00,'Game reserve within the city limits of Nairobi.',4.8,'06:00:00','18:00:00',NULL);
/*!40000 ALTER TABLE `attraction` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `attractionaddress`
--

DROP TABLE IF EXISTS `attractionaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attractionaddress` (
  `att_id` int(11) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`att_id`,`city`,`street`),
  CONSTRAINT `1` FOREIGN KEY (`att_id`) REFERENCES `attraction` (`att_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attractionaddress`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `attractionaddress` WRITE;
/*!40000 ALTER TABLE `attractionaddress` DISABLE KEYS */;
INSERT INTO `attractionaddress` VALUES
(1,'Tafelberg Road','Cape Town','South Africa','8001'),
(2,'V&A Waterfront','Cape Town','South Africa','8001'),
(3,'Stone Town','Zanzibar','Tanzania',NULL),
(4,'Langata Road','Nairobi','Kenya','00100');
/*!40000 ALTER TABLE `attractionaddress` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `traveller_id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `num_travellers` int(11) NOT NULL CHECK (`num_travellers` >= 1),
  `total_price` decimal(10,2) NOT NULL CHECK (`total_price` >= 0),
  `booking_status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `booking_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`booking_id`),
  KEY `traveller_id` (`traveller_id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `1` FOREIGN KEY (`traveller_id`) REFERENCES `traveller` (`traveller_id`),
  CONSTRAINT `2` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES
(1,3,1,1,15999.00,'confirmed','2026-05-13 00:08:15'),
(2,4,3,6,252000.00,'confirmed','2026-05-13 00:08:15'),
(3,5,2,2,57000.00,'pending','2026-05-13 00:08:15');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `businessregistration`
--

DROP TABLE IF EXISTS `businessregistration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `businessregistration` (
  `reg_id` int(11) NOT NULL AUTO_INCREMENT,
  `reg_number` varchar(50) NOT NULL,
  `status` enum('valid','taken') NOT NULL DEFAULT 'valid',
  `used_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`reg_id`),
  UNIQUE KEY `uq_reg_number` (`reg_number`),
  KEY `fk_breg_agent` (`used_by`),
  CONSTRAINT `fk_breg_agent` FOREIGN KEY (`used_by`) REFERENCES `travelagent` (`agent_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `businessregistration`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `businessregistration` WRITE;
/*!40000 ALTER TABLE `businessregistration` DISABLE KEYS */;
INSERT INTO `businessregistration` VALUES
(1,'SA-2023-001234','valid',NULL),
(2,'SA-2023-005678','valid',NULL),
(3,'SA-2023-009012','valid',NULL),
(4,'SA-2024-001111','valid',NULL),
(5,'SA-2024-002222','valid',NULL),
(6,'SA-2024-003333','valid',NULL),
(7,'SA-2024-004444','valid',NULL),
(8,'SA-2024-005555','valid',NULL),
(9,'SA-2024-006666','valid',NULL),
(10,'SA-2024-007777','valid',NULL),
(11,'SA-2025-000001','valid',NULL),
(12,'SA-2025-000002','valid',NULL),
(13,'SA-2025-000003','valid',NULL),
(14,'SA-2025-000004','valid',NULL),
(15,'SA-2025-000005','valid',NULL);
/*!40000 ALTER TABLE `businessregistration` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `destination`
--

DROP TABLE IF EXISTS `destination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `destination` (
  `dest_id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `img_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`dest_id`),
  UNIQUE KEY `uq_destination` (`city`,`country`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `destination` WRITE;
/*!40000 ALTER TABLE `destination` DISABLE KEYS */;
INSERT INTO `destination` VALUES
(1,'Cape Town','South Africa','Mother City - mountains, beaches and world-class cuisine.',NULL),
(2,'Zanzibar','Tanzania','Tropical island paradise with white sandy beaches and spice history.',NULL),
(3,'Johannesburg','South Africa','The city of gold - vibrant culture and urban energy.',NULL),
(4,'Nairobi','Kenya','Gateway to the Masai Mara and East African wildlife.',NULL);
/*!40000 ALTER TABLE `destination` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `favourite`
--

DROP TABLE IF EXISTS `favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `favourite` (
  `favourite_id` int(11) NOT NULL AUTO_INCREMENT,
  `traveller_id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`favourite_id`),
  UNIQUE KEY `uq_favourite` (`traveller_id`,`package_id`),
  KEY `fk_favourite_package` (`package_id`),
  CONSTRAINT `fk_favourite_package` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_favourite_traveller` FOREIGN KEY (`traveller_id`) REFERENCES `traveller` (`traveller_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favourite`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `favourite` WRITE;
/*!40000 ALTER TABLE `favourite` DISABLE KEYS */;
/*!40000 ALTER TABLE `favourite` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flight_id` int(11) NOT NULL AUTO_INCREMENT,
  `airline_name` varchar(100) NOT NULL,
  `departure_airport` char(3) NOT NULL,
  `arrival_airport` char(3) NOT NULL,
  `dept_date` datetime NOT NULL,
  `arrival_datetime` datetime NOT NULL,
  `classes` set('Economy','Business','First') NOT NULL DEFAULT 'Economy',
  `price` decimal(10,2) NOT NULL CHECK (`price` >= 0),
  `img_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`arrival_datetime` > `dept_date`),
  CONSTRAINT `CONSTRAINT_2` CHECK (`departure_airport` <> `arrival_airport`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES
(1,'South African Airways','JNB','CPT','2026-07-10 08:00:00','2026-07-10 10:00:00','Economy,Business',1200.00,NULL),
(2,'Kenya Airways','JNB','NBO','2026-08-01 06:30:00','2026-08-01 11:00:00','Economy',3500.00,NULL),
(3,'Precision Air','DAR','ZNZ','2026-08-05 13:00:00','2026-08-05 14:00:00','Economy',850.00,NULL),
(4,'Airlink','CPT','JNB','2026-07-17 16:00:00','2026-07-17 18:00:00','Economy,Business',1100.00,NULL);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `grouppackage`
--

DROP TABLE IF EXISTS `grouppackage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `grouppackage` (
  `package_id` int(11) NOT NULL,
  `min_group_size` int(11) NOT NULL CHECK (`min_group_size` >= 2),
  `max_group_size` int(11) NOT NULL,
  `status` enum('open','closed','full') NOT NULL DEFAULT 'open',
  PRIMARY KEY (`package_id`),
  CONSTRAINT `1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`max_group_size` >= `min_group_size`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grouppackage`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `grouppackage` WRITE;
/*!40000 ALTER TABLE `grouppackage` DISABLE KEYS */;
INSERT INTO `grouppackage` VALUES
(2,4,12,'open'),
(3,6,16,'open');
/*!40000 ALTER TABLE `grouppackage` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `package` (
  `package_id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` int(11) NOT NULL,
  `dest_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL CHECK (`price` > 0),
  `expiry_date` date NOT NULL,
  `quantity` int(11) NOT NULL CHECK (`quantity` >= 0),
  `image_url` varchar(255) NOT NULL,
  `status` enum('active','inactive','sold_out') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`package_id`),
  KEY `agent_id` (`agent_id`),
  KEY `dest_id` (`dest_id`),
  CONSTRAINT `1` FOREIGN KEY (`agent_id`) REFERENCES `travelagent` (`agent_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`dest_id`) REFERENCES `destination` (`dest_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES
(1,1,1,'Cape Town Explorer','7-day Cape Town experience including Table Mountain, wine estates and coastal drives.',15999.00,'2026-09-30',20,'active','2026-05-13 00:04:36'),
(2,1,2,'Zanzibar Island Escape','10-day tropical getaway to the spice island with beach resorts and cultural tours.',28500.00,'2026-10-31',15,'active','2026-05-13 00:04:36'),
(3,2,4,'Nairobi Safari Adventure','8-day Kenyan safari including Nairobi National Park and the Masai Mara.',42000.00,'2026-11-30',10,'active','2026-05-13 00:04:36'),
(4,2,1,'Cape Town Budget Break','5-day budget-friendly Cape Town trip for solo backpackers.',8500.00,'2026-08-31',30,'active','2026-05-13 00:04:36');
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `packageaccommodation`
--

DROP TABLE IF EXISTS `packageaccommodation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `packageaccommodation` (
  `package_id` int(11) NOT NULL,
  `acc_id` int(11) NOT NULL,
  PRIMARY KEY (`package_id`,`acc_id`),
  KEY `acc_id` (`acc_id`),
  CONSTRAINT `1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`acc_id`) REFERENCES `accommodation` (`acc_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packageaccommodation`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `packageaccommodation` WRITE;
/*!40000 ALTER TABLE `packageaccommodation` DISABLE KEYS */;
INSERT INTO `packageaccommodation` VALUES
(1,1),
(4,2),
(2,3),
(3,4);
/*!40000 ALTER TABLE `packageaccommodation` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `packageactivity`
--

DROP TABLE IF EXISTS `packageactivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `packageactivity` (
  `package_id` int(11) NOT NULL,
  `day_number` int(11) NOT NULL CHECK (`day_number` >= 1),
  `activity_name` varchar(150) NOT NULL,
  `activity_time` time DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`package_id`,`day_number`,`activity_name`),
  CONSTRAINT `1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packageactivity`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `packageactivity` WRITE;
/*!40000 ALTER TABLE `packageactivity` DISABLE KEYS */;
INSERT INTO `packageactivity` VALUES
(1,1,'Arrival & Hotel Check-in','14:00:00','Arrive at CPT airport, transfer to hotel.'),
(1,2,'Table Mountain Cable Car','09:00:00','Morning visit to Table Mountain.'),
(1,2,'V&A Waterfront Lunch','13:00:00','Lunch at the Waterfront.'),
(1,3,'Robben Island Ferry Tour','09:30:00','Full morning guided tour of Robben Island.'),
(1,4,'Cape Winelands Day Trip','08:00:00','Wine tasting in Stellenbosch and Franschhoek.'),
(2,1,'Arrival in Zanzibar','12:00:00','Fly into ZNZ, transfer to beach resort.'),
(2,2,'Stone Town Walking Tour','09:00:00','Guided tour of historic Stone Town.'),
(2,3,'Spice Farm Tour','10:00:00','Visit a traditional Zanzibari spice plantation.'),
(2,5,'Snorkelling at Mnemba Atoll','08:30:00','Guided snorkelling trip to the coral reef.'),
(3,1,'Nairobi City Arrival','15:00:00','Airport pickup, hotel check-in.'),
(3,2,'Nairobi National Park Drive','06:00:00','Early morning game drive inside the city park.'),
(3,3,'Carnivore Restaurant Dinner','19:00:00','Welcome dinner at the famous Carnivore.'),
(3,4,'Depart for Masai Mara','07:00:00','Road transfer to Masai Mara camp.');
/*!40000 ALTER TABLE `packageactivity` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `packageattraction`
--

DROP TABLE IF EXISTS `packageattraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `packageattraction` (
  `package_id` int(11) NOT NULL,
  `att_id` int(11) NOT NULL,
  PRIMARY KEY (`package_id`,`att_id`),
  KEY `att_id` (`att_id`),
  CONSTRAINT `1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`att_id`) REFERENCES `attraction` (`att_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packageattraction`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `packageattraction` WRITE;
/*!40000 ALTER TABLE `packageattraction` DISABLE KEYS */;
/*!40000 ALTER TABLE `packageattraction` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `packageflight`
--

DROP TABLE IF EXISTS `packageflight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `packageflight` (
  `package_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  PRIMARY KEY (`package_id`,`flight_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packageflight`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `packageflight` WRITE;
/*!40000 ALTER TABLE `packageflight` DISABLE KEYS */;
INSERT INTO `packageflight` VALUES
(1,1),
(3,2),
(2,3),
(1,4);
/*!40000 ALTER TABLE `packageflight` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `packagerestaurant`
--

DROP TABLE IF EXISTS `packagerestaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `packagerestaurant` (
  `package_id` int(11) NOT NULL,
  `res_id` int(11) NOT NULL,
  PRIMARY KEY (`package_id`,`res_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packagerestaurant`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `packagerestaurant` WRITE;
/*!40000 ALTER TABLE `packagerestaurant` DISABLE KEYS */;
INSERT INTO `packagerestaurant` VALUES
(1,1),
(1,2),
(2,3),
(3,4);
/*!40000 ALTER TABLE `packagerestaurant` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `payment_method` enum('Credit Card','Debit Card','EFT','PayPal','Cash') NOT NULL,
  `status` enum('pending','completed','failed','refunded') NOT NULL DEFAULT 'pending',
  `payment_date` datetime NOT NULL DEFAULT current_timestamp(),
  `reference` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL CHECK (`amount` > 0),
  PRIMARY KEY (`trans_id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES
(1,1,'Credit Card','completed','2026-05-13 00:08:36','TXN-2026-001',15999.00),
(2,2,'EFT','completed','2026-05-13 00:08:36','TXN-2026-002',252000.00),
(3,3,'Credit Card','pending','2026-05-13 00:08:36','TXN-2026-003',57000.00);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `res_id` int(11) NOT NULL AUTO_INCREMENT,
  `dest_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `fee` decimal(10,2) DEFAULT 0.00 CHECK (`fee` >= 0),
  `description` text DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL CHECK (`rating` between 0.0 and 5.0),
  `img_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  KEY `dest_id` (`dest_id`),
  CONSTRAINT `1` FOREIGN KEY (`dest_id`) REFERENCES `destination` (`dest_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES
(1,1,'The Test Kitchen','Fine Dining',850.00,'Award-winning restaurant in the Old Biscuit Mill.',4.9,NULL),
(2,1,'Mama Africa','Local Cuisine',250.00,'Traditional African cuisine in the heart of Cape Town.',4.5,NULL),
(3,2,'The Rock Restaurant','Seafood',600.00,'Unique restaurant built on a rock in the Indian Ocean.',4.8,NULL),
(4,4,'Carnivore Restaurant','Barbecue',750.00,'Famous Nairobi restaurant serving exotic meats.',4.6,NULL);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `restaurantaddress`
--

DROP TABLE IF EXISTS `restaurantaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurantaddress` (
  `res_id` int(11) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`res_id`,`city`,`street`),
  CONSTRAINT `1` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurantaddress`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `restaurantaddress` WRITE;
/*!40000 ALTER TABLE `restaurantaddress` DISABLE KEYS */;
INSERT INTO `restaurantaddress` VALUES
(1,'375 Albert Road, Woodstock','Cape Town','South Africa','7925'),
(2,'178 Long Street','Cape Town','South Africa','8001'),
(3,'Michamvi Pingwe','Zanzibar','Tanzania',NULL),
(4,'Langata Road','Nairobi','Kenya','00506');
/*!40000 ALTER TABLE `restaurantaddress` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `traveller_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `rating` tinyint(4) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `review_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `uq_review` (`traveller_id`,`agent_id`,`package_id`),
  KEY `agent_id` (`agent_id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `1` FOREIGN KEY (`traveller_id`) REFERENCES `traveller` (`traveller_id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`agent_id`) REFERENCES `travelagent` (`agent_id`) ON DELETE CASCADE,
  CONSTRAINT `3` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES
(1,3,1,1,5,'Absolutely incredible trip! Table Mountain was breathtaking. Sunway organised everything perfectly.','2026-05-13 00:08:50'),
(2,4,2,3,4,'Great safari experience, the Masai Mara was unforgettable. Logistics could have been smoother.','2026-05-13 00:08:50'),
(3,5,1,2,5,'Zanzibar was paradise. The Rock restaurant dinner was the highlight of our trip.','2026-05-13 00:08:50');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `travelagent`
--

DROP TABLE IF EXISTS `travelagent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `travelagent` (
  `agent_id` int(11) NOT NULL,
  `agency_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `registration_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`agent_id`),
  UNIQUE KEY `registration_number` (`registration_number`),
  CONSTRAINT `1` FOREIGN KEY (`agent_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travelagent`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `travelagent` WRITE;
/*!40000 ALTER TABLE `travelagent` DISABLE KEYS */;
INSERT INTO `travelagent` VALUES
(1,'Sunway Travels','+27 11 234 5678','www.sunwaytravels.co.za',NULL),
(2,'Globe Hopper Tours','+27 21 987 6543','www.globehopper.co.za',NULL);
/*!40000 ALTER TABLE `travelagent` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `traveller`
--

DROP TABLE IF EXISTS `traveller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `traveller` (
  `traveller_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `type` enum('Solo','Group','Family','Couple') DEFAULT 'Solo',
  PRIMARY KEY (`traveller_id`),
  CONSTRAINT `1` FOREIGN KEY (`traveller_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traveller`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `traveller` WRITE;
/*!40000 ALTER TABLE `traveller` DISABLE KEYS */;
INSERT INTO `traveller` VALUES
(3,'Katlego','Tau','+27 72 111 2222','Solo'),
(4,'Thabo','Mokoena','+27 83 333 4444','Group'),
(5,'Lerato','Dlamini','+27 79 555 6666','Couple');
/*!40000 ALTER TABLE `traveller` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `user_type` enum('traveller','travel_agent') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `api_key` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `api_key` (`api_key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'sunway_travels','info@sunwaytravels.co.za','f44d1ac9bf0c69b083380b86dbdf3b73797150e3cca4820ac399f7917e607647','travel_agent','2026-05-12 23:59:45','93cfc0dfcd553d526a258b70ec7bfef7'),
(2,'globehopper','hello@globehopper.co.za','d423f9d5a1398e656b5d0e97f76dac25ca901542daa1018a88d34dfccb4a8de9','travel_agent','2026-05-12 23:59:45','97f3affa44b008274ae6533c953a1f49'),
(3,'katlego_t','katlego@mail.com','9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c','traveller','2026-05-12 23:59:45','4a22690e858b02ddc4f197b07ee5448a'),
(4,'thabo_m','thabo@mail.com','1d4598d1949b47f7f211134b639ec32238ce73086a83c2f745713b3f12f817e5','traveller','2026-05-12 23:59:45','b73dcdf83b331d060e57cdb92ea37ddd'),
(5,'lerato_d','lerato@mail.com','9dbd5c893b5b573a1aa909c8cade58df194310e411c590d9fb0d63431841fd67','traveller','2026-05-12 23:59:45','9c939e4d026ad78491fbe36e54d8d80c');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-24 15:54:25
