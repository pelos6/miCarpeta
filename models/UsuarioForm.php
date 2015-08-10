<?php

namespace app\models;
use Yii;
use yii\base\model;

class UsuarioForm extends model{

public $id;
public $username;
public $email;
public $role;
public $interinos;
public $actos;
public $concursos;
public $oposiciones;

/*    public $id;
    public $dni;
    public $username;
    public $email;
    public $password;
    public $authKey;
    public $accessToken;
    public $activate;
    public $verification_code;
    public $role;
    public $interinos;
    public $actos;
    public $concursos;
    public $oposiciones;
    public $contraseña;*/

public function rules()
 {
  return [
   ['id', 'integer', 'message' => 'Id incorrecto'],
   ['username', 'required', 'message' => 'Campo requerido'],
/*   ['username', 'match', 'pattern' => '/^[a-záéíóúñ\s]+$/i', 'message' => 'Sólo se aceptan letras'],
   ['username', 'match', 'pattern' => '/^.{3,50}$/', 'message' => 'Mínimo 3 máximo 50 caracteres'],*/
   ['username', 'match', 'pattern' => "/^.{6,50}$/", 'message' => 'Mínimo 6 y máximo 50 caracteres'],
   ['username', 'match', 'pattern' => "/^[0-9a-z]+$/i", 'message' => 'Sólo se aceptan letras y números'],
   ['email','email'],
   ['email','required'],
   ['interinos','boolean'],
   ['actos', 'prueba'],
   ['concursos','boolean'],
   ['oposiciones','boolean'],
      
//   ['apellidos', 'required', 'message' => 'Campo requerido'],
//   ['apellidos', 'match', 'pattern' => '/^[a-záéíóúñ\s]+$/i', 'message' => 'Sólo se aceptan letras'],
//   ['apellidos', 'match', 'pattern' => '/^.{3,80}$/', 'message' => 'Mínimo 3 máximo 80 caracteres'],
//   ['clase', 'required', 'message' => 'Campo requerido'],
//   ['clase', 'integer', 'message' => 'Sólo números enteros'],
//   ['nota_final', 'required', 'message' => 'Campo requerido'],
//   ['nota_final', 'number', 'message' => 'Sólo números'],
  ];
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
            //'dni' => 'Dni: formato 00000001R',
            'email' => 'Correo electrónico',
            'password' => 'Contraseña',
            'password_repeat' => 'Repite la contraseña',
        ];
    }
}