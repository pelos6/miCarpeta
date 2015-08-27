<?php

require_once('include/DBConcursosSecundaria.php');

class ServerConcursosSecundaria {
     /**
     * Devuelve la información de si hay o no solicitud baremada para  
     * esa solicitud en el concurso y para la persona seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getSolicitudesConcursoBaremada($cod_con,$dni,$cod_sol) {
        //error_log('DEBUG: en getSolicitudesConcursoBaremada ' . $dni);
        $concursSolicitudBaremada = DBConcursosSecundaria::obtieneSolicitudConcursoBaremada($cod_con,$dni,$cod_sol);
        return $concursSolicitudBaremada;
    }
    /**
     * Devuelve la información de si hay o no solicitud baremada para  
     * esa solicitud en el concurso y para la persona seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getHaySolicitudConcursoBaremada($cod_con,$dni,$cod_sol) {
        //error_log('DEBUG: en getHaySolicitudConcursoBaremada ' . $dni);
        $concursoHaySolicitudBaremada = DBConcursosSecundaria::obtieneHaySolicitudConcursoBaremada($cod_con,$dni,$cod_sol);
        return $concursoHaySolicitudBaremada;
    }
    /**
     * Devuelve un array con los Concursos de Secundaria en las que 
     * tiene solicitud
     * 
     * 
     * @param string $dni
     * @return string[]
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
     * @param string $cod_opc
     * @param string $dni
     * @return string[]
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
     * @param string $cod_opc
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getSolicitudConcurso($cod_opc,$dni,$cod_sol) {
        //error_log('DEBUG: en getSolicitudConcurso ' . $cod_opc.' '. $dni. ' '. $cod_sol);
        $solicitudConcurso = DBConcursosSecundaria::obtieneSolicitudConcurso($cod_opc,$dni,$cod_sol);
        return $solicitudConcurso;
    }


    /**
     * Devuelve un array con los concursos activos 
     *  
     * @return string[]
     */
    public function getConcursosActivos() {
        //error_log('DEBUG: en getConcursosActivos Secundaria');
        $concursosActivos = DBConcursosSecundaria::obtieneConcursosActivos();
        return $concursosActivos;
    }

     /**
     * Devuelve la información del concurso seleccionado 
     * 
     * @param string $cod_con
     * @return string[]
     */
    public function getConcursoActivo($cod_con) {
        //error_log('DEBUG: en getConcursoActivo Secundaria');
        $concursoActivo = DBConcursosSecundaria::obtieneConcursoActivo($cod_con);
        return $concursoActivo;
    }

   

}

?>