<?php

require_once('include/DBConcursosSecundaria.php');

/**
 * Dada la situación de la
 */
class ServerConcursosSecundaria {
        /**
     * Devuelve un array con los Concursos de Secundaria en las que 
     * tiene solicitud
     * 
     */
    public function getConcursoHaySolicitud($dni) {
        //error_log('DEBUG: en getConcursoHaySolicitud ' . $dni);
        $concursoHaySolicitud = DBConcursosSecundaria::obtieneConcursoHaySolicitud($dni);
        return $concursoHaySolicitud;
    }

     /**
     * Devuelve un array con las solicitudes al concurso de traslasdos de Secundaria
     *  del usuario
     * 
     */
    public function getSolicitudesConcurso($cod_opc,$dni) {
        error_log('DEBUG: en getSolicitudesConcurso ' . $cod_opc.' '. $dni);
        $solicitudesConcurso = DBConcursosSecundaria::obtieneSolicitudesConcurso($cod_opc,$dni);
        return $solicitudesConcurso;
    }

    /**
     * Devuelve la información de la solicitud al concurso de traslasdos de Secundaria
     *  del usuario
     * 
     */
    public function getSolicitudConcurso($cod_opc,$dni,$cod_sol) {
        //error_log('DEBUG: en getSolicitudConcurso ' . $cod_opc.' '. $dni. ' '. $cod_sol);
        $solicitudConcurso = DBConcursosSecundaria::obtieneSolicitudConcurso($cod_opc,$dni,$cod_sol);
        return $solicitudConcurso;
    }


    /**
     * Devuelve un array con los concursos activos 
     * 
     */
    public function getConcursosActivos() {
        //error_log('DEBUG: en getConcursosActivos Secundaria');
        $concursosActivos = DBConcursosSecundaria::obtieneConcursosActivos();
        return $concursosActivos;
    }

     /**
     * Devuelve la información del concurso seleccionado 
     * 
     */
    public function getConcursoActivo($cod_con) {
        //error_log('DEBUG: en getConcursoActivo Secundaria');
        $concursoActivo = DBConcursosSecundaria::obtieneConcursoActivo($cod_con);
        return $concursoActivo;
    }

   

}

?>