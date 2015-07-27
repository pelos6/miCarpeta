<?php

require_once('include/DBConcursosSecundaria.php');

/**
 * Dada la situación de la
 */
class ServerConcursosSecundaria {
      /**
     * Devuelve un array con las solicitudes a actos de elección
     *  relevantes para el usuario
     * 
     */
    public function getSolicitudesConcursos($dni) {
        error_log('DEBUG: en getSolicitudesConcursos secundaria ' . $dni);
        $solicitudesConcursos = DBConcursosSecundaria::obtieneSolicitudesConcursos($dni);
        return $solicitudesConcursos;
    }

    /**
     * Devuelve un array con los concursos activos 
     * 
     */
    public function getConcursosActivos() {
        error_log('DEBUG: en getConcursosActivos secundaria ');
        $concursosActivos = DBConcursosSecundaria::obtieneConcursosActivos();
        return $concursosActivos;
    }

   

}

?>