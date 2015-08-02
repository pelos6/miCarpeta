<?php

/**
 * Description of DBConcursosPrimaria
 * 
 * Los datos sacados del esquema web de concurso de traslados 
 * Primaria
 *
 * @author Javier
 */
// los php requeridos que son otras clases
require_once('ConcursoTraslados.php');
require_once('SolicitudConcurso.php');

class DBConcursosPrimaria {

// con metodos estaticos dado que no se va a instanciar esta clase
// pasando los valores como array para evitar consultas sin parametrizar
// protected static function ejecutaConsulta($sql) {
    protected static function ejecutaConsulta($sql, $valores = null) {
        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8");
        // desarrollo en local
        $dsn = "mysql:host=localhost;dbname=serviciosmicarpetaconcursosprimaria";
        $usuario = 'root';
        $contrasena = 'javier';
        // para infenlaces
//        $dsn = "mysql:host=localhost;dbname=javieriranzo_dwes";
//        $usuario = 'javieriranzo_dwe';
//        $contrasena = 'javier';
//        // para apostayadrede.com
//        $dsn = "mysql:host=localhost;dbname=c23ctpri";
//        $usuario = 'c23ctpri';
//        $contrasena = 'c23ctpri';
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
     * Devuelve un array con el concurso en las que tiene solicitud
     * el usuario
     * 
     */
    public static function obtieneConcursoHaySolicitud($dni) {
        $sql = " select distinct cod_con , des_con  , cod_tip_con, des_tip_con, l_act, url, f_ini_sol, f_fin_sol, des_fas_con  ";
        $sql .= " from vconcursossolicitud ";
        $sql .= " WHERE dni=:dni ";
        error_log('DEBUG: en obtieneconcursosHaySolicitud primaria ' . $sql . ' ' . $dni);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $concursosHaySolicitud = array();

        if ($resultado) {
            $row = $resultado->fetch();
             //error_log('DEBUG: en obtieneconcursosHaySolicitud resultado true');
            while ($row != null) {
                  //error_log('DEBUG: en obtieneconcursosHaySolicitud en el loop');
                $concursosHaySolicitud[] = new ConcursoTraslados($row);
                $row = $resultado->fetch();
            }
        }

        return $concursosHaySolicitud;
    }



    /**
     * Devuelve un array con las solicitudes a concursos de primaria del
     * usuario
     * 
     */
    public static function obtieneSolicitudesConcurso($cod_con,$dni) {
        $sql = "select dni, cod_con, des_con, cod_sol, cod_est_sol , des_est_sol, f_hor_ent  from vconcursossolicitud ";
        $sql .= " WHERE dni=:dni ";
        $sql .= " and  cod_con=:cod_con ";
        error_log('DEBUG: en obtieneSolicitudesConcurso primaria ' . $sql);
        $resultado = self::ejecutaConsulta($sql, array('cod_con' => $cod_con,'dni' => $dni));
        $solicitudesConcurso = array();

        if ($resultado) {
            // Añadimos un elemento por cada solicitud obtenida
            $row = $resultado->fetch();
            while ($row != null) {
                $solicitudesConcurso[] = new SolicitudConcurso($row);
                $row = $resultado->fetch();
            }
        }
        return $solicitudesConcurso;
    }


    /**
     * Devuelve la información de la solicitud al Concurso de traslados del
     * usuario
     * 
     */
    public static function obtieneSolicitudConcurso($cod_con,$dni,$cod_sol) {
        $sql = "select dni, cod_con, des_con, cod_sol, cod_est_sol, des_est_sol, f_hor_ent  ";
        $sql .= " from vconcursossolicitud  WHERE dni=:dni ";
        $sql .= " and  cod_con=:cod_con ";
        $sql .= " and  cod_sol=:cod_sol ";
        error_log('DEBUG: en obtieneSolicitudConcurso ' . $sql.' '.$cod_con.' '.$cod_sol . ' '. $dni);
        $resultado = self::ejecutaConsulta($sql, array('cod_con' => $cod_con,'dni' => $dni, 'cod_sol' => $cod_sol));
        $row = $resultado->fetch();
        $solicitudConcurso = new SolicitudConcurso($row);
        return $solicitudConcurso;
    }


    /**
     * Devuelve un array con los concursos de traslados que estan activos
     * 
     */
    public static function obtieneConcursosActivos() {
        $sql = "SELECT cod_con , des_con  , cod_tip_con, des_tip_con, l_act, url, f_ini_sol, f_fin_sol, des_fas_con ";
        $sql .= "  FROM vconcursosactivos ";
        error_log('DEBUG: en obtieneConcursosActivos Primaria ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $concursosActivos = array();

        if ($resultado) {
            // error_log('DEBUG: en obtieneConcursosActivos Primaria resultado true');
            $row = $resultado->fetch();
            while ($row != null) {
                $concursosActivos[] = new ConcursoTraslados($row);
                $row = $resultado->fetch();
            }
        }
        return $concursosActivos;
    }


     /**
     * Devuelve la informacion del concurso seleccionado
     * 
     */
    public static function obtieneConcursoActivo($cod_con) {
        $sql = "SELECT cod_con , des_con  ,f_ini_sol, f_fin_sol,cod_tip_con, des_tip_con,l_act, url, des_fas_con   ";
         $sql .= " FROM vconcursosactivos";
        $sql .= " WHERE cod_con=:cod_con ";
        error_log('DEBUG: en obtieneConcursoActivo Primaria ' . $sql . ' '. $cod_con);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('cod_con' => $cod_con));  

        if ($resultado) {
            $row = $resultado->fetch();
            $concursoActivo = new ConcursoTraslados($row);
        }
        return $concursoActivo;
    }


}

?>
