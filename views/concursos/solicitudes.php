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
    <div class="alert alert-success">
        <?php
        foreach ($solicitudesConcurso as $solicitudConcurso) {
            echo '<a href="' . Url::toRoute(["concursos/solicitud", "cod_tip_con" => Html::encode($_GET["cod_tip_con"]),  "cod_con" => $solicitudConcurso->cod_con, "cod_sol" => $solicitudConcurso->cod_sol]) . '">' . $solicitudConcurso->cod_sol . "</a><br />\n";
        }

        ?>
    </div>

</div>