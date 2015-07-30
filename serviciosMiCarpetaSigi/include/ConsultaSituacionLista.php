<?php

// la clase producto
// de la que hereda ordenador
class ConsultaSituacionLista {

    protected $cod_opc;
    protected $tex_opc;
    protected $url;

    function getTex_opc() {
        return $this->tex_opc;
    }

    function getUrl() {
        return $this->url;
    }

    function setTex_opc($tex_opc) {
        $this->tex_opc = $tex_opc;
    }

    function setUrl($url) {
        $this->url = $url;
    }

    function getCod_opc() {
        return $this->cod_opc;
    }

    function setCod_opc($cod_opc) {
        $this->cod_opc = $cod_opc;
    }

    public function __construct($row) {
        $this->cod_opc = $row['cod_opc'];
        $this->tex_opc = $row['tex_opc'];
        $this->url = $row['url'];
    }

    public function muestra() {
        print "<p>" . $this->cod_opc . "</p>";
    }

}

?>