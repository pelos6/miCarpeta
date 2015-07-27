<?php
/**
 * Descripcion de SolicitudOposicion
 *
 * @author Javier
 */
class SolicitudOposicion {

    protected $cod_con;
    protected $des_con;
    protected $cod_sol;
    protected $tipo_id;
    protected $dni;
    protected $estado;
    

    function getCod_sol() {
        return $this->cod_sol;
    }

    function getTipo_id() {
        return $this->tipo_id;
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

    function setTipo_id($tipo_id) {
        $this->tipo_id = $tipo_id;
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
        $this->tipo_id = $row['tipo_id'];
        $this->cod_sol = $row['cod_sol'];
        $this->dni = $row['dni'];
        $this->estado = $row['estado'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>