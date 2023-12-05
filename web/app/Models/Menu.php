<?php

namespace App\Models;

use App\Casts\PublicFileClientCast;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $casts = [
        'image' => PublicFileClientCast::class,
        'image_content' => PublicFileClientCast::class,
    ];

    public function menu_items()
    {
        return $this->hasMany(MenuItem::class);
    }
}
