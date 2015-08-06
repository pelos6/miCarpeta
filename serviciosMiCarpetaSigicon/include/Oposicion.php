<?php

// la clase Oposicion
// 
class Oposicion {

    protected $cod_con;
    protected $des_con;
    protected $cod_tip_con;
    protected $l_act;
    protected $f_pub;
    protected $f_res;
    protected $f_ini_sol;
    protected $f_fin_sol;
    protected $url;
    
    function getF_ini_sol() {
        return $this->f_ini_sol;
    }

    function getUrl() {
        return $this->url;
    }

    function setF_ini_sol($f_ini_sol) {
        $this->f_ini_sol = $f_ini_sol;
    }

    function setUrl($url) {
        $this->url = $url;
    }

    function getF_pub() {
        return $this->f_pub;
    }

    function getF_res() {
        return $this->f_res;
    }

    function getF_fin_sol() {
        return $this->f_fin_sol;
    }

    function setF_pub($f_pub) {
        $this->f_pub = $f_pub;
    }

    function setF_res($f_res) {
        $this->f_res = $f_res;
    }

    function setF_fin_sol($f_fin_sol) {
        $this->f_fin_sol = $f_fin_sol;
    }
    
    function getCod_con() {
        return $this->cod_con;
    }

    function getDes_con() {
        return $this->des_con;
    }

    function getCod_tip_con() {
        return $this->cod_tip_con;
    }

    function getL_act() {
        return $this->l_act;
    }

    function setCod_con($cod_con) {
        $this->cod_con = $cod_con;
    }

    function setDes_con($des_con) {
        $this->des_con = $des_con;
    }

    function setCod_tip_con($cod_tip_con) {
        $this->cod_tip_con = $cod_tip_con;
    }

    function setL_act($l_act) {
        $this->l_act = $l_act;
    }
   
    public function __construct($row) {
        $this->cod_con = $row['cod_con'];
        $this->des_con = $row['des_con'];
        $this->cod_tip_con = $row['cod_tip_con'];
        $this->l_act = $row['l_act'];
        $this->f_res = $row['f_res'];
        $this->f_pub = $row['f_pub'];
        $this->f_ini_sol = $row['f_ini_sol'];
        $this->f_fin_sol = $row['f_fin_sol'];
        $this->url = $row['url'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_con . "</p>";
    }

}

?>