<?php

require_once('include/DBConcursosPrimaria.php');

class ServerConcursosPrimaria {

    /**
     * Devuelve la información de si hay o no solicitud baremada para  
     * esa solicitud en el concurso y para la persona seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getSolicitudesConcursoBaremada($cod_con, $dni, $cod_sol) {
        //error_log('DEBUG: en getSolicitudesConcursoBaremada ' . $dni);
        $concursSolicitudBaremada = DBConcursosPrimaria::obtieneSolicitudConcursoBaremada($cod_con, $dni, $cod_sol);
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
    public function getHaySolicitudConcursoBaremada($cod_con, $dni, $cod_sol) {
        //error_log('DEBUG: en getHaySolicitudConcursoBaremada ' . $dni);
        $concursoHaySolicitudBaremada = DBConcursosPrimaria::obtieneHaySolicitudConcursoBaremada($cod_con, $dni, $cod_sol);
        return $concursoHaySolicitudBaremada;
    }

    /**
     * Devuelve un array con los Concursos de primaria en las que 
     * tiene solicitud
     * 
     * @param string $dni
     * @return string[]
     */
    public function getConcursoHaySolicitud($dni) {
        //error_log('DEBUG: en getConcursoHaySolicitud ' . $dni);
        $concursoHaySolicitud = DBConcursosPrimaria::obtieneConcursoHaySolicitud($dni);
        return $concursoHaySolicitud;
    }

    /**
     * Devuelve un array con las solicitudes al concurso de traslasdos de primaria
     *  del usuario
     * 
     * @param string $cod_opc
     * @param string $dni
     * @return string[]
     */
    public function getSolicitudesConcurso($cod_opc, $dni) {
        //error_log('DEBUG: en getSolicitudesConcurso ' . $cod_opc.' '. $dni);
        $solicitudesConcurso = DBConcursosPrimaria::obtieneSolicitudesConcurso($cod_opc, $dni);
        return $solicitudesConcurso;
    }

    /**
     * Devuelve la información de la solicitud al concurso de traslasdos de primaria
     *  del usuario
     * 
     * @param string $cod_opc
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getSolicitudConcurso($cod_opc, $dni, $cod_sol) {
        //error_log('DEBUG: en getSolicitudConcurso ' . $cod_opc.' '. $dni. ' '. $cod_sol);
        $solicitudConcurso = DBConcursosPrimaria::obtieneSolicitudConcurso($cod_opc, $dni, $cod_sol);
        return $solicitudConcurso;
    }

    /**
     * Devuelve un array con los concursos activos 
     * 
     * @return string[]
     */
    public function getConcursosActivos() {
        //error_log('DEBUG: en getConcursosActivos Primaria');
        $concursosActivos = DBConcursosPrimaria::obtieneConcursosActivos();
        return $concursosActivos;
    }

    /**
     * Devuelve la información del concurso seleccionado 
     * 
     * @param string $cod_con
     * @return string[]
     */
    public function getConcursoActivo($cod_con) {
        //error_log('DEBUG: en getConcursoActivo Primaria');
        $concursoActivo = DBConcursosPrimaria::obtieneConcursoActivo($cod_con);
        return $concursoActivo;
    }

}

?>