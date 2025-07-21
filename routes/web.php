<?php

use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\SupportController;
use App\Http\Controllers\TicketController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserRoleController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('welcome');
})->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', function () {
        return Inertia::render('dashboard');
    })->name('dashboard');
    Route::resource('customers', CustomerController::class);
    Route::resource('supports', SupportController::class);
    Route::resource('tickets', TicketController::class);
});

Route::middleware(['auth', 'verified', 'role:admin'])->group(function (){
    //roles
    Route::get('/roles', [RoleController::class, 'index'])->name('roles.index');
    Route::get('/roles/{role}/edit', [RoleController::class, 'edit'])->name('roles.edit');
    Route::put('/roles/{role}', [RoleController::class, 'update'])->name('roles.update');
    Route::get('/roles/create', [RoleController::class, 'create'])->name('roles.create');
    Route::post('/roles', [RoleController::class, 'store'])->name('roles.store');

    //permisos
    Route::get('/users/roles', [UserRoleController::class, 'index'])->name('users.roles.index');
    Route::put('/users/roles', [UserRoleController::class, 'update'])->name('users.roles.update');

    Route::resource('users', UserController::class);

    // Registro habilitado solo para admin
    Route::get('/register', [RegisteredUserController::class, 'create'])->name('register');
    Route::post('/register', [RegisteredUserController::class, 'store']);
});


require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
