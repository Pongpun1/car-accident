-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2024 at 12:40 AM
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
  `acclocation` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `accdate` date NOT NULL,
  `accinfo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `accidentdata`
--

INSERT INTO `accidentdata` (`id`, `acclocation`, `latitude`, `longitude`, `numinjur`, `numdeath`, `accdate`, `accinfo`) VALUES
(13, 'ลาดกระบัง', 12.4634867, 17.786221, 5, 0, '2024-06-13', ''),
(11, 'ประเวศ', 12.6787987, 15.486486, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(5, 'ประเวศ', 12.7867675, 22.79837, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(8, 'ประเวศ', 13.4878, 17.4563456, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(4, 'บางพลี', 13.6117233, 100.7323332, 5, 0, '2024-06-11', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(6, 'บางเมือง', 13.78754, 13.4876, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(15, 'สำโรง', 14.9887214, 104.7754307, 5, 2, '2020-08-04', 'ไม่บอกอย่าหลอกถาม'),
(7, 'ลาดกระบัง', 15.7542, 12.8767, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(3, 'บางเมือง', 15.8916, 16.181165, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(9, 'บางเมือง', 17.43435, 16.78768, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(12, 'บางเมือง', 17.456874, 12.678, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(14, 'ประเวศ', 18.18646884, 13.67878, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(2, 'ประเวศ', 18.54941, 19.4891, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(10, 'ลาดกระบัง', 19.156489, 14.7874, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(1, 'ลาดกระบัง', 19.65612, 20.15447, 0, 1, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(0, 'แม่สาย', 20.4389131, 99.9049441, 3, 1, '2024-10-06', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(16, 'ลาดกระบัง', 20.4867886, 12.67687, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(17, 'ประเวศ', 21.7865786, 13.8942634, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(18, 'บางเมือง', 22.4867468, 14.4896987, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(19, 'บางเมือง', 22.4867468, 14.4896987, 2, 4, '2024-08-15', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(20, 'บางเมือง', 22.4867468, 15.4896987, 2, 4, '2024-08-15', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.');

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
  ADD UNIQUE KEY `unique_accident` (`latitude`,`longitude`,`accdate`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
