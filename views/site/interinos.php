<?php

use yii\helpers\Html;

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

    <h3>Interinos información general. todo cambiado Comporbando  </h3>
    <div class="alert alert-success">
        <?php
        $convocatoriasListasActivas = $clienteSigicon->getConvocatoriasListasActivas();
//        $response_string = $clienteInterinos->__getLastResponse();
//        error_log('DEBUG: $response_string ' . $response_string);
        foreach ($convocatoriasListasActivas as $convocatoriaListaActiva) {
            echo $convocatoriaListaActiva->des_con . "<br />\n";
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
            echo $consultaSituacionListas->tex_opc . "<br />\n";
        }
//    echo("<pre>");
//    print_r($convocatoriasListasActivas);
//    echo ("</pre>");
        ?>
    </div>
    <h4>Situación de las solicitudes del usuario a listas. </h4> 
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