<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class Import extends Model{
    protected $table    = 'imports';

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
}