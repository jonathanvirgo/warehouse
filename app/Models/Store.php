<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class Store extends Model{
    protected $table    = 'store';

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
}