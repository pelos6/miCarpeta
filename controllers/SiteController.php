<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\filters\VerbFilter;
use app\models\LoginForm;
use app\models\ContactoForm;
use app\models\ValidarFormulario;
use app\models\ValidarFormularioAjax;
use yii\widgets\ActiveForm;
use yii\web\Response;
use app\models\FormAlumnos;
use app\models\Alumnos;
use app\models\FormSearch;
use app\models\RegistroForm;
use app\models\Users;
use yii\web\Session;
use app\models\FormRecoverPass;
use app\models\FormResetPass;
use yii\helpers\Html;
use yii\data\Pagination;
use yii\helpers\Url;
use app\models\User;

class SiteController extends Controller {

    public function actionRecoverpass() {
        //Instancia para validar el formulario
        $model = new FormRecoverPass;

        //Mensaje que será mostrado al usuario en la vista
        $msg = null;

        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                //Buscar al usuario a través del email
                $table = Users::find()->where("email=:email", [":email" => $model->email]);

                //Si el usuario existe
                if ($table->count() == 1) {
                    //Crear variables de sesión para limitar el tiempo de restablecido del password
                    //hasta que el navegador se cierre
                    $session = new Session;
                    $session->open();

                    //Esta clave aleatoria se cargará en un campo oculto del formulario de reseteado
                    $session["recover"] = $this->randKey("abcdef0123456789", 200);
                    $recover = $session["recover"];

                    //También almacenaremos el id del usuario en una variable de sesión
                    //El id del usuario es requerido para generar la consulta a la tabla users y 
                    //restablecer el password del usuario
                    $table = Users::find()->where("email=:email", [":email" => $model->email])->one();
                    $session["id_recover"] = $table->id;

                    //Esta variable contiene un número hexadecimal que será enviado en el correo al usuario 
                    //para que lo introduzca en un campo del formulario de reseteado
                    //Es guardada en el registro correspondiente de la tabla users
                    $verification_code = $this->randKey("abcdef0123456789", 8);
                    //Columna verification_code
                    $table->verification_code = $verification_code;
                    //Guardamos los cambios en la tabla users
                    $table->save();

                    //Creamos el mensaje que será enviado a la cuenta de correo del usuario
                    $subject = "Recuperar password";
                    $body = "<p>Copie el siguiente código de verificación para restablecer su password ... ";
                    $body .= "<strong>" . $verification_code . "</strong></p>";
                    $body .= "<p><a href='http://yii.local/index.php?r=site/resetpass'>Recuperar password</a></p>";

                    //Enviamos el correo
                    Yii::$app->mailer->compose()
                            ->setTo($model->email)
                            ->setFrom([Yii::$app->params["adminEmail"] => Yii::$app->params["title"]])
                            ->setSubject($subject)
                            ->setHtmlBody($body)
                            ->send();

                    //Vaciar el campo del formulario
                    $model->email = null;

                    //Mostrar el mensaje al usuario
                    $msg = "Le hemos enviado un mensaje a su cuenta de correo para que pueda resetear su password";
                } else { //El usuario no existe
                    $msg = "Ha ocurrido un error";
                }
            } else {
                $model->getErrors();
            }
        }
        return $this->render("recoverpass", ["model" => $model, "msg" => $msg]);
    }

    public function actionResetpass() {
        //Instancia para validar el formulario
        $model = new FormResetPass;

        //Mensaje que será mostrado al usuario
        $msg = null;

        //Abrimos la sesión
        $session = new Session;
        $session->open();

        //Si no existen las variables de sesión requeridas lo expulsamos a la página de inicio
        if (empty($session["recover"]) || empty($session["id_recover"])) {
            return $this->redirect(["site/index"]);
        } else {

            $recover = $session["recover"];
            //El valor de esta variable de sesión la cargamos en el campo recover del formulario
            $model->recover = $recover;

            //Esta variable contiene el id del usuario que solicitó restablecer el password
            //La utilizaremos para realizar la consulta a la tabla users
            $id_recover = $session["id_recover"];
        }

        //Si el formulario es enviado para resetear el password
        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                //Si el valor de la variable de sesión recover es correcta
                if ($recover == $model->recover) {
                    //Preparamos la consulta para resetear el password, requerimos el email, el id 
                    //del usuario que fue guardado en una variable de session y el código de verificación
                    //que fue enviado en el correo al usuario y que fue guardado en el registro
                    $table = Users::findOne(["email" => $model->email, "id" => $id_recover, "verification_code" => $model->verification_code]);

                    //Encriptar el password
                    $table->password = crypt($model->password, Yii::$app->params["salt"]);

                    //Si la actualización se lleva a cabo correctamente
                    if ($table->save()) {

                        //Destruir las variables de sesión
                        $session->destroy();

                        //Vaciar los campos del formulario
                        $model->email = null;
                        $model->password = null;
                        $model->password_repeat = null;
                        $model->recover = null;
                        $model->verification_code = null;

                        $msg = "Enhorabuena, password reseteado correctamente, redireccionando a la página de login ...";
                        $msg .= "<meta http-equiv='refresh' content='5; " . Url::toRoute("site/login") . "'>";
                    } else {
                        $msg = "Ha ocurrido un error";
                    }
                } else {
                    $model->getErrors();
                }
            }
        }

        return $this->render("resetpass", ["model" => $model, "msg" => $msg]);
    }

    private function randKey($str = '', $long = 0) {
        $key = null;
        $str = str_split($str);
        $start = 0;
        $limit = count($str) - 1;
        for ($x = 0; $x < $long; $x++) {
            $key .= $str[rand($start, $limit)];
        }
        return $key;
    }

    public function actionConfirm() {
        $table = new Users;
        if (Yii::$app->request->get()) {

            //Obtenemos el valor de los parámetros get
            $id = Html::encode($_GET["id"]);
            $authKey = $_GET["authKey"];

            if ((int) $id) {
                //Realizamos la consulta para obtener el registro
                $model = $table
                        ->find()
                        ->where("id=:id", [":id" => $id])
                        ->andWhere("authKey=:authKey", [":authKey" => $authKey]);

                //Si el registro existe
                if ($model->count() == 1) {
                    $activar = Users::findOne($id);
                    $activar->activate = 1;
                    if ($activar->update()) {
                        echo "Enhorabuena registro llevado a cabo correctamente, redireccionando ...";
                        echo "<meta http-equiv='refresh' content='2; " . Url::toRoute("site/login") . "'>";
                    } else {
                        echo "Ha ocurrido un error al realizar el registro, redireccionando ...";
                        echo "<meta http-equiv='refresh' content='8; " . Url::toRoute("site/login") . "'>";
                    }
                } else { //Si no existe redireccionamos a login
                    return $this->redirect(["site/login"]);
                }
            } else { //Si id no es un número entero redireccionamos a login
                return $this->redirect(["site/login"]);
            }
        }
    }

    public function actionRegistro() {
        //Creamos la instancia con el model de validación
        $model = new RegistroForm;

        //Mostrará un mensaje en la vista cuando el usuario se haya registrado
        $msg = null;

        //Validación mediante ajax
        if ($model->load(Yii::$app->request->post()) && Yii::$app->request->isAjax) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
        }

        //Validación cuando el formulario es enviado vía post
        //Esto sucede cuando la validación ajax se ha llevado a cabo correctamente
        //También previene por si el usuario tiene desactivado javascript y la
        //validación mediante ajax no puede ser llevada a cabo
        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                //Preparamos la consulta para guardar el usuario
                error_log('DEBUG1: usuario-->' . $model->username . ' interinos-->' . $model->interinos);
                $table = new Users;
                $table->username = $model->username;
                $table->dni = $model->dni;
                $table->email = $model->email;
                $table->interinos = $model->interinos;
                $table->actos = $model->actos;
                $table->concursos = $model->concursos;
                $table->oposiciones = $model->oposiciones;
                //Encriptamos el password
                $table->password = crypt($model->password, Yii::$app->params["salt"]);
                //Creamos una cookie para autenticar al usuario cuando decida recordar la sesión, esta misma
                //clave será utilizada para activar el usuario
                $table->authKey = $this->randKey("abcdef0123456789", 200);
                //Creamos un token de acceso único para el usuario
                $table->accessToken = $this->randKey("abcdef0123456789", 200);
                // guardo la contraseña en claro para poder acceder en pruebas
                $table->contraseña = $model->password;
                //Si el registro es guardado correctamente
                if ($table->insert()) {
                    //Nueva consulta para obtener el id del usuario
                    //Para confirmar al usuario se requiere su id y su authKey
                    $user = $table->find()->where(["email" => $model->email])->one();
                    $id = urlencode($user->id);
                    $authKey = urlencode($user->authKey);

                    $subject = "Confirmar registro";
                    $body = "<h1>Haga click en el siguiente enlace para finalizar su registro en MiCarpeta</h1>";
                    // para infenlaces
                    //$body .= "<a href='http://www.javieriranzo.infenlaces.com/proyecto/web/index.php?r=site/confirm&id=" . $id . "&authKey=" . $authKey . "'>Confirmar</a>";
                    // para desarrollo local
                    $body .= "<a href='http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/miCarpeta/web/index.php?r=site/confirm&id=" . $id . "&authKey=" . $authKey . "'>Confirmar</a>";

                    //Enviamos el correo
                    Yii::$app->mailer->compose()
                            ->setTo($user->email)
                            ->setFrom([Yii::$app->params["adminEmail"] => Yii::$app->params["title"]])
                            ->setSubject($subject)
                            ->setHtmlBody($body)
                            ->send();

                    $model->username = null;
                    $model->dni = null;
                    $model->email = null;
                    $model->password = null;
                    $model->password_repeat = null;
                    $model->interinos = false;
                    $model->actos = false;
                    $model->concursos = false;
                    $model->oposiciones = false;
                    $msg = "Enhorabuena, ahora sólo falta que confirmes tu registro en tu cuenta de correo";
                } else {
                    $msg = "Ha ocurrido un error al llevar a cabo tu registro";
                }
            } else {
                $model->getErrors();
            }
        }
        return $this->render("registro", ["model" => $model, "msg" => $msg]);
    }

    public function actionUpdate() {
        $model = new FormAlumnos;
        $msg = null;

        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                $table = Alumnos::findOne($model->id_alumno);
                if ($table) {
                    $table->nombre = $model->nombre;
                    $table->apellidos = $model->apellidos;
                    $table->clase = $model->clase;
                    $table->nota_final = $model->nota_final;
                    if ($table->update()) {
                        $msg = "El Alumno ha sido actualizado correctamente";
                    } else {
                        $msg = "El Alumno no ha podido ser actualizado";
                    }
                } else {
                    $msg = "El alumno seleccionado no ha sido encontrado";
                }
            } else {
                $model->getErrors();
            }
        }


        if (Yii::$app->request->get("id_alumno")) {
            $id_alumno = Html::encode($_GET["id_alumno"]);
            if ((int) $id_alumno) {
                $table = Alumnos::findOne($id_alumno);
                if ($table) {
                    $model->id_alumno = $table->id_alumno;
                    $model->nombre = $table->nombre;
                    $model->apellidos = $table->apellidos;
                    $model->clase = $table->clase;
                    $model->nota_final = $table->nota_final;
                } else {
                    return $this->redirect(["site/view"]);
                }
            } else {
                return $this->redirect(["site/view"]);
            }
        } else {
            return $this->redirect(["site/view"]);
        }
        return $this->render("update", ["model" => $model, "msg" => $msg]);
    }

    public function actionDelete() {
        if (Yii::$app->request->post()) {
            $id_alumno = Html::encode($_POST["id_alumno"]);
            if ((int) $id_alumno) {
                if (Alumnos::deleteAll("id_alumno=:id_alumno", [":id_alumno" => $id_alumno])) {
                    echo "Alumno con id $id_alumno eliminado con éxito, redireccionando ...";
                    echo "<meta http-equiv='refresh' content='3; " . Url::toRoute("site/view") . "'>";
                } else {
                    echo "Ha ocurrido un error al eliminar el alumno, redireccionando ...";
                    echo "<meta http-equiv='refresh' content='3; " . Url::toRoute("site/view") . "'>";
                }
            } else {
                echo "Ha ocurrido un error al eliminar el alumno, redireccionando ...";
                echo "<meta http-equiv='refresh' content='3; " . Url::toRoute("site/view") . "'>";
            }
        } else {
            return $this->redirect(["site/view"]);
        }
    }

    public function actionView() {
        $form = new FormSearch;
        $search = null;
        if ($form->load(Yii::$app->request->get())) {
            if ($form->validate()) {
                $search = Html::encode($form->q);
                $table = Alumnos::find()
                        ->where(["like", "id_alumno", $search])
                        ->orWhere(["like", "nombre", $search])
                        ->orWhere(["like", "apellidos", $search]);
                $count = clone $table;
                $pages = new Pagination([
                    "pageSize" => 1,
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
            $table = Alumnos::find();
            $count = clone $table;
            $pages = new Pagination([
                "pageSize" => 1,
                "totalCount" => $count->count(),
            ]);
            $model = $table
                    ->offset($pages->offset)
                    ->limit($pages->limit)
                    ->all();
        }
        return $this->render("view", ["model" => $model, "form" => $form, "search" => $search, "pages" => $pages]);
    }

    public function actionCreate() {
        $model = new FormAlumnos;
        $msg = null;
        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                $table = new Alumnos;
                $table->nombre = $model->nombre;
                $table->apellidos = $model->apellidos;
                $table->clase = $model->clase;
                $table->nota_final = $model->nota_final;
                if ($table->insert()) {
                    $msg = "Enhorabuena registro guardado correctamente";
                    $model->nombre = null;
                    $model->apellidos = null;
                    $model->clase = null;
                    $model->nota_final = null;
                } else {
                    $msg = "Ha ocurrido un error al insertar el registro";
                }
            } else {
                $model->getErrors();
            }
        }
        return $this->render("create", ['model' => $model, 'msg' => $msg]);
    }

    public function actionSaluda($get = "Tutorial Yii") {
        $mensaje = "Hola Mundo";
        $numeros = [0, 1, 2, 3, 4, 5];
        return $this->render("saluda", [
                    "saluda" => $mensaje,
                    "numeros" => $numeros,
                    "get" => $get,
        ]);
    }

    public function actionFormulario($mensaje = null) {
        return $this->render("formulario", ["mensaje" => $mensaje]);
    }

    public function actionRequest() {
        $mensaje = null;
        if (isset($_REQUEST["nombre"])) {
            $mensaje = "Bien, has enviando tu nombre correctamente: " . $_REQUEST["nombre"];
        }
        $this->redirect(["site/formulario", "mensaje" => $mensaje]);
    }

    public function actionValidarformulario() {

        $model = new ValidarFormulario;

        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                //Por ejemplo, consultar en una base de datos
            } else {
                $model->getErrors();
            }
        }

        return $this->render("validarformulario", ["model" => $model]);
    }

    public function actionValidarformularioajax() {
        $model = new ValidarFormularioAjax;
        $msg = null;

        if ($model->load(Yii::$app->request->post()) && Yii::$app->request->isAjax) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
        }

        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                //Por ejemplo hacer una consulta a una base de datos
                $msg = "Enhorabuena formulario enviado correctamente";
                $model->nombre = null;
                $model->email = null;
            } else {
                $model->getErrors();
            }
        }

        return $this->render("validarformularioajax", ['model' => $model, 'msg' => $msg]);
    }

    public function behaviors() {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout', 'user', 'admin'],
                'rules' => [
                    [
                        //El administrador tiene permisos sobre las siguientes acciones
                        'actions' => ['logout', 'admin'],
                        //Esta propiedad establece que tiene permisos
                        'allow' => true,
                        //Usuarios autenticados, el signo ? es para invitados
                        'roles' => ['@'],
                        //Este método nos permite crear un filtro sobre la identidad del usuario
                        //y así establecer si tiene permisos o no
                        'matchCallback' => function ($rule, $action) {
                    //Llamada al método que comprueba si es un administrador
                    return User::isUserAdmin(Yii::$app->user->identity->id);
                },
                    ],
                    [
                        //Los usuarios simples tienen permisos sobre las siguientes acciones
                        'actions' => ['logout', 'user'],
                        //Esta propiedad establece que tiene permisos
                        'allow' => true,
                        //Usuarios autenticados, el signo ? es para invitados
                        'roles' => ['@'],
                        //Este método nos permite crear un filtro sobre la identidad del usuario
                        //y así establecer si tiene permisos o no
                        'matchCallback' => function ($rule, $action) {
                    //Llamada al método que comprueba si es un usuario simple
                    return User::isUserSimple(Yii::$app->user->identity->id);
                },
                    ],
                ],
            ],
            //Controla el modo en que se accede a las acciones, en este ejemplo a la acción logout
            //sólo se puede acceder a través del método post
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    public function actions() {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    public function actionIndex() {
        return $this->render('index');
    }

    public function actionLogin() {
        if (!\Yii::$app->user->isGuest) {

            if (User::isUserAdmin(Yii::$app->user->identity->id)) {
                return $this->redirect(["site/admin"]);
            } else {
                return $this->redirect(["site/user"]);
            }
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {

            if (User::isUserAdmin(Yii::$app->user->identity->id)) {
                return $this->redirect(["site/admin"]);
            } else {
                return $this->redirect(["site/user"]);
            }
        } else {
            return $this->render('login', [
                        'model' => $model,
            ]);
        }
    }

    public function actionLogout() {
        Yii::$app->user->logout();

        return $this->goHome();
    }

    public function actionContacto() {
        $model = new ContactoForm();
        if ($model->load(Yii::$app->request->post()) && $model->contact(Yii::$app->params['adminEmail'])) {
            Yii::$app->session->setFlash('contactFormSubmitted');

            return $this->refresh();
        } else {
            return $this->render('contacto', [
                        'model' => $model,
            ]);
        }
    }

    public function actionAbout() {
        return $this->render('about');
    }

    public function actionUser() {
        return $this->render('user');
    }

    public function actionAdmin() {
        return $this->render('admin');
    }


    public function actionConvocatoria() {
        return $this->render('convocatoria');
    }

    public function actionActos() {
        return $this->render('actos');
    }

    public function actionConcursos() {
        return $this->render('concursos');
    }

    public function actionOposiciones() {
        return $this->render('oposiciones');
    }

    public function actionConversion() {
        return $this->render('conversion');
    }

}
