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
$this->title = 'NOTAS SOLICITUD ' . Html::encode($_GET["cod_sol"]);
$this->params['breadcrumbs'][] = ['label' => 'OPOSICIONES', 'url' => ['oposiciones']];
$this->params['breadcrumbs'][] = ['label' => 'SOLICITUDES ' . $session->get('des_con_sel'), 'url' => ['solicitudes', 'cod_con' => Html::encode($_GET["cod_con"]), 'des_con' => $session->get('des_con_sel')]];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
//error_log("DEBUG: la urlInterinos " . $urlInterinos . " " . $uriInterinos);
//error_log("DEBUG: la urlActos " . $urlActos . " " . $uriActos);
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
$solicitudNotas = $clienteSigicon->getNotasSolicitudOposicion(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, Html::encode($_GET["cod_sol"]));
?>
<h4> Puntuaciones obtenidas en los procesos selectivos.</h4> 
<table class="table table-bordered">
    <thead>
        <tr>
            <th>Prueba </th>
            <th>Nota ejercicio</th>
            <th>Nota ponderada</th>
        </tr>
    </thead>
    <tbody>
        <tr class="active">
            <td>Prueba 1 A </td>
            <td><?= $solicitudNotas->pru_1_a_not ?></td>
            <td><?= $solicitudNotas->pru_1_a_pon ?></td>
        </tr>
        <tr class="active">
            <td>Prueba 1 B </td>
            <td><?= $solicitudNotas->pru_1_b_not ?></td>
            <td><?= $solicitudNotas->pru_1_b_pon ?></td>
        </tr>
         <tr class="active">
            <td>Prueba 2 A </td>
            <td><?= $solicitudNotas->pru_2_a_not ?></td>
            <td><?= $solicitudNotas->pru_2_a_pon ?></td>
        </tr>
        <tr class="active">
            <td>Prueba 2 B </td>
            <td><?= $solicitudNotas->pru_2_b_not ?></td>
            <td><?= $solicitudNotas->pru_2_b_pon ?></td>
        </tr>
        <tr class="active">
            <td>Total </td>
            <td></td>
            <td><?= $solicitudNotas->res_tot_opo ?></td>
        </tr>
         <tr class="active">
            <td>Superada </td>
            <td></td>
            <td><?= $solicitudNotas->sup ?></td>
        </tr>
        <tr class="active">
            <td>Puntuación total fase de concurso </td>
            <td></td>
            <td><?= $solicitudNotas->res_tot_con ?></td>
        </tr>
    </tbody>
</table>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Resultado total 45</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->res_tot_opo ?>
    </div>
</div>    
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_1_a_not </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_1_a_not ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_2_a_not </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_2_a_not ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_1_b_not </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_1_b_not ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_2_b_not </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_2_b_not ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_1_a_pon </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_1_a_pon ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_2_a_pon </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_2_a_pon ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_1_b_pon </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_1_b_pon ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba pru_2_b_pon </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->pru_2_b_pon ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba sup </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->sup ?>
    </div>
</div>        
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Prueba res_tot_con </h3>
    </div>
    <div class="panel-body">
        <?= $solicitudNotas->res_tot_con ?>
    </div>
</div>        


