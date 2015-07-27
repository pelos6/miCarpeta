<?php

require_once('ServerConcursosPrimaria.php');
/*desarrollo en local*/
$uriPri = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpetaCtPri";
/*ecinform*/
//$uriPri = "http://javieriranzo.infenlaces.com/serviciosMiCarpetaCtPri";
/*apostayadrede*/
//$uriPri = "http://apostayadrede.com/serviciosMiCarpetaCtPri";
error_log('DEBUG: uriPri en serviciosConcursosPrimaria '.$uriPri);
$server = new SoapServer(null, array('uri' => $uriPri));

$server->setClass('ServerConcursosPrimaria');
$server->handle();
?>
