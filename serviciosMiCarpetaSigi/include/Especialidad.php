<?php
/**
 * Descripcion de la especialidad
 *
 * @author Javier
 */
class Especialidad {


    protected $cod_cue;
    protected $cod_esp;
   
   
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

        
    public function __construct($row) {
        $this->cod_cue = $row['cod_cue'];
        $this->cod_esp = $row['cod_esp'];
    
    }
    
    public function muestra() {
        print "<p>" . $this->cod_cue . "</p>";
    }

}

?>