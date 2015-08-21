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
$this->params['breadcrumbs'][] = ['label' => 'OPOSICIONES', 'url' => ['oposiciones']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
?>
<div class="site-about">
    <h4> Solicitudes presentadas a la oposición.</h4> 
    <div class="container">
  <div class="panel panel-default">
        <?php
        $solicitudesOposicion = $clienteSigicon->getSolicitudesOposicion(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni);
        foreach ($solicitudesOposicion as $solicitudOposicion) {
                echo '<div class="panel panel-heading">'; 
                echo 'SOLICITUD CON CÓDIGO: <span class="badge">'.$solicitudOposicion->cod_sol. ' </span> FECHA  <span class="badge"> '.$solicitudOposicion->fec_sol . '</span>'.
                '<br> '. $solicitudOposicion->des_cue_esp. 
                '<br> '. $solicitudOposicion->des_est_sol. ' <br>' ; 
                if ($clienteSigicon->getHaySolicitudOposicionBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, $solicitudOposicion->cod_sol)){
                    echo Html::a('BAREMO', ['oposiciones/baremo',"cod_con" => $_GET["cod_con"],"des_con" => $_GET["des_con"],"cod_sol" => $solicitudOposicion->cod_sol], ['class' => 'btn btn-success']) ;
                } 
                echo '   ';
                if ($clienteSigicon->getHaySolicitudOposicionNota(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, $solicitudOposicion->cod_sol)){
                    echo Html::a('NOTAS', ['oposiciones/notas',"cod_con" => $_GET["cod_con"],"des_con" => $_GET["des_con"],"cod_sol" => $solicitudOposicion->cod_sol], ['class' => 'btn btn-success']) ;
                } 
                echo '</div>';
        }
//    echo("<pre>");
//    print_r($solicitudesOposicion);
//    echo ("</pre>");
//    
        ?>
    </div>
</div>
</div>