-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 07, 2025 at 09:30 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pahana_edu_bookshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
CREATE TABLE IF NOT EXISTS `bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `bill_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bill_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`bill_id`, `customer_id`, `total_amount`, `bill_date`) VALUES
(1, 1, 2500.00, '2025-07-25 11:38:15'),
(2, 1, 80.00, '2025-07-25 13:46:26'),
(3, 3, 500.00, '2025-07-26 16:32:34'),
(4, 1, 1250.00, '2025-07-26 16:34:22'),
(5, 1, 450.00, '2025-07-26 20:32:59'),
(6, 1, 1250.00, '2025-07-26 21:02:34'),
(7, 1, 1250.00, '2025-07-26 22:28:31'),
(8, 1, 5200.00, '2025-07-26 22:29:56'),
(9, 3, 1450.00, '2025-07-26 22:46:39'),
(10, 1, 1450.00, '2025-07-27 10:11:40'),
(11, 6, 1780.00, '2025-07-27 15:25:53'),
(12, 1, 4440.00, '2025-07-27 15:27:21'),
(13, 4, 500.00, '2025-07-27 15:27:54'),
(14, 6, 1450.00, '2025-07-27 15:29:51'),
(15, 5, 1450.00, '2025-07-27 15:30:08'),
(42, 13, 3390.00, '2025-07-31 12:02:35'),
(17, 1, 3530.00, '2025-07-27 15:50:14'),
(43, 15, 650.00, '2025-08-03 21:10:04'),
(19, 1, 1480.00, '2025-07-27 15:55:56'),
(20, 1, 1450.00, '2025-07-27 15:58:49'),
(21, 6, 1450.00, '2025-07-27 15:59:51'),
(22, 1, 1810.00, '2025-07-27 16:03:44'),
(23, 1, 2670.00, '2025-07-27 16:15:13'),
(24, 7, 50.00, '2025-07-27 16:20:33'),
(44, 11, 150.00, '2025-08-05 10:40:22'),
(26, 7, 2220.00, '2025-07-27 16:28:05'),
(27, 1, 890.00, '2025-07-27 16:50:43'),
(28, 7, 1570.00, '2025-07-27 16:51:40'),
(29, 8, 1750.00, '2025-07-27 16:53:33'),
(30, 1, 2220.00, '2025-07-27 17:08:15'),
(31, 9, 1450.00, '2025-07-27 17:21:56'),
(32, 11, 5300.00, '2025-07-27 20:43:47'),
(33, 4, 1450.00, '2025-07-27 21:11:13'),
(34, 3, 120.00, '2025-07-27 21:20:29'),
(35, 9, 500.00, '2025-07-28 00:14:32'),
(36, 10, 500.00, '2025-07-28 00:24:50'),
(37, 9, 2550.00, '2025-07-28 00:27:02'),
(38, 11, 2250.00, '2025-07-30 09:33:22'),
(39, 13, 2670.00, '2025-07-31 11:38:59'),
(40, 9, 120.00, '2025-07-31 11:48:07'),
(41, 10, 2400.00, '2025-07-31 11:51:16'),
(45, 9, 400.00, '2025-08-05 11:28:39'),
(46, 9, 1500.00, '2025-08-05 11:40:23'),
(47, 15, 3950.00, '2025-08-05 12:54:31'),
(48, 11, 30.00, '2025-08-05 13:02:59'),
(49, 17, 280.00, '2025-08-06 11:25:52'),
(50, 18, 240.00, '2025-08-07 10:15:31'),
(51, 10, 870.00, '2025-08-07 10:19:24');

-- --------------------------------------------------------

--
-- Table structure for table `bill_items`
--

