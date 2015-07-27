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

-- Volcando estructura de base de datos para yii
CREATE DATABASE IF NOT EXISTS `yii` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `yii`;


-- Volcando estructura para tabla yii.alumnos
CREATE TABLE IF NOT EXISTS `alumnos` (
  `id_alumno` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(80) NOT NULL,
  `clase` int(11) NOT NULL,
  `nota_final` float NOT NULL,
  PRIMARY KEY (`id_alumno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yii.alumnos: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` (`id_alumno`, `nombre`, `apellidos`, `clase`, `nota_final`) VALUES
	(1, 'modificado', 'dssss', 78, 8),
	(2, 'javier', 'iranzo', 3, 5);
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;


-- Volcando estructura para tabla yii.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dni` varchar(15) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(80) NOT NULL,
  `password` varchar(250) NOT NULL,
  `authKey` varchar(250) NOT NULL,
  `accessToken` varchar(250) NOT NULL,
  `activate` tinyint(1) NOT NULL DEFAULT '0',
  `verification_code` varchar(250) NOT NULL,
  `role` int(11) NOT NULL DEFAULT '1',
  `interinos` char(1) DEFAULT NULL,
  `actos` char(1) DEFAULT NULL,
  `concursos` char(1) DEFAULT NULL,
  `oposiciones` char(1) DEFAULT NULL,
  `contraseña` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yii.users: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `dni`, `username`, `email`, `password`, `authKey`, `accessToken`, `activate`, `verification_code`, `role`, `interinos`, `actos`, `concursos`, `oposiciones`, `contraseña`) VALUES
	(2, '01234569', 'javier', 'javieriranzo@hotmail.com', 'fsjsiDwcez2Hc', '176ec799c6a9aff5754dc309bef8e0816e74d238319e45ecf302f5575f9bbd2613f73b3509e13940de3484035f9dd93a36c8f2a030919bf328b4721dbced629ba7f8166ac4a05c14c093ce8578ab596b86959981b70d6a92d6ef885b91c79e99b3807a06', '07d8e66f3a899f80194142145edac9e9b601c0a90c820512fe29530e4791652ac298f9322ce8d902225eb2469ea760c93d8d9f39aabd0b50c3f28ffb531ac9c605cf938d96dfaa0cc3f4baff66eb8f213c70e540d05f981620543460e72bb4eab08fa650', 1, '88dbf4c5', 2, '1', '1', '1', '1', 'pelos678'),
	(9, '01234576', 'interinos', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(10, '072982803', 'usuario1', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(12, '01234579', 'usuario3', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(13, '01234580', 'usuario4', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(14, '01234581', 'usuario5', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(15, '01234582', 'usuario6', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(16, '01234583', 'usuario7', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(20, '01234587', 'usuario11', 'javieriranzo3@gmail.com', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(21, '01234588', 'cambio', 'javieriranzo3@gmail.es', 'fsF6epXbzbEro', 'a53b629ecc7668559412f641cadac7303a6bb7ed8e9063148435a672f8e63de39470d30126af44ba6a3e3d9a0bd9897ce56cd51ca584fb36160cba97f4b1bbeb0c3ebc0c095f9898b8c10c6bc36fb33f19e58ac343f01bd02f6c352479f3a16afc632d7f', '647774fe8dec43b3047d757bc4d7a7f16ae5a4f2b143383975cd1f726320066a4628c9dcdb801294cdf4af4ff8505cb80941c4accba2c3c6fa1015f2536677dda150a542a09b59ed0d02618ba35179e72f355cce5c7ac6dbf7ea83faca2350d883f1f920', 1, '', 1, '1', '1', '1', '1', 'interinos'),
	(23, '01234567', 'interinosdni', 'javieriranzo3dni@gmail.com', 'fsF6epXbzbEro', '4be4a4b1c2aa37ecdd3c45d858658921e0d2dfa4504ed40c64956326d97428bd5a96e06dc3d76602c1d466692f68ad2eba40d71c1d37deef14f940736c33f975e0d0a4903d7c1da13ee400738fe33aa2fc36570b429841493dc5a649878a42b6ff82ef4c', '3ea94cc8228c220566f64fafc7b46e7300813c2ced2984962b49237e75ccb370b74e02668e9ccc0ec572dc2419aaee5245e2af8715f5fa6c36907bbf837eff2bb97c318d7334fe909d85e120d328e6caf2db9a69b649d8bad95f4c681ab8b35f2211e82b', 0, '', 1, '1', '0', '0', '0', 'interinos');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
