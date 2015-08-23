<?php

/**
 * Description of DBConcursosSecundaria
 * 
 * Los datos sacados del esquema web de concurso de traslados 
 * Secundaria
 *
 * @author Javier
 */
// los php requeridos que son otras clases
require_once('ConcursoTraslados.php');
require_once('SolicitudConcurso.php');
require_once('SolicitudBaremada.php');

class DBConcursosSecundaria {

// con metodos estaticos dado que no se va a instanciar esta clase
// pasando los valores como array para evitar consultas sin parametrizar
// protected static function ejecutaConsulta($sql) {
    protected static function ejecutaConsulta($sql, $valores = null) {
        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8");
        // desarrollo en local
        $dsn = "mysql:host=localhost;dbname=serviciosmicarpetaconcursossecundaria";
        $usuario = 'root';
        $contrasena = 'javier';
        // para infenlaces
//        $dsn = "mysql:host=localhost;dbname=javieriranzo_dwes";
//        $usuario = 'javieriranzo_dwe';
//        $contrasena = 'javier';
//        // para apostayadrede.com
/*        $dsn = "mysql:host=localhost;dbname=c23ctsec";
        $usuario = 'c23ctsec';
        $contrasena = 'c23ctsec'; */
        $dwes = new PDO($dsn, $usuario, $contrasena, $opc);
        $resultado = null;
//        if (isset($dwes)) {
//            $resultado = $dwes->query($sql);
//        }
        if (isset($dwes)) {
            $resultado = $dwes->prepare($sql);
            try {
                $resultado->execute($valores);
            } catch  (PDOException $e) {
                 error_log ("DEBUG: ". $e->getMessage() );
                }
        }
        return $resultado;
    }
    
 /**
     * Devuelve el baremo de la solicitud en esa convocatoria del
     * usuario
     * 
     */
    public static function obtieneSolicitudConcursoBaremada($cod_con,$dni,$cod_sol) {
        $sql = " select cod_con, cod_sol, dni, res_tot, apa_1, apa_1_1, apa_1_1_1, apa_1_1_2, apa_1_1_3, apa_1_2, apa_1_2_1, apa_1_2_2, apa_1_2_3, apa_2, apa_3, apa_3_1, apa_3_1_1, apa_3_1_2, apa_3_1_3, apa_3_1_4, apa_3_2, apa_3_2_1, apa_3_2_2, apa_3_2_3, apa_3_2_4, apa_3_3, apa_4, apa_4_1, apa_4_2, apa_4_3, apa_5, apa_5_1, apa_5_2, apa_5_3, apa_6, apa_6_1, apa_6_2, apa_6_3, apa_6_4, apa_6_5, apa_6_6  ";
        $sql .= " from vsolicitudesbaremadas  WHERE cod_con=:cod_con ";
        $sql .= " and dni=:dni ";
        $sql .= " and cod_sol=:cod_sol ";
        error_log('DEBUG: en obtieneSolicitudConcursoBaremada Secundaria ' . $sql . ' ' . $dni. ' ' . $cod_sol. ' ' . $cod_con);
        $resultado = self::ejecutaConsulta($sql,array('cod_con' => $cod_con, 'dni' => $dni, 'cod_sol' => $cod_sol));
          if ($resultado) {
            //error_log('DEBUG: en obtieneBaremoSolicitudConvocatoriaListas resultado true ');
            // Añadimos un elemento por el resultado obtenido
            $row = $resultado->fetch();
                $solicitudBaremada = new SolicitudBaremada($row);
        }
        return $solicitudBaremada;
    }

 /**
     * Devuelve la información de si esta baremada la solicitud
     * del usuario
     * 
     */
    public static function obtieneHaySolicitudConcursoBaremada($cod_con,$dni,$cod_sol) {
        $sql = " select cod_con, cod_sol, dni, res_tot, apa_1, apa_1_1, apa_1_1_1, apa_1_1_2, apa_1_1_3, apa_1_2, apa_1_2_1, apa_1_2_2, apa_1_2_3, apa_2, apa_3, apa_3_1, apa_3_1_1, apa_3_1_2, apa_3_1_3, apa_3_1_4, apa_3_2, apa_3_2_1, apa_3_2_2, apa_3_2_3, apa_3_2_4, apa_3_3, apa_4, apa_4_1, apa_4_2, apa_4_3, apa_5, apa_5_1, apa_5_2, apa_5_3, apa_6, apa_6_1, apa_6_2, apa_6_3, apa_6_4, apa_6_5, apa_6_6  ";
        $sql .= " from vsolicitudesbaremadas  WHERE cod_con=:cod_con ";
        $sql .= " and dni=:dni ";
        $sql .= " and cod_sol=:cod_sol ";
        error_log('DEBUG: en obtieneHaySolicitudConcursoBaremada Secundaria ' . $sql . ' ' . $dni. ' ' . $cod_sol. ' ' . $cod_con);
        $resultado = self::ejecutaConsulta($sql,array('cod_con' => $cod_con, 'dni' => $dni, 'cod_sol' => $cod_sol));
         if ($resultado) {
            $row = $resultado->fetch();
            while ($row != null) {
              //  error_log('DEBUG: en obtieneHaySolicitudConvocatoriaListasBaremada resultado true ');
                return true;
            }
        }
       // error_log('DEBUG: en obtieneHaySolicitudConvocatoriaListasBaremada resultado false ');
        return false;
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
        error_log('DEBUG: en obtieneconcursosHaySolicitud Secundaria ' . $sql . ' ' . $dni);
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
     * Devuelve un array con las solicitudes a concursos de Secundaria del
     * usuario
     * 
     */
    public static function obtieneSolicitudesConcurso($cod_con,$dni) {
        $sql = "select dni, cod_con, des_con, cod_sol, cod_est_sol , des_est_sol, f_hor_ent,des_mod_par  from vconcursossolicitud ";
        $sql .= " WHERE dni=:dni ";
        $sql .= " and  cod_con=:cod_con ";
        error_log('DEBUG: en obtieneSolicitudesConcurso Secundaria ' . $sql);
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
        error_log('DEBUG: en obtieneConcursosActivos Secundaria ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $concursosActivos = array();

        if ($resultado) {
            // error_log('DEBUG: en obtieneConcursosActivos Secundaria resultado true');
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
        error_log('DEBUG: en obtieneConcursoActivo Secundaria ' . $sql . ' '. $cod_con);
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
