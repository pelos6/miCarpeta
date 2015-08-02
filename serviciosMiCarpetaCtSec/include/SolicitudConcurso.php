<?php
/**
 * Descripcion de SolicitudConcurso
 *
 * @author Javier
 */
class SolicitudConcurso {

    protected $cod_con;
    protected $des_con;
    protected $cod_sol;
    protected $dni;
    protected $des_est_sol;
    protected $f_hor_ent;
    

    function getF_hor_ent() {
        return $this->f_hor_ent;
    }

    function setF_hor_ent($f_hor_ent) {
        $this->f_hor_ent = $f_hor_ent;
    }

        
    function getCod_sol() {
        return $this->cod_sol;
    }

    function getDni() {
        return $this->dni;
    }

    function getDes_est_sol() {
        return $this->des_est_sol;
    }

  
    function setCod_sol($cod_sol) {
        $this->cod_sol = $cod_sol;
    }

    function setDni($dni) {
        $this->dni = $dni;
    }

    function setDes_est_sol($des_est_sol) {
        $this->des_est_sol = $des_est_sol;
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
        $this->cod_sol = $row['cod_sol'];
        $this->dni = $row['dni'];
        $this->des_est_sol = $row['des_est_sol'];
        $this->f_hor_ent = $row['f_hor_ent'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>