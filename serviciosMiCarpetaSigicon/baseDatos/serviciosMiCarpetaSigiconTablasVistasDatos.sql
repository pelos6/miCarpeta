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

-- Volcando estructura de base de datos para serviciosmicarpetainterinos
CREATE DATABASE IF NOT EXISTS `serviciosmicarpetasigicon` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `serviciosmicarpetasigicon`;


-- Volcando estructura para tabla serviciosmicarpetainterinos.w_con
CREATE TABLE IF NOT EXISTS `w_con` (
  `cod_con` varchar(4) NOT NULL,
  `des_con` varchar(200) NOT NULL,
  `cod_tip_con` varchar(1) NOT NULL,
  `l_act` varchar(1) NOT NULL,
  PRIMARY KEY (`cod_con`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetainterinos.w_con: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `w_con` DISABLE KEYS */;
INSERT INTO `w_con` (`cod_con`, `des_con`, `cod_tip_con`, `l_act`) VALUES
	('333', 'Oposicion de secundaria', 'O', 'S'),
	('334', 'Convocatorias de ampliación de lisas de Trombón 0595 068', 'C', 'S'),
	('335', 'Convocatorias de ampliación de lisas de Filosofia 0590 001', 'C', 'S'),
	('336', 'Convocatorias de nueva baremación 2015', 'R', 'S');
/*!40000 ALTER TABLE `w_con` ENABLE KEYS */;


-- Volcando estructura para vista serviciosmicarpetainterinos.vconvocatoriaslistasactivas
-- Eliminando tabla temporal y crear estructura final de VIEW
CREATE VIEW `vconvocatoriaslistasactivas` AS select cod_con, des_con, cod_tip_con  from w_con where 
l_act = 'S' and cod_tip_con in ('C','R') ;


-- Volcando estructura para vista serviciosmicarpetainterinos.vsolicitudeslistas
-- Eliminando tabla temporal y crear estructura final de VIEW
CREATE VIEW `vsolicitudeslistas` AS SELECT o.cod_con, 'D ' tipo_id, '072982803' dni, '1234' cod_sol, o.des_con, 'grabada correctamente' estado
FROM  w_con o ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

CREATE VIEW `voposicionesactivas` AS
SELECT cod_con, des_con, IF (cod_tip_con='N','Nacional','Autonómico') AS cod_tip_con, l_act
FROM w_con ;

CREATE VIEW `vsolicitudesoposiciones` AS
SELECT cod_con, des_con,'D' tipo_id, '072982803' dni, '1234' cod_sol, 'grabada correctamente' estado
FROM w_con ;