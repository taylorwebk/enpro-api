<?php
namespace Models;
use Illuminate\Database\Eloquent\Model as Model;

class Aptitudeschaside extends Model
{
  protected $guarded = array();
  protected $table = 'aptitudeschaside';
  public $timestamps = false;
  public function estudiante()
  {
    return $this->hasMany('Models\Estudiante');
  }

}
