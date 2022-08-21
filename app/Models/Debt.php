<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class Debt extends Model{
    protected $table    = 'debts';
    protected $fillable = [
        'pro_id',
        'total',
        'price',
        'report_date',
        'created_by',
        'created_at',
        'updated_at'
    ];
    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
}