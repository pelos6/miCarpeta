<?php
/**
 * Descripcion de la vacante
 *
 * @author Javier
 */
class Vacante {

    protected $cod_opc;
    protected $num_vac;
    protected $cod_cue;
    protected $cod_esp;
    protected $lat;
    protected $lon;
    protected $cod_cen;
    protected $des_cen;

    function getDes_cen() {
        return $this->des_cen;
    }

    function setdDes_cen($des_cen) {
        $this->des_cen = $des_cen;
    }
    
    function getCod_cen() {
        return $this->cod_cen;
    }

    function setCod_cen($cod_cen) {
        $this->cod_cen = $cod_cen;
    }

    function getCod_opc() {
        return $this->cod_opc;
    }

    function setCod_opc($cod_opc) {
        $this->cod_opc = $cod_opc;
    }

    function getCod_cue() {
        return $this->cod_cue;
    }

    function setCod_cue($cod_cue) {
        $this->cod_cue = $cod_cue;
    }

    function getCod_esp() {
        return $this->cod_esp;
    }

    function setCod_esp($cod_esp) {
        $this->cod_esp = $cod_esp;
    }

    function getLat() {
        return $this->lat;
    }

    function setLat($lat) {
        $this->lat = $lat;
    }

    function getLon() {
        return $this->lon;
    }

    function setLon($lon) {
        $this->lon = $lon;
    }
        
    public function __construct($row) {
        $this->cod_opc = $row['cod_opc'];
        $this->num_vac = $row['num_vac'];
        $this->cod_cue = $row['cod_cue'];
        $this->cod_esp = $row['cod_esp'];
        $this->lat = $row['lat'];
        $this->lon = $row['lon'];
        $this->cod_cen = $row['cod_cen'];
        $this->des_cen = $row['des_cen'];
    }
    
    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>