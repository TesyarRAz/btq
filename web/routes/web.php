<?php

use App\Http\Controllers\OAuth\GoogleAuthController;
use App\Models\User;
use Illuminate\Support\Facades\Route;
use Laravel\Socialite\Facades\Socialite;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('social/google/redirect', [GoogleAuthController::class, 'redirect']);
Route::get('social/google/callback', [GoogleAuthController::class, 'callback']);
Route::post('social/google/login', [GoogleAuthController::class, 'login']);