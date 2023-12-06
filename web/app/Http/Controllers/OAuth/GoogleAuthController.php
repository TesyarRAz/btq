<?php

namespace App\Http\Controllers\OAuth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Laravel\Socialite\Facades\Socialite;

class GoogleAuthController extends Controller
{
    public function redirect(Request $request)
    {
        return Socialite::driver('google')->redirect();
    }

    public function callback()
    {
        $providerUser = Socialite::driver('google')->user();

        $user = User::updateOrCreate([
            'provider_name' => 'google',
            'provider_id' => $providerUser->id,
        ], [
            'name' => $providerUser->name,
            'email' => $providerUser->email,
            'password' => 'undefined',
            'email_verified_at' => now(),
            'role' => 'user',
        ]);

        return response()->json([
            'status' => 'success',
            'user' => $user,
        ]);
    }

    public function login(Request $request)
    {
        $request->validate([
            'access_token' => 'required',
        ]);

        $token = $request->input('access_token');

        $providerUser = Socialite::driver('google')->userFromToken($token);
 
        $user = User::updateOrCreate([
            'provider_name' => 'google',
            'provider_id' => $providerUser->id,
        ], [
            'name' => $providerUser->name,
            'email' => $providerUser->email,
            'password' => 'undefined',
            'email_verified_at' => now(),
            'role' => 'user',
        ]);

        $token = $user->createToken('google_token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'token' => $token,
        ]);
    }
}
