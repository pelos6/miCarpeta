-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.23 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para serviciosmicarpetasigicon
CREATE DATABASE IF NOT EXISTS `serviciosmicarpetasigicon` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `serviciosmicarpetasigicon`;


-- Volcando estructura para tabla serviciosmicarpetasigicon.w_not
CREATE TABLE IF NOT EXISTS `w_not` (
  `COD_CON` varchar(4) NOT NULL,
  `COD_CUE` varchar(4) NOT NULL,
  `COD_ESP` varchar(3) NOT NULL,
  `COD_ACC` varchar(1) DEFAULT NULL,
  `COD_SOL` varchar(4) NOT NULL DEFAULT '',
  `DNI` varchar(15) NOT NULL DEFAULT '',
  `RES_TOT_OPO` varchar(8) NOT NULL,
  `PRU_1_A_NOT` varchar(8) NOT NULL,
  `PRU_2_A_NOT` varchar(8) NOT NULL,
  `PRU_1_B_NOT` varchar(8) NOT NULL,
  `PRU_2_B_NOT` varchar(8) NOT NULL,
  `PRU_1_A_PON` varchar(8) NOT NULL,
  `PRU_2_A_PON` varchar(8) NOT NULL,
  `PRU_1_B_PON` varchar(8) NOT NULL,
  `PRU_2_B_PON` varchar(8) NOT NULL,
  `SUP` varchar(8) NOT NULL,
  `RES_TOT_CON` varchar(8) NOT NULL,
  PRIMARY KEY (`COD_CON`,`COD_SOL`,`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigicon.w_not: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `w_not` DISABLE KEYS */;
INSERT INTO `w_not` (`COD_CON`, `COD_CUE`, `COD_ESP`, `COD_ACC`, `COD_SOL`, `DNI`, `RES_TOT_OPO`, `PRU_1_A_NOT`, `PRU_2_A_NOT`, `PRU_1_B_NOT`, `PRU_2_B_NOT`, `PRU_1_A_PON`, `PRU_2_A_PON`, `PRU_1_B_PON`, `PRU_2_B_PON`, `SUP`, `RES_TOT_CON`) VALUES
	('333', '0590', '001', '1', '0001', '00000001R', '5.5015', '5.4570', '2.4240', '8.2500', '5.3000', '2.72850', '0.96960', '4.02500', '3.18000', 'SI', '7.5000');
/*!40000 ALTER TABLE `w_not` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
