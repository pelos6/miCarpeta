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

-- Volcando estructura de base de datos para serviciosmicarpetasigi
CREATE DATABASE IF NOT EXISTS `serviciosmicarpetasigi` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `serviciosmicarpetasigi`;


-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_cue
CREATE TABLE IF NOT EXISTS `sigi_cue` (
  `COD_CUE` varchar(4) NOT NULL,
  `DES_CUE` varchar(200) NOT NULL,
  KEY `PK_SIGI_CUE` (`COD_CUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_cue: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_cue` DISABLE KEYS */;
INSERT INTO `sigi_cue` (`COD_CUE`, `DES_CUE`) VALUES
	('0597', 'DES CUERP'),
	('0591', 'DES CUERP'),
	('0590', 'DES CUERP'),
	('0597', 'DES CUERPO'),
	('0591', 'DES CUERPO'),
	('0590', 'DES CUERPO');
/*!40000 ALTER TABLE `sigi_cue` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
