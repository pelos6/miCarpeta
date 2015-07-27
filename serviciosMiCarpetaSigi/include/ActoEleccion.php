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

   
    public function __construct($row) {
        $this->cod_opc = $row['cod_opc'];
        $this->f_con_ae = $row['f_con_ae'];
        $this->cod_tip_ae = $row['cod_tip_ae'];
        $this->tex_opc = $row['tex_opc'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>