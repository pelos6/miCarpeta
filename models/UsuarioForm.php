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

public function rules()
 {
  return [
   ['id', 'integer', 'message' => 'Id incorrecto'],
   ['username', 'required', 'message' => 'Campo requerido'],
   ['username', 'match', 'pattern' => '/^[a-záéíóúñ\s]+$/i', 'message' => 'Sólo se aceptan letras'],
   ['username', 'match', 'pattern' => '/^.{3,50}$/', 'message' => 'Mínimo 3 máximo 50 caracteres'],
   ['email','email'],
   ['email','required'],
   ['role','required'],
   ['interinos','boolean'],
   ['actos','boolean'],
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
 
}