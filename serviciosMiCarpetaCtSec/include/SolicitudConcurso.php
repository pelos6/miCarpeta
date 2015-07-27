<?php
/**
 * Descripcion de SolicitudConcurso
 *
 * @author Javier
 */
class SolicitudConcurso {

    protected $cod_con;
    protected $des_con;
    protected $cod_sol;
    protected $dni;
    protected $estado;
    protected $fechagrabacion;
    

    function getFechagrabacion() {
        return $this->fechagrabacion;
    }

    function setFechagrabacion($fechagrabacion) {
        $this->fechagrabacion = $fechagrabacion;
    }

        
    function getCod_sol() {
        return $this->cod_sol;
    }
    
    function getDni() {
        return $this->dni;
    }

    function getEstado() {
        return $this->estado;
    }

  
    function setCod_sol($cod_sol) {
        $this->cod_sol = $cod_sol;
    }

    function setDni($dni) {
        $this->dni = $dni;
    }

    function setEstado($estado) {
        $this->estado = $estado;
    }
 
    function getCod_con() {
        return $this->cod_con;
    }

    function getDes_con() {
        return $this->des_con;
    }

    function setCod_con($cod_con) {
        $this->cod_con = $cod_con;
    }

    function setDes_con($des_con) {
        $this->des_con = $des_con;
    }

            
    public function __construct($row) {
        $this->cod_con = $row['cod_con'];
        $this->des_con = $row['des_con'];
        $this->cod_sol = $row['cod_sol'];
        $this->dni = $row['dni'];
        $this->estado = $row['estado'];
        $this->fechagrabacion = $row['fechagrabacion'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>