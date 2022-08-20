<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class Debt extends Model{
    protected $table    = 'debts';

    public function product()
    {
        return $this->belongsTo(Product::class, 'pro_id', 'id');
    }
}