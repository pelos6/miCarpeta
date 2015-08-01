<?php

/**
 * Description of SolicitudLista
 *
 * @author Javier
 */
class SolicitudLista {

    protected $cod_con;
    protected $des_con;
    protected $cod_sol;
    protected $tipo_id;
    protected $dni;
    protected $cod_est_sol;
    protected $des_est_sol;
    protected $fec_sol;

    function getFec_sol() {
        return $this->fec_sol;
    }

    function setFec_sol($fec_sol) {
        $this->fec_sol = $fec_sol;
    }

        
    function getCod_est_sol() {
        return $this->cod_est_sol;
    }

    function getDes_est_sol() {
        return $this->des_est_sol;
    }

    function setCod_est_sol($cod_est_sol) {
        $this->cod_est_sol = $cod_est_sol;
    }

    function setDes_est_sol($des_est_sol) {
        $this->des_est_sol = $des_est_sol;
    }

    function getCod_sol() {
        return $this->cod_sol;
    }

    function getTipo_id() {
        return $this->tipo_id;
    }

    function getDni() {
        return $this->dni;
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
        $this->cod_est_sol = $row['cod_est_sol'];
        $this->des_est_sol = $row['des_est_sol'];
        $this->fec_sol = $row['fec_sol'];
    }

    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>