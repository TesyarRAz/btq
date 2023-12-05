<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\MenuItem;
use Illuminate\Http\Request;

class MenuItemController extends Controller
{
    public function favorite(Request $request, MenuItem $menuItem)
    {
        $request->user()->favorite_menu_items()->attach($menuItem);

        return response()->json([
            'status' => 'success',
        ]);
    }

    public function unfavorite(Request $request, MenuItem $menuItem)
    {
        $request->user()->favorite_menu_items()->detach($menuItem);

        return response()->json([
            'status' => 'success',
        ]);
    }
}
