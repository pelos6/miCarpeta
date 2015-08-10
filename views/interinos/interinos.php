<?php

use yii\helpers\Html;
use yii\helpers\Url;


/* @var $this yii\web\View */
$this->title = 'Interinos';
$this->params['breadcrumbs'][] = $this->title;
$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
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
        $nada = true;
        foreach ($convocatoriasListasActivas as $convocatoriaListaActiva) {
            echo '<a href="' . Url::toRoute(["interinos/convocatoria", "cod_con" => $convocatoriaListaActiva->cod_con,"des_con" => $convocatoriaListaActiva->des_con]) . '">' . $convocatoriaListaActiva->des_con . "</a><br />\n";
            $nada = false;
        }
        if ($nada){
            echo 'Ninguna Convocatoria a listas ni de rebaremación activa';
        }
        ?>
    </div>
    <h3>Interinos: información personal</h3>

    <h4>Situación del participante en listas. </h4> 
    <div class="alert alert-success">
        <?php
        $consultasSituacionListas = $clienteSigi->getConsultasSituacionListas(Yii::$app->user->identity->dni);
        $nada = true;
        foreach ($consultasSituacionListas as $consultaSituacionListas) {
            echo '<a href="' . $consultaSituacionListas->url . '" target= "_blank">' . $consultaSituacionListas->tex_opc . "</a><br />\n";
           $nada = false; 
        }
        if ($nada){
            echo 'Ninguna información a mostrar';
        }
         ?>
    </div>
    <h4>Convocatorias en las que ha presentado solicitud    . </h4> 
    <div class="alert alert-success">
        <?php
        $ListasConSolilcitud = $clienteSigicon->getConvocatoriasListasHaySolicitud(Yii::$app->user->identity->dni);
        $nada = true;
        foreach ($ListasConSolilcitud as $ListaConSolilcitud) {
            echo '<a href="' . Url::toRoute(["interinos/solicitudes", "cod_con" => $ListaConSolilcitud->cod_con,"des_con" => $ListaConSolilcitud->des_con]) . '">' . $ListaConSolilcitud->des_con . "</a><br />\n";
            $nada = false;
        }
       if ($nada){
            echo 'El usuario no tiene solicitud en ninguna de las convocatorias activas';
        }
//    echo("<pre>");
//    print_r($solicitudesListas);
//    echo ("</pre>");
//    
        ?>
    </div>
</div>