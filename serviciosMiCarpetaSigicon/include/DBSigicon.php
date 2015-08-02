<?php

/**
 * Descripcion de DBSigicon
 * 
 * Los datos sacados de SIGICON 
 *
 * @author Javier
 */
// la clase DBSigicon para el servicio que sirve información sobre listas de interinos
// los php requeridos que son otras clases
require_once('ConvocatoriaLista.php');
require_once('SolicitudLista.php');
require_once('Oposicion.php');
require_once('SolicitudOposicion.php');

class DBSigicon {
    /* con metodos estaticos dado que no se va a instanciar esta clase y
      pasando los valores como array para evitar consultas sin parametrizar */

//    protected static function ejecutaConsulta($sql) {
    protected static function ejecutaConsulta($sql, $valores = null) {
        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8");
        // desarrollo local
        $dsn = "mysql:host=localhost;dbname=serviciosmicarpetasigicon";
        $usuario = 'root';
        $contrasena = 'javier';
        // para infenlaces
//         $dsn = "mysql:host=localhost;dbname=javieriranzo_dwes";
//          $usuario = 'javieriranzo_dwe';
//          $contrasena = 'javier';
        // para apostayadrede.com
//         $dsn = "mysql:host=localhost;dbname=c23sigicon";
//          $usuario = 'c23sigicon';
//          $contrasena = 'c23sigicon';

        $dwes = new PDO($dsn, $usuario, $contrasena, $opc);
        $resultado = null;
        // lo hacemos con parametros por seguridad
//        if (isset($dwes)) {
//            $resultado = $dwes->query($sql);
//        }
        if (isset($dwes)) {
            $resultado = $dwes->prepare($sql);
            $resultado->execute($valores);
        }
        return $resultado;
    }

    /**
     * Devuelve un la información de la solicitud de seleccionada en la 
     * convocatoria seleccionada para la persona indicada
     */
    public static function obtieneSolicitudListas($cod_con, $dni, $cod_sol) {
        $sql = "select tipo_id, dni, cod_con, des_con, cod_sol,fec_sol, cod_est_sol, des_est_sol ";
        $sql .= " from vsolicitudeslistas  WHERE cod_con=:cod_con ";
        $sql .= " and dni=:dni ";
        $sql .= " and cod_sol=:cod_sol ";
        //error_log('DEBUG: en obtieneSolicitudListas ' . $sql . ' ' . $cod_con . ' ' . $dni . ' ' . $cod_sol);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('cod_con' => $cod_con, 'dni' => $dni, 'cod_sol' => $cod_sol));
        $solicitudesListas = array();
        //error_log('DEBUG: en obtieneSolicitudListas resultado ');

        if ($resultado) {
            //error_log('DEBUG: en obtieneSolicitudListas resultado true ');
            // Añadimos un elemento por cada solicitud obtenido
            $row = $resultado->fetch();
            while ($row != null) {
                $solicitudListas = new SolicitudLista($row);
                // $solicitudesListas[] = new SolicitudLista($row);
                $row = $resultado->fetch();
            }
        }
        return $solicitudListas;
    }

    /**
     * Devuelve un array con las solicitudes a listas relevantes
     * para el usuario, tanto de ampliación de listas como de rebaremación
     * 
     */
    public static function obtieneSolicitudesConvocatoriaListas($cod_con, $dni) {
        $sql = "select tipo_id, dni, cod_con, des_con, cod_sol,des_est_sol, fec_sol, cod_est_sol ";
        $sql .= " from vsolicitudeslistas WHERE dni=:dni ";
        $sql .= " and cod_con=:cod_con ";
        //error_log('DEBUG: en obtieneSolicitudesConvocatoriaListas ' . $sql . ' ' . $cod_con . ' ' . $dni);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('cod_con' => $cod_con, 'dni' => $dni));
        $solicitudesListas = array();

        if ($resultado) {
            // Añadimos un elemento por cada solicitud obtenido
            $row = $resultado->fetch();
            while ($row != null) {
                $solicitudesListas[] = new SolicitudLista($row);
                $row = $resultado->fetch();
            }
        }
        return $solicitudesListas;
    }

