<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class Store extends Model{
    protected $table    = 'store';
    protected $fillable = [
        'pro_id',
        'total',
        'created_at',
        'updated_at'
    ];
    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
}