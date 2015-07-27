<?php

require_once('include/DBSigi.php');

class ServerSigi {

    /**
     * Devuelve un array con las solicitudes a actos de elección
     *  relevantes para el usuario
     * 
     */
    public function getSolicitudesActos($dni) {
        error_log('DEBUG: en getSolicitudesActos ' . $dni);
       // error_log('DEBUG: en getSolicitudesActos ' . $dni);
        $solicitudesActos = DBSigi::obtieneSolicitudesActos($dni);
        return $solicitudesActos;
    }

    /**
     * Devuelve un array con las consultas sobre la situación en listas relevantes
     * para el usuario
     * 
     */
    public function getConsultasSituacionListas($dni) {
        error_log('DEBUG: en getConsultasSituacionListas ' . $dni);
        $consultasSituacionListas = DBSigi::obtieneConsultasSituacionListas($dni);
        return $consultasSituacionListas;
    }

    /**
     * Obtiene el PVP de un producto a partir de su código
     * 
     */
    public function getEstaConvocado($dni) {
        error_log('DEBUG: el codigo ' . $dni);
        // $producto = DBSigi::obtieneProducto($codigo);
        return DBSigi::consultaConvocadoActoEleccion($dni);
        ;
    }

    /**
     * Devuelve un array con los códigos de todas los actos de elección activos
     * 
     */
    public function getActosActivos() {
        error_log('DEBUG: en getActosActivos');
        $actosActivos = DBSigi::obtieneActosActivos();
        return $actosActivos;
    }

    /**
     * Devuelve un array con los códigos de todas los actos de elección activos
     * 
     */
    public function getVacantesSolicitables($dni) {
        error_log('DEBUG: en getVacantesSolicitables ' . $dni);
        $vacantesSolicitables = DBSigi::obtieneVacantesSolicitables($dni);
        return $vacantesSolicitables;
    }

    public function getActoEleccion($cod_opc, $f_con_ae) {
        error_log('DEBUG: el cod_opc ' . $cod_opc);
        // $producto = DBSigi::obtieneProducto($codigo);
        return DBSigi::obtieneActoEleccion($cod_opc, $f_con_ae);
        ;
    }

}

?>