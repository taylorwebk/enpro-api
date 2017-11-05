<?php
namespace Controllers;
use \Models\Chaside;
use \Models\Kuder;
use \Models\Estudiante;
use \Models\Admin;
use \Models\Intereseschaside;
use \Models\Aptitudeschaside;
use \Models\R;

class MainController
{
  public static function add($data)
  {
    $fields = ['nombres', 'apellidos', 'colegio', 'fnac', 'sexo'];
    if (R::validateData($data, $fields)) {
      if (preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $data['fnac'])) {
        if ($data['sexo'] == 1 || $data['sexo'] == 0) {
          $username = self::generateUsername($data['nombres'], $data['apellidos']);
          Estudiante::create([
            'id' => null,
            'nombres' => $data['nombres'],
            'apellidos' => $data['apellidos'],
            'colegio' => $data['colegio'],
            'fnac' => $data['fnac'],
            'username' => $username,
            'sexo' => $data['sexo']
          ]);
          return R::success('Se creo el usuario.', $username);
        } else {
          return R::error('El campo sexo solo puede ser 1 o 0, se obtuvo: '.$data['sexo']);
        }

      } else {
        return R::error('El formato de fecha debe ser: YYYY-MM-DD (ej. 2015-02-22), usted ingreso: '.$data['fnac']);
      }
    } else {
      return R::errorData($fields);
    }
  }
  public static function getKuder($data)
  {
    if (R::validateData($data, ['username'])) {
      $status = Admin::orderBy('id', 'desc')->first();
      $est = Estudiante::where('username', $data['username'])->first();
      if ($est) {
        if (count($est->kuderdesc)) {
          return R::warning('Usted ya hizo el test Kuder');
        } else {
          if ($status->kuder) {
            return R::success('Preguntas Obtenidas', Kuder::all());
          } else {
            return R::warning('El test KUDER aún no fue habilitado.');
          }
        }
      } else {
        return R::warning('No existe el estudiante con username: '.$data['username']);
      }
    } else {
      return R::error('No se reconoce el campo username');
    }

  }
  public static function getChaside($data)
  {
    if (R::validateData($data, ['username'])) {
      $status = Admin::orderBy('id', 'desc')->first();
      $est = Estudiante::where('username', $data['username'])->first();
      // return $est->intereseschaside_id;
      if ($est) {
        if (!$est->intereseschaside_id) {
          if ($status->chaside) {
            return R::success('Preguntas obtenidas.', Chaside::all());
          } else {
            return R::warning('El test CHASIDE aún no ha sido habilitado.');
          }
        } else {
          return R::warning('Usted ya realizó el test CHASIDE');
        }
      } else {
        return R::warning('No existe el estudiante con username: '.$data['username']);
      }

    } else {
      return R::error('No se reconoce el campo: username');
    }
  }
  public static function login($data)
  {
    if (R::validateData($data, ['username'])) {
      $est = Estudiante::with(['intereseschaside', 'aptitudeschaside', 'kuderdesc', 'kudercar'])->where('username', $data['username'])->first();
      if ($est) {
        return R::success('Estudiante registrado', $est);
      } else {
        return R::warning('No existe el estudiante con username: '.$data['username']);
      }
    } else {
      R::error('No se reconoce el campo: username');
    }
  }
  public static function postAnswers($data)
  {
    $fields = ['username', 'respuestas'];
    if (R::validateData($data, $fields)) {
      if (gettype($data['respuestas']) == 'array') {
        $est = Estudiante::where('username', $data['username'])->first();
        if ($est) {
          $resChaInt = [
            'C' => [98, 12, 64, 53, 85, 1, 78, 20, 71, 91],
            'H' => [9, 34, 80, 25, 95, 67, 41, 74, 56, 89],
            'A' => [21, 45, 96, 57, 28, 11, 5, 3, 81, 36],
            'S' => [33, 92, 70, 8, 87, 62, 23, 44, 16, 52],
            'I' => [75, 6, 19, 38, 60, 27, 83, 54, 47, 97],
            'D' => [84, 31, 48, 73, 5, 65, 14, 37, 58, 24],
            'E' => [77, 42, 88, 17, 93, 32, 68, 49, 35, 61]
          ];
          $resChaApt = [
            'C' => [ 15, 51, 2, 46],
            'H' => [ 63, 30, 72, 86],
            'A' => [ 22, 39, 76, 82],
            'S' => [ 69, 40, 29, 4],
            'I' => [ 26, 59, 90, 10],
            'D' => [ 13, 66, 18, 43],
            'E' => [ 94, 7, 79, 55]
          ];
          $estChaInt = [
            'C' => array_intersect($resChaInt['C'], $data['respuestas']),
            'H' => array_intersect($resChaInt['H'], $data['respuestas']),
            'A' => array_intersect($resChaInt['A'], $data['respuestas']),
            'S' => array_intersect($resChaInt['S'], $data['respuestas']),
            'I' => array_intersect($resChaInt['I'], $data['respuestas']),
            'D' => array_intersect($resChaInt['D'], $data['respuestas']),
            'E' => array_intersect($resChaInt['E'], $data['respuestas'])
          ];
          $estChaApt = [
            'C' => array_intersect($resChaApt['C'], $data['respuestas']),
            'H' => array_intersect($resChaApt['H'], $data['respuestas']),
            'A' => array_intersect($resChaApt['A'], $data['respuestas']),
            'S' => array_intersect($resChaApt['S'], $data['respuestas']),
            'I' => array_intersect($resChaApt['I'], $data['respuestas']),
            'D' => array_intersect($resChaApt['D'], $data['respuestas']),
            'E' => array_intersect($resChaApt['E'], $data['respuestas'])
          ];
          $keyInt = array_search(max($estChaInt), $estChaInt);
          $keyApt = array_search(max($estChaApt), $estChaApt);
          $interes = Intereseschaside::where('letra', $keyInt)->first();
          $aptitud = Aptitudeschaside::where('letra', $keyApt)->first();
          $est->intereseschaside_id = $interes->id;
          $est->aptitudeschaside_id = $aptitud->id;
          $est->save();
          return R::success('Felicidades...!! finalizaste el test, puedes ver tus resultados en tu perfil', null);
        } else {
          return R::error('No existe el estudiante con username: '.$data['username']);
        }
      } else {
        return R::error('El campo respuestas debe ser un array, acaba de enviar: '.gettype($data['respuestas']));
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
