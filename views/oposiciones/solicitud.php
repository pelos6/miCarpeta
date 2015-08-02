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
$this->params['breadcrumbs'][] = ['label' => 'Actos', 'url' => ['actoos']];
$this->params['breadcrumbs'][] = ['label' => 'Solcitudes '.  $session->get('tex_opc_sel'), 'url' => ['solicitudes','cod_opc' => Html::encode($_GET["cod_opc"]),'tex_opc' => $session->get('tex_opc_sel')]];
$this->params['breadcrumbs'][] = $this->title;

$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";

$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
$solicitudActo = $clienteSigi->getSolicitudActo(Html::encode($_GET["cod_opc"]),Yii::$app->user->identity->dni,Html::encode($_GET["cod_sol"]));
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
        <?= $solicitudActo->f_hor_ent ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Código de estado de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudActo->cod_est_sol ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title"> Estado de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudActo->des_est_sol ?>
    </div>
</div>  



