<?php

require_once('include/DBSigicon.php');

class ServerSigicon {
         /**
     * Devuelve la información de la convocatoria a listas seleccionada
     * 
     */
    public function getConvocatoriaListas($cod_con) {
        error_log('DEBUG: en getConvocatoriaListas '.$cod_con);
        $convocatoriaListas = DBSigicon::obtieneConvocatoriaListas($cod_con);
        return $convocatoriaListas;
    }
     /**
     * Devuelve un array con las convocatorias a listas activas
     * 
     */
    public function getConvocatoriasListasActivas() {
        error_log('DEBUG: en getConvocatoriasListasActivas');
        $convocatoriasListasActivas = DBSigicon::obtieneConvocatoriasListasActivas();
        return $convocatoriasListasActivas;
    }
    /**
     * Devuelve un array con las solicitudes a listas relevantes
     * para el usuario, tanto de ampliación de listas como de rebaremación
     * 
     */
    public function getSolicitudesListas($dni) {
        error_log('DEBUG: en getSolicitudesListas ' . $dni);
        $solicitudesListas = DBSigicon::obtieneSolicitudesListas($dni);
        return $solicitudesListas;
    }
    
     public function getSolicitudesOposiciones($dni) {
        error_log('DEBUG: en getSolicitudesOposiciones ' . $dni);
        $solicitudesOposiciones = DBSigicon::obtieneSolicitudesOposiciones($dni);
        return $solicitudesOposiciones;
    }

    /**
     * Devuelve un array con las oposiciones activas 
     * 
     */
    public function getOposicionesActivas() {
        error_log('DEBUG: en getOposicionesActivas');
        $oposicionesActivos = DBSigicon::obtieneOposicionesActivas();
        return $oposicionesActivos;
    }

}

?>