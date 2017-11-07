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
  public static function postAnswersKuder($data)
  {
    $fields = ['username', 'si', 'no'];
    if (R::validateData($data, $fields)) {
      if (gettype($data['si']) == 'array' && gettype($data['no']) == 'array') {
        $est = Estudiante::where('username', $data['username'])->first();
        if ($est) {
          $si = [
              '0' => [2,3,9,11,17,18,24,43,45,47,50,53,54,57,59,90,92,95,96,
                      97,99,131,144,159,180,185,186,222,223,226,227,254,256,
                      257,263,297,314,315,341,380,393,398,399,422,423,426,427,
                      432,468,470,473,475,482],
            '1' => [30,33,36,40,167,198,203,208,233,235,238,244,248,250,276,
                    285,287,294,335,327,319,374,367,361,419,410,408,405,460,
                    457,449,492,499,502],
            '2' => [5,171,172,175,218,253,240,239,232,275,295,301,318,320,323,327,
                    340,344,362,365,369,385,404,411,436,450,464,481,490],
            '3' => [21,28,35,59,63,77,79,83,100,104,110,114,119,123,124,125,
                    146,152,160,163,167,186,187,194,201,204,207,225,228,230,
                    271,289,290,293,373,374,376,501],
            '4' => [6,22,29,51,68,71,73,87,127,133,142,151,155,158,169,173,
                    179,184,189,197,200,217,219,234,236,238,261,269,270,284,
                    298,302,306,308,338,339,342,345,347,382,384,386,429,430,
                    465,471],
            '5' => [34,39,42,76,162,166,292,268,272,317,322,332,354,356,357,
                    366,375,394,441,480,488,494,500,75,157,199,283],
            '6' => [13,85,102,134,138,139,145,176,213,231,269,273,340,346,
                    353,357,388,395,431,440,479],
            '7' => [23,41,81,84,122,195,197,237,247,331,377,416,445,453,495],
            '8' => [4,61,67,101,106,111,113,119,147,153,161,174,178,196,206,
                    236,242,249,255,259,271,290,291,295,316,321,337,343,348,
                    352,356,376,401,407,417,420,447,456,489,503],
            '9' => [27,60,72,80,86,108,109,120,126,135,137,143,151,156,164,
                    175,190,202,204,212,232,241,246,253,260,266,278,280,296,
                    298,300,304,339,355,363,368,369,378,389,390,406,413,415,
                    438,446,449,450,454,461,463,464,469,477,478,481,483,486,
                    504],
            'v' => [1,2,7,9,64,66,98,99,116,117,149,150,182,183,205,207,216,
                    280,282,312,328,349,358,359,372,379,380,424,426,434,435,
                    443,444,457,459,469,470,484,486,496]
          ];
          $no = [
            '0' => [1,7,8,10,12,16,22,23,44,46,48,49,51,52,55,56,58,60,88,89,
                    91,93,94,98,130,132,142,143,157,158,178,179,184,220,221,
                    224,225,253,255,258,262,264,295,296,313,340,342,379,381,
                    391,392,397,421,424,425,428,429,430,431,466,467,469,471,
                    472,474,476,477,481,483],
            '1' => [28,29,31,32,34,35,41,42,168,166,196,197,210,209,204,202,232,
                    234,236,234,239,240,245,246,247,249,251,252,274,275,283,
                    284,286,288,292,293,320,321,325,326,334,336,362,363,368,
                    369,373,375,403,404,406,407,409,411,418,420,448,450,458,
                    459,461,462,504,503,501,500,491,490],
            '2' => [4,6,169,170,173,174,176,177,217,219,238,234,233,255,254,
                    274,276,296,297,302,303,316,317,319,321,322,324,325,326,
                    341,342,343,345,361,363,364,366,367,368,386,387,403,405,
                    409,410,437,438,448,449,463,465,482,483,491,492],
            '3' => [19,20,29,30,34,36,58,60,61,62,76,78,80,81,82,84,101,102,
                    103,105,109,111,112,113,118,120,121,122,126,145,147,151,
                    153,161,162,164,165,166,168,184,185,188,189,193,195,199,
                    200,202,203,205,206,223,224,226,227,229,231,272,273,291,
                    292,294,375,377,378,499,500],
            '4' => [4,5,23,24,28,30,49,50,67,69,70,72,74,75,85,86,128,129,134,
                    135,143,144,152,153,154,156,157,159,170,171,172,174,178,
                    180,185,186,187,188,196,198,199,201,218,232,233,235,237,
                    239,240,259,260,268,283,285,299,300,301,303,304,305,307,
                    309,337,340,341,343,344,346,348,383,385,389,427,428,431,
                    432,463,464,469,470],
            '5' => [35,36,37,38,40,41,77,78,160,161,167,168,269,270,271,273,
                    294,293,316,318,323,324,331,333,352,353,355,364,365,395,
                    396,439,440,478,479,487,489,493,495,499,501,73,74,158,159,
                    200,201,284,285],
            '6' => [14,15,86,87,100,101,133,135,136,137,140,141,146,147,175,
                    177,211,212,229,230,268,270,271,272,341,342,347,348,352,
                    354,355,356,389,390,394,396,430,432,439,441,478,480],
            '7' => [22,24,40,42,79,80,82,83,121,123,193,194,196,198,235,236,
                    248,249,332,333,378,376,415,417,446,447,451,452,493,494],
            '8' => [5,6,62,63,68,69,100,102,107,108,109,110,112,114,118,120,
                    145,146,151,152,160,162,172,173,175,176,179,180,197,198,
                    206,207,235,237,241,243,247,248,253,254,260,261,272,273,
                    289,296,297,317,318,319,320,338,339,344,345,346,347,353,
                    354,355,357,378,377,400,402,406,408,415,416,418,419,445,
                    446,454,455,487,488,502,504],
            '9' => [25,26,58,59,70,71,79,81,85,87,106,107,110,111,118,119,124,
                    125,133,134,136,138,142,144,152,153,154,155,163,165,175,
                    177,191,192,203,211,213,233,234,242,243,244,245,254,255,
                    259,261,265,267,277,279,281,282,295,297,299,305,306,337,
                    338,356,357,361,362,367,376,377,388,407,408,412,414,416,
                    417,436,437,445,447,448,455,456,460,462,465,470,471,475,
                    476,479,480,482,484,485,502,503],
            'v' => [1,3,8,9,65,97,98,115,148,179,180,181,214,215,256,258,310,
                    311,329,330,350,351,360,370,371,425,426,433,435,442,457,458,485,497,498]
          ];
          $points = [];
          for ($i=0; $i < 10; $i++) {
            $points[$i] = count(
              array_merge(
                array_values(array_intersect($si[$i], $data['si'])),
                array_values(array_intersect($no[$i], $data['no']))
              )
            );
          }
          $percentil = self::generatePercentil($points, $est->sexo);
          $final = self::getIndex($percentil);
          // return $final;
          foreach ($final as $key => $val) {
            $est->kuderdesc()->attach($key + 1, ['percentil' => $val]);
            $est->kudercar()->attach($key + 1);
          }
          $verification = count(
            array_merge(
              array_values(array_intersect($si['v'], $data['si'])),
              array_values(array_intersect($no['v'], $data['no']))
            )
          );
          return R::success('Felicidades, finalizó el test Kuder, puede ver los resultados en su pérfil.', $verification);
        } else {
          return R::error('No existe el estudiante con username: '.$data['username']);
        }
      } else {
        return R::error('El campo si y no deben ser del tipo array, se obtuvo: '.gettype($data['si']).' y '.gettype($data['no']));
      }
    } else {
      return R::errorData($fields);
    }

  }
  public static function postAnswersChaside($data)
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
  private static function generatePercentil($data, $sexo)
  {
    if ($sexo || true) {
      // hombre
      $escala = [
        [0,0,0,0,0,0,0,0,0,0,1,1,1,2,2,2,3,3,3,5,5,6,6,7,8,9,10,11,14,15,16,19,20,21,24,25,27,31,33,35,37,40,42,47,48,50,55,52,53,62,64,65,70,71,72,76,77,79,83,84,85,87,88,89,90,91,92,93,94,95,95,96,97,97,97,98,98,98,99,99,99,99,99,99,99,99,100,100,100,100],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,2,2,2,3,4,5,6,6,5,10,10,10,15,15,15,24,24,24,32,33,35,40,40,42,43,45,47,63,65,67,74,75,77,81,82,84,88,89,91,92,93,95,95,96,96,93,93,99,99,99,99,99,99,99],
        [0,0,0,0,0,0,1,1,2,2,2,4,4,5,7,8,8,12,14,14,19,20,21,30,30,32,40,43,44,53,54,55,64,65,67,74,77,79,83,86,89,90,92,94,95,95,96,98,98,98,99,99,100,100,100,100,100,100],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 , 0, 1, 1, 1, 1, 2, 4, 4, 5, 5, 5, 7, 8, 9,12,14,15,19,21,26,26,27,28,34,35,37,45,47,48,55,56,58,60,61,68,74,77,78,83,84,85,89,90,91,91,92,93,95,96,97,97,97,97],
        [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,2,3, 3, 4, 5, 5, 4, 8,10,14,15,16,21,22,22,30,31,32,42,45,47,54,55,57,65,66,68,76,78,80,83,85,88,89,90,92,93,95,96,97,97,98,99,99,99,99,99,99,99,100,100,100,100,100,100,100,100,100,100,100,100],
        [0,0,0,0,1,1,1,2,3,9,9,8,8,8,12,13,19,20,20,21,32,33,34,43,44,46,56,57,58,65,69,72,77,80,81,85,87,90,91,93,94,95,97,97,97,99,99,99,99,99,100,100,100,100,100,100,100,100],
        [0,0,1,1,2,2,4,5,5,10,10,10,19,19,20,30,32,34,45,48,45,62,65,68,76,78,82,86,88,91,92,94,97,97,98,98,99,99,100,100,100,100,100],
        [1,2,10,11,13,16,17,18,21,32,45,62,68,74,82,83,86,87,89,89,90,92,94,96,97,98,99,99,99,99,100,100,100,100,100,100],
        [0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,2,2,3,3,3,4,4, 5, 8, 8, 9,12,13,13,16,16,17,22,24,25,38,40,40,42,44,46,48,50,52,55,58,60,65,67,70,74,76,77,83,84,85,88,59,90,91,92,94,95,96,96,97,98,98,98,98,99,99,99,100,100,100,100],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,2,2,2,3,3,3,4,6,6,7,8,9, 9,11,12,13,18,18,19,24,25,27,30,31,33,37,38,40,45,46,47,53,55,57,63,64,65,70,73,74,77,78,80,83,84,85,87,88,90,91,92,93,94,95,96,96,97,98,98,98,98,99,99,99,99,99,99,99,99,99,100,100,100,100,100]
      ];
      $percent = [];
      for ($j=0; $j < 10; $j++) {
        $percent[$j] = $escala[$j][$data[$j]];
      }
      return $percent;
    } else {
      // mujer
      // [0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95],
    }
  }
  private static function getIndex($data)
  {
    $newdata = array_filter($data, function ($val)
    {
      return $val >= 75;
    });
    if (count($newdata) <= 2) {
      return $newdata;
    } else {
      asort($newdata, SORT_NUMERIC);
      while (count($newdata) != 2) {
        self::array_shift_assoc_kv($newdata);
      }
      return $newdata;
    }
  }
  private static function array_shift_assoc_kv( &$arr ){
    $val = reset( $arr );
    $key = key( $arr );
    $ret = array( $key => $val );
    unset( $arr[ $key ] );
    return $ret;
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
