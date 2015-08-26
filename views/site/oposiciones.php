<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
$this->title = 'Oposiciones';
$this->params['breadcrumbs'][] = $this->title;
/* desde local */
//$urlSigicon = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpetaSigicon/servicioInterinos.php";
//$uriSigicon = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpetaSigicon";
/* desde infenlaces */
//$urlSigi = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta/servicioOposiciones.php";
//$uriSigi = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta";
/* desde  apostayadrede.com webserv.centroinf.com */
//$urlSigi = "http://apostayadrede.com/serviciosMiCarpetaSigi/servicioActos.php";
//$uriSigi = "http://apostayadrede.com/serviciosMiCarpetaSigi";

$urlSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon/servicioSigicon.php";
$uriSigicon = Yii::$app->params["servidor"] . "/serviciosMiCarpetaSigicon";
$clienteSigicon = new SoapClient(null, array('location' => $urlSigicon, 'uri' => $uriSigicon));
?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>
    <h3>Oposiciones información general</h3>
    <p>
        Información general sobre Oposiciones. sdsdssdss 
    </p>
    <div class="alert alert-success"> 
        <?php
        $oposicionesActivas = $clienteSigicon->getOposicionesActivas();
        foreach ($oposicionesActivas as $oposicionActiva) {
            echo $oposicionActiva->des_con . ' ' . $oposicionActiva->cod_tip_con . "<br />\n";
        }
//    echo("<pre>");
//    print_r($oposicionesActivas);
//    echo ("</pre>");
        ?>
    </div>
    <h3>Oposiciones información personal. </h3>
    <h4>Situación de las solicitudes del usuario en las oposiciones.</h4> 
    <div class="alert alert-success"> 
        <?php
        $solicitudesOposiciones = $clienteSigicon->getSolicitudesOposiciones(Yii::$app->user->identity->dni);
        foreach ($solicitudesOposiciones as $solicitudOposicion) {
            echo $solicitudOposicion->des_con . ' ' . $solicitudOposicion->cod_sol . ' ' . $solicitudOposicion->estado . "<br />\n";
        }
//    echo("<pre>");
//    print_r($solicitudesOposiciones);
//    echo ("</pre>");
        ?>
    </div>
    <p>
        <?= Yii::$app->params["servidor"] ?>
    </p>    
</div>