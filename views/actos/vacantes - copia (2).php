    <script src="http://maps.googleapis.com/maps/api/js"></script>
    <script src="js/jquery.soap.js"></script>
    <script src="js/codigo.js"></script>
<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

$this->title = 'Vacantes';
$this->params['breadcrumbs'][] = ['label' => 'Actos', 'url' => ['actos']];
$this->params['breadcrumbs'][] = ['label' => Html::encode($_GET["tex_opc"]),
 'url' => ["actos/convocatoria", "cod_opc" => Html::encode($_GET["cod_opc"]),"tex_opc" => Html::encode($_GET["tex_opc"]),"modo" => Html::encode($_GET["modo"])]];
$this->params['breadcrumbs'][] = $this->title;

$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
if (Html::encode($_GET["modo"]) == '1' ) {
  $vacantes = $clienteSigi->getVacantesActo($_GET["cod_opc"]);
  $especialidades = $clienteSigi->getEspecialidadesActo($_GET["cod_opc"]);
} else {
  $vacantes = $clienteSigi->getVacantesSeleccionables($_GET["cod_opc"],Yii::$app->user->identity->dni);
  $especialidades = $clienteSigi->getEspecialidadesSeleccionables($_GET["cod_opc"],Yii::$app->user->identity->dni);
}
?>

 <div id="googleMap" style="width:500px;height:380px;"> </div>
 <!--  <a href="#googleMap" onclick="mostrarActoEleccionMapa('12/05/2015');">Primaria Acto de eleccion 25/05/2015</a> -->
 <?php
        foreach ($vacantes as $vacante) {
           // echo $vacante->num_vac .' '.$vacante->lat.' '.$vacante->lon . "<br />\n" ;
            echo '<input type="hidden" name="cue_esp" value="'.$vacante->cod_cue.' '.$vacante->cod_esp. '">';
            echo '<input type="hidden" name="latitud" value="'.$vacante->lat. '">';
            echo '<input type="hidden" name="longitud" value="'.$vacante->lon. '">';
            echo '<input type="hidden" name="descripcion_centro" value="'.$vacante->des_cen. '">';
            echo '<input type="hidden" name="descripcion_vacante" value="'.$vacante->des_vac. '">';
        }
?>
<div class="alert alert-success">
    <?php
        foreach ($especialidades as $especialidad) {
          // echo '<a href="#googleMap" onclick="mostrarActoEleccionMapa('."'0590 001'".');" >' . $especialidad->cod_cue .' '.$especialidad->cod_esp . "</a><br />\n";
          echo Html::button(' '.$especialidad->cod_cue .' '.$especialidad->cod_esp .' ', [ 'class' => 'btn btn-primary', 'onclick' => 'mostrarActoEleccionMapa("'.$especialidad->cod_cue .' '.$especialidad->cod_esp .'");' ,'hint' => 'hola que tal ' ]) . ' ' ;

          //echo Html::a('especialidades ofertadas', ['#googleMap'], ['class' => 'btn btn-success']) ;
         //  echo $especialidad->cod_cue .' '.$especialidad->cod_esp. "<br />\n" ;
        }
    ?>
</div>