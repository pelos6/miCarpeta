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
$this->params['breadcrumbs'][] = ['label' => 'Oposiciones', 'url' => ['oposiciones']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
?>
<div class="site-about">
    <h4> Solicitudes presentadas a la oposición. </h4> 
    <div class="container">
  <div class="panel panel-default">
        <?php
        $solicitudesOposicion = $clienteSigicon->getSolicitudesConvocatoriaOposicion(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni);
        foreach ($solicitudesOposicion as $solicitudOposicion) {
            echo '<div class="panel panel-heading">'; 
                echo 'Solicitud con código: '.$solicitudOposicion->cod_sol.' presentada  '.$solicitudOposicion->fec_sol .' '. $solicitudOposicion->des_est_sol. ' ' ; 
                echo Html::a('Notas y baremo', ['oposiciones/notas',"cod_con" => $_GET["cod_con"],"des_con" => $_GET["des_con"],"cod_sol" => $solicitudOposicion->cod_sol,"modo" => '3'], ['class' => 'btn btn-success']) ;
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