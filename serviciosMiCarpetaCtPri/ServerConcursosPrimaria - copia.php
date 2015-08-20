<?php

require_once('include/DBConcursosPrimaria.php');

/**
 * Dada la situación de la
 */
class ServerConcursosPrimaria {
        /**
     * Devuelve un array con los Concursos de primaria en las que 
     * tiene solicitud
     * 
     */
    public function getConcursoHaySolicitud($dni) {
        error_log('DEBUG: en getConcursoHaySolicitud ' . $dni);
        $concursoHaySolicitud = DBConcursosPrimaria::obtieneConcursoHaySolicitud($dni);
        return $concursoHaySolicitud;
    }

     /**
     * Devuelve un array con las solicitudes al concurso de traslasdos de primaria
     *  del usuario
     * 
     */
    public function getSolicitudesConcurso($cod_opc,$dni) {
        error_log('DEBUG: en getSolicitudesConcurso ' . $cod_opc.' '. $dni);
        $solicitudesConcurso = DBConcursosPrimaria::obtieneSolicitudesConcurso($cod_opc,$dni);
        return $solicitudesConcurso;
    }

    /**
     * Devuelve la información de la solicitud al concurso de traslasdos de primaria
     *  del usuario
     * 
     */
    public function getSolicitudConcurso($cod_opc,$dni,$cod_sol) {
        error_log('DEBUG: en getSolicitudConcurso ' . $cod_opc.' '. $dni. ' '. $cod_sol);
        $solicitudConcurso = DBConcursosPrimaria::obtieneSolicitudConcurso($cod_opc,$dni,$cod_sol);
        return $solicitudConcurso;
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

     /**
     * Devuelve la información del concurso seleccionado 
     * 
     */
    public function getConcursoActivo($cod_con) {
        error_log('DEBUG: en getConcursoActivo Primaria');
        $concursoActivo = DBConcursosPrimaria::obtieneConcursoActivo($cod_con);
        return $concursoActivo;
    }

   

}

?>