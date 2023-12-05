<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Menu;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    public function index()
    {
        $data = Menu::with([
            'menu_items' => fn($query) => $query->when(auth()->check(), fn($query) => $query
                ->withExists([
                    'favorite_users as is_favorite' => fn($query) => $query->where('user_id', auth()->id()),
                ])
            ),
        ])->get();

        return response()->json([
            'status' => 'success',
            'data' => $data,
        ]);
    }

    
    public function favorites()
    {
        $data = auth()->user()->favorite_menu_items()->with('menu.menu_items')->get();

        return response()->json([
            'status' => 'success',
            'data' => $data,
        ]);
    }
}
