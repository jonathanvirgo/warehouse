<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\TypeBrand;
use App\Models\User;

class Pay extends Model{
    protected $table    = 'pay';
    protected $fillable = [
        'pro_id',
        'total',
        'price',
        'report_date',
        'note',
        'created_by',
        'warehouse_id',
        'brand_id',
        'created_at',
        'updated_at'
    ];
    
    public function user()
    {
        return $this->belongsTo(User::class, 'created_by', 'id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }

    public function brand()
    {
        return $this->belongsTo(TypeBrand::class, 'brand_id', 'id');
    }
    
    public function warehouse()
    {
        return $this->belongsTo(TypeWarehouse::class, 'warehouse_id', 'id');
    }
}