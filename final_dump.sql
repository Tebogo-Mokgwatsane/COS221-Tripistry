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
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(4,4,'Nairobi Serena Hotel','Hotel',4.5,4200.00,'Luxury hotel in the heart of Nairobi near Uhuru Park.',NULL),
(5,1,'Mount Nelson, A Belmond Hotel, Cape Town','Hotel',5.0,6500.00,'Iconic luxury hotel in Gardens, suitable for premium Cape Town packages.',NULL),
(6,1,'Cape Grace, A Fairmont Managed Hotel','Hotel',5.0,7200.00,'Luxury waterfront hotel at the V&A Waterfront.',NULL),
(7,1,'One&Only Cape Town','Resort',5.0,7800.00,'Luxury resort-style hotel in the V&A Waterfront.',NULL),
(8,1,'The Silo Hotel','Hotel',5.0,9500.00,'Premium boutique hotel above the Zeitz MOCAA precinct.',NULL),
(9,1,'Taj Cape Town','Hotel',5.0,4200.00,'Luxury city hotel close to Company Gardens and central attractions.',NULL),
(10,1,'Radisson RED Cape Town V&A Waterfront','Hotel',4.5,3100.00,'Modern hotel in the Silo District near the waterfront.',NULL),
(11,1,'AC Hotel by Marriott Cape Town Waterfront','Hotel',4.5,2900.00,'Waterfront-area hotel suitable for business and leisure travellers.',NULL),
(12,1,'President Hotel','Hotel',4.5,2600.00,'Seaside hotel in Bantry Bay near beaches and restaurants.',NULL),
(13,1,'Hotel Verde Cape Town Airport','Hotel',4.0,2100.00,'Airport hotel convenient for early flights and stopovers.',NULL),
(14,1,'Southern Sun Waterfront Cape Town','Hotel',4.0,2300.00,'Central hotel near the V&A Waterfront and Cape Town CBD.',NULL),
(15,1,'The Commodore Hotel','Hotel',4.0,2800.00,'Hotel near the V&A Waterfront, suitable for sightseeing packages.',NULL),
(16,1,'Victoria & Alfred Hotel','Hotel',4.5,3900.00,'Historic waterfront hotel close to harbour attractions.',NULL),
(17,1,'Lagoon Beach Hotel & Spa','Hotel',4.0,2400.00,'Beachfront hotel with views toward Table Mountain.',NULL),
(18,1,'The Westin Cape Town','Hotel',5.0,4300.00,'Large city hotel next to the Cape Town International Convention Centre.',NULL),
(19,1,'Protea Hotel Fire & Ice Cape Town','Hotel',4.0,2200.00,'Trendy hotel close to Kloof Street and the city centre.',NULL),
(20,1,'Gorgeous George by Design Hotels','Hotel',4.5,3600.00,'Boutique design hotel in Cape Town CBD.',NULL),
(21,1,'City Lodge Hotel V&A Waterfront','Hotel',3.5,1800.00,'Mid-range hotel close to the waterfront and city attractions.',NULL),
(22,1,'Hyatt Regency Cape Town','Hotel',4.0,2500.00,'City hotel in central Cape Town near Bo-Kaap and CBD attractions.',NULL),
(23,1,'Pepperclub Hotel','Hotel',5.0,3300.00,'Luxury city hotel with access to dining and nightlife areas.',NULL),
(24,3,'Four Seasons Hotel The Westcliff, Johannesburg','Hotel',5.0,6200.00,'Luxury hillside hotel with views over Johannesburg.',NULL),
(25,3,'Saxon Hotel, Villas and Spa','Hotel',5.0,8500.00,'Luxury Sandton-area hotel suitable for premium packages.',NULL),
(26,3,'54 on Bath','Hotel',5.0,3800.00,'Boutique luxury hotel in Rosebank.',NULL),
(27,3,'The Houghton Hotel, Spa, Wellness & Golf','Hotel',5.0,4600.00,'Luxury hotel with spa, wellness and golf facilities.',NULL),
(28,3,'Johannesburg Marriott Hotel Melrose Arch','Hotel',5.0,4200.00,'Modern luxury hotel in the Melrose Arch precinct.',NULL),
(29,3,'Protea Hotel by Marriott Johannesburg Balalaika Sandton','Hotel',4.0,2300.00,'Central Sandton hotel suitable for business and leisure travellers.',NULL),
(30,3,'Sandton Sun and Towers','Hotel',5.0,3900.00,'Large luxury hotel connected to Sandton shopping and business areas.',NULL),
(31,3,'Southern Sun Rosebank','Hotel',4.0,2200.00,'Hotel in Rosebank close to shopping and Gautrain access.',NULL),
(32,3,'Holiday Inn Johannesburg - Rosebank','Hotel',4.0,1900.00,'Convenient hotel near Rosebank Mall and transport links.',NULL),
(33,3,'Hyatt House Johannesburg Rosebank','Hotel',4.0,2100.00,'Apartment-style hotel option in Rosebank.',NULL),
(34,3,'The Maslow Sandton','Hotel',4.0,2600.00,'Business-friendly hotel in Sandton.',NULL),
(35,3,'Radisson RED Hotel Johannesburg Rosebank','Hotel',4.0,2300.00,'Modern hotel in the Rosebank/Oxford Parks area.',NULL),
(36,3,'The Capital Empire','Hotel',4.0,2400.00,'Hotel and apartment accommodation close to Sandton City.',NULL),
(37,3,'DaVinci Hotel and Suites','Hotel',5.0,4100.00,'Luxury hotel in Sandton near Nelson Mandela Square.',NULL),
(38,3,'InterContinental Johannesburg O.R. Tambo Airport','Hotel',5.0,4700.00,'Airport hotel for stopovers and flight-connected packages.',NULL),
(39,3,'Garden Court Sandton City','Hotel',3.5,1900.00,'Mid-range hotel close to Sandton City and Nelson Mandela Square.',NULL),
(40,3,'The Peech Hotel','Guesthouse',4.5,3200.00,'Boutique accommodation in Melrose.',NULL),
(41,3,'Sanctuary Mandela','Guesthouse',5.0,5200.00,'Boutique heritage accommodation in Houghton.',NULL),
(42,3,'The Catalyst Hotel','Hotel',4.0,2100.00,'Modern Sandton hotel suited to city packages.',NULL),
(43,3,'Hyatt House Johannesburg Sandton','Hotel',4.0,2100.00,'Apartment-style hotel in Sandton.',NULL),
(44,2,'Park Hyatt Zanzibar','Hotel',5.0,6500.00,'Luxury beachfront hotel in Stone Town.',NULL),
(45,2,'Zanzibar Serena Hotel','Hotel',5.0,5200.00,'Historic hotel on the Stone Town seafront.',NULL),
(46,2,'Tembo House Hotel','Hotel',4.0,2400.00,'Stone Town hotel close to Forodhani Gardens and the waterfront.',NULL),
(47,2,'Mizingani Seafront Hotel','Hotel',4.0,2300.00,'Seafront hotel in the historic Stone Town area.',NULL),
(48,2,'Dhow Palace Hotel','Hotel',4.0,2100.00,'Traditional Stone Town hotel with historic architecture.',NULL),
(49,2,'Kisiwa House','Hotel',4.0,2800.00,'Boutique hotel in Stone Town near heritage attractions.',NULL),
(50,2,'The Seyyida Hotel and Spa','Hotel',4.0,2600.00,'Boutique hotel with spa facilities in Stone Town.',NULL),
(51,2,'Zanzibar Coffee House','Guesthouse',4.0,1800.00,'Boutique guesthouse and cafe-style accommodation in Stone Town.',NULL),
(52,2,'Hotel Verde Zanzibar - Azam Luxury Resort and Spa','Hotel',5.0,4100.00,'Luxury resort-style hotel near Stone Town and the waterfront.',NULL),
(53,2,'Madinat Al Bahr Business & Spa Hotel','Hotel',5.0,4300.00,'Business and spa hotel near the coast.',NULL),
(54,2,'Zanzi Resort','Resort',5.0,6200.00,'Luxury resort outside Stone Town in a quieter coastal area.',NULL),
(55,2,'Meliá Zanzibar','Resort',5.0,5900.00,'Luxury beachfront resort on Zanzibar\'s east coast.',NULL),
(56,2,'Zuri Zanzibar','Resort',5.0,6800.00,'Luxury beach resort in Kendwa.',NULL),
(57,2,'Hotel Riu Palace Zanzibar','Resort',5.0,5600.00,'All-inclusive beachfront resort in Nungwi.',NULL),
(58,2,'Kendwa Rocks Beach Hotel','Resort',4.0,2500.00,'Beach hotel in Kendwa suitable for leisure packages.',NULL),
(59,2,'Amaan Beach Bungalows','Resort',4.0,2000.00,'Beach bungalow-style accommodation in Nungwi.',NULL),
(60,2,'Bluebay Beach Resort & Spa','Resort',5.0,4600.00,'Beach resort with spa facilities on the east coast.',NULL),
(61,2,'Neptune Pwani Beach Resort & Spa','Resort',5.0,4700.00,'Beach resort suitable for leisure holiday packages.',NULL),
(62,2,'Baraza Resort and Spa Zanzibar','Resort',5.0,7600.00,'Luxury resort on the south-east coast of Zanzibar.',NULL),
(63,2,'Breezes Beach Club and Spa','Resort',5.0,5100.00,'Beach resort and spa for relaxed island packages.',NULL),
(64,4,'Sarova Stanley','Hotel',5.0,3600.00,'Historic city hotel in central Nairobi.',NULL),
(65,4,'Fairmont The Norfolk','Hotel',5.0,4200.00,'Historic luxury hotel near Nairobi city centre.',NULL),
(66,4,'Villa Rosa Kempinski Nairobi','Hotel',5.0,4600.00,'Luxury hotel in the Westlands area.',NULL),
(67,4,'Hemingways Nairobi','Hotel',5.0,6200.00,'Luxury boutique hotel in Karen.',NULL),
(68,4,'Tribe Hotel','Hotel',5.0,3900.00,'Luxury hotel in the Gigiri area near Village Market.',NULL),
(69,4,'Sankara Nairobi, Autograph Collection','Hotel',5.0,4100.00,'Modern luxury hotel in Westlands.',NULL),
(70,4,'Radisson Blu Hotel Nairobi Upper Hill','Hotel',5.0,3700.00,'Business-friendly hotel in Upper Hill.',NULL),
(71,4,'Mövenpick Hotel & Residences Nairobi','Hotel',5.0,3500.00,'Hotel and residences in Westlands.',NULL),
(72,4,'Novotel Nairobi Westlands','Hotel',4.0,3000.00,'Modern hotel in Westlands.',NULL),
(73,4,'Pullman Nairobi Upper Hill','Hotel',4.0,3300.00,'Business hotel in Upper Hill.',NULL),
(74,4,'Boma Inn Nairobi','Hotel',3.5,2100.00,'Hotel near Nairobi\'s South C and airport routes.',NULL),
(75,4,'Eka Hotel Nairobi','Hotel',4.0,2500.00,'Hotel on Mombasa Road suitable for airport and safari transfers.',NULL),
(76,4,'Emara Ole-Sereni','Hotel',5.0,4000.00,'Hotel overlooking Nairobi National Park area.',NULL),
(77,4,'Argyle Grand Hotel Nairobi Airport','Hotel',5.0,3600.00,'Airport-area hotel suited to transit and business travellers.',NULL),
(78,4,'Giraffe Manor','Guesthouse',5.0,9500.00,'Luxury boutique stay in Langata, popular for wildlife-focused trips.',NULL),
(79,4,'Windsor Golf Hotel and Country Club','Resort',5.0,4300.00,'Golf resort-style accommodation in Nairobi.',NULL),
(80,4,'Palacina The Residence & The Suites','Hotel',5.0,3800.00,'Luxury residence and suites in Kilimani.',NULL),
(81,4,'Hyatt Regency Nairobi Westlands','Hotel',5.0,4100.00,'Modern hotel in Westlands for city packages.',NULL),
(82,4,'JW Marriott Hotel Nairobi','Hotel',5.0,5200.00,'Luxury Marriott hotel in Nairobi\'s Westlands area.',NULL);
/*!40000 ALTER TABLE `accommodation` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `accommodation_import_africa`
--

DROP TABLE IF EXISTS `accommodation_import_africa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `accommodation_import_africa` (
  `acc_name` varchar(150) DEFAULT NULL,
  `street_address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `acc_type` enum('Hotel','Hostel','B&B','Self-Catering','Resort','Guesthouse') DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `price_per_night` decimal(10,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accommodation_import_africa`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `accommodation_import_africa` WRITE;
/*!40000 ALTER TABLE `accommodation_import_africa` DISABLE KEYS */;
INSERT INTO `accommodation_import_africa` VALUES
('Mount Nelson, A Belmond Hotel, Cape Town','76 Orange Street, Gardens','Cape Town','South Africa','Hotel',5.0,6500.00,'Iconic luxury hotel in Gardens, suitable for premium Cape Town packages.','8001'),
('Cape Grace, A Fairmont Managed Hotel','West Quay Road, V&A Waterfront','Cape Town','South Africa','Hotel',5.0,7200.00,'Luxury waterfront hotel at the V&A Waterfront.','8001'),
('The Table Bay Hotel','Quay 6, V&A Waterfront','Cape Town','South Africa','Hotel',5.0,5500.00,'Five-star hotel at the V&A Waterfront with harbour and mountain views.','8001'),
('One&Only Cape Town','Dock Road, V&A Waterfront','Cape Town','South Africa','Resort',5.0,7800.00,'Luxury resort-style hotel in the V&A Waterfront.','8001'),
('The Silo Hotel','Silo Square, V&A Waterfront','Cape Town','South Africa','Hotel',5.0,9500.00,'Premium boutique hotel above the Zeitz MOCAA precinct.','8001'),
('Taj Cape Town','1 Wale Street','Cape Town','South Africa','Hotel',5.0,4200.00,'Luxury city hotel close to Company Gardens and central attractions.','8001'),
('Radisson RED Cape Town V&A Waterfront','Silo 6, Silo Square, V&A Waterfront','Cape Town','South Africa','Hotel',4.5,3100.00,'Modern hotel in the Silo District near the waterfront.','8001'),
('AC Hotel by Marriott Cape Town Waterfront','Dockrail Road, Foreshore','Cape Town','South Africa','Hotel',4.5,2900.00,'Waterfront-area hotel suitable for business and leisure travellers.','8001'),
('President Hotel','4 Alexander Road, Bantry Bay','Cape Town','South Africa','Hotel',4.5,2600.00,'Seaside hotel in Bantry Bay near beaches and restaurants.','8005'),
('Hotel Verde Cape Town Airport','15 Michigan Street, Airport Industria','Cape Town','South Africa','Hotel',4.0,2100.00,'Airport hotel convenient for early flights and stopovers.','7490'),
('Southern Sun Waterfront Cape Town','1 Lower Buitengracht','Cape Town','South Africa','Hotel',4.0,2300.00,'Central hotel near the V&A Waterfront and Cape Town CBD.','8001'),
('The Commodore Hotel','Portswood Road, V&A Waterfront','Cape Town','South Africa','Hotel',4.0,2800.00,'Hotel near the V&A Waterfront, suitable for sightseeing packages.','8001'),
('Victoria & Alfred Hotel','Pierhead, V&A Waterfront','Cape Town','South Africa','Hotel',4.5,3900.00,'Historic waterfront hotel close to harbour attractions.','8001'),
('Lagoon Beach Hotel & Spa','1 Lagoon Gate Drive, Milnerton','Cape Town','South Africa','Hotel',4.0,2400.00,'Beachfront hotel with views toward Table Mountain.','7441'),
('The Westin Cape Town','Convention Square, Lower Long Street','Cape Town','South Africa','Hotel',5.0,4300.00,'Large city hotel next to the Cape Town International Convention Centre.','8001'),
('Protea Hotel Fire & Ice Cape Town','New Church Street, Tamboerskloof','Cape Town','South Africa','Hotel',4.0,2200.00,'Trendy hotel close to Kloof Street and the city centre.','8001'),
('Gorgeous George by Design Hotels','118 St Georges Mall','Cape Town','South Africa','Hotel',4.5,3600.00,'Boutique design hotel in Cape Town CBD.','8001'),
('City Lodge Hotel V&A Waterfront','Corner Dock Road and Alfred Street','Cape Town','South Africa','Hotel',3.5,1800.00,'Mid-range hotel close to the waterfront and city attractions.','8001'),
('Hyatt Regency Cape Town','126 Buitengracht Street','Cape Town','South Africa','Hotel',4.0,2500.00,'City hotel in central Cape Town near Bo-Kaap and CBD attractions.','8001'),
('Pepperclub Hotel','Corner Loop Street and Pepper Street','Cape Town','South Africa','Hotel',5.0,3300.00,'Luxury city hotel with access to dining and nightlife areas.','8001'),
('Four Seasons Hotel The Westcliff, Johannesburg','67 Jan Smuts Avenue, Westcliff','Johannesburg','South Africa','Hotel',5.0,6200.00,'Luxury hillside hotel with views over Johannesburg.','2193'),
('Saxon Hotel, Villas and Spa','36 Saxon Road, Sandhurst','Johannesburg','South Africa','Hotel',5.0,8500.00,'Luxury Sandton-area hotel suitable for premium packages.','2196'),
('54 on Bath','54 Bath Avenue, Rosebank','Johannesburg','South Africa','Hotel',5.0,3800.00,'Boutique luxury hotel in Rosebank.','2196'),
('The Houghton Hotel, Spa, Wellness & Golf','Lloys Ellis Avenue, Houghton Estate','Johannesburg','South Africa','Hotel',5.0,4600.00,'Luxury hotel with spa, wellness and golf facilities.','2198'),
('Johannesburg Marriott Hotel Melrose Arch','42 The High Street, Melrose Arch','Johannesburg','South Africa','Hotel',5.0,4200.00,'Modern luxury hotel in the Melrose Arch precinct.','2076'),
('Protea Hotel by Marriott Johannesburg Balalaika Sandton','20 Maude Street, Sandton','Johannesburg','South Africa','Hotel',4.0,2300.00,'Central Sandton hotel suitable for business and leisure travellers.','2196'),
('Sandton Sun and Towers','Corner Fifth Street and Alice Lane, Sandton','Johannesburg','South Africa','Hotel',5.0,3900.00,'Large luxury hotel connected to Sandton shopping and business areas.','2196'),
('Southern Sun Rosebank','13 Tyrwhitt Avenue, Rosebank','Johannesburg','South Africa','Hotel',4.0,2200.00,'Hotel in Rosebank close to shopping and Gautrain access.','2196'),
('Holiday Inn Johannesburg - Rosebank','Oxford Road, Rosebank','Johannesburg','South Africa','Hotel',4.0,1900.00,'Convenient hotel near Rosebank Mall and transport links.','2196'),
('Hyatt House Johannesburg Rosebank','28 Tottenham Avenue, Rosebank','Johannesburg','South Africa','Hotel',4.0,2100.00,'Apartment-style hotel option in Rosebank.','2196'),
('The Maslow Sandton','146 Rivonia Road, Sandton','Johannesburg','South Africa','Hotel',4.0,2600.00,'Business-friendly hotel in Sandton.','2196'),
('Radisson RED Hotel Johannesburg Rosebank','Parks Boulevard, Oxford Parks','Johannesburg','South Africa','Hotel',4.0,2300.00,'Modern hotel in the Rosebank/Oxford Parks area.','2196'),
('The Capital Empire','177 Empire Place, Sandhurst','Johannesburg','South Africa','Hotel',4.0,2400.00,'Hotel and apartment accommodation close to Sandton City.','2196'),
('DaVinci Hotel and Suites','2 Maude Street, Sandton','Johannesburg','South Africa','Hotel',5.0,4100.00,'Luxury hotel in Sandton near Nelson Mandela Square.','2196'),
('InterContinental Johannesburg O.R. Tambo Airport','O.R. Tambo International Airport','Johannesburg','South Africa','Hotel',5.0,4700.00,'Airport hotel for stopovers and flight-connected packages.','1627'),
('Garden Court Sandton City','Corner West Street and Maude Street, Sandton','Johannesburg','South Africa','Hotel',3.5,1900.00,'Mid-range hotel close to Sandton City and Nelson Mandela Square.','2196'),
('The Peech Hotel','North Street, Melrose','Johannesburg','South Africa','Guesthouse',4.5,3200.00,'Boutique accommodation in Melrose.','2196'),
('Sanctuary Mandela','13th Avenue, Houghton Estate','Johannesburg','South Africa','Guesthouse',5.0,5200.00,'Boutique heritage accommodation in Houghton.','2198'),
('The Catalyst Hotel','100 Pretoria Avenue, Sandton','Johannesburg','South Africa','Hotel',4.0,2100.00,'Modern Sandton hotel suited to city packages.','2196'),
('Hyatt House Johannesburg Sandton','125 Ann Crescent, Sandton','Johannesburg','South Africa','Hotel',4.0,2100.00,'Apartment-style hotel in Sandton.','2196'),
('Park Hyatt Zanzibar','Shangani Street, Stone Town','Zanzibar','Tanzania','Hotel',5.0,6500.00,'Luxury beachfront hotel in Stone Town.','71101'),
('Zanzibar Serena Hotel','Shangani Street, Stone Town','Zanzibar','Tanzania','Hotel',5.0,5200.00,'Historic hotel on the Stone Town seafront.','71101'),
('Tembo House Hotel','Shangani Street, Stone Town','Zanzibar','Tanzania','Hotel',4.0,2400.00,'Stone Town hotel close to Forodhani Gardens and the waterfront.','71101'),
('Mizingani Seafront Hotel','Mizingani Road, Stone Town','Zanzibar','Tanzania','Hotel',4.0,2300.00,'Seafront hotel in the historic Stone Town area.','71101'),
('Dhow Palace Hotel','Kenyatta Road, Shangani','Zanzibar','Tanzania','Hotel',4.0,2100.00,'Traditional Stone Town hotel with historic architecture.','71101'),
('Kisiwa House','572 Baghani Street, Stone Town','Zanzibar','Tanzania','Hotel',4.0,2800.00,'Boutique hotel in Stone Town near heritage attractions.','71101'),
('The Seyyida Hotel and Spa','Kiponda, Stone Town','Zanzibar','Tanzania','Hotel',4.0,2600.00,'Boutique hotel with spa facilities in Stone Town.','71101'),
('Zanzibar Coffee House','Mkunazini Street, Stone Town','Zanzibar','Tanzania','Guesthouse',4.0,1800.00,'Boutique guesthouse and cafe-style accommodation in Stone Town.','71101'),
('Hotel Verde Zanzibar - Azam Luxury Resort and Spa','Malawi Road, Mtoni','Zanzibar','Tanzania','Hotel',5.0,4100.00,'Luxury resort-style hotel near Stone Town and the waterfront.','71110'),
('Madinat Al Bahr Business & Spa Hotel','Mbweni Road','Zanzibar','Tanzania','Hotel',5.0,4300.00,'Business and spa hotel near the coast.','71110'),
('Zanzi Resort','Kama Village','Zanzibar','Tanzania','Resort',5.0,6200.00,'Luxury resort outside Stone Town in a quieter coastal area.','71110'),
('Meliá Zanzibar','Kiwengwa','Zanzibar','Tanzania','Resort',5.0,5900.00,'Luxury beachfront resort on Zanzibar\'s east coast.','73111'),
('Zuri Zanzibar','Kendwa','Zanzibar','Tanzania','Resort',5.0,6800.00,'Luxury beach resort in Kendwa.','73109'),
('Hotel Riu Palace Zanzibar','Nungwi Beach','Zanzibar','Tanzania','Resort',5.0,5600.00,'All-inclusive beachfront resort in Nungwi.','73107'),
('Kendwa Rocks Beach Hotel','Kendwa Beach','Zanzibar','Tanzania','Resort',4.0,2500.00,'Beach hotel in Kendwa suitable for leisure packages.','73109'),
('Amaan Beach Bungalows','Nungwi Beach','Zanzibar','Tanzania','Resort',4.0,2000.00,'Beach bungalow-style accommodation in Nungwi.','73107'),
('Bluebay Beach Resort & Spa','Kiwengwa Beach','Zanzibar','Tanzania','Resort',5.0,4600.00,'Beach resort with spa facilities on the east coast.','73111'),
('Neptune Pwani Beach Resort & Spa','Pwani Mchangani','Zanzibar','Tanzania','Resort',5.0,4700.00,'Beach resort suitable for leisure holiday packages.','73111'),
('Baraza Resort and Spa Zanzibar','Bwejuu Beach','Zanzibar','Tanzania','Resort',5.0,7600.00,'Luxury resort on the south-east coast of Zanzibar.','72110'),
('Breezes Beach Club and Spa','Bwejuu Beach','Zanzibar','Tanzania','Resort',5.0,5100.00,'Beach resort and spa for relaxed island packages.','72110'),
('Nairobi Serena Hotel','Kenyatta Avenue','Nairobi','Kenya','Hotel',5.0,4400.00,'Luxury city hotel close to Uhuru Park and central attractions.','00100'),
('Sarova Stanley','Corner Kimathi Street and Kenyatta Avenue','Nairobi','Kenya','Hotel',5.0,3600.00,'Historic city hotel in central Nairobi.','00100'),
('Fairmont The Norfolk','Harry Thuku Road','Nairobi','Kenya','Hotel',5.0,4200.00,'Historic luxury hotel near Nairobi city centre.','00100'),
('Villa Rosa Kempinski Nairobi','Chiromo Road','Nairobi','Kenya','Hotel',5.0,4600.00,'Luxury hotel in the Westlands area.','00800'),
('Hemingways Nairobi','Mbagathi Ridge, Karen','Nairobi','Kenya','Hotel',5.0,6200.00,'Luxury boutique hotel in Karen.','00502'),
('Tribe Hotel','Village Market, Limuru Road','Nairobi','Kenya','Hotel',5.0,3900.00,'Luxury hotel in the Gigiri area near Village Market.','00621'),
('Sankara Nairobi, Autograph Collection','Woodvale Grove, Westlands','Nairobi','Kenya','Hotel',5.0,4100.00,'Modern luxury hotel in Westlands.','00800'),
('Radisson Blu Hotel Nairobi Upper Hill','Elgon Road, Upper Hill','Nairobi','Kenya','Hotel',5.0,3700.00,'Business-friendly hotel in Upper Hill.','00100'),
('Mövenpick Hotel & Residences Nairobi','Mkungu Close, Westlands','Nairobi','Kenya','Hotel',5.0,3500.00,'Hotel and residences in Westlands.','00800'),
('Novotel Nairobi Westlands','Westlands Road','Nairobi','Kenya','Hotel',4.0,3000.00,'Modern hotel in Westlands.','00800'),
('Pullman Nairobi Upper Hill','Upper Hill Road','Nairobi','Kenya','Hotel',4.0,3300.00,'Business hotel in Upper Hill.','00100'),
('Boma Inn Nairobi','Red Cross Road, South C','Nairobi','Kenya','Hotel',3.5,2100.00,'Hotel near Nairobi\'s South C and airport routes.','00506'),
('Eka Hotel Nairobi','Mombasa Road','Nairobi','Kenya','Hotel',4.0,2500.00,'Hotel on Mombasa Road suitable for airport and safari transfers.','00506'),
('Emara Ole-Sereni','Mombasa Road','Nairobi','Kenya','Hotel',5.0,4000.00,'Hotel overlooking Nairobi National Park area.','00506'),
('Argyle Grand Hotel Nairobi Airport','Mombasa Road','Nairobi','Kenya','Hotel',5.0,3600.00,'Airport-area hotel suited to transit and business travellers.','00506'),
('Giraffe Manor','Gogo Falls Road, Langata','Nairobi','Kenya','Guesthouse',5.0,9500.00,'Luxury boutique stay in Langata, popular for wildlife-focused trips.','00509'),
('Windsor Golf Hotel and Country Club','Kigwa Road, Ridgeways','Nairobi','Kenya','Resort',5.0,4300.00,'Golf resort-style accommodation in Nairobi.','00619'),
('Palacina The Residence & The Suites','Kitale Lane, Kilimani','Nairobi','Kenya','Hotel',5.0,3800.00,'Luxury residence and suites in Kilimani.','00100'),
('Hyatt Regency Nairobi Westlands','Westlands','Nairobi','Kenya','Hotel',5.0,4100.00,'Modern hotel in Westlands for city packages.','00800'),
('JW Marriott Hotel Nairobi','Chiromo Lane, Westlands','Nairobi','Kenya','Hotel',5.0,5200.00,'Luxury Marriott hotel in Nairobi\'s Westlands area.','00800');
/*!40000 ALTER TABLE `accommodation_import_africa` ENABLE KEYS */;
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
(4,'Kenyatta Avenue','Nairobi','Kenya','00100'),
(5,'76 Orange Street, Gardens','Cape Town','South Africa','8001'),
(6,'West Quay Road, V&A Waterfront','Cape Town','South Africa','8001'),
(7,'Dock Road, V&A Waterfront','Cape Town','South Africa','8001'),
(8,'Silo Square, V&A Waterfront','Cape Town','South Africa','8001'),
(9,'1 Wale Street','Cape Town','South Africa','8001'),
(10,'Silo 6, Silo Square, V&A Waterfront','Cape Town','South Africa','8001'),
(11,'Dockrail Road, Foreshore','Cape Town','South Africa','8001'),
(12,'4 Alexander Road, Bantry Bay','Cape Town','South Africa','8005'),
(13,'15 Michigan Street, Airport Industria','Cape Town','South Africa','7490'),
(14,'1 Lower Buitengracht','Cape Town','South Africa','8001'),
(15,'Portswood Road, V&A Waterfront','Cape Town','South Africa','8001'),
(16,'Pierhead, V&A Waterfront','Cape Town','South Africa','8001'),
(17,'1 Lagoon Gate Drive, Milnerton','Cape Town','South Africa','7441'),
(18,'Convention Square, Lower Long Street','Cape Town','South Africa','8001'),
(19,'New Church Street, Tamboerskloof','Cape Town','South Africa','8001'),
(20,'118 St Georges Mall','Cape Town','South Africa','8001'),
(21,'Corner Dock Road and Alfred Street','Cape Town','South Africa','8001'),
(22,'126 Buitengracht Street','Cape Town','South Africa','8001'),
(23,'Corner Loop Street and Pepper Street','Cape Town','South Africa','8001'),
(24,'67 Jan Smuts Avenue, Westcliff','Johannesburg','South Africa','2193'),
(25,'36 Saxon Road, Sandhurst','Johannesburg','South Africa','2196'),
(26,'54 Bath Avenue, Rosebank','Johannesburg','South Africa','2196'),
(27,'Lloys Ellis Avenue, Houghton Estate','Johannesburg','South Africa','2198'),
(28,'42 The High Street, Melrose Arch','Johannesburg','South Africa','2076'),
(29,'20 Maude Street, Sandton','Johannesburg','South Africa','2196'),
(30,'Corner Fifth Street and Alice Lane, Sandton','Johannesburg','South Africa','2196'),
(31,'13 Tyrwhitt Avenue, Rosebank','Johannesburg','South Africa','2196'),
(32,'Oxford Road, Rosebank','Johannesburg','South Africa','2196'),
(33,'28 Tottenham Avenue, Rosebank','Johannesburg','South Africa','2196'),
(34,'146 Rivonia Road, Sandton','Johannesburg','South Africa','2196'),
(35,'Parks Boulevard, Oxford Parks','Johannesburg','South Africa','2196'),
(36,'177 Empire Place, Sandhurst','Johannesburg','South Africa','2196'),
(37,'2 Maude Street, Sandton','Johannesburg','South Africa','2196'),
(38,'O.R. Tambo International Airport','Johannesburg','South Africa','1627'),
(39,'Corner West Street and Maude Street, Sandton','Johannesburg','South Africa','2196'),
(40,'North Street, Melrose','Johannesburg','South Africa','2196'),
(41,'13th Avenue, Houghton Estate','Johannesburg','South Africa','2198'),
(42,'100 Pretoria Avenue, Sandton','Johannesburg','South Africa','2196'),
(43,'125 Ann Crescent, Sandton','Johannesburg','South Africa','2196'),
(44,'Shangani Street, Stone Town','Zanzibar','Tanzania','71101'),
(45,'Shangani Street, Stone Town','Zanzibar','Tanzania','71101'),
(46,'Shangani Street, Stone Town','Zanzibar','Tanzania','71101'),
(47,'Mizingani Road, Stone Town','Zanzibar','Tanzania','71101'),
(48,'Kenyatta Road, Shangani','Zanzibar','Tanzania','71101'),
(49,'572 Baghani Street, Stone Town','Zanzibar','Tanzania','71101'),
(50,'Kiponda, Stone Town','Zanzibar','Tanzania','71101'),
(51,'Mkunazini Street, Stone Town','Zanzibar','Tanzania','71101'),
(52,'Malawi Road, Mtoni','Zanzibar','Tanzania','71110'),
(53,'Mbweni Road','Zanzibar','Tanzania','71110'),
(54,'Kama Village','Zanzibar','Tanzania','71110'),
(55,'Kiwengwa','Zanzibar','Tanzania','73111'),
(56,'Kendwa','Zanzibar','Tanzania','73109'),
(57,'Nungwi Beach','Zanzibar','Tanzania','73107'),
(58,'Kendwa Beach','Zanzibar','Tanzania','73109'),
(59,'Nungwi Beach','Zanzibar','Tanzania','73107'),
(60,'Kiwengwa Beach','Zanzibar','Tanzania','73111'),
(61,'Pwani Mchangani','Zanzibar','Tanzania','73111'),
(62,'Bwejuu Beach','Zanzibar','Tanzania','72110'),
(63,'Bwejuu Beach','Zanzibar','Tanzania','72110'),
(64,'Corner Kimathi Street and Kenyatta Avenue','Nairobi','Kenya','00100'),
(65,'Harry Thuku Road','Nairobi','Kenya','00100'),
(66,'Chiromo Road','Nairobi','Kenya','00800'),
(67,'Mbagathi Ridge, Karen','Nairobi','Kenya','00502'),
(68,'Village Market, Limuru Road','Nairobi','Kenya','00621'),
(69,'Woodvale Grove, Westlands','Nairobi','Kenya','00800'),
(70,'Elgon Road, Upper Hill','Nairobi','Kenya','00100'),
(71,'Mkungu Close, Westlands','Nairobi','Kenya','00800'),
(72,'Westlands Road','Nairobi','Kenya','00800'),
(73,'Upper Hill Road','Nairobi','Kenya','00100'),
(74,'Red Cross Road, South C','Nairobi','Kenya','00506'),
(75,'Mombasa Road','Nairobi','Kenya','00506'),
(76,'Mombasa Road','Nairobi','Kenya','00506'),
(77,'Mombasa Road','Nairobi','Kenya','00506'),
(78,'Gogo Falls Road, Langata','Nairobi','Kenya','00509'),
(79,'Kigwa Road, Ridgeways','Nairobi','Kenya','00619'),
(80,'Kitale Lane, Kilimani','Nairobi','Kenya','00100'),
(81,'Westlands','Nairobi','Kenya','00800'),
(82,'Chiromo Lane, Westlands','Nairobi','Kenya','00800');
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
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(4,4,'Nairobi National Park','Wildlife',600.00,'Game reserve within the city limits of Nairobi.',4.8,'06:00:00','18:00:00',NULL),
(5,1,'Robben Island Museum','Cultural',450.00,'Historic island museum and former prison site.',4.7,'09:00:00','17:00:00',NULL),
(6,1,'V&A Waterfront','Leisure',0.00,'Waterfront shopping dining and entertainment precinct.',4.7,'09:00:00','21:00:00',NULL),
(7,1,'Kirstenbosch National Botanical Garden','Nature',230.00,'Botanical garden on the eastern slopes of Table Mountain.',4.8,'08:00:00','18:00:00',NULL),
(8,1,'Cape Point Nature Reserve','Nature',400.00,'Scenic nature reserve at the south-western tip of the Cape Peninsula.',4.8,'06:00:00','18:00:00',NULL),
(9,1,'Boulders Beach Penguin Colony','Wildlife',190.00,'Protected beach area known for African penguins.',4.7,'08:00:00','17:00:00',NULL),
(10,1,'Two Oceans Aquarium','Family',250.00,'Aquarium showcasing marine life from the Atlantic and Indian Oceans.',4.6,'09:30:00','18:00:00',NULL),
(11,1,'District Six Museum','Museum',60.00,'Museum telling the story of District Six and forced removals.',4.6,'09:00:00','16:00:00',NULL),
(12,1,'Castle of Good Hope','Historical',90.00,'Historic fort and heritage site in central Cape Town.',4.3,'09:00:00','17:00:00',NULL),
(13,1,'Bo-Kaap Museum','Cultural',60.00,'Museum and cultural stop in the colourful Bo-Kaap area.',4.4,'09:00:00','16:00:00',NULL),
(14,1,'Zeitz MOCAA','Museum',250.00,'Contemporary African art museum in the Silo District.',4.5,'10:00:00','18:00:00',NULL),
(15,1,'Signal Hill','Viewpoint',0.00,'Popular viewpoint overlooking Cape Town and the Atlantic coastline.',4.7,'06:00:00','20:00:00',NULL),
(16,1,'Clifton Fourth Beach','Beach',0.00,'Popular Atlantic Seaboard beach known for white sand and sunsets.',4.6,'06:00:00','19:00:00',NULL),
(17,1,'Camps Bay Beach','Beach',0.00,'Beachfront area with mountain views, restaurants and ocean scenery.',4.6,'06:00:00','19:00:00',NULL),
(18,1,'Chapman\'s Peak Drive','Scenic Route',60.00,'Famous coastal drive between Hout Bay and Noordhoek.',4.8,'06:00:00','20:00:00',NULL),
(19,1,'Old Biscuit Mill','Market',0.00,'Market and food precinct in Woodstock.',4.4,'09:00:00','16:00:00',NULL),
(20,1,'Company\'s Garden','Park',0.00,'Historic public garden in central Cape Town.',4.5,'07:00:00','18:00:00',NULL),
(21,1,'Norval Foundation','Museum',200.00,'Art museum and sculpture garden near the Constantia wine route.',4.5,'10:00:00','18:00:00',NULL),
(22,1,'Groot Constantia Wine Estate','Wine Estate',150.00,'Historic wine estate with tastings, museum spaces and vineyard views.',4.6,'09:00:00','17:00:00',NULL),
(23,1,'Hout Bay Harbour','Harbour',0.00,'Working harbour with boat trips, seafood and mountain views.',4.3,'08:00:00','18:00:00',NULL),
(24,3,'Apartheid Museum','Museum',150.00,'Museum documenting South Africa\'s apartheid history.',4.7,'09:00:00','17:00:00',NULL),
(25,3,'Gold Reef City Theme Park','Theme Park',250.00,'Theme park and entertainment complex themed around gold mining history.',4.5,'09:30:00','17:00:00',NULL),
(26,3,'Constitution Hill','Historical',100.00,'Historic prison complex and home of South Africa\'s Constitutional Court.',4.6,'09:00:00','17:00:00',NULL),
(27,3,'Soweto Towers','Adventure',0.00,'Landmark painted cooling towers offering adventure activities.',4.5,'10:00:00','18:00:00',NULL),
(28,3,'Mandela House','Museum',60.00,'Former home of Nelson Mandela in Soweto.',4.5,'09:00:00','17:00:00',NULL),
(29,3,'Hector Pieterson Museum','Museum',30.00,'Museum commemorating the 1976 Soweto uprising.',4.6,'10:00:00','17:00:00',NULL),
(30,3,'Maboneng Precinct','Leisure',0.00,'Urban arts, food and entertainment precinct in Johannesburg.',4.3,'09:00:00','20:00:00',NULL),
(31,3,'Johannesburg Zoo','Wildlife',120.00,'Large city zoo with animal exhibits and family activities.',4.3,'08:30:00','17:30:00',NULL),
(32,3,'Walter Sisulu National Botanical Garden','Nature',100.00,'Botanical garden known for scenery, birdlife and the waterfall.',4.7,'08:00:00','17:00:00',NULL),
(33,3,'Cradle of Humankind Visitor Centre Maropeng','Heritage',175.00,'Visitor centre for the Cradle of Humankind World Heritage Site.',4.5,'09:00:00','17:00:00',NULL),
(34,3,'Sterkfontein Caves','Heritage',150.00,'Famous fossil cave site in the Cradle of Humankind area.',4.4,'09:00:00','16:00:00',NULL),
(35,3,'Nelson Mandela Square','Leisure',0.00,'Shopping and dining square with a large Nelson Mandela statue.',4.4,'09:00:00','21:00:00',NULL),
(36,3,'Sandton City','Shopping',0.00,'Major shopping centre in Sandton.',4.5,'09:00:00','21:00:00',NULL),
(37,3,'Rosebank Sunday Market','Market',0.00,'Weekend market with crafts, food and local stalls.',4.3,'09:00:00','16:00:00',NULL),
(38,3,'Origins Centre Museum','Museum',80.00,'Museum focused on human origins and rock art heritage.',4.5,'10:00:00','17:00:00',NULL),
(39,3,'Lindfield Victorian House Museum','Museum',100.00,'Historic Victorian house museum in Auckland Park.',4.5,'10:00:00','17:00:00',NULL),
(40,3,'James Hall Museum of Transport','Museum',50.00,'Museum with transport and vehicle exhibits.',4.3,'09:00:00','16:30:00',NULL),
(41,3,'Delta Park','Park',0.00,'Large city park with walking routes and green spaces.',4.4,'06:00:00','18:00:00',NULL),
(42,3,'Zoo Lake','Park',0.00,'Public park and lake area popular for picnics and walks.',4.4,'06:00:00','18:00:00',NULL),
(43,3,'The Wilds Nature Reserve','Nature',0.00,'Urban nature reserve with walking paths and city views.',4.5,'06:00:00','18:00:00',NULL),
(44,2,'Stone Town','Cultural',0.00,'Historic old town known for narrow streets, architecture and markets.',4.7,'08:00:00','20:00:00',NULL),
(45,2,'House of Wonders','Historical',0.00,'Historic landmark building in Stone Town.',4.2,'09:00:00','17:00:00',NULL),
(46,2,'Old Fort of Zanzibar','Historical',0.00,'Historic fort near Forodhani Gardens and the seafront.',4.3,'09:00:00','18:00:00',NULL),
(47,2,'Forodhani Gardens','Market',0.00,'Seafront gardens known for evening food stalls and views.',4.5,'16:00:00','22:00:00',NULL),
(48,2,'Darajani Market','Market',0.00,'Busy market area for local food, spices and daily trading.',4.3,'08:00:00','18:00:00',NULL),
(49,2,'Prison Island','Nature',250.00,'Island excursion known for history, beaches and giant tortoises.',4.5,'08:00:00','17:00:00',NULL),
(50,2,'Jozani Chwaka Bay National Park','Wildlife',180.00,'Forest reserve known for red colobus monkeys and mangrove walks.',4.6,'07:30:00','17:00:00',NULL),
(51,2,'Nakupenda Beach','Beach',350.00,'Sandbank excursion with swimming and beach scenery.',4.7,'08:00:00','17:00:00',NULL),
(52,2,'Nungwi Beach','Beach',0.00,'Popular northern beach with swimming, resorts and sunset views.',4.7,'06:00:00','19:00:00',NULL),
(53,2,'Kendwa Beach','Beach',0.00,'Beach area known for calm water and sunset views.',4.7,'06:00:00','19:00:00',NULL),
(54,2,'Paje Beach','Beach',0.00,'East coast beach known for kitesurfing and long sandy stretches.',4.6,'06:00:00','19:00:00',NULL),
(55,2,'Jambiani Beach','Beach',0.00,'Quiet coastal village beach with relaxed island scenery.',4.6,'06:00:00','19:00:00',NULL),
(56,2,'Mnemba Island Atoll','Marine',450.00,'Marine excursion area known for snorkelling and clear waters.',4.7,'08:00:00','16:00:00',NULL),
(57,2,'Cheetah\'s Rock','Wildlife',350.00,'Wildlife conservation visitor experience near Stone Town.',4.8,'08:30:00','17:00:00',NULL),
(58,2,'Mnarani Marine Turtles Conservation Pond','Wildlife',120.00,'Conservation pond and visitor site focused on marine turtles.',4.4,'09:00:00','17:00:00',NULL),
(59,2,'Kizimkazi Dolphin Area','Marine',300.00,'Southern coastal area commonly used for dolphin and boat trips.',4.2,'07:00:00','15:00:00',NULL),
(60,2,'Spice Farm Tour','Cultural',150.00,'Guided spice farm experience explaining Zanzibar\'s spice heritage.',4.5,'09:00:00','16:00:00',NULL),
(61,2,'The Rock Area Pingwe','Viewpoint',0.00,'Scenic coastal stop near the famous Rock Restaurant area.',4.5,'10:00:00','18:00:00',NULL),
(62,2,'Kuza Cave','Nature',120.00,'Limestone cave and cultural centre near Jambiani.',4.6,'08:30:00','17:00:00',NULL),
(63,2,'Zanzibar Butterfly Centre','Nature',100.00,'Butterfly conservation centre close to Jozani Forest.',4.4,'09:00:00','17:00:00',NULL),
(64,4,'David Sheldrick Wildlife Trust Elephant Nursery','Wildlife',300.00,'Elephant orphanage visitor experience in Nairobi.',4.8,'11:00:00','12:00:00',NULL),
(65,4,'Giraffe Centre','Wildlife',250.00,'Conservation centre where visitors can see and feed giraffes.',4.7,'09:00:00','17:00:00',NULL),
(66,4,'Karen Blixen Museum','Museum',120.00,'Museum at the former home of Karen Blixen.',4.5,'09:30:00','18:00:00',NULL),
(67,4,'Bomas of Kenya','Cultural',200.00,'Cultural centre presenting traditional Kenyan music, dance and homesteads.',4.4,'10:00:00','18:00:00',NULL),
(68,4,'Nairobi National Museum','Museum',200.00,'National museum with cultural, natural history and heritage exhibits.',4.5,'08:30:00','17:30:00',NULL),
(69,4,'Karura Forest','Nature',100.00,'Urban forest with walking, cycling and nature trails.',4.7,'06:00:00','18:00:00',NULL),
(70,4,'Uhuru Park','Park',0.00,'Central public park used for leisure walks and city views.',4.2,'06:00:00','18:00:00',NULL),
(71,4,'Kenyatta International Convention Centre','Viewpoint',150.00,'Convention centre with a popular rooftop viewpoint.',4.4,'08:00:00','18:00:00',NULL),
(72,4,'Railway Museum','Museum',100.00,'Museum with railway history and locomotive exhibits.',4.3,'08:30:00','17:00:00',NULL),
(73,4,'Maasai Market','Market',0.00,'Open-air craft market selling local art, textiles and souvenirs.',4.3,'09:00:00','18:00:00',NULL),
(74,4,'Village Market','Shopping',0.00,'Shopping and entertainment centre in Gigiri.',4.5,'09:00:00','21:00:00',NULL),
(75,4,'Kazuri Beads','Cultural',0.00,'Workshop and craft centre known for handmade ceramic beads.',4.6,'08:30:00','17:00:00',NULL),
(76,4,'Ngong Hills','Nature',200.00,'Scenic hills popular for hiking and views outside Nairobi.',4.6,'06:00:00','18:00:00',NULL),
(77,4,'Oloolua Nature Trail','Nature',100.00,'Nature trail with forest walks, caves and picnic areas.',4.4,'09:00:00','18:00:00',NULL),
(78,4,'August 7th Memorial Park','Historical',50.00,'Memorial park and museum in central Nairobi.',4.3,'08:00:00','17:00:00',NULL),
(79,4,'Jamia Mosque Nairobi','Cultural',0.00,'Landmark mosque and architectural site in central Nairobi.',4.5,'08:00:00','18:00:00',NULL),
(80,4,'Nairobi Gallery','Museum',100.00,'Art and heritage gallery housed in a historic building.',4.3,'08:30:00','17:30:00',NULL),
(81,4,'Westgate Shopping Mall','Shopping',0.00,'Modern shopping and entertainment centre in Westlands.',4.4,'09:00:00','21:00:00',NULL),
(82,4,'Two Rivers Mall','Shopping',0.00,'Large shopping and leisure mall near Nairobi.',4.5,'09:00:00','21:00:00',NULL);
/*!40000 ALTER TABLE `attraction` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `attraction_import_africa`
--

DROP TABLE IF EXISTS `attraction_import_africa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attraction_import_africa` (
  `name` varchar(150) DEFAULT NULL,
  `street_address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `fee` decimal(10,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `opening_time` time DEFAULT NULL,
  `closing_time` time DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attraction_import_africa`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `attraction_import_africa` WRITE;
/*!40000 ALTER TABLE `attraction_import_africa` DISABLE KEYS */;
INSERT INTO `attraction_import_africa` VALUES
('Table Mountain Aerial Cableway','Tafelberg Road','Cape Town','South Africa','Nature',390.00,'Cable car trip to the top of Table Mountain with views over Cape Town.',4.9,'08:00:00','18:00:00','8001'),
('Robben Island Museum','V&A Waterfront, Nelson Mandela Gateway','Cape Town','South Africa','Cultural',450.00,'Historic island museum and former prison site.',4.7,'09:00:00','17:00:00','8001'),
('V&A Waterfront','19 Dock Road','Cape Town','South Africa','Leisure',0.00,'Waterfront shopping dining and entertainment precinct.',4.7,'09:00:00','21:00:00','8001'),
('Kirstenbosch National Botanical Garden','Rhodes Drive, Newlands','Cape Town','South Africa','Nature',230.00,'Botanical garden on the eastern slopes of Table Mountain.',4.8,'08:00:00','18:00:00','7735'),
('Cape Point Nature Reserve','Cape Point Road','Cape Town','South Africa','Nature',400.00,'Scenic nature reserve at the south-western tip of the Cape Peninsula.',4.8,'06:00:00','18:00:00','7975'),
('Boulders Beach Penguin Colony','Kleintuin Road, Simon\'s Town','Cape Town','South Africa','Wildlife',190.00,'Protected beach area known for African penguins.',4.7,'08:00:00','17:00:00','7995'),
('Two Oceans Aquarium','Dock Road, V&A Waterfront','Cape Town','South Africa','Family',250.00,'Aquarium showcasing marine life from the Atlantic and Indian Oceans.',4.6,'09:30:00','18:00:00','8001'),
('District Six Museum','25A Buitenkant Street','Cape Town','South Africa','Museum',60.00,'Museum telling the story of District Six and forced removals.',4.6,'09:00:00','16:00:00','8001'),
('Castle of Good Hope','Darling Street','Cape Town','South Africa','Historical',90.00,'Historic fort and heritage site in central Cape Town.',4.3,'09:00:00','17:00:00','8001'),
('Bo-Kaap Museum','71 Wale Street','Cape Town','South Africa','Cultural',60.00,'Museum and cultural stop in the colourful Bo-Kaap area.',4.4,'09:00:00','16:00:00','8001'),
('Zeitz MOCAA','Silo District, V&A Waterfront','Cape Town','South Africa','Museum',250.00,'Contemporary African art museum in the Silo District.',4.5,'10:00:00','18:00:00','8001'),
('Signal Hill','Signal Hill Road','Cape Town','South Africa','Viewpoint',0.00,'Popular viewpoint overlooking Cape Town and the Atlantic coastline.',4.7,'06:00:00','20:00:00','8001'),
('Clifton Fourth Beach','Victoria Road, Clifton','Cape Town','South Africa','Beach',0.00,'Popular Atlantic Seaboard beach known for white sand and sunsets.',4.6,'06:00:00','19:00:00','8005'),
('Camps Bay Beach','Victoria Road, Camps Bay','Cape Town','South Africa','Beach',0.00,'Beachfront area with mountain views, restaurants and ocean scenery.',4.6,'06:00:00','19:00:00','8040'),
('Chapman\'s Peak Drive','Chapman\'s Peak Drive, Hout Bay','Cape Town','South Africa','Scenic Route',60.00,'Famous coastal drive between Hout Bay and Noordhoek.',4.8,'06:00:00','20:00:00','7806'),
('Old Biscuit Mill','375 Albert Road, Woodstock','Cape Town','South Africa','Market',0.00,'Market and food precinct in Woodstock.',4.4,'09:00:00','16:00:00','7925'),
('Company\'s Garden','19 Queen Victoria Street','Cape Town','South Africa','Park',0.00,'Historic public garden in central Cape Town.',4.5,'07:00:00','18:00:00','8001'),
('Norval Foundation','4 Steenberg Road, Tokai','Cape Town','South Africa','Museum',200.00,'Art museum and sculpture garden near the Constantia wine route.',4.5,'10:00:00','18:00:00','7945'),
('Groot Constantia Wine Estate','Groot Constantia Road, Constantia','Cape Town','South Africa','Wine Estate',150.00,'Historic wine estate with tastings, museum spaces and vineyard views.',4.6,'09:00:00','17:00:00','7806'),
('Hout Bay Harbour','Harbour Road, Hout Bay','Cape Town','South Africa','Harbour',0.00,'Working harbour with boat trips, seafood and mountain views.',4.3,'08:00:00','18:00:00','7806'),
('Apartheid Museum','Northern Parkway and Gold Reef Road','Johannesburg','South Africa','Museum',150.00,'Museum documenting South Africa\'s apartheid history.',4.7,'09:00:00','17:00:00','2001'),
('Gold Reef City Theme Park','Northern Parkway, Ormonde','Johannesburg','South Africa','Theme Park',250.00,'Theme park and entertainment complex themed around gold mining history.',4.5,'09:30:00','17:00:00','2159'),
('Constitution Hill','11 Kotze Street, Braamfontein','Johannesburg','South Africa','Historical',100.00,'Historic prison complex and home of South Africa\'s Constitutional Court.',4.6,'09:00:00','17:00:00','2001'),
('Soweto Towers','Chris Hani Road, Soweto','Johannesburg','South Africa','Adventure',0.00,'Landmark painted cooling towers offering adventure activities.',4.5,'10:00:00','18:00:00','1804'),
('Mandela House','8115 Vilakazi Street, Orlando West','Johannesburg','South Africa','Museum',60.00,'Former home of Nelson Mandela in Soweto.',4.5,'09:00:00','17:00:00','1804'),
('Hector Pieterson Museum','8287 Khumalo Street, Orlando West','Johannesburg','South Africa','Museum',30.00,'Museum commemorating the 1976 Soweto uprising.',4.6,'10:00:00','17:00:00','1804'),
('Maboneng Precinct','Fox Street, City and Suburban','Johannesburg','South Africa','Leisure',0.00,'Urban arts, food and entertainment precinct in Johannesburg.',4.3,'09:00:00','20:00:00','2094'),
('Johannesburg Zoo','Jan Smuts Avenue, Parkview','Johannesburg','South Africa','Wildlife',120.00,'Large city zoo with animal exhibits and family activities.',4.3,'08:30:00','17:30:00','2193'),
('Walter Sisulu National Botanical Garden','Malcolm Road, Roodepoort','Johannesburg','South Africa','Nature',100.00,'Botanical garden known for scenery, birdlife and the waterfall.',4.7,'08:00:00','17:00:00','1732'),
('Cradle of Humankind Visitor Centre Maropeng','R400, Cradle of Humankind','Johannesburg','South Africa','Heritage',175.00,'Visitor centre for the Cradle of Humankind World Heritage Site.',4.5,'09:00:00','17:00:00','1747'),
('Sterkfontein Caves','Kromdraai Road','Johannesburg','South Africa','Heritage',150.00,'Famous fossil cave site in the Cradle of Humankind area.',4.4,'09:00:00','16:00:00','1739'),
('Nelson Mandela Square','5th Street, Sandton','Johannesburg','South Africa','Leisure',0.00,'Shopping and dining square with a large Nelson Mandela statue.',4.4,'09:00:00','21:00:00','2196'),
('Sandton City','83 Rivonia Road, Sandton','Johannesburg','South Africa','Shopping',0.00,'Major shopping centre in Sandton.',4.5,'09:00:00','21:00:00','2196'),
('Rosebank Sunday Market','50 Bath Avenue, Rosebank','Johannesburg','South Africa','Market',0.00,'Weekend market with crafts, food and local stalls.',4.3,'09:00:00','16:00:00','2196'),
('Origins Centre Museum','Yale Road, University of the Witwatersrand','Johannesburg','South Africa','Museum',80.00,'Museum focused on human origins and rock art heritage.',4.5,'10:00:00','17:00:00','2001'),
('Lindfield Victorian House Museum','72 Richmond Avenue, Auckland Park','Johannesburg','South Africa','Museum',100.00,'Historic Victorian house museum in Auckland Park.',4.5,'10:00:00','17:00:00','2092'),
('James Hall Museum of Transport','Pioneers Park, Rosettenville Road','Johannesburg','South Africa','Museum',50.00,'Museum with transport and vehicle exhibits.',4.3,'09:00:00','16:30:00','2190'),
('Delta Park','77 Craighall Road, Victory Park','Johannesburg','South Africa','Park',0.00,'Large city park with walking routes and green spaces.',4.4,'06:00:00','18:00:00','2195'),
('Zoo Lake','60 Jan Smuts Avenue, Parkview','Johannesburg','South Africa','Park',0.00,'Public park and lake area popular for picnics and walks.',4.4,'06:00:00','18:00:00','2193'),
('The Wilds Nature Reserve','Houghton Drive, Houghton','Johannesburg','South Africa','Nature',0.00,'Urban nature reserve with walking paths and city views.',4.5,'06:00:00','18:00:00','2198'),
('Stone Town','Stone Town','Zanzibar','Tanzania','Cultural',0.00,'Historic old town known for narrow streets, architecture and markets.',4.7,'08:00:00','20:00:00','71101'),
('House of Wonders','Mizingani Road, Stone Town','Zanzibar','Tanzania','Historical',0.00,'Historic landmark building in Stone Town.',4.2,'09:00:00','17:00:00','71101'),
('Old Fort of Zanzibar','Mizingani Road, Stone Town','Zanzibar','Tanzania','Historical',0.00,'Historic fort near Forodhani Gardens and the seafront.',4.3,'09:00:00','18:00:00','71101'),
('Forodhani Gardens','Mizingani Road, Stone Town','Zanzibar','Tanzania','Market',0.00,'Seafront gardens known for evening food stalls and views.',4.5,'16:00:00','22:00:00','71101'),
('Darajani Market','Creek Road, Stone Town','Zanzibar','Tanzania','Market',0.00,'Busy market area for local food, spices and daily trading.',4.3,'08:00:00','18:00:00','71101'),
('Prison Island','Changuu Island','Zanzibar','Tanzania','Nature',250.00,'Island excursion known for history, beaches and giant tortoises.',4.5,'08:00:00','17:00:00','71101'),
('Jozani Chwaka Bay National Park','Jozani Forest Road','Zanzibar','Tanzania','Wildlife',180.00,'Forest reserve known for red colobus monkeys and mangrove walks.',4.6,'07:30:00','17:00:00','72107'),
('Nakupenda Beach','Nakupenda Sandbank','Zanzibar','Tanzania','Beach',350.00,'Sandbank excursion with swimming and beach scenery.',4.7,'08:00:00','17:00:00','71101'),
('Nungwi Beach','Nungwi Beach','Zanzibar','Tanzania','Beach',0.00,'Popular northern beach with swimming, resorts and sunset views.',4.7,'06:00:00','19:00:00','73107'),
('Kendwa Beach','Kendwa Beach','Zanzibar','Tanzania','Beach',0.00,'Beach area known for calm water and sunset views.',4.7,'06:00:00','19:00:00','73109'),
('Paje Beach','Paje Beach','Zanzibar','Tanzania','Beach',0.00,'East coast beach known for kitesurfing and long sandy stretches.',4.6,'06:00:00','19:00:00','72110'),
('Jambiani Beach','Jambiani Beach','Zanzibar','Tanzania','Beach',0.00,'Quiet coastal village beach with relaxed island scenery.',4.6,'06:00:00','19:00:00','72107'),
('Mnemba Island Atoll','Mnemba Atoll','Zanzibar','Tanzania','Marine',450.00,'Marine excursion area known for snorkelling and clear waters.',4.7,'08:00:00','16:00:00','73111'),
('Cheetah\'s Rock','Kama Village','Zanzibar','Tanzania','Wildlife',350.00,'Wildlife conservation visitor experience near Stone Town.',4.8,'08:30:00','17:00:00','71110'),
('Mnarani Marine Turtles Conservation Pond','Nungwi','Zanzibar','Tanzania','Wildlife',120.00,'Conservation pond and visitor site focused on marine turtles.',4.4,'09:00:00','17:00:00','73107'),
('Kizimkazi Dolphin Area','Kizimkazi','Zanzibar','Tanzania','Marine',300.00,'Southern coastal area commonly used for dolphin and boat trips.',4.2,'07:00:00','15:00:00','72100'),
('Spice Farm Tour','Dole Village','Zanzibar','Tanzania','Cultural',150.00,'Guided spice farm experience explaining Zanzibar\'s spice heritage.',4.5,'09:00:00','16:00:00','71110'),
('The Rock Area Pingwe','Michamvi Pingwe','Zanzibar','Tanzania','Viewpoint',0.00,'Scenic coastal stop near the famous Rock Restaurant area.',4.5,'10:00:00','18:00:00','72111'),
('Kuza Cave','Jambiani','Zanzibar','Tanzania','Nature',120.00,'Limestone cave and cultural centre near Jambiani.',4.6,'08:30:00','17:00:00','72107'),
('Zanzibar Butterfly Centre','Pete Village','Zanzibar','Tanzania','Nature',100.00,'Butterfly conservation centre close to Jozani Forest.',4.4,'09:00:00','17:00:00','72107'),
('Nairobi National Park','Langata Road','Nairobi','Kenya','Wildlife',600.00,'Wildlife park located close to Nairobi city centre.',4.8,'06:00:00','18:00:00','00506'),
('David Sheldrick Wildlife Trust Elephant Nursery','Magadi Road, Langata','Nairobi','Kenya','Wildlife',300.00,'Elephant orphanage visitor experience in Nairobi.',4.8,'11:00:00','12:00:00','00509'),
('Giraffe Centre','Duma Road, Langata','Nairobi','Kenya','Wildlife',250.00,'Conservation centre where visitors can see and feed giraffes.',4.7,'09:00:00','17:00:00','00509'),
('Karen Blixen Museum','Karen Road','Nairobi','Kenya','Museum',120.00,'Museum at the former home of Karen Blixen.',4.5,'09:30:00','18:00:00','00502'),
('Bomas of Kenya','Langata Road','Nairobi','Kenya','Cultural',200.00,'Cultural centre presenting traditional Kenyan music, dance and homesteads.',4.4,'10:00:00','18:00:00','00509'),
('Nairobi National Museum','Museum Hill Road','Nairobi','Kenya','Museum',200.00,'National museum with cultural, natural history and heritage exhibits.',4.5,'08:30:00','17:30:00','00100'),
('Karura Forest','Limuru Road','Nairobi','Kenya','Nature',100.00,'Urban forest with walking, cycling and nature trails.',4.7,'06:00:00','18:00:00','00621'),
('Uhuru Park','Uhuru Highway','Nairobi','Kenya','Park',0.00,'Central public park used for leisure walks and city views.',4.2,'06:00:00','18:00:00','00100'),
('Kenyatta International Convention Centre','Harambee Avenue','Nairobi','Kenya','Viewpoint',150.00,'Convention centre with a popular rooftop viewpoint.',4.4,'08:00:00','18:00:00','00100'),
('Railway Museum','Workshop Road','Nairobi','Kenya','Museum',100.00,'Museum with railway history and locomotive exhibits.',4.3,'08:30:00','17:00:00','00100'),
('Maasai Market','Various Locations','Nairobi','Kenya','Market',0.00,'Open-air craft market selling local art, textiles and souvenirs.',4.3,'09:00:00','18:00:00','00100'),
('Village Market','Limuru Road, Gigiri','Nairobi','Kenya','Shopping',0.00,'Shopping and entertainment centre in Gigiri.',4.5,'09:00:00','21:00:00','00621'),
('Kazuri Beads','Mbagathi Ridge, Karen','Nairobi','Kenya','Cultural',0.00,'Workshop and craft centre known for handmade ceramic beads.',4.6,'08:30:00','17:00:00','00502'),
('Ngong Hills','Ngong Road','Nairobi','Kenya','Nature',200.00,'Scenic hills popular for hiking and views outside Nairobi.',4.6,'06:00:00','18:00:00','00208'),
('Oloolua Nature Trail','Karen','Nairobi','Kenya','Nature',100.00,'Nature trail with forest walks, caves and picnic areas.',4.4,'09:00:00','18:00:00','00502'),
('August 7th Memorial Park','Moi Avenue','Nairobi','Kenya','Historical',50.00,'Memorial park and museum in central Nairobi.',4.3,'08:00:00','17:00:00','00100'),
('Jamia Mosque Nairobi','Banda Street','Nairobi','Kenya','Cultural',0.00,'Landmark mosque and architectural site in central Nairobi.',4.5,'08:00:00','18:00:00','00100'),
('Nairobi Gallery','Kenyatta Avenue','Nairobi','Kenya','Museum',100.00,'Art and heritage gallery housed in a historic building.',4.3,'08:30:00','17:30:00','00100'),
('Westgate Shopping Mall','Mwanzi Road, Westlands','Nairobi','Kenya','Shopping',0.00,'Modern shopping and entertainment centre in Westlands.',4.4,'09:00:00','21:00:00','00800'),
('Two Rivers Mall','Limuru Road, Ruaka','Nairobi','Kenya','Shopping',0.00,'Large shopping and leisure mall near Nairobi.',4.5,'09:00:00','21:00:00','00100');
/*!40000 ALTER TABLE `attraction_import_africa` ENABLE KEYS */;
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
(4,'Langata Road','Nairobi','Kenya','00100'),
(5,'V&A Waterfront, Nelson Mandela Gateway','Cape Town','South Africa','8001'),
(6,'19 Dock Road','Cape Town','South Africa','8001'),
(7,'Rhodes Drive, Newlands','Cape Town','South Africa','7735'),
(8,'Cape Point Road','Cape Town','South Africa','7975'),
(9,'Kleintuin Road, Simon\'s Town','Cape Town','South Africa','7995'),
(10,'Dock Road, V&A Waterfront','Cape Town','South Africa','8001'),
(11,'25A Buitenkant Street','Cape Town','South Africa','8001'),
(12,'Darling Street','Cape Town','South Africa','8001'),
(13,'71 Wale Street','Cape Town','South Africa','8001'),
(14,'Silo District, V&A Waterfront','Cape Town','South Africa','8001'),
(15,'Signal Hill Road','Cape Town','South Africa','8001'),
(16,'Victoria Road, Clifton','Cape Town','South Africa','8005'),
(17,'Victoria Road, Camps Bay','Cape Town','South Africa','8040'),
(18,'Chapman\'s Peak Drive, Hout Bay','Cape Town','South Africa','7806'),
(19,'375 Albert Road, Woodstock','Cape Town','South Africa','7925'),
(20,'19 Queen Victoria Street','Cape Town','South Africa','8001'),
(21,'4 Steenberg Road, Tokai','Cape Town','South Africa','7945'),
(22,'Groot Constantia Road, Constantia','Cape Town','South Africa','7806'),
(23,'Harbour Road, Hout Bay','Cape Town','South Africa','7806'),
(24,'Northern Parkway and Gold Reef Road','Johannesburg','South Africa','2001'),
(25,'Northern Parkway, Ormonde','Johannesburg','South Africa','2159'),
(26,'11 Kotze Street, Braamfontein','Johannesburg','South Africa','2001'),
(27,'Chris Hani Road, Soweto','Johannesburg','South Africa','1804'),
(28,'8115 Vilakazi Street, Orlando West','Johannesburg','South Africa','1804'),
(29,'8287 Khumalo Street, Orlando West','Johannesburg','South Africa','1804'),
(30,'Fox Street, City and Suburban','Johannesburg','South Africa','2094'),
(31,'Jan Smuts Avenue, Parkview','Johannesburg','South Africa','2193'),
(32,'Malcolm Road, Roodepoort','Johannesburg','South Africa','1732'),
(33,'R400, Cradle of Humankind','Johannesburg','South Africa','1747'),
(34,'Kromdraai Road','Johannesburg','South Africa','1739'),
(35,'5th Street, Sandton','Johannesburg','South Africa','2196'),
(36,'83 Rivonia Road, Sandton','Johannesburg','South Africa','2196'),
(37,'50 Bath Avenue, Rosebank','Johannesburg','South Africa','2196'),
(38,'Yale Road, University of the Witwatersrand','Johannesburg','South Africa','2001'),
(39,'72 Richmond Avenue, Auckland Park','Johannesburg','South Africa','2092'),
(40,'Pioneers Park, Rosettenville Road','Johannesburg','South Africa','2190'),
(41,'77 Craighall Road, Victory Park','Johannesburg','South Africa','2195'),
(42,'60 Jan Smuts Avenue, Parkview','Johannesburg','South Africa','2193'),
(43,'Houghton Drive, Houghton','Johannesburg','South Africa','2198'),
(44,'Stone Town','Zanzibar','Tanzania','71101'),
(45,'Mizingani Road, Stone Town','Zanzibar','Tanzania','71101'),
(46,'Mizingani Road, Stone Town','Zanzibar','Tanzania','71101'),
(47,'Mizingani Road, Stone Town','Zanzibar','Tanzania','71101'),
(48,'Creek Road, Stone Town','Zanzibar','Tanzania','71101'),
(49,'Changuu Island','Zanzibar','Tanzania','71101'),
(50,'Jozani Forest Road','Zanzibar','Tanzania','72107'),
(51,'Nakupenda Sandbank','Zanzibar','Tanzania','71101'),
(52,'Nungwi Beach','Zanzibar','Tanzania','73107'),
(53,'Kendwa Beach','Zanzibar','Tanzania','73109'),
(54,'Paje Beach','Zanzibar','Tanzania','72110'),
(55,'Jambiani Beach','Zanzibar','Tanzania','72107'),
(56,'Mnemba Atoll','Zanzibar','Tanzania','73111'),
(57,'Kama Village','Zanzibar','Tanzania','71110'),
(58,'Nungwi','Zanzibar','Tanzania','73107'),
(59,'Kizimkazi','Zanzibar','Tanzania','72100'),
(60,'Dole Village','Zanzibar','Tanzania','71110'),
(61,'Michamvi Pingwe','Zanzibar','Tanzania','72111'),
(62,'Jambiani','Zanzibar','Tanzania','72107'),
(63,'Pete Village','Zanzibar','Tanzania','72107'),
(64,'Magadi Road, Langata','Nairobi','Kenya','00509'),
(65,'Duma Road, Langata','Nairobi','Kenya','00509'),
(66,'Karen Road','Nairobi','Kenya','00502'),
(67,'Langata Road','Nairobi','Kenya','00509'),
(68,'Museum Hill Road','Nairobi','Kenya','00100'),
(69,'Limuru Road','Nairobi','Kenya','00621'),
(70,'Uhuru Highway','Nairobi','Kenya','00100'),
(71,'Harambee Avenue','Nairobi','Kenya','00100'),
(72,'Workshop Road','Nairobi','Kenya','00100'),
(73,'Various Locations','Nairobi','Kenya','00100'),
(74,'Limuru Road, Gigiri','Nairobi','Kenya','00621'),
(75,'Mbagathi Ridge, Karen','Nairobi','Kenya','00502'),
(76,'Ngong Road','Nairobi','Kenya','00208'),
(77,'Karen','Nairobi','Kenya','00502'),
(78,'Moi Avenue','Nairobi','Kenya','00100'),
(79,'Banda Street','Nairobi','Kenya','00100'),
(80,'Kenyatta Avenue','Nairobi','Kenya','00100'),
(81,'Mwanzi Road, Westlands','Nairobi','Kenya','00800'),
(82,'Limuru Road, Ruaka','Nairobi','Kenya','00100');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(3,5,2,2,57000.00,'pending','2026-05-13 00:08:15'),
(4,3,1,1,15999.00,'confirmed','2026-05-24 22:29:02'),
(5,3,5,2,57998.00,'confirmed','2026-06-01 09:15:00'),
(6,3,9,1,8999.00,'pending','2026-06-03 11:30:00'),
(7,3,10,2,25998.00,'cancelled','2026-06-05 14:20:00'),
(8,3,11,1,10999.00,'confirmed','2026-06-07 10:00:00'),
(9,3,16,2,45998.00,'pending','2026-06-09 16:45:00'),
(10,3,17,2,79998.00,'confirmed','2026-06-11 13:10:00'),
(11,3,20,3,74997.00,'confirmed','2026-06-13 08:40:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `destination` WRITE;
/*!40000 ALTER TABLE `destination` DISABLE KEYS */;
INSERT INTO `destination` VALUES
(1,'Cape Town','South Africa','A travel destination in Cape Town, South Africa.',NULL),
(2,'Zanzibar','Tanzania','A travel destination in Zanzibar, Tanzania.',NULL),
(3,'Johannesburg','South Africa','A travel destination in Johannesburg, South Africa.',NULL),
(4,'Nairobi','Kenya','A travel destination in Nairobi, Kenya.',NULL),
(5,'San Francisco','United States','A travel destination in San Francisco, United States.',NULL),
(6,'Hackensack','United States','A travel destination in Hackensack, United States.',NULL),
(7,'Poughkeepsie','United States','A travel destination in Poughkeepsie, United States.',NULL),
(8,'Plano','United States','A travel destination in Plano, United States.',NULL),
(9,'Syracuse','United States','A travel destination in Syracuse, United States.',NULL),
(10,'Federal Way','United States','A travel destination in Federal Way, United States.',NULL),
(11,'Dallas','United States','A travel destination in Dallas, United States.',NULL),
(12,'Renton','United States','A travel destination in Renton, United States.',NULL),
(13,'Ithaca','United States','A travel destination in Ithaca, United States.',NULL),
(14,'Vancouver','United States','A travel destination in Vancouver, United States.',NULL),
(15,'Kirkland','United States','A travel destination in Kirkland, United States.',NULL),
(16,'Albany','United States','A travel destination in Albany, United States.',NULL),
(17,'Montclair','United States','A travel destination in Montclair, United States.',NULL),
(18,'Princeton','United States','A travel destination in Princeton, United States.',NULL),
(19,'Pasadena','United States','A travel destination in Pasadena, United States.',NULL),
(20,'Bellevue','United States','A travel destination in Bellevue, United States.',NULL),
(21,'Saratoga Springs','United States','A travel destination in Saratoga Springs, United States.',NULL),
(22,'Anaheim','United States','A travel destination in Anaheim, United States.',NULL),
(23,'Frisco','United States','A travel destination in Frisco, United States.',NULL),
(24,'Atlantic City','United States','A travel destination in Atlantic City, United States.',NULL),
(25,'Bothell','United States','A travel destination in Bothell, United States.',NULL),
(26,'San Diego','United States','A travel destination in San Diego, United States.',NULL),
(27,'Seattle','United States','A travel destination in Seattle, United States.',NULL),
(28,'Teaneck','United States','A travel destination in Teaneck, United States.',NULL),
(29,'Santa Monica','United States','A travel destination in Santa Monica, United States.',NULL),
(30,'Staten Island','United States','A travel destination in Staten Island, United States.',NULL),
(31,'Toms River','United States','A travel destination in Toms River, United States.',NULL),
(32,'Laredo','United States','A travel destination in Laredo, United States.',NULL),
(33,'Bakersfield','United States','A travel destination in Bakersfield, United States.',NULL),
(34,'Los Angeles','United States','A travel destination in Los Angeles, United States.',NULL),
(35,'Amarillo','United States','A travel destination in Amarillo, United States.',NULL),
(36,'Long Beach','United States','A travel destination in Long Beach, United States.',NULL),
(37,'New York City','United States','A travel destination in New York City, United States.',NULL),
(38,'Freehold','United States','A travel destination in Freehold, United States.',NULL),
(39,'Austin','United States','A travel destination in Austin, United States.',NULL),
(40,'Fresno','United States','A travel destination in Fresno, United States.',NULL),
(41,'Berkeley','United States','A travel destination in Berkeley, United States.',NULL),
(42,'Yonkers','United States','A travel destination in Yonkers, United States.',NULL),
(43,'San Jose','United States','A travel destination in San Jose, United States.',NULL),
(44,'Fort Worth','United States','A travel destination in Fort Worth, United States.',NULL),
(45,'Riverside','United States','A travel destination in Riverside, United States.',NULL),
(46,'Newport Beach','United States','A travel destination in Newport Beach, United States.',NULL),
(47,'Waco','United States','A travel destination in Waco, United States.',NULL),
(48,'Huntington Beach','United States','A travel destination in Huntington Beach, United States.',NULL),
(49,'Kennewick','United States','A travel destination in Kennewick, United States.',NULL),
(50,'Ship Bottom','United States','A travel destination in Ship Bottom, United States.',NULL),
(51,'El Paso','United States','A travel destination in El Paso, United States.',NULL),
(52,'Forest Hills','United States','A travel destination in Forest Hills, United States.',NULL),
(53,'Puyallup','United States','A travel destination in Puyallup, United States.',NULL),
(54,'Sacramento','United States','A travel destination in Sacramento, United States.',NULL),
(55,'Bellingham','United States','A travel destination in Bellingham, United States.',NULL),
(56,'Tustin','United States','A travel destination in Tustin, United States.',NULL),
(57,'Spokane Valley','United States','A travel destination in Spokane Valley, United States.',NULL),
(58,'Kent','United States','A travel destination in Kent, United States.',NULL),
(59,'Cherry Hill','United States','A travel destination in Cherry Hill, United States.',NULL),
(60,'New Brunswick','United States','A travel destination in New Brunswick, United States.',NULL),
(61,'Katy','United States','A travel destination in Katy, United States.',NULL),
(62,'Everett','United States','A travel destination in Everett, United States.',NULL),
(63,'The Woodlands','United States','A travel destination in The Woodlands, United States.',NULL),
(64,'Palm Springs','United States','A travel destination in Palm Springs, United States.',NULL),
(65,'Cedar Grove','United States','A travel destination in Cedar Grove, United States.',NULL),
(66,'Elizabeth','United States','A travel destination in Elizabeth, United States.',NULL),
(67,'South Ozone Park','United States','A travel destination in South Ozone Park, United States.',NULL),
(68,'Newark','United States','A travel destination in Newark, United States.',NULL),
(132,'Durban','South Africa','A travel destination in Durban, South Africa.',NULL),
(133,'Mombasa','Kenya','A travel destination in Mombasa, Kenya.',NULL),
(134,'Cairo','Egypt','A travel destination in Cairo, Egypt.',NULL),
(135,'Marrakech','Morocco','A travel destination in Marrakech, Morocco.',NULL),
(136,'Accra','Ghana','A travel destination in Accra, Ghana.',NULL),
(137,'Lagos','Nigeria','A travel destination in Lagos, Nigeria.',NULL),
(138,'Kigali','Rwanda','A travel destination in Kigali, Rwanda.',NULL),
(139,'Windhoek','Namibia','A travel destination in Windhoek, Namibia.',NULL),
(140,'Victoria Falls','Zimbabwe','A travel destination in Victoria Falls, Zimbabwe.',NULL),
(141,'Lusaka','Zambia','A travel destination in Lusaka, Zambia.',NULL),
(142,'Maputo','Mozambique','A travel destination in Maputo, Mozambique.',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(4,'Airlink','CPT','JNB','2026-07-17 16:00:00','2026-07-17 18:00:00','Economy,Business',1100.00,NULL),
(5,'South African Airways','JNB','CPT','2026-07-03 08:00:00','2026-07-03 10:10:00','Economy,Business',1850.00,NULL),
(6,'South African Airways','CPT','JNB','2026-07-08 16:00:00','2026-07-08 18:10:00','Economy,Business',1900.00,NULL),
(7,'FlySafair','JNB','CPT','2026-07-10 09:30:00','2026-07-10 11:40:00','Economy',1450.00,NULL),
(8,'FlySafair','CPT','JNB','2026-07-15 17:30:00','2026-07-15 19:40:00','Economy',1500.00,NULL),
(9,'Airlink','JNB','CPT','2026-07-17 07:15:00','2026-07-17 09:25:00','Economy,Business',1750.00,NULL),
(10,'Airlink','CPT','JNB','2026-07-22 15:15:00','2026-07-22 17:25:00','Economy,Business',1800.00,NULL),
(11,'Lift Airline','JNB','CPT','2026-07-24 10:00:00','2026-07-24 12:10:00','Economy',1650.00,NULL),
(12,'Lift Airline','CPT','JNB','2026-07-29 18:00:00','2026-07-29 20:10:00','Economy',1700.00,NULL),
(13,'FlySafair','JNB','CPT','2026-08-07 06:45:00','2026-08-07 08:55:00','Economy',1250.00,NULL),
(14,'FlySafair','CPT','JNB','2026-08-11 14:45:00','2026-08-11 16:55:00','Economy',1300.00,NULL),
(15,'South African Airways','CPT','JNB','2026-07-04 08:20:00','2026-07-04 10:30:00','Economy,Business',1850.00,NULL),
(16,'South African Airways','JNB','CPT','2026-07-09 16:20:00','2026-07-09 18:30:00','Economy,Business',1900.00,NULL),
(17,'FlySafair','CPT','JNB','2026-07-11 09:10:00','2026-07-11 11:20:00','Economy',1450.00,NULL),
(18,'FlySafair','JNB','CPT','2026-07-16 17:10:00','2026-07-16 19:20:00','Economy',1500.00,NULL),
(19,'Airlink','CPT','JNB','2026-07-18 07:40:00','2026-07-18 09:50:00','Economy,Business',1750.00,NULL),
(20,'Airlink','JNB','CPT','2026-07-22 15:40:00','2026-07-22 17:50:00','Economy,Business',1800.00,NULL),
(21,'South African Airways','CPT','JNB','2026-07-25 08:00:00','2026-07-25 10:10:00','Economy,Business',2050.00,NULL),
(22,'South African Airways','JNB','CPT','2026-07-30 16:00:00','2026-07-30 18:10:00','Economy,Business',2100.00,NULL),
(23,'Lift Airline','CPT','JNB','2026-08-01 10:30:00','2026-08-01 12:40:00','Economy',1650.00,NULL),
(24,'Lift Airline','JNB','CPT','2026-08-06 18:30:00','2026-08-06 20:40:00','Economy',1700.00,NULL),
(25,'Kenya Airways','JNB','ZNZ','2026-07-05 07:00:00','2026-07-05 10:35:00','Economy,Business',6200.00,NULL),
(26,'Kenya Airways','ZNZ','JNB','2026-07-11 15:00:00','2026-07-11 18:40:00','Economy,Business',6400.00,NULL),
(27,'Air Tanzania','JNB','ZNZ','2026-07-12 09:00:00','2026-07-12 12:35:00','Economy,Business',5800.00,NULL),
(28,'Air Tanzania','ZNZ','JNB','2026-07-18 17:00:00','2026-07-18 20:40:00','Economy,Business',6000.00,NULL),
(29,'Kenya Airways','JNB','ZNZ','2026-07-19 07:30:00','2026-07-19 11:05:00','Economy,Business',6500.00,NULL),
(30,'Kenya Airways','ZNZ','JNB','2026-07-26 15:30:00','2026-07-26 19:10:00','Economy,Business',6700.00,NULL),
(31,'Ethiopian Airlines','JNB','ZNZ','2026-07-26 08:15:00','2026-07-26 11:50:00','Economy,Business',6100.00,NULL),
(32,'Ethiopian Airlines','ZNZ','JNB','2026-08-01 16:15:00','2026-08-01 19:55:00','Economy,Business',6300.00,NULL),
(33,'Air Tanzania','JNB','ZNZ','2026-08-09 09:30:00','2026-08-09 13:05:00','Economy,Business',5200.00,NULL),
(34,'Air Tanzania','ZNZ','JNB','2026-08-14 17:30:00','2026-08-14 21:10:00','Economy,Business',5400.00,NULL),
(35,'Kenya Airways','JNB','NBO','2026-07-06 08:00:00','2026-07-06 12:10:00','Economy,Business',4800.00,NULL),
(36,'Kenya Airways','NBO','JNB','2026-07-11 16:00:00','2026-07-11 20:15:00','Economy,Business',5000.00,NULL),
(37,'Kenya Airways','JNB','NBO','2026-07-13 07:45:00','2026-07-13 11:55:00','Economy,Business',5200.00,NULL),
(38,'Kenya Airways','NBO','JNB','2026-07-18 15:45:00','2026-07-18 20:00:00','Economy,Business',5400.00,NULL),
(39,'South African Airways','JNB','NBO','2026-07-20 09:15:00','2026-07-20 13:25:00','Economy,Business',4700.00,NULL),
(40,'South African Airways','NBO','JNB','2026-07-25 17:15:00','2026-07-25 21:30:00','Economy,Business',4900.00,NULL),
(41,'Kenya Airways','JNB','NBO','2026-07-27 08:30:00','2026-07-27 12:40:00','Economy,Business',4900.00,NULL),
(42,'Kenya Airways','NBO','JNB','2026-08-01 16:30:00','2026-08-01 20:45:00','Economy,Business',5100.00,NULL),
(43,'Ethiopian Airlines','JNB','NBO','2026-08-10 09:00:00','2026-08-10 13:10:00','Economy,Business',4300.00,NULL),
(44,'Ethiopian Airlines','NBO','JNB','2026-08-14 17:00:00','2026-08-14 21:15:00','Economy,Business',4500.00,NULL);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `flight_import_packages`
--

DROP TABLE IF EXISTS `flight_import_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_import_packages` (
  `package_title` varchar(200) DEFAULT NULL,
  `airline_name` varchar(100) DEFAULT NULL,
  `departure_airport` char(3) DEFAULT NULL,
  `arrival_airport` char(3) DEFAULT NULL,
  `dept_date` datetime DEFAULT NULL,
  `arrival_datetime` datetime DEFAULT NULL,
  `classes` set('Economy','Business','First') DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_import_packages`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `flight_import_packages` WRITE;
/*!40000 ALTER TABLE `flight_import_packages` DISABLE KEYS */;
INSERT INTO `flight_import_packages` VALUES
('Cape Town Luxury Waterfront Escape','South African Airways','JNB','CPT','2026-07-03 08:00:00','2026-07-03 10:10:00','Economy,Business',1850.00),
('Cape Town Luxury Waterfront Escape','South African Airways','CPT','JNB','2026-07-08 16:00:00','2026-07-08 18:10:00','Economy,Business',1900.00),
('Cape Town Family Adventure','FlySafair','JNB','CPT','2026-07-10 09:30:00','2026-07-10 11:40:00','Economy',1450.00),
('Cape Town Family Adventure','FlySafair','CPT','JNB','2026-07-15 17:30:00','2026-07-15 19:40:00','Economy',1500.00),
('Cape Town Culture and Heritage Tour','Airlink','JNB','CPT','2026-07-17 07:15:00','2026-07-17 09:25:00','Economy,Business',1750.00),
('Cape Town Culture and Heritage Tour','Airlink','CPT','JNB','2026-07-22 15:15:00','2026-07-22 17:25:00','Economy,Business',1800.00),
('Cape Town Beach and Scenic Drive Break','Lift Airline','JNB','CPT','2026-07-24 10:00:00','2026-07-24 12:10:00','Economy',1650.00),
('Cape Town Beach and Scenic Drive Break','Lift Airline','CPT','JNB','2026-07-29 18:00:00','2026-07-29 20:10:00','Economy',1700.00),
('Cape Town Budget City Break','FlySafair','JNB','CPT','2026-08-07 06:45:00','2026-08-07 08:55:00','Economy',1250.00),
('Cape Town Budget City Break','FlySafair','CPT','JNB','2026-08-11 14:45:00','2026-08-11 16:55:00','Economy',1300.00),
('Johannesburg Heritage Experience','South African Airways','CPT','JNB','2026-07-04 08:20:00','2026-07-04 10:30:00','Economy,Business',1850.00),
('Johannesburg Heritage Experience','South African Airways','JNB','CPT','2026-07-09 16:20:00','2026-07-09 18:30:00','Economy,Business',1900.00),
('Johannesburg Urban Explorer','FlySafair','CPT','JNB','2026-07-11 09:10:00','2026-07-11 11:20:00','Economy',1450.00),
('Johannesburg Urban Explorer','FlySafair','JNB','CPT','2026-07-16 17:10:00','2026-07-16 19:20:00','Economy',1500.00),
('Johannesburg Family Weekend','Airlink','CPT','JNB','2026-07-18 07:40:00','2026-07-18 09:50:00','Economy,Business',1750.00),
('Johannesburg Family Weekend','Airlink','JNB','CPT','2026-07-22 15:40:00','2026-07-22 17:50:00','Economy,Business',1800.00),
('Johannesburg Luxury Sandton Stay','South African Airways','CPT','JNB','2026-07-25 08:00:00','2026-07-25 10:10:00','Economy,Business',2050.00),
('Johannesburg Luxury Sandton Stay','South African Airways','JNB','CPT','2026-07-30 16:00:00','2026-07-30 18:10:00','Economy,Business',2100.00),
('Johannesburg History and Wildlife Mix','Lift Airline','CPT','JNB','2026-08-01 10:30:00','2026-08-01 12:40:00','Economy',1650.00),
('Johannesburg History and Wildlife Mix','Lift Airline','JNB','CPT','2026-08-06 18:30:00','2026-08-06 20:40:00','Economy',1700.00),
('Zanzibar Luxury Beach Escape','Kenya Airways','JNB','ZNZ','2026-07-05 07:00:00','2026-07-05 10:35:00','Economy,Business',6200.00),
('Zanzibar Luxury Beach Escape','Kenya Airways','ZNZ','JNB','2026-07-11 15:00:00','2026-07-11 18:40:00','Economy,Business',6400.00),
('Zanzibar Stone Town and Spice Tour','Air Tanzania','JNB','ZNZ','2026-07-12 09:00:00','2026-07-12 12:35:00','Economy,Business',5800.00),
('Zanzibar Stone Town and Spice Tour','Air Tanzania','ZNZ','JNB','2026-07-18 17:00:00','2026-07-18 20:40:00','Economy,Business',6000.00),
('Zanzibar Honeymoon Retreat','Kenya Airways','JNB','ZNZ','2026-07-19 07:30:00','2026-07-19 11:05:00','Economy,Business',6500.00),
('Zanzibar Honeymoon Retreat','Kenya Airways','ZNZ','JNB','2026-07-26 15:30:00','2026-07-26 19:10:00','Economy,Business',6700.00),
('Zanzibar Adventure and Snorkelling Package','Ethiopian Airlines','JNB','ZNZ','2026-07-26 08:15:00','2026-07-26 11:50:00','Economy,Business',6100.00),
('Zanzibar Adventure and Snorkelling Package','Ethiopian Airlines','ZNZ','JNB','2026-08-01 16:15:00','2026-08-01 19:55:00','Economy,Business',6300.00),
('Zanzibar Budget Island Break','Air Tanzania','JNB','ZNZ','2026-08-09 09:30:00','2026-08-09 13:05:00','Economy,Business',5200.00),
('Zanzibar Budget Island Break','Air Tanzania','ZNZ','JNB','2026-08-14 17:30:00','2026-08-14 21:10:00','Economy,Business',5400.00),
('Nairobi Safari Starter Package','Kenya Airways','JNB','NBO','2026-07-06 08:00:00','2026-07-06 12:10:00','Economy,Business',4800.00),
('Nairobi Safari Starter Package','Kenya Airways','NBO','JNB','2026-07-11 16:00:00','2026-07-11 20:15:00','Economy,Business',5000.00),
('Nairobi Luxury Wildlife Escape','Kenya Airways','JNB','NBO','2026-07-13 07:45:00','2026-07-13 11:55:00','Economy,Business',5200.00),
('Nairobi Luxury Wildlife Escape','Kenya Airways','NBO','JNB','2026-07-18 15:45:00','2026-07-18 20:00:00','Economy,Business',5400.00),
('Nairobi Culture and City Tour','South African Airways','JNB','NBO','2026-07-20 09:15:00','2026-07-20 13:25:00','Economy,Business',4700.00),
('Nairobi Culture and City Tour','South African Airways','NBO','JNB','2026-07-25 17:15:00','2026-07-25 21:30:00','Economy,Business',4900.00),
('Nairobi Family Wildlife Holiday','Kenya Airways','JNB','NBO','2026-07-27 08:30:00','2026-07-27 12:40:00','Economy,Business',4900.00),
('Nairobi Family Wildlife Holiday','Kenya Airways','NBO','JNB','2026-08-01 16:30:00','2026-08-01 20:45:00','Economy,Business',5100.00),
('Nairobi Budget Explorer','Ethiopian Airlines','JNB','NBO','2026-08-10 09:00:00','2026-08-10 13:10:00','Economy,Business',4300.00),
('Nairobi Budget Explorer','Ethiopian Airlines','NBO','JNB','2026-08-14 17:00:00','2026-08-14 21:15:00','Economy,Business',4500.00);
/*!40000 ALTER TABLE `flight_import_packages` ENABLE KEYS */;
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
  `status` enum('active','inactive','sold_out') NOT NULL DEFAULT 'active',
  `img_url` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`package_id`),
  KEY `agent_id` (`agent_id`),
  KEY `dest_id` (`dest_id`),
  CONSTRAINT `1` FOREIGN KEY (`agent_id`) REFERENCES `travelagent` (`agent_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`dest_id`) REFERENCES `destination` (`dest_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES
(1,1,1,'Cape Town Explorer','7-day Cape Town experience including Table Mountain, wine estates and coastal drives.',15999.00,'2026-09-30',20,'active','images/packages/one.jpg','2026-05-13 00:04:36'),
(2,1,2,'Zanzibar Island Escape','10-day tropical getaway to the spice island with beach resorts and cultural tours.',28500.00,'2026-10-31',15,'active','images/packages/two.jpg','2026-05-13 00:04:36'),
(3,2,4,'Nairobi Safari Adventure','8-day Kenyan safari including Nairobi National Park and the Masai Mara.',42000.00,'2026-11-30',10,'active','images/packages/three.jpg','2026-05-13 00:04:36'),
(4,2,1,'Cape Town Budget Break','5-day budget-friendly Cape Town trip for solo backpackers.',8500.00,'2026-08-31',30,'active','images/packages/four.jpg','2026-05-13 00:04:36'),
(5,1,1,'Cape Town Luxury Waterfront Escape','A premium Cape Town package including luxury accommodation, waterfront dining, Table Mountain and coastal sightseeing.',28999.00,'2026-12-31',9,'active','images/packages/five.jpg','2026-05-25 20:21:00'),
(6,1,1,'Cape Town Family Adventure','A family-friendly Cape Town holiday with aquarium visits, beaches, Table Mountain and relaxed restaurant options.',18999.00,'2026-12-31',20,'active','images/packages/six.jpg','2026-05-25 20:21:00'),
(7,2,1,'Cape Town Culture and Heritage Tour','A cultural package focused on Robben Island, District Six, Bo-Kaap, museums and local food experiences.',16999.00,'2026-11-30',18,'active','images/packages/seven.jpg','2026-05-25 20:21:00'),
(8,2,1,'Cape Town Beach and Scenic Drive Break','A coastal Cape Town package including Camps Bay, Clifton, Chapmans Peak, Hout Bay and seafood restaurants.',15999.00,'2026-10-31',25,'active','images/packages/eight.jpg','2026-05-25 20:21:00'),
(9,1,1,'Cape Town Budget City Break','A shorter affordable Cape Town package for travellers who want hotels, city attractions and flexible activities.',8999.00,'2026-09-30',30,'active','images/packages/nine.jpg','2026-05-25 20:21:00'),
(10,1,3,'Johannesburg Heritage Experience','A Johannesburg package covering the Apartheid Museum, Constitution Hill, Soweto, Mandela House and local restaurants.',12999.00,'2026-12-31',20,'active','images/packages/ten.jpg','2026-05-25 20:21:00'),
(11,2,3,'Johannesburg Urban Explorer','A city package with Maboneng, Rosebank, Sandton, food markets, shopping and cultural attractions.',10999.00,'2026-11-30',24,'active','images/packages/eleven.jpg','2026-05-25 20:21:00'),
(12,2,3,'Johannesburg Family Weekend','A family-focused Johannesburg package including the zoo, Gold Reef City, parks and relaxed hotel stays.',9999.00,'2026-10-31',28,'active','images/packages/twelve.jpg','2026-05-25 20:21:00'),
(13,1,3,'Johannesburg Luxury Sandton Stay','A premium Sandton package with luxury accommodation, fine dining, shopping and private city transfers.',21999.00,'2026-12-31',10,'active','images/packages/thirteen.jpg','2026-05-25 20:21:00'),
(14,2,3,'Johannesburg History and Wildlife Mix','A mixed package combining city heritage attractions with nature stops such as Walter Sisulu Botanical Garden and nearby wildlife experiences.',14999.00,'2026-11-30',16,'active','images/packages/fourteen.jpg','2026-05-25 20:21:00'),
(15,1,2,'Zanzibar Luxury Beach Escape','A luxury island package with beachfront resort accommodation, beach activities, Stone Town and seafood dining.',34999.00,'2026-12-31',14,'active','images/packages/fifteen.jpg','2026-05-25 20:21:00'),
(16,2,2,'Zanzibar Stone Town and Spice Tour','A cultural Zanzibar package focused on Stone Town, spice farms, Forodhani Gardens and Swahili cuisine.',22999.00,'2026-11-30',18,'active','images/packages/sixteen.jpg','2026-05-25 20:21:00'),
(17,1,2,'Zanzibar Honeymoon Retreat','A romantic island package with resort accommodation, beach dinners, sunset experiences and relaxed sightseeing.',39999.00,'2026-12-31',8,'active','images/packages/seventeen.jpg','2026-05-25 20:21:00'),
(18,2,2,'Zanzibar Adventure and Snorkelling Package','An active package including Mnemba Atoll, Prison Island, beaches, marine attractions and casual island restaurants.',26999.00,'2026-10-31',16,'active','images/packages/eighteen.jpg','2026-05-25 20:21:00'),
(19,1,2,'Zanzibar Budget Island Break','A more affordable Zanzibar package with guesthouse or mid-range hotel stays, beaches and selected cultural activities.',17999.00,'2026-09-30',25,'active','images/packages/nineteen.jpg','2026-05-25 20:21:00'),
(20,2,4,'Nairobi Safari Starter Package','A Nairobi package including Nairobi National Park, the Giraffe Centre, elephant nursery and comfortable hotel stays.',24999.00,'2026-12-31',18,'active','images/packages/twenty.jpg','2026-05-25 20:21:00'),
(21,1,4,'Nairobi Luxury Wildlife Escape','A premium Nairobi package with luxury accommodation, wildlife attractions, private transfers and curated dining.',36999.00,'2026-12-31',10,'active','images/packages/twentyone.jpg','2026-05-25 20:21:00'),
(22,2,4,'Nairobi Culture and City Tour','A city-focused Nairobi package including museums, markets, cultural stops, restaurants and central accommodation.',15999.00,'2026-11-30',22,'active','images/packages/twentytwo.jpg','2026-05-25 20:21:00'),
(23,1,4,'Nairobi Family Wildlife Holiday','A family-friendly package with Nairobi National Park, Giraffe Centre, museums, parks and relaxed dining options.',19999.00,'2026-10-31',20,'active','images/packages/twentythree.jpg','2026-05-25 20:21:00'),
(24,2,4,'Nairobi Budget Explorer','An affordable Nairobi package with selected attractions, mid-range accommodation and flexible restaurant options.',12999.00,'2026-09-30',30,'active','images/packages/twentyfour.jpg','2026-05-25 20:21:00');
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
(3,4),
(5,6),
(7,9),
(6,12),
(8,17),
(9,21),
(13,25),
(14,29),
(10,31),
(11,35),
(12,39),
(16,45),
(15,56),
(18,57),
(19,59),
(17,62),
(22,64),
(21,67),
(23,74),
(20,75),
(24,75);
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
(3,4,'Depart for Masai Mara','07:00:00','Road transfer to Masai Mara camp.'),
(5,1,'Arrival and hotel check-in','14:00:00','Arrive in Cape Town, transfer to the hotel, check in and enjoy a relaxed evening at the V&A Waterfront.'),
(5,2,'Table Mountain and city tour','09:00:00','Visit Table Mountain Aerial Cableway, Company Gardens and the Bo-Kaap area.'),
(5,3,'Robben Island and Waterfront dinner','09:00:00','Take the ferry to Robben Island, return to the V&A Waterfront and enjoy dinner nearby.'),
(5,4,'Cape Point and Boulders Beach','08:00:00','Full-day coastal tour including Cape Point Nature Reserve and the penguin colony at Boulders Beach.'),
(5,5,'Beach morning and departure','10:00:00','Enjoy a relaxed morning at Camps Bay or Clifton before hotel checkout and airport transfer.'),
(10,1,'Arrival in Johannesburg','15:00:00','Arrive in Johannesburg, transfer to the hotel and settle in.'),
(10,2,'Apartheid Museum and Gold Reef City','09:00:00','Visit the Apartheid Museum in the morning, followed by leisure time at Gold Reef City.'),
(10,3,'Soweto heritage tour','09:00:00','Visit Vilakazi Street, Mandela House and the Hector Pieterson Museum.'),
(10,4,'Constitution Hill and Maboneng','10:00:00','Explore Constitution Hill, then spend the afternoon in Maboneng for food, art and shopping.'),
(10,5,'Sandton and departure','10:00:00','Enjoy a relaxed morning at Nelson Mandela Square before checkout and departure.'),
(16,1,'Arrival in Zanzibar','14:00:00','Arrive in Zanzibar, transfer to the hotel and enjoy a relaxed evening near the seafront.'),
(16,2,'Stone Town walking tour','09:00:00','Explore Stone Town, the Old Fort, Forodhani Gardens and local markets.'),
(16,3,'Spice farm experience','10:00:00','Visit a spice farm and learn about Zanzibar’s spice trade and local food culture.'),
(16,4,'Prison Island and beach afternoon','08:30:00','Take a boat trip to Prison Island, then enjoy a relaxed afternoon at the beach.'),
(16,5,'Forodhani food evening','17:00:00','Spend the evening at Forodhani Gardens and enjoy local street food.'),
(16,6,'Departure','10:00:00','Breakfast, checkout and airport transfer.'),
(20,1,'Arrival in Nairobi','15:00:00','Arrive in Nairobi, transfer to the hotel and settle in.'),
(20,2,'Nairobi National Park game drive','06:00:00','Early morning game drive at Nairobi National Park, followed by a relaxed afternoon.'),
(20,3,'Elephant nursery and Giraffe Centre','10:00:00','Visit the David Sheldrick Elephant Nursery and the Giraffe Centre in Langata.'),
(20,4,'Karen Blixen Museum and Bomas of Kenya','09:30:00','Visit Karen Blixen Museum, then enjoy a cultural experience at Bomas of Kenya.'),
(20,5,'City market and departure','10:00:00','Visit a local market for souvenirs before checkout and airport transfer.');
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
(1,4),
(5,5),
(5,6),
(6,7),
(6,8),
(7,9),
(7,10),
(8,11),
(8,12),
(9,13),
(9,14),
(10,15),
(10,16),
(11,17),
(11,18),
(12,19),
(12,20),
(13,21),
(13,22),
(14,23),
(14,24),
(15,25),
(15,26),
(16,27),
(16,28),
(17,29),
(17,30),
(18,31),
(18,32),
(19,33),
(19,34),
(20,35),
(20,36),
(21,37),
(21,38),
(22,39),
(22,40),
(23,41),
(23,42),
(24,43),
(24,44);
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
(3,4),
(5,132),
(8,132),
(6,133),
(7,133),
(9,133),
(7,134),
(6,135),
(9,135),
(5,136),
(8,136),
(12,137),
(14,137),
(10,138),
(14,138),
(12,139),
(13,139),
(10,140),
(11,140),
(11,141),
(13,141),
(16,147),
(19,147),
(15,148),
(17,148),
(16,149),
(19,149),
(17,150),
(15,151),
(18,151),
(20,152),
(23,152),
(22,153),
(24,153),
(22,154),
(23,154),
(24,154),
(21,155),
(20,156),
(21,156);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(3,3,'Credit Card','pending','2026-05-13 00:08:36','TXN-2026-003',57000.00),
(4,4,'Credit Card','completed','2026-05-24 22:39:02','KAT-4-202605242229',15999.00),
(5,5,'Credit Card','completed','2026-06-01 09:25:00','KAT-5-202606010915',57998.00),
(6,6,'EFT','pending','2026-06-03 11:40:00','KAT-6-202606031130',8999.00),
(7,7,'EFT','refunded','2026-06-05 14:30:00','KAT-7-202606051420',25998.00),
(8,8,'Credit Card','completed','2026-06-07 10:10:00','KAT-8-202606071000',10999.00),
(9,9,'EFT','pending','2026-06-09 16:55:00','KAT-9-202606091645',45998.00),
(10,10,'Credit Card','completed','2026-06-11 13:20:00','KAT-10-202606111310',79998.00),
(11,11,'Credit Card','completed','2026-06-13 08:50:00','KAT-11-202606130840',74997.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(4,4,'Carnivore Restaurant','Barbecue',750.00,'Famous Nairobi restaurant serving exotic meats.',4.6,NULL),
(5,5,'Betty Lou\'s Seafood and Grill','Seafood, Vegetarian Friendly, Vegan Options',250.00,'Betty Lou\'s Seafood and Grill is a restaurant located in San Francisco.',4.5,NULL),
(6,6,'Coach House Diner','Diner, American, Vegetarian Friendly',250.00,'Both times we were there very late, after 11 PM.  At that time in many diners (forget restaurants!) you get warmed-over food and lousy service.  Not so here - food was uniformly very good and the service quite good.  There weren\'t many people but it...More',4.0,NULL),
(7,7,'Table Talk Diner','American, Diner, Vegetarian Friendly',250.00,'Waitress was very friendly but a little pricey for a diner but the food was delicious \nThe menu had a wide variety of foods to choose from but any choice would have been a good one',4.0,NULL),
(8,8,'Sixty Vines','American, Wine Bar, Vegetarian Friendly',250.00,'Not sure why I went there for the second time. Will not go again. Not because it was terrible but because it is just average.  \nThe place needs a food clean .... our menus were filthy...the table was filthy \nIt is impossible to have a...More',4.5,NULL),
(9,9,'The Clam Bar','American, Bar, Seafood',250.00,'Doesn\'t look like much from the outside but walk in either the front door or back door and get greeted and sat almost immediately. Waitress was amazing and very helpful with the very large variety that they offer. My wife and I were very satisfied...More',4.0,NULL),
(10,5,'E Tutto Qua','Seafood, Italian, Pizza',250.00,'E Tutto Qua is a restaurant located in San Francisco.',4.5,NULL),
(11,10,'Black Angus Steakhouse - Federal Way','American, Steakhouse, Bar',250.00,'This is an easy any time place to have dinner!  From week night to a special occasion.  The food is reasonably priced and always delicious!',4.0,NULL),
(12,11,'Ziziki\'s','Mediterranean, Greek, Healthy',250.00,'My husband and I went to Greece last fall and fell in love with the beauty and the food so while on a  Dallas business trip, we came across Ziziki\'s and thought we\'d give it a go knowing that this was risky after 2 weeks...More',4.5,NULL),
(13,12,'Vince\'s Italian Restaurant & Pizzeria','Italian, Pizza, Vegetarian Friendly',250.00,'I love Vince\'s pizza and I was in the neighborhood after a meeting. I had a small pizza and salad.  Both were delicious and as I would expect. The service was friendly and attentive. The delivery was as quick as one can expect for a...More',4.0,NULL),
(14,13,'John Thomas Steakhouse','American, Steakhouse, Gluten Free Options',250.00,'The ambience, food and service were all excellent. With a student at Cornell we look forward to more dinners there!',4.0,NULL),
(15,13,'ZaZa\'s Cucina','Italian, Vegetarian Friendly, Gluten Free Options',250.00,'Nice big dining area.  Holds many people, so never feels crowded.  Food and cocktails are really good.',4.0,NULL),
(16,14,'Dulin\'s Cafe','Cafe, American, Vegetarian Friendly',250.00,'This is the place if you\'re into the combo of excellent and sincerely unpretentious.  I\'m not usually a breakfast lover - but I\'ll be back here to try their corned beef on potatoes and a few other treats.',4.5,NULL),
(17,15,'Wilde Rover Irish Pub & Restaurant','Irish, Bar, Pub',250.00,'Have been here before. This time it was disappointing. Beer variety and selection as always good but food wasn´t worth the price-\nFish and meet portion in general small and all close to well-done.\nService personal wasn´t committed. Once we finished the dinner plates were...More',4.0,NULL),
(18,16,'New World Bistro Bar','American, Bar, Vegetarian Friendly',250.00,'Came with a group of eight people, and had a wonderful evening.  The food was a wide variety, and very high quality.  Service was excellent.  The flatbread deluxe hamburger was a unique burger, and extremely tasty.  The spicy grilled green bean appetizer platter was outstanding....More',4.5,NULL),
(19,17,'Red Eye Cafe','American, Cafe, Healthy',250.00,'My first time in this part of Montclair. Since I arrived at 12.15 pm, there was never ending influx of customers for a good 2 hours.  As busy as this restaurant is, we were not rushed and we fully enjoyed our food while enjoying our...More',4.5,NULL),
(20,18,'Winberies Princeton','American, Bar, Pub',250.00,'We brought our family here for dinner on a Saturday. It was busy but the staff was very attentive and our food did not take too long. The tiger tots were amazing!  The rest of our food was good as well. A little noisy and...More',4.0,NULL),
(21,19,'Malbec','Steakhouse, Latin, Argentinean',250.00,'Malbec is a restaurant located in Pasadena.',4.5,NULL),
(22,20,'Din Tai Fung','Chinese, Asian, Taiwanese',250.00,'Din Tai Fung has always been inconstantly great.  The dumplings, noodles, and rice dishes are sublime and the service is fast and friendly. \n\nWhile everything is great and fresh ]make sure you do not forget your vegetables as the greens here are a work of...More',4.5,NULL),
(23,21,'Ravenous','Belgian, French, Cafe',250.00,'The food and service were very good, but the size of the portions relative to price were a little disappointing.  They did nicely accommodate our large family gathering, which was nice!  The poutine was outstanding!More',4.5,NULL),
(24,22,'Mimi\'s Cafe','American, Cajun & Creole, Vegetarian Friendly',250.00,'Mimi\'s Cafe is a restaurant located in Anaheim.',4.0,NULL),
(25,23,'La Hacienda Ranch','Steakhouse, Mexican, Vegetarian Friendly',250.00,'Food always great and the margaritas are THE BEST. Wait staff are always courteous and friendly. Best TexMex in town.',4.0,NULL),
(26,24,'Breadsticks Cafe & Grill','American, Vegetarian Friendly, Vegan Options',250.00,'We dined for lunch (group of four) and all ordered the 3-course offering for $18.99\nExcellent value and the quality was exceptional. Food was fresh,\n hot and adequately portioned.No disappointment.\n\nBetter than the food(which is hard to do)was our attentive pleasant server Eden. She truly...More',4.0,NULL),
(27,25,'Revolve True Food & Wine Bar','Bar, Contemporary, Fusion',250.00,'Took my fiancé here for Valentine’s Day. She discovered a while back that she has a gluten allergy which has really limited what she can eat. I on the other hand, was very skeptical. Long story short, the food was delicious and I left very...More',4.0,NULL),
(28,26,'The Lion\'s Share','American, Bar, Gluten Free Options',250.00,'The Lion\'s Share is a restaurant located in San Diego.',4.5,NULL),
(29,27,'Tilikum Place Cafe','American, European, Vegetarian Friendly',250.00,'One of our favorite brunch place in Seattle. Came back for the second time while we were in town. Food is absolutely lovely but the baked potatoes were a bit too dry for my taste. Overall, great place for brunch.',4.5,NULL),
(30,28,'BV Tuscany Italian Restaurant','Italian, Vegetarian Friendly, Gluten Free Options',250.00,'BV Tuscany is in a great location with shops and a local movie theater. We always find street parking close by. The food is delicious so fresh, excellent quality. The service is always on point so friendly too! Its very romantic inside. The desserts are...More',4.5,NULL),
(31,29,'The Misfit Restaurant & Bar','American, Bar, Contemporary',250.00,'The Misfit Restaurant & Bar is a restaurant located in Santa Monica.',4.5,NULL),
(32,30,'Beso','Latin, Spanish, Vegetarian Friendly',250.00,'This place is horrible!!!!!  They dont know how to treat customers especially when they are at fault.  This place is ran by idiots and the owner should be ashamed of who he has representing him. I was a loyal customer for 4 years and after...More',4.5,NULL),
(33,31,'Social 37','American, Bar, Gastropub',250.00,'Went recently on a saturday night for a birthday celebration. We do like the atmosphere. it\'s loud but we didn\'t mind. the menu is very eclectic and appealing. problem is most everything just left the little bit to be desired. mainly not enough in the...More',4.0,NULL),
(34,15,'Ristorante Paradiso','Italian, Vegetarian Friendly, Gluten Free Options',250.00,'We live part time in Italy and are tough critics of many Italian restaurants in the US.  Paradise surprised us with two excellent dishes that would have been very good in Italy.  The pasta with cream sauce and sausage was super.  Very rich and creamy...More',4.5,NULL),
(35,32,'Tabernilla','Spanish, Mediterranean, Wine Bar',250.00,'Unique tapas menu - NOT a Mexican restaurant! My waiter made excellent recommendations and of course, the small portions or “tapas”, made it ideal to try several. \n\nEverything I ordered was de-lish!\n\nClassy, relaxing ambiance.',5.0,NULL),
(36,24,'Buddakan','Chinese, Asian, Vegetarian Friendly',250.00,'I can\'t tell you enough of how amazing the food here is. The edamam ravioli are to die for. There is not one dish I didn\'t like. This is my favorite part of visiting Atlantic City',4.5,NULL),
(37,33,'Hodel\'s Country Dining','American, Vegetarian Friendly, Vegan Options',250.00,'Hodel\'s Country Dining is a restaurant located in Bakersfield.',4.0,NULL),
(38,34,'Magic Castle','American, Vegetarian Friendly',250.00,'Magic Castle is a restaurant located in Los Angeles.',4.5,NULL),
(39,35,'Jorge\'s Mexican Restaurant','Mexican, Southwestern, Vegetarian Friendly',250.00,'Decent service.  Nothing to write home about.  Got the fajitas and the meat was way over seasoned and the beef was super chewy. The tortillas were the only good thing of that meal.  My sister got the stuffed avocado meal and was not good.  It...More',4.0,NULL),
(40,23,'Ziziki\'s at The Star','Mediterranean, Greek, Italian',250.00,'Great staff, super atmosphere and superb staff! If you like Greek food, this place is a must!  Compared to the other restaurants at The Star, it is actually not overcrowded.  Well worth a visit!',4.5,NULL),
(41,36,'The Attic','Cajun & Creole, American, Vegetarian Friendly',250.00,'The Attic is a restaurant located in Long Beach.',4.5,NULL),
(42,37,'Del Posto','Italian, Vegetarian Friendly, Vegan Options',250.00,'Fabulous!  Deserves the Michelin Star that it already has.  We had the 5 course dinner on a wintry Sunday night.  All 5 courses were marvelous!  Having said that, the linguine with geoduck was my favorite, followed closely by the veal/tuna/sweetbread appetizer.  Pork agnolotti and branzino...More',4.5,NULL),
(43,38,'Moore\'s Tavern & Restaurant','American, Bar, Pub',250.00,'On Tuesdays Moore\'s has 2 for 1 burgers. The burgers are good and large. The service however was not so good. My wife ordered bacon with her burger but did not get it. When we mentioned this to the waitress so we wouldn\'t be charged...More',3.5,NULL),
(44,17,'Fin Raw Bar and Kitchen','American, Seafood',250.00,'Oh the food is the freshest ever. Sushi bar rocks. Wait staff good looking, fun and helpful in selecting from the awesome dishes and specials. Fish tacos are superb. This is also best run location.',4.0,NULL),
(45,39,'The Capital Grille','American, Steakhouse, Gluten Free Options',250.00,'Such a nice evening! Professional and kind service in a cozy atmosphere. Everything was delicious. We shared oysters, truffle fries and asparagus. We both had beautiful steaks. Would go monthly if I lived here.',4.5,NULL),
(46,40,'The Cheesecake Factory','American, Vegetarian Friendly, Vegan Options',250.00,'The Cheesecake Factory is a restaurant located in Fresno.',4.0,NULL),
(47,27,'Pizzeria Credo','Italian, Pizza, Vegetarian Friendly',250.00,'Six of us dined here last night - Carbonara, pizzas, gnocchi, caprese and desserts were all excellent - both taste and presentation.  Warm, friendly and attentive service. Love this place!  A new favorite in Seattle.',4.5,NULL),
(48,41,'Cheeseboard Pizza','Pizza, Vegetarian Friendly, Vegan Options',250.00,'Cheeseboard Pizza is a restaurant located in Berkeley.',4.5,NULL),
(49,22,'Cortina\'s Italian Market & Pizzeria','Italian, Pizza, Deli',250.00,'Cortina\'s Italian Market & Pizzeria is a restaurant located in Anaheim.',4.5,NULL),
(50,42,'Havana Central','Caribbean, Latin, Spanish',250.00,'We came with high hopes and left underwhelmed. We were hoping for something a bit different, and interesting. The waitress spent more time describing drinks than food, which made me realise that this was more of a bar than a restaurant. And the food was...More',3.5,NULL),
(51,43,'Yard House','American, Bar, Pub',250.00,'Yard House is a restaurant located in San Jose.',4.0,NULL),
(52,32,'Siete Banderas','Mexican',250.00,'We had my daughter-in-law’s baby shower and we invited a large group of friends and family to celebrate the future birth of my granddaughter.  Siete Banderas restaurant offers a varied and delicious brunch items.  Everybody enjoyed the food and drinks.',4.5,NULL),
(53,5,'Jeanne D\'Arc Restaurant','French, European, Vegetarian Friendly',250.00,'Jeanne D\'Arc Restaurant is a restaurant located in San Francisco.',4.5,NULL),
(54,32,'Luby\'s Cafeteria Mall Del Norte','',250.00,'Located inside the Mall Del Norte, this is a rather small but clean Luby\'s.  The food and service are usually quite good.',4.0,NULL),
(55,23,'Norma\'s Cafe','American, Cafe, Diner',250.00,'Great home style food. Yummy breakfast. Large portions. Have tried chicken strips, burgers, chicken fried steak and pies. All great!',4.5,NULL),
(56,44,'Lonesome Dove Western Bistro','American, Southwestern, Vegetarian Friendly',250.00,'What a fantastic experience. The bartender was very knowledgeable about the menu and a joy to talk with.  Our server Joe as knowledgeable and attentive. The food was Devine.  The appetizers were out of this world.  I had the elk for my main course and...More',4.5,NULL),
(57,15,'KathaKali Indian Eatery','Indian, Asian, Vegetarian Friendly',250.00,'We thoroughly enjoyed our Valentine’s Weekend dinner here!  We’d been advised by a friend to arrive early on a weekend, so we arrived as they opened for the dinner service @ 5:30 (they don’t accept weekend reservations).  By 6:00 pm there was a line of...More',4.5,NULL),
(58,45,'Mission Galleria','Cafe',250.00,'Mission Galleria is a restaurant located in Riverside.',4.5,NULL),
(59,43,'Bill\'s Cafe','American, Cafe, International',250.00,'Bill\'s Cafe is a restaurant located in San Jose.',4.5,NULL),
(60,23,'MASH\'D','American, Bar, International',250.00,'If you are in Frisco you have to stop here. The Drinks are amazing. Service is great. Food is great.',4.5,NULL),
(61,46,'Eddie V\'s Wildfish','American, Seafood, Vegetarian Friendly',250.00,'Eddie V\'s Wildfish is a restaurant located in Newport Beach.',4.5,NULL),
(62,47,'Buzzard Billy\'s','American, Bar, Seafood',250.00,'We sure enjoyed our meal and the margaritas we had at Buzzard Billy’s. The place was hard to get to because of construction but well worth it. It’s on the river and has a great view and was very nice indoors with friendly staff.',3.5,NULL),
(63,15,'Anthony\'s HomePort','American, Seafood, Vegetarian Friendly',250.00,'The 3 course menu for $25 is available anytime in January which is a good deal. The salmon dip and northwest duet were good. However the salmon dip was only accompanied by a couple of crackers and slices of apple. The hot fudge sundae for...More',4.0,NULL),
(64,10,'Kwan Tip Thai','Asian, Thai, Vegetarian Friendly',250.00,'We had a meeting in Federal Way that was going to end late, and I knew we needed to get to lunch right away, so I researched places. This sounded good, and am I glad we went!  We had the Kwan Tip Wings, which was...More',4.5,NULL),
(65,48,'Longboard Restaurant & Pub','American, Bar, Pub',250.00,'Longboard Restaurant & Pub is a restaurant located in Huntington Beach.',4.0,NULL),
(66,15,'Acropolis Pizza & Pasta','Greek, Italian, Pizza',250.00,'This place has been run by the same family since they opened in 1973.  I had a salad and a half meatball grinder, sliced meatballs with tomato sauce and cheese.  These things are delicious but can be messy to eat.  Imagine if it had round...More',4.0,NULL),
(67,49,'Cedars at Pier One','American, Seafood, Bar',250.00,'We were excited to go here and have an early Valentine\'s Day dinner, Thursday, the day before the holiday and see if things had changed with the new owner. We sat in the lounge while we waited for our table. The atmosphere was relaxed, the...More',4.0,NULL),
(68,50,'Bisque Restaurant','American, Seafood, Gluten Free Options',250.00,'Three star restaurant, open all year BYOB.Classy, elegant dining. Wine glasses, table cloths. There’s not one thing on the fine menu that I would not try! Great Chef! You got me hooked!!!🤙🤙🤙',4.5,NULL),
(69,51,'Rosco\'s Burger Inn','American, Diner',250.00,'We had a Cheeseburger and Cujo dog! Onion rings were impressive- the straight cut French fries were golden, brown and delicious. The bowl of chili with onions and cheese was good and perfectly spicy. The spicy ketchup and salsa served in squeeze bottles are also...More',4.5,NULL),
(70,37,'The Capital Grille','American, Steakhouse, Vegetarian Friendly',250.00,'Service was great and the steaks were awesome. I highly recommend this Capital Grill when In NYC. Everyone was accomodating.',4.5,NULL),
(71,13,'Maxie\'s Supper Club and Oyster Bar','American, Bar, Seafood',250.00,'They nailed the Cajun atmosphere, felt like we could be dining in a New Orleans restaurant! Our waitress was very bubbly, attentive and informative. We ordered oysters from 3 different north eastern states. I had only had oysters from the gulf and never knew they...More',4.0,NULL),
(72,6,'The Cheesecake Factory','American, Vegetarian Friendly, Vegan Options',250.00,'Lots of bread and butter to start.\nExpensive, small drinks with too much ice no matter what you ask for.\nBig bowls of cheap lettuce with minimal nothing special ingredients.\nAND - $9 a slice for their 2,000 calorie cheesecake lol. Argh! \nStay away please...More',4.0,NULL),
(73,16,'677 Prime','American, Steakhouse, Gluten Free Options',250.00,'Tremendous service.  Nice atmosphere.  Ordered the large filet mignon and it had a lot of grisly fat in the middle.  Didn\'t complain cause im not one for that, but that is a few times now where my steak there was well below average.  I prefer...More',4.5,NULL),
(74,52,'Bareburger','American, Vegetarian Friendly, Vegan Options',250.00,'We ordered from this location \nAnd I\'ll say excellent burgers.  \nGood size..  Very tasty\nBut very pricey',4.0,NULL),
(75,15,'Oto Sushi','Japanese, Sushi, Asian',250.00,'We had the Mt St Helens special.  It’s a roll with avocado and crab meat inside and a fish variety on the outside.  It was great and creative.  The sushi we had was all very good.  \n\nThe soba noodle was mediocre, so don’t go for...More',4.0,NULL),
(76,14,'Planet Thai','Asian, Thai, Vegetarian Friendly',250.00,'Recently received a score of 60 from health department.  A score of 100 or higher  is closing the establishment \nDon\'t think I\'ll be back.',4.5,NULL),
(77,40,'Red Apple Cafe','American, Cafe, Vegetarian Friendly',250.00,'Red Apple Cafe is a restaurant located in Fresno.',4.5,NULL),
(78,53,'Ayothaya Thai Restaurant','Thai, Asian, Vegan Options',250.00,'An extensive menu that does not disappoint. This is my go-to place for Thai food near home. I love both the Tom Yum and the Tom Ka soups. I often just order the soup with a side of rice for an excellent meal.',4.5,NULL),
(79,54,'Mulvaney\'s Building & Loan','American, Vegetarian Friendly, Vegan Options',250.00,'Mulvaney\'s Building & Loan is a restaurant located in Sacramento.',4.5,NULL),
(80,55,'Fat Pie Pizza','Italian, American, Pizza',250.00,'Even a boy from Brooklyn NY enjoyed the pizza. Nice soft pizza with good cheese, mushrooms and pepperoni. Also had a bison burger which was cooked the way we like it. \n\nAnd the staff was extremely helpful and attentive. We carried out and everything was...More',4.5,NULL),
(81,39,'Jack Allen\'s Kitchen','American, Southwestern, Bar',250.00,'Had a valentine dinner with my wife. She had the grilled ruby red trout and she said it was excellent. I had the crispy fried red fish and it was excellent. Our waiter was very personable and excellent service.',4.5,NULL),
(82,56,'Rutabegorz','American, Vegetarian Friendly, Vegan Options',250.00,'Rutabegorz is a restaurant located in Tustin.',4.5,NULL),
(83,39,'La Volpe','Italian, American, Seafood',250.00,'What Can I say ? When in Austin you should visit La Volpe, my first time around and by far I am already in love. I had no idea about the restaurant but my mom is from around and she told me about this incredible...More',4.5,NULL),
(84,57,'Brother\'s Office Pizzeria','Pizza, Vegetarian Friendly',250.00,'We have been to both Valley locations, multiple times. The stores are not really that big so finding a place to sit can sometimes be difficult. Not a place to bring more than about 6-8 people. Their pizza is quite excellent,  maybe in the Spokane...More',4.5,NULL),
(85,58,'Gorkha Durbar','Asian, Indian, Tibetan',250.00,'Our group of 4 was limited in knowledge of the restaruant fare.  Our server, Anis, was very helpful in suggesting items that made our dining experience very enjoyable.  We enjoyed panner momos, spinach naan, vegetable thukpa, mango chicken, and lamb saag.  With our restaurant.com coupon,...More',4.5,NULL),
(86,44,'H3 Ranch','American, Steakhouse, Southwestern',250.00,'My first time visiting this restaurant. Oh my!! It was phenomenal from walking in the doors to walking out with a full stomach! Service, food, atmosphere, prices... I was not disappointed by any means.',4.5,NULL),
(87,41,'Ajanta Distinctive Indian Cuisine','Indian, Vegetarian Friendly, Vegan Options',250.00,'Ajanta Distinctive Indian Cuisine is a restaurant located in Berkeley.',4.5,NULL),
(88,33,'Black Angus Steakhouse','American, Steakhouse, Bar',250.00,'Black Angus Steakhouse is a restaurant located in Bakersfield.',4.0,NULL),
(89,34,'Off Vine','American, Contemporary, Vegetarian Friendly',250.00,'Off Vine is a restaurant located in Los Angeles.',4.5,NULL),
(90,59,'Seasons 52','American, Wine Bar, Vegetarian Friendly',250.00,'The food was very very good.\nOver priced in my opinion, but extremely good. Not a big selection to choose from.\nThe waitress was extremely good in the beginning but tended to ignore us at the end. \nThe place was so crowded people were standing...More',4.5,NULL),
(91,60,'Esquina Latina','Latin, Cuban, Caribbean',250.00,'Visted on a sat night...busy so make sure you reserve a table...moderately priced....excellent portions...started with 3 beef empanadas....tasty and not greasy at all....also had the cuban chorizo..could have been spicier..but it was excellent...for entrees stuffed porkchop with chorizo and manchego cheese....smothered in pears and onions...also...More',4.0,NULL),
(92,61,'Pane e Vino','Italian, Pizza, Vegetarian Friendly',250.00,'We heard about Pane e Vino from a friend and decided to try it.  We were met by the owner and escorted to our table.  Three of us ordered the lasagna and thought it was really good.  The fourth person ordered the veal picatta and...More',4.5,NULL),
(93,62,'Capers + Olives','Italian, Vegetarian Friendly',250.00,'Everything here is delicious and well-prepared from the olives to the bruschetta to the pasta (amazing--we tried three different ones and they were all scrumptious) to the mains. They have a lovely wine list and good cocktails. We went on a monday evening, called last...More',4.5,NULL),
(94,14,'Elements Restaurant','American, Vegetarian Friendly, Gluten Free Options',250.00,'My sister and I came here on Christmas Eve for dinner and it could not have been more pleasant!!  We both had melt in your mouth salmon, which was expertly prepared and we both loved!!  Also had a delightful cheesecake with wonderful coffee for dessert,...More',4.5,NULL),
(95,16,'Jack\'s Oyster House','American, Seafood, Gluten Free Options',250.00,'This restaurant feels like you are walking into the past in a good way. Greeted by a gentleman who was polite and very organized. Our waiter never stopped moving was very polite. He was good about all of our requests. We even had to make...More',4.0,NULL),
(96,16,'Yono\'s Restaurant','Indonesian, American, Vegetarian Friendly',250.00,'We’ve been in this nice and classy place for dinner with my husband and we remain very satisfied of our four corses menu! Every plate was delicious and service was awesome) The chief was attentive to every guest! Recommended!',4.5,NULL),
(97,63,'Fleming\'s Prime Steakhouse & Wine Bar','American, Steakhouse, Gluten Free Options',250.00,'Celebrating the end of 2019.  Reserved for 2 at 4:45, yet table set for four...awkward.  Lots of young families with small children. Fun to watch!  My gorgeous smart & sweet wife had the Modern Caesar Salad that comes with two pieces of petite garlic toasts....More',4.5,NULL),
(98,64,'Bill\'s Pizza','Italian, Pizza, Vegetarian Friendly',250.00,'Bill\'s Pizza is a restaurant located in Palm Springs.',4.5,NULL),
(99,65,'LuNello\'s Resturant','Italian, Vegetarian Friendly, Vegan Options',250.00,'My sisters and their husbands and I went here for my Mom’s 88th birthday. Wonderful restaurant. The food and service were spectacular. The portions were surprisingly large. But of course you pay for what you get. My brother-in-law picked up the tab, which had to...More',4.5,NULL),
(100,66,'Ironbound','American, Bar',250.00,'Ironbound - the pizza was pretty good and the beer was cold.  It was cold and rainy outside, I had returned my rental car, the service was good and it was convenient.',4.0,NULL),
(101,67,'Pizza Port','Pizza, Italian',250.00,'Deliver to hotels in area. Used them when we stayed at Holiday Inn Express Kennedy Airport. I ordered sausage parmigiana with a nice side salad. My spouse had a baked manicotti dish. Delivery did take an hour, but the dishes were still hot when delivered...More',4.0,NULL),
(102,66,'Sbarro','Italian, Pizza, Fast Food',250.00,'Black Friday everything else was very crowded so we decided to grab a quick bite here. The line moved fast so was good. The cheese pizza was good. But the veggie was below average.the spaghetti was okay',4.0,NULL),
(103,68,'Brasilia Grill','Latin, Barbecue, Brazilian',250.00,'Food and drinks are always on point. I visit 3 to 4 times a month. Today they had a guest singer. JUST AWEFUL!! He cannot sings,sounds terrible and just loud. How do you chase customers away? Have the band that played at Brasilia on Feb...More',4.0,NULL),
(132,1,'Gold Coast Grill','Seafood',350.00,'Seafood restaurant close to the waterfront with tourist friendly meals',4.5,NULL),
(133,1,'Table Bay Kitchen','Local Cuisine',350.00,'Relaxed local restaurant suitable for lunch and group dinners',4.0,NULL),
(134,1,'Karibu Flame House','Steakhouse',350.00,'Grill restaurant with generous meals and a warm city atmosphere',4.5,NULL),
(135,1,'Signal Hill Cafe','Cafe',150.00,'Casual cafe serving breakfast coffee and light meals',4.0,NULL),
(136,1,'Atlantic Spice Bistro','Fusion',350.00,'Modern bistro with seafood curries and Cape inspired dishes',4.5,NULL),
(137,3,'Braamfontein Braai House','African Grill',350.00,'Popular city grill serving braai plates and local sides',4.0,NULL),
(138,3,'Soweto Taste Kitchen','Local Cuisine',350.00,'Traditional meals in a lively tourist area',4.5,NULL),
(139,3,'Sandton Garden Bistro','International',350.00,'Modern bistro for business travellers and families',4.0,NULL),
(140,3,'Maboneng Street Food Cafe','Street Food',150.00,'Casual restaurant with local street food inspired plates',4.5,NULL),
(141,3,'Rosebank Flame Grill','Steakhouse',350.00,'Comfortable grill restaurant near hotels and shopping areas',4.0,NULL),
(142,132,'Golden Mile Seafood','Seafood',350.00,'Beachfront seafood restaurant with ocean views',4.5,NULL),
(143,132,'Umhlanga Curry House','Indian',350.00,'Curry restaurant known for spicy local Durban style dishes',4.5,NULL),
(144,132,'Berea Garden Cafe','Cafe',150.00,'Relaxed cafe with breakfasts light meals and desserts',4.0,NULL),
(145,132,'Zulu Taste Restaurant','Local Cuisine',350.00,'Restaurant serving local dishes in a tourist friendly setting',4.0,NULL),
(146,132,'Harbour View Grill','Grill',350.00,'Grill house close to the harbour and beachfront hotels',4.5,NULL),
(147,2,'Stone Town Spice Table','Swahili Cuisine',350.00,'Traditional island dishes with seafood and spice flavours',4.5,NULL),
(148,2,'Nungwi Ocean Grill','Seafood',350.00,'Beachfront restaurant serving fresh fish and island meals',4.5,NULL),
(149,2,'Forodhani Night Cafe','Street Food',150.00,'Casual evening meals inspired by the local night market',4.0,NULL),
(150,2,'Jambiani Beach Kitchen','Local Cuisine',350.00,'Coastal restaurant with relaxed beach style dining',4.5,NULL),
(151,2,'Coral Garden Bistro','Fusion',350.00,'Island bistro serving seafood salads and local dishes',4.0,NULL),
(152,4,'Nairobi Safari Grill','African Grill',350.00,'Popular grill restaurant for tourists and families',4.5,NULL),
(153,4,'Westlands Taste House','Local Cuisine',350.00,'Kenyan dishes in a modern restaurant setting',4.0,NULL),
(154,4,'Kilimani Garden Cafe','Cafe',150.00,'Relaxed cafe with breakfast and lunch options',4.0,NULL),
(155,4,'Karen Plains Bistro','International',350.00,'Quiet bistro near popular tourist routes',4.5,NULL),
(156,4,'Savannah Rooftop Dining','Fine Dining',750.00,'Rooftop restaurant with city views and African inspired meals',4.5,NULL),
(157,133,'Mombasa Harbour Grill','Seafood',350.00,'Seafood restaurant close to the old town and harbour',4.5,NULL),
(158,133,'Diani Beach Kitchen','Coastal Cuisine',350.00,'Beach style restaurant with grilled fish and local sides',4.0,NULL),
(159,133,'Swahili Spice Cafe','Swahili Cuisine',150.00,'Casual restaurant with coastal spices and rice dishes',4.5,NULL),
(160,133,'Old Town Curry House','Indian',350.00,'Curry house near historic attractions',4.0,NULL),
(161,133,'Nyali Garden Grill','Grill',350.00,'Family friendly grill restaurant in the Nyali area',4.5,NULL),
(162,134,'Khan el Khalili Kitchen','Egyptian',350.00,'Traditional Egyptian meals near historic market areas',4.5,NULL),
(163,134,'Nile View Restaurant','International',350.00,'Restaurant with Nile views and tourist friendly service',4.5,NULL),
(164,134,'Giza Pyramid Cafe','Cafe',150.00,'Casual cafe close to major sightseeing routes',4.0,NULL),
(165,134,'Zamalek Garden Bistro','Mediterranean',350.00,'Stylish bistro serving light meals and dinner plates',4.5,NULL),
(166,134,'Cairo Flame House','Grill',350.00,'Grill restaurant with meat dishes and local sides',4.0,NULL),
(167,135,'Marrakech Spice House','Moroccan',350.00,'Traditional Moroccan meals close to the old town',4.5,NULL),
(168,135,'Atlas Rooftop Restaurant','Fine Dining',750.00,'Rooftop restaurant with city views and Moroccan food',4.5,NULL),
(169,135,'Jemaa Garden Cafe','Cafe',150.00,'Casual cafe near popular market areas',4.0,NULL),
(170,135,'Palm Grove Tagine House','Local Cuisine',350.00,'Restaurant serving tagines couscous and Moroccan teas',4.5,NULL),
(171,135,'Red City Grill','Grill',350.00,'Comfortable grill house with Moroccan inspired plates',4.0,NULL),
(172,136,'Accra Palm Kitchen','Ghanaian',350.00,'Local Ghanaian meals in a tourist friendly area',4.5,NULL),
(173,136,'Osu Garden Grill','African Grill',350.00,'Grill restaurant with local sides and fresh juices',4.0,NULL),
(174,136,'Jamestown Seafood House','Seafood',350.00,'Seafood restaurant close to historic coastal areas',4.5,NULL),
(175,136,'Labadi Beach Cafe','Cafe',150.00,'Relaxed beach cafe with light meals and drinks',4.0,NULL),
(176,136,'Independence Bistro','International',350.00,'Modern bistro near central tourist attractions',4.5,NULL),
(177,137,'Lagos Island Grill','West African',350.00,'Nigerian meals and grilled dishes in the city centre',4.0,NULL),
(178,137,'Victoria Island Bistro','International',350.00,'Modern restaurant for travellers and business guests',4.5,NULL),
(179,137,'Lekki Taste Kitchen','Local Cuisine',350.00,'Restaurant serving jollof grilled fish and local favourites',4.0,NULL),
(180,137,'Eko Seafood Lounge','Seafood',350.00,'Seafood lounge close to coastal hotel areas',4.5,NULL),
(181,137,'Ikeja Cafe House','Cafe',150.00,'Casual cafe with coffee pastries and quick meals',4.0,NULL),
(182,138,'Kigali Hills Cafe','Cafe',150.00,'Modern cafe with light meals and coffee',4.0,NULL),
(183,138,'Nyamirambo Taste House','Rwandan',350.00,'Local dishes served in a friendly neighbourhood setting',4.5,NULL),
(184,138,'Kigali View Bistro','International',350.00,'Bistro with hillside views and dinner options',4.5,NULL),
(185,138,'Convention Garden Grill','Grill',350.00,'Tourist friendly grill restaurant near hotel districts',4.0,NULL),
(186,138,'Lake Kivu Seafood Table','Seafood',350.00,'Seafood inspired restaurant with relaxed service',4.5,NULL),
(187,139,'Windhoek Brau Kitchen','Grill',350.00,'Casual grill restaurant with generous portions',4.5,NULL),
(188,139,'Namib Desert Bistro','Local Cuisine',350.00,'Namibian inspired meals in a central location',4.0,NULL),
(189,139,'Eros Garden Cafe','Cafe',150.00,'Relaxed cafe serving breakfast lunch and coffee',4.0,NULL),
(190,139,'Safari Flame House','Steakhouse',350.00,'Steakhouse suitable for tourists and group dinners',4.5,NULL),
(191,139,'Dune View Restaurant','International',350.00,'Restaurant offering local and international dishes',4.0,NULL),
(192,140,'Victoria Falls River Grill','African Grill',350.00,'Grill restaurant close to the falls and hotels',4.5,NULL),
(193,140,'Zambezi Sunset Bistro','International',350.00,'Tourist friendly bistro with relaxed evening meals',4.5,NULL),
(194,140,'Rainforest Cafe','Cafe',150.00,'Casual cafe for light meals before or after activities',4.0,NULL),
(195,140,'Falls Market Kitchen','Local Cuisine',350.00,'Local restaurant serving Zimbabwean style dishes',4.0,NULL),
(196,140,'Baobab Seafood Grill','Seafood',350.00,'Seafood and grill restaurant near tourist shopping areas',4.5,NULL),
(197,141,'Lusaka Flame Grill','African Grill',350.00,'Central grill restaurant with local and regional dishes',4.0,NULL),
(198,141,'Manda Hill Cafe','Cafe',150.00,'Casual cafe near shopping and hotel areas',4.0,NULL),
(199,141,'Zambezi Taste Kitchen','Local Cuisine',350.00,'Zambian meals served in a modern restaurant setting',4.5,NULL),
(200,141,'Woodlands Bistro','International',350.00,'Bistro with dinner options for travellers',4.0,NULL),
(201,141,'Copperbelt Grill House','Steakhouse',350.00,'Steakhouse with family friendly service',4.5,NULL),
(202,142,'Maputo Bay Seafood','Seafood',350.00,'Seafood restaurant with bay views and fresh fish',4.5,NULL),
(203,142,'Polana Garden Bistro','Portuguese',350.00,'Mozambican and Portuguese inspired meals in a stylish setting',4.5,NULL),
(204,142,'Baixa Flame Grill','Grill',350.00,'Central grill house suitable for tourists and families',4.0,NULL),
(205,142,'Costa do Sol Cafe','Cafe',150.00,'Relaxed coastal cafe with light meals and drinks',4.0,NULL),
(206,142,'Matola Taste House','Local Cuisine',350.00,'Local cuisine restaurant with casual dining',4.0,NULL);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `restaurant_import`
--

DROP TABLE IF EXISTS `restaurant_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_import` (
  `name` varchar(200) DEFAULT NULL,
  `street_address` varchar(255) DEFAULT NULL,
  `location_text` varchar(255) DEFAULT NULL,
  `type_text` varchar(255) DEFAULT NULL,
  `reviews_text` varchar(100) DEFAULT NULL,
  `comments_text` text DEFAULT NULL,
  `price_range` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_import`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `restaurant_import` WRITE;
/*!40000 ALTER TABLE `restaurant_import` DISABLE KEYS */;
INSERT INTO `restaurant_import` VALUES
('Betty Lou\'s Seafood and Grill','318 Columbus Ave','San Francisco, CA 94133-3908',' Seafood, Vegetarian Friendly, Vegan Options','4.5 of 5 bubbles','','$$ - $$$\r'),
('Coach House Diner','55 State Rt 4','Hackensack, NJ 07601-6337',' Diner, American, Vegetarian Friendly','4 of 5 bubbles','Both times we were there very late, after 11 PM.  At that time in many diners (forget restaurants!) you get warmed-over food and lousy service.  Not so here - food was uniformly very good and the service quite good.  There weren\'t many people but it...More','$$ - $$$\r'),
('Table Talk Diner','2521 South Rd Ste C','Poughkeepsie, NY 12601-5476',' American, Diner, Vegetarian Friendly','4 of 5 bubbles','Waitress was very friendly but a little pricey for a diner but the food was delicious \nThe menu had a wide variety of foods to choose from but any choice would have been a good one','$$ - $$$\r'),
('Sixty Vines','3701 Dallas Pkwy','Plano, TX 75093-7777',' American, Wine Bar, Vegetarian Friendly','4.5 of 5 bubbles','Not sure why I went there for the second time. Will not go again. Not because it was terrible but because it is just average.  \nThe place needs a food clean .... our menus were filthy...the table was filthy \nIt is impossible to have a...More','$$ - $$$\r'),
('The Clam Bar','3914 Brewerton Rd','Syracuse, NY 13212',' American, Bar, Seafood','4 of 5 bubbles','Doesn\'t look like much from the outside but walk in either the front door or back door and get greeted and sat almost immediately. Waitress was amazing and very helpful with the very large variety that they offer. My wife and I were very satisfied...More','$$ - $$$\r'),
('E Tutto Qua','270 Columbus Ave','San Francisco, CA 94133-4518',' Seafood, Italian, Pizza','4.5 of 5 bubbles','','$$ - $$$\r'),
('Black Angus Steakhouse - Federal Way','2400 S 320th St','Federal Way, WA 98003-5465',' American, Steakhouse, Bar','4 of 5 bubbles','This is an easy any time place to have dinner!  From week night to a special occasion.  The food is reasonably priced and always delicious!','$$ - $$$\r'),
('Ziziki\'s','11663 Preston Rd','Dallas, TX 75230-2704',' Mediterranean, Greek, Healthy','4.5 of 5 bubbles','My husband and I went to Greece last fall and fell in love with the beauty and the food so while on a  Dallas business trip, we came across Ziziki\'s and thought we\'d give it a go knowing that this was risky after 2 weeks...More','$$ - $$$\r'),
('Vince\'s Italian Restaurant & Pizzeria','2815 NE Sunset Blvd','Renton, WA 98056-3105',' Italian, Pizza, Vegetarian Friendly','4 of 5 bubbles','I love Vince\'s pizza and I was in the neighborhood after a meeting. I had a small pizza and salad.  Both were delicious and as I would expect. The service was friendly and attentive. The delivery was as quick as one can expect for a...More','$$ - $$$\r'),
('John Thomas Steakhouse','1152 Danby Rd','Ithaca, NY 14850-8927',' American, Steakhouse, Gluten Free Options','4 of 5 bubbles','The ambience, food and service were all excellent. With a student at Cornell we look forward to more dinners there!','$$$$\r'),
('ZaZa\'s Cucina','622 Cascadilla St','Ithaca, NY 14850-4049',' Italian, Vegetarian Friendly, Gluten Free Options','4 of 5 bubbles','Nice big dining area.  Holds many people, so never feels crowded.  Food and cocktails are really good.','$$ - $$$\r'),
('Dulin\'s Cafe','1929 Main St','Vancouver, WA 98660-2608',' Cafe, American, Vegetarian Friendly','4.5 of 5 bubbles','This is the place if you\'re into the combo of excellent and sincerely unpretentious.  I\'m not usually a breakfast lover - but I\'ll be back here to try their corned beef on potatoes and a few other treats.','$$ - $$$\r'),
('Wilde Rover Irish Pub & Restaurant','111 Central Way','Kirkland, WA 98033-6107',' Irish, Bar, Pub','4 of 5 bubbles','Have been here before. This time it was disappointing. Beer variety and selection as always good but food wasn´t worth the price-\nFish and meet portion in general small and all close to well-done.\nService personal wasn´t committed. Once we finished the dinner plates were...More','$$ - $$$\r'),
('New World Bistro Bar','300 Delaware Ave','Albany, NY 12209-1627',' American, Bar, Vegetarian Friendly','4.5 of 5 bubbles','Came with a group of eight people, and had a wonderful evening.  The food was a wide variety, and very high quality.  Service was excellent.  The flatbread deluxe hamburger was a unique burger, and extremely tasty.  The spicy grilled green bean appetizer platter was outstanding....More','$$ - $$$\r'),
('Red Eye Cafe','94 Walnut St','Montclair, NJ 07042-3881',' American, Cafe, Healthy','4.5 of 5 bubbles','My first time in this part of Montclair. Since I arrived at 12.15 pm, there was never ending influx of customers for a good 2 hours.  As busy as this restaurant is, we were not rushed and we fully enjoyed our food while enjoying our...More','$$ - $$$\r'),
('Winberies Princeton','One Palmer Square','Princeton, NJ 08542-3718',' American, Bar, Pub','4 of 5 bubbles','We brought our family here for dinner on a Saturday. It was busy but the staff was very attentive and our food did not take too long. The tiger tots were amazing!  The rest of our food was good as well. A little noisy and...More','$$ - $$$\r'),
('Malbec','1001 E Green St','Pasadena, CA 91106-2404',' Steakhouse, Latin, Argentinean','4.5 of 5 bubbles','','$$$$\r'),
('Din Tai Fung','700 Bellevue Way NE','Bellevue, WA 98004-5046',' Chinese, Asian, Taiwanese','4.5 of 5 bubbles','Din Tai Fung has always been inconstantly great.  The dumplings, noodles, and rice dishes are sublime and the service is fast and friendly. \n\nWhile everything is great and fresh ]make sure you do not forget your vegetables as the greens here are a work of...More','$$ - $$$\r'),
('Ravenous','21 Phila St','Saratoga Springs, NY 12866-3104',' Belgian, French, Cafe','4.5 of 5 bubbles','The food and service were very good, but the size of the portions relative to price were a little disappointing.  They did nicely accommodate our large family gathering, which was nice!  The poutine was outstanding!More','$$ - $$$\r'),
('Mimi\'s Cafe','1400 S Harbor Blvd','Anaheim, CA 92802-2311',' American, Cajun & Creole, Vegetarian Friendly','4 of 5 bubbles','','$$ - $$$\r'),
('La Hacienda Ranch','4110 Preston Rd','Frisco, TX 75034-8508',' Steakhouse, Mexican, Vegetarian Friendly','4 of 5 bubbles','Food always great and the margaritas are THE BEST. Wait staff are always courteous and friendly. Best TexMex in town.','$$ - $$$\r'),
('Breadsticks Cafe & Grill','1133 Boardwalk','Atlantic City, NJ 08401-7329',' American, Vegetarian Friendly, Vegan Options','4 of 5 bubbles','We dined for lunch (group of four) and all ordered the 3-course offering for $18.99\nExcellent value and the quality was exceptional. Food was fresh,\n hot and adequately portioned.No disappointment.\n\nBetter than the food(which is hard to do)was our attentive pleasant server Eden. She truly...More','$$ - $$$\r'),
('Revolve True Food & Wine Bar','10024 Main St','Bothell, WA 98011-3464',' Bar, Contemporary, Fusion','4 of 5 bubbles','Took my fiancé here for Valentine’s Day. She discovered a while back that she has a gluten allergy which has really limited what she can eat. I on the other hand, was very skeptical. Long story short, the food was delicious and I left very...More','$$ - $$$\r'),
('The Lion\'s Share','629 Kettner Blvd','San Diego, CA 92101-6718',' American, Bar, Gluten Free Options','4.5 of 5 bubbles','','$$ - $$$\r'),
('Tilikum Place Cafe','407 Cedar St','Seattle, WA 98121-1519',' American, European, Vegetarian Friendly','4.5 of 5 bubbles','One of our favorite brunch place in Seattle. Came back for the second time while we were in town. Food is absolutely lovely but the baked potatoes were a bit too dry for my taste. Overall, great place for brunch.','$$ - $$$\r'),
('BV Tuscany Italian Restaurant','368 Cedar Ln','Teaneck, NJ 07666-3411',' Italian, Vegetarian Friendly, Gluten Free Options','4.5 of 5 bubbles','BV Tuscany is in a great location with shops and a local movie theater. We always find street parking close by. The food is delicious so fresh, excellent quality. The service is always on point so friendly too! Its very romantic inside. The desserts are...More','$$ - $$$\r'),
('The Misfit Restaurant & Bar','225 Santa Monica Blvd','Santa Monica, CA 90401-2207',' American, Bar, Contemporary','4.5 of 5 bubbles','','$$ - $$$\r'),
('Beso','11 Schuyler St','Staten Island, NY 10301-1952',' Latin, Spanish, Vegetarian Friendly','4.5 of 5 bubbles','This place is horrible!!!!!  They dont know how to treat customers especially when they are at fault.  This place is ran by idiots and the owner should be ashamed of who he has representing him. I was a loyal customer for 4 years and after...More','$$ - $$$\r'),
('Social 37','2 Route 37 W Unit B2','Toms River, NJ 08753-6588',' American, Bar, Gastropub','4 of 5 bubbles','Went recently on a saturday night for a birthday celebration. We do like the atmosphere. it\'s loud but we didn\'t mind. the menu is very eclectic and appealing. problem is most everything just left the little bit to be desired. mainly not enough in the...More','$$ - $$$\r'),
('Ristorante Paradiso','120 Park Ln','Kirkland, WA 98033-3717',' Italian, Vegetarian Friendly, Gluten Free Options','4.5 of 5 bubbles','We live part time in Italy and are tough critics of many Italian restaurants in the US.  Paradise surprised us with two excellent dishes that would have been very good in Italy.  The pasta with cream sauce and sausage was super.  Very rich and creamy...More','$$ - $$$\r'),
('Tabernilla','7124 Bob Bullock Loop','Laredo, TX 78041-2080',' Spanish, Mediterranean, Wine Bar','5 of 5 bubbles','Unique tapas menu - NOT a Mexican restaurant! My waiter made excellent recommendations and of course, the small portions or “tapas”, made it ideal to try several. \n\nEverything I ordered was de-lish!\n\nClassy, relaxing ambiance.','$$ - $$$\r'),
('Buddakan','1 Atlantic Ocean','Atlantic City, NJ 08401-6689',' Chinese, Asian, Vegetarian Friendly','4.5 of 5 bubbles','I can\'t tell you enough of how amazing the food here is. The edamam ravioli are to die for. There is not one dish I didn\'t like. This is my favorite part of visiting Atlantic City','$$$$\r'),
('Hodel\'s Country Dining','5917 Knudsen Dr','Bakersfield, CA 93308-2946',' American, Vegetarian Friendly, Vegan Options','4 of 5 bubbles','','$$ - $$$\r'),
('Magic Castle','7001 Franklin Ave','Los Angeles, CA 90028-8600',' American, Vegetarian Friendly','4.5 of 5 bubbles','','$$$$\r'),
('Jorge\'s Mexican Restaurant','6051 South Bell Street','Amarillo, TX 79109-6618',' Mexican, Southwestern, Vegetarian Friendly','4 of 5 bubbles','Decent service.  Nothing to write home about.  Got the fajitas and the meat was way over seasoned and the beef was super chewy. The tortillas were the only good thing of that meal.  My sister got the stuffed avocado meal and was not good.  It...More','$$ - $$$\r'),
('Ziziki\'s at The Star','6765 Winning Dr','Frisco, TX 75034-8162',' Mediterranean, Greek, Italian','4.5 of 5 bubbles','Great staff, super atmosphere and superb staff! If you like Greek food, this place is a must!  Compared to the other restaurants at The Star, it is actually not overcrowded.  Well worth a visit!','$$ - $$$\r'),
('The Attic','3441 E Broadway','Long Beach, CA 90803-5906',' Cajun & Creole, American, Vegetarian Friendly','4.5 of 5 bubbles','','$$ - $$$\r'),
('Del Posto','85 Tenth Avenue','New York City, NY 10011',' Italian, Vegetarian Friendly, Vegan Options','4.5 of 5 bubbles','Fabulous!  Deserves the Michelin Star that it already has.  We had the 5 course dinner on a wintry Sunday night.  All 5 courses were marvelous!  Having said that, the linguine with geoduck was my favorite, followed closely by the veal/tuna/sweetbread appetizer.  Pork agnolotti and branzino...More','$$$$\r'),
('Moore\'s Tavern & Restaurant','402 W Main St','Freehold, NJ 07728-2540',' American, Bar, Pub','3.5 of 5 bubbles','On Tuesdays Moore\'s has 2 for 1 burgers. The burgers are good and large. The service however was not so good. My wife ordered bacon with her burger but did not get it. When we mentioned this to the waitress so we wouldn\'t be charged...More','$$ - $$$\r'),
('Fin Raw Bar and Kitchen','183 Glenridge Ave','Montclair, NJ 07042-3526',' American, Seafood','4 of 5 bubbles','Oh the food is the freshest ever. Sushi bar rocks. Wait staff good looking, fun and helpful in selecting from the awesome dishes and specials. Fish tacos are superb. This is also best run location.','$$ - $$$\r'),
('The Capital Grille','117 W 4th St','Austin, TX 78701-3914',' American, Steakhouse, Gluten Free Options','4.5 of 5 bubbles','Such a nice evening! Professional and kind service in a cozy atmosphere. Everything was delicious. We shared oysters, truffle fries and asparagus. We both had beautiful steaks. Would go monthly if I lived here.','$$$$\r'),
('The Cheesecake Factory','639 E Shaw Ave','Fresno, CA 93710-7729',' American, Vegetarian Friendly, Vegan Options','4 of 5 bubbles','','$$ - $$$\r'),
('Pizzeria Credo','4520 California Ave SW','Seattle, WA 98116-4111',' Italian, Pizza, Vegetarian Friendly','4.5 of 5 bubbles','Six of us dined here last night - Carbonara, pizzas, gnocchi, caprese and desserts were all excellent - both taste and presentation.  Warm, friendly and attentive service. Love this place!  A new favorite in Seattle.','$$ - $$$\r'),
('Cheeseboard Pizza','1504 Shattuck Ave','Berkeley, CA 94709-1517',' Pizza, Vegetarian Friendly, Vegan Options','4.5 of 5 bubbles','','$\r'),
('Cortina\'s Italian Market & Pizzeria','2175 W Orange Ave','Anaheim, CA 92804-3556',' Italian, Pizza, Deli','4.5 of 5 bubbles','','$$ - $$$\r'),
('Havana Central','One Ridge Hill Blvd','Yonkers, NY 10710-7609',' Caribbean, Latin, Spanish','3.5 of 5 bubbles','We came with high hopes and left underwhelmed. We were hoping for something a bit different, and interesting. The waitress spent more time describing drinks than food, which made me realise that this was more of a bar than a restaurant. And the food was...More','$$ - $$$\r'),
('Yard House','300 Santana Row','San Jose, CA 95128-2423',' American, Bar, Pub','4 of 5 bubbles','','$$ - $$$\r'),
('Siete Banderas','901 Iturbide St','Laredo, TX 78040-5859',' Mexican','4.5 of 5 bubbles','We had my daughter-in-law’s baby shower and we invited a large group of friends and family to celebrate the future birth of my granddaughter.  Siete Banderas restaurant offers a varied and delicious brunch items.  Everybody enjoyed the food and drinks.','$$ - $$$\r'),
('Jeanne D\'Arc Restaurant','715 Bush St','San Francisco, CA 94108-3402',' French, European, Vegetarian Friendly','4.5 of 5 bubbles','','$$ - $$$\r'),
('Luby\'s Cafeteria Mall Del Norte','5300 Ih 35','Laredo, TX','','4 of 5 bubbles','Located inside the Mall Del Norte, this is a rather small but clean Luby\'s.  The food and service are usually quite good.','American\r'),
('Norma\'s Cafe','8300 Gaylord Pkwy','Frisco, TX 75034-8566',' American, Cafe, Diner','4.5 of 5 bubbles','Great home style food. Yummy breakfast. Large portions. Have tried chicken strips, burgers, chicken fried steak and pies. All great!','$$ - $$$\r'),
('Lonesome Dove Western Bistro','2406 N Main St','Fort Worth, TX 76164-8519',' American, Southwestern, Vegetarian Friendly','4.5 of 5 bubbles','What a fantastic experience. The bartender was very knowledgeable about the menu and a joy to talk with.  Our server Joe as knowledgeable and attentive. The food was Devine.  The appetizers were out of this world.  I had the elk for my main course and...More','$$$$\r'),
('KathaKali Indian Eatery','11451 98th Ave NE','Kirkland, WA 98033-4325',' Indian, Asian, Vegetarian Friendly','4.5 of 5 bubbles','We thoroughly enjoyed our Valentine’s Weekend dinner here!  We’d been advised by a friend to arrive early on a weekend, so we arrived as they opened for the dinner service @ 5:30 (they don’t accept weekend reservations).  By 6:00 pm there was a line of...More','$$ - $$$\r'),
('Mission Galleria','3700 Main St','Riverside, CA 92501-3317',' Cafe','4.5 of 5 bubbles','','$\r'),
('Bill\'s Cafe','1115 Willow St','San Jose, CA 95125-3158',' American, Cafe, International','4.5 of 5 bubbles','','$$ - $$$\r'),
('MASH\'D','3401 Preston Rd Ste D1','Frisco, TX 75034-9007',' American, Bar, International','4.5 of 5 bubbles','If you are in Frisco you have to stop here. The Drinks are amazing. Service is great. Food is great.','$$ - $$$\r'),
('Eddie V\'s Wildfish','1370 Bison Ave','Newport Beach, CA 92660-9071',' American, Seafood, Vegetarian Friendly','4.5 of 5 bubbles','','$$$$\r'),
('Buzzard Billy\'s','100 Interstate 35 N','Waco, TX 76704-2518',' American, Bar, Seafood','3.5 of 5 bubbles','We sure enjoyed our meal and the margaritas we had at Buzzard Billy’s. The place was hard to get to because of construction but well worth it. It’s on the river and has a great view and was very nice indoors with friendly staff.','$$ - $$$\r'),
('Anthony\'s HomePort','135 Lake St S','Kirkland, WA 98033-6468',' American, Seafood, Vegetarian Friendly','4 of 5 bubbles','The 3 course menu for $25 is available anytime in January which is a good deal. The salmon dip and northwest duet were good. However the salmon dip was only accompanied by a couple of crackers and slices of apple. The hot fudge sundae for...More','$$ - $$$\r'),
('Kwan Tip Thai','29426 Pacific Hwy S','Federal Way, WA 98003-3829',' Asian, Thai, Vegetarian Friendly','4.5 of 5 bubbles','We had a meeting in Federal Way that was going to end late, and I knew we needed to get to lunch right away, so I researched places. This sounded good, and am I glad we went!  We had the Kwan Tip Wings, which was...More','$$ - $$$\r'),
('Longboard Restaurant & Pub','217 Main St','Huntington Beach, CA 92648-5127',' American, Bar, Pub','4 of 5 bubbles','','$$ - $$$\r'),
('Acropolis Pizza & Pasta','500 Central Way','Kirkland, WA 98033-6208',' Greek, Italian, Pizza','4 of 5 bubbles','This place has been run by the same family since they opened in 1973.  I had a salad and a half meatball grinder, sliced meatballs with tomato sauce and cheese.  These things are delicious but can be messy to eat.  Imagine if it had round...More','$\r'),
('Cedars at Pier One','355 Clover Island Dr','Kennewick, WA 99336-3678',' American, Seafood, Bar','4 of 5 bubbles','We were excited to go here and have an early Valentine\'s Day dinner, Thursday, the day before the holiday and see if things had changed with the new owner. We sat in the lounge while we waited for our table. The atmosphere was relaxed, the...More','$$$$\r'),
('Bisque Restaurant','2020 Long Beach Blvd','Ship Bottom, Long Beach Island, NJ 08008-4353',' American, Seafood, Gluten Free Options','4.5 of 5 bubbles','Three star restaurant, open all year BYOB.Classy, elegant dining. Wine glasses, table cloths. There’s not one thing on the fine menu that I would not try! Great Chef! You got me hooked!!!🤙🤙🤙','$$$$\r'),
('Rosco\'s Burger Inn','3829 Tompkins Rd','El Paso, TX 79930-6215',' American, Diner','4.5 of 5 bubbles','We had a Cheeseburger and Cujo dog! Onion rings were impressive- the straight cut French fries were golden, brown and delicious. The bowl of chili with onions and cheese was good and perfectly spicy. The spicy ketchup and salsa served in squeeze bottles are also...More','$\r'),
('The Capital Grille','155 E 42nd St','New York City, NY 10017-5608',' American, Steakhouse, Vegetarian Friendly','4.5 of 5 bubbles','Service was great and the steaks were awesome. I highly recommend this Capital Grill when In NYC. Everyone was accomodating.','$$$$\r'),
('Maxie\'s Supper Club and Oyster Bar','635 W State St','Ithaca, NY 14850-3347',' American, Bar, Seafood','4 of 5 bubbles','They nailed the Cajun atmosphere, felt like we could be dining in a New Orleans restaurant! Our waitress was very bubbly, attentive and informative. We ordered oysters from 3 different north eastern states. I had only had oysters from the gulf and never knew they...More','$$ - $$$\r'),
('The Cheesecake Factory','197 Riverside Sq Mall','Hackensack, NJ 07601-6310',' American, Vegetarian Friendly, Vegan Options','4 of 5 bubbles','Lots of bread and butter to start.\nExpensive, small drinks with too much ice no matter what you ask for.\nBig bowls of cheap lettuce with minimal nothing special ingredients.\nAND - $9 a slice for their 2,000 calorie cheesecake lol. Argh! \nStay away please...More','$$ - $$$\r'),
('677 Prime','677 Broadway','Albany, NY 12207-2998',' American, Steakhouse, Gluten Free Options','4.5 of 5 bubbles','Tremendous service.  Nice atmosphere.  Ordered the large filet mignon and it had a lot of grisly fat in the middle.  Didn\'t complain cause im not one for that, but that is a few times now where my steak there was well below average.  I prefer...More','$$$$\r'),
('Bareburger','7149 Austin St','Forest Hills, NY 11375-4728',' American, Vegetarian Friendly, Vegan Options','4 of 5 bubbles','We ordered from this location \nAnd I\'ll say excellent burgers.  \nGood size..  Very tasty\nBut very pricey','$$ - $$$\r'),
('Oto Sushi','11628 97th Ln NE','Kirkland, WA 98034-4269',' Japanese, Sushi, Asian','4 of 5 bubbles','We had the Mt St Helens special.  It’s a roll with avocado and crab meat inside and a fish variety on the outside.  It was great and creative.  The sushi we had was all very good.  \n\nThe soba noodle was mediocre, so don’t go for...More','$$ - $$$\r'),
('Planet Thai','910 NE Tenney Rd','Vancouver, WA 98685-2837',' Asian, Thai, Vegetarian Friendly','4.5 of 5 bubbles','Recently received a score of 60 from health department.  A score of 100 or higher  is closing the establishment \nDon\'t think I\'ll be back.','$$ - $$$\r'),
('Red Apple Cafe','488 W Herndon Ave','Fresno, CA 93650-1329',' American, Cafe, Vegetarian Friendly','4.5 of 5 bubbles','','$$ - $$$\r'),
('Ayothaya Thai Restaurant','5604 176th St E','Puyallup, WA 98375-9306',' Thai, Asian, Vegan Options','4.5 of 5 bubbles','An extensive menu that does not disappoint. This is my go-to place for Thai food near home. I love both the Tom Yum and the Tom Ka soups. I often just order the soup with a side of rice for an excellent meal.','$$ - $$$\r'),
('Mulvaney\'s Building & Loan','1215 19th St','Sacramento, CA 95811-4154',' American, Vegetarian Friendly, Vegan Options','4.5 of 5 bubbles','','$$$$\r'),
('Fat Pie Pizza','1015 Harris Ave','Bellingham, WA 98225-7034',' Italian, American, Pizza','4.5 of 5 bubbles','Even a boy from Brooklyn NY enjoyed the pizza. Nice soft pizza with good cheese, mushrooms and pepperoni. Also had a bison burger which was cooked the way we like it. \n\nAnd the staff was extremely helpful and attentive. We carried out and everything was...More','$$ - $$$\r'),
('Jack Allen\'s Kitchen','3600 N Capital of Texas Hwy','Austin, TX 78746-3314',' American, Southwestern, Bar','4.5 of 5 bubbles','Had a valentine dinner with my wife. She had the grilled ruby red trout and she said it was excellent. I had the crispy fried red fish and it was excellent. Our waiter was very personable and excellent service.','$$ - $$$\r'),
('Rutabegorz','158 W Main St','Tustin, CA 92780',' American, Vegetarian Friendly, Vegan Options','4.5 of 5 bubbles','','$$ - $$$\r'),
('La Volpe','201 Brazos St. Bldg B','Austin, TX 78701',' Italian, American, Seafood','4.5 of 5 bubbles','What Can I say ? When in Austin you should visit La Volpe, my first time around and by far I am already in love. I had no idea about the restaurant but my mom is from around and she told me about this incredible...More','$$ - $$$\r'),
('Brother\'s Office Pizzeria','13221 E 32nd Ave','Spokane Valley, WA 99216-0138',' Pizza, Vegetarian Friendly','4.5 of 5 bubbles','We have been to both Valley locations, multiple times. The stores are not really that big so finding a place to sit can sometimes be difficult. Not a place to bring more than about 6-8 people. Their pizza is quite excellent,  maybe in the Spokane...More','$$ - $$$\r'),
('Gorkha Durbar','25250 Pacific Hwy S','Kent, WA 98032-6539',' Asian, Indian, Tibetan','4.5 of 5 bubbles','Our group of 4 was limited in knowledge of the restaruant fare.  Our server, Anis, was very helpful in suggesting items that made our dining experience very enjoyable.  We enjoyed panner momos, spinach naan, vegetable thukpa, mango chicken, and lamb saag.  With our restaurant.com coupon,...More','$$ - $$$\r'),
('H3 Ranch','109 E Exchange Ave','Fort Worth, TX 76164-8211',' American, Steakhouse, Southwestern','4.5 of 5 bubbles','My first time visiting this restaurant. Oh my!! It was phenomenal from walking in the doors to walking out with a full stomach! Service, food, atmosphere, prices... I was not disappointed by any means.','$$ - $$$\r'),
('Ajanta Distinctive Indian Cuisine','1888 Solano Ave','Berkeley, CA 94707-2309',' Indian, Vegetarian Friendly, Vegan Options','4.5 of 5 bubbles','','$$ - $$$\r'),
('Black Angus Steakhouse','3601 Rosedale Hwy','Bakersfield, CA 93308-6230',' American, Steakhouse, Bar','4 of 5 bubbles','','$$ - $$$\r'),
('Off Vine','6263 Leland Way','Los Angeles, CA 90028-8207',' American, Contemporary, Vegetarian Friendly','4.5 of 5 bubbles','','$$ - $$$\r'),
('Seasons 52','2000 Route 38','Cherry Hill, NJ 08002-2100',' American, Wine Bar, Vegetarian Friendly','4.5 of 5 bubbles','The food was very very good.\nOver priced in my opinion, but extremely good. Not a big selection to choose from.\nThe waitress was extremely good in the beginning but tended to ignore us at the end. \nThe place was so crowded people were standing...More','$$ - $$$\r'),
('Esquina Latina','25 Liberty St','New Brunswick, NJ 08901-1210',' Latin, Cuban, Caribbean','4 of 5 bubbles','Visted on a sat night...busy so make sure you reserve a table...moderately priced....excellent portions...started with 3 beef empanadas....tasty and not greasy at all....also had the cuban chorizo..could have been spicier..but it was excellent...for entrees stuffed porkchop with chorizo and manchego cheese....smothered in pears and onions...also...More','$$ - $$$\r'),
('Pane e Vino','8945 S Fry Rd','Katy, TX 77494',' Italian, Pizza, Vegetarian Friendly','4.5 of 5 bubbles','We heard about Pane e Vino from a friend and decided to try it.  We were met by the owner and escorted to our table.  Three of us ordered the lasagna and thought it was really good.  The fourth person ordered the veal picatta and...More','$$ - $$$\r'),
('Capers + Olives','2933 Colby Ave','Everett, WA 98201-4010',' Italian, Vegetarian Friendly','4.5 of 5 bubbles','Everything here is delicious and well-prepared from the olives to the bruschetta to the pasta (amazing--we tried three different ones and they were all scrumptious) to the mains. They have a lovely wine list and good cocktails. We went on a monday evening, called last...More','$$ - $$$\r'),
('Elements Restaurant','907 Main Street','Vancouver, WA 98660',' American, Vegetarian Friendly, Gluten Free Options','4.5 of 5 bubbles','My sister and I came here on Christmas Eve for dinner and it could not have been more pleasant!!  We both had melt in your mouth salmon, which was expertly prepared and we both loved!!  Also had a delightful cheesecake with wonderful coffee for dessert,...More','$$ - $$$\r'),
('Jack\'s Oyster House','42-44 State Street','Albany, NY 12207-2804',' American, Seafood, Gluten Free Options','4 of 5 bubbles','This restaurant feels like you are walking into the past in a good way. Greeted by a gentleman who was polite and very organized. Our waiter never stopped moving was very polite. He was good about all of our requests. We even had to make...More','$$$$\r'),
('Yono\'s Restaurant','25 Chapel St','Albany, NY 12210-2733',' Indonesian, American, Vegetarian Friendly','4.5 of 5 bubbles','We’ve been in this nice and classy place for dinner with my husband and we remain very satisfied of our four corses menu! Every plate was delicious and service was awesome) The chief was attentive to every guest! Recommended!','$$$$\r'),
('Fleming\'s Prime Steakhouse & Wine Bar','1201 Lake Woodlands Dr Ste 305','The Woodlands, TX 77380-5011',' American, Steakhouse, Gluten Free Options','4.5 of 5 bubbles','Celebrating the end of 2019.  Reserved for 2 at 4:45, yet table set for four...awkward.  Lots of young families with small children. Fun to watch!  My gorgeous smart & sweet wife had the Modern Caesar Salad that comes with two pieces of petite garlic toasts....More','$$$$\r'),
('Bill\'s Pizza','119 S Indian Canyon Dr','Palm Springs, Greater Palm Springs, CA 92262-6603',' Italian, Pizza, Vegetarian Friendly','4.5 of 5 bubbles','','$\r'),
('LuNello\'s Resturant','182 Stevens Ave','Cedar Grove, NJ 07009-1149',' Italian, Vegetarian Friendly, Vegan Options','4.5 of 5 bubbles','My sisters and their husbands and I went here for my Mom’s 88th birthday. Wonderful restaurant. The food and service were spectacular. The portions were surprisingly large. But of course you pay for what you get. My brother-in-law picked up the tab, which had to...More','$$$$\r'),
('Ironbound','1000 Spring St','Elizabeth, NJ 07201',' American, Bar','4 of 5 bubbles','Ironbound - the pizza was pretty good and the beer was cold.  It was cold and rainy outside, I had returned my rental car, the service was good and it was convenient.','$$ - $$$\r'),
('Pizza Port','13517 Lefferts Blvd','South Ozone Park, NY 11420-3601',' Pizza, Italian','4 of 5 bubbles','Deliver to hotels in area. Used them when we stayed at Holiday Inn Express Kennedy Airport. I ordered sausage parmigiana with a nice side salad. My spouse had a baked manicotti dish. Delivery did take an hour, but the dishes were still hot when delivered...More','$\r'),
('Sbarro','651 Kapkowski Rd','Elizabeth, NJ 07201-4901',' Italian, Pizza, Fast Food','4 of 5 bubbles','Black Friday everything else was very crowded so we decided to grab a quick bite here. The line moved fast so was good. The cheese pizza was good. But the veggie was below average.the spaghetti was okay','$\r'),
('Brasilia Grill','99 Monroe Street','Newark, NJ 07105',' Latin, Barbecue, Brazilian','4 of 5 bubbles','Food and drinks are always on point. I visit 3 to 4 times a month. Today they had a guest singer. JUST AWEFUL!! He cannot sings,sounds terrible and just loud. How do you chase customers away? Have the band that played at Brasilia on Feb...More','$$ - $$$\r');
/*!40000 ALTER TABLE `restaurant_import` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `restaurant_import_africa`
--

DROP TABLE IF EXISTS `restaurant_import_africa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_import_africa` (
  `name` varchar(200) DEFAULT NULL,
  `street_address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `type_text` varchar(255) DEFAULT NULL,
  `reviews_text` varchar(100) DEFAULT NULL,
  `comments_text` text DEFAULT NULL,
  `price_range` varchar(50) DEFAULT NULL,
  `postal_code` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_import_africa`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `restaurant_import_africa` WRITE;
/*!40000 ALTER TABLE `restaurant_import_africa` DISABLE KEYS */;
INSERT INTO `restaurant_import_africa` VALUES
('Gold Coast Grill','15 Beach Road','Cape Town','South Africa','Seafood','4.5 of 5 bubbles','Seafood restaurant close to the waterfront with tourist friendly meals','$$ - $$$','8001'),
('Table Bay Kitchen','22 Long Street','Cape Town','South Africa','Local Cuisine','4 of 5 bubbles','Relaxed local restaurant suitable for lunch and group dinners','$$ - $$$','8001'),
('Karibu Flame House','88 Main Road','Cape Town','South Africa','Steakhouse','4.5 of 5 bubbles','Grill restaurant with generous meals and a warm city atmosphere','$$ - $$$','8005'),
('Signal Hill Cafe','5 Kloof Road','Cape Town','South Africa','Cafe','4 of 5 bubbles','Casual cafe serving breakfast coffee and light meals','$','8001'),
('Atlantic Spice Bistro','34 Regent Road','Cape Town','South Africa','Fusion','4.5 of 5 bubbles','Modern bistro with seafood curries and Cape inspired dishes','$$ - $$$','8060'),
('Braamfontein Braai House','12 Juta Street','Johannesburg','South Africa','African Grill','4 of 5 bubbles','Popular city grill serving braai plates and local sides','$$ - $$$','2001'),
('Soweto Taste Kitchen','45 Vilakazi Street','Johannesburg','South Africa','Local Cuisine','4.5 of 5 bubbles','Traditional meals in a lively tourist area','$$ - $$$','1804'),
('Sandton Garden Bistro','9 Rivonia Road','Johannesburg','South Africa','International','4 of 5 bubbles','Modern bistro for business travellers and families','$$ - $$$','2196'),
('Maboneng Street Food Cafe','28 Fox Street','Johannesburg','South Africa','Street Food','4.5 of 5 bubbles','Casual restaurant with local street food inspired plates','$','2094'),
('Rosebank Flame Grill','16 Oxford Road','Johannesburg','South Africa','Steakhouse','4 of 5 bubbles','Comfortable grill restaurant near hotels and shopping areas','$$ - $$$','2196'),
('Golden Mile Seafood','10 Marine Parade','Durban','South Africa','Seafood','4.5 of 5 bubbles','Beachfront seafood restaurant with ocean views','$$ - $$$','4001'),
('Umhlanga Curry House','24 Lighthouse Road','Durban','South Africa','Indian','4.5 of 5 bubbles','Curry restaurant known for spicy local Durban style dishes','$$ - $$$','4320'),
('Berea Garden Cafe','7 Musgrave Road','Durban','South Africa','Cafe','4 of 5 bubbles','Relaxed cafe with breakfasts light meals and desserts','$','4001'),
('Zulu Taste Restaurant','41 Florida Road','Durban','South Africa','Local Cuisine','4 of 5 bubbles','Restaurant serving local dishes in a tourist friendly setting','$$ - $$$','4001'),
('Harbour View Grill','18 Point Road','Durban','South Africa','Grill','4.5 of 5 bubbles','Grill house close to the harbour and beachfront hotels','$$ - $$$','4001'),
('Stone Town Spice Table','7 Market Street','Zanzibar','Tanzania','Swahili Cuisine','4.5 of 5 bubbles','Traditional island dishes with seafood and spice flavours','$$ - $$$','71101'),
('Nungwi Ocean Grill','45 Nungwi Beach Road','Zanzibar','Tanzania','Seafood','4.5 of 5 bubbles','Beachfront restaurant serving fresh fish and island meals','$$ - $$$','73107'),
('Forodhani Night Cafe','3 Seafront Walk','Zanzibar','Tanzania','Street Food','4 of 5 bubbles','Casual evening meals inspired by the local night market','$','71101'),
('Jambiani Beach Kitchen','21 Jambiani Road','Zanzibar','Tanzania','Local Cuisine','4.5 of 5 bubbles','Coastal restaurant with relaxed beach style dining','$$ - $$$','72107'),
('Coral Garden Bistro','14 Kendwa Road','Zanzibar','Tanzania','Fusion','4 of 5 bubbles','Island bistro serving seafood salads and local dishes','$$ - $$$','73109'),
('Nairobi Safari Grill','30 Kenyatta Avenue','Nairobi','Kenya','African Grill','4.5 of 5 bubbles','Popular grill restaurant for tourists and families','$$ - $$$','00100'),
('Westlands Taste House','14 Westlands Road','Nairobi','Kenya','Local Cuisine','4 of 5 bubbles','Kenyan dishes in a modern restaurant setting','$$ - $$$','00800'),
('Kilimani Garden Cafe','20 Argwings Kodhek Road','Nairobi','Kenya','Cafe','4 of 5 bubbles','Relaxed cafe with breakfast and lunch options','$','00100'),
('Karen Plains Bistro','6 Karen Road','Nairobi','Kenya','International','4.5 of 5 bubbles','Quiet bistro near popular tourist routes','$$ - $$$','00502'),
('Savannah Rooftop Dining','11 Moi Avenue','Nairobi','Kenya','Fine Dining','4.5 of 5 bubbles','Rooftop restaurant with city views and African inspired meals','$$$$','00100'),
('Mombasa Harbour Grill','18 Moi Avenue','Mombasa','Kenya','Seafood','4.5 of 5 bubbles','Seafood restaurant close to the old town and harbour','$$ - $$$','80100'),
('Diani Beach Kitchen','25 Beach Road','Mombasa','Kenya','Coastal Cuisine','4 of 5 bubbles','Beach style restaurant with grilled fish and local sides','$$ - $$$','80401'),
('Swahili Spice Cafe','4 Nkrumah Road','Mombasa','Kenya','Swahili Cuisine','4.5 of 5 bubbles','Casual restaurant with coastal spices and rice dishes','$','80100'),
('Old Town Curry House','9 Fort Jesus Road','Mombasa','Kenya','Indian','4 of 5 bubbles','Curry house near historic attractions','$$ - $$$','80100'),
('Nyali Garden Grill','13 Links Road','Mombasa','Kenya','Grill','4.5 of 5 bubbles','Family friendly grill restaurant in the Nyali area','$$ - $$$','80118'),
('Khan el Khalili Kitchen','8 Al Moez Street','Cairo','Egypt','Egyptian','4.5 of 5 bubbles','Traditional Egyptian meals near historic market areas','$$ - $$$','11511'),
('Nile View Restaurant','16 Corniche Road','Cairo','Egypt','International','4.5 of 5 bubbles','Restaurant with Nile views and tourist friendly service','$$ - $$$','11221'),
('Giza Pyramid Cafe','5 Pyramid Road','Cairo','Egypt','Cafe','4 of 5 bubbles','Casual cafe close to major sightseeing routes','$','12556'),
('Zamalek Garden Bistro','22 Taha Hussein Street','Cairo','Egypt','Mediterranean','4.5 of 5 bubbles','Stylish bistro serving light meals and dinner plates','$$ - $$$','11211'),
('Cairo Flame House','31 Ramses Street','Cairo','Egypt','Grill','4 of 5 bubbles','Grill restaurant with meat dishes and local sides','$$ - $$$','11522'),
('Marrakech Spice House','9 Medina Road','Marrakech','Morocco','Moroccan','4.5 of 5 bubbles','Traditional Moroccan meals close to the old town','$$ - $$$','40000'),
('Atlas Rooftop Restaurant','18 Avenue Mohammed V','Marrakech','Morocco','Fine Dining','4.5 of 5 bubbles','Rooftop restaurant with city views and Moroccan food','$$$$','40000'),
('Jemaa Garden Cafe','4 Souk Street','Marrakech','Morocco','Cafe','4 of 5 bubbles','Casual cafe near popular market areas','$','40000'),
('Palm Grove Tagine House','27 Palmeraie Road','Marrakech','Morocco','Local Cuisine','4.5 of 5 bubbles','Restaurant serving tagines couscous and Moroccan teas','$$ - $$$','40000'),
('Red City Grill','12 Riad Zitoun Road','Marrakech','Morocco','Grill','4 of 5 bubbles','Comfortable grill house with Moroccan inspired plates','$$ - $$$','40000'),
('Accra Palm Kitchen','12 Oxford Street','Accra','Ghana','Ghanaian','4.5 of 5 bubbles','Local Ghanaian meals in a tourist friendly area','$$ - $$$','00233'),
('Osu Garden Grill','25 Cantonments Road','Accra','Ghana','African Grill','4 of 5 bubbles','Grill restaurant with local sides and fresh juices','$$ - $$$','00233'),
('Jamestown Seafood House','7 High Street','Accra','Ghana','Seafood','4.5 of 5 bubbles','Seafood restaurant close to historic coastal areas','$$ - $$$','00233'),
('Labadi Beach Cafe','19 Beach Road','Accra','Ghana','Cafe','4 of 5 bubbles','Relaxed beach cafe with light meals and drinks','$','00233'),
('Independence Bistro','4 Castle Road','Accra','Ghana','International','4.5 of 5 bubbles','Modern bistro near central tourist attractions','$$ - $$$','00233'),
('Lagos Island Grill','25 Marina Street','Lagos','Nigeria','West African','4 of 5 bubbles','Nigerian meals and grilled dishes in the city centre','$$ - $$$','100221'),
('Victoria Island Bistro','11 Ahmadu Bello Way','Lagos','Nigeria','International','4.5 of 5 bubbles','Modern restaurant for travellers and business guests','$$ - $$$','101241'),
('Lekki Taste Kitchen','34 Admiralty Way','Lagos','Nigeria','Local Cuisine','4 of 5 bubbles','Restaurant serving jollof grilled fish and local favourites','$$ - $$$','105102'),
('Eko Seafood Lounge','8 Bar Beach Road','Lagos','Nigeria','Seafood','4.5 of 5 bubbles','Seafood lounge close to coastal hotel areas','$$ - $$$','101241'),
('Ikeja Cafe House','20 Allen Avenue','Lagos','Nigeria','Cafe','4 of 5 bubbles','Casual cafe with coffee pastries and quick meals','$','100271'),
('Kigali Hills Cafe','6 KN Street','Kigali','Rwanda','Cafe','4 of 5 bubbles','Modern cafe with light meals and coffee','$','00000'),
('Nyamirambo Taste House','13 KN Avenue','Kigali','Rwanda','Rwandan','4.5 of 5 bubbles','Local dishes served in a friendly neighbourhood setting','$$ - $$$','00000'),
('Kigali View Bistro','22 KG Road','Kigali','Rwanda','International','4.5 of 5 bubbles','Bistro with hillside views and dinner options','$$ - $$$','00000'),
('Convention Garden Grill','9 Kimihurura Road','Kigali','Rwanda','Grill','4 of 5 bubbles','Tourist friendly grill restaurant near hotel districts','$$ - $$$','00000'),
('Lake Kivu Seafood Table','17 Avenue de la Paix','Kigali','Rwanda','Seafood','4.5 of 5 bubbles','Seafood inspired restaurant with relaxed service','$$ - $$$','00000'),
('Windhoek Brau Kitchen','15 Independence Avenue','Windhoek','Namibia','Grill','4.5 of 5 bubbles','Casual grill restaurant with generous portions','$$ - $$$','9000'),
('Namib Desert Bistro','28 Sam Nujoma Drive','Windhoek','Namibia','Local Cuisine','4 of 5 bubbles','Namibian inspired meals in a central location','$$ - $$$','9000'),
('Eros Garden Cafe','6 Nelson Mandela Avenue','Windhoek','Namibia','Cafe','4 of 5 bubbles','Relaxed cafe serving breakfast lunch and coffee','$','9000'),
('Safari Flame House','40 Hosea Kutako Drive','Windhoek','Namibia','Steakhouse','4.5 of 5 bubbles','Steakhouse suitable for tourists and group dinners','$$ - $$$','9000'),
('Dune View Restaurant','3 Robert Mugabe Avenue','Windhoek','Namibia','International','4 of 5 bubbles','Restaurant offering local and international dishes','$$ - $$$','9000'),
('Victoria Falls River Grill','2 Falls Road','Victoria Falls','Zimbabwe','African Grill','4.5 of 5 bubbles','Grill restaurant close to the falls and hotels','$$ - $$$','00000'),
('Zambezi Sunset Bistro','10 Zambezi Drive','Victoria Falls','Zimbabwe','International','4.5 of 5 bubbles','Tourist friendly bistro with relaxed evening meals','$$ - $$$','00000'),
('Rainforest Cafe','5 Park Road','Victoria Falls','Zimbabwe','Cafe','4 of 5 bubbles','Casual cafe for light meals before or after activities','$','00000'),
('Falls Market Kitchen','18 Livingstone Way','Victoria Falls','Zimbabwe','Local Cuisine','4 of 5 bubbles','Local restaurant serving Zimbabwean style dishes','$$ - $$$','00000'),
('Baobab Seafood Grill','22 Elephant Walk','Victoria Falls','Zimbabwe','Seafood','4.5 of 5 bubbles','Seafood and grill restaurant near tourist shopping areas','$$ - $$$','00000'),
('Lusaka Flame Grill','16 Cairo Road','Lusaka','Zambia','African Grill','4 of 5 bubbles','Central grill restaurant with local and regional dishes','$$ - $$$','10101'),
('Manda Hill Cafe','9 Great East Road','Lusaka','Zambia','Cafe','4 of 5 bubbles','Casual cafe near shopping and hotel areas','$','10101'),
('Zambezi Taste Kitchen','25 Independence Avenue','Lusaka','Zambia','Local Cuisine','4.5 of 5 bubbles','Zambian meals served in a modern restaurant setting','$$ - $$$','10101'),
('Woodlands Bistro','14 Leopards Hill Road','Lusaka','Zambia','International','4 of 5 bubbles','Bistro with dinner options for travellers','$$ - $$$','10101'),
('Copperbelt Grill House','31 Church Road','Lusaka','Zambia','Steakhouse','4.5 of 5 bubbles','Steakhouse with family friendly service','$$ - $$$','10101'),
('Maputo Bay Seafood','12 Marginal Avenue','Maputo','Mozambique','Seafood','4.5 of 5 bubbles','Seafood restaurant with bay views and fresh fish','$$ - $$$','1100'),
('Polana Garden Bistro','8 Julius Nyerere Avenue','Maputo','Mozambique','Portuguese','4.5 of 5 bubbles','Mozambican and Portuguese inspired meals in a stylish setting','$$ - $$$','1100'),
('Baixa Flame Grill','20 Avenida 25 de Setembro','Maputo','Mozambique','Grill','4 of 5 bubbles','Central grill house suitable for tourists and families','$$ - $$$','1100'),
('Costa do Sol Cafe','5 Beach Avenue','Maputo','Mozambique','Cafe','4 of 5 bubbles','Relaxed coastal cafe with light meals and drinks','$','1100'),
('Matola Taste House','30 EN4 Road','Maputo','Mozambique','Local Cuisine','4 of 5 bubbles','Local cuisine restaurant with casual dining','$$ - $$$','1114');
/*!40000 ALTER TABLE `restaurant_import_africa` ENABLE KEYS */;
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
(4,'Langata Road','Nairobi','Kenya','00506'),
(5,'318 Columbus Ave','San Francisco','United States','94133-3908'),
(6,'55 State Rt 4','Hackensack','United States','07601-6337'),
(7,'2521 South Rd Ste C','Poughkeepsie','United States','12601-5476'),
(8,'3701 Dallas Pkwy','Plano','United States','75093-7777'),
(9,'3914 Brewerton Rd','Syracuse','United States','13212'),
(10,'270 Columbus Ave','San Francisco','United States','94133-4518'),
(11,'2400 S 320th St','Federal Way','United States','98003-5465'),
(12,'11663 Preston Rd','Dallas','United States','75230-2704'),
(13,'2815 NE Sunset Blvd','Renton','United States','98056-3105'),
(14,'1152 Danby Rd','Ithaca','United States','14850-8927'),
(15,'622 Cascadilla St','Ithaca','United States','14850-4049'),
(16,'1929 Main St','Vancouver','United States','98660-2608'),
(17,'111 Central Way','Kirkland','United States','98033-6107'),
(18,'300 Delaware Ave','Albany','United States','12209-1627'),
(19,'94 Walnut St','Montclair','United States','07042-3881'),
(20,'One Palmer Square','Princeton','United States','08542-3718'),
(21,'1001 E Green St','Pasadena','United States','91106-2404'),
(22,'700 Bellevue Way NE','Bellevue','United States','98004-5046'),
(23,'21 Phila St','Saratoga Springs','United States','12866-3104'),
(24,'1400 S Harbor Blvd','Anaheim','United States','92802-2311'),
(25,'4110 Preston Rd','Frisco','United States','75034-8508'),
(26,'1133 Boardwalk','Atlantic City','United States','08401-7329'),
(27,'10024 Main St','Bothell','United States','98011-3464'),
(28,'629 Kettner Blvd','San Diego','United States','92101-6718'),
(29,'407 Cedar St','Seattle','United States','98121-1519'),
(30,'368 Cedar Ln','Teaneck','United States','07666-3411'),
(31,'225 Santa Monica Blvd','Santa Monica','United States','90401-2207'),
(32,'11 Schuyler St','Staten Island','United States','10301-1952'),
(33,'2 Route 37 W Unit B2','Toms River','United States','08753-6588'),
(34,'120 Park Ln','Kirkland','United States','98033-3717'),
(35,'7124 Bob Bullock Loop','Laredo','United States','78041-2080'),
(36,'1 Atlantic Ocean','Atlantic City','United States','08401-6689'),
(37,'5917 Knudsen Dr','Bakersfield','United States','93308-2946'),
(38,'7001 Franklin Ave','Los Angeles','United States','90028-8600'),
(39,'6051 South Bell Street','Amarillo','United States','79109-6618'),
(40,'6765 Winning Dr','Frisco','United States','75034-8162'),
(41,'3441 E Broadway','Long Beach','United States','90803-5906'),
(42,'85 Tenth Avenue','New York City','United States','10011'),
(43,'402 W Main St','Freehold','United States','07728-2540'),
(44,'183 Glenridge Ave','Montclair','United States','07042-3526'),
(45,'117 W 4th St','Austin','United States','78701-3914'),
(46,'639 E Shaw Ave','Fresno','United States','93710-7729'),
(47,'4520 California Ave SW','Seattle','United States','98116-4111'),
(48,'1504 Shattuck Ave','Berkeley','United States','94709-1517'),
(49,'2175 W Orange Ave','Anaheim','United States','92804-3556'),
(50,'One Ridge Hill Blvd','Yonkers','United States','10710-7609'),
(51,'300 Santana Row','San Jose','United States','95128-2423'),
(52,'901 Iturbide St','Laredo','United States','78040-5859'),
(53,'715 Bush St','San Francisco','United States','94108-3402'),
(54,'5300 Ih 35','Laredo','United States',NULL),
(55,'8300 Gaylord Pkwy','Frisco','United States','75034-8566'),
(56,'2406 N Main St','Fort Worth','United States','76164-8519'),
(57,'11451 98th Ave NE','Kirkland','United States','98033-4325'),
(58,'3700 Main St','Riverside','United States','92501-3317'),
(59,'1115 Willow St','San Jose','United States','95125-3158'),
(60,'3401 Preston Rd Ste D1','Frisco','United States','75034-9007'),
(61,'1370 Bison Ave','Newport Beach','United States','92660-9071'),
(62,'100 Interstate 35 N','Waco','United States','76704-2518'),
(63,'135 Lake St S','Kirkland','United States','98033-6468'),
(64,'29426 Pacific Hwy S','Federal Way','United States','98003-3829'),
(65,'217 Main St','Huntington Beach','United States','92648-5127'),
(66,'500 Central Way','Kirkland','United States','98033-6208'),
(67,'355 Clover Island Dr','Kennewick','United States','99336-3678'),
(68,'2020 Long Beach Blvd','Ship Bottom','United States','08008-4353'),
(69,'3829 Tompkins Rd','El Paso','United States','79930-6215'),
(70,'155 E 42nd St','New York City','United States','10017-5608'),
(71,'635 W State St','Ithaca','United States','14850-3347'),
(72,'197 Riverside Sq Mall','Hackensack','United States','07601-6310'),
(73,'677 Broadway','Albany','United States','12207-2998'),
(74,'7149 Austin St','Forest Hills','United States','11375-4728'),
(75,'11628 97th Ln NE','Kirkland','United States','98034-4269'),
(76,'910 NE Tenney Rd','Vancouver','United States','98685-2837'),
(77,'488 W Herndon Ave','Fresno','United States','93650-1329'),
(78,'5604 176th St E','Puyallup','United States','98375-9306'),
(79,'1215 19th St','Sacramento','United States','95811-4154'),
(80,'1015 Harris Ave','Bellingham','United States','98225-7034'),
(81,'3600 N Capital of Texas Hwy','Austin','United States','78746-3314'),
(82,'158 W Main St','Tustin','United States','92780'),
(83,'201 Brazos St. Bldg B','Austin','United States','78701'),
(84,'13221 E 32nd Ave','Spokane Valley','United States','99216-0138'),
(85,'25250 Pacific Hwy S','Kent','United States','98032-6539'),
(86,'109 E Exchange Ave','Fort Worth','United States','76164-8211'),
(87,'1888 Solano Ave','Berkeley','United States','94707-2309'),
(88,'3601 Rosedale Hwy','Bakersfield','United States','93308-6230'),
(89,'6263 Leland Way','Los Angeles','United States','90028-8207'),
(90,'2000 Route 38','Cherry Hill','United States','08002-2100'),
(91,'25 Liberty St','New Brunswick','United States','08901-1210'),
(92,'8945 S Fry Rd','Katy','United States','77494'),
(93,'2933 Colby Ave','Everett','United States','98201-4010'),
(94,'907 Main Street','Vancouver','United States','98660'),
(95,'42-44 State Street','Albany','United States','12207-2804'),
(96,'25 Chapel St','Albany','United States','12210-2733'),
(97,'1201 Lake Woodlands Dr Ste 305','The Woodlands','United States','77380-5011'),
(98,'119 S Indian Canyon Dr','Palm Springs','United States','92262-6603'),
(99,'182 Stevens Ave','Cedar Grove','United States','07009-1149'),
(100,'1000 Spring St','Elizabeth','United States','07201'),
(101,'13517 Lefferts Blvd','South Ozone Park','United States','11420-3601'),
(102,'651 Kapkowski Rd','Elizabeth','United States','07201-4901'),
(103,'99 Monroe Street','Newark','United States','07105'),
(132,'15 Beach Road','Cape Town','South Africa','8001'),
(133,'22 Long Street','Cape Town','South Africa','8001'),
(134,'88 Main Road','Cape Town','South Africa','8005'),
(135,'5 Kloof Road','Cape Town','South Africa','8001'),
(136,'34 Regent Road','Cape Town','South Africa','8060'),
(137,'12 Juta Street','Johannesburg','South Africa','2001'),
(138,'45 Vilakazi Street','Johannesburg','South Africa','1804'),
(139,'9 Rivonia Road','Johannesburg','South Africa','2196'),
(140,'28 Fox Street','Johannesburg','South Africa','2094'),
(141,'16 Oxford Road','Johannesburg','South Africa','2196'),
(142,'10 Marine Parade','Durban','South Africa','4001'),
(143,'24 Lighthouse Road','Durban','South Africa','4320'),
(144,'7 Musgrave Road','Durban','South Africa','4001'),
(145,'41 Florida Road','Durban','South Africa','4001'),
(146,'18 Point Road','Durban','South Africa','4001'),
(147,'7 Market Street','Zanzibar','Tanzania','71101'),
(148,'45 Nungwi Beach Road','Zanzibar','Tanzania','73107'),
(149,'3 Seafront Walk','Zanzibar','Tanzania','71101'),
(150,'21 Jambiani Road','Zanzibar','Tanzania','72107'),
(151,'14 Kendwa Road','Zanzibar','Tanzania','73109'),
(152,'30 Kenyatta Avenue','Nairobi','Kenya','00100'),
(153,'14 Westlands Road','Nairobi','Kenya','00800'),
(154,'20 Argwings Kodhek Road','Nairobi','Kenya','00100'),
(155,'6 Karen Road','Nairobi','Kenya','00502'),
(156,'11 Moi Avenue','Nairobi','Kenya','00100'),
(157,'18 Moi Avenue','Mombasa','Kenya','80100'),
(158,'25 Beach Road','Mombasa','Kenya','80401'),
(159,'4 Nkrumah Road','Mombasa','Kenya','80100'),
(160,'9 Fort Jesus Road','Mombasa','Kenya','80100'),
(161,'13 Links Road','Mombasa','Kenya','80118'),
(162,'8 Al Moez Street','Cairo','Egypt','11511'),
(163,'16 Corniche Road','Cairo','Egypt','11221'),
(164,'5 Pyramid Road','Cairo','Egypt','12556'),
(165,'22 Taha Hussein Street','Cairo','Egypt','11211'),
(166,'31 Ramses Street','Cairo','Egypt','11522'),
(167,'9 Medina Road','Marrakech','Morocco','40000'),
(168,'18 Avenue Mohammed V','Marrakech','Morocco','40000'),
(169,'4 Souk Street','Marrakech','Morocco','40000'),
(170,'27 Palmeraie Road','Marrakech','Morocco','40000'),
(171,'12 Riad Zitoun Road','Marrakech','Morocco','40000'),
(172,'12 Oxford Street','Accra','Ghana','00233'),
(173,'25 Cantonments Road','Accra','Ghana','00233'),
(174,'7 High Street','Accra','Ghana','00233'),
(175,'19 Beach Road','Accra','Ghana','00233'),
(176,'4 Castle Road','Accra','Ghana','00233'),
(177,'25 Marina Street','Lagos','Nigeria','100221'),
(178,'11 Ahmadu Bello Way','Lagos','Nigeria','101241'),
(179,'34 Admiralty Way','Lagos','Nigeria','105102'),
(180,'8 Bar Beach Road','Lagos','Nigeria','101241'),
(181,'20 Allen Avenue','Lagos','Nigeria','100271'),
(182,'6 KN Street','Kigali','Rwanda','00000'),
(183,'13 KN Avenue','Kigali','Rwanda','00000'),
(184,'22 KG Road','Kigali','Rwanda','00000'),
(185,'9 Kimihurura Road','Kigali','Rwanda','00000'),
(186,'17 Avenue de la Paix','Kigali','Rwanda','00000'),
(187,'15 Independence Avenue','Windhoek','Namibia','9000'),
(188,'28 Sam Nujoma Drive','Windhoek','Namibia','9000'),
(189,'6 Nelson Mandela Avenue','Windhoek','Namibia','9000'),
(190,'40 Hosea Kutako Drive','Windhoek','Namibia','9000'),
(191,'3 Robert Mugabe Avenue','Windhoek','Namibia','9000'),
(192,'2 Falls Road','Victoria Falls','Zimbabwe','00000'),
(193,'10 Zambezi Drive','Victoria Falls','Zimbabwe','00000'),
(194,'5 Park Road','Victoria Falls','Zimbabwe','00000'),
(195,'18 Livingstone Way','Victoria Falls','Zimbabwe','00000'),
(196,'22 Elephant Walk','Victoria Falls','Zimbabwe','00000'),
(197,'16 Cairo Road','Lusaka','Zambia','10101'),
(198,'9 Great East Road','Lusaka','Zambia','10101'),
(199,'25 Independence Avenue','Lusaka','Zambia','10101'),
(200,'14 Leopards Hill Road','Lusaka','Zambia','10101'),
(201,'31 Church Road','Lusaka','Zambia','10101'),
(202,'12 Marginal Avenue','Maputo','Mozambique','1100'),
(203,'8 Julius Nyerere Avenue','Maputo','Mozambique','1100'),
(204,'20 Avenida 25 de Setembro','Maputo','Mozambique','1100'),
(205,'5 Beach Avenue','Maputo','Mozambique','1100'),
(206,'30 EN4 Road','Maputo','Mozambique','1114');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES
(2,4,2,3,4,'Great safari experience, the Masai Mara was unforgettable. Logistics could have been smoother.','2026-05-13 00:08:50'),
(3,5,1,2,5,'Zanzibar was paradise. The Rock restaurant dinner was the highlight of our trip.','2026-05-13 00:08:50'),
(4,3,1,1,4,'Great experiance would highly recommend','2026-05-24 22:33:58');
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

-- Dump completed on 2026-05-26  2:12:13
