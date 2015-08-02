<?php
require_once ('include/config.php');
require_once('ServerConcursosSecundaria.php');

$server = new SoapServer(null, array('uri' => $servidor."/serviciosMiCarpetaCtSec"));

$server->setClass('ServerConcursosSecundaria');
$server->handle();
?>
