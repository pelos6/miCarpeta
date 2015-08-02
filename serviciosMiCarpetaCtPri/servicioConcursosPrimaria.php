<?php
require_once ('include/config.php');
require_once('ServerConcursosPrimaria.php');

$server = new SoapServer(null, array('uri' => $servidor."/serviciosMiCarpetaCtPri"));

$server->setClass('ServerConcursosPrimaria');
$server->handle();
?>
