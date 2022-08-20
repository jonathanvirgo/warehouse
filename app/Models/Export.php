<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class Export extends Model{
    protected $table    = 'exports';

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
}