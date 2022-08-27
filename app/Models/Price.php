<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\TypeWarehouse;
use App\Models\TypeExport;

class Price extends Model{
    protected $table    = 'price';
    protected $fillable = [
        'pro_id',
        'price',
        'type_export_id',
        'warehouse_id',
        'is_import',
        'created_at',
        'updated_at'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
    public function warehouse()
    {
        return $this->belongsTo(TypeWarehouse::class, 'warehouse_id', 'id');
    }
    public function typeExport()
    {
        return $this->belongsTo(TypeExport::class, 'type_export_id', 'id');
    }
}