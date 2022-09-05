<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\Warehouse;

class Price extends Model{
    protected $table    = 'price';
    protected $fillable = [
        'pro_id',
        'price',
        'warehouse_id',
        'im_export',
        'campain_id',
        'created_at',
        'updated_at'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id', 'id');
    }
}