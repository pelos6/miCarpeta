<?php

require_once ('include/config.php');
require_once('ServerSigicon.php');

$server = new SoapServer(null, array('uri' => $servidor."/serviciosMiCarpetaSigicon"));

$server->setClass('ServerSigicon');
$server->handle();
?>
