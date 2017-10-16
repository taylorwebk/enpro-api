<?php
namespace Controllers;
use \Models\Chaside;
use \Models\Estudiante;
use \Models\R;

class MainController
{
  public static function add($data)
  {
    $fields = ['nombres', 'apellidos', 'colegio', 'fnac'];
    if (R::validateData($data, $fields)) {
      if (preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $data['fnac'])) {
        $username = self::generateUsername($data['nombres'], $data['apellidos']);
        Estudiante::create([
          'id' => null,
          'nombres' => $data['nombres'],
          'apellidos' => $data['apellidos'],
          'colegio' => $data['colegio'],
          'fnac' => $data['fnac'],
          'username' => $username
        ]);
        return R::success('Se creo el usuario.', $username);
      } else {
        return R::error('El formato de fecha debe ser: YYYY-MM-DD (ej. 2015-02-22), usted ingreso: '.$data['fnac']);
      }
    } else {
      return R::errorData($fields);
    }
  }
  public static function getQuestions ()
  {
    return Chaside::all();
  }
  private static function generateUsername($name, $secname)
  {
    $pos = strpos(trim($name), ' ');
    if($pos){
      $nn = strtolower(substr($name, 0, $pos));
    } else {
      $nn = strtolower($name);
    }
    $nn = $nn.strtolower(substr(trim($secname), 0, 1));
    $num = Estudiante::where('username', 'LIKE', $nn.'%')->count();
    return $nn.$num;
  }
}
