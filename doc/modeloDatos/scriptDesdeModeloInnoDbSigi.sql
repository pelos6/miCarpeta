-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema yii
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema yii
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `yii` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema c23sigi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema c23sigi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `c23sigi` DEFAULT CHARACTER SET latin1 ;
USE `yii` ;

-- -----------------------------------------------------
-- Table `yii`.`alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yii`.`alumnos` (
  `id_alumno` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` VARCHAR(50) NOT NULL COMMENT '',
  `apellidos` VARCHAR(80) NOT NULL COMMENT '',
  `clase` INT(11) NOT NULL COMMENT '',
  `nota_final` FLOAT NOT NULL COMMENT '',
  PRIMARY KEY (`id_alumno`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `yii`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yii`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `dni` VARCHAR(15) NOT NULL COMMENT '',
  `username` VARCHAR(50) NOT NULL COMMENT '',
  `email` VARCHAR(80) NOT NULL COMMENT '',
  `password` VARCHAR(250) NOT NULL COMMENT '',
  `authKey` VARCHAR(250) NOT NULL COMMENT '',
  `accessToken` VARCHAR(250) NOT NULL COMMENT '',
  `activate` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '',
  `verification_code` VARCHAR(250) NOT NULL COMMENT '',
  `role` INT(11) NOT NULL DEFAULT '1' COMMENT '',
  `interinos` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `actos` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `concursos` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `oposiciones` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `contraseña` VARCHAR(16) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;

USE `c23sigi` ;

-- -----------------------------------------------------
-- Table `c23sigi`.`sigi_opc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`sigi_opc` (
  `COD_OPC` VARCHAR(7) NOT NULL COMMENT '',
  `F_CON_AE` DATE NULL DEFAULT NULL COMMENT '',
  `COD_TIP_AE` VARCHAR(1) NULL DEFAULT NULL COMMENT '',
  `TEX_OPC` VARCHAR(200) NOT NULL COMMENT '',
  `TEX_OPC_CAB` VARCHAR(200) NOT NULL COMMENT '',
  `TEX_OPC_PDF` VARCHAR(200) NULL DEFAULT NULL COMMENT '',
  `FEC_CUR_COM` VARCHAR(10) NULL DEFAULT NULL COMMENT '',
  `L_VIS` VARCHAR(1) NOT NULL COMMENT '',
  `L_ACT` VARCHAR(1) NOT NULL COMMENT '',
  `L_PET_MAS` VARCHAR(1) NULL DEFAULT NULL COMMENT '',
  `L_RES_VIS` VARCHAR(1) NULL DEFAULT NULL COMMENT '',
  `L_RES_ACT` VARCHAR(1) NULL DEFAULT NULL COMMENT '',
  `F_INI_OPC` DATE NOT NULL COMMENT '',
  `F_FIN_OPC` DATE NOT NULL COMMENT '',
  `C_USU_ULT_MOD` VARCHAR(8) NOT NULL COMMENT '',
  `F_ULT_MOD` DATE NOT NULL COMMENT '',
  PRIMARY KEY (`COD_OPC`)  COMMENT '')
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `c23sigi`.`sigi_can_pre_ae`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`sigi_can_pre_ae` (
  `tipo_id` VARCHAR(1) NOT NULL COMMENT '',
  `dni` VARCHAR(15) NOT NULL COMMENT '',
  `cod_opc` VARCHAR(7) NOT NULL COMMENT '',
  `cod_col` VARCHAR(1) NOT NULL COMMENT '',
  `l_med` VARCHAR(1) NULL DEFAULT NULL COMMENT '',
  `cod_mun` VARCHAR(9) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`tipo_id`, `dni`, `cod_opc`)  COMMENT '',
  INDEX `sigi_can_pre_ae_sigi_opc_idx` (`cod_opc` ASC)  COMMENT '',
  CONSTRAINT `sigi_can_pre_ae_sigi_opc`
    FOREIGN KEY (`cod_opc`)
    REFERENCES `c23sigi`.`sigi_opc` (`COD_OPC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `c23sigi`.`sigi_esp_can_pre_ae`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`sigi_esp_can_pre_ae` (
  `TIPO_ID` VARCHAR(1) NOT NULL COMMENT '',
  `DNI` VARCHAR(15) NOT NULL COMMENT '',
  `COD_OPC` VARCHAR(7) NOT NULL COMMENT '',
  `COD_CUE` VARCHAR(4) NOT NULL COMMENT '',
  `COD_ESP` VARCHAR(3) NOT NULL COMMENT '',
  `COD_PRO_1_SUS` VARCHAR(2) NULL DEFAULT NULL COMMENT '',
  `COD_PRO_2_SUS` VARCHAR(2) NULL DEFAULT NULL COMMENT '',
  `L_LIS_SUS` VARCHAR(1) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`TIPO_ID`, `DNI`, `COD_OPC`, `COD_CUE`, `COD_ESP`)  COMMENT '',
  CONSTRAINT `sigi_esp_can_pre_ae_sigi_can_pre_ae`
    FOREIGN KEY (`TIPO_ID` , `DNI` , `COD_OPC`)
    REFERENCES `c23sigi`.`sigi_can_pre_ae` (`tipo_id` , `tipo_id` , `tipo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `c23sigi`.`sigi_est_sol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`sigi_est_sol` (
  `COD_EST_SOL` VARCHAR(1) NOT NULL COMMENT '',
  `DES_EST_SOL` VARCHAR(200) NOT NULL COMMENT '',
  `L_ACT` VARCHAR(1) NOT NULL COMMENT '',
  PRIMARY KEY (`COD_EST_SOL`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `c23sigi`.`sigi_lis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`sigi_lis` (
  `COD_OPC` VARCHAR(7) NOT NULL COMMENT '',
  `TIPO_ID` VARCHAR(1) NOT NULL COMMENT '',
  `DNI` VARCHAR(15) NOT NULL COMMENT '',
  `COD_CUE` VARCHAR(4) NOT NULL COMMENT '',
  `COD_ESP` VARCHAR(3) NOT NULL COMMENT '',
  `TIP_LIS` VARCHAR(1) NOT NULL COMMENT '',
  `FEC_ORI_BLO` VARCHAR(8) NOT NULL COMMENT '',
  `COD_BLO` VARCHAR(155) NOT NULL COMMENT '',
  `NUM_ORD` VARCHAR(4) NOT NULL COMMENT '',
  `RES_TOT` VARCHAR(6) NOT NULL COMMENT '',
  `COD_EST` VARCHAR(10) NOT NULL COMMENT '',
  `DES_CAU_EST` VARCHAR(150) NULL DEFAULT NULL COMMENT '',
  `FEC_INI_EST` DATE NULL DEFAULT NULL COMMENT '',
  `DES_PRO_1_SUS` VARCHAR(8) NULL DEFAULT NULL COMMENT '',
  `FEC_PRO_1_SUS` DATE NULL DEFAULT NULL COMMENT '',
  `DES_PRO_2_SUS` VARCHAR(8) NULL DEFAULT NULL COMMENT '',
  `FEC_PRO_2_SUS` DATE NULL DEFAULT NULL COMMENT '',
  `ORD_DIS_ZA` VARCHAR(4) NULL DEFAULT NULL COMMENT '',
  `ORD_DIS_HU` VARCHAR(4) NULL DEFAULT NULL COMMENT '',
  `ORD_DIS_TE` VARCHAR(4) NULL DEFAULT NULL COMMENT '',
  `ORD_CCAO` VARCHAR(4) NULL DEFAULT NULL COMMENT '',
  `DES_PRO_REF` VARCHAR(8) NULL DEFAULT NULL COMMENT '',
  `L_RES` VARCHAR(2) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`COD_OPC`, `TIPO_ID`, `DNI`, `COD_CUE`, `COD_ESP`)  COMMENT '',
  CONSTRAINT `sigi_lis_sigi_opc`
    FOREIGN KEY (`COD_OPC`)
    REFERENCES `c23sigi`.`sigi_opc` (`COD_OPC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `c23sigi`.`sigi_sol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`sigi_sol` (
  `TIPO_ID` VARCHAR(1) NOT NULL COMMENT '',
  `DNI` VARCHAR(15) NOT NULL COMMENT '',
  `COD_OPC` VARCHAR(7) NOT NULL COMMENT '',
  `COD_SOL` VARCHAR(4) NOT NULL COMMENT '',
  `F_HOR_ENT` DATE NOT NULL COMMENT '',
  `COD_EST_SOL` VARCHAR(1) NOT NULL COMMENT '',
  `COD_USU` VARCHAR(8) NOT NULL COMMENT '',
  `F_HOR_PRE` DATE NULL DEFAULT NULL COMMENT '',
  `L_PRE` VARCHAR(1) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`COD_SOL`, `TIPO_ID`, `DNI`, `COD_OPC`)  COMMENT '',
  INDEX `sigi_sol_sigi_can_pre_ae_idx` (`TIPO_ID` ASC, `DNI` ASC, `COD_OPC` ASC)  COMMENT '',
  INDEX `sigi_sol_sigi_est_sol_idx` (`COD_EST_SOL` ASC)  COMMENT '',
  CONSTRAINT `sigi_sol_sigi_can_pre_ae`
    FOREIGN KEY (`TIPO_ID` , `DNI` , `COD_OPC`)
    REFERENCES `c23sigi`.`sigi_can_pre_ae` (`tipo_id` , `tipo_id` , `tipo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sigi_sol_sigi_est_sol`
    FOREIGN KEY (`COD_EST_SOL`)
    REFERENCES `c23sigi`.`sigi_est_sol` (`COD_EST_SOL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `c23sigi`.`sigi_vac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`sigi_vac` (
  `COD_OPC` VARCHAR(7) NOT NULL COMMENT '',
  `NUM_VAC` INT(4) NOT NULL COMMENT '',
  `COD_CUE` VARCHAR(4) NOT NULL COMMENT '',
  `COD_ESP` VARCHAR(3) NOT NULL COMMENT '',
  `COD_MUN_VAC` VARCHAR(9) NOT NULL COMMENT '',
  `COD_TIP_DUR` VARCHAR(1) NOT NULL COMMENT '',
  PRIMARY KEY (`COD_OPC`)  COMMENT '',
  CONSTRAINT `sigi_vac_sigi_opc`
    FOREIGN KEY (`COD_OPC`)
    REFERENCES `c23sigi`.`sigi_opc` (`COD_OPC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `c23sigi` ;

-- -----------------------------------------------------
-- Placeholder table for view `c23sigi`.`vactosactivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`vactosactivos` (`cod_opc` INT, `tex_opc` INT, `cod_tip_ae` INT, `f_con_ae` INT, `f_ini_opc` INT, `f_fin_opc` INT, `url` INT);

-- -----------------------------------------------------
-- Placeholder table for view `c23sigi`.`vactosconvocado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`vactosconvocado` (`dni` INT, `cod_opc` INT, `tex_opc` INT, `cod_tip_ae` INT, `f_con_ae` INT, `f_ini_opc` INT, `f_fin_opc` INT, `url` INT);

-- -----------------------------------------------------
-- Placeholder table for view `c23sigi`.`vactossolicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`vactossolicitud` (`cod_opc` INT, `f_con_ae` INT, `cod_tip_ae` INT, `tex_opc` INT, `dni` INT, `cod_sol` INT, `f_hor_ent` INT, `cod_est_sol` INT, `des_est_sol` INT, `url` INT, `f_ini_opc` INT, `f_fin_opc` INT);

-- -----------------------------------------------------
-- Placeholder table for view `c23sigi`.`vconsultasituacionlistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`vconsultasituacionlistas` (`dni` INT, `cod_opc` INT, `tex_opc` INT, `url` INT);

-- -----------------------------------------------------
-- Placeholder table for view `c23sigi`.`vsolicitudesacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `c23sigi`.`vsolicitudesacto` (`cod_opc` INT, `tex_opc` INT, `cod_sol` INT, `dni` INT, `cod_est_sol` INT, `f_hor_ent` INT, `des_est_sol` INT);

-- -----------------------------------------------------
-- View `c23sigi`.`vactosactivos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `c23sigi`.`vactosactivos`;
USE `c23sigi`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`c23sigi`@`%` SQL SECURITY DEFINER VIEW `c23sigi`.`vactosactivos` AS select `o`.`COD_OPC` AS `cod_opc`,`o`.`TEX_OPC` AS `tex_opc`,`o`.`COD_TIP_AE` AS `cod_tip_ae`,`o`.`F_CON_AE` AS `f_con_ae`,`o`.`F_INI_OPC` AS `f_ini_opc`,`o`.`F_FIN_OPC` AS `f_fin_opc`,'https://servicios3.aragon.es/sigi/' AS `url` from `c23sigi`.`sigi_opc` `o` where (`o`.`COD_OPC` in ('SIGISAE','SIGIPAE'));

-- -----------------------------------------------------
-- View `c23sigi`.`vactosconvocado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `c23sigi`.`vactosconvocado`;
USE `c23sigi`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`c23sigi`@`%` SQL SECURITY DEFINER VIEW `c23sigi`.`vactosconvocado` AS select `c`.`dni` AS `dni`,`o`.`COD_OPC` AS `cod_opc`,`o`.`TEX_OPC` AS `tex_opc`,`o`.`COD_TIP_AE` AS `cod_tip_ae`,`o`.`F_CON_AE` AS `f_con_ae`,`o`.`F_INI_OPC` AS `f_ini_opc`,`o`.`F_FIN_OPC` AS `f_fin_opc`,'https://servicios3.aragon.es/sigi/' AS `url` from (`c23sigi`.`sigi_opc` `o` join `c23sigi`.`sigi_can_pre_ae` `c`) where (`o`.`COD_OPC` = `c`.`cod_opc`);

-- -----------------------------------------------------
-- View `c23sigi`.`vactossolicitud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `c23sigi`.`vactossolicitud`;
USE `c23sigi`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`c23sigi`@`%` SQL SECURITY DEFINER VIEW `c23sigi`.`vactossolicitud` AS select `o`.`COD_OPC` AS `cod_opc`,`o`.`F_CON_AE` AS `f_con_ae`,`o`.`COD_TIP_AE` AS `cod_tip_ae`,`o`.`TEX_OPC` AS `tex_opc`,`s`.`DNI` AS `dni`,`s`.`COD_SOL` AS `cod_sol`,`s`.`F_HOR_ENT` AS `f_hor_ent`,`s`.`COD_EST_SOL` AS `cod_est_sol`,`e`.`DES_EST_SOL` AS `des_est_sol`,'https://servicios3.aragon.es/sigi/' AS `url`,`o`.`F_INI_OPC` AS `f_ini_opc`,`o`.`F_FIN_OPC` AS `f_fin_opc` from ((`c23sigi`.`sigi_opc` `o` join `c23sigi`.`sigi_sol` `s`) join `c23sigi`.`sigi_est_sol` `e`) where ((`s`.`COD_OPC` = `o`.`COD_OPC`) and (`s`.`COD_EST_SOL` = `e`.`COD_EST_SOL`));

-- -----------------------------------------------------
-- View `c23sigi`.`vconsultasituacionlistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `c23sigi`.`vconsultasituacionlistas`;
USE `c23sigi`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`c23sigi`@`%` SQL SECURITY DEFINER VIEW `c23sigi`.`vconsultasituacionlistas` AS select `l`.`DNI` AS `dni`,`o`.`COD_OPC` AS `cod_opc`,`o`.`TEX_OPC` AS `tex_opc`,'https://servicios3.aragon.es/sigi' AS `url` from (`c23sigi`.`sigi_opc` `o` join `c23sigi`.`sigi_lis` `l`) where ((`o`.`COD_OPC` in ('SIGISSP','SIGIPSP')) and (`o`.`COD_OPC` = `l`.`COD_OPC`));

-- -----------------------------------------------------
-- View `c23sigi`.`vsolicitudesacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `c23sigi`.`vsolicitudesacto`;
USE `c23sigi`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`c23sigi`@`%` SQL SECURITY DEFINER VIEW `c23sigi`.`vsolicitudesacto` AS select `o`.`COD_OPC` AS `cod_opc`,`o`.`TEX_OPC` AS `tex_opc`,`s`.`COD_SOL` AS `cod_sol`,`s`.`DNI` AS `dni`,`s`.`COD_EST_SOL` AS `cod_est_sol`,`s`.`F_HOR_ENT` AS `f_hor_ent`,`e`.`DES_EST_SOL` AS `des_est_sol` from ((`c23sigi`.`sigi_opc` `o` join `c23sigi`.`sigi_sol` `s`) join `c23sigi`.`sigi_est_sol` `e`) where ((`o`.`COD_OPC` = `s`.`COD_OPC`) and (`e`.`COD_EST_SOL` = `s`.`COD_EST_SOL`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
