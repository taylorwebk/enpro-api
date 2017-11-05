<?php
namespace Models;
use Illuminate\Database\Eloquent\Model as Model;

class Kuder extends Model
{
  protected $guarded = array();
  protected $table = 'kuder';
  public $timestamps = false;
}
