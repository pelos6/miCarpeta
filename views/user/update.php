<?php
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
?>

<a href="<?= Url::toRoute("user/index") ?>">Ir a la lista de usuarios</a>

<h1>Editar usuario con id <?= Html::encode($_GET["id"]) ?></h1>

<h3><?= $msg ?></h3>

<?php $form = ActiveForm::begin([
    "method" => "post",
    'enableClientValidation' => true,
]);
?>

<?= $form->field($model, "id")->input("hidden")->label(false) ?>

<div class="form-group">
 <?= $form->field($model, "username")->input("text") ?>   
</div>

<div class="form-group">
 <?= $form->field($model, "email")->input("text") ?>   
</div>

<div class="form-group">
 <?= $form->field($model, "role")->input("text") ?>   
</div>

<p>Por favor indique al menos un tema de interes:</p>
<?= $form->field($model, 'interinos')->checkbox() ?>
<?= $form->field($model, 'actos')->checkbox() ?>
<?= $form->field($model, 'concursos')->checkbox() ?>
<?= $form->field($model, 'oposiciones')->checkbox() ?>

<?= Html::submitButton("Actualizar", ["class" => "btn btn-primary"]) ?>

<?php $form->end() ?>

