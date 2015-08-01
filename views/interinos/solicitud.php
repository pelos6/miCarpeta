<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
use yii\web\Session;

$session = Yii::$app->session;
$session->open();
//    echo("<pre>");
//    print_r($_SESSION);
//    echo ("</pre>");
$this->title = 'solicitud ' . Html::encode($_GET["cod_sol"]);
$this->params['breadcrumbs'][] = ['label' => 'Interinos', 'url' => ['interinos']];
$this->params['breadcrumbs'][] = ['label' => 'Solcitudes '.  $session->get('des_con_sel'), 'url' => ['solicitudes','cod_con' => Html::encode($_GET["cod_con"]),'des_con' => $session->get('des_con_sel')]];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
//error_log("DEBUG: la urlInterinos " . $urlInterinos . " " . $uriInterinos);
//error_log("DEBUG: la urlActos " . $urlActos . " " . $uriActos);
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
$solicitudListas = $clienteSigicon->getSolicitudListas(Html::encode($_GET["cod_con"]),Yii::$app->user->identity->dni,Html::encode($_GET["cod_sol"]));
?>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Codigo de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= Html::encode($_GET["cod_sol"]) ?>
    </div>
</div>    
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha de grabación de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudListas->fec_sol ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Código de estado de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudListas->cod_est_sol ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title"> Estado de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudListas->des_est_sol ?>
    </div>
</div>  



