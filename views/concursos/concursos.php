<?php

use yii\helpers\Html;
use yii\helpers\Url;

/* @var $this yii\web\View */
$this->title = 'Concursos';
$this->params['breadcrumbs'][] = $this->title;
$urlPrimaria =   Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri/servicioConcursosPrimaria.php";
$urlSecundaria = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec/servicioConcursosSecundaria.php";
$uriPri = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri";
$uriSec = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec";
$clienteConcursosPrimaria = new SoapClient(null, array('location' => $urlPrimaria, 'uri' => $uriPri));
$clienteConcursosSecundaria = new SoapClient(null, array('location' => $urlSecundaria, 'uri' => $uriSec));

?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>
    <h3>Concursos de Traslados: información general. </h3>
    <div class="alert alert-success">
        <?php
        $concursosActivosPrimaria = $clienteConcursosPrimaria->getConcursosActivos();
        foreach ($concursosActivosPrimaria as $concursoActivo) {
            echo '<a href="' . Url::toRoute(["concursos/convocatoria", "cod_tip_con" => 'P', "cod_con" => $concursoActivo->cod_con,"des_con" => $concursoActivo->des_con]) . '">' . $concursoActivo->des_con . "</a><br />\n";
        }
        $concursosActivosSecundaria = $clienteConcursosSecundaria->getConcursosActivos();
        foreach ($concursosActivosSecundaria as $concursoActivo) {
            echo '<a href="' . Url::toRoute(["concursos/convocatoria","cod_tip_con" => 'S', "cod_con" => $concursoActivo->cod_con,"des_con" => $concursoActivo->des_con]) . '">' . $concursoActivo->des_con . "</a><br />\n";
        }
        ?>
    </div>

    <h3>Concursos de Traslados información personal</h3>
    <h4>Convocatorias en las que ha presentado solicitud . </h4> 
     <div class="alert alert-success">
        <?php
        $ConcursosPrimariaConSolicitud = $clienteConcursosPrimaria->getConcursoHaySolicitud(Yii::$app->user->identity->dni);
        foreach ($ConcursosPrimariaConSolicitud as $ConcursoPrimariaConSolicitud) {
           // echo $ConcursoPrimariaConSolicitud->des_con  . "<br />\n";
            echo '<a href="' . Url::toRoute(["concursos/solicitudes","cod_tip_con" => 'P', "cod_con" => $ConcursoPrimariaConSolicitud->cod_con,"des_con" => $ConcursoPrimariaConSolicitud->des_con]) . '">' . $ConcursoPrimariaConSolicitud->des_con . "</a><br />\n";
        }
        ?>
        <?php
        $ConcursosSecundariaConSolicitud = $clienteConcursosSecundaria->getConcursoHaySolicitud(Yii::$app->user->identity->dni);
        foreach ($ConcursosSecundariaConSolicitud as $ConcursoSecundariaConSolicitud) {
           // echo $ConcursoSecundariaConSolicitud->des_con  . "<br />\n";
            echo '<a href="' . Url::toRoute(["concursos/solicitudes","cod_tip_con" => 'S', "cod_con" => $ConcursoSecundariaConSolicitud->cod_con,"des_con" => $ConcursoSecundariaConSolicitud->des_con]) . '">' . $ConcursoSecundariaConSolicitud->des_con . "</a><br />\n";
        }

//    echo("<pre>");
//    print_r($solicitudesConcursos);
//    echo ("</pre>");
        ?>
    </div>
</div>