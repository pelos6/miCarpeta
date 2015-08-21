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
$this->title = 'BAREMO SOLICITUD ' . Html::encode($_GET["cod_sol"]);
$this->params['breadcrumbs'][] = ['label' => 'INTERINOS', 'url' => ['interinos']];
$this->params['breadcrumbs'][] = ['label' => 'SOLICITUDES '.  $session->get('des_con_sel'), 'url' => ['solicitudes','cod_con' => Html::encode($_GET["cod_con"]),'des_con' => $session->get('des_con_sel')]];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
//error_log("DEBUG: la urlInterinos " . $urlInterinos . " " . $uriInterinos);
//error_log("DEBUG: la urlActos " . $urlActos . " " . $uriActos);
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
$solicitudBaremada = $clienteSigicon->getBaremoSolicitudConvocatoriaListas(Html::encode($_GET["cod_con"]),Yii::$app->user->identity->dni,Html::encode($_GET["cod_sol"]));
?>
<h4> Baremo obtenido sobre los méritos documentados. </h4> 
<table class="table table-bordered">
    <tbody>
        <tr class="active">
            <td colspan="3">Apartado I.  EXPERIENCIA DOCENTE PREVIA. </td>
            <td><?= $solicitudBaremada->apa_1 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 1.1 </td>
            <td>Apartado 1.2 </td>
            <td>Apartado 1.3 </td>
            <td>Apartado 1.4 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudBaremada->apa_1_1 ?> </td>
            <td><?= $solicitudBaremada->apa_1_2 ?> </td>
            <td><?= $solicitudBaremada->apa_1_3 ?></td>
            <td><?= $solicitudBaremada->apa_1_4 ?></td>
        </tr>
        <tr class="active">
            <td colspan="3">Apartado II.  FORMACIÓN ACADÉMICA Y PERMANENTE . </td>
            <td><?= $solicitudBaremada->apa_2 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 2.1 </td>
            <td>Apartado 2.2 </td>
            <td>Apartado 2.3 </td>
            <td>Apartado 2.4 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudBaremada->apa_2_1 ?> </td>
            <td><?= $solicitudBaremada->apa_2_2 ?> </td>
            <td><?= $solicitudBaremada->apa_2_3 ?></td>
            <td><?= $solicitudBaremada->apa_2_4 ?></td>
        </tr>
        <tr class="active">
            <td colspan="3">Apartado III. OTROS MÉRITOS . </td>
            <td><?= $solicitudBaremada->apa_3 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 3.1 </td>
            <td>Apartado 3.2 </td>
            <td>Apartado 3.3 </td>
            <td>Apartado 3.4 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudBaremada->apa_3_1 ?> </td>
            <td><?= $solicitudBaremada->apa_3_2 ?> </td>
            <td><?= $solicitudBaremada->apa_3_3 ?></td>
            <td><?= $solicitudBaremada->apa_3_4 ?></td>
        </tr>
        <tr class="danger">
            <td colspan="3">Total . </td>
            <td><?= $solicitudBaremada->res_tot ?></td>
        </tr>
    </tbody>
</table>
