<?php

require_once('include/DBSigi.php');

class ServerSigi {
     /**
     * Devuelve un array con las especialidades convocadas a un acto de elección 
     * de las vacantes que puede pedir el usuario
     * 
     */
    public function getEspecialidadesPedidas($cod_opc, $dni, $cod_sol) {
        error_log('DEBUG: en getEspecialidadesPedidas '.$cod_opc);
        $especialidadesActo = DBSigi::obtieneEspecialidadesPedidas($cod_opc, $dni, $cod_sol);
        return $especialidadesActo;
    }
    /**
     * Devuelve un array con las vacantes convocadas a un acto de elección 
     * de la que puede pedir el usuario
     * 
     */
    public function getVacantesPedidas($cod_opc, $dni, $cod_sol) {
        //error_log('DEBUG: en getVacantesPedidas '.$cod_opc);
        $vacantesActo = DBSigi::obtieneVacantesPedidas($cod_opc, $dni, $cod_sol);
        return $vacantesActo;
    }

     /**
     * Devuelve un array con las especialidades convocadas a un acto de elección 
     * de las vacantes que puede pedir el usuario
     * 
     */
    public function getEspecialidadesSeleccionables($cod_opc, $dni) {
        error_log('DEBUG: en getEspecialidadesSeleccionables '.$cod_opc);
        $especialidadesActo = DBSigi::obtieneEspecialidadesSeleccionables($cod_opc, $dni);
        return $especialidadesActo;
    }
    /**
     * Devuelve un array con las vacantes convocadas a un acto de elección 
     * de la que puede pedir el usuario
     * 
     */
    public function getVacantesSeleccionables($cod_opc, $dni) {
        //error_log('DEBUG: en getVacantesSeleccionables '.$cod_opc);
        $vacantesActo = DBSigi::obtieneVacantesSeleccionables($cod_opc, $dni);
        return $vacantesActo;
    }

     /**
     * Devuelve un array con las especialidades convocadas a un acto de elección 
     * 
     */
    public function getEspecialidadesActo($cod_opc) {
        error_log('DEBUG: en getEspecialidadesActo '.$cod_opc);
        $especialidadesActo = DBSigi::obtieneEspecialidadesActo($cod_opc);
        return $especialidadesActo;
    }
    /**
     * Devuelve un array con las vacantes convocadas a un acto de elección 
     * 
     */
    public function getVacantesActo($cod_opc) {
        //error_log('DEBUG: en getVacantesActo '.$cod_opc);
        $vacantesActo = DBSigi::obtieneVacantesActo($cod_opc);
        return $vacantesActo;
    }
      /**
     * Devuelve un array con los actos de elección en las que 
     * tiene solicitud
     * 
     */
    public function getActosHaySolicitud($dni) {
        //error_log('DEBUG: en getActosHaySolicitud ' . $dni);
        $actosHaySolicitud = DBSigi::obtieneActosHaySolicitud($dni);
        return $actosHaySolicitud;
    }

    /**
     * Devuelve un array con los actos de elección en las que 
     * esta convocado
     * 
     */
    public function getActosConvocado($dni) {
        //error_log('DEBUG: en getActosConvocado ' . $dni);
        $actosConvocado = DBSigi::obtieneActosConvocado($dni);
        return $actosConvocado;
    }

    /**
     * Devuelve un array con las solicitudes al acto de elección
     *  del usuario
     * 
     */
    public function getSolicitudesActo($cod_opc,$dni) {
        error_log('DEBUG: en getSolicitudesActos ' . $cod_opc.' '. $dni);
        $solicitudesActo = DBSigi::obtieneSolicitudesActo($cod_opc,$dni);
        return $solicitudesActo;
    }

    /**
     * Devuelve la información de la solicitud al acto de elección
     *  del usuario
     * 
     */
    public function getSolicitudActo($cod_opc,$dni,$cod_sol) {
        error_log('DEBUG: en getSolicitudActo ' . $cod_opc.' '. $dni. ' '. $cod_sol);
        $solicitudActo = DBSigi::obtieneSolicitudActo($cod_opc,$dni,$cod_sol);
        return $solicitudActo;
    }

    /**
     * Devuelve un array con las consultas sobre la situación en listas relevantes
     * para el usuario
     * 
     */
    public function getConsultasSituacionListas($dni) {
        //error_log('DEBUG: en getConsultasSituacionListas ' . $dni);
        $consultasSituacionListas = DBSigi::obtieneConsultasSituacionListas($dni);
        return $consultasSituacionListas;
    }

    /**
     * Devuelve un array con los códigos de todas los actos de elección activos
     * 
     */
    public function getActosActivos() {
        //error_log('DEBUG: en getActosActivos');
        $actosActivos = DBSigi::obtieneActosActivos();
        return $actosActivos;
    }

    /**
     * Devuelve la información del acto de elección activo
     * 
     */
    public function getActoActivo($cod_opc) {
        //error_log('DEBUG: en getActoActivo '.$cod_opc);
        $actoActivo = DBSigi::obtieneActoActivo($cod_opc);
        return $actoActivo;
    }

    /**
     * Devuelve un array con los códigos de todas los actos de elección activos
     * 
     */
    public function getVacantesSolicitables($dni) {
        //error_log('DEBUG: en getVacantesSolicitables ' . $dni);
        $vacantesSolicitables = DBSigi::obtieneVacantesSolicitables($dni);
        return $vacantesSolicitables;
    }

    public function getActoEleccion($cod_opc, $f_con_ae) {
        //error_log('DEBUG: el cod_opc ' . $cod_opc);
        // $producto = DBSigi::obtieneProducto($codigo);
        return DBSigi::obtieneActoEleccion($cod_opc, $f_con_ae);
        ;
    }

}

?>