DROP TABLE IF EXISTS `bill_items`;
CREATE TABLE IF NOT EXISTS `bill_items` (
  `bill_item_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`bill_item_id`),
  KEY `bill_id` (`bill_id`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bill_items`
--

INSERT INTO `bill_items` (`bill_item_id`, `bill_id`, `item_id`, `quantity`, `price`) VALUES
(1, 1, 1, 2, 1250.00),
(2, 2, 15, 2, 40.00),
(3, 3, 17, 1, 500.00),
(4, 4, 1, 1, 1250.00),
(5, 5, 9, 1, 450.00),
(6, 6, 1, 1, 1250.00),
(7, 7, 1, 1, 1250.00),
(8, 8, 12, 1, 5200.00),
(9, 9, 4, 1, 1450.00),
(10, 10, 4, 1, 1450.00),
(11, 11, 2, 2, 890.00),
(12, 12, 4, 3, 1450.00),
(13, 12, 10, 3, 30.00),
(14, 13, 17, 1, 500.00),
(15, 14, 4, 1, 1450.00),
(16, 15, 4, 1, 1450.00),
(17, 16, 14, 1, 120.00),
(18, 16, 2, 1, 890.00),
(19, 17, 8, 2, 320.00),
(20, 17, 18, 1, 2000.00),
(21, 17, 2, 1, 890.00),
(22, 18, 8, 1, 320.00),
(23, 18, 4, 1, 1450.00),
(24, 19, 4, 1, 1450.00),
(25, 19, 10, 1, 30.00),
(26, 20, 4, 1, 1450.00),
(27, 21, 4, 1, 1450.00),
(28, 22, 14, 3, 120.00),
(29, 22, 4, 1, 1450.00),
(30, 23, 2, 3, 890.00),
(31, 24, 6, 1, 50.00),
(32, 25, 13, 1, 750.00),
(33, 26, 14, 1, 120.00),
(34, 26, 5, 1, 2100.00),
(35, 27, 2, 1, 890.00),
(36, 28, 14, 1, 120.00),
(37, 28, 4, 1, 1450.00),
(38, 29, 6, 1, 50.00),
(39, 29, 1, 1, 1250.00),
(40, 29, 9, 1, 450.00),
(41, 30, 14, 1, 120.00),
(42, 30, 5, 1, 2100.00),
(43, 31, 4, 1, 1450.00),
(44, 32, 1, 4, 1250.00),
(45, 32, 10, 10, 30.00),
(46, 33, 4, 1, 1450.00),
(47, 34, 14, 1, 120.00),
(48, 35, 21, 1, 500.00),
(49, 36, 21, 1, 500.00),
(50, 37, 9, 1, 450.00),
(51, 37, 5, 1, 2100.00),
(52, 38, 22, 1, 1050.00),
(53, 38, 12, 1, 1200.00),
(54, 39, 2, 2, 890.00),
(55, 39, 2, 1, 890.00),
(56, 40, 14, 1, 120.00),
(57, 41, 7, 2, 150.00),
(58, 41, 22, 2, 1050.00),
(59, 42, 1, 2, 1250.00),
(60, 42, 2, 1, 890.00),
(61, 43, 11, 1, 650.00),
(62, 44, 10, 5, 30.00),
(63, 45, 15, 10, 40.00),
(64, 46, 13, 2, 750.00),
(65, 47, 22, 1, 1050.00),
(66, 47, 4, 2, 1450.00),
(67, 48, 10, 1, 30.00),
(68, 49, 10, 2, 30.00),
(69, 49, 14, 1, 220.00),
(70, 50, 10, 8, 30.00),
(71, 51, 14, 1, 220.00),
(72, 51, 11, 1, 650.00);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `account_number` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `units_consumed` int DEFAULT '0',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `account_number` (`account_number`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `account_number`, `name`, `address`, `phone`, `units_consumed`) VALUES
(13, 'ACC005', 'Ivanna Townsend', 'Nuwara Eliya', '0758574078', 4),
(12, 'ACC004', 'LOGEESAN AKEEBAN', 'COLOMBO', '+94987654324', 20),
(9, 'ACC001', ' Rowan', 'kalmunaii', '0753226077', 5),
(11, 'ACC003', 'Vibu', 'Trincomalee', '0753226070', 11),
(14, 'ACC006', 'Alexandra ', 'Anuradhapura', '0743227834', 5),
(10, 'ACC002', 'jana', 'colombo', '+94987654324', 2),
(15, 'ACC007', 'Jackson', 'Kandy', '0752347856', 10),
(16, 'ACC008', 'Rohanan', 'Kalmunai', '0769406944', 15),
(17, 'ACC009', 'Fernando ', 'Batticaloa ', '0777605508', 21),
(18, 'ACC010', 'Kingston Sweeney', 'Moratuwa', '076452856', 6),
(19, 'ACC011', 'Romeo Monroe', 'Sri Jayawardenepura Kotte', '0753447948', 11);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(150) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int DEFAULT '0',
  PRIMARY KEY (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `item_name`, `price`, `stock`) VALUES
(1, 'Mathematics Grade 10 Textbook', 1250.00, 18),
(2, 'English Grammar Workbook', 890.00, 13),
(3, 'Science Experiment Kit', 3500.00, 50),
(4, 'History of Sri Lanka', 1450.00, 13),
(5, 'Computer Fundamentals Guide', 2100.00, 17),
(6, 'Best Time Travel Fiction', 1150.00, 19),
(7, 'Most Interesting World', 150.00, 178),
(8, 'Children\'s Fantasy and Science Fiction', 2220.00, 10),
(9, 'Drawing Book (50 Pages)', 450.00, 57),
(10, 'Pencil HB', 30.00, 270),
(11, 'Geometry Box', 650.00, 38),
(12, 'Engineering EEE', 1200.00, 6),
(13, 'Whiteboard Marker (Pack of 4)', 750.00, 22),
(14, 'Nature Story Book', 220.00, 7),
(15, 'Children\'s Cartoon Book', 140.00, 18),
(16, 'Most Under-rated Science Fiction', 2330.00, 5),
(17, 'Best Science Fiction & Fantasy Book', 500.00, 50),
(18, 'Best Books Involving Forbidden Love', 1200.00, 9),
(21, 'Story book', 500.00, 32),
(22, 'My Dream Leading Men', 1050.00, 8),
(23, 'AI-Powered Book Title Generator', 1250.00, 11),
(24, 'The Book Thief', 1200.00, 5),
(27, 'Modern Cinema', 1050.00, 6);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `payment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `payment_method` enum('Cash','Card','Online') DEFAULT 'Cash',
  `payment_status` enum('Successful','Failed','Pending') DEFAULT 'Pending',
  PRIMARY KEY (`payment_id`),
  KEY `bill_id` (`bill_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `bill_id`, `amount_paid`, `payment_date`, `payment_method`, `payment_status`) VALUES
(1, 45, 400.00, '2025-08-05 11:28:40', 'Card', 'Successful'),
(2, 46, 1500.00, '2025-08-05 11:40:23', 'Cash', 'Successful'),
(3, 47, 4000.00, '2025-08-05 12:54:32', 'Cash', 'Failed'),
(4, 48, 130.00, '2025-08-05 13:02:59', 'Online', 'Successful'),
(5, 49, 300.00, '2025-08-06 11:25:52', 'Online', 'Pending'),
(6, 50, 300.00, '2025-08-07 10:15:31', 'Card', 'Pending'),
(7, 51, 870.00, '2025-08-07 10:19:24', 'Online', 'Failed');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','staff') DEFAULT 'staff',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `CreatedAt`) VALUES
(1, 'admin', 'admin123', 'admin', '2025-07-25 05:22:22'),
(2, 'staff', 'staff123', 'staff', '2025-07-25 14:31:23');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
