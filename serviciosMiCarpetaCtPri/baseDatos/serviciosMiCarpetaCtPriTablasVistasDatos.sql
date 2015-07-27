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


-- Volcando estructura para tabla serviciosmicarpetaconcursosprimaria.ct_con
CREATE TABLE IF NOT EXISTS `ct_con` (
  `cod_con` varchar(20) NOT NULL,
  `des_con` varchar(200) NOT NULL,
  `cod_tip_con` varchar(1) NOT NULL,
  `l_act` varchar(1) NOT NULL,
  `cod_fas` char(1) DEFAULT NULL,
  PRIMARY KEY (`cod_con`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursosprimaria.ct_con: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `ct_con` DISABLE KEYS */;
INSERT INTO `ct_con` (`cod_con`, `des_con`, `cod_tip_con`, `l_act`, `cod_fas`) VALUES
	('CT_PRI', 'Concurso de traslados de primaria', 'A', 'S', '2');
/*!40000 ALTER TABLE `ct_con` ENABLE KEYS */;






-- Volcando estructura para tabla serviciosmicarpetaconcursosprimaria.wct_part
CREATE TABLE IF NOT EXISTS `wct_part` (
  `PROV` varchar(2) NOT NULL,
  `NORDEN` varchar(4) NOT NULL,
  `DNI` varchar(9) NOT NULL,
  `APE1` varchar(24) NOT NULL,
  `APE2` varchar(24) DEFAULT NULL,
  `NOMBRE` varchar(24) NOT NULL,
  `TELEF` varchar(15) DEFAULT NULL,
  `MODALIDAD` varchar(1) DEFAULT NULL,
  `FECHAGRABACION` datetime DEFAULT NULL,
  PRIMARY KEY (`DNI`,`NORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursosprimaria.wct_part: ~24 rows (aproximadamente)
/*!40000 ALTER TABLE `wct_part` DISABLE KEYS */;
INSERT INTO `wct_part` (`PROV`, `NORDEN`, `DNI`, `APE1`, `APE2`, `NOMBRE`, `TELEF`, `MODALIDAD`, `FECHAGRABACION`) VALUES
	('22', '1234', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '1747', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '4321', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '4568', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '6685', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '7588', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '7596', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '7822', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '8969', '012345678', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '1234', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '1747', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '4321', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '4568', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '6685', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '7588', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '7596', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '7822', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '8969', '023456785', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '1234', '072982803', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 16:53:37'),
	('22', '5797', '072982803', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 09:53:37'),
	('22', '7855', '072982803', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-03 13:53:37'),
	('22', '1234', '075899658', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-14 16:53:37'),
	('22', '5797', '075899658', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-15 09:53:37'),
	('22', '7855', '075899658', 'GONZALEZ', 'GONZALEZ', 'JOSE', '976123456', 'K', '2015-07-03 13:53:37');
/*!40000 ALTER TABLE `wct_part` ENABLE KEYS */;


CREATE  VIEW `vconcursosactivos` AS select `ct_con`.`cod_con` AS `cod_con`,`ct_con`.`des_con` AS `des_con`,if((`ct_con`.`cod_tip_con` = 'N'),'Nacional','Autonómico') AS `cod_tip_con`,`ct_con`.`l_act` AS `l_act`,'http://servicios.aragon.es/tpri/' AS `url`,
if((`ct_con`.`cod_fas` = '1'),'Solicitudes','Peticion documentacion') AS `des_fas`
 from `ct_con` ;

CREATE  VIEW `vsolicitudesconcursos` AS SELECT c.des_con as des_con, cod_con, dni, norden as cod_sol , fechagrabacion, 'grabada correctamente' estado
FROM wct_part p, ct_con c
where c.cod_con = 'CT_PRI' ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
