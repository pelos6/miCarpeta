<?php

namespace app\controllers;

use Yii;
use app\models\User;
use app\models\UserSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use app\models\FormSearch;
use app\models\Users;
use yii\data\Pagination;
use yii\helpers\Html;
use yii\helpers\Url;
use app\models\UsuarioForm;

/**
 * UserController implements the CRUD actions for User model.
 */
class InterinosController extends Controller {

    public function behaviors() {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }

    public function actionInterinos() {
        return $this->render('interinos');
    }

    public function actionConvocatoria() {
        return $this->render('convocatoria');
    }

    public function actionSolicitudes() {
        return $this->render('solicitudes');
    }

    public function actionSolicitud() {
        return $this->render('solicitud');
    }

}
