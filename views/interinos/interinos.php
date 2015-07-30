<?php

use yii\helpers\Html;
use yii\helpers\Url;

/* @var $this yii\web\View */
$this->title = 'Interinos';
$this->params['breadcrumbs'][] = $this->title;
$urlSigicon = Yii::$app->params["servidor"] ."/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] ."/serviciosMiCarpetaSigicon";
$urlSigi = Yii::$app->params["servidor"] ."/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] ."/serviciosMiCarpetaSigi";
//error_log("DEBUG: la urlInterinos " . $urlInterinos . " " . $uriInterinos);
//error_log("DEBUG: la urlActos " . $urlActos . " " . $uriActos);
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>

    <h3>Interinos información general.  </h3>
    <div class="alert alert-success">
        <?php
        $convocatoriasListasActivas = $clienteSigicon->getConvocatoriasListasActivas();
        foreach ($convocatoriasListasActivas as $convocatoriaListaActiva) {
            echo '<a href="' .  Url::toRoute(["interinos/convocatoria", "id" => $convocatoriaListaActiva->cod_con]). '">'. $convocatoriaListaActiva->des_con. "</a><br />\n";
        }
//    echo("<pre>");
//    print_r($convocatoriasListasActivas);
//    echo ("</pre>");
        ?>
    </div>
    <h3>Interinos información personal</h3>

    <h4>Situación del participante en listas. </h4> 
    <div class="alert alert-success">
        <?php
        $consultasSituacionListas = $clienteSigi->getConsultasSituacionListas(Yii::$app->user->identity->dni);
        foreach ($consultasSituacionListas as $consultaSituacionListas) {
//            echo $consultaSituacionListas->tex_opc . "<br />\n";
            echo '<a href="'.  $consultaSituacionListas->url. '">'. $consultaSituacionListas->tex_opc. "</a><br />\n";
      
        }
//    echo("<pre>");
//    print_r($convocatoriasListasActivas);
//    echo ("</pre>");
        ?>
    </div>
    <h4>Convocatorias en las que ha presentado solicitud    . </h4> 
    <div class="alert alert-success">
        <?php
        $solicitudesListas = $clienteSigicon->getSolicitudesListas(Yii::$app->user->identity->dni);
        foreach ($solicitudesListas as $solicitudLista) {
            echo $solicitudLista->des_con . ' ' . $solicitudLista->cod_sol . ' ' . $solicitudLista->estado . "<br />\n";
        }
//    echo("<pre>");
//    print_r($solicitudesListas);
//    echo ("</pre>");
//    
        ?>
    </div>
</div>