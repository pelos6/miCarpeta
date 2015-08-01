<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
use yii\web\Session;

$session = Yii::$app->session;
$session->open();
$session->set('des_con_sel', Html::encode($_GET["des_con"]));
//echo("<pre>");
//print_r($_SESSION);
//echo ("</pre>");
$this->title = 'solicitudes ' . Html::encode($_GET["des_con"]);
$this->params['breadcrumbs'][] = ['label' => 'Interinos', 'url' => ['interinos']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
//error_log("DEBUG: la urlInterinos " . $urlInterinos . " " . $uriInterinos);
//error_log("DEBUG: la urlActos " . $urlActos . " " . $uriActos);
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
?>
<div class="site-about">
    <h4> Solicitudes presentadas a la convocatoria  </h4> 
    <div class="alert alert-success">
        <?php
        $solicitudesListas = $clienteSigicon->getSolicitudesConvocatoriaListas(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni);
        foreach ($solicitudesListas as $solicitudLista) {
            echo '<a href="' . Url::toRoute(["interinos/solicitud", "cod_con" => $solicitudLista->cod_con, "cod_sol" => $solicitudLista->cod_sol]) . '">' . $solicitudLista->cod_sol . "</a><br />\n";
        }
//    echo("<pre>");
//    print_r($solicitudesListas);
//    echo ("</pre>");
//    
        ?>
    </div>

</div>