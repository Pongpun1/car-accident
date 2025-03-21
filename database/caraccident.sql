-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 20, 2025 at 03:28 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

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
(373, 0, 'ลาดกระบัง', 13.7219711, 100.7802323, 2, 0, '2024-06-13', 'สี่แยกฉลองกรุง'),
(374, 0, 'ลาดกระบัง', 13.7220178, 100.7802319, 1, 1, '2024-05-19', ''),
(375, 0, 'ลาดกระบัง', 13.7219651, 100.7802876, 2, 4, '2024-08-10', ''),
(376, 0, 'ลาดกระบัง', 11.876576, 21.4545, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(377, 0, 'ประเวศ', 12.7867675, 22.79837, 1, 1, '2024-05-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(378, 0, 'บางเมือง', 13.78754, 13.4876, 2, 4, '2024-08-12', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(379, 0, 'ลาดกระบัง', 15.7542, 12.8767, 5, 0, '2024-06-14', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(380, 0, 'แขวงลาดกระบัง', 13.7227954, 100.7386503, 1, 1, '2024-05-19', '989'),
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
(394, 0, 'บางพลี', 13.4895, 100.89147, 8, 0, '2024-08-20', 'Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis\r\n      in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.'),
(395, 0, 'ลาดกระบัง', 13.7314092, 100.7839932, 2, 0, '2025-02-03', NULL),
(396, 0, 'KMITL', 13.7279387, 100.776882, 1, 0, '2025-02-01', NULL),
(397, 0, 'KMITL', 13.7315157, 100.7750118, 0, 0, '2025-02-03', NULL),
(398, 0, ' ทับยาวซอย 8', 13.766339, 100.834175, 2, 0, '2025-02-01', NULL),
(399, 0, ' ซอยเกกี 3', 13.726214, 100.769905, 2, 0, '2025-02-01', NULL),
(400, 0, ' หน้าบริษัทมาร์โก้ในนิคมลาดกระบัง', 13.77566, 100.788147, 2, 0, '2025-02-01', NULL),
(401, 0, ' สี่แยกไฟแดงร่มเกล้า', 13.721279, 100.740162, 2, 0, '2025-02-01', NULL),
(402, 0, ' แยกเจ้ากรีฑา', 13.731408, 100.716307, 2, 0, '2025-02-01', NULL),
(403, 0, ' ซอยลาดกระบัง54', 13.72206, 100.78763, 2, 0, '2025-02-01', NULL),
(404, 0, ' ลาดกระบัง 9/1', 13.722243, 100.712086, 2, 0, '2025-02-01', NULL),
(405, 0, ' ทางยกระดับร่มเกล้า', 13.756759, 100.746382, 2, 0, '2025-02-01', NULL),
(406, 0, ' ลาดกระบัง 11/2 หน้าร้านจำหน่ายพลาสติก', 13.721841, 100.770057, 2, 0, '2025-02-01', NULL),
(407, 0, ' ถนนทางยกระดับจากสนามบินมุ่งหน้าร่มเกล้า', 13.721758, 100.706686, 2, 0, '2025-02-01', NULL),
(408, 0, ' หน้าร้านพัสดุก่อสร้าง ถนนทับยาว', 13.713481, 100.812472, 2, 0, '2025-02-01', NULL),
(409, 0, ' ไกล้จุดกลับรถขึ้นสะพาย ลำกอไผ่ ถ.ฉลองกรุง', 13.765866, 100.805129, 2, 0, '2025-02-01', NULL),
(410, 0, ' ถนนประชาพัฒนา ก่อนถึงโลตัสหน้าเอื้ออาทร 2', 13.714958, 100.821625, 2, 0, '2025-02-01', NULL),
(411, 0, ' เคหะร่มเกล้า', 13.767477, 100.732352, 2, 0, '2025-02-01', NULL),
(412, 0, ' ขับรถล้มเองถนนคลองเจ้า', 13.73105, 100.817534, 2, 0, '2025-02-01', NULL),
(413, 0, ' แยกลาดกระบัง', 13.722373, 100.746689, 2, 0, '2025-02-01', NULL),
(414, 0, ' ถนนธงขาว-ทับยาวลาดกระบัง', 13.745833, 100.838902, 2, 0, '2025-02-01', NULL),
(415, 0, ' ถนนลาดกระบัง', 13.722647, 100.749512, 2, 0, '2025-02-01', NULL),
(416, 0, ' ใกล้เคียงหน้าส.น.ลาดกระบัง', 13.721597, 100.763761, 2, 0, '2025-02-01', NULL),
(417, 0, ' แยกคลังสินค้า ไอซีดี ถนนเจ้าคุณทหาร', 13.743306, 100.761374, 2, 0, '2025-02-01', NULL),
(418, 0, ' แถวเทคโนลาดกระบัง', 13.729763, 100.778424, 2, 0, '2025-02-01', NULL),
(419, 0, ' แยกวัดพลมานีย์', 13.721887, 100.797143, 2, 0, '2025-01-31', NULL),
(420, 0, 'PP', 13.7225868, 100.7465591, 2, 0, '2025-02-01', NULL),
(421, 0, 'PPCW+X=', 13.7226182, 100.7463835, 2, 0, '2025-02-01', NULL),
(422, 0, 'PPCW', 13.7224235, 100.7466556, 2, 0, '2025-02-01', NULL),
(423, 0, '420 ถนน ', 13.722699, 100.7467635, 2, 0, '2025-02-01', NULL),
(424, 0, 'สถานีลาดก', 13.7282024, 100.7494603, 2, 0, '2025-02-01', NULL),
(425, 0, 'PPHW+4R ', 13.7278705, 100.7470216, 2, 0, '2025-02-01', NULL),
(426, 0, 'PPHW+', 13.7277848, 100.7469798, 2, 0, '2025-02-01', NULL),
(427, 0, 'กรุงเทพ-', 13.7294331, 100.7584816, 2, 0, '2025-02-01', NULL),
(428, 0, 'PQH5+P3', 13.7293713, 100.7576362, 2, 0, '2025-02-01', NULL),
(429, 0, 'PQH5+Q', 13.7294036, 100.7582614, 2, 0, '2025-02-01', NULL),
(430, 0, 'PQH5+', 13.7293795, 100.7576028, 2, 0, '2025-02-01', NULL),
(431, 0, '12/', 13.7294719, 100.7571226, 2, 0, '2025-02-01', NULL),
(432, 0, 'PQH5+8W', 13.7283563, 100.7598224, 2, 0, '2025-01-31', NULL),
(433, 0, 'PQH6+82', 13.7282636, 100.7600059, 2, 0, '2025-01-31', NULL),
(434, 0, 'PQH5+', 13.7283524, 100.7596151, 2, 0, '2025-02-01', NULL),
(435, 0, 'PQH5+9P', 13.7284262, 100.7592745, 2, 0, '2025-02-01', NULL),
(436, 0, '45 ', 13.7222041, 100.7884547, 2, 0, '2025-02-01', NULL),
(437, 0, 'PPCW+X', 13.7223171, 100.7466479, 2, 0, '2025-02-01', NULL),
(438, 0, '18/90 ', 13.7221908, 100.7883587, 2, 0, '2025-02-01', NULL),
(439, 0, '1 ซอ', 13.7278477, 100.7661371, 2, 0, '2025-02-01', NULL),
(440, 0, '1 ซอ', 13.7278332, 100.7661298, 2, 0, '2025-02-01', NULL),
(441, 0, 'PPCW+', 13.7225075, 100.7465304, 2, 0, '2025-02-01', NULL),
(442, 0, 'PPCW+X', 13.7224386, 100.7466516, 2, 0, '2025-02-01', NULL),
(443, 0, '323', 13.7216115, 100.7684141, 2, 0, '2025-02-01', NULL),
(444, 0, '1560 ', 13.7216079, 100.7689843, 2, 0, '2025-02-01', NULL),
(445, 0, '10520,', 13.7286472, 100.7781128, 2, 0, '2025-02-01', NULL),
(446, 0, '71', 13.7242173, 100.7690948, 2, 0, '2025-02-01', NULL),
(447, 0, 'PQH9+5P4 ', 13.7278648, 100.7689968, 2, 0, '2025-02-01', NULL),
(448, 0, 'PQH9+5P4', 13.7278428, 100.7689412, 2, 0, '2025-02-01', NULL),
(449, 0, '13/30 ', 13.727857, 100.7710821, 2, 0, '2025-02-01', NULL),
(450, 0, '13/30 ซ', 13.7278548, 100.7710659, 2, 0, '2025-02-01', NULL),
(451, 0, 'PQHG+F3X', 13.7285717, 100.7750239, 2, 0, '2025-02-01', NULL),
(452, 0, '13/30 ', 13.7278953, 100.7710895, 2, 0, '2025-02-01', NULL),
(453, 0, '17', 13.7247293, 100.7802617, 2, 0, '2025-02-01', NULL),
(454, 0, '1793 1', 13.7247655, 100.7801329, 2, 0, '2025-02-01', NULL),
(455, 0, '1793 1 ถ.', 13.724986, 100.7801262, 2, 0, '2025-02-01', NULL),
(456, 0, '1793 ', 13.7248112, 100.7801592, 2, 0, '2025-02-01', NULL),
(457, 0, '790/3 ', 13.7280662, 100.7768632, 2, 0, '2025-02-01', NULL),
(458, 0, '790/3 แข', 13.72804, 100.7768552, 2, 0, '2025-02-01', NULL),
(461, 0, 'สจล.', 13.7265293, 100.7780672, 2, 0, '2025-02-01', NULL),
(462, 0, 'สจล', 13.7261633, 100.7780495, 2, 0, '2025-02-01', NULL),
(463, 0, '3 ถ. ฉลอ', 13.7258849, 100.780155, 2, 0, '2025-02-01', NULL),
(464, 0, 'สจล.', 13.7264645, 100.7780266, 2, 0, '2025-02-01', NULL),
(465, 0, 'PPCW+XHF ', 13.722459, 100.7462232, 2, 0, '2025-02-01', NULL),
(466, 0, '420', 13.7227153, 100.7467558, 2, 0, '2025-02-01', NULL),
(467, 0, 'ลาดกระบัง แขวงลาดกระบัง ', 13.7219747, 100.7807458, 2, 0, '2025-02-01', NULL),
(468, 0, 'ลาดกระบัง', 13.722016, 100.7808815, 2, 0, '2025-02-01', NULL),
(469, 0, 'PQHH+97P', 13.7281524, 100.7780444, 2, 0, '2025-02-01', NULL),
(470, 0, 'แขวงลาดกระบัง', 13.7281077, 100.7780089, 2, 0, '2025-02-01', NULL),
(471, 0, 'แขวงลาดกระบัง', 13.7283463, 100.777995, 2, 0, '2025-01-28', NULL),
(472, 0, 'ทางรถไฟลาดกระบัง', 13.7284315, 100.7779888, 0, 2, '2025-01-29', NULL),
(473, 0, '41/16 ถนน อิสรภาพ แขวงบ้านช่างหล่อ เขตบางกอกน้อย กรุงเทพมหานคร 10700 ประเทศไทย', 13.751956, 100.476065, 0, 0, '2025-03-02', NULL),
(474, 0, 'ขวัญอ่อน', 13.7255863, 100.7707261, 7, 0, '2025-03-02', NULL);

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
(198, 0, 'ฟหกฟหกฟหดๆดไำด', 13.6117233, 100.6188288, 7, 3, '2024-11-10', 'กไฟกไฟกฟหก'),
(200, 0, 'บางนา', 13.663853, 100.6132453, 5, 1, '2024-12-01', 'มีขโมยตรงซอยมังกร');

-- --------------------------------------------------------

--
-- Table structure for table `unapprove_data`
--

CREATE TABLE `unapprove_data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `unapprove_location` varchar(255) DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `numinjur` int(11) NOT NULL,
  `numdeath` int(11) NOT NULL,
  `unapprove_date` date NOT NULL,
  `unapprove_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(172, 0, 'บางลำพู', 13.7561935, 100.5057151, 1, 2, '2025-03-02', 'ไก่ขันก่อนนอน');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=475;

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
