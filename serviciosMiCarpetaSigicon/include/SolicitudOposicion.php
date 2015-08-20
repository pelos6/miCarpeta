<?php

/**
 * Description of SolicitudOposicion
 *
 * @author Javier
 */
class SolicitudOposicion {

    protected $cod_con;
    protected $des_con;
    protected $des_cue;
    protected $des_esp;
    protected $des_cue_esp;
    protected $cod_sol;
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

    function setCod_cue($cod_cue) {
        $this->cod_cue = $cod_cue;
    }

    function setDes_cue($des_cue) {
        $this->des_cue = $des_cue;
    }

    function setCod_esp($cod_esp) {
        $this->cod_esp = $cod_esp;
    }

    function setDes_esp($des_esp) {
        $this->des_esp = $des_esp;
    }

    function setCod_cue_esp($cod_cue_esp) {
        $this->cod_cue_esp = $cod_cue_esp;
    }

    function setDes_cue_esp($des_cue_esp) {
        $this->des_cue_esp = $des_cue_esp;
    }


    public function __construct($row) {
        $this->cod_con = $row['cod_con'];
        $this->des_con = $row['des_con'];
        $this->des_cue = $row['des_cue'];
        $this->des_esp = $row['des_esp'];
        $this->des_cue_esp = $row['des_cue_esp'];
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