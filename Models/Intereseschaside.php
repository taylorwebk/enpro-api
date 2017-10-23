<?php
namespace Models;
use Illuminate\Database\Eloquent\Model as Model;

class Intereseschaside extends Model
{
  protected $guarded = array();
  protected $table = 'intereseschaside';
  public $timestamps = false;
  public function estudiante()
  {
    return $this->hasMany('Models\Estudiante');
  }

}
