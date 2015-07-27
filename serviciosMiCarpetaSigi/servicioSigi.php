<?php
require_once 'include/config.php';
require_once('ServerSigi.php');

$server = new SoapServer(null, array('uri' => $servidor."/serviciosMiCarpetaSigi"));

$server->setClass('ServerSigi');
$server->handle();
?>
