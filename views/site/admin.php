<?php
use yii\helpers\Html;

/* @var $this yii\web\View */
$this->title = 'admin';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="site-about">
    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        This is the admin page. You may modify the following file to customize its content:
    </p>

    <code><?= __FILE__ ?></code>
</div>
