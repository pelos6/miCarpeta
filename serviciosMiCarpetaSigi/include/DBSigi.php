<?php

/**
 * Description of DBSigi
 * 
 * Los datos sacados de SIGI 
 *
 * @author Javier
 */
// los php requeridos que son otras clases
require_once('ActoEleccion.php');
require_once('SolicitudActo.php');
require_once('ConsultaSituacionLista.php');

class DBSigi {

// con metodos estaticos dado que no se va a instanciar esta clase
// pasando los valores como array para evitar consultas sin parametrizar
// protected static function ejecutaConsulta($sql) {
    protected static function ejecutaConsulta($sql, $valores = null) {
        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8");
        /*desarrollo local*/
          $dsn = "mysql:host=localhost;dbname=serviciosmicarpetasigi";
          $usuario = 'root';
          $contrasena = 'javier';
//        // para infenlaces
//        $dsn = "mysql:host=localhost;dbname=javieriranzo_dwes";
//        $usuario = 'javieriranzo_dwe';
//        $contrasena = 'javier';
        // para apostayadrede.com
/*        $dsn = "mysql:host=localhost;dbname=c23sigi";
         $usuario = 'c23sigi';
         $contrasena = 'c23sigi';*/
        $dwes = new PDO($dsn, $usuario, $contrasena, $opc);
        $resultado = null;
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
     * Devuelve un array con los actos de elección en las que tiene solicitud
     * el usuario
     * 
     */
    public static function obtieneActosHaySolicitud($dni) {
        $sql = " select distinct cod_opc , f_con_ae , cod_tip_ae, f_con_ae, f_ini_opc,  f_fin_opc , url, tex_opc  ";
        $sql .= " from vactossolicitud ";
        $sql .= " WHERE dni=:dni ";
        //error_log('DEBUG: en obtieneActosHaySolicitud ' . $sql . ' ' . $dni);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $actosHaySolicitud = array();

        if ($resultado) {
            $row = $resultado->fetch();
             //error_log('DEBUG: en obtieneActosHaySolicitud resultado true');
            while ($row != null) {
                  //error_log('DEBUG: en obtieneActosHaySolicitud en el loop');
                $actosHaySolicitud[] = new ActoEleccion($row);
                $row = $resultado->fetch();
            }
        }

        return $actosHaySolicitud;
    }

  /**
     * Devuelve un array con los actos de elección en las que esta convocado
     * el usuario
     * 
     */
    public static function obtieneActosConvocado($dni) {
        $sql = " select cod_opc , f_con_ae , cod_tip_ae, f_con_ae, f_ini_opc,  f_fin_opc , url, tex_opc  ";
        $sql .= " from vactosconvocado ";
        $sql .= " WHERE dni=:dni ";
        //error_log('DEBUG: en obtieneActosConvocado ' . $sql . ' ' . $dni);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $actosConvocado = array();

        if ($resultado) {
            $row = $resultado->fetch();
             //error_log('DEBUG: en obtieneActosConvocado resultado true');
            while ($row != null) {
                  //error_log('DEBUG: en obtieneActosConvocado en el loop');
                $actosConvocado[] = new ActoEleccion($row);
                $row = $resultado->fetch();
            }
        }

        return $actosConvocado;
    }


    /**
     * Devuelve un array con las solicitudes a actos de elección del
     * usuario
     * 
     */
    public static function obtieneSolicitudesActo($cod_opc,$dni) {
        $sql = "select dni, cod_opc, tex_opc, cod_sol, cod_est_sol  from vsolicitudesacto ";
        $sql .= " WHERE dni=:dni ";
        $sql .= " and  cod_opc=:cod_opc ";
        error_log('DEBUG: en obtieneSolicitudesActo ' . $sql);
        $resultado = self::ejecutaConsulta($sql, array('cod_opc' => $cod_opc,'dni' => $dni));
        $solicitudesActo = array();

        if ($resultado) {
            // Añadimos un elemento por cada solicitud obtenida
            $row = $resultado->fetch();
            while ($row != null) {
                $solicitudesActo[] = new SolicitudActo($row);
                $row = $resultado->fetch();
            }
        }
        return $solicitudesActo;
    }


    /**
     * Devuelve la información de la solicitud al acto de elección del
     * usuario
     * 
     */
    public static function obtieneSolicitudActo($cod_opc,$dni,$cod_sol) {
        $sql = "select dni, cod_opc, tex_opc, cod_sol, cod_est_sol, des_est_sol, f_hor_ent  from vsolicitudesacto ";
        $sql .= " WHERE dni=:dni ";
        $sql .= " and  cod_opc=:cod_opc ";
        $sql .= " and  cod_sol=:cod_sol ";
        error_log('DEBUG: en obtieneSolicitudActo ' . $sql.' '.$cod_opc.' '.$cod_sol);
        $resultado = self::ejecutaConsulta($sql, array('cod_opc' => $cod_opc,'dni' => $dni, 'cod_sol' => $cod_sol));
        $row = $resultado->fetch();
        $solicitudActo = new SolicitudActo($row);
        return $solicitudActo;
    }

    /**
     * Devuelve un array con las consultas sobre la situación en listas relevantes
     * para el usuario
     * 
     */
    public static function obtieneConsultasSituacionListas($dni) {
        $sql = "select cod_opc, tex_opc, url from vconsultasituacionlistas ";
        $sql .= " WHERE dni=:dni ";
        //error_log('DEBUG: en obtieneConsultasSituacionListas  DBSigi ' . $sql. ' '.$dni);
        // $resultado = self::ejecutaConsulta($sql);
        //$resultado = self::ejecutaConsulta($sql, null);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $consultasSituacionListas = array();

        if ($resultado) {
            $row = $resultado->fetch();
            while ($row != null) {
                $consultasSituacionListas[] = new ConsultaSituacionLista($row);
                $row = $resultado->fetch();
            }
        }
        return $consultasSituacionListas;
    }

    // obtiene las vacantes solicitables de un interino
    public static function obtieneVacantesSolicitables($dni) {
        //error_log('DEBUG: en obtieneVacantesSolicitables ' . $dni);
        $sql = "SELECT num_vac,cod_esp FROM sigiv_vac_int ";
        $sql .= "WHERE dni=:dni ";
        //error_log('DEBUG: en obtieneVacantesSolicitables ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $vacantesSolicitables = array();

        if ($resultado) {
            //error_log('DEBUG: en obtieneVacantesSolicitables resultado true');
            $row = $resultado->fetch(PDO::FETCH_BOTH);
            //error_log('DEBUG: en obtieneActosActivos  ' . $row);
            //$row1 = $resultado->fetchColumn(1);
            while ($row != null) {
                // //error_log('DEBUG: en obtieneActosActivos resultado while '.$row[0].' '.$row[1]);
                $vacantesSolicitables[] = $row;
                //$vacantesSolicitables['cod_esp'] = $row1;
                $row = $resultado->fetch(PDO::FETCH_BOTH);
                //   $row1 = $resultado->fetchColumn(1);
            }
        }
        //error_log('DEBUG: en obtieneVacantesSolicitables resultado antes del return');
        return $vacantesSolicitables;
    }

    // obtiene las vacantes solicitables de un interino
    public static function obtieneVacantesSolicitables1($dni) {
        //error_log('DEBUG: en obtieneVacantesSolicitables ' . $dni);
        $sql = "SELECT num_vac, cod_esp /*, nombre*/ FROM sigiv_vac_int ";
        $sql .= "WHERE dni=:dni ";
        //error_log('DEBUG: en obtieneVacantesSolicitables ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $vacantesSolicitables = array();

        if ($resultado) {
            //error_log('DEBUG: en obtieneVacantesSolicitables resultado true');
            $row = $resultado->fetchColumn(PDO::FETCH_ASSOC);
            while ($row != null) {
                //error_log('DEBUG: en obtieneActosActivos resultado while ' . $row);
                $vacantesSolicitables[] = $row;
                $row = $resultado->fetchColumn(PDO::FETCH_ASSOC);
            }
        }
        //error_log('DEBUG: en obtieneVacantesSolicitables resultado antes del return');
        return $vacantesSolicitables;
    }

    // consulta si la persona esta o no convocada a un acto de elección
    public static function consultaConvocadoActoEleccion($dni) {
        //error_log("DEBUG: consultaConvocadoActoEleccion " . $dni);
        $sql = "SELECT cod_opc FROM sigi_can_pre_ae ";
        $sql .= "WHERE dni=:dni ";
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $verificado = 'desde infenlaces: no esta convocado';

        if (isset($resultado)) {
            $fila = $resultado->fetch(PDO::FETCH_OBJ);
            //error_log("DEBUG: consultaConvocadoActoEleccion ");
            if ($fila !== false)
                $verificado = 'desde localhost: Si que esta convocado a ' . $fila->cod_opc;
        }
        return $verificado;
    }

    /**
     * Devuelve la información del acto de elección seleccionado
     * 
     */
    public static function obtieneActoActivo($cod_opc) {
        //error_log('DEBUG: en obtieneActoActivo '.$cod_opc);
        $sql = "SELECT cod_opc , f_con_ae , cod_tip_ae, f_con_ae, f_ini_opc,  f_fin_opc , url, tex_opc  FROM vactosactivos ";
        $sql .= "WHERE cod_opc=:cod_opc ";
        //error_log('DEBUG: en obtieneActoActivo ' . $sql. ' '. $cod_opc);
        $resultado = self::ejecutaConsulta($sql, array('cod_opc' => $cod_opc));
        //$actoActivo = array();

        if ($resultado) {
           // //error_log('DEBUG: en obtieneActoActivos resultado true');
            $row = $resultado->fetch();
            while ($row != null) {
                $actoActivo = new ActoEleccion($row);
                $row = $resultado->fetch();
            }
        }
        return $actoActivo;
    }
    /**
     * Devuelve un array con los actos de elección estan activos
     * 
     */
    public static function obtieneActosActivos() {
        //error_log('DEBUG: en obtieneActosActivos');
        $sql = "SELECT cod_opc , f_con_ae , cod_tip_ae, f_con_ae, f_ini_opc,  f_fin_opc , url, tex_opc  FROM vactosactivos;";
        //error_log('DEBUG: en obtieneActosActivos ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $actosActivos = array();

        if ($resultado) {
            //error_log('DEBUG: en obtieneActosActivos resultado true');
            $row = $resultado->fetch();
            while ($row != null) {
                $actosActivos[] = new ActoEleccion($row);
                $row = $resultado->fetch();
            }
        }
        return $actosActivos;
    }

    // obtiene un producto de la tabla producto
    public static function obtieneActoEleccion($cod_opc, $f_con_ae) {
        //error_log('DEBUG:  obtieneActoEleccion cod_opc ' . $cod_opc . ' f_con_ae ' . $f_con_ae);
        $sql = "SELECT cod_opc , f_con_ae , cod_tip_ae,tex_opc FROM sigi_opc";
//        $sql .= " WHERE cod_opc='" . $cod_opc . "'";
//        $sql .= " and f_con_ae='" . $f_con_ae . "'";
        // con la de arriba se ve la select entera pero la que dejo es más segura
        $sql .= " WHERE cod_opc=:cod_opc";
        $sql .= " and f_con_ae=:f_con_ae";
//        $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('cod_opc' => $cod_opc, 'f_con_ae' => $f_con_ae));

        $actoEleccion = null;

        if (isset($resultado)) {
            $row = $resultado->fetch();
            $actoEleccion = new ActoEleccion($row);
        }

        return $actoEleccion;
    }

}

?>
