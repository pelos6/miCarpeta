<?php
/**
 * Descripcion de SolicitudActo
 *
 * @author Javier
 */
class SolicitudActo {

    protected $cod_opc;
    protected $tex_con;
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
 

    function getCod_opc() {
        return $this->cod_opc;
    }

    function getTex_con() {
        return $this->tex_con;
    }

    function setCod_opc($cod_opc) {
        $this->cod_opc = $cod_opc;
    }

    function setTex_con($tex_con) {
        $this->tex_con = $tex_con;
    }

    
        
    public function __construct($row) {
        $this->cod_opc = $row['cod_opc'];
        $this->tex_opc = $row['tex_opc'];
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