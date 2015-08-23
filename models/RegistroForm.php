<?php

namespace app\models;

use Yii;
use yii\base\Model;
use app\models\Users;

class RegistroForm extends Model {

//    public $username = 'usuario1';
//    public $dni = '00000001R';
//    public $email = 'javieriranzo@hotmail.com';
//    public $password = 'usuario1';
//    public $password_repeat = 'usuario1';
    public $username  ;
    public $dni ;
    public $email;
    public $password ;
    public $password_repeat ;
    public $interinos = false;
    public $actos = false;
    public $concursos = false;
    public $oposiciones = false;

    public function rules() {
        return [
            [['username', 'email', 'password', 'password_repeat'], 'required', 'message' => 'Campo requerido'],
            ['username', 'match', 'pattern' => "/^.{6,50}$/", 'message' => 'Mínimo 6 y máximo 50 caracteres'],
            ['username', 'match', 'pattern' => "/^[0-9a-z]+$/i", 'message' => 'Sólo se aceptan letras y números'],
            ['dni', 'required'],
            ['dni', 'validar_dni'],
            ['dni', 'dni_existe'],
            ['dni', 'match', 'pattern' => "/^[0-9a-z]+$/i", 'message' => 'Sólo se aceptan letras y números'],
            ['dni', 'match', 'pattern' => "/^.{9,10}$/", 'message' => 'Mínimo 9 y máximo 10 caracteres'],
            ['username', 'username_existe'],
            ['email', 'match', 'pattern' => "/^.{5,80}$/", 'message' => 'Mínimo 5 y máximo 80 caracteres'],
            ['email', 'email', 'message' => 'Formato no válido'],
            ['email', 'email_existe'],
            ['password', 'match', 'pattern' => "/^.{6,16}$/", 'message' => 'Mínimo 6 y máximo 16 caracteres'],
            ['password_repeat', 'compare', 'compareAttribute' => 'password', 'message' => 'Las contraseñas no coinciden'],
            ['interinos', 'boolean'],
            ['actos', 'prueba'],
            ['concursos', 'boolean'],
            ['oposiciones', 'boolean'],
        ];
    }

    public function validar_dni($attribute, $params) {
        error_log('DEBUG: dni' . $this->dni);

        $letra = substr($this->dni, -1);
        error_log('DEBUG: letra ' . $letra);
        $numeros = substr($this->dni, 0, -1);
        error_log('DEBUG: numeros ' . $numeros);
        if (!( substr("TRWAGMYFPDXBNJZSQVHLCKE", $numeros % 23, 1) == $letra &&
                strlen($letra) == 1 && strlen($numeros) == 8 )) {
            $this->addError($attribute, "El dni no es válido. 8 numeros, 1 letra mayuscula sin ceros por delante ");
        }
    }

    public function email_existe($attribute, $params) {

        //Buscar el email en la tabla
        $table = Users::find()->where("email=:email", [":email" => $this->email]);

        //Si el email existe mostrar el error
        if ($table->count() == 1) {
            $this->addError($attribute, "El email introducido existe");
        }
    }

    public function username_existe($attribute, $params) {
        //Buscar el username en la tabla
        $table = Users::find()->where("username=:username", [":username" => $this->username]);

        //Si el username existe mostrar el error
        if ($table->count() == 1) {
            $this->addError($attribute, "El usuario introducido existe");
        }
    }

    public function dni_existe($attribute, $params) {

        //Buscar el email en la tabla
        $table = Users::find()->where("dni=:dni", [":dni" => $this->dni]);

        //Si el email existe mostrar el error
        if ($table->count() == 1) {
            $this->addError($attribute, "El dni introducido existe");
        }
    }

    public function prueba() {
        if ($this->interinos == 0 && $this->actos == 0 && $this->concursos == 0 && $this->oposiciones == 0) {
            $this->addError('interinos', 'Debe indicar al menos un tema de interes.');
            $this->addError('actos', 'Debe indicar al menos un tema de interes.');
            $this->addError('concursos', 'Debe indicar al menos un tema de interes.');
            $this->addError('oposiciones', 'Debe indicar al menos un tema de interes.');
        }
    }

    /**
     * @return array customized attribute labels
     */
    public function attributeLabels() {
        return [
            'username' => 'Nombre',
            'dni' => 'Dni: formato 00000001R',
            'email' => 'Correo electrónico',
            'password' => 'Contraseña',
            'password_repeat' => 'Repite la contraseña',
        ];
    }

}
