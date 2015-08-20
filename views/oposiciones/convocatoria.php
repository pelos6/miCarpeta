<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

$this->title = Html::encode($_GET["des_con"]);
$this->params['breadcrumbs'][] = ['label' => 'OPOSICIONES', 'url' => ['oposiciones']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
//error_log("DEBUG: la urlInterinos " . $urlInterinos . " " . $uriInterinos);
//error_log("DEBUG: la urlActos " . $urlActos . " " . $uriActos);
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
$convocatoriaOposicion = $clienteSigicon->getConvocatoriaOposicion($_GET["cod_con"]);
?>

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Codigo de convocatoria</h3>
    </div>
    <div class="panel-body">
        <?= Html::encode($_GET["cod_con"]) ?>
    </div>
</div>    
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Descripción de convocatoria</h3>
    </div>
    <div class="panel-body">
        <?= $convocatoriaOposicion->des_con ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha resolución</h3>
    </div>
    <div class="panel-body">
        <?= $convocatoriaOposicion->f_res ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha publicación</h3>
    </div>
    <div class="panel-body">
        <?= $convocatoriaOposicion->f_pub ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha inicio de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $convocatoriaOposicion->f_ini_sol ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha fin de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $convocatoriaOposicion->f_fin_sol ?>
    </div>
</div>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Enlace a la convocatoria.</h3>
    </div>
    <div class="panel-body">
        <?= '<a href="' . $convocatoriaOposicion->url . '" target="_blank">' . "SIGICON" . "</a><br />\n"; ?>
    </div>
</div>  




