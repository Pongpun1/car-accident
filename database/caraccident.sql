-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 26, 2024 at 12:07 PM
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
(373, 0, 'ลาดกระบัง', 19.65612, 20.15447, 0, 1, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(374, 0, 'ประเวศ', 18.54941, 19.4891, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(375, 0, 'บางเมือง', 15.8916, 16.181165, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(376, 0, 'ลาดกระบัง', 11.876576, 21.4545, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(377, 0, 'ประเวศ', 12.7867675, 22.79837, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(378, 0, 'บางเมือง', 13.78754, 13.4876, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(379, 0, 'ลาดกระบัง', 15.7542, 12.8767, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(380, 0, 'ประเวศ', 13.4878, 17.4563456, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(381, 0, 'บางเมือง', 17.43435, 16.78768, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(382, 0, 'ลาดกระบัง', 19.156489, 14.7874, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(383, 0, 'ประเวศ', 12.6787987, 15.486486, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(384, 0, 'บางเมือง', 17.456874, 12.678, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(385, 0, 'ลาดกระบัง', 12.4634867, 17.786221, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(386, 0, 'ประเวศ', 18.18646884, 13.67878, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(387, 0, 'บางเมือง', 12.468486, 11.8789678, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(388, 0, 'ลาดกระบัง', 20.4867886, 12.67687, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(389, 0, 'ประเวศ', 21.7865786, 13.8942634, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(390, 0, 'บางเมือง', 22.4867468, 14.4896987, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(391, 0, 'บางเมือง', 22.4867468, 14.4896987, 2, 4, '2024-08-15', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(392, 0, 'บางเมือง', 22.4867468, 15.4896987, 2, 4, '2024-08-15', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(394, 0, 'บางพลี', 13.4895, 100.89147, 8, 0, '2024-08-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=395;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
