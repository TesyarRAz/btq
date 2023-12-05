<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Menu;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    public function index()
    {
        $data = Menu::with('menu_items')->get();

        return response()->json([
            'status' => 'success',
            'data' => $data,
        ]);
    }
}
