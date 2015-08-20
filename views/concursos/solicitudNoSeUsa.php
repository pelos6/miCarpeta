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
$this->params['breadcrumbs'][] = ['label' => 'Concursos', 'url' => ['concursos']];
$this->params['breadcrumbs'][] = ['label' => 'Solicitudes '.  $session->get('des_con_sel'), 'url' => ['solicitudes','cod_con' => Html::encode($_GET["cod_con"]),'cod_tip_con' => Html::encode($_GET["cod_tip_con"]),'des_con' => $session->get('des_con_sel')]];
$this->params['breadcrumbs'][] = $this->title;

if (Html::encode($_GET["cod_tip_con"] == 'P')) {
    $urlPrimaria =   Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri/servicioConcursosPrimaria.php";
    $uriPri = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri";
    $clienteConcursosPrimaria = new SoapClient(null, array('location' => $urlPrimaria, 'uri' => $uriPri));
    $solicitudConcurso = $clienteConcursosPrimaria->getSolicitudConcurso(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni,Html::encode($_GET["cod_sol"]));
}
else{
    $urlSecundaria = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec/servicioConcursosSecundaria.php";
    $uriSec = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec";
    $clienteConcursosSecundaria = new SoapClient(null, array('location' => $urlSecundaria, 'uri' => $uriSec));
    $solicitudConcurso = $clienteConcursosSecundaria->getSolicitudConcurso(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni,Html::encode($_GET["cod_sol"]));
}
//$solicitudActo = $clienteSigi->getSolicitudActo(Html::encode($_GET["cod_opc"]),Yii::$app->user->identity->dni,Html::encode($_GET["cod_sol"]));
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
        <?= $solicitudConcurso->f_hor_ent ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Código de estado de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudConcurso->des_est_sol ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title"> Estado de la solicitud</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudConcurso->des_est_sol ?>
    </div>
</div>  



