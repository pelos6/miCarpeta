<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
$this->title = 'Concursos';
$this->params['breadcrumbs'][] = $this->title;
$urlPrimaria =   Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri/servicioConcursosPrimaria.php";
$urlSecundaria = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec/servicioConcursosSecundaria.php";
$uriPri = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri";
$uriSec = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec";
error_log("DEBUG: desde parametros la urlPrimaria " . $urlPrimaria . " " . $urlSecundaria);
$clienteConcursosPrimaria = new SoapClient(null, array('location' => $urlPrimaria, 'uri' => $uriPri));
$clienteConcursosSecundaria = new SoapClient(null, array('location' => $urlSecundaria, 'uri' => $uriSec));

?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>
    <h3>Concursos de Traslados información general. desde parametros  </h3>
    <p>
        Información general sobre concursos de Traslados. 
    </p>
    <div class="alert alert-success">
        <?php
        $concursosActivosPrimaria = $clienteConcursosPrimaria->getConcursosActivos();
        foreach ($concursosActivosPrimaria as $concursoActivo) {
            echo '<a href="' . $concursoActivo->url . '" target="_blank">' . $concursoActivo->des_con . ' ' . $concursoActivo->cod_tip_con . ' ' . $concursoActivo->des_fas . "</a><br />\n";
        }
        $concursosActivosSecundaria = $clienteConcursosSecundaria->getConcursosActivos();
        foreach ($concursosActivosSecundaria as $concursoActivo) {
            echo '<a href="' . $concursoActivo->url . '" target="_blank">' . $concursoActivo->des_con . ' ' . $concursoActivo->cod_tip_con . ' ' . $concursoActivo->des_fas . "</a><br />\n";
        }
//    echo("<pre>");
//    print_r($concursosActivos);
//    echo ("</pre>");
        ?>
    </div>

    <h3>Concursos de Traslados información personal</h3>
    <h4>Situación de las solicitudes del usuario en los concursos de traslados.</h4> 
    <div class="alert alert-success">
        <?php
        $solicitudesConcursosPrimaria = $clienteConcursosPrimaria->getSolicitudesConcursos(Yii::$app->user->identity->dni);
        foreach ($solicitudesConcursosPrimaria as $solicitudConcurso) {
            echo $solicitudConcurso->des_con . ' ' . $solicitudConcurso->cod_sol . ' ' . $solicitudConcurso->estado . ' ' . $solicitudConcurso->fechagrabacion . "<br />\n";
        }
        
        $solicitudesConcursosSecundaria = $clienteConcursosSecundaria->getSolicitudesConcursos(Yii::$app->user->identity->dni);
        foreach ($solicitudesConcursosSecundaria as $solicitudConcurso) {
            echo $solicitudConcurso->des_con . ' ' . $solicitudConcurso->cod_sol . ' ' . $solicitudConcurso->estado . ' ' . $solicitudConcurso->fechagrabacion . "<br />\n";
        }

//    echo("<pre>");
//    print_r($solicitudesConcursos);
//    echo ("</pre>");
        ?>
    </div>
</div>