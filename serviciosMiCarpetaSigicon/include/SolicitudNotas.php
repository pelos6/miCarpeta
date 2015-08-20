<?php

/**
 * Descripcion de las notas en una Solicitud
 *
 * @author Javier
 */
class SolicitudNotas {

    protected $cod_con;
    protected $cod_cue;
    protected $cod_esp;
    protected $cod_acc;
    protected $cod_sol;
    protected $dni;
    protected $res_tot_opo;
    protected $pru_1_a_not;
    protected $pru_2_a_not;
    protected $pru_1_b_not;
    protected $pru_2_b_not;
    protected $pru_1_a_pon;
    protected $pru_2_a_pon;
    protected $pru_1_b_pon;
    protected $pru_2_b_pon;
    protected $sup;
    protected $res_tot_con;

    function getCod_con() {
        return $this->cod_con;
    }

    function getCod_cue() {
        return $this->cod_cue;
    }

    function getCod_esp() {
        return $this->cod_esp;
    }

    function getCod_acc() {
        return $this->cod_acc;
    }

    function getCod_sol() {
        return $this->cod_sol;
    }

    function getDni() {
        return $this->dni;
    }

    function getRes_tot_opo() {
        return $this->res_tot_opo;
    }

    function getPru_1_a_not() {
        return $this->pru_1_a_not;
    }

    function getPru_2_a_not() {
        return $this->pru_2_a_not;
    }

    function getPru_1_b_not() {
        return $this->pru_1_b_not;
    }

    function getPru_2_b_not() {
        return $this->pru_2_b_not;
    }

    function getPru_1_a_pon() {
        return $this->pru_1_a_pon;
    }

    function getPru_2_a_pon() {
        return $this->pru_2_a_pon;
    }

    function getPru_1_b_pon() {
        return $this->pru_1_b_pon;
    }

    function getPru_2_b_pon() {
        return $this->pru_2_b_pon;
    }

    function getSup() {
        return $this->sup;
    }

    function getRes_tot_con() {
        return $this->res_tot_con;
    }

    function setCod_con($cod_con) {
        $this->cod_con = $cod_con;
    }

    function setCod_cue($cod_cue) {
        $this->cod_cue = $cod_cue;
    }

    function setCod_esp($cod_esp) {
        $this->cod_esp = $cod_esp;
    }

    function setCod_acc($cod_acc) {
        $this->cod_acc = $cod_acc;
    }

    function setCod_sol($cod_sol) {
        $this->cod_sol = $cod_sol;
    }

    function setDni($dni) {
        $this->dni = $dni;
    }

    function setRes_tot_opo($res_tot_opo) {
        $this->res_tot_opo = $res_tot_opo;
    }

    function setPru_1_a_not($pru_1_a_not) {
        $this->pru_1_a_not = $pru_1_a_not;
    }

    function setPru_2_a_not($pru_2_a_not) {
        $this->pru_2_a_not = $pru_2_a_not;
    }

    function setPru_1_b_not($pru_1_b_not) {
        $this->pru_1_b_not = $pru_1_b_not;
    }

    function setPru_2_b_not($pru_2_b_not) {
        $this->pru_2_b_not = $pru_2_b_not;
    }

    function setPru_1_a_pon($pru_1_a_pon) {
        $this->pru_1_a_pon = $pru_1_a_pon;
    }

    function setPru_2_a_pon($pru_2_a_pon) {
        $this->pru_2_a_pon = $pru_2_a_pon;
    }

    function setPru_1_b_pon($pru_1_b_pon) {
        $this->pru_1_b_pon = $pru_1_b_pon;
    }

    function setPru_2_b_pon($pru_2_b_pon) {
        $this->pru_2_b_pon = $pru_2_b_pon;
    }

    function setSup($sup) {
        $this->sup = $sup;
    }

    function setRes_tot_con($res_tot_con) {
        $this->res_tot_con = $res_tot_con;
    }

    public function __construct($row) {
        $this->cod_con = $row['cod_con'];
        $this->cod_cue = $row['cod_cue'];
        $this->cod_esp = $row['cod_esp'];
        $this->cod_acc = $row['cod_acc'];
        $this->cod_sol = $row['cod_sol'];
        $this->dni = $row['dni'];
        $this->res_tot_opo = $row['res_tot_opo'];
        $this->pru_1_a_not = $row['pru_1_a_not'];
        $this->pru_2_a_not = $row['pru_2_a_not'];
        $this->pru_1_b_not = $row['pru_1_b_not'];
        $this->pru_2_b_not = $row['pru_2_b_not'];
        $this->pru_1_a_pon = $row['pru_1_a_pon'];
        $this->pru_2_a_pon = $row['pru_2_a_pon'];
        $this->pru_1_b_pon = $row['pru_1_b_pon'];
        $this->pru_2_b_pon = $row['pru_2_b_pon'];
        $this->sup = $row['sup'];
        $this->res_tot_con = $row['res_tot_con'];
    }

    public function muestra() {
        print "<p>" . $this->cod_con . "</p>";
    }

}

?>