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

-- Volcando estructura de base de datos para serviciosmicarpetaconcursossecundaria
CREATE DATABASE IF NOT EXISTS `serviciosmicarpetaconcursossecundaria` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `serviciosmicarpetaconcursossecundaria`;


-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.ctsec_bar
CREATE TABLE IF NOT EXISTS `ctsec_bar` (
  `COD_CON` varchar(4) NOT NULL,
  `COD_SOL` varchar(4) NOT NULL DEFAULT '',
  `DNI` varchar(15) NOT NULL DEFAULT '',
  `RES_TOT` varchar(8) NOT NULL,
  `APA_1` varchar(8) NOT NULL,
  `APA_1_1` varchar(8) NOT NULL,
  `APA_1_1_1` varchar(8) NOT NULL,
  `APA_1_1_2` varchar(8) NOT NULL,
  `APA_1_1_3` varchar(8) NOT NULL,
  `APA_1_2` varchar(8) NOT NULL,
  `APA_1_2_1` varchar(8) NOT NULL,
  `APA_1_2_2` varchar(8) NOT NULL,
  `APA_1_2_3` varchar(8) NOT NULL,
  `APA_2` varchar(8) NOT NULL,
  `APA_3` varchar(8) NOT NULL,
  `APA_3_1` varchar(8) NOT NULL,
  `APA_3_1_1` varchar(8) NOT NULL,
  `APA_3_1_2` varchar(8) NOT NULL,
  `APA_3_1_3` varchar(8) NOT NULL,
  `APA_3_1_4` varchar(8) NOT NULL,
  `APA_3_2` varchar(8) NOT NULL,
  `APA_3_2_1` varchar(8) NOT NULL,
  `APA_3_2_2` varchar(8) NOT NULL,
  `APA_3_2_3` varchar(8) NOT NULL,
  `APA_3_2_4` varchar(8) NOT NULL,
  `APA_3_3` varchar(8) NOT NULL,
  `APA_4` varchar(8) NOT NULL,
  `APA_4_1` varchar(8) NOT NULL,
  `APA_4_2` varchar(8) NOT NULL,
  `APA_4_3` varchar(8) NOT NULL,
  `APA_5` varchar(8) NOT NULL,
  `APA_5_1` varchar(8) NOT NULL,
  `APA_5_2` varchar(8) NOT NULL,
  `APA_5_3` varchar(8) NOT NULL,
  `APA_6` varchar(8) NOT NULL,
  `APA_6_1` varchar(8) NOT NULL,
  `APA_6_2` varchar(8) NOT NULL,
  `APA_6_3` varchar(8) NOT NULL,
  `APA_6_4` varchar(8) NOT NULL,
  `APA_6_5` varchar(8) NOT NULL,
  `APA_6_6` varchar(8) NOT NULL,
  PRIMARY KEY (`COD_CON`,`COD_SOL`,`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_bar: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_bar` DISABLE KEYS */;
INSERT INTO `ctsec_bar` (`COD_CON`, `COD_SOL`, `DNI`, `RES_TOT`, `APA_1`, `APA_1_1`, `APA_1_1_1`, `APA_1_1_2`, `APA_1_1_3`, `APA_1_2`, `APA_1_2_1`, `APA_1_2_2`, `APA_1_2_3`, `APA_2`, `APA_3`, `APA_3_1`, `APA_3_1_1`, `APA_3_1_2`, `APA_3_1_3`, `APA_3_1_4`, `APA_3_2`, `APA_3_2_1`, `APA_3_2_2`, `APA_3_2_3`, `APA_3_2_4`, `APA_3_3`, `APA_4`, `APA_4_1`, `APA_4_2`, `APA_4_3`, `APA_5`, `APA_5_1`, `APA_5_2`, `APA_5_3`, `APA_6`, `APA_6_1`, `APA_6_2`, `APA_6_3`, `APA_6_4`, `APA_6_5`, `APA_6_6`) VALUES
	('51', '0012', '00000001R', '37.3332', '27.3332', '17.0000', '15.0000', '2.0000', '0.0000', '10.3332', '10.3332', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '4.0000', '0.0000', '0.0000', '4.0000', '6.0000', '6.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000');
/*!40000 ALTER TABLE `ctsec_bar` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
