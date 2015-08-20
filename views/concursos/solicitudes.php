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
$this->title = 'Solicitudes ' . Html::encode($_GET["des_con"]);
$this->params['breadcrumbs'][] = ['label' => 'Concursos', 'url' => ['concursos']];
$this->params['breadcrumbs'][] = $this->title;

if (Html::encode($_GET["cod_tip_con"] == 'P')) {
    $urlPrimaria =   Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri/servicioConcursosPrimaria.php";
    $uriPri = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri";
    $clienteConcursosPrimaria = new SoapClient(null, array('location' => $urlPrimaria, 'uri' => $uriPri));
    $solicitudesConcurso = $clienteConcursosPrimaria->getSolicitudesConcurso(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni);
}
else{
    $urlSecundaria = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec/servicioConcursosSecundaria.php";
    $uriSec = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec";
    $clienteConcursosSecundaria = new SoapClient(null, array('location' => $urlSecundaria, 'uri' => $uriSec));
    $solicitudesConcurso = $clienteConcursosSecundaria->getSolicitudesConcurso(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni);
}

?>
<div class="site-about">
    <h4> Solicitudes presentadas al concurso de traslados  </h4> 
    <div class="container">
      <div class="panel panel-default">
            <?php
            foreach ($solicitudesConcurso as $solicitudConcurso) {
                echo '<div class="panel panel-heading">'; 
                echo 'Solicitud con código: <span class="badge">'.$solicitudConcurso->cod_sol.' </span> presentada <span class="badge"> '.$solicitudConcurso->f_hor_ent .' </span>' . 
                '<br> '.$solicitudConcurso->des_est_sol. '<br>  ' ; 
                if (Html::encode($_GET["cod_tip_con"] == 'P')) {
                     if ($clienteConcursosPrimaria->getHaySolicitudConcursoBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, $solicitudConcurso->cod_sol)){
                        echo Html::a('Baremo de la solicitud', ['concursos/baremo',"cod_con" => $_GET["cod_con"],"des_con" => $_GET["des_con"],"cod_sol" => $solicitudConcurso->cod_sol, "cod_tip_con" => $_GET["cod_tip_con"] ], ['class' => 'btn btn-success']) ;
                    }
                } else {
                    if ($clienteConcursosSecundaria->getHaySolicitudConcursoBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, $solicitudConcurso->cod_sol)){
                        echo Html::a('Baremo de la solicitud', ['concursos/baremo',"cod_con" => $_GET["cod_con"],"des_con" => $_GET["des_con"],"cod_sol" => $solicitudConcurso->cod_sol , "cod_tip_con" => $_GET["cod_tip_con"] ], ['class' => 'btn btn-success']) ;
                    }
                }
                echo '</div>';
            }

            ?>
        </div>
    </div>
</div>