<?php
/**
 * Descripcion de SolicitudActo
 *
 * @author Javier
 */
class SolicitudActo {

    protected $cod_opc;
    protected $tex_opc;
    protected $cod_sol;
    protected $dni;
    protected $cod_est_sol;
    protected $des_est_sol;
    protected $f_hor_ent;
    

    function getCod_sol() {
        return $this->cod_sol;
    }

    function getDes_est_sol() {
        return $this->des_est_sol;
    }
    
     function getF_hor_ent() {
        return $this->f_hor_ent;
    }

    function getDni() {
        return $this->dni;
    }

    function getcod_est_sol() {
        return $this->cod_est_sol;
    }

  
    function setCod_sol($cod_sol) {
        $this->cod_sol = $cod_sol;
    }


    function setDni($dni) {
        $this->dni = $dni;
    }

    function setCod_est_sol($cod_est_sol) {
        $this->cod_est_sol = $cod_est_sol;
    }

        function setDes_est_sol($des_est_sol) {
        $this->des_est_sol = $des_est_sol;
    }

        function setF_hor_ent($f_hor_ent) {
        $this->f_hor_ent = $f_hor_ent;
    }
 
    function getCod_opc() {
        return $this->cod_opc;
    }

    function getTex_opc() {
        return $this->tex_opc;
    }

    function setCod_opc($cod_opc) {
        $this->cod_opc = $cod_opc;
    }

    function setTex_opc($tex_opc) {
        $this->tex_opc = $tex_opc;
    }

    
        
    public function __construct($row) {
        $this->cod_opc = $row['cod_opc'];
        $this->tex_opc = $row['tex_opc'];
        $this->cod_sol = $row['cod_sol'];
        $this->dni = $row['dni'];
        $this->cod_est_sol = $row['cod_est_sol'];
        $this->des_est_sol = $row['des_est_sol'];
        $this->f_hor_ent = $row['f_hor_ent'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>