<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \models\RegisterForm */

$this->title = 'Registro';
$this->params['breadcrumbs'][] = $this->title;
?>
<h1><?= Html::encode($this->title) . ' casi 10' ?></h1>
<h3><?= $msg ?></h3>

<?php
$form = ActiveForm::begin([
            'method' => 'post',
            'id' => 'formulario',
            'enableClientValidation' => false,
            'enableAjaxValidation' => true,
        ]);
?>
<div class="form-group">
    <?= $form->field($model, "username")->input("text") ?>   
</div>

<div class="form-group">
    <?= $form->field($model, "dni")->input("dni") ?>   
</div>

<div class="form-group">
    <?= $form->field($model, "email")->input("email") ?>   
</div>

<div class="form-group">
    <?= $form->field($model, "password")->input("password") ?>   
</div>

<div class="form-group">
<?= $form->field($model, "password_repeat")->input("password") ?>   
</div>

<p>Por favor indique al menos un tema de interes:</p>
<?= $form->field($model, 'interinos')->checkbox() ?>
<?= $form->field($model, 'actos')->checkbox() ?>
<?= $form->field($model, 'concursos')->checkbox() ?>
<?= $form->field($model, 'oposiciones')->checkbox() ?>

<?= Html::submitButton("Registro", ["class" => "btn btn-primary"]) ?>

<?php $form->end() ?>