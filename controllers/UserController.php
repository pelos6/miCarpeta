<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
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
class UserController extends Controller {


    public function behaviors() {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['index', 'view','create', 'update', 'delete'],
                'rules' => [
                    [
                        //El administrador tiene permisos sobre las siguientes acciones
                        'actions' => ['index', 'create', 'view', 'update', 'delete'],
                        //Esta propiedad establece que tiene permisos
                        'allow' => true,
                        //Usuarios autenticados, el signo ? es para invitados
                        'roles' => ['@'],
                        //Este método nos permite crear un filtro sobre la identidad del usuario
                        //y así establecer si tiene permisos o no
                                'matchCallback' => function ($rule, $action) {
                            //Llamada al método que comprueba si es un administrador
                            return User::isUserAdmin(Yii::$app->user->identity->id);
                            }
                        ],
                          [
                        //Los usuarios simples tienen permisos sobre las siguientes acciones
                        'actions' => ['update'],
                        //Esta propiedad establece que tiene permisos
                        'allow' => true,
                        //Usuarios autenticados, el signo ? es para invitados
                        'roles' => ['@'],
                        //Este método nos permite crear un filtro sobre la identidad del usuario
                        //y así establecer si tiene permisos o no
                                'matchCallback' => function ($rule, $action) {
                            //Llamada al método que comprueba si es un administrador
                            return User::isUserSimple(Yii::$app->user->identity->id);
                            }
                        ]
                    ]
                ],

            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }

    public function actionIndex() {
        $form = new FormSearch;
        $search = null;
        error_log('DEBUG: actionIndex 1' ) ;
        if ($form->load(Yii::$app->request->get())) {
            if ($form->validate()) {
                $search = Html::encode($form->q);
                /* $table = Users::find()
                  ->where(["like", "id", $search])
                  ->orWhere(["like", "nombre", $search])
                  ->orWhere(["like", "apellidos", $search]); */
                $table = Users::find()
                        ->where(["like", "id", $search])
                        ->orWhere(["like", "username", $search]);
                $count = clone $table;
                $pages = new Pagination([
                    "pageSize" => 10,
                    "totalCount" => $count->count()
                ]);
                $model = $table
                        ->offset($pages->offset)
                        ->limit($pages->limit)
                        ->all();
            } else {
                $form->getErrors();
            }
        } else {
               error_log('DEBUG: actionIndex 2' ) ;
            $table = Users::find();
            $count = clone $table;
            $pages = new Pagination([
                "pageSize" => 10,
                "totalCount" => $count->count(),
            ]);
            $model = $table
                    ->offset($pages->offset)
                    ->limit($pages->limit)
                    ->all();
        }
        return $this->render("index", ["model" => $model, "form" => $form, "search" => $search, "pages" => $pages]);
    }

    /**
    * ESTA NO SE USA
     * Lists all User models.
     * @return mixed
     */
    public function action1Index() {
        $searchModel = new UserSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
                    'searchModel' => $searchModel,
                    'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single User model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id) {
        return $this->render('view', [
                    'model' => $this->findModel($id),
        ]);
    }
  public function actionCreate()
    {
        $model = new UsuarioForm;
        $msg = null;
        if($model->load(Yii::$app->request->post()))
        {
            if($model->validate())
            {
              /*  $table = new Alumnos;
                $table->nombre = $model->nombre;
                $table->apellidos = $model->apellidos;
                $table->clase = $model->clase;
                $table->nota_final = $model->nota_final;*/
                $table = new Users;
                 $table->username = $model->username;
                    $table->role = $model->role;
                    $table->email = $model->email;
                    $table->interinos = $model->interinos;
                    $table->actos = $model->actos;
                    $table->concursos = $model->concursos;
                    $table->oposiciones = $model->oposiciones;
                if ($table->insert())
                {
                    $msg = "Enhorabuena registro guardado correctamente";
                    $model->role = null;
                    $model->email = null;
                    $model->username = null;
                    $model->interinos = null;
                    $model->actos = null;
                    $model->concursos = null;
                    $model->oposiciones = null;
                }
                else
                {
                    $msg = "Ha ocurrido un error al insertar el registro";
                }
            }
            else
            {
                $model->getErrors();
            }
        }
        return $this->render("create", ['model' => $model, 'msg' => $msg]);
    }


    /**
     * Creates a new User model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate1() {
        $model = new User();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('create', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing User model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate1($id) {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('update', [
                        'model' => $model,
            ]);
        }
    }

    public function actionUpdate() {
        $model = new UsuarioForm;
        $msg = null;
        // validando la modificación
        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                error_log('DEBUG 2: ' . $model->id . ' ' . $model->username);
                $table = Users::findOne($model->id);
                if ($table) {
                    $table->username = $model->username;
                   // $table->role = $model->role;
                    $table->email = $model->email;
                    $table->interinos = $model->interinos;
                    $table->actos = $model->actos;
                    $table->concursos = $model->concursos;
                    $table->oposiciones = $model->oposiciones;
                    try {
                        /* if ($table->update()) {
                          $msg = "El Usuario ha sido actualizado correctamente";
                          } else {
                          $msg = "El Usuario no ha podido ser actualizado";
                          } */
                        $table->update();
                        //$msg = "El Usuario ha sido actualizado correctamente";
                        $msg = "El Usuario ha sido actualizado correctamente, redireccionando a la página de inicio ...";
                        $msg .= "<meta http-equiv='refresh' content='3; " . Url::toRoute("site/login") . "'>";
                    } catch (\Exception $e) {
                        $msg = "El Usuario no ha podido ser actualizado " . $e;
                        // throw $e;
                    }
                } else {
                    $msg = "El Usuario seleccionado no ha sido encontrado";
                }
            } else {
                // si la modificación no es correcta ... a corregirla
                $model->getErrors();
                return $this->render("update", ["model" => $model, "msg" => $msg]);
            }
        }

        // si todo ha ido bien se recupera de la base de datos y se muestra
        if (Yii::$app->request->get("id")) {
            $id = Html::encode($_GET["id"]);
            if ((int) $id) {
                $table = Users::findOne($id);
                if ($table) {
                    $model->id = $table->id;
                    $model->username = $table->username;
                    $model->email = $table->email;
                    $model->role = $table->role;
                    $model->interinos = $table->interinos;
                    $model->actos = $table->actos;
                    $model->concursos = $table->concursos;
                    $model->oposiciones = $table->oposiciones;
                } else {
                    return $this->redirect(["user/index"]);
                }
            } else {
                return $this->redirect(["user/index"]);
            }
        } else {
            return $this->redirect(["user/index"]);
        }
        
        
        return $this->render("update", ["model" => $model, "msg" => $msg]);
    }

    /**
     * Deletes an existing User model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete1($id) {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    public function actionDelete() {
        if (Yii::$app->request->post()) {
            $id = Html::encode($_POST["id"]);
            if ((int) $id) {
                if (Users::deleteAll("id=:id", [":id" => $id])) {
                    echo "Usuario con id $id eliminado con éxito, redireccionando ...";
                    echo "<meta http-equiv='refresh' content='3; " . Url::toRoute("user/index") . "'>";
                } else {
                    echo "Ha ocurrido un error al eliminar el usuario, redireccionando ...";
                    echo "<meta http-equiv='refresh' content='3; " . Url::toRoute("user/index") . "'>";
                }
            } else {
                echo "Ha ocurrido un error al eliminar el usuario, redireccionando ...";
                echo "<meta http-equiv='refresh' content='3; " . Url::toRoute("user/index") . "'>";
            }
        } else {
            return $this->redirect(["user/index"]);
        }
    }

    /**
     * Finds the User model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return User the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id) {
        if (($model = User::findOne($id)) !== null) {
            error_log('en findModel ' . $model->username);
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

}
