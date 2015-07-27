<?php

/**
 * Description of DBConcursos
 * 
 * Los datos sacados del esquema web de concurso de traslados 
 * de secundaria
 *
 * @author Javier
 */
// los php requeridos que son otras clases
require_once('ConcursoTraslados.php');
require_once('SolicitudConcurso.php');

class DBConcursosSecundaria {

// con metodos estaticos dado que no se va a instanciar esta clase
// pasando los valores como array para evitar consultas sin parametrizar
// protected static function ejecutaConsulta($sql) {
    protected static function ejecutaConsulta($sql, $valores = null) {
        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8");
        $dsn = "mysql:host=localhost;dbname=serviciosmicarpetaconcursossecundaria";
        $usuario = 'root';
        $contrasena = 'javier';
        // para infenlaces
//        $dsn = "mysql:host=localhost;dbname=javieriranzo_dwes";
//        $usuario = 'javieriranzo_dwe';
//        $contrasena = 'javier';
//       // para apostayadrede.com
//        $dsn = "mysql:host=localhost;dbname=c23ctsec";
//        $usuario = 'c23ctsec';
//        $contrasena = 'c23ctsec';
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
     * Devuelve un array con las solicitudes a concursod de traslados del
     * usuario
     * 
     */
    public static function obtieneSolicitudesConcursos($dni) {
        $sql = "select dni, cod_con, des_con, cod_sol, estado, fechagrabacion  from vsolicitudesconcursos ";
        $sql .= " WHERE dni=:dni ";
        error_log('DEBUG: en obtieneSolicitudesConcursos secundaria ' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, array('dni' => $dni));
        $solicitudesConcursos = array();

        if ($resultado) {
             error_log('DEBUG: en obtieneSolicitudesConcursos Secundaria True' . $dni);
            // Añadimos un elemento por cada solicitud obtenida
            $row = $resultado->fetch();
            while ($row != null) {
                $solicitudesConcursos[] = new SolicitudConcurso($row);
                $row = $resultado->fetch();
            }
        }
        return $solicitudesConcursos;
    }

    /**
     * Devuelve un array con los concursos de traslados que estan activos
     * 
     */
    public static function obtieneConcursosActivos() {
       // error_log('DEBUG: en obtieneConcursosActivos Secundaria');
        $sql = "SELECT cod_con , des_con  , cod_tip_con,l_act, url, des_fas   FROM vconcursosactivos;";
        error_log('DEBUG: en obtieneConcursosActivos Secundaria' . $sql);
        // $resultado = self::ejecutaConsulta($sql);
        $resultado = self::ejecutaConsulta($sql, null);
        $concursosActivos = array();

        if ($resultado) {
            //error_log('DEBUG: en obtieneConcursosActivos resultado true');
            $row = $resultado->fetch();
            while ($row != null) {
                $concursosActivos[] = new ConcursoTraslados($row);
                $row = $resultado->fetch();
            }
        }
        return $concursosActivos;
    }

}

?>
