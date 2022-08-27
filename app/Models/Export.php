<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class Export extends Model{
    protected $table    = 'exports';

    protected $fillable = [
        'pro_id',
        'total',
        'price_import',
        'price_export',
        'report_date',
        'income',
        'discount',
        'note',
        'created_by',
        'brand_id',
        'warehouse_id',
        'type_discount',
        'ship',
        'created_at',
        'updated_at'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class, 'brand_id', 'id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id', 'id');
    }
}