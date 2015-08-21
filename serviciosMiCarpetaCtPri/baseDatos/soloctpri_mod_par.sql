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

-- Volcando estructura de base de datos para serviciosmicarpetaconcursosprimaria
CREATE DATABASE IF NOT EXISTS `serviciosmicarpetaconcursosprimaria` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `serviciosmicarpetaconcursosprimaria`;


-- Volcando estructura para tabla serviciosmicarpetaconcursosprimaria.ctpri_mod_par
CREATE TABLE IF NOT EXISTS `ctpri_mod_par` (
  `COD_MOD_PAR` varchar(1) NOT NULL,
  `DES_MOD_PAR` varchar(200) NOT NULL,
  `L_ACT` varchar(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`COD_MOD_PAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursosprimaria.ctpri_mod_par: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `ctpri_mod_par` DISABLE KEYS */;
INSERT INTO `ctpri_mod_par` (`COD_MOD_PAR`, `DES_MOD_PAR`, `L_ACT`) VALUES
	('A', 'Destino Definitivo', 'S'),
	('B', 'Excedente voluntario', 'S'),
	('C', 'Resolución firme de expediente disciplinario', 'S'),
	('D', 'Cumplimiento de sentencia o resolución de recurso', 'S'),
	('E', 'Supresión o modificación del puesto de trabajo que desempeñaban con carácter definitivo', 'S'),
	('F', 'Reingreso con destino provisional', 'S'),
	('G', 'Excedencia forzosa', 'S'),
	('H', 'Suspensión de funciones una vez cumplida la sanción', 'S'),
	('I', 'Causas análogas que hayan implicado la pérdida del puesto de trabajo que desempeñaban con carácter definitivo', 'S'),
	('J', 'Provisional que nunca ha obtenido destino definitivo', 'S'),
	('K', 'En Practicas', 'S');
/*!40000 ALTER TABLE `ctpri_mod_par` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
