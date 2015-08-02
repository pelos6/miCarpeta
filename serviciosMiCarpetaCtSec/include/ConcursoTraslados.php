<?php
/**
 * Descripcion de ConcursoTraslado
 * 
 * La clase para los concursos de traslados
 *
 * @author Javier
 */
class ConcursoTraslados {

    protected $cod_con;
    protected $des_tip_con; 
    protected $des_con;
    protected $f_ini_sol;
    protected $f_fin_sol;
    protected $cod_tip_con;
    protected $l_act;
    protected $url;
    protected $des_fas_con;



    function getF_ini_sol() {
        return $this->f_ini_sol;
    }

      function setF_ini_sol($f_ini_sol) {
        $this->f_ini_sol = $f_ini_sol;
    }

      function getF_fin_sol() {
        return $this->f_fin_sol;
    }

      function setF_fin_sol($f_fin_sol) {
        $this->f_fin_sol = $f_fin_sol;
    }

    function getUrl() {
        return $this->url;
    }

    function setUrl($url) {
        $this->url = $url;
    }

        
    function getCod_con() {
        return $this->cod_con;
    }

    function getCod_tip_con() {
        return $this->cod_tip_con;
    }

    function getDes_con() {
        return $this->des_con;
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

    function setDes_tip_con($des_tip_con) {
        $this->des_tip_con = $des_tip_con;
    }

    function setL_act($l_act) {
        $this->l_act = $l_act;
    }

    function getDes_fas_con() {
        return $this->des_fas_con;
    }

    function setDes_fas_con($des_fas_con) {
        $this->des_fas_con = $des_fas_con;
    }

        
    public function __construct($row) {
        $this->cod_con = $row['cod_con'];
        $this->des_con = $row['des_con'];
        $this->des_tip_con = $row['des_tip_con'];
        $this->cod_tip_con = $row['cod_tip_con'];
        $this->l_act = $row['l_act'];
        $this->url = $row['url'];
        $this->des_fas_con = $row['des_fas_con'];
        $this->f_ini_sol = $row['f_ini_sol'];
        $this->f_fin_sol = $row['f_fin_sol'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>