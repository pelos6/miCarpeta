<?php
/**
 * Descripcion de ActoElección
 * 
 * La clase para los actos de elección
 *
 * @author Javier
 */
class ActoEleccion {

    protected $cod_opc;
    protected $f_con_ae;
    protected $cod_tip_ae;
    protected $tex_opc;
    protected $f_ini_opc;
    protected $f_fin_opc;
    protected $url;

    function getCod_opc() {
        return $this->cod_opc;
    }

    function getF_con_ae() {
        return $this->f_con_ae;
    }

    function setCod_opc($cod_opc) {
        $this->cod_opc = $cod_opc;
    }


    function setF_con_ae($f_con_ae) {
        $this->f_con_ae = $f_con_ae;
    }


    function getF_ini_opc() {
        return $this->f_ini_opc;
    }

    function setF_ini_opc($f_ini_opc) {
        $this->f_ini_ae = $f_ini_opc;
    }

    function getF_fin_opc() {
        return $this->f_fin_opc;
    }

    function setF_fin_opc($f_fin_opc) {
        $this->f_fin_opc = $f_fin_opc;
    }

    function setUrl($url) {
        $this->url = $url;
    }

      function getUrl() {
        return $this->url;
    }

   
    public function __construct($row) {
        $this->cod_opc = $row['cod_opc'];
        $this->f_con_ae = $row['f_con_ae'];
        $this->cod_tip_ae = $row['cod_tip_ae'];
        $this->tex_opc = $row['tex_opc'];
        $this->f_ini_opc = $row['f_ini_opc'];
        $this->f_fin_opc = $row['f_fin_opc'];
        $this->url = $row['url'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>