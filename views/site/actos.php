<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
$this->title = 'Actos de elección';
$this->params['breadcrumbs'][] = $this->title;
$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>
    <h3>Actos de elección: información general.</h3>
    <p> 
        Información general sobre actos de elección que actos de elección hay convocados y en que situación estan     
    </p>
    <div class="alert alert-success">
        <?php
        $actosActivos = $clienteSigi->getActosActivos();
        foreach ($actosActivos as $actoActivo) {
            echo $actoActivo->tex_opc . "<br />\n";
        }
//    echo("<pre>");
//    print_r($actosActivos);
//    echo ("</pre>");
        ?>
    </div>
    <h3>Actos de elección: información personal </h3>
    <h4>Situación de las solicitudes del usuario en los actos de elección.</h4> 
    <div class="alert alert-success">
        <?php
        $solicitudesActos = $clienteSigi->getSolicitudesActos(Yii::$app->user->identity->dni);
        foreach ($solicitudesActos as $solicitudActo) {
            echo $solicitudActo->tex_opc . ' ' . $solicitudActo->cod_sol . ' ' . $solicitudActo->estado . "<br />\n";
        }
//    echo("<pre>");
//    print_r($solicitudesActos);
//    echo ("</pre>");
        ?>
    </div>
    <p>
        <?= Yii::$app->params["servidor"] ?>
    </p>
</div>