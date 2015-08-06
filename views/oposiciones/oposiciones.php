<?php

use yii\helpers\Html;
use yii\helpers\Url;

/* @var $this yii\web\View */
$this->title = 'Oposiciones';
$this->params['breadcrumbs'][] = $this->title;

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>
    <h3>Oposiciones: información general</h3>
    <div class="alert alert-success"> 
        <?php
        $oposicionesActivas = $clienteSigicon->getOposicionesActivas();
        foreach ($oposicionesActivas as $oposicionActiva) {
            echo '<a href="' . Url::toRoute(["oposiciones/convocatoria", "cod_con" => $oposicionActiva->cod_con,"des_con" => $oposicionActiva->des_con]) . '">' . $oposicionActiva->des_con . "</a><br />\n";
        }
        ?>
    </div>
    <h3>Oposiciones información personal. </h3>
    <h4>Oposiciones en las que ha presentado solicitud . </h4> 
    <div class="alert alert-success">
        <?php
        $OposicionesHaySolicitud = $clienteSigicon->getOposicionesHaySolicitud(Yii::$app->user->identity->dni);
        foreach ($OposicionesHaySolicitud as $OposicionHaySolicitud) {
            echo '<a href="' . Url::toRoute(["oposiciones/solicitudes", "cod_con" => $OposicionHaySolicitud->cod_con,"des_con" => $OposicionHaySolicitud->des_con]) . '">' . $OposicionHaySolicitud->des_con . "</a><br />\n";
        }
//    echo("<pre>");
//    print_r($solicitudesListas);
//    echo ("</pre>");
//    
        ?>
    </div>  
 </div>