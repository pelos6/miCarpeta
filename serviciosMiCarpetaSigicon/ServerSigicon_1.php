<?php

require_once('include/DBSigicon.php');

class ServerSigicon {
    /*INTERINOS*/
    /**
     * Devuelve la información del baremo de la solicitud 
     * en la convocatoria seleccionada
     */
    public function getBaremoSolicitudConvocatoriaListas($cod_con,$dni,$cod_sol) {
        error_log('DEBUG: en getBaremoSolicitudConvocatoriaListas '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneBaremoSolicitudConvocatoriaListas($cod_con,$dni, $cod_sol);
        return $solicitudBaremada;
    }
      /**
     * Devuelve la información de si la solicitud esta o no baremada
     * en la convocatoria seleccionada
     */
    public function getHaySolicitudConvocatoriaListasBaremada($cod_con,$dni,$cod_sol) {
        //error_log('DEBUG: en getHaySolicitudConvocatoriaListasBaremada '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneHaySolicitudConvocatoriaListasBaremada($cod_con,$dni, $cod_sol);
        return $solicitudBaremada;
    }
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
    /* FIN INTERINOS*/

    /*OPOSICIONES*/
    /**
     * Devuelve la información de las notas de la solicitud 
     * en la convocatoria seleccionada
     */
    public function getNotaSolicitudConvocatoriaOposicion($cod_con,$dni,$cod_sol) {
        error_log('DEBUG: en getNotaSolicitudConvocatoriaOposicion '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudNotas = DBSigicon::obtieneNotasSolicitudConvocatoriaOposicion($cod_con,$dni, $cod_sol);
        return $solicitudNotas;
    }
      /**
     * Devuelve la información de si la solicitud esta o no calificada
     * en la convocatoria seleccionada
     */
    public function getHaySolicitudConvocatoriaOposicionNota($cod_con,$dni,$cod_sol) {
        //error_log('DEBUG: en getHaySolicitudConvocatoriaOposicionNota '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudNotas = DBSigicon::obtieneHaySolicitudConvocatoriaOposicionNotas($cod_con,$dni, $cod_sol);
        return $solicitudNotas;
    }
    /**
     * Devuelve la información del baremo de la solicitud 
     * en la convocatoria seleccionada
     */
    public function getBaremoSolicitudConvocatoriaOposicion($cod_con,$dni,$cod_sol) {
        error_log('DEBUG: en getBaremoSolicitudConvocatoriaOposicion '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneBaremoSolicitudConvocatoriaOposicion($cod_con,$dni, $cod_sol);
        return $solicitudBaremada;
    }
      /**
     * Devuelve la información de si la solicitud esta o no baremada
     * en la convocatoria seleccionada
     */
    public function getHaySolicitudConvocatoriaOposicionBaremada($cod_con,$dni,$cod_sol) {
        //error_log('DEBUG: en getHaySolicitudConvocatoriaOposicionBaremada '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneHaySolicitudConvocatoriaOposicionBaremada($cod_con,$dni, $cod_sol);
        return $solicitudBaremada;
    }
    /**
     * Devuelve la información del baremo de la solicitud 
     * en la oposición seleccionada
     */
    public function getBaremoSolicitudOposicion($cod_con,$dni,$cod_sol) {
        error_log('DEBUG: en getBaremoSolicitudOposicion '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneBaremoSolicitudOposicion($cod_con,$dni, $cod_sol);
        return $solicitudBaremada;
    }
      /**
     * Devuelve la información de si la solicitud esta o no baremada
     * en la convocatoria seleccionada
     */
    public function getHaySolicitudOposicionBaremada($cod_con,$dni,$cod_sol) {
        //error_log('DEBUG: en getHaySolicitudOposicionBaremada '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneHaySolicitudOposicionBaremada($cod_con,$dni, $cod_sol);
        return $solicitudBaremada;
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

 /**
     * Devuelve la información de la oposición seleccionada
     * 
     */
    public function getConvocatoriaOposicion($cod_con) {
        //error_log('DEBUG: en getConvocatoriaOposicion ' . $cod_con);
        $convocatoriaOposicion = DBSigicon::obtieneConvocatoriaOposicion($cod_con);
        return $convocatoriaOposicion;
    }


/****A BORRAR LOS DE ABAJO*******/

    public function getSolicitudesOposiciones($dni) {
        //error_log('DEBUG: en getSolicitudesOposiciones ' . $dni);
        $solicitudesOposiciones = DBSigicon::obtieneSolicitudesOposiciones($dni);
        return $solicitudesOposiciones;
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

    /*FIN OPOSICIONES*/
}

?>