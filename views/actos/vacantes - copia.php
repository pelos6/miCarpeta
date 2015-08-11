    <script src="http://maps.googleapis.com/maps/api/js"></script>
    <script src="js/codigo.js"></script>
<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

$this->title = 'Vacantes';
$this->params['breadcrumbs'][] = ['label' => 'Actos', 'url' => ['actos']];
$this->params['breadcrumbs'][] = ['label' => Html::encode($_GET["tex_opc"]),
 'url' => ["actos/convocatoria", "cod_opc" => Html::encode($_GET["cod_opc"]),"tex_opc" => Html::encode($_GET["tex_opc"])]];
$this->params['breadcrumbs'][] = $this->title;

$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
$vacantesActo = $clienteSigi->getVacantesActo($_GET["cod_opc"]);
$especialidadesActo = $clienteSigi->getEspecialidadesActo($_GET["cod_opc"]);

?>

 <div id="googleMap" style="width:500px;height:380px;"> </div>
 <!--  <a href="#googleMap" onclick="mostrarActoEleccionMapa('12/05/2015');">Primaria Acto de eleccion 25/05/2015</a> -->
 <?php
        foreach ($vacantesActo as $vacanteActo) {
           // echo $vacanteActo->num_vac .' '.$vacanteActo->lat.' '.$vacanteActo->lon . "<br />\n" ;
            echo '<input type="hidden" name="latitud" value="'.$vacanteActo->lat. '">';
            echo '<input type="hidden" name="longitud" value="'.$vacanteActo->lon. '">';
            echo '<input type="hidden" name="descripcion" value="'.$vacanteActo->des_cen. '">';
        }
?>
<div class="alert alert-success">
    <?php
        foreach ($especialidadesActo as $especialidadActo) {
           echo '<a href="#googleMap" onclick="mostrarActoEleccionMapa();" >' . $especialidadActo->cod_cue .' '.$especialidadActo->cod_esp . "</a><br />\n";
         //  echo $especialidadActo->cod_cue .' '.$especialidadActo->cod_esp. "<br />\n" ;
        }
    ?>
</div>