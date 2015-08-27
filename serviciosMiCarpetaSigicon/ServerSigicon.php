<?php

require_once('include/DBSigicon.php');

class ServerSigicon {
    /* INTERINOS */
    /* BAREMO */

    /**
     * Devuelve la información del baremo de la solicitud 
     * en la convocatoria seleccionada
     *
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getBaremoSolicitudConvocatoriaListas($cod_con, $dni, $cod_sol) {
        //error_log('DEBUG: en getBaremoSolicitudConvocatoriaListas ' . $cod_con . ' ' . $dni . ' ' . $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneBaremoSolicitudConvocatoriaListas($cod_con, $dni, $cod_sol);
        return $solicitudBaremada;
    }

    /**
     * Devuelve la información de si la solicitud esta o no baremada
     * en la convocatoria seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getHaySolicitudConvocatoriaListasBaremada($cod_con, $dni, $cod_sol) {
        //error_log('DEBUG: en getHaySolicitudConvocatoriaListasBaremada '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneHaySolicitudConvocatoriaListasBaremada($cod_con, $dni, $cod_sol);
        return $solicitudBaremada;
    }

    /* FIN BAREMO */

    /**
     * Devuelve la información de la solicitud seleccionada
     * en la convocatoria seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getSolicitudListas($cod_con, $dni, $cod_sol) {
        //error_log('DEBUG: en getSolicitudListas '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudesListas = DBSigicon::obtieneSolicitudListas($cod_con, $dni, $cod_sol);
        return $solicitudesListas;
    }

    /**
     * Devuelve un array con las convocatorias a listas activas
     * 
     * @return string[]
     */
    public function getConvocatoriasListasActivas() {
        //error_log('DEBUG: en getConvocatoriasListasActivas');
        $convocatoriasListasActivas = DBSigicon::obtieneConvocatoriasListasActivas();
        return $convocatoriasListasActivas;
    }

    /**
     * Devuelve la información de la convocatoria a listas seleccionada
     * 
     * @param string $cod_con
     * @return string[]
     */
    public function getConvocatoriaListas($cod_con) {
        //error_log('DEBUG: en getConvocatoriaListas ' . $cod_con);
        $convocatoriaListas = DBSigicon::obtieneConvocatoriaListas($cod_con);
        return $convocatoriaListas;
    }

    /* SOLICITUDES */

    /**
     * Devuelve un array con las convocatorias a listas en las que 
     * tiene solicitud
     * 
     * @param string $dni
     * @return string[]
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
     * @param string $cod_con
     * @param string $dni
     * @return string[]
     */
    public function getSolicitudesConvocatoriaListas($cod_con, $dni) {
        //error_log('DEBUG: en getSolicitudesConvocatoriaListas '. $cod_con.' ' . $dni);
        $solicitudesListas = DBSigicon::obtieneSolicitudesConvocatoriaListas($cod_con, $dni);
        return $solicitudesListas;
    }

    /* FIN SOLICITUDES */
    /* FIN INTERINOS */

    /* OPOSICIONES */
    /* NOTAS */

    /**
     * Devuelve la información de las notas de la solicitud 
     * en la convocatoria seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getNotasSolicitudOposicion($cod_con, $dni, $cod_sol) {
       // error_log('DEBUG: en getNotasSolicitudConvocatoriaOposicion ' . $cod_con . ' ' . $dni . ' ' . $cod_sol);
        $solicitudNotas = DBSigicon::obtieneNotasSolicitudOposicion($cod_con, $dni, $cod_sol);
        return $solicitudNotas;
    }

    /**
     * Devuelve la información de si la solicitud esta o no calificada
     * en la convocatoria seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getHaySolicitudOposicionNota($cod_con, $dni, $cod_sol) {
        //error_log('DEBUG: en getHaySolicitudConvocatoriaOposicionNota '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudNotas = DBSigicon::obtieneHaySolicitudOposicionNotas($cod_con, $dni, $cod_sol);
        return $solicitudNotas;
    }

    /* FIN NOTAS */
    /* BAREMO */

    /**
     * Devuelve la información del baremo de la solicitud 
     * en la oposición seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getBaremoSolicitudOposicion($cod_con, $dni, $cod_sol) {
        error_log('DEBUG: en getBaremoSolicitudOposicion ' . $cod_con . ' ' . $dni . ' ' . $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneBaremoSolicitudOposicion($cod_con, $dni, $cod_sol);
        return $solicitudBaremada;
    }

    /**
     * Devuelve la información de si la solicitud esta o no baremada
     * en la convocatoria seleccionada
     * 
     * @param string $cod_con
     * @param string $dni
     * @param string $cod_sol
     * @return string[]
     */
    public function getHaySolicitudOposicionBaremada($cod_con, $dni, $cod_sol) {
        //error_log('DEBUG: en getHaySolicitudOposicionBaremada '. $cod_con.' ' . $dni. ' '. $cod_sol);
        $solicitudBaremada = DBSigicon::obtieneHaySolicitudOposicionBaremada($cod_con, $dni, $cod_sol);
        return $solicitudBaremada;
    }

    /* FIN BAREMO */

    /**
     * Devuelve un array con las oposiciones activas 
     * 
     * @return string[]
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
     * @param string $dni
     * @return string[]
     */
    public function getOposicionesHaySolicitud($dni) {
        //error_log('DEBUG: en getOposicionesHaySolicitud ' . $dni);
        $oposicionesSolicitud = DBSigicon::obtieneOposicionesHaySolicitud($dni);
        return $oposicionesSolicitud;
    }

    /**
     * Devuelve un array con las solicitudes a oposición
     * 
     * @param string $cod_con
     * @param string $dni
     * @return string[]
     */
    public function getSolicitudesOposicion($cod_con, $dni) {
        //error_log('DEBUG: en getSolicitudesConvocatoriaListas '. $cod_con.' ' . $dni);
        $solicitudesOposicion = DBSigicon::obtieneSolicitudesOposicion($cod_con, $dni);
        return $solicitudesOposicion;
    }

    /**
     * Devuelve la información de la oposición seleccionada
     * 
     * @param string $cod_con
     * @return string[]
     */
    public function getConvocatoriaOposicion($cod_con) {
        //error_log('DEBUG: en getConvocatoriaOposicion ' . $cod_con);
        $convocatoriaOposicion = DBSigicon::obtieneConvocatoriaOposicion($cod_con);
        return $convocatoriaOposicion;
    }

    /* FIN OPOSICIONES */
}

?>