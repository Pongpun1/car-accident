-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2025 at 04:58 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `caraccident`
--

-- --------------------------------------------------------

--
-- Table structure for table `accidentdata`
--

CREATE TABLE `accidentdata` (
  `id` int(11) NOT NULL,
  `acclocation` varchar(255) DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `accdate` date NOT NULL,
  `accinfo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `crimedata`
--

CREATE TABLE `crimedata` (
  `id` int(11) NOT NULL,
  `crimelocation` varchar(255) DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `crimedate` date NOT NULL,
  `crimeinfo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `unapprove_data`
--

CREATE TABLE `unapprove_data` (
  `id` int(11) NOT NULL,
  `unapprove_location` varchar(255) DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `unapprove_date` date NOT NULL,
  `unapprove_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `unapprove_data`
--

INSERT INTO `unapprove_data` (`id`, `unapprove_location`, `latitude`, `longitude`, `numinjur`, `numdeath`, `unapprove_date`, `unapprove_info`) VALUES
(65, 'สำโรงใต้', 13.6117233, 100.7323332, 2, 4, '2025-03-03', 'ฟกกฟกฟก'),
(66, 'test', 13.7563, 100.5018, 2, 1, '2025-02-28', 'tes'),
(67, 'คูเมือง', 13.7845, 100.0347, 2, 1, '2025-02-28', 'tes'),
(68, 'คูเมือง', 13.1845, 100.0347, 2, 1, '2025-02-28', 'tes'),
(69, 'te', 12.9322, 99.449, 2, 1, '2025-02-28', 'tes'),
(70, 'aa', 12.8322, 99.549, 2, 1, '2025-02-28', 'tes');

-- --------------------------------------------------------

--
-- Table structure for table `unspecified_data`
--

CREATE TABLE `unspecified_data` (
  `id` int(11) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `date` date NOT NULL,
  `info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `unspecified_data`
--

INSERT INTO `unspecified_data` (`id`, `location`, `latitude`, `longitude`, `numinjur`, `numdeath`, `date`, `info`) VALUES
(630, 'Test', 14.7505781, 10.7943199, 1, 2, '2024-12-03', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `username`, `password`) VALUES
(1, 'pp_saeng@hotmail.com', 'Admin01', '$2b$10$u7ZZtyB3cYBm7GjGQgpWm.XcIMndTDzkHFs1UlBpoNIwACEvdjYj2'),
(2, 'max423@hotmail.com', 'Admin02', '$2b$10$94G8zbAVaMACmNz1Qc6uUOtJhU3SG/UZ9y6UXIfoat0GvYhYkb4Am');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accidentdata`
--
ALTER TABLE `accidentdata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_accident` (`latitude`,`longitude`,`accdate`);

--
-- Indexes for table `crimedata`
--
ALTER TABLE `crimedata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_crime` (`latitude`,`longitude`,`crimedate`);

--
-- Indexes for table `unapprove_data`
--
ALTER TABLE `unapprove_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_approve` (`latitude`,`longitude`,`unapprove_date`);

--
-- Indexes for table `unspecified_data`
--
ALTER TABLE `unspecified_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`latitude`,`longitude`,`date`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accidentdata`
--
ALTER TABLE `accidentdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=897;

--
-- AUTO_INCREMENT for table `crimedata`
--
ALTER TABLE `crimedata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=384;

--
-- AUTO_INCREMENT for table `unapprove_data`
--
ALTER TABLE `unapprove_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT for table `unspecified_data`
--
ALTER TABLE `unspecified_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=631;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
