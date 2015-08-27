<?php
//serverW.php es el fichero descrito anteriormente, donde se implementan los métodos que se se ofrecen
        require_once 'ServerConcursosPrimaria.php';
        require_once'WSDLDocument.php'; //script que generará el fichero xml 
 
//        $url="Especifica la ubiación del fichero servidor con los comentarios @param..."
//        $uri="especifica la ubiación de los ficheros dominio de nombres"
        $url="http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/miCarpeta/serviciosMiCarpetaCtPri/ServerConcursosPrimaria.php";
        $uri="http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/miCarpeta/serviciosMiCarpetaCtPri/";
        
 
 echo 'hola';
         //serviciow.php es el fichero que genera el objeto servidor soap 
        $accion = new WSDLDocument("ServerConcursosPrimaria",$url,$uri);
 
      echo  $accion->saveXML(); //Genera el en  navegador el fichero xml que hay que revisar
/* LOS PARAMETROS DE WSDLDOCUMENT(   )
    1º: El nombre de la clase que gestionará las peticiones al servicio.
    2º: La URL en que se ofrece el servicio.
    3º: El espacio de nombres destino.
 * */
 
?>

