<?php

use yii\helpers\Url;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\data\Pagination;
use yii\widgets\LinkPager;
?>

<a href="<?= Url::toRoute("site/create") ?>">Crear un nuevo usuario</a>

<?php
$f = ActiveForm::begin([
            "method" => "get",
            "action" => Url::toRoute("user/index"),
            "enableClientValidation" => true,
        ]);
?>

<div class="form-group">
<?= $f->field($form, "q")->input("search") ?>
</div>

<?= Html::submitButton("Buscar", ["class" => "btn btn-primary"]) ?>

<?php $f->end() ?>

<h3><?= $search ?></h3>

<h3>Usuarios</h3>
<table class="table table-bordered">
    <tr>
        <th>Nombre</th>
        <th>email</th>
        <th>dni</th>
        <th>Rol</th>
        <th>contraseña</th>
        <th>int</th>
        <th>act</th>
        <th>con</th>
        <th>opo</th>
        <th></th>
        <th></th>
    </tr>
<?php foreach ($model as $row): ?>
        <tr>
            <td><?= $row->username ?></td>
            <td><?= $row->email ?></td>>
            <td><?= $row->dni ?></td>
            <td><?= $row->role ?></td>
            <td><?= $row->contraseña ?></td>
            <td><?= $row->interinos ?></td>
            <td><?= $row->actos ?></td>
            <td><?= $row->concursos ?></td>
            <td><?= $row->oposiciones ?></td>


            <td><a href="<?= Url::toRoute(["user/update", "id" => $row->id]) ?>">Editar</a></td>
            <td>
                <a href="#" data-toggle="modal" data-target="#id_alumno_<?= $row->id ?>">Eliminar</a>
                <div class="modal fade" role="dialog" aria-hidden="true" id="id_alumno_<?= $row->id ?>">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title">Eliminar usuario</h4>
                            </div>
                            <div class="modal-body">
                                <p>¿Realmente deseas eliminar al alumno con nombre <?= $row->username ?>?</p>
                            </div>
                            <div class="modal-footer">
    <?= Html::beginForm(Url::toRoute("user/delete"), "POST") ?>
                                <input type="hidden" name="id" value="<?= $row->id ?>">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                <button type="submit" class="btn btn-primary">Eliminar</button>
    <?= Html::endForm() ?>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
            </td>
        </tr>
<?php endforeach ?>
</table>

<?=
LinkPager::widget([
    "pagination" => $pages,
]);
