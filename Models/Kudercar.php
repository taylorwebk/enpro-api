<?php
namespace Models;
use Illuminate\Database\Eloquent\Model as Model;

class Kudercar extends Model
{
  protected $guarded = array();
  protected $table = 'kudercar';
  public $timestamps = false;
  public function estudiantes()
  {
    return $this->belongsToMany('Models\Estudiante');
  }
}
