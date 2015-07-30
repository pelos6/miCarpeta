<?php

use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use app\assets\AppAsset;
use app\models\User;

/* @var $this \yii\web\View */
/* @var $content string */

AppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
    <head>
        <meta charset="<?= Yii::$app->charset ?>">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <?= Html::csrfMetaTags() ?>
        <title><?= Html::encode($this->title) ?></title>
        <?php $this->head() ?>
    </head>
    <body>

        <?php $this->beginBody() ?>
        <div class="wrap">
            <?php
            //error_log('DEBUG: main.php el id ' . Yii::$app->user->id);
            NavBar::begin([
                'brandLabel' => 'Mi Carpeta ',
                'brandUrl' => Yii::$app->homeUrl,
                'options' => [
                    'class' => 'navbar-inverse navbar-fixed-top',
                ],
            ]);
            echo Nav::widget([
                'options' => ['class' => 'navbar-nav navbar-right'],
                'items' => [
                    ['label' => 'Inicio', 'url' => ['/site/index']],
                    //['label' => 'Formulario', 'url' => ['/site/entry'], 'visible' => !Yii::$app->user->isGuest],
                    //['label' => 'Saludo', 'url' => ['/site/saluda']],
                    // ['label' => 'Paises', 'url' => ['/country/index'], 'visible' => !Yii::$app->user->isGuest],
                    // ['label' => 'Usuarios', 'url' => ['/user/index'], 'visible' => Yii::$app->user->id == 1],
                    ['label' => 'Acerca de', 'url' => ['/site/about'], 'visible' => !Yii::$app->user->isGuest],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Usuarios', 'url' => ['/user/index'], 'visible' => false] :
                            ['label' => 'Usuarios', 'url' => ['/user/index'], 'visible' => User::isUserAdmin(Yii::$app->user->identity->id)],
                    ['label' => 'Conversión', 'url' => ['/site/conversion']],
                    ['label' => 'Contacto', 'url' => ['/site/contacto']],
                    ['label' => 'Registro', 'url' => ['/site/registro'], 'visible' => Yii::$app->user->isGuest],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Interinos', 'url' => ['/interinos/interinos'], 'visible' => false] :
                            ['label' => 'Interinos', 'url' => ['/interinos/interinos'], 'visible' => Yii::$app->user->identity->interinos == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Actos', 'url' => ['/site/actos'], 'visible' => false] :
                            ['label' => 'Actos', 'url' => ['/site/actos'], 'visible' => Yii::$app->user->identity->actos == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Concursos', 'url' => ['/site/concrusos'], 'visible' => false] :
                            ['label' => 'Concursos', 'url' => ['/site/concursos'], 'visible' => Yii::$app->user->identity->concursos == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Oposiciones', 'url' => ['/site/oposiciones'], 'visible' => false] :
                            ['label' => 'Oposiciones', 'url' => ['/site/oposiciones'], 'visible' => Yii::$app->user->identity->oposiciones == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Acceder', 'url' => ['/site/login']] :
                            ['label' => 'Salir (' . Yii::$app->user->identity->username . ' i ' . Yii::$app->user->identity->interinos . ' a ' . Yii::$app->user->identity->actos . ' c ' . Yii::$app->user->identity->concursos . ' o ' . Yii::$app->user->identity->oposiciones . ')',
                        'url' => ['/site/logout'],
                        'linkOptions' => ['data-method' => 'post']],
                ],
            ]);
            NavBar::end();
            ?>

            <div class="container">
                <?=
                Breadcrumbs::widget([
                    'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
                ])
                ?>
                <?= $content ?>
            </div>
        </div>

        <footer class="footer">
            <div class="container">
                <p class="pull-left">&copy; Mi Carpeta <?= date('Y') . ' webServices ' . Yii::$app->params["servidor"] ?></p>
                <p class="pull-right"><?= Yii::powered() ?></p>
            </div>
        </footer>

        <?php $this->endBody() ?>
    </body>
</html>
<?php $this->endPage() ?>
