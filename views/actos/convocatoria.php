<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

$this->title = Html::encode($_GET["tex_opc"]);
$this->params['breadcrumbs'][] = ['label' => 'ACTOS DE ELECCIÓN', 'url' => ['actos']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
$actoActivo = $clienteSigi->getActoActivo($_GET["cod_opc"]);

?>

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Codigo de convocatoria</h3>
    </div>
    <div class="panel-body">
        <?= Html::encode($_GET["cod_opc"]) ?>
    </div>
</div>    
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Descripción de convocatoria</h3>
    </div>
    <div class="panel-body">
         <?= Html::encode($_GET["tex_opc"]) ?>
    </div>
</div>  
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Tipo del acto de elección</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->cod_tip_ae ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha del acto de elección</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->f_con_ae ?>
    </div>
</div>  

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha inicio de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->f_ini_opc ?>
    </div>
</div> 
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Fecha fin de solicitudes</h3>
    </div>
    <div class="panel-body">
        <?= $actoActivo->f_fin_opc ?>
    </div>
</div>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">Enlace a la convocatoria.</h3>
    </div>
    <div class="panel-body">
        <?= '<a href="' . $actoActivo->url . '" target="_blank">' . "SIGI" . "</a><br />\n"; ?>
    </div>
</div>  

    <div class="panel-body">
       <?php
       if (Html::encode($_GET["modo"]) == '1' ) {
            echo Html::a('Vacantes ofertadas', ['actos/vacantes',"cod_opc" => $_GET["cod_opc"],"tex_opc" => $_GET["tex_opc"],"modo" => '1'], ['class' => 'btn btn-success']) ;
        } else {
            echo Html::a('Vacantes seleccionables', ['actos/vacantes',"cod_opc" => $_GET["cod_opc"],"tex_opc" => $_GET["tex_opc"],"modo" => '2'], ['class' => 'btn btn-success']) ;
        }
       ?>
    </div>