<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

$this->title = 'convocatoria '. Html::encode($_GET["tex_opc"]);
$this->params['breadcrumbs'][] = ['label' => 'Actos', 'url' => ['actos']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
$actoActivo = $clienteSigi->getActoActivo($_GET["cod_opc"]);

?>

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Codigo de convocatoria</h3>
    </div>
    <div class="panel-body">
        <?= Html::encode($_GET["cod_opc"]) ?>
    </div>
</div>    
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Descripción de convocatoria</h3>
    </div>
    <div class="panel-body">
         <?= Html::encode($_GET["tex_opc"]) ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Tipo del acto de elección</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->cod_tip_ae ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha del acto de elección</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->f_con_ae ?>
    </div>
</div>  

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha inicio de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->f_ini_opc ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha fin de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->f_fin_opc ?>
    </div>
</div>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Enlace a la convocatoria.</h3>
    </div>
    <div class="panel-body">
        <?= '<a href="' . $actoActivo->url . '" target="_blank">' . "SIGI" . "</a><br />\n"; ?>
    </div>
</div>  



