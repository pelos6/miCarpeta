<?php

require_once('ServerConcursosSecundaria.php');
/*desarrollo en local*/
$uriSec = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpetaCtSec";
/*ecinform*/
//$uriSec = "http://javieriranzo.infenlaces.com/serviciosMiCarpetaCtSec";
/*ecinform*/
//$uriSec = "http://apostayadrede.com/serviciosMiCarpetaCtSec";
error_log('DEBUG: uriSec en serviciosConcursosSecundaria '.$uriSec);
$server = new SoapServer(null, array('uri' => $uriSec));

$server->setClass('ServerConcursosSecundaria');
$server->handle();
?>
