<?php

use App\Http\Controllers\Api\MenuController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::get('/menu', [MenuController::class, 'index']);
Route::middleware('auth:sanctum')->group(function() {
    Route::get('/user', [UserController::class, 'user']);
    Route::get('/menu/favorites', [MenuController::class, 'favorites']);
    Route::post('/menu/{menu_item}/favorite', [MenuController::class, 'favorite']);
    Route::delete('/menu/{menu_item}/favorite', [MenuController::class, 'unfavorite']);
});