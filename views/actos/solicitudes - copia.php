<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
use yii\web\Session;

$session = Yii::$app->session;
$session->open();
$session->set('tex_opc_sel', Html::encode($_GET["tex_opc"]));
//echo("<pre>");
//print_r($_SESSION);
//echo ("</pre>");
$this->title = 'solicitudes ' . Html::encode($_GET["tex_opc"]);
$this->params['breadcrumbs'][] = ['label' => 'Actos', 'url' => ['actos']];
$this->params['breadcrumbs'][] = $this->title;

$urlSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi/servicioSigi.php";
$uriSigi = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigi";
$clienteSigi = new SoapClient(null, array('location' => $urlSigi, 'uri' => $uriSigi));
?>
<div class="site-about">
    <h4> Solicitudes presentadas al acto de elección  </h4> 
    <div class="alert alert-success">
        <?php
        $solicitudesActo = $clienteSigi->getSolicitudesActo(Html::encode($_GET["cod_opc"]), Yii::$app->user->identity->dni);
        foreach ($solicitudesActo as $solicitudesActo) {
            echo '<div class="panel panel-success">';
            echo '<a href="' . Url::toRoute(["actos/solicitud", "cod_opc" => $solicitudesActo->cod_opc, "cod_sol" => $solicitudesActo->cod_sol]) . '">' . $solicitudesActo->cod_sol . "</a><br />\n";
            echo Html::a('Vacantes pedidas', ['actos/vacantes',"cod_opc" => $_GET["cod_opc"],"tex_opc" => $_GET["tex_opc"],"modo" => '3'], ['class' => 'btn btn-success']) ;
            echo '</div>';
        }

        ?>
    </div>

</div>