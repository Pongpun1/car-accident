-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 04, 2025 at 10:38 PM
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
  `acclocation` varchar(255) DEFAULT NULL,
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
(755, 0, 'ลาดกระบัง', 13.7505781, 100.7943199, 1, 2, '2025-02-17', 'เกิดเหตุรถชนบนถนนทำให้มี ผู้บาดเจ็บเพศชาย 5 ราย\nและผู้เสียชีวิตเพศหญิง 3 ราย'),
(756, 0, 'มีนบุรี', 13.8154818, 100.7352666, 4, 6, '2024-12-02', ' เกิดเหตุรถชนบนถนนทำให้มี ผู้บาดเจ็บเพศชาย 5 ราย และผู้เสียชีวิตเพศหญิง 3 ราย'),
(757, 0, 'บ้านทับช้าง', 13.7331049, 100.6886425, 7, 2, '2024-12-02', 'เกิดรถล้มตรงฟุตบาท มีผู้ชายได้รับบาดเจ็บ 5 ราย'),
(758, 0, 'บางพลี', 13.6117233, 100.7323332, 8, 5, '2024-12-01', 'เกิดเหตุจี้ชิงทรัพย์ในยามวิกาล'),
(759, 0, 'สยาม', 15.870032, 100.992541, 0, 2, '2024-12-02', 'เกิดเหตุรถ10ล้อ ประสานงากับรถพ่วง ทำให้มีผู้บาดเจ็บเพศชาย 2 ราย'),
(760, 0, 'ลาดกระบัง', 13.7505781, 100.7943199, 1, 2, '2024-12-03', 'อุบัติเหตุ'),
(761, 0, 'มีนบุรี', 13.8154818, 100.7352666, 4, 6, '2024-12-03', 'มีรถชนกันตรง 4 แยก'),
(762, 0, 'บ้านทับช้าง', 13.7331049, 100.6886425, 7, 2, '2024-12-03', 'เกิดรถล้มตรงฟุตบาท มีผู้ชายได้รับบาดเจ็ 5 ราย'),
(764, 0, 'สยาม', 15.870032, 100.992541, 0, 2, '2024-12-03', 'เกิดเหตุรถ10ล้อ ประสานงากับรถพ่วง'),
(765, 0, 'ลาดกระบัง', 13.7505781, 100.7943199, 1, 2, '2024-12-01', 'อุบัติเหตุ'),
(766, 0, 'ลำลูกกา', 13.9754896, 100.7774424, 1, 1, '2025-03-01', 'ฟหกฟหกฟ'),
(767, 0, '', 13.663853, 100.6132453, 0, 0, '2025-03-02', NULL),
(768, 0, 'ห้วยขวาง', 13.7699094, 100.5864793, 0, 0, '2025-03-08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `crimedata`
--

CREATE TABLE `crimedata` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `crimelocation` varchar(255) DEFAULT NULL,
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
(154, 0, 'บางนา', 13.663853, 100.6132453, 2, 4, '2025-02-01', 'เป็นผู้ชาย 2 คน'),
(163, 0, 'สำโรงเหนือ', 13.6475561, 100.6188288, 2, 2, '2024-12-01', 'มีโจรปล้นตรงมุมตึก'),
(165, 0, 'บ้านทับช้าง', 13.7331049, 100.6886425, 4, 2, '2024-12-09', 'กฟหกฟหก'),
(170, 0, 'อโศก', 13.7426472, 100.5621419, 3, 1, '2024-11-04', 'เกิดเหตุรถชนบนถนนทำให้มี ผู้บาดเจ็บเพศชาย 5 ราย และผู้เสียชีวิตเพศหญิง 3 ราย'),
(174, 0, 'บางเมือง', 13.6106322, 100.6252859, 6, 3, '2024-12-01', 'มีคนร้ายแอบลอบวางเพลิง'),
(185, 0, 'บางพลี', 13.6117233, 100.7323332, 8, 5, '2024-11-28', 'เกิดเหตุจี้ชิงทรัพย์ในยามวิกาล'),
(188, 0, 'บางพลี', 13.6117233, 100.7323332, 8, 5, '2024-12-01', 'เกิดเหตุจี้ชิงทรัพย์ในยามวิกาล'),
(200, 0, 'บางนา', 13.663853, 100.6132453, 5, 1, '2024-12-01', 'มีขโมยตรงซอยมังกร'),
(203, 0, '', 13.6383764, 100.5774363, 0, 0, '2025-02-03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `unapprove_data`
--

CREATE TABLE `unapprove_data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `unapprove_location` varchar(255) NOT NULL,
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

INSERT INTO `unapprove_data` (`id`, `user_id`, `unapprove_location`, `latitude`, `longitude`, `numinjur`, `numdeath`, `unapprove_date`, `unapprove_info`) VALUES
(65, 0, 'สำโรงใต้', 13.6117233, 100.7323332, 2, 4, '2025-03-03', 'ฟกกฟกฟก');

-- --------------------------------------------------------

--
-- Table structure for table `unspecified_data`
--

CREATE TABLE `unspecified_data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
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

INSERT INTO `unspecified_data` (`id`, `user_id`, `location`, `latitude`, `longitude`, `numinjur`, `numdeath`, `date`, `info`) VALUES
(158, 0, 'บางปู', 13.6117233, 100.7323332, 2, 4, '2025-01-06', 'กฟหกฟหก'),
(167, 0, 'ภูเก็ต', 7.9843109, 98.3307468, 6, 2, '2024-12-08', 'มดกินปลา'),
(168, 0, 'สนามบินวุวรรณภูมิ', 13.6818969, 100.7468694, 9, 4, '2024-12-08', 'กินมันติดเหงือก'),
(169, 0, 'ฉลองกรุง 1', 13.7278962, 100.7693314, 7, 2, '2024-12-02', 'กินเผือกติดฟัน'),
(170, 0, 'สมุรทปราการ เทพารักษ์', 13.6309772, 100.6168401, 3, 3, '2024-12-08', 'ปลากินมด'),
(171, 0, 'ฟเดหเิหแปปปแปแ', 13.6475561, 100.7323332, 7, 8, '2025-02-10', 'ฟกหกฟหกฟหกฟอิิแปvsvsd'),
(172, 0, 'บางลำพู', 13.7561935, 100.5057151, 1, 2, '2025-03-02', 'ไก่ขันก่อนนอน'),
(173, 0, '', 12.4202239, 102.5298028, 0, 0, '2025-03-04', NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=776;

--
-- AUTO_INCREMENT for table `crimedata`
--
ALTER TABLE `crimedata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `unapprove_data`
--
ALTER TABLE `unapprove_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT for table `unspecified_data`
--
ALTER TABLE `unspecified_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
