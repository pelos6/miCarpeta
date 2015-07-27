<?php
/**
 * Descripcion de Oposicion
 * 
 * La clase para las oposiciones
 *
 * @author Javier
 */
class Oposicion {

    protected $cod_con;
    protected $des_con;
    protected $cod_tip_con;
    protected $l_act;

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
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>