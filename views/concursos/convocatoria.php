<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

$this->title =  Html::encode($_GET["des_con"]);
$this->params['breadcrumbs'][] = ['label' => 'CONCURSOS DE TRASLADOS', 'url' => ['concursos']];
$this->params['breadcrumbs'][] = $this->title;

if (Html::encode($_GET["cod_tip_con"] == 'P')) {
    $urlPrimaria =   Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri/servicioConcursosPrimaria.php";
    $uriPri = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri";
    $clienteConcursosPrimaria = new SoapClient(null, array('location' => $urlPrimaria, 'uri' => $uriPri));
    $concursoActivo = $clienteConcursosPrimaria->getConcursoActivo($_GET["cod_con"]);
}
else{
    $urlSecundaria = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec/servicioConcursosSecundaria.php";
    $uriSec = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec";
    $clienteConcursosSecundaria = new SoapClient(null, array('location' => $urlSecundaria, 'uri' => $uriSec));
    $concursoActivo = $clienteConcursosSecundaria->getConcursoActivo($_GET["cod_con"]);
}


?>
   
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Descripción de convocatoria</h3>
    </div>
    <div class="panel-body">
         <?= Html::encode($_GET["des_con"]) ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Ambito del Concurso de Traslados</h3>
    </div>
    <div class="panel-body">
        <?= $concursoActivo->des_tip_con ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fase del Concurso de Traslados</h3>
    </div>
    <div class="panel-body">
        <?= $concursoActivo->des_fas_con ?>
    </div>
</div>  

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha inicio de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $concursoActivo->f_ini_sol ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha fin de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $concursoActivo->f_fin_sol ?>
    </div>
</div>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Enlace a la convocatoria.</h3>
    </div>
    <div class="panel-body">
        <?= '<a href="' . $concursoActivo->url . '" target="_blank">' . "Concurso Traslados" . "</a><br />\n"; ?>
    </div>
</div>  




