<?php

namespace App\Models;

use App\Casts\PublicFileClientCast;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MenuItem extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $casts = [
        'is_favorite' => 'boolean',
    ];

    public function menu()
    {
        return $this->belongsTo(Menu::class);
    }

    public function favorite_users()
    {
        return $this->belongsToMany(User::class, 'favorite_menu_item')->using(FavoriteMenuItem::class);
    }
}
