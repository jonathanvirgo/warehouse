<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\TypeProduct;
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
        'type_id',
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

    public function type()
    {
        return $this->belongsTo(TypeProduct::class, 'type_id', 'id');
    }
}