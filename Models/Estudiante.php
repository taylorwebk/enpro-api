<?php
namespace Models;
use Illuminate\Database\Eloquent\Model as Model;
/**
 *
 */
class Estudiante extends Model
{
  protected $guarded = array();
  protected $table = 'estudiante';
  public $timestamps = false;
  public function intereseschaside()
  {
    return $this->belongsTo('Models\Intereseschaside');
  }
  public function aptitudeschaside()
  {
    return $this->belongsTo('Models\Aptitudeschaside');
  }
  public function kudercar()
  {
    return $this->belongsToMany('Models\Kudercar');
  }
  public function kuderdesc()
  {
    return $this->belongsToMany('Models\Kuderdesc')->withPivot('percentil');
  }
  //
  // public function estudiantes()
  // {
  //   return $this->belongsToMany('Models\Estudiante');
  // }
  // public function materia()
  // {
  //   return $this->belongsTo('Models\Materia');
  // }
  // public function docente()
  // {
  //   return $this->belongsTo('Models\Docente');
  // }
  // public function listas()
  // {
  //   return $this->hasMany('Models\Lista');
  // }

}
