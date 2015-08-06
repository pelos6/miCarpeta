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


-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.ctsec_con
CREATE TABLE IF NOT EXISTS `ctsec_con` (
  `cod_con` varchar(20) NOT NULL,
  `des_con` varchar(200) NOT NULL,
  `cod_tip_con` varchar(1) NOT NULL,
  `l_act` varchar(1) NOT NULL,
  `cod_fas_con` varchar(1) NOT NULL,
  `f_ini_sol` date NOT NULL,
  `f_fin_sol` date NOT NULL,
  PRIMARY KEY (`cod_con`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_con: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_con` DISABLE KEYS */;
INSERT INTO `ctsec_con` (`cod_con`, `des_con`, `cod_tip_con`, `l_act`, `cod_fas_con`, `f_ini_sol`, `f_fin_sol`) VALUES
	('51', 'Concurso de traslados de secundaria', 'N', 'S', '1', '0000-00-00', '0000-00-00');
/*!40000 ALTER TABLE `ctsec_con` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.ctsec_est_sol
CREATE TABLE IF NOT EXISTS `ctsec_est_sol` (
  `COD_EST_SOL` varchar(1) NOT NULL,
  `DES_EST_SOL` varchar(200) NOT NULL,
  `L_ACT` varchar(1) NOT NULL,
  PRIMARY KEY (`COD_EST_SOL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_est_sol: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_est_sol` DISABLE KEYS */;
INSERT INTO `ctsec_est_sol` (`COD_EST_SOL`, `DES_EST_SOL`, `L_ACT`) VALUES
	('0', 'SOLICITUD GRABADA CORRECTAMENTE', 'S'),
	('1', 'SOLICITUD PRESENTADA AL PROCEDIMIENTO', 'S'),
	('2', 'SOLICITUD ADMITIDA AL PROCEDIMIENTO', 'S'),
	('3', 'SOLICITUD EXCLUIDA DEL PROCEDIMIENTO', 'S');
/*!40000 ALTER TABLE `ctsec_est_sol` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.ctsec_fas_con
CREATE TABLE IF NOT EXISTS `ctsec_fas_con` (
  `COD_FAS_CON` varchar(1) NOT NULL,
  `DES_FAS_CON` varchar(200) NOT NULL,
  `L_ACT` varchar(1) NOT NULL,
  PRIMARY KEY (`COD_FAS_CON`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_fas_con: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_fas_con` DISABLE KEYS */;
INSERT INTO `ctsec_fas_con` (`COD_FAS_CON`, `DES_FAS_CON`, `L_ACT`) VALUES
	('0', 'convocatoria creada', 'S'),
	('1', 'grabación de solicitudes', 'S'),
	('2', 'petición de documentación', 'S');
/*!40000 ALTER TABLE `ctsec_fas_con` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.ctsec_sol
CREATE TABLE IF NOT EXISTS `ctsec_sol` (
  `DNI` varchar(15) NOT NULL,
  `COD_CON` varchar(7) NOT NULL,
  `COD_SOL` varchar(4) NOT NULL,
  `F_HOR_ENT` date NOT NULL,
  `COD_EST_SOL` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_sol: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_sol` DISABLE KEYS */;
INSERT INTO `ctsec_sol` (`DNI`, `COD_CON`, `COD_SOL`, `F_HOR_ENT`, `COD_EST_SOL`) VALUES
	('000000001', '51', '0011', '2015-08-02', '0'),
	('000000001', '51', '0012', '2015-08-02', '0'),
	('000000001', '51', '0013', '2015-08-02', '0'),
	('000000002', '51', '0003', '2015-08-02', '0');
/*!40000 ALTER TABLE `ctsec_sol` ENABLE KEYS */;



-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.wctem_part
CREATE TABLE IF NOT EXISTS `wctem_part` (
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

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.wctem_part: ~24 rows (aproximadamente)
/*!40000 ALTER TABLE `wctem_part` DISABLE KEYS */;
INSERT INTO `wctem_part` (`PROV`, `NORDEN`, `DNI`, `APE1`, `APE2`, `NOMBRE`, `TELEF`, `MODALIDAD`, `FECHAGRABACION`) VALUES
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
/*!40000 ALTER TABLE `wctem_part` ENABLE KEYS */;


-- Volcando estructura para vista serviciosmicarpetaconcursossecundaria.vconcursosactivos
-- Eliminando tabla temporal y crear estructura final de VIEW
CREATE VIEW `vconcursosactivos` AS select c.cod_con, c.des_con, if((`cod_tip_con` = 'N'),'Nacional','Autonómico') AS `des_tip_con`, cod_tip_con
, c.l_act, f.des_fas_con ,'http://servicios.aragon.es/tsec/' AS `url`, f_ini_sol, f_fin_sol from ctsec_con c , 
ctsec_fas_con f
where c.cod_fas_con = f.cod_fas_con ;


-- Volcando estructura para vista serviciosmicarpetaconcursossecundaria.vconcursossolicitud
-- Eliminando tabla temporal y crear estructura final de VIEW
CREATE VIEW `vconcursossolicitud` AS select o.cod_con, o.cod_tip_con, o.des_con, o.l_act,
s.dni, s.cod_sol, s.f_hor_ent, s.cod_est_sol, e.des_est_sol
, 'http://servicios.aragon.es/tpri/' AS `url`, o.f_ini_sol, o.f_fin_sol,
if((`cod_tip_con` = 'N'),'Nacional','Autonómico') AS `des_tip_con`,
des_fas_con
FROM ctsec_con o, ctsec_sol s, ctsec_fas_con f,
ctsec_est_sol e
WHERE s.cod_con = o.cod_con AND s.cod_est_sol = e.cod_est_sol 
and f.cod_fas_con = o.cod_fas_con ;


-- Volcando estructura para vista serviciosmicarpetaconcursossecundaria.vsolicitudesconcursos
-- Eliminando tabla temporal y crear estructura final de VIEW

CREATE VIEW `vsolicitudesconcursos` AS SELECT c.des_con as des_con, cod_con, dni, norden as cod_sol , fechagrabacion, 'grabada correctamente' estado
FROM wctem_part p, ct_con c
where c.cod_con = 'CT_SEC' ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
