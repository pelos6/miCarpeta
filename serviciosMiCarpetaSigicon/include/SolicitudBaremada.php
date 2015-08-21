<?php

/**
 * Descripcion de SolicitudBaremada
 *
 * @author Javier
 */
class SolicitudBaremada {

    protected $cod_con;
    protected $cod_sol;
    protected $dni;
    protected $res_tot;
    protected $apa_1;
    protected $apa_2;
    protected $apa_3;
    protected $apa_1_1;
    protected $apa_1_2;
    protected $apa_1_3;
    protected $apa_1_4;
    protected $apa_2_1;
    protected $apa_2_2;
    protected $apa_2_3;
    protected $apa_2_4;
    protected $apa_3_1;
    protected $apa_3_2;
    protected $apa_3_3;
    protected $apa_3_4;

    function getRes_tot() {
        return $this->res_tot;
    }

    function setRes_tot($res_tot) {
        $this->res_tot = $res_tot;
    }

    function getCod_sol() {
        return $this->cod_sol;
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

    function getApa_1() {
        return $this->apa_1;
    }

    function getApa_2() {
        return $this->apa_2;
    }

    function getApa_3() {
        return $this->apa_3;
    }

    function getApa_1_1() {
        return $this->apa_1_1;
    }

    function getApa_1_2() {
        return $this->apa_1_2;
    }

    function getApa_1_3() {
        return $this->apa_1_3;
    }

    function getApa_2_1() {
        return $this->apa_2_1;
    }

    function getApa_2_2() {
        return $this->apa_2_2;
    }

    function getApa_2_3() {
        return $this->apa_2_3;
    }

    function getApa_3_1() {
        return $this->apa_3_1;
    }

    function getApa_3_2() {
        return $this->apa_3_2;
    }

    function getApa_3_3() {
        return $this->apa_3_3;
    }

    function setApa_1($apa_1) {
        $this->apa_1 = $apa_1;
    }

    function setApa_2($apa_2) {
        $this->apa_2 = $apa_2;
    }

    function setApa_3($apa_3) {
        $this->apa_3 = $apa_3;
    }

    function setApa_1_1($apa_1_1) {
        $this->apa_1_1 = $apa_1_1;
    }

    function setApa_1_2($apa_1_2) {
        $this->apa_1_2 = $apa_1_2;
    }

    function setApa_1_3($apa_1_3) {
        $this->apa_1_3 = $apa_1_3;
    }

    function setApa_2_1($apa_2_1) {
        $this->apa_2_1 = $apa_2_1;
    }

    function setApa_2_2($apa_2_2) {
        $this->apa_2_2 = $apa_2_2;
    }

    function setApa_2_3($apa_2_3) {
        $this->apa_2_3 = $apa_2_3;
    }

    function setApa_3_1($apa_3_1) {
        $this->apa_3_1 = $apa_3_1;
    }

    function setApa_3_2($apa_3_2) {
        $this->apa_3_2 = $apa_3_2;
    }

    function setApa_3_3($apa_3_3) {
        $this->apa_3_3 = $apa_3_3;
    }

    function getCod_con() {
        return $this->cod_con;
    }

    function setCod_con($cod_con) {
        $this->cod_con = $cod_con;
    }

    function getApa_1_4() {
        return $this->apa_1_4;
    }

    function getApa_2_4() {
        return $this->apa_2_4;
    }

    function getApa_3_4() {
        return $this->apa_3_4;
    }

    function setApa_1_4($apa_1_4) {
        $this->apa_1_4 = $apa_1_4;
    }

    function setApa_2_4($apa_2_4) {
        $this->apa_2_4 = $apa_2_4;
    }

    function setApa_3_4($apa_3_4) {
        $this->apa_3_4 = $apa_3_4;
    }

        public function __construct($row) {
        $this->cod_con = $row['cod_con'];
        $this->cod_sol = $row['cod_sol'];
        $this->dni = $row['dni'];
        $this->res_tot = $row['res_tot'];
        $this->apa_1 = $row['apa_1'];
        $this->apa_2 = $row['apa_2'];
        $this->apa_3 = $row['apa_3'];
        $this->apa_1_1 = $row['apa_1_1'];
        $this->apa_1_2 = $row['apa_1_3'];
        $this->apa_1_3 = $row['apa_1_2'];
        $this->apa_2_1 = $row['apa_2_1'];
        $this->apa_2_2 = $row['apa_2_3'];
        $this->apa_2_3 = $row['apa_2_2'];
        $this->apa_3_1 = $row['apa_3_1'];
        $this->apa_3_2 = $row['apa_3_3'];
        $this->apa_3_3 = $row['apa_3_2'];
        $this->apa_1_4 = $row['apa_1_4'];
        $this->apa_2_4 = $row['apa_2_4'];
        $this->apa_3_4 = $row['apa_3_4'];
    }

    public function muestra() {
        print "<p>" . $this->cod_con . "</p>";
    }

}

?>