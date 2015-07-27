<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
$this->title = 'conversion';
$this->params['breadcrumbs'][] = $this->title;
/* desde local */
/*$urlActos = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta/servicioActos.php";
$uriActos = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta";
$clienteActos = new SoapClient(null, array('location' => $urlActos, 'uri' => $uriActos));*/
/* desde infenlaces */
$urlActos = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta/servicioActos.php";
$uriActos = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta";
$clienteActos = new SoapClient(null, array('location' => $urlActos, 'uri' => $uriActos));
/* desde local */
$urlInterinos = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta/servicioInterinos.php";
$uriInterinos = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta";
/* desde infenlaces */
//$url = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta/servicioInterinos.php";
//$uri = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta";
//Creamos un cliente para llamar a esa URL. 
//Es obligatorio establecer el parámetro 'uri' al no tener WSDL , igual que ocurría al instanciar el objeto SoapServer
$clienteInterinos = new SoapClient(null, array('location' => $urlInterinos, 'uri' => $uriInterinos));
?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>

    <h3>Interinos información general.</h3>
    <div class="alert alert-success">
        <?= $clienteActos->getEstaConvocado(Yii::$app->user->identity->dni); ?>
    </div>
    <?php
    $convocatoriasListasActivas = $clienteInterinos->getConvocatoriasListasActivas();
    foreach ($convocatoriasListasActivas as $convocatoriaListaActiva){
        echo $convocatoriaListaActiva->des_con ."<br />\n";
   }
    echo("<pre>");
    print_r($convocatoriasListasActivas);
    echo ("</pre>");
    ?>
    <h3>Interinos información personal</h3>

    <h4>Situación del participante en listas</h4> 
     <?php
    $consultasSituacionListas = $clienteActos->getConsultasSituacionListas(Yii::$app->user->identity->dni);
    foreach ($consultasSituacionListas as $consultaSituacionListas){
        echo $consultaSituacionListas->tex_opc ."<br />\n";
   }
//    echo("<pre>");
//    print_r($convocatoriasListasActivas);
//    echo ("</pre>");
    ?>
 
    <h4>Situación de las solicitudes del usuario a listas.</h4> 
      <?php
    $solicitudesListas = $clienteInterinos->getSolicitudesListas(Yii::$app->user->identity->dni);
    foreach ($solicitudesListas as $solicitudLista){
        echo $solicitudLista->des_con .' '.$solicitudLista->cod_sol.' '.$solicitudLista->estado ."<br />\n";
   }
//    echo("<pre>");
//    print_r($solicitudesListas);
//    echo ("</pre>");
//    ?>
    
</div>