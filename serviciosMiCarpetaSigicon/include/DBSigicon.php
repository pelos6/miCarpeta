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
     * Devuelve un array con las solicitudes a listas relevantes
     * para el usuario, tanto de ampliación de listas como de rebaremación
     * 
     */
    public static function obtieneSolicitudesListas($dni) {
        $sql = "select tipo_id, dni, cod_con, des_con, cod_sol, estado  from vsolicitudeslistas ";
        // $sql .= " WHERE dni=:dni ";
        error_log('DEBUG: en obtieneSolicitudesListas ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
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
    public static function obtieneConvocatoriasListasActivas() {
        $sql = "select cod_con, des_con, cod_tip_con, 'S' l_act from vconvocatoriaslistasactivas;";
        error_log('DEBUG: en obtieneConvocatoriasListasActivas '.$sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $convocatoriasListasActivas = array();

        if ($resultado) {
            // Añadimos un elemento por cada producto obtenido
            $row = $resultado->fetch();
            error_log('DEBUG: en obtieneConvocatoriasListasActivas resultado true');
            while ($row != null) {
                error_log('DEBUG: en obtieneConvocatoriasListasActivas en el loop');
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
        error_log('DEBUG: en obtieneSolicitudesOposiciones ' . $sql);
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
        error_log('DEBUG: en obtieneOposicionesActivas');
        $sql = "SELECT cod_con , des_con  , cod_tip_con,l_act  FROM voposicionesactivas;";
        error_log('DEBUG: en obtieneOposicionesActivas ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $oposicionesActivos = array();

        if ($resultado) {
           // error_log('DEBUG: en obtieneOposicionesActivas resultado true');
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
