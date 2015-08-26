<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
$this->title = 'Interinos';
$this->params['breadcrumbs'][] = $this->title;
/* desde local */
$url = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta/servicio.php";
$uri = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta";
/* desde infenlaces */
//$url = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta/servicio.php";
//$uri = "http://javieriranzo.infenlaces.com/serviciosMiCarpeta";
//Creamos un cliente para llamar a esa URL. 
//Es obligatorio establecer el parámetro 'uri' al no tener WSDL , igual que ocurría al instanciar el objeto SoapServer
$cliente = new SoapClient(null, array('location' => $url, 'uri' => $uri));
echo 'Ahora por ejemplo podemos consumir el servicio contra la base de datos serviciosMiCarpeta ';
?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>
    <div class="alert alert-success">
        <?= $cliente->getEstaConvocado(Yii::$app->user->identity->dni); ?>
    </div>
    <h3>Interinos información general</h3>

    <h2>Las Familias : </h2>

    <?php
    $actosActivos = $cliente->getActosActivos();
    echo("<pre>");
    print_r($actosActivos);
    echo ("</pre>");
    ?>
    <p>
        Información general sobre lista de interinos
    </p>

    <h3>Interinos información personal</h3>
    <p>
        Información personal sobre lista de interinos
    </p>

</div>