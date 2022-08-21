<?php

namespace App\Models;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;

class LogActivity extends Model
{
	protected $table = 'prb_log_activity';
    protected $fillable = [
        'user_id',
        'name',
        'message',
        'url',
        'method',
        'agent',
        'form_data',
        'created_at',
        'updated_at'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
