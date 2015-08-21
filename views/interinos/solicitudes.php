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
$this->title = 'SOLICITUDES ' . Html::encode($_GET["des_con"]);
$this->params['breadcrumbs'][] = ['label' => 'INTERINOS', 'url' => ['interinos']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
//error_log("DEBUG: la urlInterinos " . $urlInterinos . " " . $uriInterinos);
//error_log("DEBUG: la urlActos " . $urlActos . " " . $uriActos);
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
?>
<div class="site-about">
    <h4> Solicitudes presentadas a la convocatoria. </h4> 
    <div class="container">
        <div class="panel panel-default">
            <?php
            $solicitudesListas = $clienteSigicon->getSolicitudesConvocatoriaListas(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni);
            foreach ($solicitudesListas as $solicitudLista) {
                echo '<div class="panel panel-heading">'; 
                echo 'Solicitud con código: <span class="badge">'.$solicitudLista->cod_sol. ' </span> fecha  <span class="badge"> '.$solicitudLista->fec_sol . '</span>'.
                '<br> '. $solicitudLista->des_cue_esp. 
                '<br> '. $solicitudLista->des_est_sol. ' <br>' ; 
                if ($clienteSigicon->getHaySolicitudConvocatoriaListasBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, $solicitudLista->cod_sol)){
                    echo Html::a('Baremo de la solicitud', ['interinos/baremo',"cod_con" => $_GET["cod_con"],"des_con" => $_GET["des_con"],"cod_sol" => $solicitudLista->cod_sol], ['class' => 'btn btn-success']) ;
                }   
                echo '</div>';
            }
    //    echo("<pre>");
    //    print_r($solicitudesListas);
    //    echo ("</pre>");
    //    
            ?>
        </div>
    </div>
</div>