    /**
     * Devuelve un array con las convocatorias a listas que estan activas
     * para el usuario, tanto de ampliación de listas como de rebaremación
     * 
     */
    public static function obtieneConvocatoriaListas($cod_con) {
        $sql = "select cod_con, des_con, cod_tip_con, 'S' l_act, f_res, f_pub,";
        $sql .= " f_ini_sol, f_fin_sol, url from vconvocatoriaslistasactivas ";
        $sql .= " WHERE cod_con=:cod_con ";
        //error_log('DEBUG: en obtieneConvocatoriaListas ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('cod_con' => $cod_con));
        $convocatoriaListas = array();

        if ($resultado) {
            
            $row = $resultado->fetch();
            ////error_log('DEBUG: en obtieneConvocatoriaListas resultado true');
            $convocatoriaListas = new ConvocatoriaLista($row);
        }
        return $convocatoriaListas;
    }

    /**
     * Devuelve un array con las convocatorias a listas en las que tiene solicitud
     * el usuario, tanto de ampliación de listas como de rebaremación
     * 
     */
    public static function obtieneConvocatoriasListasHaySolicitud($dni) {
        $sql = " select distinct cod_con, des_con,l_act, cod_tip_con,f_res, f_pub, f_ini_sol, ";
        $sql .= "f_fin_sol, url from vconvocatoriaslistassolicitud ";
        $sql .= " WHERE dni=:dni ";
        //error_log('DEBUG: en obtieneConvocatoriasListasHaySolicitud ' . $sql . ' ' . $dni);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $convocatoriasListasActivas = array();

        if ($resultado) {
            $row = $resultado->fetch();
            // //error_log('DEBUG: en obtieneConvocatoriasListasHaySolicitud resultado true');
            while ($row != null) {
                //  //error_log('DEBUG: en obtieneConvocatoriasListasHaySolicitud en el loop');
                $convocatoriasListasActivas[] = new ConvocatoriaLista($row);
                $row = $resultado->fetch();
            }
        }

        return $convocatoriasListasActivas;
    }

    /**
     * Devuelve un array con las convocatorias a listas que estan activas
     * para el usuario, tanto de ampliación de listas como de rebaremación
     * 
     */
    public static function obtieneConvocatoriasListasActivas() {
//        $sql = "select cod_con, des_con, cod_tip_con, 'S' l_act from vconvocatoriaslistasactivas;";
        $sql = "select cod_con, des_con, cod_tip_con, 'S' l_act, f_res, f_pub,";
        $sql .= " f_ini_sol, f_fin_sol, url from vconvocatoriaslistasactivas ";
        //error_log('DEBUG: en obtieneConvocatoriasListasActivas ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $convocatoriasListasActivas = array();

        if ($resultado) {
            
            $row = $resultado->fetch();
            // //error_log('DEBUG: en obtieneConvocatoriasListasActivas resultado true');
            while ($row != null) {
                //    //error_log('DEBUG: en obtieneConvocatoriasListasActivas en el loop');
                $convocatoriasListasActivas[] = new ConvocatoriaLista($row);
                $row = $resultado->fetch();
            }
        }

        return $convocatoriasListasActivas;
    }

    /**
     * Devuelve un array con las solicitudes a concursod de traslados del
     * usuario
     * 
     */
    public static function obtieneSolicitudesOposiciones($dni) {
        $sql = "select tipo_id, dni, cod_con, des_con, cod_sol, estado  from vsolicitudesoposiciones ";
        $sql .= " WHERE dni=:dni ";
        //error_log('DEBUG: en obtieneSolicitudesOposiciones ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $solicitudesOposiciones = array();

        if ($resultado) {
            // Añadimos un elemento por cada solicitud obtenida
            $row = $resultado->fetch();
            while ($row != null) {
                $solicitudesOposiciones[] = new SolicitudOposicion($row);
                $row = $resultado->fetch();
            }
        }
        return $solicitudesOposiciones;
    }

    /**
     * Devuelve un array con las oposiciones que estan activas
     * 
     */
    public static function obtieneOposicionesActivas() {
        //error_log('DEBUG: en obtieneOposicionesActivas');
        $sql = "SELECT cod_con , des_con  , cod_sol, cod_tip_con,l_act  FROM voposicionesactivas;";
        //error_log('DEBUG: en obtieneOposicionesActivas ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $oposicionesActivos = array();

        if ($resultado) {
            // //error_log('DEBUG: en obtieneOposicionesActivas resultado true');
            $row = $resultado->fetch();
            while ($row != null) {
                $oposicionesActivos[] = new Oposicion($row);
                $row = $resultado->fetch();
            }
        }
        return $oposicionesActivos;
    }

}

?>
