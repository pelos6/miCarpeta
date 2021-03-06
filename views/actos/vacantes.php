<script src="http://maps.googleapis.com/maps/api/js"></script>
<script src="js/codigo.js"></script>
<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
$this->params['breadcrumbs'][] = ['label' => 'ACTOS DE ELECCIÓN', 'url' => ['actos']];

if (Html::encode($_GET["modo"]) == '1') {
    $vacantes = $clienteSigi->getVacantesActo($_GET["cod_opc"]);
    $especialidades = $clienteSigi->getEspecialidadesActo($_GET["cod_opc"]);
    $this->params['breadcrumbs'][] = ['label' => Html::encode($_GET["tex_opc"]),
        'url' => ["actos/convocatoria", "cod_opc" => Html::encode($_GET["cod_opc"]), "tex_opc" => Html::encode($_GET["tex_opc"]), "modo" => Html::encode($_GET["modo"])]];
    $this->title = 'VACANTES OFERTADAS';
    $tex = ' vacantes ofertadas';
} else if (Html::encode($_GET["modo"]) == '2') {
    $vacantes = $clienteSigi->getVacantesSeleccionables($_GET["cod_opc"], Yii::$app->user->identity->dni);
    $especialidades = $clienteSigi->getEspecialidadesSeleccionables($_GET["cod_opc"], Yii::$app->user->identity->dni);
    $this->params['breadcrumbs'][] = ['label' => Html::encode($_GET["tex_opc"]),
        'url' => ["actos/convocatoria", "cod_opc" => Html::encode($_GET["cod_opc"]), "tex_opc" => Html::encode($_GET["tex_opc"]), "modo" => Html::encode($_GET["modo"])]];
    $this->title = 'VACANTES SELECCIONABLES';
    $tex = ' vacantes seleccionables';
} else {
    $vacantes = $clienteSigi->getVacantesPedidas($_GET["cod_opc"], Yii::$app->user->identity->dni, $_GET['cod_sol']);
    $especialidades = $clienteSigi->getEspecialidadesPedidas($_GET["cod_opc"], Yii::$app->user->identity->dni, $_GET['cod_sol']);
    $this->params['breadcrumbs'][] = ['label' => 'SOLICITUDES' . Html::encode($_GET["tex_opc"]),
        'url' => ["actos/solicitudes", "cod_opc" => Html::encode($_GET["cod_opc"]), "tex_opc" => Html::encode($_GET["tex_opc"])]];
    $this->title = 'VACANTES PEDIDAS SOLICITUD ' . $_GET['cod_sol'];
    $tex = ' vacantes pedidas en la solicitud '.$_GET['cod_sol'];
}

$this->params['breadcrumbs'][] = $this->title;
?>
<h4 id="texto">Situación geográfica de las  <?= $tex ?> </h4> 
<div id="googleMap" style="width:500px;height:380px;"> </div>
<?php
foreach ($vacantes as $vacante) {
    // echo $vacante->num_vac .' '.$vacante->lat.' '.$vacante->lon . "<br />\n" ;
    echo '<input type="hidden" name="cue_esp" value="' . $vacante->cod_cue . ' ' . $vacante->cod_esp . '">';
    echo '<input type="hidden" name="latitud" value="' . $vacante->lat . '">';
    echo '<input type="hidden" name="longitud" value="' . $vacante->lon . '">';
    echo '<input type="hidden" name="descripcion_centro" value="' . $vacante->des_cen . '">';
    echo '<input type="hidden" name="descripcion_vacante" value="' . $vacante->des_vac . '">';
}
?>
<h4>Especialidades de las <?= $tex ?>  </h4> 
<div class="alert alert-success">
<?php
foreach ($especialidades as $especialidad) {
    // echo '<a href="#googleMap" onclick="mostrarActoEleccionMapa('."'0590 001'".');" >' . $especialidad->cod_cue .' '.$especialidad->cod_esp . "</a><br />\n";
    echo Html::button(' ' . $especialidad->cod_cue . ' ' . $especialidad->cod_esp . ' ', [ 'class' => 'btn btn-primary', 'onclick' => 'mostrarActoEleccionMapa("' . $especialidad->cod_cue . ' ' . $especialidad->cod_esp . '");']) . ' ';
    //echo Html::a('especialidades ofertadas', ['#googleMap'], ['class' => 'btn btn-success']) ;
    //  echo $especialidad->cod_cue .' '.$especialidad->cod_esp. "<br />\n" ;
}
?>
</div>