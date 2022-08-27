<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\TypeBrand;

class Debt extends Model{
    protected $table    = 'debts';
    protected $fillable = [
        'pro_id',
        'total',
        'price',
        'report_date',
        'created_by',
        'brand_id',
        'created_at',
        'updated_at'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }

    public function brand()
    {
        return $this->belongsTo(TypeBrand::class, 'brand_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'created_by', 'id');
    }
}