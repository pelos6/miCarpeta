-- --------------------------------------------------------
-- Host:                         www.apostayadrede.com
-- Versión del servidor:         5.5.29-0ubuntu0.12.04.1 - (Ubuntu)
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para c23sigicon
CREATE DATABASE IF NOT EXISTS `c23sigicon` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `c23sigicon`;


-- Volcando estructura para vista c23sigicon.vconvocatoriaslistasactivas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vconvocatoriaslistasactivas` (
	`cod_con` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`des_con` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci',
	`cod_tip_con` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`f_res` DATE NOT NULL,
	`f_pub` DATE NOT NULL,
	`f_ini_sol` DATE NOT NULL,
	`f_fin_sol` DATE NOT NULL,
	`url` VARCHAR(37) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- Volcando estructura para vista c23sigicon.vconvocatoriaslistassolicitud
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vconvocatoriaslistassolicitud` (
	`cod_con` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`des_con` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci',
	`dni` VARCHAR(15) NOT NULL COLLATE 'utf8_general_ci',
	`cod_sol` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`l_act` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`cod_tip_con` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`f_res` DATE NOT NULL,
	`f_pub` DATE NOT NULL,
	`f_ini_sol` DATE NOT NULL,
	`f_fin_sol` DATE NOT NULL,
	`url` VARCHAR(37) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- Volcando estructura para vista c23sigicon.vconvocatoriasoposicionsolicitud
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vconvocatoriasoposicionsolicitud` (
	`cod_con` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`des_con` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci',
	`dni` VARCHAR(15) NOT NULL COLLATE 'utf8_general_ci',
	`cod_sol` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`l_act` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`cod_tip_con` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`f_res` DATE NOT NULL,
	`f_pub` DATE NOT NULL,
	`f_ini_sol` DATE NOT NULL,
	`f_fin_sol` DATE NOT NULL,
	`url` VARCHAR(37) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- Volcando estructura para vista c23sigicon.voposicionesactivas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `voposicionesactivas` (
	`cod_con` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`des_con` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci',
	`cod_tip_con` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`f_res` DATE NOT NULL,
	`f_pub` DATE NOT NULL,
	`f_ini_sol` DATE NOT NULL,
	`f_fin_sol` DATE NOT NULL,
	`url` VARCHAR(37) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- Volcando estructura para vista c23sigicon.vsolicitudeslistas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vsolicitudeslistas` (
	`tipo_id` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`dni` VARCHAR(15) NOT NULL COLLATE 'utf8_general_ci',
	`cod_con` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`des_con` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci',
	`cod_sol` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`fec_sol` DATETIME NULL,
	`cod_est_sol` VARCHAR(1) NULL COLLATE 'utf8_general_ci',
	`des_est_sol` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Volcando estructura para vista c23sigicon.vsolicitudesoposicion
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vsolicitudesoposicion` (
	`tipo_id` VARCHAR(1) NOT NULL COLLATE 'utf8_general_ci',
	`dni` VARCHAR(15) NOT NULL COLLATE 'utf8_general_ci',
	`cod_con` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`des_con` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci',
	`cod_sol` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`fec_sol` DATETIME NULL,
	`cod_est_sol` VARCHAR(1) NULL COLLATE 'utf8_general_ci',
	`des_est_sol` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Volcando estructura para vista c23sigicon.vsolicitudesoposiciones
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vsolicitudesoposiciones` (
	`cod_con` VARCHAR(4) NOT NULL COLLATE 'utf8_general_ci',
	`des_con` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci',
	`tipo_id` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`dni` VARCHAR(9) NOT NULL COLLATE 'utf8mb4_general_ci',
	`cod_sol` VARCHAR(4) NOT NULL COLLATE 'utf8mb4_general_ci',
	`estado` VARCHAR(21) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- Volcando estructura para tabla c23sigicon.w_con
CREATE TABLE IF NOT EXISTS `w_con` (
  `cod_con` varchar(4) NOT NULL,
  `des_con` varchar(200) NOT NULL,
  `cod_tip_con` varchar(1) NOT NULL,
  `l_act` varchar(1) NOT NULL,
  `fas_con` varchar(1) NOT NULL,
  `f_res` date NOT NULL,
  `f_pub` date NOT NULL,
  `f_ini_sol` date NOT NULL,
  `f_fin_sol` date NOT NULL,
  PRIMARY KEY (`cod_con`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla c23sigicon.w_con: 4 rows
/*!40000 ALTER TABLE `w_con` DISABLE KEYS */;
INSERT INTO `w_con` (`cod_con`, `des_con`, `cod_tip_con`, `l_act`, `fas_con`, `f_res`, `f_pub`, `f_ini_sol`, `f_fin_sol`) VALUES
	('333', 'Oposicion de secundaria', 'O', 'S', '1', '2015-07-28', '2015-07-29', '2015-07-30', '2015-12-10'),
	('334', 'Convocatorias de ampliación de listas de Trombón 0595 068', 'C', 'S', '2', '2015-07-28', '2015-07-29', '2015-07-30', '2015-12-10'),
	('335', 'Convocatorias de ampliación de listas de Filosofia 0590 001', 'C', 'S', '2', '2015-07-28', '2015-07-29', '2015-07-30', '2015-12-10'),
	('336', 'Convocatorias de nueva baremación 2015 local', 'R', 'S', '2', '2015-07-28', '2015-07-29', '2015-07-30', '2015-12-10');
/*!40000 ALTER TABLE `w_con` ENABLE KEYS */;


-- Volcando estructura para tabla c23sigicon.w_est_sol
CREATE TABLE IF NOT EXISTS `w_est_sol` (
  `COD_EST_SOL` varchar(1) NOT NULL,
  `DES_EST_SOL` varchar(200) NOT NULL,
  `L_ACT` varchar(1) NOT NULL,
  PRIMARY KEY (`COD_EST_SOL`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla c23sigicon.w_est_sol: 4 rows
/*!40000 ALTER TABLE `w_est_sol` DISABLE KEYS */;
INSERT INTO `w_est_sol` (`COD_EST_SOL`, `DES_EST_SOL`, `L_ACT`) VALUES
	('0', 'SOLICITUD GRABADA CORRECTAMENTE', 'S'),
	('1', 'SOLICITUD PRESENTADA AL PROCEDIMIENTO', 'S'),
	('2', 'SOLICITUD ADMITIDA AL PROCEDIMIENTO', 'S'),
	('3', 'SOLICITUD EXCLUIDA DEL PROCEDIMIENTO', 'S');
/*!40000 ALTER TABLE `w_est_sol` ENABLE KEYS */;


-- Volcando estructura para tabla c23sigicon.w_sol
CREATE TABLE IF NOT EXISTS `w_sol` (
  `COD_CON` varchar(4) NOT NULL,
  `COD_CUE` varchar(4) NOT NULL,
  `COD_ESP` varchar(3) NOT NULL,
  `COD_ACC` varchar(1) DEFAULT NULL,
  `COD_SOL` varchar(4) NOT NULL DEFAULT '',
  `TIPO_ID` varchar(1) NOT NULL,
  `DNI` varchar(15) NOT NULL DEFAULT '',
  `APE1` varchar(22) DEFAULT NULL,
  `APE2` varchar(22) DEFAULT NULL,
  `NOM` varchar(14) DEFAULT NULL,
  `F_NAC` date DEFAULT NULL,
  `SEX` varchar(1) DEFAULT NULL,
  `COD_PRO_NAC` varchar(2) DEFAULT NULL,
  `COD_LOC_NAC` varchar(9) DEFAULT NULL,
  `COD_LOC_RES` varchar(9) DEFAULT NULL,
  `COD_PRO_RES` varchar(2) DEFAULT NULL,
  `COD_NAC_RES` varchar(3) DEFAULT NULL,
  `DAN` varchar(1) DEFAULT NULL,
  `FEC_SOL` datetime DEFAULT NULL,
  `COD_TIT_ACC_CUE` varchar(12) DEFAULT NULL,
  `TEL1` varchar(9) DEFAULT NULL,
  `TEL2` varchar(9) DEFAULT NULL,
  `CUE_COR` varchar(100) DEFAULT NULL,
  `DOM` varchar(50) DEFAULT NULL,
  `COD_POS` varchar(5) DEFAULT NULL,
  `LOC_FIR` varchar(50) DEFAULT NULL,
  `F_FIR` date DEFAULT NULL,
  `L_RES` varchar(1) DEFAULT NULL,
  `DES_ADA` varchar(150) DEFAULT NULL,
  `COD_NAC` varchar(3) DEFAULT NULL,
  `L_CAS` varchar(1) DEFAULT NULL,
  `L_INT` varchar(1) DEFAULT NULL,
  `COD_PRO_REF` varchar(2) DEFAULT NULL,
  `L_INF` varchar(1) DEFAULT NULL,
  `COD_CCAA_INF` varchar(2) DEFAULT NULL,
  `COD_CUE_PRO` varchar(4) DEFAULT NULL,
  `COD_ESP_PRO` varchar(3) DEFAULT NULL,
  `L_TPE` varchar(1) DEFAULT NULL,
  `L_DIS` varchar(1) DEFAULT NULL,
  `JUS` varchar(13) DEFAULT NULL,
  `L_EXE` varchar(1) DEFAULT NULL,
  `COD_EST_SOL` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`COD_CON`,`COD_SOL`,`TIPO_ID`,`DNI`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla c23sigicon.w_sol: 6 rows
/*!40000 ALTER TABLE `w_sol` DISABLE KEYS */;
INSERT INTO `w_sol` (`COD_CON`, `COD_CUE`, `COD_ESP`, `COD_ACC`, `COD_SOL`, `TIPO_ID`, `DNI`, `APE1`, `APE2`, `NOM`, `F_NAC`, `SEX`, `COD_PRO_NAC`, `COD_LOC_NAC`, `COD_LOC_RES`, `COD_PRO_RES`, `COD_NAC_RES`, `DAN`, `FEC_SOL`, `COD_TIT_ACC_CUE`, `TEL1`, `TEL2`, `CUE_COR`, `DOM`, `COD_POS`, `LOC_FIR`, `F_FIR`, `L_RES`, `DES_ADA`, `COD_NAC`, `L_CAS`, `L_INT`, `COD_PRO_REF`, `L_INF`, `COD_CCAA_INF`, `COD_CUE_PRO`, `COD_ESP_PRO`, `L_TPE`, `L_DIS`, `JUS`, `L_EXE`, `COD_EST_SOL`) VALUES
	('333', '0595', '068', '0', '0099', 'D', '00000002W', 'APELLIDO1', 'APELLIDO2', 'NOMBRE', '2015-08-01', 'H', '50', NULL, NULL, '50', NULL, NULL, '2015-08-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2'),
	('333', '0595', '068', '0', '0101', 'D', '00000001R', 'APELLIDO1', 'APELLIDO2', 'NOMBRE', '2015-08-01', 'H', '50', NULL, NULL, '50', NULL, NULL, '2015-08-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2'),
	('333', '0595', '068', '0', '0102', 'D', '00000001R', 'APELLIDO1', 'APELLIDO2', 'NOMBRE', '2015-08-01', 'H', '50', NULL, NULL, '50', NULL, NULL, '2015-08-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2'),
	('334', '0595', '068', '0', '0001', 'D', '00000002W', 'APELLIDO1', 'APELLIDO2', 'NOMBRE', '2015-08-01', 'H', '50', NULL, NULL, '50', NULL, NULL, '2015-08-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0'),
	('334', '0595', '068', '0', '0002', 'D', '00000002W', 'APELLIDO1', 'APELLIDO2', 'NOMBRE', '2015-08-01', 'H', '50', NULL, NULL, '50', NULL, NULL, '2015-08-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1'),
	('335', '0595', '068', '0', '0009', 'D', '00000001R', 'APELLIDO1', 'APELLIDO2', 'NOMBRE', '2015-08-01', 'H', '50', NULL, NULL, '50', NULL, NULL, '2015-08-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2');
/*!40000 ALTER TABLE `w_sol` ENABLE KEYS */;


-- Volcando estructura para vista c23sigicon.vconvocatoriaslistasactivas
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vconvocatoriaslistasactivas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`c23sigicon`@`%` SQL SECURITY DEFINER VIEW `vconvocatoriaslistasactivas` AS select `c`.`cod_con` AS `cod_con`,`c`.`des_con` AS `des_con`,`c`.`cod_tip_con` AS `cod_tip_con`,`c`.`f_res` AS `f_res`,`c`.`f_pub` AS `f_pub`,`c`.`f_ini_sol` AS `f_ini_sol`,`c`.`f_fin_sol` AS `f_fin_sol`,'https://servicios3.aragon.es/sigicon/' AS `url` from `w_con` `c` where ((`c`.`l_act` = 'S') and (`c`.`cod_tip_con` in ('C','R')) and (`c`.`f_ini_sol` <= sysdate()) and (`c`.`f_fin_sol` >= sysdate()));


-- Volcando estructura para vista c23sigicon.vconvocatoriaslistassolicitud
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vconvocatoriaslistassolicitud`;
CREATE ALGORITHM=UNDEFINED DEFINER=`c23sigicon`@`%` SQL SECURITY DEFINER VIEW `vconvocatoriaslistassolicitud` AS select `c`.`cod_con` AS `cod_con`,`c`.`des_con` AS `des_con`,`s`.`DNI` AS `dni`,`s`.`COD_SOL` AS `cod_sol`,`c`.`l_act` AS `l_act`,`c`.`cod_tip_con` AS `cod_tip_con`,`c`.`f_res` AS `f_res`,`c`.`f_pub` AS `f_pub`,`c`.`f_ini_sol` AS `f_ini_sol`,`c`.`f_fin_sol` AS `f_fin_sol`,'https://servicios3.aragon.es/sigicon/' AS `url` from (`w_con` `c` join `w_sol` `s`) where ((`c`.`cod_con` = `s`.`COD_CON`) and (`c`.`cod_tip_con` in ('C','R')));


-- Volcando estructura para vista c23sigicon.vconvocatoriasoposicionsolicitud
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vconvocatoriasoposicionsolicitud`;
CREATE ALGORITHM=UNDEFINED DEFINER=`c23sigicon`@`%` SQL SECURITY DEFINER VIEW `vconvocatoriasoposicionsolicitud` AS select `c`.`cod_con` AS `cod_con`,`c`.`des_con` AS `des_con`,`s`.`DNI` AS `dni`,`s`.`COD_SOL` AS `cod_sol`,`c`.`l_act` AS `l_act`,`c`.`cod_tip_con` AS `cod_tip_con`,`c`.`f_res` AS `f_res`,`c`.`f_pub` AS `f_pub`,`c`.`f_ini_sol` AS `f_ini_sol`,`c`.`f_fin_sol` AS `f_fin_sol`,'https://servicios3.aragon.es/sigicon/' AS `url` from (`w_con` `c` join `w_sol` `s`) where ((`c`.`cod_con` = `s`.`COD_CON`) and (`c`.`cod_tip_con` = 'O'));


-- Volcando estructura para vista c23sigicon.voposicionesactivas
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `voposicionesactivas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`c23sigicon`@`%` SQL SECURITY DEFINER VIEW `voposicionesactivas` AS select `c`.`cod_con` AS `cod_con`,`c`.`des_con` AS `des_con`,`c`.`cod_tip_con` AS `cod_tip_con`,`c`.`f_res` AS `f_res`,`c`.`f_pub` AS `f_pub`,`c`.`f_ini_sol` AS `f_ini_sol`,`c`.`f_fin_sol` AS `f_fin_sol`,'https://servicios3.aragon.es/sigicon/' AS `url` from `w_con` `c` where ((`c`.`l_act` = 'S') and (`c`.`cod_tip_con` = 'O'));


-- Volcando estructura para vista c23sigicon.vsolicitudeslistas
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vsolicitudeslistas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`c23sigicon`@`%` SQL SECURITY DEFINER VIEW `vsolicitudeslistas` AS select `s`.`TIPO_ID` AS `tipo_id`,`s`.`DNI` AS `dni`,`s`.`COD_CON` AS `cod_con`,`c`.`des_con` AS `des_con`,`s`.`COD_SOL` AS `cod_sol`,`s`.`FEC_SOL` AS `fec_sol`,`s`.`COD_EST_SOL` AS `cod_est_sol`,`e`.`DES_EST_SOL` AS `des_est_sol` from ((`w_con` `c` join `w_sol` `s`) join `w_est_sol` `e`) where ((`c`.`cod_con` = `s`.`COD_CON`) and (`e`.`COD_EST_SOL` = `s`.`COD_EST_SOL`) and (`c`.`cod_tip_con` in ('C','R')));


-- Volcando estructura para vista c23sigicon.vsolicitudesoposicion
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vsolicitudesoposicion`;
CREATE ALGORITHM=UNDEFINED DEFINER=`c23sigicon`@`%` SQL SECURITY DEFINER VIEW `vsolicitudesoposicion` AS select `s`.`TIPO_ID` AS `tipo_id`,`s`.`DNI` AS `dni`,`s`.`COD_CON` AS `cod_con`,`c`.`des_con` AS `des_con`,`s`.`COD_SOL` AS `cod_sol`,`s`.`FEC_SOL` AS `fec_sol`,`s`.`COD_EST_SOL` AS `cod_est_sol`,`e`.`DES_EST_SOL` AS `des_est_sol` from ((`w_con` `c` join `w_sol` `s`) join `w_est_sol` `e`) where ((`c`.`cod_con` = `s`.`COD_CON`) and (`e`.`COD_EST_SOL` = `s`.`COD_EST_SOL`) and (`c`.`cod_tip_con` = 'O'));


-- Volcando estructura para vista c23sigicon.vsolicitudesoposiciones
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vsolicitudesoposiciones`;
CREATE ALGORITHM=UNDEFINED DEFINER=`c23sigicon`@`%` SQL SECURITY DEFINER VIEW `vsolicitudesoposiciones` AS select `w_con`.`cod_con` AS `cod_con`,`w_con`.`des_con` AS `des_con`,'D' AS `tipo_id`,'072982803' AS `dni`,'1234' AS `cod_sol`,'grabada correctamente' AS `estado` from `w_con`;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
