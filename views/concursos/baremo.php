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
$this->params['breadcrumbs'][] = ['label' => 'SOLICITUDES ' . $session->get('des_con_sel'), 'url' => ['solicitudes', 'cod_con' => Html::encode($_GET["cod_con"]), 'des_con' => $session->get('des_con_sel'), 'cod_tip_con' => $_GET["cod_tip_con"]]];
$this->params['breadcrumbs'][] = $this->title;
if (Html::encode($_GET["cod_tip_con"] == 'P')) {
    $urlPrimaria = Yii::$app->params["servidor"] . "/serviciosMiCarpetaCtPri/servicioConcursosPrimaria.php";
    $uriPri = Yii::$app->params["servidor"] . "/serviciosMiCarpetaCtPri";
    $clienteConcursosPrimaria = new SoapClient(null, array('location' => $urlPrimaria, 'uri' => $uriPri));
    $solicitudesConcursoBaremada = $clienteConcursosPrimaria->getSolicitudesConcursoBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, Html::encode($_GET["cod_sol"]));
} else {
    $urlSecundaria = Yii::$app->params["servidor"] . "/serviciosMiCarpetaCtSec/servicioConcursosSecundaria.php";
    $uriSec = Yii::$app->params["servidor"] . "/serviciosMiCarpetaCtSec";
    $clienteConcursosSecundaria = new SoapClient(null, array('location' => $urlSecundaria, 'uri' => $uriSec));
    $solicitudesConcursoBaremada = $clienteConcursosSecundaria->getSolicitudesConcursoBaremada(Html::encode($_GET["cod_con"]), Yii::$app->user->identity->dni, Html::encode($_GET["cod_sol"]));
}
?>
<h4> Baremo obtenido sobre los méritos presentados. </h4> 
<table class="table table-bordered">
    <tbody>
        <tr class="active">
            <td colspan="5">Apartado I.  ANTIGÜEDAD. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_1 ?></td>
        </tr>
        <tr class="active">
            <td colspan="5">Apartado I-1.  ANTIGÜEDAD CENTRO. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_1_1 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 1.1.1 </td>
            <td>Apartado 1.1.2 </td>
            <td>Apartado 1.1.3 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudesConcursoBaremada->apa_1_1_1 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_1_1_2 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_1_1_3 ?> </td>
        </tr>
        <tr class="active">
            <td colspan="5">Apartado I-2.  ANTIGÜEDAD CUERPO. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_1_2 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 1.2.1 </td>
            <td>Apartado 1.2.2 </td>
            <td>Apartado 1.2.3 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudesConcursoBaremada->apa_1_2_1 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_1_2_2 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_1_2_3 ?> </td>
        </tr>
        <tr class="active">
            <td colspan="5">Apartado II.  CATEDRÁTICO. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_2 ?></td>
        </tr>
        <tr class="active">
            <td colspan="5">Apartado III.  MERITOS ACADÉMICOS. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_3 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 3.1 </td>
            <td>Apartado 3.2 </td>
            <td>Apartado 3.3 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudesConcursoBaremada->apa_3_1 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_3_2 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_3_3 ?></td>
        </tr>
        <tr class="active">
            <td colspan="5">Apartado IV.  DESEMPEÑO CARGOS DIRECTIVOS. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_4 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 4.1 </td>
            <td>Apartado 4.2 </td>
            <td>Apartado 4.3 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudesConcursoBaremada->apa_4_1 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_4_2 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_4_3 ?></td>
        </tr>
        <tr class="active">
            <td colspan="5">Apartado V.  FORMACIÓN Y PERFECCIONAMIENTO. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_5 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 5.1 </td>
            <td>Apartado 5.2 </td>
            <td>Apartado 5.3 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudesConcursoBaremada->apa_5_1 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_5_2 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_5_3 ?></td>
        </tr>
        <tr class="active">
            <td colspan="5">Apartado VI.  OTROS MERITOS. </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->apa_6 ?></td>
        </tr>
        <tr class="info">
            <td>Apartado 6.1 </td>
            <td>Apartado 6.2 </td>
            <td>Apartado 6.3 </td>
            <td>Apartado 6.4 </td>
            <td>Apartado 6.5 </td>
            <td>Apartado 6.6 </td>
        </tr>
        <tr class="success">
            <td><?= $solicitudesConcursoBaremada->apa_6_1 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_6_2 ?> </td>
            <td><?= $solicitudesConcursoBaremada->apa_6_3 ?></td>
            <td><?= $solicitudesConcursoBaremada->apa_6_4 ?></td>
            <td><?= $solicitudesConcursoBaremada->apa_6_5 ?></td>
            <td><?= $solicitudesConcursoBaremada->apa_6_6 ?></td>
        </tr>
        <tr class="danger">
            <td colspan="5">Total . </td>
            <td colspan="1"><?= $solicitudesConcursoBaremada->res_tot ?></td>
        </tr>
    </tbody>
</table>
