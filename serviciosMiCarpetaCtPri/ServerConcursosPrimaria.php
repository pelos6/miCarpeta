<?php

require_once('include/DBConcursosPrimaria.php');

/**
 * Dada la situación de la
 */
class ServerConcursosPrimaria {
      /**
     * Devuelve un array con las solicitudes a actos de elección
     *  relevantes para el usuario
     * 
     */
    public function getSolicitudesConcursos($dni) {
        error_log('DEBUG: en getSolicitudesConcursos Primaria ' . $dni);
        $solicitudesConcursos = DBConcursosPrimaria::obtieneSolicitudesConcursos($dni);
        return $solicitudesConcursos;
    }

    /**
     * Devuelve un array con los concursos activos 
     * 
     */
    public function getConcursosActivos() {
        error_log('DEBUG: en getConcursosActivos Primaria');
        $concursosActivos = DBConcursosPrimaria::obtieneConcursosActivos();
        return $concursosActivos;
    }

   

}

?>