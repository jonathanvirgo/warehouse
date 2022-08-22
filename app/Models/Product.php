<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\TypeProduct;

class Product extends Model{
    protected $table    = 'products';

    protected $fillable = [
        'name',
        'total',
        'price_import',
        'price_export',
        'type_id',
        'created_at',
        'updated_at'
    ];

    public function type()
    {
        return $this->belongsTo(TypeProduct::class, 'type_id', 'id');
    }
}