<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
use yii\web\Session;

$session = Yii::$app->session;
$session->open();
//    echo("<pre>");
//    print_r($_SESSION);
//    echo ("</pre>");
$this->title = 'BAREMO SOLICITUD ' . Html::encode($_GET["cod_sol"]);
$this->params['breadcrumbs'][] = ['label' => 'CONCURSO DE TRASLADOS', 'url' => ['concursos']];
$this->params['breadcrumbs'][] = ['label' => 'SOLICITUDES '.  $session->get('des_con_sel'), 'url' => ['solicitudes','cod_con' => Html::encode($_GET["cod_con"]),'des_con' => $session->get('des_con_sel'), 'cod_tip_con' => $_GET["cod_tip_con"]]];
$this->params['breadcrumbs'][] = $this->title;
if (Html::encode($_GET["cod_tip_con"] == 'P')) {
    $urlPrimaria =   Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri/servicioConcursosPrimaria.php";
    $uriPri = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtPri";
    $clienteConcursosPrimaria = new SoapClient(null, array('location' => $urlPrimaria, 'uri' => $uriPri));
    $solicitudesConcursoBaremada = $clienteConcursosPrimaria->getSolicitudesConcursoBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, Html::encode($_GET["cod_sol"]));
}
else{
    $urlSecundaria = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec/servicioConcursosSecundaria.php";
    $uriSec = Yii::$app->params["servidor"] ."/serviciosMiCarpetaCtSec";
    $clienteConcursosSecundaria = new SoapClient(null, array('location' => $urlSecundaria, 'uri' => $uriSec));
    $solicitudesConcursoBaremada = $clienteConcursosSecundaria->getSolicitudesConcursoBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, Html::encode($_GET["cod_sol"]));
}
?>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Resultado total</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->res_tot ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_1_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_1_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_1_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_1_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_1_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_1_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_2_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_2_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_2_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_2_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 1_2_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_1_2_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_1_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_1_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_1_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_1_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_1_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_1_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_1_4</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_1_4  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_2_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_2_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_2_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_2_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_2_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_2_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_2_4</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_2_4  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 3_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_3_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 4</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_4  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 4_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_4_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 4_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_4_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 4_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_4_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 5</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_5  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 5_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_5_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 5_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_5_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 5_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_5_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 6</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_6  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 6_1</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_6_1  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 6_2</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_6_2  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 6_3</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_6_3  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 6_4</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_6_4  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 6_5</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_6_5  ?>
    </div>
</div>     
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Apartado 6_6</h3>
    </div>
    <div class="panel-body">
        <?= $solicitudesConcursoBaremada->apa_6_6 ?>
    </div>
</div>   