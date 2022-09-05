<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Brand;

class Product extends Model{
    protected $table    = 'products';

    protected $fillable = [
        'name',
        'brand_id',
        'campain_id',
        'created_at',
        'updated_at'
    ];

    public function brand()
    {
        return $this->belongsTo(Brand::class, 'brand_id', 'id');
    }
}