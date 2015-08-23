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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yii.users: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `dni`, `username`, `email`, `password`, `authKey`, `accessToken`, `activate`, `verification_code`, `role`, `interinos`, `actos`, `concursos`, `oposiciones`, `contraseña`) VALUES
	(1, '01234569K', 'javier', 'javieriranzo0@hotmail.com', 'fsXqW.J5vbjhw', 'a82b02f5c9d7087631003b4a9a52471db2aae7bc5593e7e22ef9046c098909f5930ea259b724ac4501c8c2745e85b0b2694853dcffac467dcb7d566289784e661668da251dfac78c5a09c0369a31b2ef986f3764113e2e70d07a20d081e00b4f014b8b89', '07d8e66f3a899f80194142145edac9e9b601c0a90c820512fe29530e4791652ac298f9322ce8d902225eb2469ea760c93d8d9f39aabd0b50c3f28ffb531ac9c605cf938d96dfaa0cc3f4baff66eb8f213c70e540d05f981620543460e72bb4eab08fa650', 1, '43f3315f', 2, '0', '0', '0', '1', 'javier'),
	(4, '00000001R', 'usuario1', 'javieriranzo2@hotmail.com', 'fssruqF8WfbJ2', '9c5a8749b9d237c5ab890aef1e3dcc53cea828ec8677ec480486d2320291a7855d5428eea28b0f19cbf109e26444f1054b6e853e3bec7049efbb9df1256599e497d641fc22bc5fe662d2805e33e3af3051ac6a1867ea8cd14357d029bfb003da68d1e292', '1b65272b923a8f5299fad5d3de63c77a2c5f10e23e7b9be9c283f539a253fbaf8b9767f8391a06de688a730ed4a19c43584c2c6b9217de106cde6f20735d9c4583403f3c587205c1be91a9a06167f9a50db1b07c8d3b89d07fa1519fbddfb563f4718f09', 1, 'ed181894', 1, '1', '1', '1', '1', 'usuario1'),
	(7, '00000002W', 'usuario2', 'javieriranzo2@hotmail.com', 'fssruqF8WfbJ2', 'c32e2b6b512835101f46de45d942d0c73be9e84321f7c39336384b6348481d71010304984e34be73bb7916d024bcb789358a7e4bdacf17b29e274eba5f7ecfffc760564cb3b8cf5fdf34c5f2f79e26d2c7a39cbb0b1fd4597faeba88ee2cea0415453089', 'a1c457c27c770d8d43081c94c24432a4b4e72989d7adbeeff5529d82dca2813d165858ae9032bd9f16fa7bdd446d4f24e537f620b7242abd8500b7971a876b6a0364e1014c74f43a616462af4e0ee51d9fff3a502f232d14ac266a15d0d3cd2e88f8e2fd', 1, '', 1, '1', '0', '0', '1', 'usuario1'),
	(8, '00000003A', 'usuario3', 'javieriranzo3@hotmail.com', 'fssruqF8WfbJ2', 'c32e2b6b512835101f46de45d942d0c73be9e84321f7c39336384b6348481d71010304984e34be73bb7916d024bcb789358a7e4bdacf17b29e274eba5f7ecfffc760564cb3b8cf5fdf34c5f2f79e26d2c7a39cbb0b1fd4597faeba88ee2cea0415453089', 'a1c457c27c770d8d43081c94c24432a4b4e72989d7adbeeff5529d82dca2813d165858ae9032bd9f16fa7bdd446d4f24e537f620b7242abd8500b7971a876b6a0364e1014c74f43a616462af4e0ee51d9fff3a502f232d14ac266a15d0d3cd2e88f8e2fd', 1, '', 1, '1', '0', '0', '1', 'usuario1'),
	(9, '00000004G', 'usuario4', 'javieriranzo4@hotmail.com', 'fssruqF8WfbJ2', '9c5a8749b9d237c5ab890aef1e3dcc53cea828ec8677ec480486d2320291a7855d5428eea28b0f19cbf109e26444f1054b6e853e3bec7049efbb9df1256599e497d641fc22bc5fe662d2805e33e3af3051ac6a1867ea8cd14357d029bfb003da68d1e292', '1b65272b923a8f5299fad5d3de63c77a2c5f10e23e7b9be9c283f539a253fbaf8b9767f8391a06de688a730ed4a19c43584c2c6b9217de106cde6f20735d9c4583403f3c587205c1be91a9a06167f9a50db1b07c8d3b89d07fa1519fbddfb563f4718f09', 1, 'ed181894', 1, '1', '0', '0', '1', 'usuario1'),
	(10, '00000005M', 'usuario5', 'javieriranzo5@hotmail.com', 'fssruqF8WfbJ2', '9c5a8749b9d237c5ab890aef1e3dcc53cea828ec8677ec480486d2320291a7855d5428eea28b0f19cbf109e26444f1054b6e853e3bec7049efbb9df1256599e497d641fc22bc5fe662d2805e33e3af3051ac6a1867ea8cd14357d029bfb003da68d1e292', '1b65272b923a8f5299fad5d3de63c77a2c5f10e23e7b9be9c283f539a253fbaf8b9767f8391a06de688a730ed4a19c43584c2c6b9217de106cde6f20735d9c4583403f3c587205c1be91a9a06167f9a50db1b07c8d3b89d07fa1519fbddfb563f4718f09', 1, 'ed181894', 1, '1', '1', '0', '1', 'usuario1'),
	(12, '17703071V', 'javieriranzo', 'javieriranzo@hotmail.com', 'fssruqF8WfbJ2', '502f232d14ac266a15d0d3cd2e88f8e2fd603fb44c3456c1e8c017f38dc04f07f70faa99e23bd4951a1eb8975b75047a500d62ece680c0b7aacab8998679174c1768999d39420a38a7d415f80feb988b3c212dacf953a226f34dd1b6f6aa6718ce481018', '17d1b862ad13fac24cd89404afcd60d383ae1c0db547724cef543f5deea01f0c6ee9ee052ad95724f04d28148be12b93a6710e7bfec99b6a6f858f2a858096883c789c3030173c0e2c3a349dee8d6edb30dc7852c0c33cff584e477fb5e9957c938fb2e2', 1, 'a417c7e2', 1, '1', '0', '0', '1', 'usuario1'),
	(13, '00000006Y', 'usuario6', 'javieriranzo6@hotmail.com', 'fssruqF8WfbJ2', '9c5a8749b9d237c5ab890aef1e3dcc53cea828ec8677ec480486d2320291a7855d5428eea28b0f19cbf109e26444f1054b6e853e3bec7049efbb9df1256599e497d641fc22bc5fe662d2805e33e3af3051ac6a1867ea8cd14357d029bfb003da68d1e292', '1b65272b923a8f5299fad5d3de63c77a2c5f10e23e7b9be9c283f539a253fbaf8b9767f8391a06de688a730ed4a19c43584c2c6b9217de106cde6f20735d9c4583403f3c587205c1be91a9a06167f9a50db1b07c8d3b89d07fa1519fbddfb563f4718f09', 1, 'ed181894', 1, '1', '1', '0', '1', 'usuario1'),
	(14, '00000007F', 'usuario7', 'javieriranzo7@hotmail.com', 'fssruqF8WfbJ2', '9c5a8749b9d237c5ab890aef1e3dcc53cea828ec8677ec480486d2320291a7855d5428eea28b0f19cbf109e26444f1054b6e853e3bec7049efbb9df1256599e497d641fc22bc5fe662d2805e33e3af3051ac6a1867ea8cd14357d029bfb003da68d1e292', '1b65272b923a8f5299fad5d3de63c77a2c5f10e23e7b9be9c283f539a253fbaf8b9767f8391a06de688a730ed4a19c43584c2c6b9217de106cde6f20735d9c4583403f3c587205c1be91a9a06167f9a50db1b07c8d3b89d07fa1519fbddfb563f4718f09', 1, 'ed181894', 1, '0', '1', '1', '1', 'usuario1'),
	(15, '00000008P', 'usuario8', 'javieriranzo8@hotmail.com', 'fssruqF8WfbJ2', '9c5a8749b9d237c5ab890aef1e3dcc53cea828ec8677ec480486d2320291a7855d5428eea28b0f19cbf109e26444f1054b6e853e3bec7049efbb9df1256599e497d641fc22bc5fe662d2805e33e3af3051ac6a1867ea8cd14357d029bfb003da68d1e292', '1b65272b923a8f5299fad5d3de63c77a2c5f10e23e7b9be9c283f539a253fbaf8b9767f8391a06de688a730ed4a19c43584c2c6b9217de106cde6f20735d9c4583403f3c587205c1be91a9a06167f9a50db1b07c8d3b89d07fa1519fbddfb563f4718f09', 1, 'ed181894', 1, '0', '1', '1', '1', 'usuario1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
