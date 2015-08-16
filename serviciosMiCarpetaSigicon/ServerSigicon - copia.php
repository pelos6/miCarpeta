<?php

require_once('include/DBSigicon.php');

class ServerSigicon {

      /**
     * Devuelve la información de la solicitud seleccionada
     * en la convocatoria seleccionada
     */
    public function getSolicitudListas($cod_con,$dni,$cod_sol) {
        //error_log('DEBUG: en getSolicitudListas '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudesListas = DBSigicon::obtieneSolicitudListas($cod_con,$dni, $cod_sol);
        return $solicitudesListas;
    }
    /**
     * Devuelve un array con las convocatorias a listas activas
     * 
     */
    public function getConvocatoriasListasActivas() {
        //error_log('DEBUG: en getConvocatoriasListasActivas');
        $convocatoriasListasActivas = DBSigicon::obtieneConvocatoriasListasActivas();
        return $convocatoriasListasActivas;
    }
    /**
     * Devuelve la información de la convocatoria a listas seleccionada
     * 
     */
    public function getConvocatoriaListas($cod_con) {
        //error_log('DEBUG: en getConvocatoriaListas ' . $cod_con);
        $convocatoriaListas = DBSigicon::obtieneConvocatoriaListas($cod_con);
        return $convocatoriaListas;
    }

    /**
     * Devuelve un array con las convocatorias a listas en las que 
     * tiene solicitud
     * 
     */
    public function getConvocatoriasListasHaySolicitud($dni) {
       //error_log('DEBUG: en getConvocatoriasListasHaySolicitud ' . $dni);
        $convocatoriasListasSolicitud = DBSigicon::obtieneConvocatoriasListasHaySolicitud($dni);
        return $convocatoriasListasSolicitud;
    }

    /**
     * Devuelve un array con las solicitudes a listas de la convocatoria
     *  tanto de ampliación de listas como de rebaremación
     * 
     */
    public function getSolicitudesConvocatoriaListas($cod_con,$dni) {
        //error_log('DEBUG: en getSolicitudesConvocatoriaListas '. $cod_con.' ' . $dni);
        $solicitudesListas = DBSigicon::obtieneSolicitudesConvocatoriaListas($cod_con,$dni);
        return $solicitudesListas;
    }
    

    /**
     * Devuelve un array con las oposiciones en las que 
     * tiene solicitud
     * 
     */
    public function getOposicionesHaySolicitud($dni) {
       //error_log('DEBUG: en getOposicionesHaySolicitud ' . $dni);
        $oposicionesSolicitud = DBSigicon::obtieneOposicionesHaySolicitud($dni);
        return $oposicionesSolicitud;
    }

   /**
     * Devuelve un array con las solicitudes a oposición
     * 
     */
    public function getSolicitudesConvocatoriaOposicion($cod_con,$dni) {
        //error_log('DEBUG: en getSolicitudesConvocatoriaListas '. $cod_con.' ' . $dni);
        $solicitudesOposicion = DBSigicon::obtieneSolicitudesConvocatoriaOposicion($cod_con,$dni);
        return $solicitudesOposicion;
    }
    public function getSolicitudesOposiciones($dni) {
        //error_log('DEBUG: en getSolicitudesOposiciones ' . $dni);
        $solicitudesOposiciones = DBSigicon::obtieneSolicitudesOposiciones($dni);
        return $solicitudesOposiciones;
    }

  /**
     * Devuelve la información de la oposición seleccionada
     * 
     */
    public function getConvocatoriaOposicion($cod_con) {
        //error_log('DEBUG: en getConvocatoriaOposicion ' . $cod_con);
        $convocatoriaOposicion = DBSigicon::obtieneConvocatoriaOposicion($cod_con);
        return $convocatoriaOposicion;
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


/**
     * Devuelve un array con las oposiciones en las que 
     * tiene solicitud el usuario
     * 
     */
    public function getConvocatoriasOposicionHaySolicitud($dni) {
       error_log('DEBUG: en getConvocatoriasOposicionHaySolicitud ' . $dni);
        $convocatoriasOposicionSolicitud = DBSigicon::obtieneConvocatoriasOposicionHaySolicitud($dni);
        return $convocatoriasOposicionSolicitud;
    }


     /**
     * Devuelve la información de la solicitud seleccionada
     * en la convocatoria seleccionada
     */
    public function getSolicitudOposicion($cod_con,$dni,$cod_sol) {
        error_log('DEBUG: en getSolicitudOposicion '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudesListas = DBSigicon::obtieneSolicitudOposicion($cod_con,$dni, $cod_sol);
        return $solicitudesListas;
    }

}

?>