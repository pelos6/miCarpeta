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

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_bar: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_bar` DISABLE KEYS */;
INSERT INTO `ctsec_bar` (`COD_CON`, `COD_SOL`, `DNI`, `RES_TOT`, `APA_1`, `APA_1_1`, `APA_1_1_1`, `APA_1_1_2`, `APA_1_1_3`, `APA_1_2`, `APA_1_2_1`, `APA_1_2_2`, `APA_1_2_3`, `APA_2`, `APA_3`, `APA_3_1`, `APA_3_1_1`, `APA_3_1_2`, `APA_3_1_3`, `APA_3_1_4`, `APA_3_2`, `APA_3_2_1`, `APA_3_2_2`, `APA_3_2_3`, `APA_3_2_4`, `APA_3_3`, `APA_4`, `APA_4_1`, `APA_4_2`, `APA_4_3`, `APA_5`, `APA_5_1`, `APA_5_2`, `APA_5_3`, `APA_6`, `APA_6_1`, `APA_6_2`, `APA_6_3`, `APA_6_4`, `APA_6_5`, `APA_6_6`) VALUES
	('51', '0012', '00000001R', '37.3332', '27.3332', '17.0000', '15.0000', '2.0000', '0.0000', '10.3332', '10.3332', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '4.0000', '0.0000', '0.0000', '4.0000', '6.0000', '6.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000'),
	('51', '0012', '00000008P', '37.3332', '27.3332', '17.0000', '15.0000', '2.0000', '0.0000', '10.3332', '10.3332', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '4.0000', '0.0000', '0.0000', '4.0000', '6.0000', '6.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000');
/*!40000 ALTER TABLE `ctsec_bar` ENABLE KEYS */;


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
	('51', 'CONCURSO DE TRASLADOS DE SECUNDARIA', 'N', 'S', '1', '2015-08-04', '2015-08-24');
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


-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.ctsec_mod_par
CREATE TABLE IF NOT EXISTS `ctsec_mod_par` (
  `COD_MOD_PAR` varchar(1) NOT NULL,
  `DES_MOD_PAR` varchar(200) NOT NULL,
  `L_ACT` varchar(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`COD_MOD_PAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_mod_par: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_mod_par` DISABLE KEYS */;
INSERT INTO `ctsec_mod_par` (`COD_MOD_PAR`, `DES_MOD_PAR`, `L_ACT`) VALUES
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
/*!40000 ALTER TABLE `ctsec_mod_par` ENABLE KEYS */;


-- Volcando estructura para tabla serviciosmicarpetaconcursossecundaria.ctsec_sol
CREATE TABLE IF NOT EXISTS `ctsec_sol` (
  `DNI` varchar(15) NOT NULL,
  `COD_CON` varchar(7) NOT NULL,
  `COD_SOL` varchar(4) NOT NULL,
  `F_HOR_ENT` datetime NOT NULL,
  `COD_EST_SOL` varchar(1) NOT NULL,
  `COD_MOD_PAR` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla serviciosmicarpetaconcursossecundaria.ctsec_sol: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `ctsec_sol` DISABLE KEYS */;
INSERT INTO `ctsec_sol` (`DNI`, `COD_CON`, `COD_SOL`, `F_HOR_ENT`, `COD_EST_SOL`, `COD_MOD_PAR`) VALUES
	('00000001R', '51', '0011', '2015-08-03 12:25:30', '0', 'A'),
	('00000001R', '51', '0012', '2015-08-05 01:51:03', '0', 'K'),
	('00000001R', '51', '0013', '2015-08-04 01:25:04', '0', 'A'),
	('00000002W', '51', '0003', '2015-08-02 07:04:25', '0', 'A'),
	('00000007F', '51', '0012', '2015-08-05 01:51:03', '0', 'K'),
	('00000008P', '51', '0012', '2015-08-05 01:51:03', '0', 'K');
/*!40000 ALTER TABLE `ctsec_sol` ENABLE KEYS */;



-- Volcando estructura para vista serviciosmicarpetaconcursossecundaria.vconcursosactivos
-- Eliminando tabla temporal y crear estructura final de VIEW
CREATE  VIEW `vconcursosactivos` AS select c.cod_con, c.des_con, if((`cod_tip_con` = 'N'),'Nacional','Autonómico') AS `des_tip_con`, cod_tip_con
, c.l_act, f.des_fas_con ,'http://servicios.aragon.es/tsec/' AS `url`, 
 DATE_FORMAT(f_ini_sol,'%d/%c/%Y') f_ini_sol, 
 DATE_FORMAT(f_fin_sol,'%d/%c/%Y') f_fin_sol
from ctsec_con c , 
ctsec_fas_con f
where c.cod_fas_con = f.cod_fas_con ;


-- Volcando estructura para vista serviciosmicarpetaconcursossecundaria.vconcursossolicitud
-- Eliminando tabla temporal y crear estructura final de VIEW
CREATE  VIEW `vconcursossolicitud` AS select o.cod_con, o.cod_tip_con, o.des_con, o.l_act,
s.dni, s.cod_sol, s.f_hor_ent, s.cod_est_sol, e.des_est_sol des_est_sol
, 'http://servicios.aragon.es/tsec/' AS `url`, o.f_ini_sol, o.f_fin_sol,
if((`cod_tip_con` = 'N'),'Nacional','Autonómico') AS `des_tip_con`,
upper(des_fas_con) des_fas_con, upper(des_mod_par) des_mod_par
FROM ctsec_con o, ctsec_sol s, ctsec_fas_con f,
ctsec_est_sol e, ctsec_mod_par p
WHERE s.cod_con = o.cod_con AND s.cod_est_sol = e.cod_est_sol 
and f.cod_fas_con = o.cod_fas_con and 
p.COD_MOD_PAR = s.COD_MOD_PAR ;


-- Volcando estructura para vista serviciosmicarpetaconcursossecundaria.vsolicitudesbaremadas
-- Eliminando tabla temporal y crear estructura final de VIEW
CREATE  VIEW `vsolicitudesbaremadas` AS select cod_con, cod_sol, dni, res_tot, apa_1, apa_1_1, apa_1_1_1, apa_1_1_2, apa_1_1_3, apa_1_2, apa_1_2_1, apa_1_2_2, apa_1_2_3, apa_2, apa_3, apa_3_1, apa_3_1_1, apa_3_1_2, apa_3_1_3, apa_3_1_4, apa_3_2, apa_3_2_1, apa_3_2_2, apa_3_2_3, apa_3_2_4, apa_3_3, apa_4, apa_4_1, apa_4_2, apa_4_3, apa_5, apa_5_1, apa_5_2, apa_5_3, apa_6, apa_6_1, apa_6_2, apa_6_3, apa_6_4, apa_6_5, apa_6_6                                        
 from ctsec_bar ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
