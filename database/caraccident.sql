-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2024 at 06:59 AM
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
  `user_id` int(11) NOT NULL,
  `acclocation` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `accdate` date NOT NULL,
  `accinfo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `accidentdata`
--

INSERT INTO `accidentdata` (`id`, `user_id`, `acclocation`, `latitude`, `longitude`, `numinjur`, `numdeath`, `accdate`, `accinfo`) VALUES
(712, 0, 'ลาดกระบัง', 13.7505781, 100.7943199, 4, 4, '2024-11-29', 'เกิดอุบัติเหตุรถชนกลางสี่แยกทำให้มีผู้บาดเจ็บ 4 รายเป็น ชาย 2 และ หญิง 2 และผู้เสียชีวิต 4 ราย เป็น ชาย 2 และหญิง 2'),
(713, 0, 'ไบเทคบางนา', 13.6694549, 100.6101543, 3, 4, '2024-12-09', 'ชาย 2 คน บาดเจ็บ หญิง 1 คน เสียชีวิต'),
(714, 0, 'ลาดกระบัง', 13.7505781, 100.7943199, 1, 2, '2024-12-03', 'อุบัติเหตุ'),
(715, 0, 'บ้านทับช้าง', 13.7331049, 100.6886425, 2, 5, '2024-10-06', 'บัติเหตุเกิดขึ้นมีผู้บาดเจ็บ 2 คน, ผู้เสียชีวิต 1 คน, ผู้บาดเจ็บเป็นหญิง 1 คน, ชาย 1 คน'),
(716, 0, 'ดอนเมือง', 13.9254892, 100.5923206, 1, 1, '2024-12-04', 'ชาย');

-- --------------------------------------------------------

--
-- Table structure for table `crimedata`
--

CREATE TABLE `crimedata` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `crimelocation` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `crimedate` date NOT NULL,
  `crimeinfo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `crimedata`
--

INSERT INTO `crimedata` (`id`, `user_id`, `crimelocation`, `latitude`, `longitude`, `numinjur`, `numdeath`, `crimedate`, `crimeinfo`) VALUES
(145, 0, 'สำโรงเหนือ', 13.6475561, 100.6188288, 1, 5, '2024-11-29', 'มีโจรปล้นตรงมุมตึก ทำให้มีผู้เสียหายและได้รับบาดเจ็บเป็นชาย 1 คน'),
(146, 0, 'ยะลา', 6.522747499999999, 101.178725, 6, 3, '2024-08-07', 'กฟหกฟหกฟ'),
(148, 0, 'สำโรงเหนือ', 13.6475561, 100.6188288, 2, 1, '2024-12-01', 'มีโจรปล้นตรงมุมตึก'),
(149, 0, 'ปัตตานี', 6.869516, 101.2504562, 3, 3, '2023-12-05', 'กฟหกฟห'),
(150, 0, 'สมุทรปราการ', 13.6335741, 100.7548851, 1, 1, '2024-09-09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `unspecified_data`
--

CREATE TABLE `unspecified_data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `date` date NOT NULL,
  `info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=717;

--
-- AUTO_INCREMENT for table `crimedata`
--
ALTER TABLE `crimedata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `unspecified_data`
--
ALTER TABLE `unspecified_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
