<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\TypeBrand;

class Product extends Model{
    protected $table    = 'products';

    protected $fillable = [
        'name',
        'total',
        'price_import',
        'price_export',
        'brand_id',
        'created_at',
        'updated_at'
    ];

    public function brand()
    {
        return $this->belongsTo(TypeBrand::class, 'brand_id', 'id');
    }
}