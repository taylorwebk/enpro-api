<?php
namespace Models;
class R
{

  public static function error($mensaje)
  {
    $data['status'] = 'error';
    $data['content'] = $mensaje;
    return $data;
  }
  public static function errorData($dat)
  {
    $data['status'] = 'error';
    $data['content'] = 'No se reconocen los campos: '.implode('|', $dat);
    return $data;
  }
  public static function success($content)
  {
    $data['status'] = "success";
    $data['content'] = $content;
    return $data;
  }
  public static function warning($mensaje)
  {
    $data['status'] = "warning";
    $data['content'] = $mensaje;
    return $data;
  }
  public static function simpleToken($status, $content, $token)
  {
    return array('status' => $status, 'content' => $content, 'token' => $token);
  }
  public static function validateData($data, $fields)
  {
    foreach ($fields as $value) {
      if (! isset($data[$value])) {
        return false;
      }
    }
    return true;
  }
}
