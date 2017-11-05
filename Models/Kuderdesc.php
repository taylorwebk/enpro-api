<?php
namespace Models;
use Illuminate\Database\Eloquent\Model as Model;

class Kuderdesc extends Model
{
  protected $guarded = array();
  protected $table = 'kuderdesc';
  public $timestamps = false;
  public function estudiantes()
  {
    return $this->belongsToMany('Models\Estudiante');
  }
}
