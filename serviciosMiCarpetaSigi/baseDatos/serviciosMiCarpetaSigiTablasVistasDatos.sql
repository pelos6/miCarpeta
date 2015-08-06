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



-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_can_pre_ae
CREATE TABLE IF NOT EXISTS `sigi_can_pre_ae` (
  `tipo_id` varchar(1) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `cod_opc` varchar(7) NOT NULL,
  `cod_col` varchar(1) NOT NULL,
  `l_med` varchar(1) DEFAULT NULL,
  `cod_mun` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`tipo_id`,`dni`,`cod_opc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_can_pre_ae: ~400 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_can_pre_ae` DISABLE KEYS */;
INSERT INTO `sigi_can_pre_ae` (`tipo_id`, `dni`, `cod_opc`, `cod_col`, `l_med`, `cod_mun`) VALUES
	('D', '000000001', 'SIGIPAE', '0', 'N', NULL),
	('D', '000000001', 'SIGISAE', '0', 'N', NULL),
	('D', '003927930', 'SIGIPAE', '0', 'N', NULL),
	('D', '079326377', 'SIGISAE', '0', NULL, NULL);
/*!40000 ALTER TABLE `sigi_can_pre_ae` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_esp_can_pre_ae
CREATE TABLE IF NOT EXISTS `sigi_esp_can_pre_ae` (
  `TIPO_ID` varchar(1) NOT NULL,
  `DNI` varchar(15) NOT NULL,
  `COD_OPC` varchar(7) NOT NULL,
  `COD_CUE` varchar(4) NOT NULL,
  `COD_ESP` varchar(3) NOT NULL,
  `COD_PRO_1_SUS` varchar(2) DEFAULT NULL,
  `COD_PRO_2_SUS` varchar(2) DEFAULT NULL,
  `L_LIS_SUS` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_esp_can_pre_ae: ~502 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_esp_can_pre_ae` DISABLE KEYS */;
INSERT INTO `sigi_esp_can_pre_ae` (`TIPO_ID`, `DNI`, `COD_OPC`, `COD_CUE`, `COD_ESP`, `COD_PRO_1_SUS`, `COD_PRO_2_SUS`, `L_LIS_SUS`) VALUES
	('D', '029127154', 'SIGIPAE', '0597', 'PT', NULL, NULL, 'N'),
	('D', '029112865', 'SIGIPAE', '0597', 'PT', NULL, NULL, 'N'),
	('D', '072993429', 'SIGIPAE', '0597', 'PT', NULL, NULL, 'N');
/*!40000 ALTER TABLE `sigi_esp_can_pre_ae` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_est_sol
CREATE TABLE IF NOT EXISTS `sigi_est_sol` (
  `COD_EST_SOL` varchar(1) NOT NULL,
  `DES_EST_SOL` varchar(200) NOT NULL,
  `L_ACT` varchar(1) NOT NULL,
  PRIMARY KEY (`COD_EST_SOL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_est_sol: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_est_sol` DISABLE KEYS */;
INSERT INTO `sigi_est_sol` (`COD_EST_SOL`, `DES_EST_SOL`, `L_ACT`) VALUES
	('0', 'SOLICITUD GRABADA CORRECTAMENTE', 'S'),
	('1', 'SOLICITUD PRESENTADA AL PROCEDIMIENTO', 'S'),
	('2', 'SOLICITUD ADMITIDA AL PROCEDIMIENTO', 'S'),
	('3', 'SOLICITUD EXCLUIDA DEL PROCEDIMIENTO', 'S');
/*!40000 ALTER TABLE `sigi_est_sol` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_lis
CREATE TABLE IF NOT EXISTS `sigi_lis` (
  `COD_OPC` varchar(7) NOT NULL,
  `TIPO_ID` varchar(1) NOT NULL,
  `DNI` varchar(15) NOT NULL,
  `COD_CUE` varchar(4) NOT NULL,
  `COD_ESP` varchar(3) NOT NULL,
  `TIP_LIS` varchar(1) NOT NULL,
  `FEC_ORI_BLO` varchar(8) NOT NULL,
  `COD_BLO` varchar(155) NOT NULL,
  `NUM_ORD` varchar(4) NOT NULL,
  `RES_TOT` varchar(6) NOT NULL,
  `COD_EST` varchar(10) NOT NULL,
  `DES_CAU_EST` varchar(150) DEFAULT NULL,
  `FEC_INI_EST` date DEFAULT NULL,
  `DES_PRO_1_SUS` varchar(8) DEFAULT NULL,
  `FEC_PRO_1_SUS` date DEFAULT NULL,
  `DES_PRO_2_SUS` varchar(8) DEFAULT NULL,
  `FEC_PRO_2_SUS` date DEFAULT NULL,
  `ORD_DIS_ZA` varchar(4) DEFAULT NULL,
  `ORD_DIS_HU` varchar(4) DEFAULT NULL,
  `ORD_DIS_TE` varchar(4) DEFAULT NULL,
  `ORD_CCAO` varchar(4) DEFAULT NULL,
  `DES_PRO_REF` varchar(8) DEFAULT NULL,
  `L_RES` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_lis: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_lis` DISABLE KEYS */;
INSERT INTO `sigi_lis` (`COD_OPC`, `TIPO_ID`, `DNI`, `COD_CUE`, `COD_ESP`, `TIP_LIS`, `FEC_ORI_BLO`, `COD_BLO`, `NUM_ORD`, `RES_TOT`, `COD_EST`, `DES_CAU_EST`, `FEC_INI_EST`, `DES_PRO_1_SUS`, `FEC_PRO_1_SUS`, `DES_PRO_2_SUS`, `FEC_PRO_2_SUS`, `ORD_DIS_ZA`, `ORD_DIS_HU`, `ORD_DIS_TE`, `ORD_CCAO`, `DES_PRO_REF`, `L_RES`) VALUES
	('SIGISSP', 'D', '000000001', '0590', '001', '1', '01/08/20', '20', '12', '78,5', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SIGIPSP', 'D', '000000001', '0590', '001', '1', '01/08/20', '20', '12', '78,5', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SIGIPSP', 'D', '000000002', '0590', '001', '1', '01/08/20', '20', '12', '78,5', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SIGIPSP', 'D', '000000002', '0590', '001', '1', '01/08/20', '20', '12', '78,5', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `sigi_lis` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_opc
CREATE TABLE IF NOT EXISTS `sigi_opc` (
  `COD_OPC` varchar(7) NOT NULL,
  `F_CON_AE` date DEFAULT NULL,
  `COD_TIP_AE` varchar(1) DEFAULT NULL,
  `TEX_OPC` varchar(200) NOT NULL,
  `TEX_OPC_CAB` varchar(200) NOT NULL,
  `TEX_OPC_PDF` varchar(200) DEFAULT NULL,
  `FEC_CUR_COM` varchar(10) DEFAULT NULL,
  `L_VIS` varchar(1) NOT NULL,
  `L_ACT` varchar(1) NOT NULL,
  `L_PET_MAS` varchar(1) DEFAULT NULL,
  `L_RES_VIS` varchar(1) DEFAULT NULL,
  `L_RES_ACT` varchar(1) DEFAULT NULL,
  `F_INI_OPC` date NOT NULL,
  `F_FIN_OPC` date NOT NULL,
  `C_USU_ULT_MOD` varchar(8) NOT NULL,
  `F_ULT_MOD` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_opc: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_opc` DISABLE KEYS */;
INSERT INTO `sigi_opc` (`COD_OPC`, `F_CON_AE`, `COD_TIP_AE`, `TEX_OPC`, `TEX_OPC_CAB`, `TEX_OPC_PDF`, `FEC_CUR_COM`, `L_VIS`, `L_ACT`, `L_PET_MAS`, `L_RES_VIS`, `L_RES_ACT`, `F_INI_OPC`, `F_FIN_OPC`, `C_USU_ULT_MOD`, `F_ULT_MOD`) VALUES
	('SIGIPAE', '2015-07-28', 'I', 'PRIMARIA ACTO DE ELECCION DE INTERINOS DE INICIO DE CURSO DE FECHA 28/07/15', 'Fecha del Acto de Elección de Inicio de curso 28/07/15', 'CUERPO DE MAESTROS - INTERINOS', '31/10/14', 'S', 'N', 'S', 'S', 'S', '2015-07-28', '2015-07-28', 'SCPRINRE', '2015-07-28'),
	('SIGISSP', NULL, NULL, 'SECUNDARIA CONSULTA DE LA SITUACION DEL PARTICIPANTE', 'CONSULTA DE LA SITUACION DEL PARTICIPANTE DE SECUNDARIA', NULL, '31/10/14', 'S', 'S', 'N', 'N', 'N', '2015-07-28', '2015-07-28', 'SYSTEM', '2015-07-28'),
	('SIGIPSP', NULL, NULL, 'PRIMARIA CONSULTA DE LA SITUACION DEL PARTICIPANTE', 'CONSULTA DE LA SITUACiON DEL PARTICIPANTE DE PRIMARIA', NULL, '31/10/14', 'S', 'N', 'N', 'N', 'N', '2015-07-28', '2015-07-28', 'SYSTEM', '2015-07-28'),
	('SIGISAE', '2015-07-28', 'S', 'SECUNDARIA ACTO DE ELECCIÓN DE INTERINOS SEMANAL DE FECHA 11/06/15', 'Fecha del Acto de Elección Semanal 11/06/15', 'PERSONAL INTERINO DE ENSEÑANZA SECUNDARIA, F.P. Y RÉGIMEN ESPECIAL. MODELO DE SOLICITUD PARA ELECCIÓN DE DESTINO. CURSO 2014/2015', '31/10/14', 'S', 'S', 'N', 'N', 'N', '2015-07-28', '2015-07-28', 'SCEMINRE', '2015-07-28');
/*!40000 ALTER TABLE `sigi_opc` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_sol
CREATE TABLE IF NOT EXISTS `sigi_sol` (
  `TIPO_ID` varchar(1) NOT NULL,
  `DNI` varchar(15) NOT NULL,
  `COD_OPC` varchar(7) NOT NULL,
  `COD_SOL` varchar(4) NOT NULL,
  `F_HOR_ENT` date NOT NULL,
  `COD_EST_SOL` varchar(1) NOT NULL,
  `COD_USU` varchar(8) NOT NULL,
  `F_HOR_PRE` date DEFAULT NULL,
  `L_PRE` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_sol: ~100 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_sol` DISABLE KEYS */;
INSERT INTO `sigi_sol` (`TIPO_ID`, `DNI`, `COD_OPC`, `COD_SOL`, `F_HOR_ENT`, `COD_EST_SOL`, `COD_USU`, `F_HOR_PRE`, `L_PRE`) VALUES
	('D', '000000001', 'SIGIPAE', '9039', '0000-00-00', '0', 'INTERNET', NULL, NULL),
	('D', '072973662', 'SIGIPAE', '2741', '0000-00-00', '0', 'INTERNET', NULL, NULL),
	('D', '072974277', 'SIGIPAE', '7635', '0000-00-00', '0', 'INTERNET', NULL, NULL),
	('D', '072972033', 'SIGIPAE', '3667', '0000-00-00', '0', 'INTERNET', NULL, NULL);
/*!40000 ALTER TABLE `sigi_sol` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetasigi.sigi_vac
CREATE TABLE IF NOT EXISTS `sigi_vac` (
  `COD_OPC` varchar(7) NOT NULL,
  `NUM_VAC` int(4) NOT NULL,
  `COD_CUE` varchar(4) NOT NULL,
  `COD_ESP` varchar(3) NOT NULL,
  `COD_MUN_VAC` varchar(9) NOT NULL,
  `COD_TIP_DUR` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetasigi.sigi_vac: ~500 rows (aproximadamente)
/*!40000 ALTER TABLE `sigi_vac` DISABLE KEYS */;
INSERT INTO `sigi_vac` (`COD_OPC`, `NUM_VAC`, `COD_CUE`, `COD_ESP`, `COD_MUN_VAC`, `COD_TIP_DUR`) VALUES
	('SIGIPAE', 266, '0597', 'EF', '44014', 'C'),
	('SIGIPAE', 1242, '0597', 'EF', '44014', 'C'),
	('SIGIPAE', 1390, '0597', 'PRI', '44191', 'C');
/*!40000 ALTER TABLE `sigi_vac` ENABLE KEYS */;






-- Volcando estructura para vista serviciosmicarpetasigi.vactosactivos
-- Eliminando tabla temporal y crear estructura final de VIEW
-- DROP TABLE IF EXISTS `vactosactivos`;
CREATE  VIEW `vactosactivos` AS SELECT cod_opc, tex_opc, o.cod_tip_ae, o.f_con_ae, o.f_ini_opc, o.f_fin_opc , 'https://servicios3.aragon.es/sigi/' AS `url`  from sigi_opc o where cod_opc in ('SIGISAE','SIGIPAE') ;


-- Volcando estructura para vista serviciosmicarpetasigi.vactosconvocado
-- Eliminando tabla temporal y crear estructura final de VIEW
-- DROP TABLE IF EXISTS `vactosconvocado`;
CREATE  VIEW `vactosconvocado` AS SELECT c.dni, o.cod_opc, tex_opc, o.cod_tip_ae, o.f_con_ae, o.f_ini_opc, o.f_fin_opc, 'https://servicios3.aragon.es/sigi/' AS `url`
FROM sigi_opc o, sigi_can_pre_ae c
WHERE
o.cod_opc = c.cod_opc ;


-- Volcando estructura para vista serviciosmicarpetasigi.vactossolicitud
-- Eliminando tabla temporal y crear estructura final de VIEW
-- DROP TABLE IF EXISTS `vactossolicitud`;
CREATE  VIEW `vactossolicitud` AS select o.cod_opc,o.f_con_ae, o.cod_tip_ae, o.tex_opc, 
s.dni, s.cod_sol, s.f_hor_ent, s.cod_est_sol, e.des_est_sol
, 'https://servicios3.aragon.es/sigi/' AS `url`, o.f_ini_opc, o.f_fin_opc
FROM sigi_opc o, sigi_sol s,
sigi_est_sol e
WHERE s.cod_opc = o.cod_opc AND s.cod_est_sol = e.cod_est_sol ;


-- Volcando estructura para vista serviciosmicarpetasigi.vconsultasituacionlistas
-- Eliminando tabla temporal y crear estructura final de VIEW
-- DROP TABLE IF EXISTS `vconsultasituacionlistas`;
CREATE  VIEW `vconsultasituacionlistas` AS SELECT l.dni,o.cod_opc, o.tex_opc, 'https://servicios3.aragon.es/sigi' AS url
FROM sigi_opc o, sigi_lis l
WHERE o.cod_opc IN ('SIGISSP','SIGIPSP') AND o.COD_OPC = l.COD_OPC ;


-- Volcando estructura para vista serviciosmicarpetasigi.vsolicitudesacto
-- Eliminando tabla temporal y crear estructura final de VIEW
-- DROP TABLE IF EXISTS `vsolicitudesacto`;
CREATE  VIEW `vsolicitudesacto` AS select o.cod_opc, o.tex_opc, s.cod_sol,s.dni, s.cod_est_sol,  f_hor_ent, des_est_sol 
from sigi_opc o, sigi_sol s, sigi_est_sol e
 where o.cod_opc = s.cod_opc 
 and e.cod_est_sol = s.cod_est_sol ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
