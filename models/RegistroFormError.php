<?php

namespace app\models;

use Yii;
use yii\base\Model;
use app\models\Users;

class RegistroForm extends Model {

    public $username = 'interinosModel';
    public $dni = '01234567';
    public $email = 'javieriranzo3@gmail.com';
    public $password = 'interinos';
    public $password_repeat = 'interinos';
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
            ['dni','match', 'pattern' => "/^[0-9a-z]+$/i", 'message' => 'Sólo se aceptan letras y números'],
            ['dni', 'match', 'pattern' => "/^.{9,00}$/", 'message' => 'Mínimo 9 y máximo 10 caracteres'],
            ['username', 'username_existe'],
            ['email', 'match', 'pattern' => "/^.{5,80}$/", 'message' => 'Mínimo 5 y máximo 80 caracteres'],
            ['email', 'email', 'message' => 'Formato no válido'],
            ['email', 'email_existe'],
            ['password', 'match', 'pattern' => "/^.{6,16}$/", 'message' => 'Mínimo 6 y máximo 16 caracteres'],
            ['password_repeat', 'compare', 'compareAttribute' => 'password', 'message' => 'Los passwords no coinciden'],
            ['interinos', 'boolean'],
            ['actos', 'prueba'],
            ['concursos', 'boolean'],
            ['oposiciones', 'boolean'],
        ];
    }

    public function email_existe($attribute, $params) {

        //Buscar el email en la tabla
        $table = Users::find()->where("email=:email", [":email" => $this->email]);

        //Si el email existe mostrar el error
        if ($table->count() == 1) {
            $this->addError($attribute, "El email seleccionado existe");
        }
    }

    public function username_existe($attribute, $params) {
        //Buscar el username en la tabla
        $table = Users::find()->where("username=:username", [":username" => $this->username]);

        //Si el username existe mostrar el error
        if ($table->count() == 1) {
            $this->addError($attribute, "El usuario seleccionado existe");
        }
    }

    public function validar_dni($attribute, $params) {
    $letra = substr($this->dni, -1);
    $numeros = substr($thid->dni, 0, -1);
    if ( substr("TRWAGMYFPDXBNJZSQVHLCKE", $numeros%23, 1) == $letra && strlen($letra) == 1 && strlen ($numeros) == 8 ){
        echo 'valido';
    }else{
        //echo 'no valido';
         $this->addError($attribute, "El dni no es válido");
    }
}

    public function prueba() {
        if ($this->interinos == 0 && $this->actos == 0 && $this->concursos == 0 && $this->oposiciones == 0) {
            $this->addError('interinos', 'Debe indicar al menos un tema de interes!');
            $this->addError('actos', 'Debe indicar al menos un tema de interes!');
            $this->addError('concursos', 'Debe indicar al menos un tema de interes!');
            $this->addError('oposiciones', 'Debe indicar al menos un tema de interes!');
        }
    }

    /**
     * @return array customized attribute labels
     */
    public function attributeLabels() {
        return [
            'username' => 'Nombre',
            'dni' => 'Dni',
            'email' => 'Correo electrónico',
            'password' => 'Contraseña',
            'password_repeat' => 'Repite la contraseña',
        ];
    }

}
