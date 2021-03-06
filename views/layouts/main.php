<?php

use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use app\assets\AppAsset;
use app\models\User;
use yii\helpers\Url;

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
                    ['label' => 'Acerca de', 'url' => ['/site/about'], 'visible' => !Yii::$app->user->isGuest],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Usuarios', 'url' => ['/user/index'], 'visible' => false] :
                            ['label' => 'Usuarios', 'url' => ['/user/index'], 'visible' => User::isUserAdmin(Yii::$app->user->identity->id)],
                    ['label' => 'Contacto', 'url' => ['/site/contacto']],
                    ['label' => 'Registro', 'url' => ['/site/registro'], 'visible' => Yii::$app->user->isGuest],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Interinos', 'url' => ['/interinos/interinos'], 'visible' => false] :
                            ['label' => 'Interinos', 'url' => ['/interinos/interinos'], 'visible' => Yii::$app->user->identity->interinos == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Actos', 'url' => ['/actos/actos'], 'visible' => false] :
                            ['label' => 'Actos', 'url' => ['/actos/actos'], 'visible' => Yii::$app->user->identity->actos == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Concursos', 'url' => ['/concursos/concrusos'], 'visible' => false] :
                            ['label' => 'Concursos', 'url' => ['/concursos/concursos'], 'visible' => Yii::$app->user->identity->concursos == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Oposiciones', 'url' => ['/oposiciones/oposiciones'], 'visible' => false] :
                            ['label' => 'Oposiciones', 'url' => ['/oposiciones/oposiciones'], 'visible' => Yii::$app->user->identity->oposiciones == 1],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Modificar el usuario', 'visible' => false] :
                            ['label' => 'Modificar el usuario', 'url' => Url::toRoute(["user/update", "id" => Yii::$app->user->identity->id])],
                    Yii::$app->user->isGuest ?
                            ['label' => 'Acceder', 'url' => ['/site/login']] :
                           // ['label' => 'Salir (' . Yii::$app->user->identity->username . ' i ' . Yii::$app->user->identity->interinos . ' a ' . Yii::$app->user->identity->actos . ' c ' . Yii::$app->user->identity->concursos . ' o ' . Yii::$app->user->identity->oposiciones . ')',
                            ['label' => 'Salir (' . Yii::$app->user->identity->username .')',
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
                <p class="pull-left">&copy; Mi Carpeta  <?= Yii::$app->params["version"] .' '. date('Y') . ' webServices ' . Yii::$app->params["servidor"] ?></p>
                <p class="pull-right"><?= Yii::powered() ?></p>
            </div>
        </footer>

        <?php $this->endBody() ?>
    </body>
</html>
<?php $this->endPage() ?>
