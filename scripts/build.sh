#!/bin/bash

echo "🚀 Iniciando proceso de build para Coolify..."

# Instalar dependencias de PHP
echo "📦 Instalando dependencias de PHP..."
composer install --no-dev --optimize-autoloader --no-interaction

# Instalar dependencias de Node.js
echo "📦 Instalando dependencias de Node.js..."
npm ci

# Compilar assets para producción
echo "🔨 Compilando assets para producción..."
npm run build

# Limpiar cache si existe
echo "🧹 Limpiando cache..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Generar caches optimizados
echo "⚡ Generando caches optimizados..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "✅ Build completado exitosamente!"
