<?php

use yii\helpers\Html;
use yii\helpers\Url;

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
    <div class="alert alert-success">
        <?php
        $actosActivos = $clienteSigi->getActosActivos();
        $nada = true;
        foreach ($actosActivos as $actoActivo) {
           // echo $actoActivo->tex_opc . "<br />\n";
            echo '<a href="' . Url::toRoute(["actos/convocatoria", "cod_opc" => $actoActivo->cod_opc,"tex_opc" => $actoActivo->tex_opc]) . '">' . $actoActivo->tex_opc . "</a><br />\n";
            $nada = false;
        }
        if ($nada){
            echo 'Ninguna  Acto de Elección activo';
        }
        ?>
    </div>
    <h3>Actos de elección: información personal </h3>
     <h4>Actos de elección en las que esta preseleccionado . </h4> 
    <div class="alert alert-success">
        <?php
        $ActosConvocado = $clienteSigi->getActosConvocado(Yii::$app->user->identity->dni);
        $nada = true;
        foreach ($ActosConvocado as $ActoConvocado) {
            echo '<a href="' . Url::toRoute(["actos/convocatoria", "cod_opc" => $ActoConvocado->cod_opc,"tex_opc" => $ActoConvocado->tex_opc]) . '">' . $ActoConvocado->tex_opc . "</a><br />\n";
            $nada = false;
        }
        if ($nada){
            echo 'El usuario no esta convocado en ningún Acto de Elección ';
        }
        ?>
    </div>
    <h4>Actos de elección en las que ha presentado solicitud . </h4> 
    <div class="alert alert-success">
        <?php
        $ActosHaySolicitud = $clienteSigi->getActosHaySolicitud(Yii::$app->user->identity->dni);
        $nada = true;
        foreach ($ActosHaySolicitud as $ActoHaySolicitud) {
            echo '<a href="' . Url::toRoute(["actos/solicitudes", "cod_opc" => $ActoHaySolicitud->cod_opc,"tex_opc" => $ActoHaySolicitud->tex_opc]) . '">' . $ActoHaySolicitud->tex_opc . "</a><br />\n";
            $nada = false;
        }
        if ($nada){
            echo 'El usuario no tiene solicitud en ningún Acto de Elección';
        }
//    echo("<pre>");
//    print_r($solicitudesListas);
//    echo ("</pre>");
//    
        ?>
    </div>
</div>